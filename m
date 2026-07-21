Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087BAC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7VV-0002pV-5L; Tue, 21 Jul 2026 06:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7VS-0002hl-JC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:15:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7VQ-0008DM-Ud
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:15:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L8i1ZR568625
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ieiy9G8x/zMnlC7jWe2hgiyxlYjC9vJ8z83I/gdAC3U=; b=pWOHvROz4RNu1niS
 MEorKFZiB+tr2bH1yFuiuWAvhwgziyDMTv4fjUGIsikzezs8qMQ2KV2gNTzz8+YN
 il42zMVtaBarfcNEAj3Ff9Etq/zRRCC2jKMgIdUgwJumUKkUSpJhiboCyksbUtEy
 oK7XnGfwqgLNa0ejCU9rCR52q9ex8wAP2XZFjAoktPjgwaNElLGZSa7Zwi4FI4+3
 jB8XDXavBAUj+Nwt3u65D+O6z3NTg1aL8xXw1vdNiSz/3jzbdwFSnTt1qWXr7SHo
 ibe+NbiFYfVf89fQKxuOXWVHSjerX0qQ+zgw8jVUby3JRyOWeTRgeDdnIDDDzIJt
 cHcSkQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvsps2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:15:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so162743981cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628919; x=1785233719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ieiy9G8x/zMnlC7jWe2hgiyxlYjC9vJ8z83I/gdAC3U=;
 b=kmadJSZTEW+KbFWYTo1TBfzgqbAt0j4vnKLnVsnANlsXQDELU4aEzzAuCVEUmv3lVR
 l9od1MQ6FvX8yFCShADvedEyWK67R7TKfaVuQIrcN/DLTOOvowEcmw2r9w7VQg/m0Jdc
 MUAQ8q82JB/XfqzRZX+sba98t06rY4K55AuVZqWR+f99ovPyXtN/tw1eIT54fxnGT00U
 LE4Qkb8gzO6Xfkb1JjZ1DVKAQzSmVhOVrAJMskp6Jb1Jo3tuAQWAyIP8qpK7FsnhuXnb
 YWXJ9WbAVzXR3GuANjLNfMsi6i7+zE1HIjMSmh235gCpJLadEwaX0Gch5nLp9H6c2RK4
 h95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628919; x=1785233719;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ieiy9G8x/zMnlC7jWe2hgiyxlYjC9vJ8z83I/gdAC3U=;
 b=IKVTwrbshjOIitPAhpTID2gVqLEEjHqZ/qkFYVGTIJ2GkWDLXoaRezOqmEET7h/JMq
 w90wtsIcwegIoZYPVXHFXsul/ROIqeG+4QMtYOGn4GCQV0RZA1o37odMmH8d96eFh82F
 A/bKSfBW/oUwgQHxGXMYbDsCDuD01ZeyZ4wryua4runxO5APOT5QmZgzDJ3NKLcFaO7b
 gHwjTZM32vVCWpUFBdktKDwP5C+7t01Kaa5Z41H+ZXZkBJKvFQONkgJv7HBJFmWxOFHm
 Y/ebby+eMyU6xSs+4prUB6tf4mxmsaJGqR7RJsViqRX2l5E4qmRahYWDYKysiU9I+NBK
 Tn6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlTqek1ZFK6g8i90A9oj9lu5RWcmmG93iB4Rdq393sktQjA4UGhkfHuQZZF0R8STKLhHPXHhFnrqZl@nongnu.org
X-Gm-Message-State: AOJu0YwLvLp0YCEdEX4CPdZa8L3NdD12+W0LzlaYUVfhokUXWafH3oY7
 lC+k6W5zc5MtQqReIANJu4tgrVAGDindgnTKQCAafUjVu4AbgvZjNCtMpeZCVyo47U5b/85w9VH
 YF33w0RYLHxt3Ih8Ork5ED4rvNkCgEIwowGLLgd0TATBKCEKyn08bHViuqg==
