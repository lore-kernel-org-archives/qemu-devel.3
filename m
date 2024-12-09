Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF01E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 22:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKmKf-0003FP-KG; Mon, 09 Dec 2024 17:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKmKc-0003Ev-UY; Mon, 09 Dec 2024 17:34:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKmKa-0000jM-Ju; Mon, 09 Dec 2024 17:34:22 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JvaCf002320;
 Mon, 9 Dec 2024 22:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E4Uk3D
 9gLZEWufOyfC2YxFHDBaeaLwn5jcvl7eMYNlE=; b=XENRxfEzyhT6bRpDBzThZF
 nwbv2SBN7rH39+Ecc2bRol5M6WAsc+HtFSAfnOMqhZ409unB8jDQgw5UDxpjI5Cs
 xnJFMdrL7ExGHwki6VU0IjMHazamdbbzv3X4Mkoq/u+et1qm/v7wjnDMsCPAde1N
 X90wcfmbPq/4QVue9oLuMTKBoyK/95rxdm11n+FymYroAzcM7P3asE/UjlnsEshz
 sNL0/EBveYSR7Ly7Dc6DoClIXjgemp2r3ZIFxbG3KGmFgHghuQb4Q57Cnzi6AE5p
 ONFrF5DitmrIHDZttHyHsQkgjfqXXn8kc3zToLaL9LZBq3VvpLW/JoUh8V7boXNQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vkvew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 22:34:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Lda8v032727;
 Mon, 9 Dec 2024 22:34:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps8wn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 22:34:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9MYF8c34472372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 22:34:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A48E5805D;
 Mon,  9 Dec 2024 22:34:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C04258058;
 Mon,  9 Dec 2024 22:34:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 22:34:14 +0000 (GMT)
Message-ID: <1da8840e-a7be-48c5-bc06-e7a4e111b9e7@linux.ibm.com>
Date: Mon, 9 Dec 2024 17:34:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 23/26] hw/tpm: Add TPM event log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-25-jean-philippe@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241125195626.856992-25-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M6ujat-5dXQttN6p07xhY9N7b4V4QIjb
X-Proofpoint-ORIG-GUID: M6ujat-5dXQttN6p07xhY9N7b4V4QIjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> Provide a library allowing the VMM to create an event log that describes
> what is loaded into memory. During remote attestation in confidential
> computing this helps an independent verifier reconstruct the initial
> measurements of a VM, which contain the initial state of memory and
> CPUs.
> 
> We provide some definitions and structures described by the Trusted
> Computing Group (TCG) in "TCG PC Client Platform Firmware Profile
> Specification" Level 00 Version 1.06 Revision 52 [1]. This is the same
> format used by UEFI, and UEFI could reuse this log after finding it in

as used by

> DT or ACPI tables, but can also copy its content into a new one.

I thought it was going to be a completely independent log. If UEFI would 
do anything with it, I think it would have to replay the measurements 
into its own log and extend them into all PCRs of all active PCR banks 
of the TPM, but if I understand correctly then you do not use the TPM 
for this log at all since you have a signature over it and defined 
(somewhere -- where?) that only sha256 and sha512 are to be used for 
this log.

