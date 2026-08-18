Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FD1C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 04:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwBtX-0001rI-Dp; Tue, 18 Aug 2026 00:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwBtW-0001qh-DN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 00:57:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwBtU-0007hV-Ux
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 00:57:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3iL1c1171843
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 981q+Ohiq34Wi9cgaN/4b5gCBa0VEICqQYgaaQRCwWc=; b=h+ZaMDGcQkNH5zxn
 94uGL6BCToeL65muQIQg3GIFqbIoSiT2VPquX7eRJAqvGZ1AXnWKf2aqnIXcQ9Iy
 XtFi4Xsu4v+4QgqBX9d381rlps0HaOnOmoKANLbsRCOexJaK+Lci0WwOaYhX4eep
 mvIJZzeaB2RWOAzRrzBE6yMZHYi1XNE6QEtH2X2ixItxoS87q5yySAG9WWLsmLva
 ihwJ2Fio0MWT4jcXbjWcGn1+6fJh7fSRJyulhP3w8DYcuQK2qW5s5GxzcEA2pWMf
 HcttHdh5f+Nh1rLaAl5OCBpawJxdCe35ITo7B6z9db4PWYCnEzkIgrEMAzhI/0+q
 Fg4fEA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmr8hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:57:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ec3146553so743571185a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787029065; x=1787633865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=981q+Ohiq34Wi9cgaN/4b5gCBa0VEICqQYgaaQRCwWc=;
 b=KpKSNT/2ByDwc1WM1xFrIH29LeplQEtkGuuQeOx429r0Suo7cJnZcAw278BUJK/caE
 AtSVK6+o+AAzKJWaBNUaK3tqQPtRm1AQ/0F2uHqGm19NkA1vbUmKEJjuvOq4fWFfhyoT
 kLjk20LwqVDwNIqYAHID4cAMZNn9jS+cwOmIG0KAEpXzy97UGKhe60wnRqD1Sx/yO2Lw
 q7+qt3GZoggQuiTlFXurHRW2mh2MlPZt55CzRwNpiWP3mzlEMdWUQ7Sj/+BDgyP4CF4d
 fFj0A7O5wZs1Ypg6aWHPZc7GqEIVbVgMNyHORo2uLSoixIymv2dcKTqzFPYuKMWbByzv
 MOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029065; x=1787633865;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=981q+Ohiq34Wi9cgaN/4b5gCBa0VEICqQYgaaQRCwWc=;
 b=ctbEUFGUOr5xqa6qVCKr9hWorLX1L7jlPT3nRskh5C/CRaCYvlgFLNhp7ovSiXWrR5
 F99nEaLVYvXghyQUKMgZIdpf7F3a2R1nH6DljYBvLDYSzR+bgYv7hXvi2/gDzpjMhXjb
 JKEsRhXh1/FaU8zeEWsaGEKKYjSwwgDRhcqtaE8W6NAL32axGjvUxas7dQWiCT/d4twl
 MAL9zOmL7DNTDkK1Q95LkwVa5UFeQrMWY2haP8jPmeXoUuN+lpyHaHFLRoJGoSQ68wvm
 YG4dHiMDUOUwzUN1ez3NRpc4t5ehEJlATEcSjixe4bjeivDBZTPcrWIM/JWiEUfRJPX2
 OQKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQNZO5P4OHTldYhT+Yi91NFuOTgaxYmiRk6yHq4uCnwC+SmbCrpMSqIfVgBc2b3O1brMiK4W56kSv+@nongnu.org
X-Gm-Message-State: AOJu0YxZrHC5Y7Qjg6deXGgkvHnxyrBKNk0eSY1mipWdAPdJmLwN9uDT
 gauKE212ZSilwWXiYLjgvJOxpDNPyFenzMi/kifoVOod4wuiuhAe9H7zc9beKnhm+IOv75zfJ2h
 pxMZS4r0tyfQqIrvU1Gka/9/NsNsV6sb+pIQwCP5jrKBr+5BboF4BpchoTA==
