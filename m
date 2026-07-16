Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38E4C43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkEM6-0004Ns-Ne; Thu, 16 Jul 2026 01:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkEM5-0004Nk-UU
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:09:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkEM4-0001X7-G0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:09:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wMbI1753938
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aOgllXtExSYXP34z1hjQczrIc45UQEBC4sNqxbH7Y4c=; b=FMQQqK6TY1c3LV3s
 bTUEui9c5ArCt0frEcz+7ZJ7GmJw9IE7t+i+G76HAp7tGALq1vMtJ9V1adXKmYdq
 WsZ7Xc7eKXHfeFUnKb18fC4YBqx5OQstKjEgw4h0CYmIZPWIpb/uUj1qOdPM38ou
 6q7Gc89dOJirXS+ZS67eEQQ9f0Vl+NhdnGXsfDVsKztF17KsXHQwPZy6cNLdMfMA
 3e00rtdyqtj3VUxVO9n3zT9OjehqsMpRSaWd4dsRbS7V3Myle9k31q1nlv8D6eg6
 rXAXyEevUFdvZdRzZKs9QL2z+5GZQx+sroSedpslfG6J6tMgG9HA17PUV/k7y4xZ
 ArUA1A==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855c248-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:09:50 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6651d030185so3926810d50.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784178590; x=1784783390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aOgllXtExSYXP34z1hjQczrIc45UQEBC4sNqxbH7Y4c=;
 b=DNcdaISPGf/FPvsQWhbd5NApEfrQ0kIxfJhRYXvxolNE3G5y6Tbfwt+u66dGndiGpf
 +VPxEekYeoxmywGeBxHCVtmFtY0EwZ5q9RJjq7QOTDjQiOzrPShBMd3m4cyEHEHdLwyU
 2DKrpevIEJdJPuYwbI9UgYsrZgkM/hRJX/BOZVLEe2L3aUgD2gum6WzCGfn8Mee+ik6O
 BiFXj3Cvg6BCW1qAjuL7mi15l4INAHTSb4CZlrevLjqsXkniXqMDJxUSHQ+mJeR66xB0
 nbgskLDjQsIK6fK7GksQbobGGisaFVrI4HfSNe7NbxcCsWs0Qs/rkJE7uoArBzC+TvBf
 QF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784178590; x=1784783390;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aOgllXtExSYXP34z1hjQczrIc45UQEBC4sNqxbH7Y4c=;
 b=pubpCKpTnbnT2LiXxJ4QdszuEorSBDHvjMyXFCshB33hX/ucE0x98P4gimsxTNIQl1
 Xy3wHAKYYuHyqUCbfKw8G3HyIRAP5vyAnLiFvn4Rc5JNBXTGvU8jWT5CJbz5Cok1xonj
 KeCaM6fwxgP6E19oAo/CM+lWkgjHfXY9KY0jUYQEHcRznBqjO+kMmXflID1JGD+dZj+c
 pCYiyqz0wKkDi4OjOatE4746tv5MXoa8LUcnNpXa+y2Y/qdM9FsW9iNhz19A397t/XTk
 lOQ6ZC1HSS/lCMYtnyT+2n9UP0cnr/equT5l+N+jZuF03eCjNrwQXzSzCFcVmYnP8QNX
 XetA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh5j8WwxH9jui4K4c1uNh7UDf+SHeMR2vfYA+CeSW6wjda16h8VPzlSqGWMUJQF08GFG7nIxYdkrqG@nongnu.org
X-Gm-Message-State: AOJu0Yx+WDfYozCu+8EeI3Nx4qvQLzLGWXqMUO4Ix4WouwFRu9DeLTtg
 zEEfdlRHJRViYPHbZ/eJRDrOJOfq9MPOgglyrpI2hZoDz9AIFZXwt/Zb+ZqiciuYqwYLMpPhj1E
 gGjsuzcogBY09apRwQcnjUVoFvagJsMPrT7Aal+dvQQr9eft6K/BE7AmdBQ==
