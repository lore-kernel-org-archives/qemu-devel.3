Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C774FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVTQ-0001Lv-3k; Wed, 08 Jul 2026 12:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVTK-0001Gh-Dg
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:50:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVTH-00043Z-RF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:50:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLeOM3337732
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ks9kadJ9alUK4TDSu/0ifajH+3ZNUjMYjij47mJ/REg=; b=AENMTwkSRX1udPCc
 HKIdM2biedYwEb1xjAroFNbBkWPNaw8HXlYQ+e3BGZxohszIWoEU3YWIuDkFNgY1
 xS1uGkA5Gsp0otm/oEiBU5iqmk+bn4epI8AKHx72Ez5g8QG4dSNV1Ih3l8KCFSdX
 FXgfaeyAQgPcePorFSZTha4pNh5Ht21f5qq1DXVomj2OXf/CBShWi3G/NjkOznEZ
 g5BnK/UAQjUW4+jc+sC99ogFh2kqSlisZSrALs3aE6t2KMAp5EREBdBuYnB9Yvlf
 WX7wXkRxb8R5ZoIVLUsmTXiZx2VS10hKW1UvT8YA4IlKkVJJy7DVPjEh80RqSdst
 Uo/qVg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssuj6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:50:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88ab059052so42086a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529401; x=1784134201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ks9kadJ9alUK4TDSu/0ifajH+3ZNUjMYjij47mJ/REg=;
 b=JiIINpmiwU+W42peBAdK3VifFia6dSnMVdjhnnRr8Z0+nQ2PC/gB4Rab1Qb0tNAADs
 z3PjWyuxH6873B7YahhtlzePJQeK2CUS0gX1CthgYi86l/0O7l10rXmGA3swm1IBB2Ns
 gXCfTHFmXYE2l9RLscpS9EBgmGVF75MbLe2ksVB1Zl8vCMMrh7iWn4vCt/4EqvjkfsH5
 vPzmR95UiJxW84gecKdQiLp0P5yZvouJovWFyEBhm9t8wLdfxTFCQSa2vH47IJfQRWLo
 7lDLGvr6rLEWJIoGxEdGY/yNfCwPyHoDzvcSbyMAFxT3lbldDVp0VkWVqVGNTz/L+9wR
 FEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529401; x=1784134201;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ks9kadJ9alUK4TDSu/0ifajH+3ZNUjMYjij47mJ/REg=;
 b=QFuDmK7PZX5qJF7/wxu8kM3wkgBsOpdiFYUXE16T0tCbTlpOmiFdRwASqE4ANPhqIQ
 zrRwDOcCmhLOFIyDBRfdOq3aa4skyK7pCHtlMcDjlHFXzMTT9BiOgqjDQmuwrqYScCRR
 EBkIR4dGfxpMpddlqtkvdTSBrVsyw3LTxXwNFqcNxyHanqLSQsTSJOpGTxvNMnwmMg6M
 Lg+CV7A7p5at/PVog/nMLnn/E7C2cNFEu8w6B3FcGcOz2ADERdDZD6T8fnylSaYdVdlB
 kbWCTd92nQVsPXTqsqk3JW4nBI5XLqDaD+yG/BSu5jv1ad/0B01NJm6yqPMZjikrOzN5
 WY9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLbycLqlUQ1eFl28HN75/wpLKESChAkkhHKj7NV4wYvrIzlUtjJ1HOflYH1cweO4knGX/9UzAocdyW@nongnu.org
X-Gm-Message-State: AOJu0YwNIc1xzi3bggx+x8oCXwf9zQw/dbsl/Kav7s21nueC5RfnZjAz
 uh0/A6U2968J8zqK4UqGM+RE0P90dObHRyWu4e5pJKjxukDrzx/irqD9CG/SLAPufFoGQQZzTnW
 AuhAVHpDvOnrUADZhFOPU0TjgzXsWC4Zt9dItj8s4+BPGCuwrW7WzVdqXWw==
X-Gm-Gg: AfdE7ck+V7dmRdKU/79Lb4pBUTK13bVQxjFiFHtAwYrCXLo/KN3wQOhSQhzU7x49GQc
 zrZoJSUD4zgPDcYzGa0lHJno1QcpP0k8IOZjyPicJrGb/BxuiNUyPcVVQNPCC5ERFJ8Xr2K462o
 GNCfskJY71W/uVu4uFqDM3Wtpsu93S8skt0DJisDszkNEdIpA06x9usSze9j6FUvcfH9rsx0uVP
 jD7OErMg5SX7FQHAE3sUf9QWnzpvhyDhRRWLOynjEx5mcD4cDXEMu12DMDqHVaMvG0UnYhrVEKy
 xtS1X+MKoh+p0htQKUN+VV2kfVvlXenOEep0sSm2g8aUThFl0VxdM/3F1aoxi/jAUzEmNSw3BCq
 k4m6Tx4e8GvoHtf4bVmipeQNLzrmXpZVmtApF/CHk+wIErEuUUz/5wnpmH7N5Srg9MuK38/k8pO
 vVcdA=
