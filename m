Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C123C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpk5l-0005UU-Ik; Fri, 31 Jul 2026 06:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpk5k-0005UB-27
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:03:48 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1wpk5i-0006At-3P
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 06:03:47 -0400
Received: from [192.168.106.196]
 (dynamic-077-002-060-183.77.2.pool.telefonica.de [77.2.60.183])
 by csgraf.de (Postfix) with ESMTPSA id 610E7608027F;
 Fri, 31 Jul 2026 12:03:42 +0200 (CEST)
Message-ID: <ad328c87-eef8-40ae-842c-cea5633cc2d9@csgraf.de>
Date: Fri, 31 Jul 2026 12:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] hw/misc/vmlaunchupdate: add api header
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: graf@amazon.com, qemu-devel@nongnu.org
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-5-anisinha@redhat.com>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20260730071254.80695-5-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 30.07.26 09:12, Ani Sinha wrote:
> Add a separate header file for guest usable api definitions.
>
> CC: Alex Graf <graf@amazon.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++++++++++++++++
>   1 file changed, 102 insertions(+)
>   create mode 100644 include/standard-headers/misc/vmlaunchupdate.h
>
> diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
> new file mode 100644
> index 0000000000..fc18f8faf7
> --- /dev/null
> +++ b/include/standard-headers/misc/vmlaunchupdate.h


Didn't standard-headers usually get imported from somewhere, like Linux? 
Where does this one originate? If it's self written, why not put it into 
include/hw/misc?


> @@ -0,0 +1,102 @@
> +/*
> + * Guest driven VM launch state update device via IGVM.
> + * The definitions in this header defines the API for the hypervisor interface.
> + * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
> + *
> + * Copyright (C) 2026 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +#ifndef VMLAUNCHUPDATE_API_H
> +#define VMLAUNCHUPDATE_API_H
> +
> +/* fw-cfg file definition */
> +#define FILE_VMLAUNCHUPDATE "etc/vmlaunchupdate"
> +
> +/* version */
> +#define VM_LAUNCHUPDATE_VERSION 0x01
> +
> +/* format bits, used by both 'capabilities' and 'control'  */
> +
> +/* igvm */
> +#define VM_LAUNCHUPDATE_FORMAT_IGVM           (1ULL << 32)
> +
> +/* 'control' field bits  */
> +
> +/* disable vmlaunchupdate interface */
> +#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
> +/* revert to the original host provided igvm */
> +#define VM_LAUNCHUPDATE_CTL_HOST_IGVM          (1 << 1)
> +
> +/* The combination of the above two ctl interfaces work as
> + * follows:
> + *
> + * A) CTL_HOST_IGVM=off CTL_DISABLE=off
> + *
> + * Supplied IGVM file replaces the firmware permanently.  Updating the
> + * firmware again is possible.
> + *
> + * B) CTL_HOST_IGVM=off CTL_DISABLE=on
> + *
> + * Supplied IGVM file replaces the firmware permanently.  Updating the
> + * firmware again is not possible.
> + *
> + * C) CTL_HOST_IGVM=on CTL_DISABLE=off
> + *
> + * Supplied IGVM file replaces the firmware for one reset.  Resetting
> + * again will switch back to the original firmware.  Updating the
> + * firmware again is possible.
> + *
> + * D) CTL_HOST_IGVM=on CTL_DISABLE=on
> + *
> + * Supplied IGVM file replaces the firmware for one reset.  Resetting
> + * again will switch back to the original firmware.  Updating the
> + * firmware again is NOT possible.
> + *
> + */
> +
> +/* status code */
> +enum VMLaunchUpdateStatus {
> +    VM_LAUNCHUPDATE_SUCCESS,
> +    VM_LAUNCHUPDATE_LOAD_FAIL,
> +    VM_LAUNCHUPDATE_NOT_IGVM_INIT,
> +};
> +
> +typedef struct {
> +    /* api version */
> +    uint16_t version;
> +
> +    /*
> +     * The guest can read this in order to determine if loading new IGVM
> +     * succeeded.
> +     */
> +    uint16_t status;
> +
> +    uint32_t _padding;
> +
> +    /* VMM capabilities, read-only. */
> +    uint64_t capabilities;
> +    /* control bits, see VMFWUPDATE_CTL_* */
> +    uint64_t control;
> +
> +    /*
> +     * address and size of the IGVM image.  Will be cleared when
> +     * the write completes successfully and IGVM file is correctly parsed.
> +     */
> +    uint64_t fw_image_addr;
> +    uint64_t fw_image_size;
> +
> +    /*
> +     * address + size of opaque blob.  The guest can use this to pass on
> +     * information, for example which memory region the linux kernel has been
> +     * loaded to.  writable, will be kept intact on firmware update.
> +     */
> +    uint64_t opaque_addr;
> +    uint64_t opaque_size;
> +
> +} VMLaunchUpdate;


In theory, we may want to allow all of this logic with TCG eventually. 
At that point, we need to watch out for different struct layout 
constraints implied by the compiler. It's probably best to mark this 
struct QEMU_PACKED right away to not run into accidental padding on 
obscure platforms later.


Alex


