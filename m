Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AD8C79F9C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 14:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcllP-0000hN-TF; Mon, 05 Jan 2026 09:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vcllA-0000UC-3R
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vcll6-00013a-Ji
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767624034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X9erSmLZYRs6TUDf9tD1wk2f1OvU9PGvgsVtotRHgkQ=;
 b=ZKDb/MGYkgVJBHSfQK4LtyQZ8tpRG0nD1ztZH8+UUVDfJx+HowZfU4Eg+UWq843diKJ1cE
 r7HXmrxohJW3/XQ7S6X0Xf4x9tqDOsV6PS9UVwU9MzgeJXCep3tmq4EiJwWiLuFj4x/cp2
 /R1f5z6Rd8YCquX2pbhcuY5hCuEGPIk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-yjTfnku2OE2bDrxZ9a6QbA-1; Mon,
 05 Jan 2026 09:40:30 -0500
X-MC-Unique: yjTfnku2OE2bDrxZ9a6QbA-1
X-Mimecast-MFC-AGG-ID: yjTfnku2OE2bDrxZ9a6QbA_1767624029
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C7FF18002C1; Mon,  5 Jan 2026 14:40:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE43830001A8; Mon,  5 Jan 2026 14:40:26 +0000 (UTC)
Date: Mon, 5 Jan 2026 14:40:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] docs/interop/firmware: Introduce extended syntax for
 FirmwareMappingMemory
Message-ID: <aVvNV0X0uZ4lVBWv@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
 <20251228232649.1708400-3-abologna@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251228232649.1708400-3-abologna@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 29, 2025 at 12:26:49AM +0100, Andrea Bolognani wrote:
> The new syntax allows describing firmwares that are loaded as
> ROMs but also support NVRAM storage. This is the case for edk2
> builds that are set up to use the uefi-vars QEMU device, and
> whose descriptors would advertise the 'host-uefi-vars' feature.

I find it a bit of a stretch to be referring to the host-uefi-vars
feature as being "NVRAM storage". IIUC, it is effectively a command
/ response RPC service over a paravirtualized device.

> The extended syntax intentionally mirrors FirmwareMappingFlash
> since it needs to cover the exact same scenarios, which are a
> strict superset of the ones FirmwareMappingMemory supports
> today.

IMHO this is a mistake as it isn't really the same as the
NVRAM for the flash mapping.


> +##
> +# @FirmwareMemoryExecutableFormat:
> +#
> +# Formats that are supported for firmware executables.
> +#
> +# @raw: Raw disk image format.
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'FirmwareMemoryExecutableFormat',
> +  'data': [ 'raw' ] }
> +
> +##
> +# @FirmwareMemoryNvramFormat:
> +#
> +# Formats that are supported for firmware NVRAM files.
> +#
> +# @json: JSON format.
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'FirmwareMemoryNvramFormat',
> +  'data': [ 'json' ] }

These two are both examples of where the analogy to the flash
mapping falls down.

The executable format in flash mapping was required because
the binaries are provided via the block backend config (-blockdev).
The list of formats conceptually would expand to anything that
is possible with -blockdev, but we artificially restricted the
schema to just raw & qcow2 since other options were somewhat
unplausible.

Similarly the flash mapping nvram again wanted a format because
it was again describing something to be used with -blockdev.

Neither of these two scenarios applies, and while we could squint
and say using "raw" is acceptable for FirmwareMemoryExecutableFormat,
using "json" is definitely not a fit as it has nothing todo with
-blockdev.


> +##
> +# @FirmwareMemoryMode:
> +#
> +# Describes how the firmware build handles variable persistence.
> +#
> +# @split: the executable file contains code while the NVRAM template
> +#     provides variable storage.  The executable can be shared
> +#     between multiple guests.  The NVRAM template must be cloned for
> +#     each new guest and configured read-write.
> +#
> +# @stateless: the executable file contains code and variable storage
> +#     is not persisted.  The executable can be shared between
> +#     multiple guests.  No NVRAM template will be specified.
> +#
> +# Since: 11.0
> +##
> +{ 'enum' : 'FirmwareMemoryMode',
> +  'data' : [ 'split', 'stateless' ] }

