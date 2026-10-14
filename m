Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E9C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4ow-0005Ix-HT; Wed, 14 Oct 2026 15:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4ov-0005Id-AY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4os-0001B8-42
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbFLO301195
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yzGafPkX13s2QTTVLXBW8HKv1ZiROX85TteYtlUrscM=; b=NBWjx28qsIbZY0MM
 7eKMCFTWLeEwiYcQ8G/m3hE26wz+2Tg7LDilLag493m9RI01JS8jm45GpKqu+Oq1
 tcjkzXtbH8bBWoNaP5sqc1pIBnuCvblkm71HPa/0pgHdXvCcP6ltfwpdIIjLV3Mz
 Is+GU9rLhIbPcN3aNoIsOEa1A5mvkmVZgB5/5Z+Vhdt4xWLSltW/j/PYfLnuGE8C
 UhHkah+H64CulPMNfkfF4gbW4CcJQnFXcw1qDtX99wWrcEAN84S6Hb6SX4fmw+GT
 uF1ejP/uve6QuIfW3k6N6sA80GDn2+jC+OpEp78F2xkZMGH1ty4VBWUpMc1Axpsa
 9+fclQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha462380y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso165735985a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006757; x=1792611557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzGafPkX13s2QTTVLXBW8HKv1ZiROX85TteYtlUrscM=;
 b=WJlLYZldm8W6OxNoH3QdK3ufbYWYlNquH3wCDHpt9DufKtILQ8YGJEHatZo1rL0oDy
 ticJ0QoDzPjfRhJhqj47ET+BhwY6hsf4sdOvDG8+e1pxtLdRDKf9eelzyvnsu4MDIH6Z
 UwazMS9a3xdmAMOI7e9SkEjJdyk9nQoSOIIoqCih3SPeasZAfHiXyYHsPPuWQ/uBNaau
 9UG1Bo3ToT/bsLPe/ElSpVOxT/kTgd4fi2CGUfJlm53IFRM8ePWbWI9HZhDZiJiWWtG/
 POI3F4HoOSTuUJFEYEWDtyfuFdpY0gvqCyVxWrqhfPnU28ARaF2I2WLPiHV8I24N9V10
 hfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006757; x=1792611557;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzGafPkX13s2QTTVLXBW8HKv1ZiROX85TteYtlUrscM=;
 b=WGGEGKQwq9Z23LVbkEo21nHrNkriccA7szkekChXSFIX/XBqrHZ1IlwtxXNP9gEJak
 V5e2cCo7zFoQTv+HgvuD5P8Dh4RrR9sTezDTqgAWfv9y3i5Age/BoUX7pMDs5pG0TRYF
 ZNDF3PeIZsQrQkkmMRBWOITzOQU+8NfZwIod9yAgTIgfIqYyXDOW/aMQEWqMnZkrpB/S
 FvkudllEcXsm55XBS/JuvKmiZm8Hqr00hW0y1HOoQ7EyjPyxpNhEIKjEtmz0l5LmVKSu
 HlEt4Skzg6RgWSt4r+Q6rmOlnFUnjqHiRyh8CnjHYwfTPR3Z0bmztE+ADSJToysXpnm5
 s9JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLxe23lfvt0lctrGZJYsZ0F56OE4AK+Oww9MxuireAd+YCUkqAbF9o0T0qgoYtRmQPFIYG7notwpbV@nongnu.org
X-Gm-Message-State: AFq9FYKgmBsgopoL+cBLl59MBfnyPyHcR1S1IFQyvns4ZWr1bY5trHoq
 /KQaUFT2uhg+rJvQqDhjg2M7Oj4ihlsY/h8c3I7s16fHulDhireCiglvpiT3hKQTcEkBpH5L+Qq
 p7SsaP/+6emy8EYeZgZbyA+RbduqNGnGaV8HiJ2W5Kk0EIAilPGntuS2waQ==
X-Gm-Gg: AYBFou2FMdzx6enylloejZq1U+k+Gx6GBIlbYIvW0uYvx3f8sbNdhlvBRXEIMIJqR8S
 vAMmy6Hs57S/EtHgxhkxd6V58teYkhnM9/JLYvdNJ63dtqZN9Q92EAh/iCsQYZtFX+p1Zcja2/h
 ++Ac02VrP/Mhn6Ghhn3aLjG8PESUkBzn2WDVhsKfYeJQ6Dat+pA8X0sxYAOBTg3xrNkHy46gXfj
 zDN75bcrNOQSPcEYP3iqdHKVlG5ECjgdV7qSYDiRqI2oYCJbnngyC8C/zEVURLB/mfG8KPMYn5v
 Qnb4laEPkp473KfX7Lurc7xqigIR0npwPyyOEgu7vbple6h1JlAUTVhgImgomaOyBsxkawW2o4M
 V+m4vJCLkTD2jDqMbVSGwXno7SiYYOy6PVg==
X-Received: by 2002:a05:620a:2a14:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93ebd2ab63bmr2875379085a.65.1792006756874; 
 Wed, 14 Oct 2026 12:39:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-93ebd2ab63bmr2875375885a.65.1792006756437; 
 Wed, 14 Oct 2026 12:39:16 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48ded3874c6sm5022625f8f.18.2026.10.14.12.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:39:15 -0700 (PDT)
Message-ID: <116bd902-7ca9-4aa3-a89a-9b91c480118d@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] semihosting: remove common_* functions
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-11-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-11-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S3wH-AlWU8h17vR0dXy0iE1KrL33GTcR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX05zuESpmkCJG
 scb1T1BuwKAi/672Zm1iRNlXkaJ03ybUOBUG3jkThHiQEu1mEdOrgP7bLUOASc3qQXGBNkh8oKP
 EXjtey+7X4HdzcS9kXWQzvt+zfCiR2UH5mdudt2yuEJOVzr3OY/1TtY3ZvmAwfzow3uNDv7JSF6
 Lnxe8hJRlZaNiNwgZf3egT6hZkFGU4QATO8jQoB2mqEdYiy38etzorC+XSpUqoqdFI+wxJ273t5
 YkO2m8kWipWYwGLEPNyByIGW6K1S7Id2exOiK1CP1eYheAGA6yNvz3FdTa/1lOCXyp88nPHteNO
 vbh1mixlX/TaJoNg9umVGQbwHjRHvhtXKj4gufKEQyb9TFIcpQ/nQGuzPFSPmWVvdT2QDm6hQnB
 Ew6S+z4R5r86sX9VCiVQq0H32i9gAc9ICALeHYCCXGmVwhO+7Dv37yVzhdbmiArGrYgGn8zBFst
 3Pvofck+yhBArV+QRhg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfda65 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXzlRT2s8625lk
 Dp2Ue4BdXpVR5Hdx1SMH/CR9+dJElu+QpGgirPCpIms7eCVB4ewQydNV5zGagu9i4Dnkc1ZUEQG
 F9BvPK37YGtx8axj9z2TRl7LkAIX5lc=
X-Proofpoint-GUID: S3wH-AlWU8h17vR0dXy0iE1KrL33GTcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> Now that both targets and semihosting implementation both use the
> semihosting ops interface, we can remove all common_* functions.
> This allows us to link together the three targets concerned: arm,
> hexagon and riscv.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/semihosting/common-semi.h   |  7 ------
>   target/arm/common-semi-target.c     | 35 -----------------------------
>   target/hexagon/common-semi-target.c | 35 -----------------------------
>   target/riscv/common-semi-target.c   | 35 -----------------------------
>   4 files changed, 112 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

