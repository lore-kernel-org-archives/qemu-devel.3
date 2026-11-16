Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FB606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eruuM2qO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wt+PUgFT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4ub-0004HN-C2; Mon, 16 Nov 2026 17:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT4uZ-0004Ct-Ol
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:10:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT4uX-0001Fv-LG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:10:51 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfCdU2589426
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8YweDSGhXD9vSxuhKGqZ6Xce9VDuhlCTm7+7ppHWaqM=; b=eruuM2qO0yJMPZzv
 niTYGWQMog53nIdT1d6WketMcsJ4mZp6MQ3mO3qmob5tiyH6sYwPdiTdis8P4pNL
 N6WgpE58IT9/AM3va6PQVNbhGduU4GQAQI5QH7JVBV3AqeeA1BJJ14QbPoGeB9HY
 7etvGAYZGM+TiDZ2FPZAzWK1g9WXSxpCS64HW4GXGbvpiMXoSytYB2MWZ3fW1UH1
 +D0bbSe9W8jtxuaut+ek+pzF3P9amDBu+W3/acx/xp6BI4lSig1UmuCRnqfUgWpg
 Iy0qYWFEj67Xs8wWbuZ5WY7sou5lHeSdqIUSr/+Uzf1WG/bqm3bHU9th9IkRXECj
 8sfOEA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k19r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:10:48 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso1349020241.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794867047; x=1795471847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YweDSGhXD9vSxuhKGqZ6Xce9VDuhlCTm7+7ppHWaqM=;
 b=Wt+PUgFT9MIUPq47bL3n75p4l8m9qOYXDdi1QQzoNf8ASLEriuyHLx7iDDTN/gl0Xb
 rQ9sOzwBCEX7jPZDs1/hkYVcLH2USk+3D9cKHN5cbZTWwjLKIpNCm/fcbDk6upNi3Aly
 XFUWc4ptfwUdxweBMUNGnQ1Lj6869PIm+Zm2OOowZl/l2zhlfMUcrTtBc4oM62J7aaQc
 ExijeKLmcha896130bz0PoFjtghf4m9oivi4OrSc0QjufWBEZSgzeDXLgjvDBmmfJ3/A
 eNK4b96w3OluXy6wZ/hhTPI82qoY2G+S0wO6p2AmWjThmUGryWdzk7IaA+XgVQ6aNIE5
 m77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794867047; x=1795471847;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8YweDSGhXD9vSxuhKGqZ6Xce9VDuhlCTm7+7ppHWaqM=;
 b=zw17kUl7AkhmgVT5+V8bKZEB6/HE96s6KsUaa6kbg0j/3uPIqFl6XrPSzq2/mmYSOT
 6nLuM4jqAi89Npz2terqxyIv/HAOZrQdvxuuh5WWH4A1njDcNs0vD7tnOWYHwqOuSYiD
 0+/DqWrbrXBn2nppGD61t+Aj9jX9FU/Bd7Qzr0b1iOYRiD4ItYednfCIo1aoj27uro+/
 uJ53crPWB/It/PAtJqly90b1hDf1MHp4Mxf/tATn1EVB2OYyMbnJEzMq+WU2aMg7BBRO
 hlih6+RSb/jWx3z+FwUnA0u4iMtf9qlk9cdqVZe4Klqgw91AeZeoPk1AQXKeHTr+VZmm
 43/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHYiT3Bkc+BESQvIZOfz5QFa7ndR1A025DwDOeWPHMR9nFV8QN5BlcjwYRQG5uIMF3HtghF+dlN/lJt@nongnu.org
X-Gm-Message-State: APuU4Z+uMvrIHipn2hKeKav1T7Bp6VY+Jev5wQOhO3dkl4JUS41wGyxk
 pDYasdoXbBqhRTQWw9PNtZOKpXKLYcwbeyH+AFrcP35Vl/FrVap4Rr22KHkXkP10Moc5i/xi2Op
 2QdU4TFi41gb4CNNpZiJAIw3MCVPP6hbUyl2J1IPBu4xVfi6AQmMv461+Pw==
