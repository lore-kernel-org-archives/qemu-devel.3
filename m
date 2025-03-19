Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15399C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turGa-00072a-PN; Wed, 19 Mar 2025 07:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turGY-000728-Tm
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turGX-00025z-34
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742382435;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xInxaIjWeqBykHjNIwgyArR9haje7myVLKDqOsKIX9s=;
 b=W5ksFUdqVPKmLuC4mIMXM5Wagq2uvUi7NWyRGqrTJ4DYVief3zmuodwW1PtfLve+Qfi/pb
 /g0R+xCNo/sOYuURF/LCf7/Z1ebIHQce5xhfZYl5dIlsWFborZnsZMil785sTGCqLeTK3B
 4pKkCn/Aj2vdZ61BS0WlntR1UhV5dHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-Y_0nvRGFNz-zI5zngoWM-A-1; Wed,
 19 Mar 2025 07:07:12 -0400
X-MC-Unique: Y_0nvRGFNz-zI5zngoWM-A-1
X-Mimecast-MFC-AGG-ID: Y_0nvRGFNz-zI5zngoWM-A_1742382431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6921800A34; Wed, 19 Mar 2025 11:07:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0011800944; Wed, 19 Mar 2025 11:07:08 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:07:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <Z9qlWV_TsnndwIM4@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319110152.1309969-5-kraxel@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Mar 19, 2025 at 12:01:51PM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/interop/firmware.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 57f55f6c5455..76df1043dae9 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -214,13 +214,16 @@
>  #                  PL011 UART. @verbose-static is mutually exclusive
>  #                  with @verbose-dynamic.
>  #
> +# @qemu-vars: The firmware expects qemu to provide an efi variable
> +#             store, via "uefi-vars-sysbus" or "uefi-vars-x64" device.

It seems like this would imply mapping.device == memory, as if we had
mapping.device == flash, then we would need to extend FirmwareFlashMode
with an extra option ? If so, lets document this expectation.

> +#
>  # Since: 3.0
>  ##
>  { 'enum' : 'FirmwareFeature',
>    'data' : [ 'acpi-s3', 'acpi-s4',
>               'amd-sev', 'amd-sev-es', 'amd-sev-snp',
>               'intel-tdx',
> -             'enrolled-keys', 'requires-smm', 'secure-boot',
> +             'enrolled-keys', 'requires-smm', 'secure-boot', 'qemu-vars',
>               'verbose-dynamic', 'verbose-static' ] }
>  
>  ##
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