X-Gm-Gg: AfdE7clj8m/BQZrCIks9FR65S9A0cA5M8QkPxXxbOvoTjG5hvkxCqfzwIlfhSZKcfkt
 MtEpyGSr/0GmqzVUfdqAufTlPowVFpLBk3sYVm9JWO10gSB7bbW4C7fC/NiQ5bpCq6PmCMnsFhj
 g0elEZrzM2JOBEtzhhGkSVC5096BdbU0DQ0VjSznh7961rhl/WK15V3Ry2KCEekYWYE5dxDcqsR
 WySrgMgAH6LPHYx9MjqIMQhilSfCJ82ujOia5x19t+tvCp4NNhYlIhvRPhLyXcVQ9QvA9Q6Pj+5
 DuLELZQkSz6BmqguQrp9wRb3syBISEarXzcbrgg0MCn+QHrv2UwDYcHDO0AHfQrqU+TbbPbRC56
 5SZ7rCo1GrphogEZ5QKVKz+9sE7vDsHA8Arv55K7uP7Sv76UZuKJ3p2cOntb8Rr6sw41qEQ28Rw
 QR/Os+
X-Received: by 2002:a05:690e:1341:b0:667:78df:cc0a with SMTP id
 956f58d0204a3-667d7c7d464mr13351567d50.51.1784178590114; 
 Wed, 15 Jul 2026 22:09:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1341:b0:667:78df:cc0a with SMTP id
 956f58d0204a3-667d7c7d464mr13351540d50.51.1784178589711; 
 Wed, 15 Jul 2026 22:09:49 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6681fbfe082sm2464630d50.5.2026.07.15.22.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 22:09:48 -0700 (PDT)
Message-ID: <bae6840a-ed15-4b89-916d-3bd1fe67c011@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 00:09:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/hexagon: fix get_phys_addr_debug with
 in-page offset
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <dd52bfe14af72beffce026a67e930b68dd6a67e7.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <dd52bfe14af72beffce026a67e930b68dd6a67e7.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JraDTnnW7fEPaBtvj8b8QmewWnhZlOjl
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a58679f cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=I1YZxu5Nj160TyuHuuoA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfXyg2osfamNtlO
 1LcsSrG7gsS9OJZ0tp8oSvrH4UylDO+UgNk9Sn/Wkpg5zALkOj66Ko5z47s7qzF7lHz/roMbrK6
 gCIq1bBlClC/oMAz7R3L95acsT0tREqeq83jgxztwVhqmneOg/7Zp1EUiWcgB1LOopd2+81LLmY
 Su2MzbJ/NFp/U0M6tPGEqypwqPxkBKz2Erehy1KDAKwZJYjpzUgFvlw+VJxGQKawp8dzuJ280MZ
 Cw8DoOfnFuGEUsedw5OIa/J6TgR9gMROZRarPO8Tug4ixaScUG8eGWHdI8pm5lZ+ciP508ugB8H
 V/fdVlhZHtZgJRBtTRm1EdAhK+s5pwUZlS0mocmj/wVP3gyFNJYAx7QQ2hzg8gtZWfcXJA70Qtk
 NOZptlg8B8gGtQSGmj95TN2zoV2C/SHLLR77YtuqioeVppTYxNrcRgZw+aXfD+o2RYFnHPcKNcU
 8PD0e7HRAtKM0gHfcHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfX0a59hzopr1Gt
 bMJjQKheqpgvRSzTj2PUjg9NzWC6nB4GbIhUzo4xFoBiokHEmmClWN4hEQ29G5jM+V+Yj0lQaZN
 6nJXGWN479hQZaWKT2mDLxmJMB3+n4k=
X-Proofpoint-ORIG-GUID: JraDTnnW7fEPaBtvj8b8QmewWnhZlOjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160050
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 7/13/2026 3:07 PM, Matheus Tavares Bernardino wrote:
> As documented:
>
>       * @get_phys_addr_debug: Callback for obtaining a physical address.
>       * This must be able to handle a non-page-aligned address, and will
>       * return the physical address corresponding to that address.
>
> When MMU is enabled, hexagon_cpu_get_phys_addr_debug() returns the
> physical address page-aligned, not corrected to reflect the exact byte
> the virtual addr maps to within the page. Let's fix that. The
> MMU-disabled case is already correct.
>
> This would break semihosting argument reads when it is added for Hexagon.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 42d93e5da47..028cfe9edde 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -569,7 +569,9 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>   
>       if (get_physical_address(env, &phys_addr, &prot, &page_size, &excp,
>                                addr, 0, mmu_idx)) {
> +        vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
>           find_qemu_subpage(&addr, &phys_addr, page_size);
> +        phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
>           return phys_addr;
>       }
>   

