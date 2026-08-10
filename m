Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082EBC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtFwJ-0007Pc-1N; Sun, 09 Aug 2026 22:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFwG-0007Nw-Ug
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:40:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFwE-00033G-RR
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:40:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LRHSR3088576
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/7EMSo7txd59ZvhkFF92SQMOYs6Y+TmZP9d86rs+cI=; b=Lbhyq2lCIa3pza0z
 LuiKkcD/RBIMi3XIJ2l8AiC+k7HBb9Gqo8bJDVTTGxCkpjr7R8li5qI8iTYplnL3
 xPvigThSulMhrXDYtPLn8q3IggcxMMTMiBKlMzvNmUSYDdqsD3UG9C352VHjG5p8
 ITJ4JZNrJIEsTlRH97xkLxLCIs+C909ispB3HtqtkGjnTj3PjvsFc4csK95gXmTB
 DWYFeIf2Vl21qoM1kSSjeT0ibwXG3Ahc0NopUcp4Go9HGeFZyNU7M44A8kDi5gD4
 8VKAlAqkA1GfehJvtbCJ6+CIXKUIZVoITyCOCnB2ZoNVgnDywS0/F7SahtS1oiNp
 VQZw+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwmgv0kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:40:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so19229431cf.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786329628; x=1786934428; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S/7EMSo7txd59ZvhkFF92SQMOYs6Y+TmZP9d86rs+cI=;
 b=eis/6xcAmilzNJosTh7uVaU9MM0IIkXquAF5tE1+6q2K9xeNqKDTCYi/vy7j9KVfju
 NIzYgsJQIIa92d4KLCbYzGFGApcfspZhA1nOJTjRbQt84z3xNZBeO4r5oPsA8ibMpxb/
 v4uAWPScAs6CJEp47b45W0LDLHi+YbYrBsFOevH6mg1o3oZ70/yWrH9w1Wzu0NKwbHI5
 xKkP496Tj1eZYPEFWXZg4EoTXzBt1cQIO6SxWldtRJLF1Vt1lwdFxwI8ss0w0GkKgrIk
 u1Tw366Gi0OJCEI2D7AqRMcc8rX4Kf9JVKNSj9sqQUooyImRxWtwovRBGOIltTsgI+Mq
 Farg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329628; x=1786934428;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S/7EMSo7txd59ZvhkFF92SQMOYs6Y+TmZP9d86rs+cI=;
 b=aPDNUXgD3f/77A9+L/k+VWM0hSDZ1yxWlLzFeEn7SOvBcxQ1Vr8LF/kLRu4lrjb14b
 c0LR94hXx1xPlBC2O7Vg4PPWcv0IckroYuO2U4EWzdJ4vD9Yvp7v1lXQaXfpeqw5yULW
 /vZ8+q9D8mE99EiVj1oOsfS5C2E4NGkofACilPJcYb95D9ujr2sY8GGVUjib3hZqkd4B
 icayncrgarB7yuaIbiZAwdyw0fSohvV+CX59/IHqFcDZTXUzqhnH+JrAQL1E9f6WqHs9
 ilgt6JxTMl89ZOkyR9lxbD0h6+uzonFUg+FpCWPyuasMQSA06jC2VD4ONDIQrtwuBwuw
 Kvcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrphq5eUXjuL44IeEQPPcJhkKQxd7ZiteIsUZroVI+fLvbZU7i4zWB9tWAX1c6hPa+k1Pd8DFWGh0Db@nongnu.org
X-Gm-Message-State: AOJu0YzWF1pthPTh0S/UiIn1t4U2JbSCJtJ1Kkczq5opBXvEGv1qJUtZ
 wG3ak92/0ryu5tNaqskNslsLbAJHleTZS5FueCV2LmnlpuhwIbqSGorGjs5AHIumlH3Gdd9kaBd
 U7WNUSs/kfTd/K86X6P7CMCnxx7jWIsqRbHWcXJkI46Sa4ZOtVcGE2oU8NA==
X-Gm-Gg: AR+sD11iSBXqx7PE76YWgQgnqXHUyTWdSoiompKMQbUUTNIGa5gKqvLxYp1PlQj3W1F
 8UmiUIiE6+RRKxqAso/oIKeeRWvW3VvU7RGPSponEraDjatG1WRzu5+A8Sv+C/vBAvHGvncKudM
 ac9hi+WQ86iKjJBtGW4S8MZSJwKq3GgV2NGCf9aJS57mMFkajF+2ilWy4g0zvMzL741RM+9ub8n
 YKseq0cUwEYlsfI4UUtzFvVNhSQjN1Pg5T3afzxdI4XDd+FfQo/IS2kO4PS7cgcH1BxE+htwbH4
 IYWGLMHgLPOGseNX29ZyoukE/a4aVU7nDYICwRXq48EvBUrx5oBec7uGOoI61reHguieqEtVqQQ
 TfCquV8eXsUfGqfMHRPfHk3dvKfIl3qTFh5E=
X-Received: by 2002:a05:622a:1c13:b0:51e:4f6a:b9b8 with SMTP id
 d75a77b69052e-52d18e1b36dmr210406951cf.1.1786329628481; 
 Sun, 09 Aug 2026 19:40:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1c13:b0:51e:4f6a:b9b8 with SMTP id
 d75a77b69052e-52d18e1b36dmr210406771cf.1.1786329628061; 
 Sun, 09 Aug 2026 19:40:28 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm27527008f8f.0.2026.08.09.19.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:40:26 -0700 (PDT)
Message-ID: <0dc1f28c-1a70-4f57-8ce6-f25444f88916@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/m68k: Enable disassembly via capstone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX1NC/EC5+am0t
 MMbb9X7A7I9QgRXgRmSMsVIAn2dcR8xw2UfJb+wF/npr04rDGCWjugcdrDmvguB+vCyeyfrC61p
 zCrd8gC0In6IEcQXElA6YpNFzOUQ2q0=
X-Authority-Analysis: v=2.4 cv=HodG3UTS c=1 sm=1 tr=0 ts=6a793a1d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WEbN1Vetez_7PGiJofe0Z8XggCV1trrG
X-Proofpoint-GUID: WEbN1Vetez_7PGiJofe0Z8XggCV1trrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX1sn8/EiBZW2t
 POVI9C0nwlGxFpPRdd9QIlU4Y1sTGUQjuu3jW/sFm1tHF91pstlzR146BHT8BapdZWjGX/BAs+f
 uymWlc1ahSTGXXc+rLWetj5Z0lH9Z6cRRDKgR+rR/El2fQXXIkz8NHdSs8ro01+GlhZ+wToRB8l
 jBMIQ/oSfwEyMqh4Wlv7pYwmY9OfNCxZo44L6cthh9QBtKaZR9OmWeZR9EmZb6jl3CNqzE7SDpw
 arpKI77bhKrPgBfIXtdRHbNZio9eYwKxzKPo2g4aFdFwyUsgwInew6TGNgiW4Rp1ZOHb8PwrGp2
 WO3p/j4sIVxxhNF9XVpxf/H1D0TGnoymYajc18w3fCeP6LYv8lHEKITzBDBGFT7h82BL5hEm/l5
 SibDbxH3p4OxY3n0MLc1T+uJH1HpkRett6IQl093pK+bD+IdkgACbK+/ZtI/ayGNfcUtVFJlADQ
 +u8WmIaYppXs3xG23Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100021
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 9/8/26 03:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 20 +++++++++++++
>   target/m68k/cpu.c        | 65 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 84 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