X-Received: by 2002:a05:6a20:9188:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3c09b017563mr10060626637.11.1783529400641; 
 Wed, 08 Jul 2026 09:50:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:3bb:2434:3d8e with SMTP id
 adf61e73a8af0-3c09b017563mr10060567637.11.1783529399934; 
 Wed, 08 Jul 2026 09:49:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm22971253c88.11.2026.07.08.09.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 09:49:58 -0700 (PDT)
Message-ID: <80008b92-4d89-4ee3-9f79-c7dc93eabb77@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 09:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/devel: Document SSI dummy-cycle ownership
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20260708150038.46113-1-bin.meng@processmission.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260708150038.46113-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e7fb9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=nsNDFm5iVlLkgjshVrsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX/yOCLmqzNKCS
 VMWAdm3DtNdjuAsCKU5gcYC9k+zmA/aOI7BijsWGW4Ar3COaeeazED7fzjpB0sfDSMHvwoeFB3s
 HY30KERL0iDaW6oGylejHCyuUTZ+Ro0X+tsuXTolTiANtnFU58QvlFcDvY/ng/yyuTsqS8bMpqn
 xXGgwFhMCyMkxmplyc0iZwpEwCFQAEbISUY6vPE2yPArj6EkBVKV47Mksk3+J0GdCSUxxPlYcUg
 bpu223qOOry6H2YVUgmBRSai9b6OKki3PhGfnUm/IsiiKIDQvkw3r8pzuJ/u9Z8ihfc9uYbvkQV
 IY5RjaPOXvcPy1SOSKdRfpkOTOsCRNPrsKW/QDlnSgMZT86yT4vKHBn4JBje45k2Pjx5SvqObl1
 YxqaEnAZ3ORG1me2koieZazPDcKyyN2c3NHcHJeTwI0jcuPOy/ukqLrhDv1100LblN+QfFBxRvo
 TwrDorS6DQW4HGx6bZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX86r+01LXOqEE
 9zBRTB9DetCzUvYaIVqf7L9QH9PbZmN+HctE1E6V16ove/TBMuIYY2vrwW+W/Cc1g5ZgOV+4VsD
 R9gvSUPD61jQ1goODoYSNgfI8FbZx/Q=
