Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B8C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ckF-0005UU-Ro; Wed, 02 Sep 2026 00:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckB-0005QD-Gb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ck9-0008C3-SY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTMY94097967
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tTz3iIeLrXiuMpS5Bk5upIuw1rXRAfI9k5q61GEj7aM=; b=lwhEyLUXgzswpCdp
 sB8WRE3Y03j2MORx0I3yGDvMSPJJEYhXzM7ZI5TTPj1hFbST1/G9KgyTNPT86dCm
 PGNSVF1ipFGdfZ9FwFKWVEDK6JuOe9u9RBBvIgPwXoIQQqWVW2Xv49svfrlxZKOc
 RMSjxZ/GKhUnzXNZVHR8iJqNHcS72SeHJifFdfwPf1yHsqYNBsPpqWhE4zf69WC2
 ha45CdpxG5acRXhu+iNhqI50mcRSvcP/Lf5NqbmvFqp/+nOMes/59FrVW8ionnkV
 DvME8kS0Xb3Pob2apDp7/fzovDz4EIf9NI7A7kMHsBl4iY1TN9kMslOSQ9eKg4Pr
 E9EoQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt3eyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:38:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93494527488so138829385a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323916; x=1788928716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tTz3iIeLrXiuMpS5Bk5upIuw1rXRAfI9k5q61GEj7aM=;
 b=g1RLEkdnmoyvcV/T3VIw77P8xCrP9PHevKCe6qahyfXGVOptW9sZTYfEIHZLrwJnZc
 +TRd75bAGO93Z7uONHbKELjSJ6kv6lvkMfhzGYV/54o97w4oMt0BGO9SwxuQ5dUju84V
 7o5agZxINiu4kDMHtXckWpra7hjrZc06TJ0/zIPnlRFYbbfw8tG4FQj6i5FqPtzpQBCy
 AIsRx1FR6R6XPbQrKea5M/9ipBA0HpPM32mtyh3vPLxbaEGTEE+dsCYZ21JQMjKrKDo7
 R5XDhgPqgc6KWdr+BqGLX6aK6S4F8luAk1PA/vjuyjmsP7IeKA27Mpq6WbHXyey394tX
 WfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323916; x=1788928716;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTz3iIeLrXiuMpS5Bk5upIuw1rXRAfI9k5q61GEj7aM=;
 b=UTSgp8rLfY4xcX4n6H1rJLbP8vLM/3iJR2K+deF+T+LGXaF8t+AVwRyFYAG92w+kOU
 TTNbZp0Oan+5q7MO6BQtoMDGY70bPn/eHAo9ASoG5pyXL+WWRS7EZGoyaDQRslGQTYAk
 MaKDOyaMIqKBdpZUSxzGCHNtWlIFYNbF9xp5VXq1LfQ+qXuuhl7lf9EjQI3Rnm1ZfAkv
 wIoMkcntVsh1OnS7kfl3xzcrXHK+/jebEd6UO+QM+gmb4Jv+bUHavb7fYCPnM387+9eV
 ISLsKy2sgPvuQm7bnimxDUefOusy+NLWFFXNabGv7hobrRpaE9F9Qv5q7ffrsdrDBuij
 DDNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro23Qhyk2nhMO7Q3oJmr5q1Yp84vsjlYaS3gAvmwQZBx8Cf3Q+e55RGGjL2t02WrhMNw7/fjqqpplnF@nongnu.org
X-Gm-Message-State: AFuF++kUJjxgA7E6XQIcqrcOF5O9Fp462lvY5j5ZVyYbdDFJPOknAl8L
 qnF1/PL7LLhhO8p6la7W/cr/ouztHeE0XPXI++EuaARUwwdbsys1VD5JGEf5wym3+jJVVqDgS48
 RX1rguOj3ZECrIPoGUfLA3ds216GDagU7SqdJnjlYhV2JipeIOYXVfu0o8g==
