Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F79EC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cl5-0006g7-Dy; Wed, 02 Sep 2026 00:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cl4-0006fF-Dd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cl3-0008FE-28
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824NS6a4097961
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OtG8FSr3PPasaeHBO0ZnHSCsLxE6pb70O4YkrDBc7BU=; b=eh+cA5T3hg3QFg0e
 ADdGiZRZvZ7i82m1MI5v9i+bIZTfR0HKW9ekzH2iCc+reO1gBN3rCKBCD65fDVvZ
 3M/gbmOWNMUZUHEjAjgM9w5XaPOo3aopcuVZ60k77yqnFqxYu4vVBN2j46O/M4+4
 qsAcVQb33CSNYSqwjhYygs/RWp7dFS0yZaQ4fxQgocC35VSxPNsO4r8TBJFWkwQO
 /fu0dz65kwRhpO8ZRIXu5hx6be+51z3JjeXuL/Wo7Ptl5N8Fufbg31YFx+Rqmf+i
 X94ASJnQeIuk54LZxsYxdyw3il2ggA3Dwy894Jl7ilFCG0Hu9s43rBqrzgMsznNo
 LssIBQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt3f3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:39:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fbe82671dso10772981cf.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323971; x=1788928771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OtG8FSr3PPasaeHBO0ZnHSCsLxE6pb70O4YkrDBc7BU=;
 b=A074wD6ZJR9C6rmSOE2FBBUCzDctf+l9X37apMQAtVQvMwuJ2kcWKzRG7ufgbiXevQ
 dFORO5jBd6wB/a97CRXusR7juO93SFQEBgsouC2edc94a/PAJlN4UMPncL2Vy4uZclqi
 M536CM0kQmPEtLnU3Gv3liT03MUOJsvHUcE3aAEBvOK6al8hfDgNt3PcTtBaGJfhgJ8m
 nqhJ1ecVVgQI7bUKMAMNXHf4MVVEuBUGE2w7EjKc4JgQTkXW+PjE+974IhAmrBTJIyoY
 fFeZlm389ywxpcXsJQZWOw4q4yGRVOaCywV2bYODsTVfe9iKS6uQ8YL+dlfgqLbuHtwP
 Q8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323971; x=1788928771;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtG8FSr3PPasaeHBO0ZnHSCsLxE6pb70O4YkrDBc7BU=;
 b=IHvCnf1kEHjsWVLDT61dXplcfSYf8XbVVTBPsc+QsEB4U1tdHxzPi9/axvCzWJuNoY
 Xb6gWDR6h00S1epBUDwUbicLHsV7Cmb7P0O55y0AOvzrfDX0Nimy332iVYKTn0UzjTMy
 R71M4iOJLPBEwkORZypg/VvcMu7H7f7VLW7XMWCK1s/AigJ3BgznItVOqWTLLvH4QHS0
 pxvf5VVJYYDLHfi0Xms7VfpaR9jI5kV/T1z9MvL8XbjNYvq4qmo2aYec1hqxdJPRDyEq
 nLzQjofbf9ex1k4Hxw+vQq7Y/kUbNSbh0UMvZ0CpD0HlmI+jup2tmnVGauW8tpYqeGFC
 wkIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0nhUgL7JLDv3Ge/q5FSopGT2l8vrcl36ooXQmrDjwmhqsk4sRcZhbHYesRiCmIfCxpGbHjM34ZDYv@nongnu.org
X-Gm-Message-State: AFuF++lxTp80hE/flJUisuDLHUgKY2VN5fwRh2SpL45vkE2YNvkkFQ2U
 wDabpBGafnK1yGhMArH7yI9oTAiyg6AAV+kC9hbjApAwX3H3Hcxw1ht7Jr9JZ8n103SubXxIvex
 oX1tBDr6r8VPzOa5M4ih+x4Y+mf2Io+1Z10tn7ZbJ3Pj4vCNQ2rfyYCSFBA==
