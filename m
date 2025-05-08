Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF4C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 18:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD5x3-0007v2-4l; Thu, 08 May 2025 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD5x0-0007qv-SC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 14:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD5wx-0006hk-7d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 14:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746728786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QLGWMrXN5hRKgbdnj9lu34SYj0cWT9tgsZHRwQj11vs=;
 b=goJDvyt59FL8TmEQf/sRkkpCIBIaUf+VBx69HtsVSIDVuCn74AZ+OQV4Db/ILb6pTmzNZu
 CL2ujRCKoqFN/d2G27FU3KFB4F8fu4G7dftrWZgUN+dZNm9noBrkvBlgPsIuUiGx0td1/d
 AfSXegnHgbXhTrPnBCps2BFE2r+gyxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-FoWJ47CSMIe1izN_z1DuKQ-1; Thu,
 08 May 2025 14:26:22 -0400
X-MC-Unique: FoWJ47CSMIe1izN_z1DuKQ-1
X-Mimecast-MFC-AGG-ID: FoWJ47CSMIe1izN_z1DuKQ_1746728781
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23F3D1956080; Thu,  8 May 2025 18:26:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C7231956055; Thu,  8 May 2025 18:26:17 +0000 (UTC)
Date: Thu, 8 May 2025 19:26:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 5/5] Revert "meson.build: Disable
 -fzero-call-used-regs on OpenBSD"
Message-ID: <aBz3Rh6S5emirSPz@redhat.com>
References: <20250508144120.163009-1-thuth@redhat.com>
 <20250508144120.163009-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508144120.163009-6-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 08, 2025 at 04:41:20PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> This reverts commit 2d6d995709482cc8b6a76dbb5334a28001a14a9a.
> 
> OpenBSD 7.7 fixed the problem with the -fzero-call-used-regs on OpenBSD,
> see https://github.com/openbsd/src/commit/03eca72d1e030b7a542cd6aec1 for
> the fix there.
> 
> Suggested-by: Brad Smith <brad@comstyle.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Marked as RFC since we likely can include this only once OpenBSD
>  7.6 goes out of service, see:
>  https://lists.libreplanet.org/archive/html/qemu-arm/2025-05/msg00559.html

Yep, we have to wait a bit longer, unless someone can confirm the
fix was backported to 7.6

> 
>  meson.build | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 6c61e1dcaec..5f0e6a65cb0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -699,11 +699,7 @@ hardening_flags = [
>  #
>  # NB: Clang 17 is broken and SEGVs
>  # https://github.com/llvm/llvm-project/issues/75168
> -#
> -# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
> -# https://gitlab.com/qemu-project/qemu/-/issues/2278
> -if host_os != 'openbsd' and \
> -   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
> +if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
>                 name: '-fzero-call-used-regs=used-gpr',
>                 args: ['-O2', '-fzero-call-used-regs=used-gpr'])
>      hardening_flags += '-fzero-call-used-regs=used-gpr'
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