X-Gm-Gg: AR+sD13MZewuIuNtPFMn/r9ErN+iOhmTBAOvMN1HyNI4UKLwNHpy0JCPBueqVGkxO2T
 10m8lm3k0uch/pyXkDYG9/bn3YJJQKWG7IzO8qUDC4GY8yRE6OXBAoFREx/8HTIgyWxsnme5TJ3
 vA6SgPT7MKByKC1ICKenpHIySiGptFX5QHpnqpGjbmLa3nswBVbSMfr4XDUs/57JiDgg61FCYbh
 fWz+YVHF9/Q6mbmyqwWZr/zZHYRk1eElOsnDnw929Ksam2M7VU8whdfQ8PaR84O1XRqFB4XHNpE
 dJBkcFQr+xycPOroTI4StX8sxnc5DWYsxdfGvFFsow5/rG8SFBKOppcgPUTu6mhm7Hkec1wkBJB
 WE11G7tKeZ9JK5ammunQMEyClWud8qDbdtw==
X-Received: by 2002:a05:620a:3b16:b0:937:3669:14e with SMTP id
 af79cd13be357-93960cb8138mr175528785a.9.1788323916186; 
 Tue, 01 Sep 2026 21:38:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3b16:b0:937:3669:14e with SMTP id
 af79cd13be357-93960cb8138mr175527085a.9.1788323915725; 
 Tue, 01 Sep 2026 21:38:35 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce171c3sm125578575e9.8.2026.09.01.21.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:38:35 -0700 (PDT)
Message-ID: <4bff7222-cd7a-4501-8939-4a66f9f1fef0@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] hw/arm: remove machines-qom.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-11-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-11-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX2Cnu2DH76hI8
 JAJJVJ/gnZyLfeAnxlxmuPKa5zZH8FImln1wK4GUYS7nDhkGOsgqlIfCwQQP9Sf1hMspnlt5B6D
 KBpYG+GIUO6UjjQAinc0YN5OlIsnCAYAYlCkxip3EaHtn1+bibfzZz29/Lv0M95mPebQ+J4GyDa
 dp/Xt3qQqhg16JksDyXQXNnCq62MZfD5ZN74a9ipfpdSz8W3ix3FhJkFrqvPJ5fbf3nlv4kGgrf
 j4VT2nu839846TDd4nEbjMKkYzkqsXhZGjZJuLBHwQ+KTHEk556KT+Wckw9dtdl3IECmQc3bruh
 GVoq+kxR1h5C/AcgxYw8kYJ/CS8xbhgyUWHSiGnbRdCi8Aaeq1RRaGNwuvQfQxCMEvpCRD2JwYs
 1Qj99V5//Bb6Qf+I50/1ipy6u99Z0qNR4IprNcVRSClauTQNUt66ztCYYBmgcSC6kQ207WoGBsU
 CTX3uitnRhHxKNq4XRQ==
