Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC479CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP0g-0006Vb-Mt; Wed, 07 Oct 2026 06:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP0R-0006It-5t
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:36:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP0P-0007qS-NC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:36:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jbhx3298317
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7SAZssxnUkCZ4dx8LfnJ5XRSzguklYmWiWvbceXf0QI=; b=kwPK7aX6jPg/toUy
 wheFYhqcxSL5SjAYSKfMkoNsmAmEeInxKXFn2JhqQGeyr2pvK1Ltqh8MT7AgxvgN
 5dg3uacX2Cy11SVeD8e1lGTi04xDPuQ/UR0JfpCD/IKKv2ujQsvYQGow0otQRCN0
 wqVQcNvBZV47PGKuuAb5k/MfbM+OhpQ06U4fc2xKewjtZOrhiY2L/hYoaE5Hrzpv
 5WW6BtoPrtH9CJEh90oafiS39++O+VAzAnbZaNZt6B2C+7/A4BQP7Wewm00SYVYy
 Lk5gBz/6/vvVwudDNTa7vUnJwAGD+G7H+kU+seGFDCvXIAstDzuMUA0zkY0+U2N0
 EWfJng==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrnua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:36:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939c30aa9a0so456327185a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791369371; x=1791974171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7SAZssxnUkCZ4dx8LfnJ5XRSzguklYmWiWvbceXf0QI=;
 b=U8cXF1dVDmWo3xrdhwCyhqKZgbxQzAzYZziI8ZVovNMFWiZ58oS3nM+mx95YNhJok+
 OTLS2nz3xiHHkKuvsPA3Wb11Jh6nK+9nEjSAVLcYI3WipE9wcSEtoEiO/Dvct4V0bNYr
 L7q4KVqNslntnMKK9oALm/AkNFtPpy6PzLDG9R8bYv7W5mPnhb9xe8TTmIKC/JanEMH0
 lBuhceZwkDqC0xmlAZaHInTReGQIhAlYAcDd1R2P7sdqTUVXUY3BmlldwWJakzpsgWzf
 GES9yLwA1BhwuDkZ2suJSk0qWMXD9Lzh2ldF+FhvyS2m+nqUV0Y6feIBEHyXVOBG/kQ0
 IdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791369371; x=1791974171;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7SAZssxnUkCZ4dx8LfnJ5XRSzguklYmWiWvbceXf0QI=;
 b=EJjOvJhs2+lmLBDUMpKV/1JM3bcrUF9N+d/F/A5LeS36ns6p7wSIqze9+po3f4YPvT
 VGArNCEgjEGVHFvVkGGGhxpF3dGGvz6OZNvW9fb4LUb8dfyKljj3Q0npRadmk1Xk62/+
 ltLkNzuZjfUz8hAv/aMRqLK0A0QKxe/64ek2fY9qhV7o7gb0NSLVHbJmkxG9Fit5ZgT4
 c2kjq9x3V5fkx0Pin1lgDIFlYMd3+g5ekQ8N0xfSYw9GwVhpw+2nABy8pu3H3Vbu1rCt
 mYOvqRLq9hwEccNRXWaxGwoPCnwsMlGHj1igeItKT3SCE4ti9agJ4U68QhR4FbIQoUIq
 P3Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxthyBZ2OIEtpjZMZT9zBOOPtIj6ITvSCS3U9PBSxVa7e8pd1PYJrr/mfjQElD65kcWsFMNE1kDgz2k@nongnu.org
X-Gm-Message-State: AFuF++kX1g1cgfdTHaXGC6ox5VRNCxI4fKHKuXPUMKugirJpixrjlEMm
 RZvVYCrXULtWgIkKChWYiGw9uVwwXCCmOsqorebDLIwOt1mgnjadjjgfLrqCCA1Z/NT8zMmwVY2
 KD7Lse2GJsBpDe1PSf4G0TEgzuqRHFKN7acvadKnqqGbSjLCOt9P38TpLRw==
X-Gm-Gg: AYBFou1wKRUnY6NY4oyv/ahfw8rzv9WoiBbL/jeH6xgXV6FONkVP2LdMaGPU1mXzd0+
 KPY3yQ3rXGfd2cowj3e6bZvlgIhowNMzOdnfrLbkKCIAvqshfG3wG4sjixgRAwpgKNLJMiVJldB
 l60jOy7gyRv7nVsHvK8+sz1MeFohT/o4vyvuoYZ3s/78gyH19pX4nyrT7gFe8el9fqra0BmEtlP
 a63zEUbi2G6zoX7t0nyB0w/w/UwVZfS2t2qxgW8pwjjCSqD4V7x9rjMBTgxnRrYLoobmQG6Ozbv
 bH+w+vfD1B5QKF4J5SdjNEssF03gHjkRqgeR5gfGWTmY3VESDAyrDkNTrsjfg9CDORNI4KRpkVR
 kTo0REBj5U2weK4DTZ3TjuaP69CWQeW/Wkw==
X-Received: by 2002:a05:620a:408b:b0:93e:9808:b9ee with SMTP id
 af79cd13be357-93e9b88bf27mr375632285a.83.1791369371041; 
 Wed, 07 Oct 2026 03:36:11 -0700 (PDT)
X-Received: by 2002:a05:620a:408b:b0:93e:9808:b9ee with SMTP id
 af79cd13be357-93e9b88bf27mr375628685a.83.1791369370552; 
 Wed, 07 Oct 2026 03:36:10 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f51beffsm62449715e9.2.2026.10.07.03.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:35:53 -0700 (PDT)
Message-ID: <2b7245fb-e388-4bbe-9c42-8f1f8b0dce7b@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] target/riscv: Compile time_helper.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-17-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-17-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fpteRE-r338kgfIvHLhxQqPO5vlaDuNv
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac6209b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dREDruNvXLWMvVqCjPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX8lEtsh1CbjBo
 Ni3/O5TV4IPbEte/K+dHdI0RQETauLZX0/omIjOcuqYQB8tJoYK4y88cdFgSiyCWEj4VwK3OX27
 AtLReKr7yNmwGS43tzWb9IWTpiT1At8=
X-Proofpoint-ORIG-GUID: fpteRE-r338kgfIvHLhxQqPO5vlaDuNv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX8ezG5fnQwM8E
 UeiRvJ/8EUWgUmajM1xyDYrPzZcSH7o6VGOl6zfu3C23y8zkplQGx7tNYhFb2SRKvNX77dK/TW5
 TItFyv05rC4/QXx9t3PV5HILQPXkjeXpWZFEp7gWvejizMH/LjPaDXWVf+QnQS6S01YhTqyC4Ki
 u0h0PvIe6QP73o+uiqeyu7UGL5urHvqrfPQBPj4a+B/laD5s2Qioy0RSGZj2vsGoovBxeok8Hab
 7RRqT5KzM5Lw+ZUofHJ9vNWv/zdgNyOO/zNjOju0DA83FHoqefgoKDgaumcyo63DELoFyaus++g
 R2Os9fx/uDfc/7fB/Zb2Bz1fM5T5+DV1yt9hTW2M4mmGDGdSdrrzavS8trEkb532rIL1gxmajaa
 5xHxUCIc1d0StZazCmzd0na7ENiuqj4sUeb2w27z+DOFucr6eauQPTfZvepTEUG0daQO+M80/1C
 dNihnbIJAXM3Hrk095w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070042
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

On 7/10/26 10:43, Anton Johansson wrote:
> File is already agnostic to target specifics at this point.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

