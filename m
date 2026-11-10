Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12316606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LfikUuwB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jjYbRSin
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQq9i-0005E8-Nq; Tue, 10 Nov 2026 13:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQq9d-0005DU-IJ
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:01:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQq9b-0007uD-Qs
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:01:09 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAExqxd2748219
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 18:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D4Wn973MFNtv8wjhtI2WktaDZA/JVu9qQI6wMbpa9sI=; b=LfikUuwBP5PrHUrz
 fb5V+aVmOVopNi0WlNY1LiN3x36Jva08kkxpBWuYc5N8amVdQaJ9iD4IBwLG3iWq
 n8zl309nNJzBL0En9jmxdhP8JdJT/pV/fs+rY6nP6Ym2Jzckositl5iio2dBZDOM
 Bxy3a1skLLFdkowMgmknEDcxhP9ZyZcsm84ZUiBPE3u7aKlzWwzVPsNeVoyW5Als
 JRwj1gqBN+dW7akCHjpbIVEL4phaxe71dIuMxpbGc3HJG1wFTW6V7Efgha4pYIlQ
 ILPEaTZjdkipSyRux7Q8+ymLe2VlXCkf/NS4tc0HxYYJymFwTMe6LNlWR4xNLNM9
 4kolBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw4a483-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 18:01:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso519691185a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794333665; x=1794938465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D4Wn973MFNtv8wjhtI2WktaDZA/JVu9qQI6wMbpa9sI=;
 b=jjYbRSinFkdpv+RA2X8bbUIv+w2MAHqKvOXXwlH2cEOzC5CQXTQS8cTePIkEJ5srv4
 gQ4VoutEM0WmbzkXORJ7PA3z6U2YYbcgvMzQQQAZx+iwt2CN2eNx+Rv9NoKvsGsbTwuj
 lySYYS3/cKtlKZrnytFNF+HYxSUYDdYCCu1J7zJQOA55UzeRh65eEYFEaNsZDP6C8k4Z
 MH4noRTgeOg3Vipbyhev3NjARv6zMHzWX0NYz7HY0wmeN+Ip/sNOXNXM4asIZRjalx4D
 06N1xg+nZmXpLkChns3vaovcyjA29spMSsrrwVkKXV2G/kPuHUbz66LA6jHxb/pb88Tk
 2TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794333665; x=1794938465;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D4Wn973MFNtv8wjhtI2WktaDZA/JVu9qQI6wMbpa9sI=;
 b=E5q74DY1vAGoJKlgs7QGLO9flLfOngkLXrmM0JJHtdTs2OY2sI2M4suCrLsYROfQIO
 QZ1ZxAJPI08PVlmY++HiHP2/UJpknIh1AXuatAvAc9Dv7qS/tGJNIUKaGIodtyN+laqg
 09ETVQbDy894Dle+YvtJIAWrvIYNnbWopDIhKJSt+/2WYArPjIivppsAffIAYpWcRE8D
 ckLZj2J9LR9CnaZVvodG9o0SNqh4lgmKsmRyx5H6Lsi5degbU7FzJaYuABaSnpTniqkb
 JHB+n33evwkxiuXfM6t2C3o1J0hTtzL+eMTdUblGP96uaJJ9mAmXStdUADoOe6vfE3lW
 chMg==
X-Forwarded-Encrypted: i=1;
 AL+hErFBg+KYPJ+EvwsqqC8hGk2aBjcohPTCvzv+vxPzOIKgdAQbbCqSY1zs8p771pPaTYAbec/FMwM/RnA5@nongnu.org
X-Gm-Message-State: APuU4Z++QI7cmHPw/zNZUUVpamoOkaNJ+xJwgx+UlF3oHAgykBgvpBJ+
 8/kuO19uiZMIyTbjm7OenAjasrh1cexevWXFvPlM6tRokaXomLfgPdcgjIS+V3oNCqdpxt1S1ru
 IGVNCs5x2NnYxi2hTug++gvXYl14y91Q/WlALZQq70JRsVfJeLi3lwtTO8Q==
