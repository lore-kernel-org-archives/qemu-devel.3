Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A68C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC8S-0005g3-P7; Tue, 18 Aug 2026 01:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwC8Q-0005XF-Gz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:13:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwC8O-0003vU-RS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:13:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I2YP093761859
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1OrLRRD5wuUCzFWAZtuM4rtw63ebB47e90Wx0muSfaA=; b=KAIbrMJwAHAGG05S
 OpaCpnUXGPY8rJ/u7JmaZv33Z7uey/ZT82fYnTqMyg3zNnwDc+yqUfK14ktK98NE
 6A7cgJjUULy79uV0bZaMRf57wgURpkSUNSZuJkcZU4huk0iJMaJvvV5MDB8Sa7kc
 8LsjnL8bwEZt7Bi4M2DVHlYMdwQkd56qKu5GJQ9ws/vMnKgFgAC2bnxREEsUnMTY
 PtSTcJzzxKS/8ytvr0aZdx1do06rJSdCHIQOhGDCmYHeICfXtxvCxH0UcOVtoJAL
 tTccB4f3H1tpIFAF6sTxUiYGLKBEoc0mtdCK+UIMX3Hs8ngCY4ohovCiBLr1KfjE
 uQFO7w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtrhyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:13:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so57602391cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787029990; x=1787634790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1OrLRRD5wuUCzFWAZtuM4rtw63ebB47e90Wx0muSfaA=;
 b=JkRJ8xrIpRn5qwJZwamIKWjJ3W3bqhZcO1YiNwBaX9rQCie7p3Vftz6L/xOXdkmXG1
 DkjNqaRZ1D88s9E6ak+DXXRVrPkOO4/kgutdt5mSc03mF76Pp9santR/EBJ+cNLGhY+p
 Ji5Re99Ul8O8RYiZeMp2sks79bjYiJ9wC0n4abQiqMGEmyTeVUcJyDcNt2RutskN3Nw/
 d0+TmE/Y14V6ta06vZZpNTaCalBUcBXZ4Lk3K/k+nwpAcLAcsuiUJr3jT4s/fZuljBAg
 DlUclYG7WJXJ+yrnES+022wdIrcmvp/5BZfqfy0f0jerJOEL4Lxk6mnmlN2k22xE9Naa
 4rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029990; x=1787634790;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OrLRRD5wuUCzFWAZtuM4rtw63ebB47e90Wx0muSfaA=;
 b=jf5QxZvxMRBxE4DRV3Mkyvtv6QZZN26MyCiqoaHpWuOz+2TB/kjYljZiBgIqVi0Chn
 R070r373y+H+8KbYzZ8G3EyWljaD6Xz3kAWIltn6nZWTM9lv/HtLL90r/kjrLCV5oNzw
 /m9rRwMaWRz8iLyMlu0kr9jCvvIQQe/5iM2pYPoa3jHiaNB9EyvHkRf27EcbrIEshWU4
 aS59lJDI/KA/UVkqlwn1VIxeqs00WWiD7EUSE5rPhQ/41o4dnIKFerpOHzC2b3AR3TzG
 uw0do1eyAUL0vLNL3o2KcO8RgKTMLeJYBQK9yasyOZCvkCntAOreSp7jwRc/jog10iRV
 blAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCXXEF0ak75sbijALVKrLnyJFlKxxKKvRRL5xSDhQhZJY5APcjyKepG6Rvy9MRAUT8ByAuFcu9wbkF@nongnu.org
X-Gm-Message-State: AOJu0YwVS2XvXMERhfkBNvh/zb+JFezEjKWVy/2tkGt9+0LZ3llpf979
 tfpQn+CC5vGz7Nj+HRWvGqucfI+1ypPT3gbZ3wvA1GtzZsmzQoOIXseqJbzyNfUL3B2Izn4BRFm
 BbvzXBVoxFsbGuehkg538ZxQtMvbPXvsDZzHineN4FYCDfAmqW0vJPPWteg==
X-Gm-Gg: AR+sD12BL2iQ4B1S7hGoo4wdEct39SA5N1Apgkmf/pdOxK4rVYtbSZ6Al/NQLQtKQ5U
 2BU9M+9TGVHrpMtj1kUcmp/H3W0T29CLIq4WUvdGMvRd2dNpLP/iCP3pwMKJGguDXlvSumBhRA/
 +ksVD0qkp7aDLvWutyrDZYg54gCkbTBR309v5l5gf7zq+hAfmbRvEYy0zzggl4K0ETI/xnDTOby
 gw2YcwTNUc7IS4aPLQR7ON1mHgpekJL0mWqOf6kOy7rkkGnPXh/B0irFWeKnzyLWggUxtzpPOkV
 P/0E4BdZg1VmdkZilFqagZlpRS+RE77tq/cRG0VGh9ihzGHyRyyxm7Jdyo1G6bO3/W0W1VaMfEV
 kLIkFAEEY2GoFXE3VsI0z/sj/Z5daGyr3cAM=
X-Received: by 2002:a05:622a:1304:b0:51c:555:7dea with SMTP id
 d75a77b69052e-52d8549af33mr318883721cf.30.1787029990271; 
 Mon, 17 Aug 2026 22:13:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1304:b0:51c:555:7dea with SMTP id
 d75a77b69052e-52d8549af33mr318883461cf.30.1787029989811; 
 Mon, 17 Aug 2026 22:13:09 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b896sm9347395f8f.16.2026.08.17.22.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:13:09 -0700 (PDT)
