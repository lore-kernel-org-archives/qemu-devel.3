Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF732C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzY4T-00033e-5L; Thu, 27 Aug 2026 07:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzY4R-000335-2p
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:14:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzY4P-0006PT-3u
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:14:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9HsOS3977965
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jo/dlRsPNzJyS28l36QcTtFieUZdm2PBzofeMOaUYD0=; b=dobwrvD28S3aldEf
 eg/QqAbzGjz4gcCzLl+jRT4WQ3rtYdyYqw+qDPp7CDTnQc2lFE3ukjSJa3NOVRYo
 vb20S77ey8fNEzGwDARC1vmZDYDW8oHCmwjLfWz+/6SSto7YJ3+PcuA6k/+KpVyx
 HGWOiWnwF1gevTnNw5z95O/UBaHF1fjIUACo8V9IkRBdqJL1enHc8mo41BFmEfPt
 SJZ++jZD1vpyaTXjeL89Sx7bImY9nHE8aHlTyxoEnxzpMYLA6bbpKPoOkwR8/Thc
 vGvXqYptj4/qHXut3d0ZDp2GKSbtsj5nUD4bpDMcBWnOc9ahdYKxAS1jWg6u27CN
 0W7rAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egkfe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:14:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso185306585a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787829295; x=1788434095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jo/dlRsPNzJyS28l36QcTtFieUZdm2PBzofeMOaUYD0=;
 b=iMqkC8M+8Eer5f9swDZKA1YE5kO5iWo5lCl6JsffvT5+G7Gik1ze+ecQwPluZ8UbGH
 7c8OpgpwnI3z25r+ajlPv1JWRKZlAOow6TUs+dwTt+Xjhw8sUUgT+NOqyVx9iqOZmOwi
 i1TbBrbBYdAsGhNhRTt+f0SIUb/4WDiuE0EKRHtOiUZ+e4rZrxs2wtfd954PY4x+GKCk
 9S4sWJcy9vY79vMpicWSCUskbKTwonK9jED88TPpVPfSr8C+dRFa7NjZdR827B95uZEL
 PSTDMwZnvcyqxn6pCYDToJ4492eLxL6LmybHyYzHXmAlmoufkKA7Tj6mErwifK0Oq06N
 AcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787829295; x=1788434095;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jo/dlRsPNzJyS28l36QcTtFieUZdm2PBzofeMOaUYD0=;
 b=oytChEq64xr7Wzcc/60RmDi63beeFP67g+p/CTjLz/BTi18pLRwVBtO8x+ibuR5AbF
 uAvwixEkWcQ3SDeIEy/crmLCuoNb4EHAb7yBBlTfp4PLdjwG/clzfJlW0smyidKmVLjH
 bjBUjr0W7NUYeENmIOaiGHNf/Coy+fGlw4XNoHniXgtwaDlju3pVS6sNNB6ehvSOMap7
 WVJgo5l4jIjBtT0wrwW5QpS3bBl3hYl6tk6T3aocaBJl3zwZxWk3fm3o00Pn1GxDbG2z
 jQHrmcR+KTu6tE03M56d9nTQtQYAPcZaBFEhJir5iLvhFw1rNOp3f2IZl0S7EwXKDgVf
 R0XQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrL9/Z2WsnLvb6oB6KtJ69XWdGM+TAlfTPyJVHikbX2KOFOVfvcaULPGr2q9EVojsl2b3UaMJGjhPSv@nongnu.org
X-Gm-Message-State: AFuF++kZbl2ZUgSApbiyukUu3Ym+AMU6NxLPIhFA21rjQbTAAN3IBWtQ
 sUqs3e4zbdcyP87lzJu2NujKRnvN0MJy12l13vGMz6YbXfrw221PcKK/bW0HGfdZg0ZdUFiILF6
 sJwH3MPUroucOK0O6iPAJVpe6KcHxeE7m6ncpsZOYB2aAUbX1GOpXiBJ66A==
X-Gm-Gg: AR+sD11/Hy/Cob5yp+DubpyaTcn5o6bdUzcJMTJKVd3b4LZL34a699IZ28aUBY7aheJ
 WG4gORp8dtHNCjuUVtXYCMTTsGNn8xVAE43gowWA/Uz99yNIiaCqdCsXttkUyx/arWKMUSCGdSi
 e2PS3sCe5E4U7y07I/K6QJIwBoMfuaEbELpGR2pJceTHYtylGpQdNo8GPWPEQwIp4KnBpTXA1jW
 i7u5KpYotv2tBSv/XyqzVhLDvFhnUPcDUaOutFDFmh4MgaykWCUQU/TrlBmqlT0sPZuaazxBKBP
 iFRQ3a2K8imNyy/HGCS1IcDGAXqMUwcYW831E+ucYPEo0waSWei5bY1Y+1gmKmEhg4FkCqqIu3I
 mhWjsoPlvA/G/4t/wG6clASmcy7Ln2cuSoACU