X-Proofpoint-ORIG-GUID: c6BM0rk-qFzIdf11S36n7yfnmWh4c0E4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfXz7p9YkQC+sUm
 cjy1p21Mxv5qc3SV6l4R/57IFCGtzMkNJqIv+EHzLhZdL0Bi6e801LPP0B4e+Z7YdFE4UzOP7FV
 VuradgXSKURdqjg2wvD8EyalDA/oFOE=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a97a84c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=r0bVYnQz3-FgjroSeqQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: c6BM0rk-qFzIdf11S36n7yfnmWh4c0E4
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
> Header is now empty so we can remove it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/arm/aspeed.c                           |  1 -
>   hw/arm/aspeed_ast1040_evb.c               |  1 -
>   hw/arm/aspeed_ast10x0_evb.c               |  1 -
>   hw/arm/aspeed_ast2400_palmetto.c          |  1 -
>   hw/arm/aspeed_ast2400_quanta-q71l.c       |  1 -
>   hw/arm/aspeed_ast2400_supermicrox11.c     |  1 -
>   hw/arm/aspeed_ast2500_evb.c               |  1 -
>   hw/arm/aspeed_ast2500_g220a.c             |  1 -
>   hw/arm/aspeed_ast2500_romulus.c           |  1 -
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c |  1 -
>   hw/arm/aspeed_ast2500_tiogapass.c         |  1 -
>   hw/arm/aspeed_ast2500_witherspoon.c       |  1 -
>   hw/arm/aspeed_ast2500_yosemitev2.c        |  1 -
>   hw/arm/aspeed_ast2600_anacapa.c           |  1 -
>   hw/arm/aspeed_ast2600_bletchley.c         |  1 -
>   hw/arm/aspeed_ast2600_catalina.c          |  1 -
>   hw/arm/aspeed_ast2600_evb.c               |  1 -
>   hw/arm/aspeed_ast2600_fby35.c             |  1 -
>   hw/arm/aspeed_ast2600_fuji.c              |  1 -
>   hw/arm/aspeed_ast2600_gb200nvl.c          |  1 -
>   hw/arm/aspeed_ast2600_rainier.c           |  1 -
>   hw/arm/aspeed_ast27x0-fc.c                |  1 -
>   hw/arm/aspeed_ast27x0_evb.c               |  1 -
>   hw/arm/ax3000-boards.c                    |  1 -
>   hw/arm/b-l475e-iot01a.c                   |  1 -
>   hw/arm/bananapi_m2u.c                     |  1 -
>   hw/arm/collie.c                           |  1 -
>   hw/arm/cubieboard.c                       |  1 -
>   hw/arm/digic_boards.c                     |  1 -
>   hw/arm/exynos4_boards.c                   |  1 -
>   hw/arm/imx25_pdk.c                        |  1 -
>   hw/arm/imx8mm-evk.c                       |  1 -
>   hw/arm/imx8mp-evk.c                       |  1 -
>   hw/arm/integratorcp.c                     |  1 -
>   hw/arm/kzm.c                              |  1 -
>   hw/arm/max78000fthr.c                     |  1 -
>   hw/arm/mcimx6ul-evk.c                     |  1 -
>   hw/arm/mcimx7d-sabre.c                    |  1 -
>   hw/arm/microbit.c                         |  1 -
>   hw/arm/mps2-tz.c                          |  1 -
>   hw/arm/mps2.c                             |  1 -
>   hw/arm/mps3r.c                            |  1 -
>   hw/arm/msf2-som.c                         |  1 -
>   hw/arm/musca.c                            |  1 -
>   hw/arm/musicpal.c                         |  1 -
>   hw/arm/netduino2.c                        |  1 -
>   hw/arm/netduinoplus2.c                    |  1 -
>   hw/arm/npcm7xx_boards.c                   |  1 -
>   hw/arm/npcm8xx_boards.c                   |  1 -
>   hw/arm/olimex-stm32-h405.c                |  1 -
>   hw/arm/omap_sx1.c                         |  1 -
>   hw/arm/orangepi.c                         |  1 -
>   hw/arm/raspi.c                            |  1 -
>   hw/arm/raspi4b.c                          |  1 -
>   hw/arm/realview.c                         |  1 -
>   hw/arm/sabrelite.c                        |  1 -
>   hw/arm/sbsa-ref.c                         |  1 -
>   hw/arm/stellaris.c                        |  1 -
>   hw/arm/stm32vldiscovery.c                 |  1 -
>   hw/arm/versatilepb.c                      |  1 -
>   hw/arm/vexpress.c                         |  1 -
>   hw/arm/virt.c                             |  1 -
>   hw/arm/xen-pvh.c                          |  1 -
>   hw/arm/xilinx_zynq.c                      |  1 -
>   hw/arm/xlnx-versal-virt.c                 |  1 -
>   hw/arm/xlnx-zcu102.c                      |  1 -
>   hw/core/null-machine.c                    |  1 -
>   hw/nitro/machine.c                        |  1 -
>   hw/remote/machine.c                       |  1 -
>   include/hw/arm/machines-qom.h             | 14 --------------
>   target-info-qom.c                         |  1 -
>   target/arm/machine.c                      |  1 -
>   72 files changed, 85 deletions(-)
>   delete mode 100644 include/hw/arm/machines-qom.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

