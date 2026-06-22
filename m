Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAB1CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbm0n-0004X5-0A; Mon, 22 Jun 2026 17:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm0h-0004U3-WF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:16:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm0g-0005SX-N4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:16:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJawkC1902551
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /q817DvL06vSoUlR5GSDEt3kdu31mUt/9QtXDB8NS5k=; b=PnZqFNNrcLFZHF/W
 SvN3dkkl5YHbYn4/ylnVsq9oavYClyh7HxwP2pkhTdPk/f8bSWLVMLKTdEOztpgd
 S0IE3oldp/2MHyYODganCCNJGRIBm4CzaTAwWj/2fZw+XUbGc5Mq7fU/NPGoGWkQ
 5ukzWyolk1Sumowd+BaKG4k55LLHvSkDOe5NtizhttBMRnEn6DatFYXF/CTdVIEK
 /3/IbMVPwNAfO6+RVXV4UT6WohENHar2hVV80rosNMduZvT7IupTuHQ/2VNFMXh9
 aDbvuE26hGWo3/N2fcB1utc/FsKnmLHQBGG/KIHnI94U9Q2rSPowdGGZ/4oYFaiz
 7O1NYA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1ucpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:16:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-72b09f14b5fso2176286137.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782163009; x=1782767809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/q817DvL06vSoUlR5GSDEt3kdu31mUt/9QtXDB8NS5k=;
 b=MWEssthdR+gu9UViV83ObzmWlJVInziy5ofsgAx57biURMMyXf3f6xPrBxERdauZW7
 W5S0zF3rrXO9yY1+2apc2YuklrfyDhZ6nmNPmHmY36dc9GiIOO8ED3ecYCIfkz0bKNgP
 dpCxKlbOL8ObpCvhbodLiE+N6Jw59DfHJHlvS1nMo6tYeEnCVxKFRYlW+DBmTsOLFxld
 faaqI5elX2bwmJ5BZkC6d8A3Y2y2u7Opvm8EN3pvLyvlE52T8gf6eBFyYr4vdKgsqzUT
 UHZx2HL1IxFRDDux9N3NVN9gB3dY0dlvVYi/JnW+mrKxjRiQE1UP5Sm0gODAkdf4dh8j
 E4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163009; x=1782767809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/q817DvL06vSoUlR5GSDEt3kdu31mUt/9QtXDB8NS5k=;
 b=K6N7YADtdjG7kAPWszPssSEnjWB6EiBzSz85mud3xsu+cWirJ+ha2tEZrqi4UvQZoh
 XV0iXzv8/FXiiICK/lbsGCGc0GA+LT91nJUuCIO+yFemkdo4ceXv/ux47bYpw2jrrr2x
 KVqR3HXaY+GTmSL1eUr9+ZcPq790OPHAzPEbKofXhifktW02t2mNRDB0LqMCu/yKugKx
 lSco12Qw1f/Yd/T/XTuccvctTQ99ey+2lmb/DmkquPHQ7Vs81HYZtgbJ0gFejJeGQqie
 tP3xeAY/ONUxsJJti1wosydwOJXOJT9eGcmxH6WHAI+pcCtURhCxPNH4nzBgdUNKcsfd
 hdyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9A0+IsXrH1PCK/77pBo0L85X/kg6Clse535oJK8RIq+by+FLlQhVvglhSRWPtJLOVYN6ZJSAxbDItB@nongnu.org
X-Gm-Message-State: AOJu0YyyjP+iLagx8Q0Jfltq6sU2Qpr4iDffEfvosNTLO7VGhlcH2NoB
 Zdfmy9ikbX+JD27+ED5VIxGcIYpq8UEOH4+1vnZdhE6LdK4r0fUMcEg7S2wwOFHpqFI8bFVFJdz
 u6aO4C7XmLbNDTtzQkIY0uzr5JuSHu0Rm4hx7jdGUiFU6JTIkGn1BLujo9A==
