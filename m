Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD00C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0YN-0005EA-W9; Wed, 16 Jul 2025 07:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uc0Mk-0004gk-HF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uc0Me-0003Sv-Dz
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752665513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Df1vCYquYpEq0apqkonugHu7yYo89n8zohC3t1WF15k=;
 b=HaoDc4nmk8Cx0+5s4xI/wmwJJG5EwcG0M+hfvroK215bBnoWi24vufCv6c0SdZO5zjIIrI
 QfOtoaakV5GVHCu1+QPY0qzfrDQMr7IIdHe7BQ0M2tVwbPOsZfiNQEDwDm+S7T+28iy16+
 n1S7KwF/gtVjbyYmQTl7zYw8l44vqD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-TuQDrxyDPG-169N8GjzbEw-1; Wed,
 16 Jul 2025 07:31:49 -0400
X-MC-Unique: TuQDrxyDPG-169N8GjzbEw-1
X-Mimecast-MFC-AGG-ID: TuQDrxyDPG-169N8GjzbEw_1752665509
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD9F21800C37; Wed, 16 Jul 2025 11:31:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D92A1955F16; Wed, 16 Jul 2025 11:31:43 +0000 (UTC)
Date: Wed, 16 Jul 2025 12:31:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 17/77] meson: Add optional dependency on IGVM library
Message-ID: <aHeNnCnN2RGmbxWm@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
 <20250714110406.117772-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714110406.117772-18-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 14, 2025 at 01:03:06PM +0200, Paolo Bonzini wrote:
> From: Roy Hopkins <roy.hopkins@randomman.co.uk>
> 
> The IGVM library allows Independent Guest Virtual Machine files to be
> parsed and processed. IGVM files are used to configure guest memory
> layout, initial processor state and other configuration pertaining to
> secure virtual machines.
> 
> This adds the --enable-igvm configure option, enabled by default, which
> attempts to locate and link against the IGVM library via pkgconfig and
> sets CONFIG_IGVM if found.
> 
> The library is added to the system_ss target in backends/meson.build
> where the IGVM parsing will be performed by the ConfidentialGuestSupport
> object.

> diff --git a/meson_options.txt b/meson_options.txt
> index a442be29958..1e429311a2d 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -117,6 +117,8 @@ option('tpm', type : 'feature', value : 'auto',
>         description: 'TPM support')
>  option('valgrind', type : 'feature', value: 'auto',
>         description: 'valgrind debug support for coroutine stacks')
> +option('igvm', type: 'feature', value: 'auto',
> +       description: 'Independent Guest Virtual Machine (IGVM) file support')

This description does not match...

>  
>  # Do not enable it by default even for Mingw32, because it doesn't
>  # work on Wine.
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 73e0770f42b..78515404450 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -130,6 +130,7 @@ meson_options_help() {
>    printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
>    printf "%s\n" '  hvf             HVF acceleration support'
>    printf "%s\n" '  iconv           Font glyph conversion support'
> +  printf "%s\n" '  igvm            IGVM file support'

... this description here, so when this file is re-generated by any
other pending patch touching meson options we get a spurious diff
for IGVM.

We really need to get something into 'make check' that runs the
generator and compares its output to 'meson-buildoptions.sh' as
we have hit this problem over & over again.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