X-Gm-Gg: AR+sD13oYvCLXflIhqMom1edTTrfTs4K6eGje4R+k0gxmNoP1HKCnBhnQQ7yH+PNBC0
 p9e1V/QTyEP6aAJ/5MPzYULUXboViirjF4nubSOPhLwZdic5s16cTFTcgBlvGnDqFXxRCXd9Oiv
 dMeOZ5vZaxUDm5pzFueYpS0fsaIgqtT7aGVJjT0rjy9Ofgzxu3s3I5IydVBJ0HsjirWWXFtOHjq
 /bFaaZKdf50o0mqbHGMPTXW7j5BHliX5lyVHN6VaIR+G0DVmbS4F8AO2IAJzgLEtGkuhsUdUZK1
 r18cKl9/1vW1uC02b+AhLsVKE7dEL88Ry7gQW0EiDeS1MWaGTvVQUzu0wXq5vcwhpthEZumPlPE
 P5FaV5WfImfeba/ME8XKClPF0v7WxgNPeIyw=
X-Received: by 2002:a05:620a:a906:b0:930:f35d:41ba with SMTP id
 af79cd13be357-936d22ff1cdmr2840160185a.36.1787029064791; 
 Mon, 17 Aug 2026 21:57:44 -0700 (PDT)
X-Received: by 2002:a05:620a:a906:b0:930:f35d:41ba with SMTP id
 af79cd13be357-936d22ff1cdmr2840158885a.36.1787029064420; 
 Mon, 17 Aug 2026 21:57:44 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999619a7c3sm190439735e9.15.2026.08.17.21.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 21:57:43 -0700 (PDT)
Message-ID: <1e10b7ca-e417-436b-aa78-6923dcac71fd@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 06:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tcg: Export tcg_gen_ussub_i{32,64,tl}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811191540.79882-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNCBTYWx0ZWRfXxS45Gyy1b5T+
 uWDWFrgRRxBhBLR/u6T7g4Q5/DPzFUBcq5BzkMfEI6K9bBPonwXBAJOMJgLnWUUOKEStVTGm3D6
 LRKnUmbRG70HdaO30sblaLaISjnVFC9ecmOkV1xkVQd98dsGvht/YsdtkzqucQ26xG7AbsCuQVv
 VzxB+Qryn5nw1jsfs7LVEOylkYmC2K/6aLCv/Ll1SyrkOLhIAIKjYgKHgiXt4kayeDJO4mcHSD0
 Qslzxx3nFxkAnXba7XWz2AxogdpCtLGXDTSQk6/7YAK/OwD73mueRLcBpLnCyGsO/7hzsI63xay
 6afwKHR6ZmpCrVqIXFN2a86F4i0lJuPxTt8h7rPtgslPD4s/qzob7A1a+TN0QzwYTgLEMZEOQre
 k7/8+54yjKYPEJOW6WDWwxYoiW/ZcjULq3kwmukZS/z47kYj0pBOKEq+7Sb/T+CyIdHFXREVjNF
 a4uiqqcyodgW7C3ibOQ==
X-Proofpoint-GUID: gBWRyhQbIUvZKXmuQ1VE_B7ZqUzI1QoA
X-Proofpoint-ORIG-GUID: gBWRyhQbIUvZKXmuQ1VE_B7ZqUzI1QoA
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a83e649 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNCBTYWx0ZWRfX5AtqZBcch2k7
 3UPUPore2RzuCB7S6Vsq7Hh6C626kBOzCB4JwMmyFdNL2aXByjyUODhdrO5XbceNMyhMbP6Mf9q
 /Z0/cufQBZlDTrUaLmNMv/BPD6wh8t4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/8/26 21:15, Richard Henderson wrote:
> Move from tcg-op-gvec.c to tcg-op.c.
> Use a temporary, to cover the possibility of operand overlap.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  2 ++
>   include/tcg/tcg-op.h        |  2 ++
>   tcg/tcg-op-gvec.c           | 14 --------------
>   tcg/tcg-op.c                | 20 ++++++++++++++++++++
>   4 files changed, 24 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

