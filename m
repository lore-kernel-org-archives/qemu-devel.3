Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5719C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7xy-0003jk-8M; Mon, 28 Sep 2026 05:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7xt-0003gW-St
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:48:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7xs-0007gw-6b
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:48:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MMmB954631
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=; b=Sk743+XIob0L4JtM
 PWIHdZGD1/JZIuRtdbn4Facc7hXUs12gqsjYtr3D8UGPkWW9fXvrhh5ss7VHKLPz
 /+XvRSVL00kTyjOI7DpSHpoul21q7QZJlB0ZEPn5ndP5Ith9KB8FakVzHdpNWvuM
 1GRdKFqFZ/7lbKS4TbJ1/qtWW4bHc9S1cgvAvByXu2KUq88MGkvm1hrO4UK1I0r0
 ZwNKmRf4g0vYAxUGg2UZ2AK+8stxKfVvy9lBWEcAnqOW9CrSUqwc9TL9LKkxeWhl
 WZDdIaA+znzE0lgHa89Z5FcBPnsUOq3gg11FbVabJoHVXrPALz+sgkhcnwojK8KR
 kNEKhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc04sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:48:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c614646e9so260157085a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588882; x=1791193682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=;
 b=TW8/K+VfPGwwEVIG4sA5AY7CNzhCyk+FJqLTO4f8QUl9q1l5KwV6G2DdTxU9QZY6On
 sGKl4sNaZKEfZ6O+oaBK+c1EtOQ6unIvU4ClK/m6pz/qbskBfKRUM69oPMCObYjaelfO
 LH0SO5atrENWrviiXn4ICrNos8FOx7sDTKT5CbRk/yxUMOs7E3HtkoWXokwc5b6Q7Ql6
 kvIqvod4aDNQzp0bXmYHvaPz5lWuivbp4xGuELfkcGFb1loN6AVkMFzlD4PeTlChctgB
 dWiOMgSa0cO5HK3E5yfqPyQTMJmGGPUplwQNpzgr1s2MFIY1CTZIJegYdKCkiPtoIhyN
 usmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588882; x=1791193682;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=;
 b=lF6v7TpqT+EmqSzEQ3c6kSiA3j0GywyX/a0qp+GGXHYUC3MVxxL+kp8WB1A8UQHNJj
 vyBuY7mj31No8y+aELNzrsXJ/jS9aC2RlVEo93PYYZXVb51G82g9LaaibyNX6wG6xTrN
 rj06oQsPhUF5UouKQL5k7OfoIQnPCKgB+UBvhBrWZ+rb61vp8y82F8V0Prm1gjHgP5ob
 XjIebH8/sndWG0KrUc0yoiAp1u7TBEWIPLHqvUr6USebJc30rCn7AdQAJpTlgo/h9M4Y
 sAccatGkrXRV3qea6DSi7rpyWs8suMg6blfWikANfVDqgz1JygvZ/AJ5rDjbY/cC1QMU
 /jbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJYuOJIAwXE+Q6b5JaVDtCaqEWdORMyFYYty/ifHuCEsLsupKm/b+P7Zw0tE04vIDPb05XRjmoR7IS@nongnu.org
X-Gm-Message-State: AFuF++n7OrAV0zx3OUcu6q+h/YJda7XxfnZlIxuSjAqjMBXqDYwmTF9M
 t+UC/DVF8vcdGF7MjgSTOATC12aNY39SLmXSgV2xxyt+fqN2XUtonM5m4RMsbnprKf3tAY3YEy0
 iwZ3NCebyHhitMMY2D4mgljYZ3uAXfFy4Q5LKgItmjlkRHYluOTAxCuxRLA==
X-Gm-Gg: AYBFou3jm+tquehlZiPgT1o37kIHidaewXZRFcXlsqnliJFn7jfxaqG+sea8G+D7C9I
 QSdE+NwD2cj6BPeVZfZUMz2cejodD0hnnTMzHMEkpItBcefJ5MwIyxX/ngGZVE+WlspG0X/8I1/
 PXhdnH93Kid5FvdHCp/eGSLEYkgxuhUnlC+GSAZdh2VTFOtOnGnPU3GoDnWcZe1ThzMXcyezhLa
 hvOiffETaxLmo9ipSl63vclgT5jdLC85EL8GOZF6kDMIWbp6upkKl6/tgYJ7FxjLnBIQ3YqvFle
 t6pgMhUc+38sG/NhyaG4UqIwO9Am4xayLCAJqhYXCZxiCW9PtHzcTTK/efGxJbJs2W7PXnEJugi
 L6oAOzOuR3V2WJp8b35n8WBdewgq8O7itHg==
X-Received: by 2002:a05:620a:4612:b0:93c:7948:6e84 with SMTP id
 af79cd13be357-93c794878c7mr518199085a.52.1790588881919; 
 Mon, 28 Sep 2026 02:48:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4612:b0:93c:7948:6e84 with SMTP id
 af79cd13be357-93c794878c7mr518196185a.52.1790588881483; 
 Mon, 28 Sep 2026 02:48:01 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a009f8b4b9sm7572665e9.10.2026.09.28.02.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:48:00 -0700 (PDT)
Message-ID: <235bd901-ef7a-4f3a-9515-843a8f89c39b@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 027/101] tcg: Generic expansion of tcg_gen_sari_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba37d2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WokCdTH82pdmRbEVORb1UqN2v2S7gYcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX1DrHg2MWB8JD
 LTHO01sPoE4rUwdeqwh6DhIsDueRxWHQadDVzm6ZGZdS9zFWTOBl3FFttnG/I3UguIOcOE9pm6/
 3mqslptGNe5brASFhBm97oO+nFPjnbhRZ2oY/1b/OTps55SaucX04Tvm9asYkE4IlJIfhKlxjO6
 xCM9KcIvZ0wrL0xD4W7IfAfnhO4Uo46qfZtOawzlr4YE6TX3Xi+qwJ2C8p9yRa8tD7PM60Jt+Bj
 yRiu1wga77GzXGnqjZJnwjd0/mdw26Mt/myDYyjgLOhXGu2VmrsHAEoZIICBrTfR0SGBdV9tp7a
 GTyr/gqpkNMmhfHsCGA5FfhwC+Rb8bnBjR2d4Y+zwf0ULPvz5hAgO0X5gzIDiPq8XuL+io8Pkzk
 0wTRKJKPU7gpoWbkjQ7DKXhJmRLqKCjpvRgFkwApoDwErzjkpN9qSGQXPSG/Vl2a29twUfu/qga
 ZQvKwNrtDRyCqdmioVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX6P+z8A96h/IU
 xwYknQRG3jx180cT8DlgzL+Zur+k4coR6YzX6cf7YwZSqGrAZ5Xn4WY5xzCZ7CSQ4t7DlmzBPip
 ccPuMMDqbQIaKUQNWGZoT7wK4b4H0e0=
X-Proofpoint-ORIG-GUID: WokCdTH82pdmRbEVORb1UqN2v2S7gYcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