> 
> [1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> 
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New
> ---
>   qapi/tpm.json            |  14 ++
>   include/hw/tpm/tpm_log.h |  89 +++++++++++
>   hw/tpm/tpm_log.c         | 325 +++++++++++++++++++++++++++++++++++++++
>   hw/tpm/Kconfig           |   4 +
>   hw/tpm/meson.build       |   1 +
>   5 files changed, 433 insertions(+)
>   create mode 100644 include/hw/tpm/tpm_log.h
>   create mode 100644 hw/tpm/tpm_log.c
> 
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index a16a72edb9..697e7150ee 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -188,3 +188,17 @@
>   ##
>   { 'command': 'query-tpm', 'returns': ['TPMInfo'],
>     'if': 'CONFIG_TPM' }
> +
> +##
> +# @TpmLogDigestAlgo:
> +#
> +# @sha256: Use the SHA256 algorithm
> +#
> +# @sha512: Use the SHA512 algorithm
> +#
> +# Algorithm to use for event log digests
> +#
> +# Since: 9.3
> +##
> +{ 'enum': 'TpmLogDigestAlgo',
> +  'data': ['sha256', 'sha512'] }
> diff --git a/include/hw/tpm/tpm_log.h b/include/hw/tpm/tpm_log.h
> new file mode 100644
> index 0000000000..b3cd2e7563
> --- /dev/null
> +++ b/include/hw/tpm/tpm_log.h
> @@ -0,0 +1,89 @@
> +#ifndef QEMU_TPM_LOG_H
> +#define QEMU_TPM_LOG_H
> +
> +#include "qom/object.h"
> +#include "sysemu/tpm.h"
> +
> +/*
> + * Defined in: TCG Algorithm Registry
> + * Family 2.0 Level 00 Revision 01.34
> + *
> + * (Here TCG stands for Trusted Computing Group)
> + */
> +#define TCG_ALG_SHA256  0xB
> +#define TCG_ALG_SHA512  0xD
> +
> +/* Size of a digest in bytes */
> +#define TCG_ALG_SHA256_DIGEST_SIZE      32
> +#define TCG_ALG_SHA512_DIGEST_SIZE      64
> +
> +/*
> + * Defined in: TCG PC Client Platform Firmware Profile Specification
> + * Version 1.06 revision 52
> + */
> +#define TCG_EV_NO_ACTION                        0x00000003
> +#define TCG_EV_EVENT_TAG                        0x00000006
> +#define TCG_EV_POST_CODE2                       0x00000013
> +#define TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2      0x8000000A
> +
> +struct UefiPlatformFirmwareBlob2Head {
> +        uint8_t blob_description_size;
> +        uint8_t blob_description[];
> +} __attribute__((packed));
> +
> +struct UefiPlatformFirmwareBlob2Tail {
> +        uint64_t blob_base;
> +        uint64_t blob_size;
> +} __attribute__((packed));
> +
> +#define TYPE_TPM_LOG "tpm-log"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(TpmLog, TPM_LOG)
> +
> +/**
> + * tpm_log_create - Create the event log
> + * @log: the log object
> + * @max_size: maximum size of the log. Adding an event past that size will
> + *            return an error
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Allocate the event log and create the initial entry (Spec ID Event03)
> + * describing the log format.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int tpm_log_create(TpmLog *log, size_t max_size, Error **errp);
> +
> +/**
> + * tpm_log_add_event - Append an event to the log
> + * @log: the log object
> + * @event_type: the `eventType` field in TCG_PCR_EVENT2
> + * @event: the `event` field in TCG_PCR_EVENT2
> + * @event_size: the `eventSize` field in TCG_PCR_EVENT2
> + * @data: content to be hashed into the event digest. May be NULL.
> + * @data_size: size of @data. Should be zero when @data is NULL.
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Add a TCG_PCR_EVENT2 event to the event log. Depending on the event type, a
> + * data buffer may be hashed into the event digest (for example
> + * TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2 contains a digest of the blob.)
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +int tpm_log_add_event(TpmLog *log, uint32_t event_type, const uint8_t *event,
> +                      size_t event_size, const uint8_t *data, size_t data_size,
> +                      Error **errp);
> +
> +/**
> + * tpm_log_write_and_close - Move the log to guest memory
> + * @log: the log object
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Write the log into memory, at the address set in the load-addr property.
> + * After this operation, the log is not writable anymore.
> + *
> + * Return: 0 on success, -1 on error
> + */
> +int tpm_log_write_and_close(TpmLog *log, Error **errp);
> +
> +#endif
> diff --git a/hw/tpm/tpm_log.c b/hw/tpm/tpm_log.c
> new file mode 100644
> index 0000000000..e6183a6e70
> --- /dev/null
> +++ b/hw/tpm/tpm_log.c
> @@ -0,0 +1,325 @@
> +/*
> + * tpm_log.c - Event log as described by the Trusted Computing Group (TCG)
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * Create an event log in the format specified by:
> + *
> + *  TCG PC Client Platform Firmware Profile Specification
> + *  Level 00 Version 1.06 Revision 52
> + *  Family “2.0”
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "crypto/hash.h"
> +#include "exec/address-spaces.h"
> +#include "exec/memory.h"
> +#include "hw/tpm/tpm_log.h"
> +#include "qapi/error.h"
> +#include "qemu/bswap.h"
> +#include "qom/object_interfaces.h"
> +
> +/*
> + * Legacy structure used only in the first event in the log, for compatibility
> + */
> +struct TcgPcClientPcrEvent {
> +        uint32_t pcr_index;
> +        uint32_t event_type;
> +        uint8_t  digest[20];
> +        uint32_t event_data_size;
> +        uint8_t  event[];
> +} __attribute__((packed));
> +
> +struct TcgEfiSpecIdEvent {
> +        uint8_t  signature[16];
> +        uint32_t platform_class;
> +        uint8_t  family_version_minor;
> +        uint8_t  family_version_major;
> +        uint8_t  spec_revision;
> +        uint8_t  uintn_size;
> +        uint32_t number_of_algorithms; /* 1 */
> +        /*
> +         * For now we declare a single algo, but if we want UEFI to reuse this

You mean UEFI would reuse this struct here? I think UEFI will not use it 
nor will it look at the binary log...

> +         * header then we'd need to add entries here for all algos supported by
> +         * UEFI (and expand the digest field for EV_NO_ACTION).
> +         */
> +        uint16_t algorithm_id;
> +        uint16_t digest_size;
> +        uint8_t  vendor_info_size;
> +        uint8_t  vendor_info[];
> +} __attribute__((packed));

Apart from QEMU_PACKED I have not much else to say here.