X-Gm-Gg: AfdE7cnP15z9h/GydphpxQPx6VKP6gZcp+V31nL/3a/uQAzmNH4/xIUfGb+YWZb2ZMZ
 sRVPIB8zt3+fIRj04t3Hzk+It5S5hEgDCMiYpTCvYLN52tTqlJMmuEgbsrh3xleFcs1UraR0Gso
 g3C1oCA0b6/SRXGPkDpBHDWGlzFp5qzjxmn+NNsxxakVU1F9e03FG8i0xPo0DHR/QBfGJwKHk4I
 ZzO4P/FhIXOT9BHoqNkWjB4ekCFBkoXAKWum1chQfjL9m30mLPWBvycBpPshL0pro3DwTW77cud
 1sHEndsJGbtlLmH6UwZcteQYr/nGuksYQuLsKAC4RmeEkB1A9Hbp9mLRIMzdOCowseWmRvq57QA
 etAkzTxmXFOD83mvogYyrOckSdI4lwskoJzs7eLJ2t/O1XFXDViU=
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr164953081cf.29.1784628918954; 
 Tue, 21 Jul 2026 03:15:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1909:b0:517:8470:2d2d with SMTP id
 d75a77b69052e-5213c9dc20bmr164952871cf.29.1784628918490; 
 Tue, 21 Jul 2026 03:15:18 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b291e0e9fcsm2724708e87.39.2026.07.21.03.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:15:17 -0700 (PDT)
Message-ID: <6f7f52e2-49c4-422b-ba1a-0eb165f4870a@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/intel-hda: restrict all DMA engine paths to
 memories
Content-Language: en-US
To: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, philmd@redhat.com, thuth@redhat.com, alxndr@bu.edu,
 qemu-stable@nongnu.org
References: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rS1T9oyV3kFfRxbAKxBs_FB2sUMdSRl_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX3vIlb9ANtOh1
 XCp76G8NH8gorDRPfKDPZVftTGLJConU9AoJO/7K2T8fE8PSG0VnlK0RDECL4CLeXc8Me12dgnD
 t66pNv7M7Ws2SYOill9HPqNJouR9jxg=
X-Proofpoint-GUID: rS1T9oyV3kFfRxbAKxBs_FB2sUMdSRl_
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f46b7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=MdMbO4X_2lyUEMNyGkoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfXzDIGK89/qG35
 yrhaKVbAq4phTo0MSKyg/ovHdITatmiDODeCpR8jfWO99kGzd4ibqKkqy2B17QwYGLtn+qNgKmN
 x1ANu43nYlZUkxQvZTw/vzzmPAcT6yvFnGOY2GvZLRfVBnod32M9GBYQ9jPLRdcU0I19GKB62Q8
 vYX1B4UJwQsrEDktRCkPooqARJBWDr2yEtT4nGJv5mOlypevvBTUFkEKK2FqKiKE5u1iZdmhbCQ
 5baW15JdCXqj6pwnxeK/0NPByQzC3+rf5+Y7o00/CnO+8dlm3j3Nm+T/pzhuy/wzNEq+LtXmkrm
 SZZu2s3IfON2GUmx17XKmIXPQiARXO4CLDy6lWaKt45+duap1tAOnQdHhoespiDySbMXk6p9nFa
 /tmyeDp0M7kk3ZaAOABIRds+7HWogdleGuGx/ManValDlpSJvboCkPJz9QpS9sFdgjuBXgWh+Kg
 XWF7BgP5gM2HHtwhPlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210108
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

On 21/7/26 08:09, jianghaotian.sunday@gmail.com wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
> by setting attrs.memory=true, but only applied this to intel_hda_response.
> Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
> allowing a malicious guest to trigger DMA-to-self-MMIO reentry:
> 
>    - intel_hda_xfer (line 398): called from the audio timer callback
>      (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
>      fire (engaged_in_io is false outside MMIO dispatch). A guest that
>      points a BDL entry at the HDA controller's own MMIO BAR can write
>      audio samples to device registers, triggering whandler side effects
>      such as starting/stopping streams or injecting codec commands via
>      CORBWP.
>    - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
>      MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
>      point at controller MMIO, allowing the DMA engine to read device
>      registers as BDL descriptors.
>    - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
>      with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
>      controller MMIO as CORB entries.
> 
> Fix all three by passing {.memory = true} explicitly, matching the
> fix already applied to intel_hda_response. For intel_hda_parse_bdl,
> replace pci_dma_read with pci_dma_rw to pass the controlled attrs.
> 
> Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/audio/intel-hda.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Patch queued, thanks.

