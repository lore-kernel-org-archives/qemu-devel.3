Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E41BCA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFIVX-0005sZ-0l; Fri, 09 Oct 2026 17:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xFIVR-0005rw-UO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:51:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xFIVQ-0005zx-0x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:51:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ki5Us3372676
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 21:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GDv03abaUgsaRgeFJ+f9XtNAC6Hxo5B3l2j3tulLiwg=; b=KPAo0Sd4cMODECop
 L9XsMf3CqNcMKZos1DFv9tf3ArAUvpXMBZv550g9CLnWxtx+Igdbp+GhfcM0Tezd
 z7vPWe4aPtOFiIZ9GtaBEfPRpTBhrwaoICIbJ2Wx7xCd2bKqCwplxnOVYbus/Q4Q
 rPpavaLQMlpCBPV6IUxbHrCDlvl/E40PUtsuUkzXvZFlx8OGQ1uSSJhIhrunpU1U
 /gi6HszfHXzIdv9WZvRUcD4E8GzoepkplKdRGslhr+Q2NONh2HSQbwfBgbFeWEFy
 Np0gf/SdxyVLf/gqmpc4UXtQjhk+SVT6zkHJHxqYTNheDv0/1M2t6saAzHkUKH7B
 trLRJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8gur4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 21:51:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc359d9easo21858385a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791582714; x=1792187514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GDv03abaUgsaRgeFJ+f9XtNAC6Hxo5B3l2j3tulLiwg=;
 b=Dh17b1AJEjyFev4gaCDbCI/NA51iY0SZio4YHt9pIHWashSA9HwXfUvQoR4v7VvSmo
 7h201jHD/abht2INO1FnXvForIdIc9OrroJSOOZn0+QyvLZQqHo0tj5Yq5xx+eKf1DwV
 puYaolLnsmcLJTAayqZMwVrQ+bXn31PzcE8p6wSV6x5DNI+1H53RR6rCHye53bADKWuE
 sAMW2BYP1G20ewRaucBTMlgf4l9D5EQ45NY/M32YHREo13spjemLIul1QakV89Nm0tA6
 SBgfjvECbWCT+n4N6vykYqc7ibBlI0VwF4iiVgpGvrGH5DKRi4fkbYEfIE7oSlHZNO4F
 pBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791582714; x=1792187514;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GDv03abaUgsaRgeFJ+f9XtNAC6Hxo5B3l2j3tulLiwg=;
 b=UOeOVvko+QbLLRcFTDmMGnHTnumrvI3vOeWlbTDNYUwM/A0o6aZftB6BHZx9JOfyFO
 9Jj2WWBV/RhDO4LVueJ570ybFfMCv9y9ImXjP9VX48qDsIv5xQx+2DmnH1R0Ycz0E5sO
 XXYpifXD3l4dugbrYXq3S9ZhZxGwP88Z6k3oYtKPv6YhiywJ27CHWSGwY5aLTOjkElTv
 xzEgy1OQJcqQ/+ffEchqFDFOqUyXJeO7Jksw9YROIEpaGjfe4DtsI1JV9IGpiPq7XYib
 nDRHmnrTaxGg5vpOVPTsJL77kny9BaXAD6p0VxQe6jQo7w+ceZkNqzumFKH5wCtDGz3R
 wqSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgvGQusWbakaCSxW8JlAo9+oKI8XoBXh6mob4hCZ2NXHuarJhytzl6BYkdJdGlk55/OJKrtyzdOuQK@nongnu.org
X-Gm-Message-State: AFq9FYKck6tUlNNiDaJ+qhY1IFx7tw35m4u4B4Ded5M71/sdSMTFjsqt
 z2oKtW80ZjB0Xzoh0TX4iz6HAUrgmHXd/YO6DjJzemRZjO8YXuIk/n5rU3OIQ8VA7SK1W0Euhkm
 OKuxT/Xnc9xXADDHXeApQgsskRYY2AeU/U8wZVzxDa3wEx0SRm7mjp1LAfg==
