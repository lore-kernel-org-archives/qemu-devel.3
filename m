Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349C1C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwLM-0002eQ-Vf; Wed, 02 Jul 2025 08:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWwLJ-0002ck-6V
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWwLG-00050r-RO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751458412;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgxSzLtizTTIkVDvfEGEzwAVoWcrFNRhe9cZ+FKuHOs=;
 b=JhGyVb2lhhJDgsMMn7XX5PaRa9rj1Xo0V1c4vbIPkESv72dXvkfzhdclc7EZgcJJwziClH
 0cFAuPYobHnONZRw2c05Z26c1eGhr2JiJh+c82BX+rhVHs4LE3woK0jmv/v4G+oaA8L2nZ
 AsRWn21WRmDpoAuSpUzrw43HhbrHiJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Y5QsNUiONdu8ZdRWWaPXdQ-1; Wed,
 02 Jul 2025 08:13:26 -0400
X-MC-Unique: Y5QsNUiONdu8ZdRWWaPXdQ-1
X-Mimecast-MFC-AGG-ID: Y5QsNUiONdu8ZdRWWaPXdQ_1751458405
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AACA918DA381; Wed,  2 Jul 2025 12:13:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB1119560A7; Wed,  2 Jul 2025 12:13:21 +0000 (UTC)
Date: Wed, 2 Jul 2025 13:13:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 24/68] accel/system: Add 'info accel' on human monitor
Message-ID: <aGUiXjcEvx7ncBRI@redhat.com>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-25-philmd@linaro.org>
 <878ql7rxxg.fsf@pond.sub.org>
 <d9ab105e-20ad-4ee2-8655-2b89ed3910b8@linaro.org>
 <87ms9myf9a.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ms9myf9a.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 02, 2025 at 02:00:01PM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > On 2/7/25 06:58, Markus Armbruster wrote:
> >> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> >> 
> >>> 'info accel' dispatches to the AccelOpsClass::get_stats()
> >>> and get_vcpu_stats() handlers.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> >> 
> >> Standard question for new HMP commands that don't wrap around QMP
> >> commands: why is the functionality not useful in QMP?
> >
> > So far the sole use of this command is to prove the 'split accel'
> > works by using it in a test:
> > https://lore.kernel.org/qemu-devel/20250620172751.94231-43-philmd@linaro.org/
> 
> Different series?  Best to add new interfaces together with their uses.
> 
> > Is it worth overloading QAPI and its documentation, and overload
> > the QMP command set (even if prefixing with experimental / hidden 'x-')?
> >
> > If so, I don't mind implementing yet another "embedded plain HMP string
> > to QMP command" in v4, or directly export each debug statistical value
> > via QAPI.
> 
> Whatever the reasons for implementing something in HMP only may be, the
> commit message should state them.
> 
> "Just for testing" is a valid reason for HMP-only.  It's not obvious
> from the command documentation or code, though.

IMHO there is no valid reason for continuing to add HMP-only commands
which are not backed by QMP.

A test case can easily run QMP commands, and we accept arbitrary QMP
commands with the 'x-' prefix and experimental tag, to serve as the
basis for the HMP command printing human readable text. So if anything
I'd suggest exposing a QMP command and not bothering with HMP at all.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


