Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387A4C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 19:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4TI-0006rd-2M; Mon, 05 Feb 2024 14:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX4TC-0006r8-Nx
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX4T9-00017R-W3
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707160646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOHWHR2gglSmbNmNWINDfJfKY40x01aLqEzkJMhJhiI=;
 b=Y9pUweP2ZZNsrVUL4Yawyg1S2Zsk934Y4Q/2tNxhrD2VS+cTtwduCgJFIl1ju5VMxf1tMG
 MZKLKA7uzEkHfDJT7WWEyt4FXvfBIqwyOBZkoXTCr6wYphWkzFoAK8AaNvmSdAStzjxxp+
 wmG0FL9weejk3UV27AEeSOJQdpFR/3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-ujlDXfFEPqSeXJuoxVKokw-1; Mon,
 05 Feb 2024 14:17:23 -0500
X-MC-Unique: ujlDXfFEPqSeXJuoxVKokw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2F9B1C0BA4B;
 Mon,  5 Feb 2024 19:17:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C37492BC6;
 Mon,  5 Feb 2024 19:17:20 +0000 (UTC)
Date: Mon, 5 Feb 2024 19:17:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Samuel Tardieu <sam@rfc1149.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
Message-ID: <ZcE0Phnz-kyLoIq_@redhat.com>
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com> <877cjiaibh.fsf@rfc1149.net>
 <CAJSP0QXt4VtyeqZTY6nJ4fVQrjrjMFS7rHPCxiHkcQL8CD=qFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXt4VtyeqZTY6nJ4fVQrjrjMFS7rHPCxiHkcQL8CD=qFg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 05, 2024 at 02:06:39PM -0500, Stefan Hajnoczi wrote:
> On Mon, 5 Feb 2024 at 13:16, Samuel Tardieu <sam@rfc1149.net> wrote:
> >
> >
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> >
> > > $ gcc -Wall -Wuninitialized -o jump jump.c
> >
> > Note that many GCC warnings don't trigger if you don't enable
> > optimizations. In the case you exhibit, adding -O is enough to get
> > a sensible warning:
> >
> > $ gcc -Wall -O -o jump jump.c
> > jump.c: In function ‘main’:
> > jump.c:11:3: warning: ‘foo’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >    11 |   free(foo);
> >       |   ^~~~~~~~~
> > jump.c:8:9: note: ‘foo’ was declared here
> >     8 |   char *foo = malloc(30);
> >       |         ^~~
> 
> llvm also prints a warning:
> 
>   jump.c:5:7: warning: variable 'foo' is used uninitialized whenever
> 'if' condition is true [-Wsometimes-uninitialized]
> 
> I confirmed that QEMU's current compiler flags enable these warnings
> so both gcc and llvm detect the issue that Daniel pointed out in QEMU
> code.
> 
> Daniel: Does this address your concern about compiler warnings?

While it is good that its included when optimization is enabled, IME
GCC is not entirely reliable at detecting unintialized variables as
it has limits on extent of its flow control analysis.

Also consider the maint impact if a method includes C99 decls, and
a contributor later needs to add a 'goto' error cleanup path. They
might be forced to make a bunch of unrelated refactoring changes to
eliminate use of the C99 decls. This makes me not a fan of having a
situation where we tell contributors they can use C99 mixed decls,
except when they can't use them.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


