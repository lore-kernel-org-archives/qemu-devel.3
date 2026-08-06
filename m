Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A45C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2GC-0002QM-Qv; Thu, 06 Aug 2026 13:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2GA-0002Pk-R8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:52:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2G9-0004aO-Ew
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:52:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HPZoM2639852
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kYdzS72jYG6WSm3X80ySxnL8BeSP9cZTr0muPitbdA4=; b=Hx4wPcBbSQmriQi8
 a9GD1Zxim/uvP03VRLYxkxGOK/NvB8/gmtpoE4FqMQ/BixdrIpFSKlj82uGjKlOI
 GveKdEI1PbGG4f5pLna1IJDFXMWq5D4drA1kHoWBk0dU6DYXqCCce6rlU1SdtlFG
 xYBKItiWIgD9a536nGT7TimqquLQVLZiDWVv6jPFMIEOqoyopTlhs4p3tJLHKyEC
 jly/mCyTkRpcJnQBYtyQ/blVlE+Q/xTksAzPgBChphRtNYVdk5M5KIgCwZun/vzz
 jqgcataoOg2h5GV7R5oBWmzdg0+ICxJ8nMWpQI2TypShqwBnb35y+DMYJRZeY9N6
 a7LMGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvxnfr4ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:52:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so40772701cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786038719; x=1786643519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYdzS72jYG6WSm3X80ySxnL8BeSP9cZTr0muPitbdA4=;
 b=XB/HWlox8yH2uqm2n+3dC/E1o5AD4p144nwzTffvErBinnAlo32ynvPvvyR1EnJNhk
 AAMblkwNFHlM1p9FoBx73LF2P4pxQ9MUta7vX7xCoh8nMNeonuD9hPl3WsaV00/clLku
 mt1J0mhqZRb/kTnlE2AVQgm4jzrIm8ahV9R8IEvXUGh7+buIb4fVnU/i66bZJsPo7fJO
 pOWtbWTC8m2C5M7/IVRVWB4KZHjcXpbtgIGiFieGpaHaFXogeSTwURW58UdLaQSLN0BD
 UxpR1eJWJXIBJqg81PAMh9CnbT+q4ARzyJHIvfrCYufyo1DajuBzrBLdKwm+2VGORfx/
 9wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038719; x=1786643519;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYdzS72jYG6WSm3X80ySxnL8BeSP9cZTr0muPitbdA4=;
 b=nEC0AALm8Bck1PN+1GFyJJTeY7J4CHA2Qxzkz19D71lpSnG8nkEySdiiVip4sp1NKA
 uyLZvCWFSuWRFvzMGDHZPpLs++FZqkwDNGHjCFw5SkI/PjSp42tts/fy2Q7jEJElNSVL
 V6zbNFIzJLayz6cgorNzjS9rAM/xA26ikQIu1+wnJz7GN8qZ+dpHWD63gHNFzUihBv27
 49XCwDmKrAMDDoF6blC2zROFSr+1Pv+6dj1dz3ER+f1DAMe1B6WBumQkOB0ZOqD/Sb4j
 ZDs5AChoxJsxMDLyFaIOg92EtR/H0BOjJkmI3cbrATbe0zxsb0dw49emHSG0Y3if6zVs
 d89A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQWEu1J1weJi2jYlx7wcPOa5MwSG0nFSH4hpHV4EfBII9b+bVog4b0yjmdAffCgXoNsuGRXgGmhCIC@nongnu.org
X-Gm-Message-State: AOJu0Yx1SElcwAAIhEzl4ZLWcBPf1/8yAogoik+RqNOVwPmtsz730pB2
 Zp74fIA3/aQ7uZQNaS6DWuDVB3nyaZQmsQD+7gbxgBmJRUJXHATbhPyNN1JwlCbcqROEAaDznfq
 Zr17RffPjPyvqAQpOLu4VVlWRknjHSRI8CdXlbWmneoONs8FHTfBSlR9Rzw==
