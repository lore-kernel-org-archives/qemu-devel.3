Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E08BCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoxe-0005Hh-5t; Wed, 30 Sep 2026 03:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoxc-0005H6-34
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:42:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoxa-0004QV-Ja
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:42:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dYoY2433087
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sNI/ONcz0BO5TiBOzxdhj9wQFNqeB9Q8q0ME/9IPDL4=; b=CuxTWicKlz6iz6XT
 NJcJ448vJsgZGNRFqP0qSDSVYsydhymKjcuFrfaCUhQDB8rYLipBm3H2T7W3Lc3U
 Th4iE6qk4hXv1XT9djgIileGEvpeU3lZTYa7szx9gPKKr5k3Q8kiqTl6MfEMVgzN
 /D2gddzrUO0+x0XDUTzOVQBuRpHkQUvBiJJti4NTGkgOe1IuW48ROSXXsT9jCQiT
 ytzYM440PNrA+UQ2aHJX/ZCNCZPNg/QbcQn/jsX1Hv930wdSSnobGbeFoBcYDiqu
 baLk9U8XHmqHAApgNOm/Q4TsmjIlaIfgMN1ZsmWI8Vtdf1rUgWEJiF5KHgD+hHj1
 YEzAGQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0yh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:42:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c444b438aso1094456185a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790754156; x=1791358956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sNI/ONcz0BO5TiBOzxdhj9wQFNqeB9Q8q0ME/9IPDL4=;
 b=W/Tw8QEYSDlj4Vj72xQKoKI3H0UDB04uyx57r5mBPlZsyns4dub1DxvmNZVKBatnoL
 p8KvtPiatEfMudv0n4XXUPoYlMl3rPN82OOjW/9yIV8HTGlzNLVX+uc/Ip6loup16fGa
 zhzJ6Xhotf7kJQQd3hWP+fBOF+tibQRq6nnHHwWXsw6gJWhjevnisyCzkoNgDK6JzF/F
 W8+GkI+PKy23rx9RZEreOI3aqo5DlejkefwQEtlA4DmNr9lrwpSWRvTj7DlQM5pi2Kl0
 IMdxoE1gL0OSe4OqmL88jUy7DwbcvkSJH55SYeu4/ExFyZJ2KThue8j8r630dXNrIzI2
 2igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754156; x=1791358956;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sNI/ONcz0BO5TiBOzxdhj9wQFNqeB9Q8q0ME/9IPDL4=;
 b=lZbuNtNBIXAjBRD4kTEKH1V3nrRG02ruUe0VEBjmjKbewzlfYTWhivQ13MAVfC7kWd
 6t+aoEwvA0mbN2eIMgFv23iQt88LDcaWwL+0H078eOpRvpU//p6Fx/FjV90CQkIMd/FN
 QRE5sKdr8zPdoPpGDrCU5A9rUWf1Uq0oHBT4QGE5jy1p4eaHpULNc6eMSMM1xdIWscjF
 yO4NGxk7RrwFqqlNhJvX//4Er7elLwDidweqIX+WC0Fi2LGAeRuOfGj79ln5Ml46RlaS
 3sAIhE16D3/MTGqW0RRh0ZNvbP50o2ZlXtLA4Jr+rx/79QHlPSk9Wz+4rhrsySk09JKI
 SxcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3h0PwVunf7vl6DqojLqlRgSovULrFjMYPbkV3YYm7xjrk2eLwc+vtpDpP0InyqOE6074C2f2itCoW@nongnu.org
X-Gm-Message-State: AFuF++lmTo8cyJS9iL7zez8LmB3Pfr79oEyJ5TZIBd8/Mw+5JJq7usv3
 le0v7DD8EXydod6xUCYgQo3qWcSw6mut/sZPWs6nxffGW0zH0ug9/ew+01A7Z/6L99xu2qWqS3s
 bywy0KMPlcxB7qSO9ZbszSwDHO6cJAUwIchzN/hSuD5CyF2Q548payFLzbA==
