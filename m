Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F81C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vE3-0005By-QN; Mon, 31 Aug 2026 02:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vE1-0005BZ-8Q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:10:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vDz-0006AD-QA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:10:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52auI2061059
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E63u2NdFRHCtsBz8IhUK5CKk622X/NKhuhXY1W25GKI=; b=NTMIP5x1TD06JqCF
 nq7njvP5BoefAhTq0PTvKwePgQuwxgtRUZ3OVTRsG9JhxDXCDi78pmuYrm7wm8WI
 sc1iUhA5FrE5TFIzWBYFkxnvDM1xlGmnTlgImNbO9PH7clITedZ8BMObZeTgNlIe
 /3YT+6Doj1GiDgatyy4m37K2c8Shyw4uynKJDdWMMJbP9voNqv0H1iYKMqE6+kYg
 4C/hQ7kCrzfXGVDhrzXG3K9whiR/FK6m7BQ7yQaRrqfv/wfR0CN7lyw8H+bMkxgO
 t/UCfBGaFNj/16MD2B6oydPq3jBNQC8HLIqlg0z3q7dnvT9SqNpcrcm1rq9lgnEs
 VbtBWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dvqjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:10:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9390a2c895bso685043985a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156629; x=1788761429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E63u2NdFRHCtsBz8IhUK5CKk622X/NKhuhXY1W25GKI=;
 b=VjvG6AyqIQN5/x1ws54hcCwRyT34Qt3M73a02GGYR4ZYj2dW8JrBUQybNJ5AQZCuzW
 Os2hOuQ/ymJ/JyKyAfZ8d0YpLdPbygAK6yNzw2bLOQLPfS1wkKmcBdD0vXq7jWiHL3NA
 mlaVbbAbZqGZoEa3fG491DInqmM07YO1I1WfqOwFGh/gVTQDG5GtuBKeeJTWKvmIFQ1h
 OHt3XlNsci/sxbsE0sCR7p+ik8bvFyzT8ra9NvXvaoiUq3OBNyqUDxAvKcSeWnvvHIlp
 k5KBcTHSGbt+FuaFkRp2Lmwx7nXcYq8q1NLbvywTw9bQXOm9exPvO1Y8jx29R88aTp83
 fuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156629; x=1788761429;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E63u2NdFRHCtsBz8IhUK5CKk622X/NKhuhXY1W25GKI=;
 b=ixMOXHpGme6n/nvleoyz1TWZqi5lM5PAmdtF/IXz/OhlgkXtnWtqhqZV53Ri0GNtc+
 30fy0hKoDmGqhwpPYSvU3c6jy/lKtDmQwk/rAZgace/Snetd2DKH1IzxZd0sIOLx9pIH
 3BcJ1J4S+AGMrV8CNeMzhrVu2PY7nQoG3XuAJnIIMrKZdlnlCvtppa2jmd5/pQiUHIda
 muijjpVqdqp1dftodJvCZZMxe5ezhdAn2uZ3ANBTC2CTEtyuHFos1i0Z4CQIm/CxsR6M
 RfKQP3/U2bcomH4mn3oETcLTrvt0grQGGNjKkC6JIaqTqqWlowGRCEAIkzPjyZfeHJnp
 YD8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBQDFm3kTAKmsTBUBa8ushpJEkBJ03MM2zroL1lRG58h9KfBTSpIneyTp8pXlj3rE/0A9Rd8MCNJBn@nongnu.org
X-Gm-Message-State: AFuF++mUK6aR9hwmRj9l7Fow5OHqzcHMZ5qPPgzHNMATXWST6rGVRlAx
 ZXrW+N/CW7zkrtgXOtG8Y/3hHgYErn+Z8D0nJQnZmGaeQ8ueda7pVDrz2pSKmm5GMHYCR+Wdxd3
 l5iulnfeGM0snLTc5nNrUhG98djMKLZU/axsRTyaW2BWXzGwrj9Hm3IqH+Z19gKZGIA==
X-Gm-Gg: AR+sD12pP2InZwqa1F08kAPjQrbmez/8ssYs0y3qd7pjGsD7WmXne/dFU6pNcBz4Ofi
 hgb+omKdK3Rg29jot0xgNApn2pQSpAgT8GeH1xn2ot68V2fQLEG6YfZe5b8s2CWgkpBETEdGC8e
 8uX7v/vcWfNWhFOVmpusHaCVxbRK/z7/ywQlwRpkHUj6SK3OyA046s9YEm83utOhxIcY/WL9ywg
 QDNoqs4KBpVC8ubTQUl2hxNRiEz26dxgZMXhCvINTU4IMBG23Sbc9l+mw/ehOpqndY9+J/GEYgl
 VtzeEGLW7xONqUoQOeHTmrnM6xs0aFG2HW/jnTo8dIX8FBEAQwiATbqQniI/gG36OOFQZxjULHe
 KWLz2udP3VPbWIRih5hG7bvbIq2YD1O40Xg==
X-Received: by 2002:a05:620a:9de:b0:923:8612:f15 with SMTP id
 af79cd13be357-9391380955emr2125977685a.18.1788156629294; 
 Sun, 30 Aug 2026 23:10:29 -0700 (PDT)
X-Received: by 2002:a05:620a:9de:b0:923:8612:f15 with SMTP id
 af79cd13be357-9391380955emr2125976385a.18.1788156628884; 
 Sun, 30 Aug 2026 23:10:28 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm21029855f8f.36.2026.08.30.23.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:10:28 -0700 (PDT)
Message-ID: <57f222da-495c-432c-942d-a12b8ebe0c38@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] target/s390x: Use tcg_gen_lea_i64 in get_address
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfXx+60bhRuw55F
 WSIHrRDTV3EK0CiNKZmt05ZEz1U0kNZsGMyN8QUmDzmAte/hMBOnCF2YMtcbYS81czQRMdsKgSl
 WqXJ/GFiyNf4XmXSocIID9hfZtthqISwZBh3TrwwdAdR78GNMi2nhYwqzlyZ2Vf96L82EfelrnO
 xMouVeteV61uUG19ErXTmrVFfX6JIV0UfDE+ej2ZpDIuoXbJG0lBHcg6ew+MnQKepIP2uY1BI5p
 7w84bhvkvH137ZQaEGyJavsRBy/zdF6WCfWlpolRV4ngBVBlp4hqmpYwGq/e+Y6xvmtGzOt7dWr
 iO71akQJ6OkVzKgTzTj2ft6vCuZUCbSqOWJKgubGaRwwW0GyKtPjCfGje66FevOc1U+JuksrNp1
 ufrjQNNUEkugpRPmpT767keNV8zuHGAG3w5SYSf2JVlLyJm5EzUIhFVD8fko4mxlKCKSJ/DaOlu
 oaY8PCZ282EvcmVrmyw==
X-Proofpoint-GUID: ad-YR3V8uEOvqNSJn7zfymb7erUOXofp
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a951ad6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX4Yd6HQ4QCi0L
 dtkFvDJbRwym6x59SEv91uhrDihlntrscV83OO5XFJ6lvftKImXH5ylpYqqkreal9KpPSvbGKft
 IVfN8j/Nr9/xWAIxPkculxpE2rs/Q+I=
X-Proofpoint-ORIG-GUID: ad-YR3V8uEOvqNSJn7zfymb7erUOXofp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310051
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

On 29/8/26 00:44, Richard Henderson wrote:
> While there's no actual shift, use the compound function
> to add two registers and an immediate in one step.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

