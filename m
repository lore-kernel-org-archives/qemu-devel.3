Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB59C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzH7p-0003cY-T5; Wed, 26 Aug 2026 13:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzH7m-0003cA-ID
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:09:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzH7k-0006gD-49
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:09:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGupig343497
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kh6MRvq+JUDptROKpj10YKRN3GCbaSRAo/cL83AXRH4=; b=U1Rd9I7QmrwXnWvh
 a82EbyW+KYgm4xmDaWjQoo0XPzdZM2CwBeAS7D1hRQLSTPyfyjxwHL9TjcRT8K56
 HyEyrlWxAiZ461XwOPmWxyADmEzcl/jSB+yTpb3gmiiEoL1JMS688z92L25ZiT12
 mzIF6QaaaOC34k6zlLqptm5CJP/DQ0jseRaY6FzDll8f6hizOjPiTSzImC7J5S+o
 BUf5q/dIDJVI79e65GqiKn5EiccovtUUHIPkvk4hHf5UKyDdPzWUnhNYR9yxi6CK
 bGXkMRxTSkXJ+mo/mB0EyY2/l1rT/1QL2xxPAmUIG5eY2L89eLM64A7otoNYEzAn
 Gxa48w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9utht80d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:09:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52dcf1bb6e9so927071cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764154; x=1788368954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kh6MRvq+JUDptROKpj10YKRN3GCbaSRAo/cL83AXRH4=;
 b=cLz/uGNDLUyThPCT6pTV+PRM9r/gnWJ/D1NHobMiU3/FaVGm4ahwvpYGDBVggaCPFf
 JY8NW0b7brmUFliFNBLCnGNxtITHtZokuJ1r3kb1kLWv3e5no0W7uVDbFZtS8nqSjTZm
 uNufwnz/DHzR4h3lc9Elcv+OBUnJcxaCXdhy+KZIhL4BCl2IG8YosF8bpdisDUhqfdJz
 SrfT2ZTq355DqB953+9Qh1vL5n7zehMF/L+BCQ4ntfQ7UoZxmlc6LqkWk/tmXPtC1HfQ
 kv3pjucZl+GpORhMwunhPaBnO2OfBybDNJSpcJI3fBaX4HfFfMV7qG4ZLDn9bzVXtae5
 Ki5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764154; x=1788368954;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kh6MRvq+JUDptROKpj10YKRN3GCbaSRAo/cL83AXRH4=;
 b=ixPW/q3yntk8X+JoTnRm11YzJDzQBw5r0UuiBKQSN5a+1IvwvW/MuafKGICG9smMaX
 GsYUmbxGrtd5k6JfEGTDkASoLaM6EbEBvcYrRt3Vb1ygiXrcejLob4SpT4I5SPEx5jiF
 vC+pHV8M5e7CKxyfYB2Py7oWRy/KDIY0/zcxNIHvjd/Dw+OKphMguzVcGr0o0H0GHDwB
 cY1KjouxR5D/voB24IP+LzHez2POwEQTVdamSs9uP/TgubUhCLVRyih09uESTeFB8v9G
 CLBe0c2lugwrUH6pYIVQeaVp6o5Elff68FUyqcSQkz5bokCeyMo8jcEJr6XGjMa7nZKD
 mvhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6b7pvAq3q6V6Z45LEsU0N/uJ4deJ3nOOH/bQ7kA+SBb22I1usq8CDXLAUGJo7IWHuhGwVbKvaz0UM@nongnu.org
X-Gm-Message-State: AFuF++kMF0ua8wwsgheup7cmXKS0nzBFn2dwsgRMRmVnjuMTfhTqMq/l
 usGxra8bbKjKb2eILmv7BmU430NugRpT+0Vo+utxk9MRY4WwQNmjjfJVvcSMPVdIU9iTod4DhVG
 pvC16c+jNo5c/KGS/WLUUS7kFeJewQoM5s56SDU6szA7naeuc3ZRtbCRv9Q==
X-Gm-Gg: AR+sD13Ei0C8Zrt4Nvi6zJKyiM4gDqmPLAD/NO87jFNfIEfw5vwBTJ8cYMrDsBSbq+w
 qgI4VuU/1qnBXrOWW+NY0YeETAqZGjo3yIdiVAoTzLmdv+uPjJRLSc3GcwO1lC/VUz8g48Ik77+
 HewZlODqJ3FtDRUIq4WH/V80EG8yfQFYofNgUMj9UQ9vcCv7BnK0b5/mqRC7TooXfmu77Xamh0T
 UiTTLl6xRH6Co5Hs3Wk99nSaQuqS+uChVkAj40YW9spTQUx/IUD3iVEFNaXZX3GTjzY7Y2xiUDt
 IVzUe2mRQivEz7XVf4cMQ1SBICbuGBDDEK2REb/EvVVVuaxvR+FZ4aSQvdT5h4mddn+/Oc/aKPX
 YmXD7Ycz5dJSCqa0d8eYIueuUlSIaxuAPKQNzNc5A/pU=
