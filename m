Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32353CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvGT-0001Pt-IZ; Wed, 14 Oct 2026 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGvGR-0001Pl-M7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:27:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGvGQ-000897-1x
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:27:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E5wpoR3951298
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JiQuL0+No/TJVOwMFvvBgw7NdCceIIQhBanI4v3E6Lw=; b=Ly6bmAhSmaUWf2Gk
 D55XFEbnFBBP++zL0sKbXADCxMYTz9wkWSAYGAtSqF0YNkqNTVerM9IywGF+qUgv
 pUVPO2pK8Wlu9H5XZvBwHvQ5rc8bgkYC795DNVarfYwEtGqAEGSBuVL991TB3Bs4
 ekgZj2+Bffo1groE7269DYyJq563DirP88G/MOuNs1KP4YYPPPKuziK6Gefpy5KU
 EF6PW9R3qBwsLeLAlql6SAfmA13FE+zkhMm8QfdT7MSOZEzJJ9V6aOVnij3hW2nV
 bWO8iesNFj5U+NtI+VuK+w0c9DdZsh2ng7rylIZkwI58zSNDZno5I8W/kNQBiY0w
 lI082Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p0vje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:27:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53514fbd4a3so2745601cf.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791970027; x=1792574827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JiQuL0+No/TJVOwMFvvBgw7NdCceIIQhBanI4v3E6Lw=;
 b=IoIDWk7IK73BYDQJadM+SGctiuyI/FOvHYF796ME9/LzyoFZ0kJre/5Qix3f91CejS
 nMBPQdefNwpqSPcaOi+jsPypJxi98MZGuSuFAjngLZRrOZs7TrT3nPtt7iPbi6ZLxAOv
 bi7lhuVTXvAHbyqUIxwYiaNl38jjShYDEarW5PO+SpQIeJXGW0hvxxs5M46YOXTTPZgr
 Rj+nOhPGOYaC1fE1oQwCsufGfGU5tAKtKqozFyMMfMngZmcFgIDWBHyNrCX3lWpTbNOg
 zVWlwHijdLztZlqh6GoOjWFQl8Ws/lv/AXEWe40ZCZoIjiyvwfLvnNrUfDwsZFmMVeGj
 csOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970027; x=1792574827;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JiQuL0+No/TJVOwMFvvBgw7NdCceIIQhBanI4v3E6Lw=;
 b=dXR+OUgBXttBJaikrNnyFcTYj9lEqDmV3MxzOdtarA9FDCRuf+GFukJgVxvBXAdLuT
 sEiz+TBN9q3nuaSbsiP9g8z0lMQQva+5E3hj+21B6wry73jbSRaeXsCft2NFxinPmXoK
 bHiOeiBQ77uxk5/jIm6+j3OuyEvQPniaHfLyqYkOS0kDji1Vdt1jDlx2D+hSR/eMLIre
 f847iTxZoyC4EqmXNE2jxdO69D3gKTfPAufEJy++rtXTjxrHbwWFuun2gSfMkO7RdCHi
 aOdFv89wW8C9Q8mSB65NRxorRIdNdILfD3wR5tU1Ds4oPw4P9qEe73B6dDLLTL/Mheph
 kFJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTCHJ8APSEW1atBGkL1x+QgwjxPoAiI+tZce2FfHimzBT4lRtxXLXma2THNqPT6YMxPnGl89NDZRRS@nongnu.org
X-Gm-Message-State: AFq9FYKBSgMoNJXalOcACJRYSGFx61KKOaZNbMjRGq47wBE4BOIzqkFr
 oLJ76sgMCqz57D5r6XHAPxWOaImcDmBJSowlqz46Ng8AcPXaueZ0xBWUYJ30QfSgtoWu+tUaS9r
 Pn6n249a803t7m2jCL/Od1wGFmVqaM8BH0PGjHBI3hC06JIFvhCqGXc9Cxw==
X-Gm-Gg: AYBFou0h/naUWSog30geCeude113J+0OH4TJKtKQEtBAYe7iauXJxdiSH7MTBonS5Of
 WBEzcnEgq+XrMgFJ9p5tS43R69iVZ3JakSB4LebL6UIw0Fd0M7dCTWw82mf339YMe4p3S1a5jkn
 ExnXiNwQBvsN60qdOrD55VpWaCiJP68ZzS841sec9VaBIun9N9IbXgDJWXM+Q4wdKIbskv58aM+
 JFFG4Pa+hHGaAsoUhuUbzFWLqK1hNgnRyathij4mkgzPN5oREjzqSN4M2leCByUakmmcP9OfgNU
 riYOaok6z4k6U1XGx7KwHTCWwshAbk9ORFkXq1UCZPXCSWfuey3JzDk+GX4fAybSQTpkgAynE+q
 7y4ibekhM20Pwbs1SsG+AS5DhMmNJkpi+4A==
X-Received: by 2002:ac8:5a91:0:b0:535:f1b:68e5 with SMTP id
 d75a77b69052e-5359fb5a450mr263359531cf.44.1791970027335; 
 Wed, 14 Oct 2026 02:27:07 -0700 (PDT)
X-Received: by 2002:ac8:5a91:0:b0:535:f1b:68e5 with SMTP id
 d75a77b69052e-5359fb5a450mr263359401cf.44.1791970026904; 
 Wed, 14 Oct 2026 02:27:06 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf35930sm422852375e9.13.2026.10.14.02.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 02:27:06 -0700 (PDT)
Message-ID: <7957a503-6fb5-40cd-9793-1bcdcde1717b@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: deprecate use of instance level properties
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261013120638.855671-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013120638.855671-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNyBTYWx0ZWRfX/DRb+gaxWmhC
 jXVF+MyO6VTRJqWSqiRVVAyzdBvcRhB8Q2IQC/GPk5TjkrvEKgFmYknY6EcbTD8E65vSXOPMQOr
 dqBRtY1hsFuQ+g2bleRq0O9Rgfxjvis=
X-Proofpoint-ORIG-GUID: xIkJH_YS-xuniawfdjj3CXLfPvVfqtyj
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf4aeb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ug_acTv2MyFcWMqQv4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNyBTYWx0ZWRfX5q9E6Ssprwkk
 XExWxAFTg2e3Pd3aqZ/nRGGLHQskSBnaVjq5jIiBEqgChpW6G9x/4bVUXpfb4U7loa+Tv1uIKHP
 M5CEjeGjnJxcvmLPGVl8tB9ebx127FAArL3MNm9QgEDfFol1+U7gbc7ogpyjNPxHJiTbsgAEbQe
 rQxPa8mwRQdAY80tjlhBQC5IJzUWu2DRiFdy1Af+1z19dB0rmpi+UfgWbB1Jcn9CtV3DNhQjqBE
 AkzlrGrpZMWYmugoGWfYyeq9Ia4W52jvJbld6GzGy4/YNv5ZYCVg0S3vhd3OX2FYqZdWqzqXUEr
 xd1ZcFfetM+GvWVGYACHNHmlIPdTifrv+CGk5bVa+2T/VgVX/aWSA3vYL+A2N7gKLyM/YF4SlQK
 LlYhZkLpw5PvsJtR0WuWGXmf9l2nF3WgzDQldY/lsk4fWEdCQ1Q6wpwRTRL0TNsq+ZFISsStjos
 d2QbmzEnFHwtEvbF+mw==
X-Proofpoint-GUID: xIkJH_YS-xuniawfdjj3CXLfPvVfqtyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140037
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

On 13/10/26 14:06, Daniel P. BerrangÃ© wrote:
> Add API docs to object_property_(add/try_add/del) to recommend
> use of class properties instead.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

