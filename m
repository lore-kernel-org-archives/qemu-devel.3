Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7A606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QgveBur9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FuXlnFKM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRxb-0003fm-BV; Sun, 01 Nov 2026 04:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRxW-0003ZT-M4
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:34:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRxU-0005uK-L0
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:34:38 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KSp4916661
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5q5X5sebZv4uCqvkSFfeVqudf7kKDA65y3myxtNMNbg=; b=QgveBur9KfbpxuL7
 j7tKb/Gn7aGJlb6MLEOTHDuZ8X7vdJHls2sbMPikeHrDbhhvd2+YwWP7UtNvQpzs
 CdduyntQW72KUB/8DQzeIoOqzXa1kCbYeumf4Td3NC21y5JvNj9eYyOGPx/vczDC
 lWw/S955FipAyV1eAmnDbWn7geErgzYl0IN8tgZ2aEVLChL3xxjbERB8F/jOKK/V
 qEOIEjRMoKGXa9ZEs6n4mws3mdcB/E5CQgqOAFk1Sk44cDbj8XdN/bZoOADfTpEN
 /1MYJGfo8JqIO5ECWxH0B3kuBtBEOaWlWqH7rwZxH3/E8WToOP6TibcYn1fY/1fn
 65WPpA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6k6x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:34:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so41155296d6.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525670; x=1794130470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5q5X5sebZv4uCqvkSFfeVqudf7kKDA65y3myxtNMNbg=;
 b=FuXlnFKMVypcIlXSrmwj+NCzG0Z1rG5yrsKDfuwUwswf+ae4oahJ3Vu7ssFdLQGdoY
 PTGVSKXEFYkmgXiwu3EwmDJaoi4vaA1gYoUc38VboOAoGtX1VWlfToo2bdwvPknKESKF
 7BpcoLv+l9pdWhT6Um2lZhsP0wqKYqJh5EEzHlC2By4p6APrpRU8CRAvaGNkdvyIxW6I
 KMSCQ4tybAwxcF/ugc015T4UmQt2oUB0wV2PaVAhUBjeNvrvul3xGnYLRfip1KXda2Mr
 Vf/m7+piWgzZoV5becLpycic+hTf6TaFbcLbRbiuUTxiXMHdOzTd+ZjsQW6famlnPzcJ
 IKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525670; x=1794130470;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5q5X5sebZv4uCqvkSFfeVqudf7kKDA65y3myxtNMNbg=;
 b=YSzUocTNqf9U+3C5IY9xGkSbehTG+hw8r90c41tPk0Ak6v13JAsKo4C89MC+MDo3q7
 H6UYDlMk5/a9MTyVV4ArkRxMrGpRrjAMOqYIoaJkcPzU2mbfgispnaXkitMxX6/PXx/A
 GZ82Zx9PeDAGHuFgG7ylmQSFLhkdHvde+5v31pQNiFCLPwyy4yi5+1DF5TQLcxozOxrg
 HPjhzN/w+Ec0jaBY4kNYYRlqzEoLciwkuEG0M2TrRj96O1DF9OX5Nqcbg6Y5oYGCZGOh
 RGUNak6d1lJIZwgRVXoJ1bgyTmcs5PtY+9iTDgf/ZQZLSxmXiXsp3xRP5lEhiMp89kON
 x4DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq2RyV5qy7uPkmscWqf2oYS/HpRX8pB3BPkkCkLT+fxXF5HM6Sjv6coO30rr7T3RF9dIQnzZ33Y+Th@nongnu.org
X-Gm-Message-State: AFq9FYKKFWPSvVGtIkVssxpdWkmcqKgGHhfyEh6jwG1ZORS95ou/gOrB
 GAFkCYezduHRRCR9rtRanTRoGXay5ysm9X5L1u0yyNsUjo53/pTMgRjeRLsbfevTMVg40fsA4Fs
 kNLFko4Mg8+WbnpHn+3lrrKirRHBgTRA3wAzkXu+iaBmGvUNmI+d9B4GojA==
