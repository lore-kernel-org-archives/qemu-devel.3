Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A841606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cSofWuJv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y+f081xp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0ss-0007H6-BF; Thu, 19 Nov 2026 07:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0se-0007AJ-Dq
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:04:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0sc-0003Qw-Lt
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:04:44 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBkARe2331695
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /o8u9yuakn0wqKiXg4i2dC8rza35U9W04iigxWwockw=; b=cSofWuJvzUngqLhR
 94Bw7DsSMSIYgaqL19pJLhJ91rRuDjC+ytfRQyUxgdogWDivyXJ/7zkuJ9x+TJj4
 Zqo5XKyWpgg9SxSR8hHxWw6B2jvDTwyEpq5u5j1MeH6SqIC5ELyPnsDZz1wD/usx
 UcKf8v29EKr2dVESlvIB/BFaX/nbifhOd2NXWrr0BO9zIpWVmSUBxXC5TXobsgVE
 0PgEg1GVrTJV8ELuVn3ZcolbpXC1GAJDkSBK5t9CXRDogP75PaNh5LG14lQyGJoP
 kTcsx5yp/iciRt5YdWBqLnjq5KMMqRwEElWjFTYOlXecL8Yfg0DxNeqtYTxtD70N
 yPQhtw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdctpv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:04:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d322fcso89850385a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795089880; x=1795694680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/o8u9yuakn0wqKiXg4i2dC8rza35U9W04iigxWwockw=;
 b=Y+f081xpwurzxbnpOIXND5J8kFRtiq+F5er2ZDpRc2gaC0wQm1NWKIIpXBYliJT7uT
 Meb+KjazKm36y5nfEEC49Tp/LpdstchmTZkzQ3PcNMPhK3c8l27X8vMJf8RPVamejoLp
 6MRRu5yom9jmHTl4Y1YQGX0Y3adh8hq9P3XfG6uLd0gRQ3vHyXCzCr8r/ArKOcN2zHu9
 2FvN9zFVsBWDvj5C24Ht1HgKcI1h5+6K5CGjOLxKSLNG65n6PqVVhzRtaGzoRNjO33kl
 Ty1Hi5/6TgXRCdKcw2z8cJXXxYioww8G1N7ubjBlLnEu8RP+YH6MtWB4GLrTgupEGOgr
 tKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795089880; x=1795694680;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/o8u9yuakn0wqKiXg4i2dC8rza35U9W04iigxWwockw=;
 b=tOqSrhSvxBi/s6jukZddEbyoKeYuTYRBPBbnFNlhk/Sy/Qm22ASELuitj/H4x1TE3V
 UWBGTNzP7omIAYjfOwXztrZH3V9pAIunWiyn8iSaPWoDbHHylanTi5M0hkmhy/MTV47d
 ac43FV8NQdpVnN3FEyi4+coLOjs6No8m5ALkBqn6Sp9O4Rms1blY0R2HQKViugQQkWlU
 as1kbtpypqh9GuXjp7dAsuomtdHX5n747cj0Z+xxvDKwquDNESQCfVc/Y9Hhtuf9wuKL
 BkxwoHYNkRynQYrSAcwXsHF1m9mnRlMfs6HK03Dft+xl/fPHSzvH3wQD2qkGRfZLBZ9w
 YMUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEfXtkzdh21DYTqb5GgHeafjPTDIXNz9kkzKN7P4L6kNUguz/6pSXk9gFHvMfQ1NJN6npQIUiG/STqG@nongnu.org
X-Gm-Message-State: APuU4Z9bR4OoBm6CCp4jGsDNxG9+Z/5tszHMFu5kbkygyJ429fwC3oXm
 k1tYeJq9s6B1u8DT9G8b7OTtQe+7HW5pbexzvJW9Wnx/yJ4ueEuU17FU2Gvc3jZR9g+VKUCajn8
 +uVMW6L3vkg0QpTeCMSErjXUGxXHi8HXZWB+YsiGmRxAMVo6Y6g4+o4Yn4g==
X-Gm-Gg: AYBFou3BBsaUPxzeRZOQeNnKZe7V1CyK3YuYVWZ/1xL1XAbpLvzMCrzguQkrtqwsIQq
 ObH6oHgrHFXZRlK8ywAcgDjffqfA7KgVqzZyRF6fscs2b1LFaq5yr+efQsbORn1D/F2+n382Cro
 C3Op0ZYCQkPRafWQ0LflRkyAJH73c4EBCpnvgX8kAI6Cc4ao1Wrsek1U/kDsK0/bkLBD4olpN8t
 HGVX3oH5DEyiuaElrze0dt3esZj6WX4323HRH+3nEb3su1sijlWGET8IDkvTWurXhpvvbmVzl5S
 Q9IHZkI/UfvHEPtdTXmfyvKBwOIJMRM+DvLBxgtArcjT43+2ry8qXcl0ftgWdrqfNdkY39/KLPj
 PzyfTWzr6HgrMDaLgYE8GF/Fibs0w8bX7fU5Qs+J+0Xg0uP9cGXPrhFz95YxmniBJiMtUMEvMlo
 GhGQDDv0Y=