X-Gm-Gg: AYBFou3LoF3JvTOeWumnHM5whIFsdF/3iZpoa6bXFe5X5ut7l+KWpLG6WH1cGpWjHv7
 Y2udNtvvAopCbKfgnkPkciIPH9tDvXHCisjTfL0BApPF3Mxw3KKy1EPC2GmYWlF0trrka8mvecD
 E1uCjUqgfY2rhdy9WZGDgnb8WBARu3HQNjBUZk7T69RWBSO60e/ZOnUccQqL9Eeo5pfhua/tzAH
 gusuR4PiLPUUJ+Qt28/XeFAMMQrnwJjfxLjCAyAEXchogwzyKWr/o5xFuHPkGfWZyJ2+8udjaM8
 53yqZaY46xrA33ppmjKiBQLFPpoRSxtHFWclEYXfVgdJ8dqAWx6kzg31vQ3uepJDPJBwHW+svnS
 cj1SZ9mSAgjKrgtBImYC3yzrqdwAk5/eVEKcmihwyt3SJ9dvTGEsexHy+ZyKk0Jx22Z+UMG0kVR
 OxZSU+Q+E=
X-Received: by 2002:a05:6102:c01:b0:7c3:3890:6076 with SMTP id
 ada2fe7eead31-7d64d70315bmr3465601137.6.1794867047622; 
 Mon, 16 Nov 2026 14:10:47 -0800 (PST)
X-Received: by 2002:a05:6102:c01:b0:7c3:3890:6076 with SMTP id
 ada2fe7eead31-7d64d70315bmr3465594137.6.1794867047079; 
 Mon, 16 Nov 2026 14:10:47 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6443d700sm137877385e9.2.2026.11.16.14.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:10:46 -0800 (PST)
Message-ID: <13463a88-6ec5-4843-8af4-e68e27a1ddf0@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:10:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.2] hw/virtio/virtio-iommu: Fix IOVA address lookup
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com
References: <20261116173857.367638-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261116173857.367638-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb7f68 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=Huoy5dzQn1gHJE_Zu5YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=TOPH6uDL9cOC6tEoww4z:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX2Ndyj5zt3ORi
 Vfy1mlCHFviyZMAbfjP0ySy21P/t1q9x+Ij041gVsUdPSgLdGZ+R6sNfqBvwVMD8QjjRyeLCoTu
 G3iSDpS7eXryjfjiPBCqSbGVXVjWymA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX8CtWRlhVrlJv
 ELt4xS+N2DYZxAvzsizx0lKBGjFQxoxExeAW5gy0sLo6rT0v/WHgTQQGJMGDywmvS8cI2bPO+6s
 BGgsZuANhDqdfpVn3o+b39+PT2e9Ci7P85PaWX5ll2IpgagcayTA6cV1+ki7gFnWcnWxGYg4mzK
 TSAMdAYsRVdxDk3fYQqyttqHzExGNSsczZ1e81ix0lLBw2C197Ee4/u7cvObZfAvJ1pUfeCk1Wy
 gYg6p+XPogOlhwmWlxMR7Vwf42MdwEOchVCMFRY3AdNrLhmVVQgapUAutWvwdDnio5fzda3YCJ8
 DheUEsOiyW+pB9m90Z5afHfMs25XTSvekCGBVqcTwSDExaHbEXBtLw+8tYLLJHrU+39lW8WptAB
 BqfG1FS9qf9Z4lJgqC+TD8416Cn4lKnXEonoNQ5bzr9Z0dutUbP9rI/Nbwd/tSHwKA/PCuhiOy6
 /S4+ef8WgxIZRApbUEQ==
X-Proofpoint-GUID: 7411HTJk_Uj-aY5VIP_-Bwlydbnkr3Kh
X-Proofpoint-ORIG-GUID: 7411HTJk_Uj-aY5VIP_-Bwlydbnkr3Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/11/26 18:38, Eric Auger wrote:
> The translation code checks the address to be translated
> belongs to mapped segments by calling g_tree_lookup_extended().
> This uses the interval_cmp() function. However the interval
> is badly formed with the .low=addr and .high= addr + 1 instead
> of both being set to addr.
> 
> As a result an attempt to translate an unmapped byte just before
> a mapped segment will not fault as expected.
> 
> Example: only [0x2000, 0x2fff] IOVA range is mapped.
> An attempt to translate 0x1fff will succeed
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4754
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/virtio/virtio-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

