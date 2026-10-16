Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E6CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHfiD-0003uO-OD; Fri, 16 Oct 2026 07:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1xHfhw-0003ro-82
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:02:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1xHfht-0007dZ-Qv
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:02:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAA5LV1983057
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8VDCgOWO3CNU+1gP6G7Xltlc
 S9rhKx8joyJ5bbcFRag=; b=HzGlpKWLDQO4nNm6t2uStrg7B8Dsj/merEPZr6bQ
 liGhq4yNWcI4RBKKEj6G6mG5t/k6lNtA+HKJdhMcRc+3t2rZzZLGJ0gqoHaks3Sa
 WtvIXOFSBKwoetb5oDLF0BONqjJR2V8TARzbD+H7MUeDndJcImLnRw9phZsiOSjX
 Sh5QxI1m9x2SA+GkE+2oeOrNbdJ21SSM+jsgTegtPINYhR3gyD3q29wcUZ2U3Prs
 Gser4SFbKDT27EgSEUaTWCKhZghPrXVrNRgI7vsmrQs0ZDRq5dX6pSALildUlY4f
 wU3DRJnzO8L8eFSsA6mv/tv/X+i1SXvLeVnOarKYv2CBuQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8aada-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:02:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5e96f90659eso900279e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792148553; x=1792753353; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8VDCgOWO3CNU+1gP6G7XltlcS9rhKx8joyJ5bbcFRag=;
 b=j2WTQSOeGtKLnPoTTqzuBgJewzRdG/MpGfUOCttMrRxTzI1XxetjTaZUY/CA+/Rf5v
 r8u5wIcjD5otiIqlzteLllfDP7dmITh0RPufoOsqjQ/KtaJI8cZAm1UuIT/5OdCPzE/c
 dDQbQhObzX3bgXeG/q6M58RYvSnoG5qTRQaEgLk9J4G/eIVPNv4HtpvXb4QMnWBq3xof
 aBkNAyebcxOfDR9V0SAhQpe53XqiVcdN9xWT06Vtd9WzJ3LWtWS7m/wDWKjvwpycesk2
 TyHqHUbV5XfaV6Mh+nRJion7P4AKyuo6Tw7RnPl2Q7FeF5fD902jFEMZy2udNxC5puWl
 uQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792148553; x=1792753353;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8VDCgOWO3CNU+1gP6G7XltlcS9rhKx8joyJ5bbcFRag=;
 b=g6sVf4+bDMyCs0jzCFZn0GzQQ9GUBd4HQXsT3u8kFGKkJ2kBvXvseXhoK3D0iRsCMi
 GxxYNRqo3rHmMJy+j1X6uLRvl30VP8Kp1PldKxTuRzkgxoXRRx0ttKux/VVWCrS128R1
 JSTosVzlDAmO7FogBjLvw0vwmuSoVP1hCqMv8giy+kRBe5npK4uK0tKnx1xkQPtXXsPw
 VLb1ph1vg76Ql89b27Ww0KuVMSBgaoXMpoZGxY+ywyL8gDLLfDiwcmrE0ymW1d9fGb1y
 HbTSxO8nO5RM1aD4ZSS4jqpHsXDVIzheyRyEv/LKWt0IPDNt5zxhNEsSR7av1TmXE9Cb
 Gi+g==
X-Gm-Message-State: AFq9FYIJ4L5wy6YJc4Kn/rqs5En0tfzRzFA0rPfv3ZHIZpDDuSxlTjDS
 RGyg7yx5zxrZ8QUb7I0EQjfEn6J49JdDh879gONRRQU+DnuZFfLtk1f3R7xzdKTIhhcqrf5Nl4n
 NS7xk0JiD1k/gTrDbwhz2H5ulV4BEgG2gCHGqsQQX73RQfgc229tN3aHD+A==