This feels very wierd talking about NVRAM again when no such concept
exists with -bios, even when the UEFI var service is present.

The 'split' concept doesn't really match what the UEFI var service
provides IMHO. 


> +# The two syntaxes are mutually exclusive. In particular:
> +#
> +# - only one of @filename and @executable can be specified;
> +#
> +# - if @filename is specified, @mode must be omitted and its value
> +#   is assumed to be @stateless.  If @executable is used instead,
> +#   the value for @mode must be provided explicitly;
> +#
> +# - @nvram-template can only be specified together with @executable,
> +#   and in this case the value of @mode must be @split.
> +#
> +# Based on these rules,
> +#
> +# ::
> +#
> +#     {
> +#         "mapping: {
> +#             "device": "memory",
> +#             "filename": "/path/to/firmware.bin"
> +#         }
> +#     }
> +#
> +# and
> +#
> +# ::
> +#
> +#     {
> +#         "mapping": {
> +#             "device": "memory",
> +#             "mode": "stateless",
> +#             "executable": {
> +#                 "filename": "/path/to/firmware.bin",
> +#                 "format": "raw"
> +#             }
> +#         }
> +#     }
> +#
> +# are completely equivalent, whereas
> +#
> +# ::
> +#
> +#     {
> +#         "mapping": {
> +#             "device": "memory",
> +#             "mode": "split",
> +#             "executable": {
> +#                 "filename": "/path/to/firmware.bin",
> +#                 "format": "raw"
> +#             },
> +#             "nvram-template": {
> +#                 "filename": "/path/to/variables.json",
> +#                 "format": "json"
> +#             }
> +#         }
> +#     }
> +#
> +# can only be described using the extended syntax.
> +#
> +# @mode: Describes how the firmware build handles variable storage.
> +#     Must be present when @executable is used and absent when
> +#     @filename is used; in the latter scenario, its value will be
> +#     assumed to be @stateless.  Since: 11.0
> +#
> +# @executable: Describes the firmware excutable.  The corresponding
> +#     QEMU command line option is "-bios @executable.@filename".
> +#     Since: 11.0
> +#
> +# @nvram-template: Describes the NVRAM template compatible with
> +#     @executable, when @mode is set to @split, otherwise it should
> +#     not be present.  Management software instantiates an individual
> +#     copy -- a specific NVRAM file -- from @nvram-template.@filename
> +#     for each new virtual machine definition created.
> +#     @nvram-template.@filename itself is never mapped into virtual
> +#     machines, only individual copies of it are.  An NVRAM file is
> +#     typically used for persistently storing the non-volatile UEFI
> +#     variables of a virtual machine definition.  The corresponding
> +#     QEMU command line option is
> +#
> +#     ::
> +#
> +#         -device uefi-vars-x64,jsonfile=FILENAME_OF_PRIVATE_NVRAM_FILE
> +#
> +#     on x86_64 and
> +#
> +#     ::
> +#
> +#         -device uefi-vars-sysbus,jsonfile=FILENAME_OF_PRIVATE_NVRAM_FILE
> +#
> +#     on other architectures (aarch64, riscv64, loongarch64).
> +#     Since: 11.0
> +#
> +# @filename: Legacy syntax that can only describe @stateless firmware
> +#     builds.  The corresponding QEMU command line option is "-bios
> +#     @filename".  If present, none of the other attributes (@mode,
> +#     @executable, @template) can be present.
>  #
>  # Since: 3.0
>  ##
>  { 'struct' : 'FirmwareMappingMemory',
> -  'data'   : { 'filename' : 'str' } }
> +  'data'   : { '*mode'           : 'FirmwareMemoryMode',
> +               '*executable'     : 'FirmwareMemoryExecutableFile',
> +               '*nvram-template' : 'FirmwareMemoryNvramTemplateFile',
> +               '*filename'       : 'str' } }

IMHO we could add merely a new "uefi-vars-service" such that it looks
like this:

     {
         "mapping: {
             "device": "memory",
             "filename": "/path/to/firmware.bin",
	     "uefi-vars-service": {
	       "template": "/path/to/firmware.json",
	     }
         }
     }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