Message-ID: <d1b31369-2bc0-48c9-b34c-9e6c6b1012f5@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 07:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] hw/ide: revert the CHS translation on a hardware
 reset
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260817205242.1199851-1-den@openvz.org>
 <20260817205242.1199851-14-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817205242.1199851-14-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfXzKosqZqA8lPC
 9wqE2V0q8jIldjWX3OZfnmiZ1QUO1lEsAQrshg5fqaRmlaKj06ObdM07sWWJO0N3at/gJS4r03c
 WUx/rqsoRwQJpQPHb+VP2sy1avTb0vQ=
X-Proofpoint-ORIG-GUID: p7PnR1bZSUBPQusuzCKBDT5W-bdGBv_t
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a83e9e6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=C0JQNRP7iAIswsPoYdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Hx1yvPaMooE3kwe23bt7:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: p7PnR1bZSUBPQusuzCKBDT5W-bdGBv_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX2nhWZ3udx22h
 7JeBR343DrsTD+OeB0p0M5bHhCow6/LceJav8mtJINWXeOa/pcB0rMmgl3jauEgEF3026nChvwq
 PlD8BQHXOanPOWPFxwRb6vzPYV1PyLJpTB0R1C+9mfUShY+FOMZRDBj0EoOTaBust3zWquZBGgz
 GQHQCrZ87niUn7t34X0kON6CcqOswma9Rvl7u0UIQKl0E5SIx+JZN99nxQIrpv9Ki6Aj/G+ZPzz
 pfWIf7OtL0a88pS33/f90r3nlpu5tHrlWThP5rmfXvpb7WFuguYxBxAhaIQ+2ZV4iLJx39BYJSl
 dgPqOKtTsL5T5lpuPssKGmR8EJkxx3oH1NjCXZz+QzBQeD+/eW63QCmv3uvBrteyEY/EdyBrU7n
 0fx6IUGcMkdNzJD1tTdY+OUCuHBv81+UJDZ0nVmTILNmL+dFg5TZJuRVHKgevtveTeeKSrai9i8
 4iFkIbSodMn+ucU9MJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi Denis,

On 17/8/26 22:52, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A power on or hardware reset returns the device parameters to their
> power-on defaults (ATA-5 9.1). A software reset keeps them unless the
> guest asked with SET FEATURES 0xCC for the next reset to revert (ATA-5 9.2
> and 8.16.6). ide_reset() applied the second rule to every reset, so a
> translation a guest selected outlived the reset of the machine it selected
> it on, and the guest that came up next addressed the disk through a
> geometry it never asked for.
> 
> Neither ide_reset() nor, for AHCI, ide_bus_reset() could tell the two
> apart: a guest clearing SRST in the second host to device FIS of the
> software reset protocol lands in the same ahci_reset_port() as a COMRESET
> or a reset of the host adapter. Pass the kind down from the callers, which
> do know.
> 
> ide_drive_pre_load() stays necessary: it restores the same fields, but a
> vmstate cannot depend on its device having been reset first.
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/ahci.c         | 12 ++++++------
>   hw/ide/cmd646.c       |  2 +-
>   hw/ide/core.c         | 18 +++++++++---------
>   hw/ide/ide-internal.h |  7 ++++++-
>   hw/ide/isa.c          |  2 +-
>   hw/ide/macio.c        |  2 +-
>   hw/ide/mmio.c         |  2 +-
>   hw/ide/piix.c         |  2 +-
>   hw/ide/sii3112.c      |  6 +++---
>   hw/ide/via.c          |  2 +-
>   10 files changed, 30 insertions(+), 25 deletions(-)


> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index c330508128..bd155f8d3a 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -1347,7 +1347,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>       }
>   }
>   
> -static void ide_reset(IDEState *s)
> +static void ide_reset(IDEState *s, IDEResetKind kind)
>   {
>       trace_ide_reset(s);
>   
> @@ -1356,7 +1356,7 @@ static void ide_reset(IDEState *s)
>           s->pio_aiocb = NULL;
>       }
>   
> -    if (s->reset_reverts) {
> +    if (kind == IDE_RESET_HARDWARE || s->reset_reverts) {
>           s->reset_reverts = false;
>           s->heads         = s->drive_heads;
>           s->sectors       = s->drive_sectors;

The change is good, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Still I think it could be logically better to rework ide_reset() and
use IDEResetKind as a IDEResetLevel instead, having IDE_RESET_HARDWARE
the higher level. Anyway just thinking about it, feel free to ignore me.

> diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
> index 281d07c9d5..094772209d 100644
> --- a/hw/ide/ide-internal.h
> +++ b/hw/ide/ide-internal.h
> @@ -393,7 +393,12 @@ extern const VMStateDescription vmstate_ide_drive;
>   #define VMSTATE_IDE_DRIVE(_field, _state) \
>       VMSTATE_STRUCT(_field, _state, 1, vmstate_ide_drive, IDEState)
>   
> -void ide_bus_reset(IDEBus *bus);
> +typedef enum {
> +    IDE_RESET_HARDWARE, /* power on, hardware reset or COMRESET, ATA-5 9.1 */
> +    IDE_RESET_SOFTWARE, /* SRST or DEVICE RESET, ATA-5 9.2 */
> +} IDEResetKind;



