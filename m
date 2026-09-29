Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7375FCA5FB2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXKy-0007Xf-Q5; Tue, 29 Sep 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXKw-0007XD-Qj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:53:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXKu-00082F-Ul
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:53:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCr61W206325
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=; b=ho0p3jdDXN5L8Gtl
 LVX0inaTmpPbV61kFM7kuQfo7rEmayUqLE3gmEc6lFGsdmdRxp7cELYKqBN/iR4o
 lkmFnNOqprB7/sYX07qtQRQ9yd/1gh+oBqhc0T3vbV2e4ZPg6NZE1d+GPqXjd5wM
 uRN6lHgcwwwBXJe/TsKvxZq5eVEk194ONJAuIvMXzCsGbMDnegoV90q1byw63vfj
 j1l/AWUOlBEtq1orbsGYTXzUc/5OsySC9qfcTfAPCvMYXfitoiA9f1YYoA571kaQ
 WvZCm+kdBMJ1zC3k3194gS7PpdtOpxyBx+RvWjCLfZLIuqbK0yIvbhf9pxPujOox
 CCSZ+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144u1cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:53:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bfb2da664so1189165685a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686411; x=1791291211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=;
 b=JjEW6K/XWUZ+2jilD9wxlMeAf9WtKb5Rk5ZdnrWjSRiyognv6nTsM4iUPauTjGdXhE
 3qZ+9hyfnX/qnQO66AUlVuabtGlKpsAYUVG+as7gOI8zL9lz0CLGR09rTRw3d5RMVsIw
 o629zJwuSOVFxz97AMMZ8zGFkDncYgd91JTWv51RNhNS/tu/3giwM4DpVy0JUipSU729
 VrPmJFanVOTNfxw3AQs1HlxK91m5DEt9jE7yRKXgLwvqK3ZIaBrNFtd/HUP4gOViFH5g
 NTFoXLiI21Xi7avxATyDHH2XQZvMbJ6bnEk7OU9sZaZ4h2jafutA8EeWUf0cRuLFznQA
 h4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686411; x=1791291211;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=;
 b=XojpOOtGI5xGCJnX2F5w3u4JwP+t0NS6uL6O4HbrED6zS5UXBefTyhHn+IqVr20HJS
 UTX4Ahv97BAAMw72F66Qauj+LUDItOkDzqv6EdBB7SSuYiJVf39BL895WtYP9iB8j2Yo
 woxb/bDwfGnG0WS2C6UV9dwjN9LLbvhMmO8gufrbw5McCR/Kt7bri0mXuVkD7qpIw6Q6
 DFz31OUPDW8LP2PTfkP4wtIjaamVccqG0lqLzg3KMxw6cK76H/yxCWbq+LLQ0aN/KpCo
 M2tyTP/rMIQpSoME8W7miEuGRUiOST1jq1CbCKrcVEtPyYcmyvwekxwzbqcrCs62vUUG
 bbpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHtk9DHMokvkvlMnTL02RyRfTYYBbBGUiZfo+f0VDYlqHWx2O+tfesqZH+A12aEgPCfcQ6+1IT0bn0@nongnu.org
X-Gm-Message-State: AFuF++lMBUPpX39Gdrs+KaEA1aWyyqqj5BcgLAHTNgVHRQIqL9RCKldv
 xwD7b1J1lJQJlX9EkVvG3Ad6QrEKNJ/9Gs7jNeNoeFwQqKl1VwAXipRmQTCd2P43K+vd2Lu8fs/
 4eciF7QbSHpG29tKtDKe+mh1rJbjMD6Th5m1OsL/7c9wIU8C0YZqk5z6lfogVqYAQMw==
X-Gm-Gg: AYBFou2RCpOmjViE3kF+QNybjvdyLpCcVH+nVMN4oRuEfX9px4tPcNKU6VTqC8aXm7E
 Up5CjSolI9Gf6sHPRYCKeE8dwr4fczV2vvLiRm1WCqlspHcrwJSI9r3fJ02gvaQbrIiVyjRR01u
 mXTPiEdo0N4y3C13Y7+RVu807YWpgfv1U+vCS96BFp9Cf/ACrbQvqxz5KuC9IWT8j9mX0g9A8tN
 FYSIMCPuT39d8SUSb4y2ie23wfdwy1tcDAnC+wCcTkP6lysNA8UdtDXWI4ycTAvAHVlmWue9pLH
 3Hh31y4fBWIfH6kGvoaDA7OSbUCzIHrwVUuPCw1GrRnlj3N2fg3eJHGpJdMzsvWbNApQBrOH4cj
 Nefp2IibITKGws62u4LIOQJXwkbMCB7G+gw==
X-Received: by 2002:a05:620a:90d2:10b0:93c:5951:38e9 with SMTP id
 af79cd13be357-93c59513a31mr1368690785a.52.1790686410766; 
 Tue, 29 Sep 2026 05:53:30 -0700 (PDT)
X-Received: by 2002:a05:620a:90d2:10b0:93c:5951:38e9 with SMTP id
 af79cd13be357-93c59513a31mr1368687985a.52.1790686410211; 
 Tue, 29 Sep 2026 05:53:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf8f93csm82345805e9.5.2026.09.29.05.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:53:28 -0700 (PDT)
Message-ID: <dcfe555c-c6ed-440e-8a19-8590cf0d6415@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 058/101] tcg: Generic expansion of tcg_gen_rotl_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-59-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-59-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX1zpM8wH5ZbE2
 TohRYiMFF2WW6VqFHttzZkiqQVIUEJiSXpgI62/vX6lbXm19sBZUTqdiglhyONWEqh0l0boL6JT
 xQZ6Y9cVInt9HZgb86wQvrjgrOvjWyhzjNTHjdBWbyOwDVudYtyu8H+8D+7L77hqgYbdDyyq176
 o52/rbHFQ/ritg3vEABPYevqEAN7XaEX2zBMBhGds5wTQzwnNiceuyBXvqDLEKJNolcxPqo82co
 ZanGVqFpkJJX1zHutigu5XWi4qs/Di8u69bngq6rqb+VQcFLFlZQTAlX1mBylzWUvqlX+seKiP5
 oszJ1wDf8gDmWm25T5gS/nnBteO0aq72S34huva/rjgSPtvhDB+gdARc+taTHS2jCtyqHn7vhSo
 UhECFHR+vjx567M3BdH0jV8xgVAW4am8oRNpr/BB7mxjx4FEArt4JfiotUf+TP/jDm2RTc6FcOJ
 dy8DHh49jGemmxx+0BA==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abbb4cb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vDzd5LRRpeQ31Ju-GOB6iStPbnvBSG6J
X-Proofpoint-GUID: vDzd5LRRpeQ31Ju-GOB6iStPbnvBSG6J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfXyt1XW+TEe43O
 LcL1ipMRSPKNqCxo8vx/9vAf3mRSlB3LCLJ8sJzFlfigwONu4B2V0CuUYbLXgwyr6t736j9sezK
 9Eo7YhNmY9JabU8mz8DyCdDaPGCZDvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290051
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 62 ++++++++++++------------------------
>   3 files changed, 21 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