X-Received: by 2002:a05:620a:2906:b0:944:dbd:8253 with SMTP id
 af79cd13be357-949995ee428mr1120632585a.59.1795089879733; 
 Thu, 19 Nov 2026 04:04:39 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:944:dbd:8253 with SMTP id
 af79cd13be357-949995ee428mr1120624385a.59.1795089879111; 
 Thu, 19 Nov 2026 04:04:39 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm10169313f8f.18.2026.11.19.04.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 04:04:38 -0800 (PST)
Message-ID: <53dcc9c6-474e-430c-abbf-0b667675a497@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 13:04:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] target/mips: Do not negate NaN results in NMADD.fmt
 and NMSUB.fmt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-20-philmd@oss.qualcomm.com>
 <3d021b3f-fdd0-4c83-8b3c-3924a5cb42d8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3d021b3f-fdd0-4c83-8b3c-3924a5cb42d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zUa6GfuhpyuZLnlqnQ_Xf3diu5QMg3hg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfXxwdPeAyhQqk3
 fu/lYjXT3oWiBWCi2A01ine6rqWULrcityC0IhqSsHrz/8v7+1fuDBPyf+OUYmWDg8tvANA541j
 dTEcvnQiJNqMos4ncSWugM4iNk4C4tQ=
X-Proofpoint-GUID: zUa6GfuhpyuZLnlqnQ_Xf3diu5QMg3hg
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afee5d8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZCQ6zAl_naE_dTWWkOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX2MwlcvUw5X3+
 BW8LU43P7J0yR2QZiiLXs/ZHfipJCqnYDW8oPHYiPOfc3J7ygD2Riaw4hIUofv8zeeAwESOCPkY
 6ab+RYwQUzd1MUE3UQAOuUAQRgIitUCl+7MkFRLVolFX1Sp369fT3esqQd/JSVgj5MY9teqyMNB
 fir2kbVq7OYfJ3ZkqCIyF0eVOF/tx/7b2xJWC96wPjEAtLMumsdmaS4Kv6tAkPwxO5Mbsb69gy+
 YEuiFYdWSEnNC8rk5BQbcpYDfU9Z6z6utIcAMtyWRjUJ/eStMUJl4PhnoL2gqh6V5HPxZqybcny
 uPWD0Pt+O0gYaczTI806CCc0RRYLTrscCFz+ZMoNINgeSxoX62qnlBhvbnH0Oo+N8pqQPT7zlST
 AsaTs79/YhRsxQ1N8vW7/SXSCcBUD0RITzyAz3Z0S6O4/igM6mjK/Wbbu6UJFkd94aUVL99QY2Q
 saBczihbrslgyb4SayQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 20:37, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>> The final negation of NMADD.fmt and NMSUB.fmt is arithmetic. With the
>> legacy NaN encoding (FCSR.NAN2008 = 0) QEMU returns the default NaN
>> (0x7ff7ffffffffffff for double precision, positive) for a NaN result,
>> then flipped its sign with float{32,64}_chs().
>>
>> Observed on a Cavium Octeon III V0.2 (FPU V0.0, Linux 4.9.79) running
>> risu: "nmsub.d $f7,$f27,$f23,$f15" with $f27 = 0x7fffffffffffffff (a
>> signaling NaN in the legacy encoding), $f23 = 0 and
>> $f15 = 0x472fa6f57f408dcc gives 0x7ff7ffffffffffff on the hardware,
>> where QEMU gave 0xfff7ffffffffffff. The same was seen for the single
>> precision "nmsub.s $f1,$f18,$f22,$f21".
>>
>> Do not change the sign of a NaN result when NAN2008 is 0. Non-NaN
>> results and the NAN2008 = 1 behavior are unchanged. NMADD.fmt, which
>> shares the code, was not exercised on the hardware.
>>
>> The hardware (or its kernel FPU emulator) also returns a different NaN
>> than QEMU for "mul.d" with a signaling NaN operand and a denormal
>> operand: this is not addressed here.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/fpu_helper.c | 39 ++++++++++++++++++++++++++++--------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> Isn't the larger problem that this should be using a fused multiply-add 
> via float64_muladd, and thus the negation via float_muladd_negate_result 
> (which will not affect NaN results).
> 
> Certainly MD00087 says the product uses infinite precision.

MD00087 says the opposite for NMADD/NMSUB... Vol II-A rev 6.06,
NMADD.fmt (p.376) and NMSUB.fmt (p.378):

   "The intermediate product is rounded according to the current
    rounding mode in FCSR [...] The results and flags are as if
    separate floating-point multiply and add and negate instructions
    were executed"

The infinite-precision-product wording is from the Release 6
MADDF.fmt/MSUBF.fmt (p.324), which the same manual describes as
replacing the pre-R6 instructions that were "unfused multiply-add,
with an intermediate rounding".
Those are already implemented with float_muladd (float_maddf_*/
float_msubf_*); using it for NMADD/NMSUB would remove the required
intermediate rounding and change Inexact in double-rounding cases.