X-Gm-Gg: AYBFou3Z7bCA3BpHbw3LyCLcpBeJnXFiOSqWSHIT81tiZw248eTWHEmV/lx8TAcv3D0
 FfxNeldS5d/C1DZrQvcAiXU4HZg+2fKUAHZlKFXezwxmqj4csYc5OAXh+m6eAZtNzaufMexJH1I
 DC5r7K5NIiQEmzp5raBhoiy6L3giiCYdHaDPh1r9goIvlSfYXl4DcdB5V3JzNDfcQcwanI147fT
 dUS4WPhkoNfZk41TRQm55u480MqeBsBCWziHcg3hEs2Db1CkbPSoWMLY3QyRzgKYD/AXmlIhxYn
 Ap5xX6X7EkRWV47vk5GCd8x0fHDKEdoJNmCyK8qQPmo3Uk1r1GpD5Wx/+uU1W6inIlci0fjXDtt
 A3JkUjW6ObUsx5FrLlsLWqxHCD+dBTfgMssWkKhgRoVZ2bRJjtHdEz6t1i8ejDSEk12K671HkzQ
 ==
X-Received: by 2002:a05:6122:218f:b0:5d9:82c1:b343 with SMTP id
 71dfb90a1353d-5e91f250d84mr7310035e0c.1.1792148552895; 
 Fri, 16 Oct 2026 04:02:32 -0700 (PDT)
X-Received: by 2002:a05:6122:218f:b0:5d9:82c1:b343 with SMTP id
 71dfb90a1353d-5e91f250d84mr7309995e0c.1.1792148552333; 
 Fri, 16 Oct 2026 04:02:32 -0700 (PDT)
Received: from leviathan ([2a0d:3344:316:5100:f22f:74ff:fe21:6f68])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfdeb18f8sm3795411f8f.20.2026.10.16.04.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 04:02:30 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:02:28 +0100
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref.c: Increase SMMU space for Root
 registers
Message-ID: <atIERMvh5tFG7Uwi@leviathan>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
 <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MyBTYWx0ZWRfX0C1KPeTOPYW2
 Xe6hmpVmMi5ex70L6sxnxHUVrnJ1kqhzsjuX6b1rTbYMEIuVCMztEZlRiWkBbsmHW9yFZlukv/Q
 FDZ5MYH6hPIUPT5s91tYLfNalBVYMkY=
X-Proofpoint-ORIG-GUID: zbPpN0rMa-GjahhQqDf_Olr0h7vwFI-G
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad2044a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=iN6TQegEkVnv5H5OV8oA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MyBTYWx0ZWRfX4U6nm0ep5VFO
 Qa+dDm1hY+9gFAxraaoQu5rmIBlzMJDzb4am1NdJHuRBm1nM69o+mrg0h7ePV2htXhSpsAYA9aE
 oKUupjGwrOT7sfiyzesE4T1ZXI9nmiEgPMoalmqWncz0XoyNSZKcmK2f27pNmLaqvJ0e1Zv2qK9
 nrcYcaIR3X0cfaNHxbI0EswBGPUMArubLQ63VrF2+Dpfmgbem5c+qZruMBr9wcpbbiu7A1uI5/q
 8loUUw2+xBXGVKoJVlr275+3iprbAZactbBTK8wAzB4c4+XOtyIngHguBrAtrh+VXUHHH1IP7ke
 2vpqtv5hKyZhYMLLeyn3VI7hqQWiY94DuR6Tzcmkeso67GmFfZ/mZWmeMOEdy1QvqVJ2XeavPgt
 WGKinyA8ajvRE7YIFzXrHRrO6wQDoIFkc4Ou1Fsamg+ZRmi2VtGf84wnpEG1dQAF4qlDruK8lcD
 yUkaM0KB8LRGdH829bA==
X-Proofpoint-GUID: zbPpN0rMa-GjahhQqDf_Olr0h7vwFI-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160043
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Fri, Oct 16, 2026 at 10:40:52 +0100, Jim MacArthur wrote:
> In our implementation, SMMU Root registers are directly after the
> non-optional SMMU registers. Realms registers will be added above the
> root registers later.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

Acked-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

> ---
>  hw/arm/sbsa-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 158b461eb4..0747f5ca9f 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -129,7 +129,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
>      [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
>      [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
> -    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
> +    [SBSA_SMMU] =               { 0x60050000, 0x00040000 },
>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
>      [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
> 
> -- 
> 2.43.0
> 