X-Received: by 2002:a05:622a:4d85:b0:528:ce0:e9f8 with SMTP id
 d75a77b69052e-52fa1a4aaa1mr8463551cf.3.1787764153710; 
 Wed, 26 Aug 2026 10:09:13 -0700 (PDT)
X-Received: by 2002:a05:622a:4d85:b0:528:ce0:e9f8 with SMTP id
 d75a77b69052e-52fa1a4aaa1mr8462771cf.3.1787764153082; 
 Wed, 26 Aug 2026 10:09:13 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b106dsm675324466b.43.2026.08.26.10.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:09:12 -0700 (PDT)
Message-ID: <07620a7d-592f-4fe7-8da3-aed6959bb1c4@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] hw/riscv/fdt_common, virt.c: add
 create_fdt_pcie()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-5-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-5-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f1dba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aMASRZD-tIQv_IvYdFMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: V9yfadZ2p5UC3ADZqrC_8931Jy-V-G5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MyBTYWx0ZWRfX4zrdvlx/PEb1
 MqO0yZpcYKy9zta9gOHH4ZymK50tmnbOnVVuUB43bGqvoh825AdixsML+W6aSJPU31OTuRBUg3f
 or+OCBaqyCtLwcBDIutBlOwzNesHWRgoMmXXaN9hX4hGeWTbqWh2rcPCQkZM67RI9RLmS1IwsDW
 e9lvZ7O50aZFCe4s5TqfXqBsKAsy7xu/aKxK0QKz+bBX6ZYR9L079jz4k2OvXJVVcFcqKpxxAnh
 ChdJJ56QTzi5wBaYeueWV3Hq+B2Ah0CG/kd9vYd0fuxu6xvFpemcGY4OPFrPk/QuhDl+sIYyzc8
 Oszg0e+7rEV8lUVUfH/kN9O81XH2+eXlcNurfGDBEOvt3HQJDaq6DK/LXHvLIa7K8glSi/pWLJK
 85kHcuiIKTMHJAR/N8xIdlQCDdy36iHh333CBPbQCFh/U408UxRCX7eBP6vaeR8CSf+AcM/3vLv
 JZI4EpYtrf/c2aKzbtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MyBTYWx0ZWRfX/KdLPsFnWEB6
 00yyUlZJ5BhlhuOfod6wokvr7lzBjexFXSGNteMKmV9P3ESkoIg9qjb6N69gHYtYIEiC+xAAaye
 XyxjjyTROzOOt4Nfnyf60DtLGrzsozg=
X-Proofpoint-GUID: V9yfadZ2p5UC3ADZqrC_8931Jy-V-G5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:
> The pcie FDT is quite tedious but can be parametrized into a helper.
> This is going to benefit only the 'virt' board for now but it will be
> used by the 'riscv-server-ref' board in the near future too.
> 
> Some other changes made:
> 
> - FDT related macros are moved to fdt-common.h.  Only a couple are being
>    used by the helper ATM but more will be added in the next patches;
> - an RISCVAIAType enum is created.  There are several FDTs that depends
>    on the active AIA type being used, and we want a way to represent the
>    different AIA modes that doesn't re-use the 'virt' specific VIRT_AIA_*
>    macros.  The enum vals are equivalent by design - we want "s->aia_type"
>    to be used by 'virt' when calling the fdt helpers, and other boards
>    will use "AIA_*" macros in their code.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/fdt-common.c         | 108 ++++++++++++++++++++++++++++++++++
>   hw/riscv/virt.c               | 108 ++--------------------------------
>   include/hw/riscv/fdt-common.h |  26 ++++++++
>   include/hw/riscv/virt.h       |  15 -----
>   4 files changed, 140 insertions(+), 117 deletions(-)


> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 37a1544706..bee8b85597 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -11,6 +11,27 @@
>   
>   #include "target/riscv/cpu.h"
>   
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_PLIC_ADDR_CELLS   0
> +#define FDT_PLIC_INT_CELLS    1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_PLIC_INT_MAP_WIDTH  (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_PLIC_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> +                                 1 + FDT_APLIC_INT_CELLS)

I'm a bit suspiscious these numbers will always match for
any machine. No objection although.