X-Gm-Gg: AYBFou2ZYW1FqbuwX4SZQRISX6rlZpbiqCe9wRbuk4HW08O/iqx7BJuBWVIMXZv8y8J
 WuLRxwQ8VkaCR3JNbUq3yXKeyo0a1f2NW8pfOjf9tU+BoNQJnXAKjSKLdVixd4Exf4JbfiAOX/L
 XUVCDcja6ULo1WQfSEvoVVW1MdTeLAPoprc+jlVSqOGETb73JPRpzN3SEx0KQDkUPzWWH2+ce8q
 77jDFTTvcttcQ+jGkEXW+7Apv2+qwyxPJufmwqUKdiBpTg9eOx6CVW4SqBQX9GUa/dSsJ5TMEr6
 +u08NXslF9/LsN5pUc6l3e1jwl3udMgMZFO4kAngcC5Q2tJmtx242GLsBoKtefO7gYbF6j8E+8B
 +lOholmVvHSkn+7RnYtVYur7biEdkO4Iy/A==
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr471201685a.58.1791582713514; 
 Fri, 09 Oct 2026 14:51:53 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr471199385a.58.1791582713037; 
 Fri, 09 Oct 2026 14:51:53 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beacd2csm92053425e9.14.2026.10.09.14.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 14:51:52 -0700 (PDT)
Message-ID: <4e9a1c83-033a-4e64-8b44-a9fc17b3b921@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 23:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Fix vector constant matching for logical ops
To: Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261008181647.3015949-1-aurelien@aurel32.net>
 <118805f8-bc4c-4600-b156-5b494a840ef5@linaro.org>
 <asksJ0sjVi9BZ5m0@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <asksJ0sjVi9BZ5m0@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX+2G5wwuFSAyy
 izHkkywR6r8dXqayuqT592DbicWibzeVnFGiC570I/84ork8QF/lL0FVoFlcnG3XxFFaPWLwhQn
 rD2KCzqjoeJTJltbvxNSzXZA9rcYdj0=
X-Proofpoint-GUID: Dwao0v4-58Trmmtncsk-LyJwFICEVhMF
X-Proofpoint-ORIG-GUID: Dwao0v4-58Trmmtncsk-LyJwFICEVhMF
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac961fa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=IY-dOOI46LtgxrX4_OEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX1bB0GHZhbNIm
 gUZbiFoGSsvMH842UjAxDHCwDiBm70mB0vkIZcaE52ljAQokHN/4VZANcYFSaKAh1keAmSqvR73
 04AbbFbApNG0ujxASWP1D6ld8C54OW8lYNfPARddprGhEmpHgiteUCxsk4Ccb830eM0Xsy7pNNA
 QIqqZ14A3oFp+QVZR+I6oJn6DLhMRZA/o+a6oYHODQrlv53v6q/zWdBtdRSsdoQ7R/FV7wOX3pV
 nTflN1lJuw9lNKsW6sc8eruUmY5G42IG55IikM5Cg9hbjuspnzyYbKMvvaBaJ8SIscVS4x4A9df
 xdufW5S+OvanpP0XLFY35H7cpZV7MdXpopS7oAbVxkyPoiBXIL6JH6iqqN76g/CcwDAHp9E+IJJ
 rQr4fbVGqYyNvftHRgVmfEYuz0F9OtxmA1BqOfdFf1RMCcdtCqpU3WJTc5YEGCNSTGRtieoU4cS
 +qa0uC6TYq3wIXTiEuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090087
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

On 9/10/26 20:02, Aurelien Jarno wrote:
> Hi,
> 
> On 2026-10-09 07:05, Richard Henderson wrote:
>> On 10/8/26 20:16, Aurelien Jarno wrote:
>>> +        if ((vece != MO_8) || (val == (uint8_t)val * 0x0101010101010101ull)) {
>>
>> Do you really want
>>
>>      val = dup_const(vece, val)


> Or maybe you just mean to replace the check by
> 
> +        if ((vece != MO_8) || (val == dup_const(vece, val))) {
Likely ;)