X-Received: by 2002:a05:6214:6354:b0:90c:cce2:afcb with SMTP id
 6a1803df08f44-90ccce2b190mr85068906d6.23.1787829294611; 
 Thu, 27 Aug 2026 04:14:54 -0700 (PDT)
X-Received: by 2002:a05:6214:6354:b0:90c:cce2:afcb with SMTP id
 6a1803df08f44-90ccce2b190mr85068526d6.23.1787829294180; 
 Thu, 27 Aug 2026 04:14:54 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73fc984sm14124276d6.39.2026.08.27.04.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:14:53 -0700 (PDT)
Message-ID: <0da0b312-106c-418b-9827-f340a736f502@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:14:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] hw/riscv/atlantis: Remove unused fdt_size
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826220528.54516-9-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-9-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JIgs68wi1e4E0dDxARrPcw-M7MRyTpUT
X-Proofpoint-ORIG-GUID: JIgs68wi1e4E0dDxARrPcw-M7MRyTpUT
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a901c2f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HipSeL5UOqurNVnDHuQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MyBTYWx0ZWRfXx2msEYnYNiLZ
 ej0U1PaZ3dtnihjtA2IZNqomp3y4FWr6mbcrTkHXD7Y/J0yKJWQdBdu9a70NvJPS334lWxuUeIf
 nVGotsdIR1R4qMMJ2JetY1HS9ym+M15sT/2aVMSXaAV3XcfSKky+sK0OqsEYT2arzo1t/Aw3isg
 HQ7RvP98caElko0cXFtxV0u9yj56MoTcXV/zzLphkHK47Z+Ulz29QrPpEbxu9eQsnnst9h/Cdgs
 ebk3g5RkwvssUmC62Hgx3V0dv53v5v00xQIAep/8nvaCArGqGsNE0gGgXOr2eP1LLnXgEcz/60O
 NF4Nn8NKkYiXOI/iq3w3V+iijUQDJqrX5jxJDgyEXohDWJQs8XhPZ/xIykTCX1aP0NnTt1lGeXx
 FnJtRW0u2AqpiScOHtWCc2jPtx4sSDsUYI1fziOOCSuxvW9GYCHPULCkzbN+i0ewvQoTex+zcrF
 MkZu8RVkXKQ9K4uXDIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MyBTYWx0ZWRfX8qSRHLtq2QrH
 SPjL/kTLvYRq0L0I/W1nizeZXydIJo/LEMqq49XkMyZyNeVTOT8yRVludkCkCc6Cgykk+mcV0Vj
 O80smUld5hnks+9WZQ6h9Pt8aUgslfQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/26/2026 7:05 PM, Joel Stanley wrote:
> The machine state carries around the FDT size which isn't used by
> anything.

AFAIK no RISC-V boards are doing anything with the fdt_size return value
from create_fdt() at this moment.  Maybe they were doing it in the past and
we just kept it around.

Probably something we could clean up in other boards too.

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/tt_atlantis.h | 2 --
>   hw/riscv/tt_atlantis.c         | 6 ++++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index c9308aa57017..d0cca3b02424 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -33,8 +33,6 @@ struct TTAtlantisState {
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>       UnimplementedDeviceState uart1;
> -
> -    int fdt_size;
>   };
>   
>   enum {
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index acfd0d31b368..127c89be4f60 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -366,9 +366,10 @@ static void finalize_fdt(TTAtlantisState *s)
>   static void create_fdt(TTAtlantisState *s)
>   {
>       MachineState *ms = MACHINE(s);
> +    int fdt_size = 0;
>   
>       ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
> -                                       "tenstorrent,atlantis", &s->fdt_size);
> +                                       "tenstorrent,atlantis", &fdt_size);
>   
>       qemu_fdt_add_subnode(ms->fdt, "/chosen");
>   
> @@ -384,8 +385,9 @@ static void load_fdt(TTAtlantisState *s)
>       MachineState *ms = MACHINE(s);
>       char **node_path;
>       Error *err = NULL;
> +    int fdt_size = 0;
>   
> -    ms->fdt = load_device_tree(ms->dtb, &s->fdt_size);
> +    ms->fdt = load_device_tree(ms->dtb, &fdt_size);
>       if (!ms->fdt) {
>           error_report("load_device_tree() failed");
>           exit(1);


