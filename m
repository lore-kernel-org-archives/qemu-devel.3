Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A528DC98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cDb-0000pp-5u; Thu, 24 Sep 2026 01:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cDX-0000pe-Ew
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:41:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cDT-0003CR-GG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:41:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5ea4l772807
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BIrFC9pkFgQvPvYi7E7vCIL6lfL3G/0uchFyLxXHr/o=; b=ozDUSswuzOuPVhg2
 dwPNndp15e3DJDRskXWXpWkqd859cLA4VS8tN/Y5tmsTaXRufIgNIQUReOlukaqh
 5D1hZ6WNuknY162OU80YFu1NUdEdPtQm8lHdT4pnjQGNuWQbCx7k2m4gRhGQN4nw
 A0aXmBv6BaBQ4VzYRojhxdS8UaVMALdolZgW6mMTk0P8V7QBOuEYIfMoIbwKbqTH
 tTqgZuOCeRFnZTN7mEk0nIVrEwD17FDP8lQ5QbDUlr4IbVvOlNWjyJK4Ac/sXDcP
 A4x9lKhVMBAenyI18ILORldh94SbmzS4QfzJRw4gm9i2Gidadu5GHJS9AXZPPlLn
 pI/udg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr9094vp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:41:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so98770385a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228511; x=1790833311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BIrFC9pkFgQvPvYi7E7vCIL6lfL3G/0uchFyLxXHr/o=;
 b=eyTfkxWvnKjo8UUcgJ32nipklub6FMiYT5mKuAsMIJsw5oFljiQtpvmk8yJcD/HpX9
 2K+tplJ2viIVNewUR2K+hdfkFJrb0ECOJS7jwuI7rb4JuvP6Uobp6+RFgHaNgoXLm83D
 SikKugUbVOkhNMQmjJF7BrCQJOVKt2jjyDzwsm1VuoXW8adIdqouS4aOj3XRWLMhXphV
 yonCnauxzJUjqCfPzAwTD4tybdvmCjnoTU0lvj3OFBuU4t7Hvlr9uLGZA7Zu0Tsfoftn
 2vH+cp8lowiaTMLGVdtGF9mzdk/q+8vkS4BvKz5Kl03rLxRXQxMQA0tkxzLuW00qv4i+
 NnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228511; x=1790833311;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BIrFC9pkFgQvPvYi7E7vCIL6lfL3G/0uchFyLxXHr/o=;
 b=af3Ja1Tng3rh635mp+FO42/53hh1w8HxkrZHWHQPkxVaYKjB0dOwLGTBeP7wEJ5d54
 ZMD4TtfLRwR95M/4FXUU5iLXOkufTpA8F984tHjjQvwJdaXdeHLZHbIv0QGCS838pdPi
 R8ogLoHAeQZr95pQ3FOn+rk49ehZzIPNAN5BM4N6G2yjLobSQbyN+3jLilQuJ2oIKxBx
 Tv1J5DWTsbOI2UlC1T70dvl17jGA+S5fDDUGjvB0E14XdJItx1macp3IJl8Ap7b3Vxx3
 BXWltfR6h94AWEFC6tfzDCmDFJogDuaRXNttsSu7rgZJoCY//KJ4S5P346w2Z53nCj5S
 c8fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvFaKSE7cGgZ3m5vKpoczrv9+cPKoRb50RxljEXTzBjluDCh0uo28xDlU+hNRn3i7/HiMF0d79AEzf@nongnu.org
X-Gm-Message-State: AFuF++nOvVHSbidPRGXE3WJj7TuNoI3euN7SjhBUXiXFLaMhAwa0U5mg
 W8RWjXrNw/FBOQeKvBrwQWyq0KWpcS56Q6FVKWabFuU37oqWeDcs8sRnJ8Cn5NAiQfcaJ8zQdZY
 WEZ2dHT7qC7b6Yb672YQnWrktciJajAZcPMdNZZSCaiMDQuNabEZQWWlZ7Q==
X-Gm-Gg: AYBFou2KOtSYYRO+tbukyn0rDVVVUexmkr0aCfld4ivbU8OWz7b+YYdAv1K53Hr7Ogm
 QQwRckCmtQ8fnWp4O8W3HEm+BDpuBvf+pnynJREm1WPcqeFDERTNi9bk3jND1dOYRK7shZ3gQW+
 DY5ON+0gJgQgepRLdpxXSBPssRrOu1Ou3ZPosf1s9Z8K+TkhxQE+AfDpQdWbZ8BRD5st+xxlGUV
 ygeL+DHnOiMW+Bsu29AYJtrVzpzl19viSK/IdgZNSf6fv0lAu+bga0UJINNiDmdYDSGi+waNg9W
 RkLzK+lUO5O6+x7NRgF33MgVaGlMyQAs/F62f7yI0T45jOWClNB2189295lM2OXQxoyRw/ry5+P
 /xtnkyWiOyLIxeq1t/t1378ul1sWSl5KA/w==
X-Received: by 2002:a05:620a:2556:b0:939:b053:ce44 with SMTP id
 af79cd13be357-93c366fef3bmr110921285a.22.1790228511533; 
 Wed, 23 Sep 2026 22:41:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2556:b0:939:b053:ce44 with SMTP id
 af79cd13be357-93c366fef3bmr110919585a.22.1790228511085; 
 Wed, 23 Sep 2026 22:41:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682668e7sm13411287f8f.4.2026.09.23.22.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:41:50 -0700 (PDT)
Message-ID: <13dba0ae-fb31-4644-bb73-771afec8fdd9@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/mips/tcg: Drop zero optimization in
 gen_mxu_s32mul
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX3EcTXpQmU8sb
 obNcTu9wCNbEImRo8aYEIDS9lB5WeN5d+UlEJq9ouy+Ao9eUjgDucqX6KcfjSsI4e3DKcc+n7zk
 mp1ewCiqMR8ESKFMwTBR4QERm/kRVFE=
X-Proofpoint-GUID: DihTGgmjiWvO7mhjznIbbYr1mkeDGkI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX7K4j6Jl2/ML6
 vWJzongV1y31a9pVMNDe6FStkzhfLdyjXkBFBtIQG6GHdG3T0jlaU82aGBeaPWRHibM20k91qOi
 3CNy5XZxZtqCzIxHC5jIsc8f/jcfhqC7q2VeeIAEBPliO0dyhnnP2BZwd9fA0wjebFtLawBAG6Y
 Wh6X65vU1j56PIwAqJj5lmQMGs3OtLnlSZ1vsvDasb5BQpPOfwoYKnyQzGT6KDQcQada4wvPdM7
 bzWib3GPrtpUnoP72gkOQ9ALMVG98U8ITIxTYTR8UG1HGcBa93xYMeqsJwM+GRTZw5OD6f1Hx82
 mfwbv+W8t5XCIrhRRyyL8KnJyWi2FAEYr7M3baJVG3EjVBRqBaauwqCMaTw8q1tg++O4uur1136
 jCc5ljYQCX8EcR7a0Aq3aKYsjhWrp3PgY8vsxVq9x/tlQXI0xD3P3SYfMkD6RPqQGYjiBnVEnHd
 NgG6S6Yc+eCVhwmrx+w==
X-Proofpoint-ORIG-GUID: DihTGgmjiWvO7mhjznIbbYr1mkeDGkI-
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4b820 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=abz3XTd6ouS7ev8uitwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024
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

On 15/9/26 01:08, Richard Henderson wrote:
> In the unlikely event of the architecturally valid case
> of using the zero register as a multiply input, this will
> be folded away during optimize.

=)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

