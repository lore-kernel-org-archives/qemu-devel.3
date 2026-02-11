Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F18ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCvn-0001OV-2D; Wed, 11 Feb 2026 11:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqCvk-0001O9-V1
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqCvj-0001bU-08
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826746;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4a2VcLKbLYnGVEh/bZk6tGSTGFEeQYoqBEMcmNMBgA=;
 b=dyj1UA9i1lMnvJ8GGSn8FW1T9fPLj9+JY5iQhkwKcnBN+QeDCHtUlJgKtgB5+yAfZrICJH
 rzqlWiEkG4NWQoTm2biFltuXt2QtHSQkyHY9l1jD539eDGXaLV2OFBKWBp8kdfrmp9Zcjn
 w8Ua4plfSf5i2NMNF6kTBdiNEQgWxSA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-LEE6XT35O9qzHgr-YEyF4Q-1; Wed,
 11 Feb 2026 11:19:04 -0500
X-MC-Unique: LEE6XT35O9qzHgr-YEyF4Q-1
X-Mimecast-MFC-AGG-ID: LEE6XT35O9qzHgr-YEyF4Q_1770826743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF5FE180025B; Wed, 11 Feb 2026 16:19:03 +0000 (UTC)
Received: from redhat.com (unknown [10.45.227.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CD1418004AD; Wed, 11 Feb 2026 16:19:01 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:18:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
Message-ID: <aYyr8luQzgKKLqIg@redhat.com>
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209133906.294720-2-abologna@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 09, 2026 at 02:39:06PM +0100, Andrea Bolognani wrote:
> This allows describing firmwares that are loaded as ROMs but also
> support a UEFI variable store. This is the case for edk2 builds
> that are set up to use the uefi-vars QEMU device, and whose
> descriptors would advertise the 'host-uefi-vars' feature.
> 
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>  docs/interop/firmware.json | 44 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index da0362a2c0..e51fffa473 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -369,6 +369,39 @@
>  { 'struct' : 'FirmwareMappingKernel',
>    'data'   : { 'filename' : 'str' } }
>  
> +##
> +# @FirmwareMemoryUefiVars:
> +#
> +# Contains information needed to set up the "uefi-vars" device
> +# to provide UEFI variable store access to the firmware.
> +#
> +# @template: The path to the UEFI variable store template compatible

s/UEFI variable store/UEFI JSON variable store/

> +#     with the firmware.  Management software instantiates an
> +#     individual copy -- a specific UEFI variable store file -- from
> +#     @template for each new virtual machine definition created.
> +#     @template itself is never mapped into virtual machines, only
> +#     individual copies of it are.  The file created by copying
> +#     @template is used for persistently storing the non-volatile
> +#     UEFI variables of a virtual machine definition.  The
> +#     corresponding QEMU command line options are
> +#
> +#     ::
> +#
> +#         -device uefi-vars-x64,jsonfile=PATH_TO_PRIVATE_FILE
> +#
> +#     for x86_64 virtual machines, or
> +#
> +#     ::
> +#
> +#         -device uefi-vars-sysbus,jsonfile=PATH_TO_PRIVATE_FILE
> +#
> +#     for other UEFI architectures (aarch64, riscv64, loongarch64).
> +#
> +# Since: 11.0
> +##
> +{ 'struct' : 'FirmwareMemoryUefiVars',
> +  'data'   : { 'template' : 'str' }}
> +
>  ##
>  # @FirmwareMappingMemory:
>  #
> @@ -380,10 +413,19 @@
>  #     definitions.  The corresponding QEMU command line option is
>  #     "-bios @filename".
>  #
> +# @uefi-vars: Information specific to firmware builds that expect the
> +#             "uefi-vars" device to be used to provide access to the
> +#             UEFI variable store.  If the mapping contains this
> +#             member, the firmware descriptor should advertise the
> +#             @uefi interface from @FirmwareOSInterface as well as
> +#             the @host-uefi-vars feature from @FirmwareFeature.
> +#             Since 11.0

s/should advertize the/must advertize both the/

s/as well as/and/

With those changes:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> +#
>  # Since: 3.0
>  ##
>  { 'struct' : 'FirmwareMappingMemory',
> -  'data'   : { 'filename' : 'str' } }
> +  'data'   : { 'filename' : 'str',
> +               '*uefi-vars' : 'FirmwareMemoryUefiVars' } }
>  
>  ##
>  # @FirmwareMappingIgvm:
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