X-Gm-Gg: AYBFou20u1nR0nN4BL4EgEl5TKLCB+ozYaMQ7YBrM55tsF4FIIrsr9AbkU+55eefaVG
 qfVCespgBUpgHuFrypPb9IeO+xJxHSb4BseBKHl/ovPN4B6ZIa5ij3pkyfrtgGRPThpRtOYoQZr
 4KKoXv2Zo2uh8Pti0zHwK1SPGlwseM56R5MGJ1CocR/7Q5EsFq96LxSmiH65aA3vvmitwtaqsvK
 ftRNrKcvgP+mKUVz7r42eZaSToRlZAtc2jKeLc0ebcKSZSWEGkIAhq6fvKdg6iKDzxkhNV2dpTb
 sm/eA5+AVB0B0pMOBBnAqHT05r3Z5J+cR6ow4YMgzvZHJ+xTYTZPcC8u2ProSc1zQ1KoDEa5mTD
 mE/f2oosOuSwGoh+XgSeM1m8Cm/BPEdAp5Ky8PWD7YHQrzXSJ50uZEyFg1iXpAqX9WlMbVdRdKk
 22cXyMJhrlSQ==
X-Received: by 2002:a05:620a:370b:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-9479f34cc68mr591235985a.69.1794333664690; 
 Tue, 10 Nov 2026 10:01:04 -0800 (PST)
X-Received: by 2002:a05:620a:370b:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-9479f34cc68mr591223385a.69.1794333663830; 
 Tue, 10 Nov 2026 10:01:03 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7ffa11sm277212685a.43.2026.11.10.10.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 10:01:03 -0800 (PST)
Message-ID: <b2c5d338-780a-498a-9ac2-2b4c972847eb@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:01:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/riscv: iommu: Check permissions on IOATC hits
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-3-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261108143934.129923-3-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MSBTYWx0ZWRfXw6Uca2VxXnrc
 ypWhNFhrIDBiH/pRwWAfpo0/NXbTeM6G9Sc13wgGnd78aTBitvMPdC6RLC2LPg6EgEIkYh3o+6h
 IVco6ie0ndTfGBFTmKXUOFRAOeVeHCNPjV/fdkR1gr0TSYXy9wI+y7oKWeV1T43yEmvLshgrHl3
 8LE8rTyo2WKnmpdIyOmyYB+Y3omh0V2UeJN/mOSPtj5Dd/jTeT3Xq2Kk6U3BwrBnSttOOC8oZy6
 aeh7LVWFfq93psUupUuf2YQ7tjvfBvmEzBrgGwud1HFAPui6tke0A8rsmdgmXCG+MbyFyJbOOEm
 xcRWa+No8/ZxbfLVtEdV4M2h8mbFvNJcnY0f9R553RJ1w+esmRz0CnrfTjWKeXf1JuzW0tftS+V
 ZXkWHCpnmwnGl9yrZsXTTWLkHcf2uq8gImFqq7OOdS7YdDcBAqFc4ZQdAnz8Pj7k6Em1EAIFP2Y
 OwJXfoQHDgo/F3kKfIQ==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af35be2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dA0nmnVxKb9tw0mG97EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MSBTYWx0ZWRfXymhaZCZEeRPF
 uEC8abKThhcIxmMci1+Qzv70o5/p59yOIoOCpdWLw/IfI5gmsZEM0jrlFztsHF1rYYCJ9LtzzV+
 xtqbLpv2arBaV+vtGGuTFLUViy6m1wc=
X-Proofpoint-GUID: jJt5exN-xxBZYgReDkj16eXz9MTlnvmK
X-Proofpoint-ORIG-GUID: jJt5exN-xxBZYgReDkj16eXz9MTlnvmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/8/2026 11:39 AM, Tan Chi wrote:
> The current implementation reuses cached translations without checking
> whether their permissions satisfy the requested access.
> 
> Only reuse an IOATC entry when its permissions cover the current
> request. Otherwise, perform a page-table walk to check the requested
> access. Preserve the existing behavior for requests with IOMMU_NONE.
> 
> This is also needed for hardware A/D updates, where mappings with a
> clear D bit must not cache write permission until the bit has been set.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 2dcc528599..6760699eb8 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1781,7 +1781,9 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           phys = iot->phys;
>       }
>       qemu_mutex_unlock(&s->iot_lock);
> -    if (perm != IOMMU_NONE) {
> +    if (perm != IOMMU_NONE &&
> +        (iotlb->perm == IOMMU_NONE ||
> +         (perm & iotlb->perm) == iotlb->perm)) {
>           iotlb->translated_addr = PPN_PHYS(phys);
>           iotlb->addr_mask = ~TARGET_PAGE_MASK;
>           iotlb->perm = perm;