X-Gm-Gg: AfdE7cmV+X2zj7bu4I6/LgQ+1GFdqUCV0nH+vxToqLOnVAwMsOtBXpxOaCQwla2Qxk+
 VDwMBLQPqiFCuv9DHrHPVLXMV1U/N6HZEua1dBwAf7aZkirmfxQWyxQyePOrInmWb+MYIdSjeLY
 TIQkqT0M9clPns9X/DJVIkmGkDggpJCrC8rsTL86pWbfJTJYvWUAC3hGDyg8N4qZgIgcZAnz3o7
 lg6mXdCDG1ENqwp7st1mE3X/Wvq6oCju66lfY7sU4qUohBRRIHlp7ejxKAotT80XQ+FFEpqonqc
 iDG7tPXGQdsqm4z+bmn2qQrT68Vxc85NTBYGRYDcex1GKHo0riWHvoIwM5ozdxEg1lkUf+HDk0R
 QKQ2Kj2B2nSySk2zwVejkvZdcyuVN1QOmotSv6RtUkmd0mZ0jjYaGsYVLGys1GQ==
X-Received: by 2002:a05:6102:c46:b0:726:cf2d:6076 with SMTP id
 ada2fe7eead31-72a2011d6ddmr8793043137.29.1782163009225; 
 Mon, 22 Jun 2026 14:16:49 -0700 (PDT)
X-Received: by 2002:a05:6102:c46:b0:726:cf2d:6076 with SMTP id
 ada2fe7eead31-72a2011d6ddmr8792838137.29.1782163003956; 
 Mon, 22 Jun 2026 14:16:43 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238bfbsm254518305e9.5.2026.06.22.14.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:16:43 -0700 (PDT)
Message-ID: <5a7d1354-74ba-4550-9ada-03dec9845793@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-21-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-21-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QTRzOlyNhzEGKhU_bJxHwkC3vJY4Rpoh
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39a641 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNSBTYWx0ZWRfX3rCsYCizadmD
 meKxLUN/W6e+JJe1RU+JYdJrye2iQ8OLAYK8O4ggNGNHnSISW3qi3fT+Vp1XKBX0H9i7vODOTXz
 sUYi0Dx9dqTQXOs5s2KOi7PxYQO1aSg=
X-Proofpoint-ORIG-GUID: QTRzOlyNhzEGKhU_bJxHwkC3vJY4Rpoh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNSBTYWx0ZWRfXx+5UGbAimGsI
 Pj3K9Ecu1CaL4DZh3PxTUh82xFr/L/jmhYLZ7vWvmIDRzKYr8iHywEKsAVfU9HQ2s0x1B0LcsX8
 LsQqj+/aCvuFWKzQlDj/CTiQpFzxBC7rLNHhb1F60LdMs80GcanwSyZ1uS+WQQnz5iuQwJW3hQm
 3BwhzJcAwrWClXjCWaVtgrZkSeg4n21hW5AySZqRBJG2FNqYlaqJwdwhviQAdkrYK3khcJ3j+pW
 dnOZX3KNnC/nA6UQFSZTvTNJxVbTPwSqDi7Kkbeca6AxIxrzkMvUuMQo+4M2FEsmbl78TnQXRiW
 LXW/zYaNRsyJr7/zW4HpZwWuill4xpGu2x//kNkJ/Y5hPub1sXs++9YyckdjhokbnKbP0CrON78
 M4SbjX4+g4DIWaCFGlRDL7yOnlNaj6BVlcsMVZP3ik448dWKPqY3v5sB5cj3vnlmcJYoqFqWOe2
 rpCkBB4YG8/W0U0U4ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220205
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> There's no need for it to be in cpu_helper since riscv_aclint is the
> only caller.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/intc/riscv_aclint.c        | 8 ++++++++
>   target/riscv/cpu.h            | 2 --
>   target/riscv/tcg/cpu_helper.c | 7 -------
>   3 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