X-Gm-Gg: AR+sD11477+8pPfW/OR0rLh7ENooV3ClsT9If7xLFchhaG+ZKD+PV+BZ7H464Cz02sd
 RGnWF6LY2LG6wQruYJvPiY7CHa+1Ew6H+9hSQCGn/Hp/sNBZOQ5w0z9iqtPbZ/NlJriqPlfBS0+
 Lc2l6rQwWQ31KqMwdOF6rYUhMVIBSHMryAu3G7s1Rf7asnVA63zpk8u4rXTFA0CO2nrGnzsErsE
 Lou/3WnjleX0/JjX4aEVp4bLYkNpiOYKc8QvxQA10r9SYltuM79cLCe1X/4H/UEq1gG/6AgxVwU
 XuQyr9HCZ+qdhP63ppB2IhHXdYdMdc9QW9lwkihUeQsNoAbQhaDpIueuLRZVKZuoBPbJpztRJaE
 0jLT5uyxKYFL5rRJiJhcYWu95vFnStWdLC3Q=
X-Received: by 2002:a05:622a:614:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-52ce6187082mr165630741cf.29.1786038719647; 
 Thu, 06 Aug 2026 10:51:59 -0700 (PDT)
X-Received: by 2002:a05:622a:614:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-52ce6187082mr165630111cf.29.1786038719023; 
 Thu, 06 Aug 2026 10:51:59 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b183b2sm8660827f8f.24.2026.08.06.10.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:51:58 -0700 (PDT)
Message-ID: <af245e94-ba75-4128-ae84-0c893a9f8a35@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/arm: Introduce cpu types max-v8 and max-v9
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WOA3hzKnbBKbODh4NIW4GHd69_koJ-q6
X-Proofpoint-GUID: WOA3hzKnbBKbODh4NIW4GHd69_koJ-q6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX9/qp1y4Ozcjt
 SDlNsF5ml2JFMozjMb/6HXbtCqA9JE3NddLn9eXxxGL5QBOlSnooIiVeqHhYZx6kGlpq7N3TpyH
 xGUQijF4xF9legl0c4ByYeMGYpgOcTXdTKV5G2DMVIiCU8m4WrqQmmsEyFHrwvYR9tCFyUgd1h0
 58y8sRKq5YrjMrVZKPU8VNR54i5H6QUS5MdJOnf4sFSxNl8mPFy84NEPjO16J7Hskh5cfoHb/Qe
 lPXYViaE2arnY3QUm/NfmA2nLQO/ipLVllISP9ZPtRzoycZaRhOZLBkNgQA6Q8suc+s2ik3PrKL
 T4S/C36/yfnzR+uHoSkHRdesW47VCaBOrV3IztS4pYtculR7YM15naUlTrj2DqNVWwzctPtH8Ry
 9+1Vdw8qkvhojLbbDs4k/mbAQpyFE9baojEanv4juskniJ93iGe6lScyHg1bCtF+ALZh0KKH8Zx
 Cq7CM9tkIn2Y7xCMsfA==
X-Authority-Analysis: v=2.4 cv=OqN/DS/t c=1 sm=1 tr=0 ts=6a74c9c0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX97TnkCbk/2l3
 Wrqf3AtixYTqvzqgapOrN8K8y9v8I8WuQcz+EmjedwmMB6VBJ8Ts0A5VcZ+247g42MJmNjtVBdM
 QY99t97WjmTL7ZClfMOryiHZzjYR+Uc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060140
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

On 6/8/26 18:39, Richard Henderson wrote:
> Introduce the names and allow them with the virt
> and sbsa-ref machine types.  So far, the cpu types
> both exactly match "max".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/sbsa-ref.c      | 2 ++
>   hw/arm/virt.c          | 2 ++
>   target/arm/tcg/cpu64.c | 2 ++
>   3 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

