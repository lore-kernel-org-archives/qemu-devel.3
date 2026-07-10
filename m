Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A5FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi7vX-0003Nw-1O; Fri, 10 Jul 2026 05:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi7vU-0003No-Sa
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi7vS-00034E-Fw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783677221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wWthMpWOTErRlCXV+0K2SDcr5YjJh5DfnVWxCtEN/4o=;
 b=YsUOj4oPmXTpDM/lGdczjL6JsZYkbky8vffgMAeL8n5I6fOv66/xAs9md79ARCYxYjzH5A
 +7Q6rllL2oiFeuL9YlTBUJ4gITsXQCFQRxHOEtQ7Cuj+PlcpQtPukgYUg9PyvsaYOIcoGB
 YVMWAIkZxYprjMSCQN0qjyaxwpE/Duo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-SDrNQAAnMvC86fnItBhEWw-1; Fri,
 10 Jul 2026 05:53:37 -0400
X-MC-Unique: SDrNQAAnMvC86fnItBhEWw-1
X-Mimecast-MFC-AGG-ID: SDrNQAAnMvC86fnItBhEWw_1783677216
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20C0C1956094; Fri, 10 Jul 2026 09:53:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.77])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA22018001D2; Fri, 10 Jul 2026 09:53:32 +0000 (UTC)
Date: Fri, 10 Jul 2026 10:53:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
Subject: Re: [PATCH] meson.build: re-add explicit gcrypt/nettle request check
Message-ID: <alDBGFEqLeaBFdcC@redhat.com>
References: <20260710075113.35631-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710075113.35631-1-luc.michel@amd.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Jul 10, 2026 at 09:51:12AM +0200, Luc Michel wrote:
> c4b3d0074 removed the check that nettle or gcrypt were explicitly
> requested as the crypto library to use, breaking the --enable-nettle and
> --enable-gcrypt options. Re-add the check.
> 
> Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 164328ded83..475c5922030 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1809,10 +1809,15 @@ crypto_sm3 = not_found
>  
>  if get_option('nettle').enabled() and get_option('gcrypt').enabled()
>    error('Only one of gcrypt & nettle can be enabled')
>  endif
>  
> +# Explicit nettle/gcrypt request, so ignore gnutls for crypto
> +if get_option('nettle').enabled() or get_option('gcrypt').enabled()
> +  gnutls = not_found
> +endif
> +
>  if not gnutls.found()

This is not sufficient - if  --enable-nettle is given this logic
will fully disable all use of gnutls.  We need to retain the use
of nettle for TLS APIs, but exclude it for crypto APIs.

IOW, we need to revert more of c4b3d0074 - can you also bring
back the lines that set the 'gnutls_crypto' variable, so we
can disable gnutls for crypto only, not TLS>

>    if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
>      gcrypt = dependency('libgcrypt', version: '>=1.9.4',
>                          required: get_option('gcrypt'))
>      # Debian has removed -lgpg-error from libgcrypt-config
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