X-Gm-Gg: AR+sD10hbKOAS7/BF6kFaIpHX0n0J4pJ3w0Wc2VBmwRBvy5P28I9RVsGHlpgtTawbnC
 2gDMD0W1tkNVDHs5K+UMEjc6o+/VwslqtrdV5VACDDK5c8WBijsEzrJdhzZHJ0iy4bOjH0vau1w
 xCgmEtwjWBVpver7AwGZ7aRbP1FPkAh9u3Hl9ulFNw1Xgzlm93Z9QyJ5+KERP2WQBfattCeesEh
 SoG52IWN28iyzNfHYCvK0Y/IjizHSvC0YzWBqH1qj4RfeRCUPQ0J1slf6ZH6BqT9+/StQ60mZrV
 Q74Jbl8Ly+9yJbgJCpuyycJ4RFx6TOjj0/UHEUfEZVTMJl1gQKO2PAMRSCHKU+0hp1zTqcxG/cR
 ENQJl9DAOJJBwXbUWPYxj2hU9UXk7wczUpQ==
X-Received: by 2002:a05:622a:5809:b0:52e:467e:ea75 with SMTP id
 d75a77b69052e-53036d13b39mr22805531cf.31.1788323971263; 
 Tue, 01 Sep 2026 21:39:31 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:52e:467e:ea75 with SMTP id
 d75a77b69052e-53036d13b39mr22805321cf.31.1788323970824; 
 Tue, 01 Sep 2026 21:39:30 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea961sm3650560f8f.28.2026.09.01.21.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:39:30 -0700 (PDT)
Message-ID: <5b5c8329-f922-4739-b075-3b9c5d46fdaf@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/riscv: remove machines-qom.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-15-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-15-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX02V/hxIJxvBh
 cGWXcGZK+Ons9U/96IupJKJa7SH5EM2QPE+9RMaTyp4VyaoNMd0DGeDBUc25jTGaCaVEdXcojk5
 M38Smnx+pPrKRrYrFvCPCUvX7bWHg2uDlpooc6IZ8um8ArIe3JPOJag++FNYy8aJbBEanZDWhwU
 8/UjhKrQfHsKjg2ceeGoYgXcAkZPPFc3mcBLWp8YxenT84t5pPvZIhLYka6PGhO1DJ4lSeebl98
 LU0T/wdOw5w+tHYS8t03aQC2OH3w25nfDhSLZ7jS5PBnyMb7a5Ocy6l0YPvo5PtKK3VyDjnEWDA
 O2lyQWfGa7UAZzDS8pWsZHeFIyoAy+YYUmv2XBGTXAiDXkJI/WDdrYBX/lPSlBAWw3iMeLXuZpo
 xYasBloUIlOgS19C7umYxgaHbfizJt22PuU0NPz6uTdmCYnnRc9als1Vv7BDpQ6Q89cX6U9dw8S
 lQqrj5kNyHGtqLt5SAg==
X-Proofpoint-ORIG-GUID: bGWyRVR638AIA_nnWuym-6FEcVap89K2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX2CA19eDShRK1
 /XFWcDq1GpcRgla46Qwgw/PLMRMV4uGLyK6MTP7b66qYKb7t1XXYkyncasegawGaQL+jjwSP1E9
 ne2cSapDCYUxy5bwJc5pfG6frIZVyBY=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a97a883 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: bGWyRVR638AIA_nnWuym-6FEcVap89K2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/null-machine.c          |  1 -
>   hw/riscv/boston-aia.c           |  1 -
>   hw/riscv/k230.c                 |  1 -
>   hw/riscv/microblaze-v-generic.c |  1 -
>   hw/riscv/microchip_pfsoc.c      |  1 -
>   hw/riscv/opentitan.c            |  1 -
>   hw/riscv/shakti_c.c             |  1 -
>   hw/riscv/sifive_e.c             |  1 -
>   hw/riscv/sifive_u.c             |  1 -
>   hw/riscv/spike.c                |  1 -
>   hw/riscv/tt_atlantis.c          |  1 -
>   hw/riscv/virt.c                 |  1 -
>   hw/riscv/xiangshan_kmh.c        |  1 -
>   include/hw/riscv/machines-qom.h | 14 --------------
>   target-info-qom.c               |  1 -
>   target/riscv/machine.c          |  1 -
>   16 files changed, 29 deletions(-)
>   delete mode 100644 include/hw/riscv/machines-qom.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

