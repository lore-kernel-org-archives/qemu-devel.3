Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40866E6814E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsH4J-0008LN-Gw; Tue, 17 Feb 2026 04:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsH4H-0008L1-5J
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsH4D-0003LF-BR
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771319303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahmM3I2JCBoLKKwe/8T+2pL0KotM1K8eCuhqWuu6uwo=;
 b=b0UQmDRlLJD9BG2TCF4lgC+XiBIxdTHglcpImcPg/8MQ1h8r3wXxrU2r7KAkdBWd/AlxFg
 5YAfp3x/dTJaTELjf9+m8oWoFACFO8ocPPegxsG/EGO+nGN2uYsTzEkGB9XQ0cfxmxLwM6
 k7ctUk+4SNQ00KIg7iVE0+QoqnzWT/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-JzrcnPm8NE2UhdFWDZP8cw-1; Tue,
 17 Feb 2026 04:08:18 -0500
X-MC-Unique: JzrcnPm8NE2UhdFWDZP8cw-1
X-Mimecast-MFC-AGG-ID: JzrcnPm8NE2UhdFWDZP8cw_1771319297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDF1C1955D7A; Tue, 17 Feb 2026 09:08:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC2030001BF; Tue, 17 Feb 2026 09:08:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F390421E692D; Tue, 17 Feb 2026 10:08:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Kashyap Chamarthy
 <kchamart@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member
 for FirmwareMappingMemory
In-Reply-To: <20260209133906.294720-2-abologna@redhat.com> (Andrea Bolognani's
 message of "Mon, 9 Feb 2026 14:39:06 +0100")
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
Date: Tue, 17 Feb 2026 10:08:14 +0100
Message-ID: <87seazn3ep.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Andrea Bolognani <abologna@redhat.com> writes:

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
> +#

(Since 11.0) and indent like this, please:

   # @uefi-vars: Information specific to firmware builds that expect the
   #     "uefi-vars" device to be used to provide access to the UEFI
   #     variable store.  If the mapping contains this member, the
   #     firmware descriptor should advertise the @uefi interface from
   #     @FirmwareOSInterface as well as the @host-uefi-vars feature
   #     from @FirmwareFeature.  (Since 11.0)

>  # Since: 3.0
>  ##
>  { 'struct' : 'FirmwareMappingMemory',
> -  'data'   : { 'filename' : 'str' } }
> +  'data'   : { 'filename' : 'str',
> +               '*uefi-vars' : 'FirmwareMemoryUefiVars' } }
>  
>  ##
>  # @FirmwareMappingIgvm:

Acked-by: Markus Armbruster <armbru@redhat.com>


