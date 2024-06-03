Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC570C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE45h-0007FU-Th; Mon, 03 Jun 2024 05:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE45g-0007F8-Gk
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE45a-0002VZ-6K
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717407289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCV8/vEXAVrsC6NOzVdfJCMgixLgChXW4n/oSVQ4gFs=;
 b=UqVUNPUYPBoGuuIUZz5XnhvUSBR/wa10ZklpE+oIA1qy8sKgvb9iASQh76kw/DuoXss45G
 iF1pMdm9t2/g2lqwWoHqoYkVGN6MbBORxoGSWOqkdvPD+DHgn6QGcAxF+l4CByW+BJWD5H
 hB2lVC60rUILLZ3g2Uqlin3NjDqTyiQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-COq2i__BPsmctxDOzyUfhQ-1; Mon,
 03 Jun 2024 05:34:46 -0400
X-MC-Unique: COq2i__BPsmctxDOzyUfhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11E5B29AA382;
 Mon,  3 Jun 2024 09:34:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBC21050174;
 Mon,  3 Jun 2024 09:34:45 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:34:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] .gitlab-ci.d/buildtest.yml: Use
 -fno-sanitize=function in the clang-system job
Message-ID: <Zl2OM2SpRc-HEapO@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
 <20240601070543.37786-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240601070543.37786-4-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jun 01, 2024 at 09:05:41AM +0200, Thomas Huth wrote:
> The latest version of Clang (version 18 from Fedora 40) now reports
> bad function pointer casts as undefined behavior. Unfortunately, we are
> still doing this in quite a lot of places in the QEMU code and some of
> them are not easy to fix. So for the time being, temporarily switch this
> off in the failing clang-system job until all spots in the QEMU sources
> have been tackled.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 91c57efded..0eec570310 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -432,6 +432,7 @@ clang-system:
>      IMAGE: fedora
>      CONFIGURE_ARGS: --cc=clang --cxx=clang++
>        --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
> +      --extra-cflags=-fno-sanitize=function
>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
>      MAKE_CHECK_ARGS: check-qtest check-tcg

I think we have a gitlab issue for the functio ncast problems - good
to have a comment linking to those, to remind us to remove -fno-sanitize
when they're fixed.

Regardless

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