X-Gm-Gg: AYBFou3lxnOflRWTtRQ1CviLzf8ARH/NBt1YpqHe91xwa886AWk8KW0bHp+cbiUU0oZ
 lfNDRvFPvgE3ozDNv8xd48wEosJLzsCSEGSAFeU+1VcHkIFaQb6LS3HkoqnxtnByksquBjCbruX
 36NrCL5tmCN2awfFuUR0RJbDzeTzB4Qi5/ARm0jeMTbIHnr8w8dEA901b4B70RfsFBzjdBpqncZ
 kOd7d6GVHg4XGY1FBOXie3BTfIMtx5qlPKvaYFkwEPoCCeWjcuJgeJEs7lCjHnzoOwZ1SrSU3pI
 SkD67Ti4EzGMCjJDgmjm52IrLxKlKvuMmozrE5BxTL10qBRTlBZnOrrx3aqMKpTAERngo442ebs
 5b+PvjoZtqNgOZjlOX+8=
X-Received: by 2002:a05:620a:269f:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ca97c6111mr84272285a.36.1790754156038; 
 Wed, 30 Sep 2026 00:42:36 -0700 (PDT)
X-Received: by 2002:a05:620a:269f:b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93ca97c6111mr84269485a.36.1790754155495; 
 Wed, 30 Sep 2026 00:42:35 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015a84419sm28422565e9.1.2026.09.30.00.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:42:34 -0700 (PDT)
Message-ID: <6631b089-8bd2-49ea-8b66-d89e07f53b58@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] hw/arm/aspeed_ast1040: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930072501.2612119-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcbd6d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=tpBcqw07G-8aa49P_B4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: 7L3xWY0RxhLA6lAO59TS9HhcTX_msiAT
X-Proofpoint-GUID: 7L3xWY0RxhLA6lAO59TS9HhcTX_msiAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX9uUFHGzaFeag
 bJvFrx3OC6yxojpY+q0WOSNzYcVPUxW6CEU3PnhLz4h4HokblJRiZMRwZmh1uast0pRKsSRwGlw
 UA4puaLLRJPifYa2GlefItHqHxzruwJQ7R3LBAHO2y5AsnKaN7QJYW1Fq/lJhDR5FR0p0yT8y8o
 IJwbCaTvaf2mvZxv4tty4lt3AhO62ZodcEslWJw+8BT1iotTJJnjl203uaDBCgdPAWHNBkZfJeV
 ZgvlcS7u4n5ZAmGz3QhinPr6lG6+CLcDoBo3EFhmuRnbNQs2rnaQGwmoJOHilrA2PKADSNdHr69
 7/NSiac8Zdl4PZiZ5SZRp/RPQBarsyXDceL2rV4Ca4iiOq0KWU6rw4HXNGjxdTlKlJ0yr5DTiZN
 AmJZESV7qec14X6d8Gzbw2XYbn/977O1PTYXcO9RmvvPRx+ohSjnKR0qD4NfbL0JQ5ohXeh5VWj
 MWdLbOunAUijBCg4l5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX6Rf4z4WgliIq
 xWICsgFbRO9tvtajIn0K/Sn9iLd5YqEiwAox8YoIFIdKdHKKOHF3gbR8fWqiYlxjR1gMseHxKsO
 iw0VOdm22osy2wBx/jScKw7dNlG90cc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300030
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

On 2026-09-30 9:25, Jamin Lin wrote:
> Before this change, each unimplemented device needed its own field in
> AspeedSoCState. This made the variable names confusing. For example,
> AspeedSoCState has "udc" as an unimplemented device, but
> Aspeed2600SoCState also has "udc" as the real UDC model.
> 
> Use the "unimp" array in AspeedSoCState for all unimplemented devices,
> and use the AspeedUnimpDevice table to describe them. This makes the
> code easier to maintain and read. Convert AST1040 to use them.
> 
> This also fixes a type mismatch. AST1040 used the "pwm" field
> (AspeedPWMState) to create an unimplemented device. It now uses the
> "unimp" array instead.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 49 ++++++++++++++++++-----------------------
>   1 file changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