X-Gm-Gg: AYBFou0iKeuvnUZRYlZ7DDbkFS6Bw2649ktaGYJbOqs+4VvGQ7+H947SnsZaVpfUU8R
 7+2uEaL5Rb+i9t4KZgWzOqhY3oDoWh8X4Gq3uEBPk42tcG6gYUo9hxBFLTKTdMuKXBoGwWmgDBp
 zIjb0gzgL6U0njb+VL8sD9eJfPq6HCXYCuzQCqJu8rFACNw27wqxOsnNxpkX+NLkoIYs79Z41GK
 tFhzCKhCf72343Bh67yibHxM7119exvcBeZoc91OsOpIqLxlOYhEB8NvfMD8mFXVdSY6HYKTjc7
 zSI8Ypugw0JPCcWgLrgzcXqSTyJYD921xq6d93nIt3qkLpSYexHVR9DU8LuO4KKFzxJ5oLNcbeP
 9PU2kYTbi/5rubi6fX4ZZ7nHgDw3fug9lSFbbS6S9bE2KxrYGSHRcb3VBTGfF2yjWSx7FFu5nWF
 Oz5Liz9II8
X-Received: by 2002:a05:6214:d49:b0:91c:6386:eca5 with SMTP id
 6a1803df08f44-91ca4b2a6c9mr115451036d6.30.1793525669893; 
 Sun, 01 Nov 2026 01:34:29 -0800 (PST)
X-Received: by 2002:a05:6214:d49:b0:91c:6386:eca5 with SMTP id
 6a1803df08f44-91ca4b2a6c9mr115450786d6.30.1793525669386; 
 Sun, 01 Nov 2026 01:34:29 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca8068ca8sm62740556d6.36.2026.11.01.01.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:34:28 -0800 (PST)
Message-ID: <547da4dc-c434-41ef-bf3d-24c419c28b7c@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:34:25 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/riscv: pfsoc: Default Icicle Kit to five harts
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-23-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-23-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1HbdrCTR4Y6yE95pwMR4NDFeAmGs_9_z
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae707ab cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=I3NZUf3FJzrWW2FUEREA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: 1HbdrCTR4Y6yE95pwMR4NDFeAmGs_9_z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX4OlJ+QgyBXDe
 q2UqFYc4u1UyUcahBiGwa2/dvmwUdplibRSDGmObhT/Ke2yrOHm+LLf7khztHQjKYbLpFwRnGvc
 QlMcPw7iCORHqPC0235e1pnnjHLxgP8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfXz+NuIemvcGQ0
 8j68aa/gPr5si5yMUr2SgjrJ7bctk26D4aAruTkyskX2G1+HsXoRWftQDA9Vlo2PbGiqogglU/y
 3I4hklk/56nGbEx0qa19PUCJFh+8tBoyin3BPTrfcTml1AuZeZjKrX33e7Xchy6eOqxqGIU1mha
 bzjF7mjwThrUBfa+GUVkoE1go2lZJyCXREXWG9ff8o9LWsmNTN1tLqy98XqGuOHwS4ptWn35wsp
 QESBvf3DX2EHYelu0vXvrb4YzI1aa7IgWYEHq2v/tYYO6OdDQKkaTeT2aDuJDiST/EGxlur/R6w
 A/lYYYdNt2LcE1RA6hEfVbAOGEaWympRtCf1KcUHi6xhsxOD3TWlDljGfWDzfZfDERFbqnlb+KR
 2IBu+wRRNpKTIUmbM9RsOwU//NCD+Y050t5rNbMFpL2bsp5wYjQnf3BDmZDQF0GeNKeBpllFxIj
 wVLrPS0wJx//WCOf6TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/13/2026 10:23 PM, Bin Meng wrote:
> The Icicle Kit contains one E51 management hart and four U54 application
> harts. Defaulting to two harts can accidentally boot firmware and a
> device tree that expect the full five-hart topology.
> 
> Default to all five harts, while retaining the existing two-to-five
> range for users intentionally configuring fewer application harts.
> Document that firmware and device trees must match the selected count.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v3)
> 
> Changes in v3:
> - Change only the default hart count and retain the minimum of two
> - Document reduced topologies and matching firmware requirements
> 
>   docs/system/riscv/microchip-icicle-kit.rst | 3 +++
>   hw/riscv/microchip_pfsoc.c                 | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
> index b0ad24f174..138289a913 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -27,6 +27,9 @@ The ``microchip-icicle-kit`` machine supports the following devices:
>   * 1 SDHC storage controller
>   
>   The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
> +The machine defaults to all five harts. ``-smp`` may select two to five harts,
> +with one E51 and one to four U54 cores. The firmware and device tree must match
> +the selected topology; the HSS boot flow below uses all five harts.
>   
>   Boot options
>   ------------
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 855c719f76..9d8e5916e7 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -752,7 +752,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
>       mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
>                      MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
>       mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpus = mc->min_cpus;
> +    mc->default_cpus = mc->max_cpus;
>       mc->default_ram_id = "microchip.icicle.kit.ram";
>       mc->auto_create_sdcard = true;
>   