X-Proofpoint-GUID: OyNLtY-OP-AFoSJUVh1TDfQyw-qEBvaU
X-Proofpoint-ORIG-GUID: OyNLtY-OP-AFoSJUVh1TDfQyw-qEBvaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/8/2026 8:00 AM, Bin Meng wrote:
> Document the boundary between SPI/SSI controller models and SPI flash
> models when representing fast-read dummy cycles. It explains that
> flash models own command semantics, while controllers own
> hardware-generated dummy transfers and cycle-to-byte conversion.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> ---
> 
> Changes in v4:
> - fix checkpatch ssi.rst warning
> 
> Changes in v3:
> - fix checkpatch MAINTAINERS warning
> 
>  MAINTAINERS                    |   1 +
>  docs/devel/index-internals.rst |   1 +
>  docs/devel/ssi.rst             | 134 +++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 docs/devel/ssi.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..77ca6e6c31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2347,6 +2347,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
>  SSI
>  M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
> +F: docs/devel/ssi.rst
>  F: hw/ssi/*
>  F: hw/block/m25p80*
>  F: include/hw/ssi/ssi.h
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index b89bab9b30..a8f5e310df 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
>     reset
>     s390-cpu-topology
>     s390-dasd-ipl
> +   ssi
>     tracing
>     uefi-vars
>     vfio-iommufd
> diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
> new file mode 100644
> index 0000000000..7475d7f241
> --- /dev/null
> +++ b/docs/devel/ssi.rst
> @@ -0,0 +1,134 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +================================
> +SSI devices and SPI flash models
> +================================
> +
> +QEMU's Synchronous Serial Interface (SSI) bus models the full-duplex transfer
> +of words between a controller and one selected peripheral. Most SPI flash
> +models, including ``m25p80``, are attached to controllers through this bus.
> +
> +This page documents the expected boundary between a controller model and a
> +flash model for SPI fast-read dummy cycles. The boundary is important because
> +many real controllers expose dummy-cycle configuration in registers, while the
> +flash model observes only the byte stream delivered through ``ssi_transfer()``.
> +
> +SSI transfer granularity
> +------------------------
> +
> +``ssi_transfer()`` transfers one SSI word. Flash models that implement common
> +SPI NOR command streams usually consume one 8-bit word at a time:
> +
> +* command opcode;
> +* address bytes;
> +* optional mode or continuous-read bytes;
> +* dummy bytes;
> +* data bytes.
> +
> +The SSI core does not model individual clock edges or the number of active SPI
> +data lines. If a real transaction has a dummy phase expressed in clock cycles,
> +the device model that generates transfers on the SSI bus must represent that
> +phase as a number of dummy byte transfers.
> +
> +Flash model responsibilities
> +----------------------------
> +
> +A SPI flash model owns the command semantics for the flash device:
> +
> +* which opcodes are recognized;
> +* how many address bytes are required;
> +* whether a command has mode bytes;
> +* how many dummy bytes must be consumed before data can be returned;
> +* manufacturer-specific differences in fast-read command behavior.
> +
> +For the ``m25p80`` model, ``needed_bytes`` is a byte count. It must not store
> +raw dummy cycles. When a flash datasheet describes the dummy phase in cycles,
> +the flash model converts the cycles to bytes using the bus width used for the
> +dummy phase::
> +
> +    dummy_bytes = DIV_ROUND_UP(dummy_cycles * dummy_bus_width, 8)
> +
> +For SPI NOR fast-read commands modeled by ``m25p80``, the dummy phase follows
> +the address phase width. For example, output-only dual and quad read commands
> +such as DOR and QOR use one line for command, address, and dummy phases, then
> +use two or four lines only for the data phase. Dual I/O and Quad I/O commands
> +such as DIOR and QIOR use the wider bus for both address and dummy phases.
> +
> +If the exact dummy phase cannot be represented as a whole number of SSI byte
> +transfers, the model should round up and log the limitation instead of silently
> +treating cycles as bytes.
> +
> +Controller model responsibilities
> +---------------------------------
> +
> +A controller model owns the behavior of the controller hardware:
> +
> +* how guest-visible registers select command, address width, bus width, and
> +  dummy-cycle count;
> +* whether the guest supplies dummy bytes in a transmit FIFO;
> +* whether the controller itself generates the dummy phase for a memory-mapped,
> +  direct-read, or other automatic transfer mode;
> +* how chip-select state changes around controller-generated transfers.
> +
> +When guest software writes dummy bytes into a transmit FIFO or manual transfer
> +path, the controller should pass those bytes to ``ssi_transfer()`` like any
> +other guest-provided byte. It should not add more dummy transfers on behalf of
> +the flash.
> +
> +When hardware registers instruct the controller to generate a dummy phase, the
> +controller must emit dummy byte transfers before data transfers reach the flash
> +model. The controller should convert the configured cycle count using the bus
> +width that the controller uses during the dummy phase. For example:
> +
> +* 8 dummy cycles on a single data line become 1 dummy byte;
> +* 8 dummy cycles on two data lines become 2 dummy bytes;
> +* 8 dummy cycles on four data lines become 4 dummy bytes.
> +
> +The controller should not duplicate flash-specific opcode tables merely to
> +guess which commands need dummy cycles. In automatic modes the controller
> +already has enough hardware configuration to know whether it must generate a
> +dummy phase. In manual modes the guest-provided byte stream is authoritative.
> +
> +Avoiding double counting
> +------------------------
> +
> +Exactly one side should generate each dummy byte transfer seen by the flash:
> +
> +* If the guest sends dummy bytes through the controller, the controller forwards
> +  them and the flash consumes them.
> +* If the guest programs a controller dummy-cycle register, the controller
> +  converts those cycles to dummy byte transfers and the flash consumes them.
> +* The flash may know that a command requires dummy bytes, but it does not create
> +  transfers on the SSI bus.
> +
> +Do not implement controller-side snooping that watches manual-mode opcode
> +streams and injects extra dummy transfers based on flash opcodes. That mixes
> +flash command semantics into the controller and is fragile when flash models
> +gain correct dummy-byte accounting.
> +
> +Examples in the tree
> +--------------------
> +
> +The following models illustrate the boundary:
> +
> +* ``hw/block/m25p80.c`` keeps fast-read dummy requirements as byte counts in
> +  ``needed_bytes``. Manufacturer-specific helpers convert datasheet dummy
> +  cycles to the byte stream expected by the model.
> +* ``hw/ssi/aspeed_smc.c`` generates dummy byte transfers for direct fast-read
> +  mode from controller registers, but manual user-mode writes are forwarded as
> +  guest-provided bytes.
> +* ``hw/ssi/npcm7xx_fiu.c`` converts the direct-read dummy configuration to the
> +  number of dummy byte transfers sent before reading data.
> +
> +Review checklist
> +----------------
> +
> +When adding or changing a SPI flash controller or flash model, check:
> +
> +* Are dummy counts stored in byte units when they drive flash state machines?
> +* If a hardware register stores cycles, is the conversion to bytes based on the
> +  bus width of the dummy phase?
> +* Are manual guest-provided dummy bytes forwarded without extra injection?
> +* Are automatic controller-generated dummy phases modeled by the controller?
> +* Is flash-specific opcode knowledge kept in the flash model rather than copied
> +  into controller snooping paths?

I'll let Alistair pull this through SSI subsystem.

Regards,
Pierrick

