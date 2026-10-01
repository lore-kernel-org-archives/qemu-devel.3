Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97DFCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP1X-00044R-LM; Thu, 01 Oct 2026 18:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1K-0003tv-EU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1I-0003Fi-UK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsWKA2475309
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MJ+WKPt47hqbTXLOZ5dxmD68Mb05BenRvBGew98MdrA=; b=Vjx2FZfs0uxsIL0z
 +wDHmONPOUiDeJZUnAdqctcIbXhnFYEcfMwsGzec58g9iqKeRqAmlbaAlO8jVwGO
 pxW+nHoJO2Noo3eafhz726NkZZvroD49o/A0cre8hSsWKqvny2rcrZyLICf5W14/
 rNgcpD2JG4L+cIG8B9JJBu3nQFEsr4HwYUuXXp9f+uYgJVK5KcQVJqoOIkaF/5si
 j8IvCurBNI7zb6MKC+8yjQ04Dwbj6LYnMnD3/XbuEpvdG/I6ik84VBDu/crhizA6
 vChZyHWNipUNoM4ncGKpe7YGfJXupiqikBGGpoGD3SeN+FGY19z8i6wzt6GfQR+r
 TEHk7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbg9jjp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:12:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5403811eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892771; x=1791497571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MJ+WKPt47hqbTXLOZ5dxmD68Mb05BenRvBGew98MdrA=;
 b=DE05Vh8hNANYmB3FGH/AK+FZegTX42DqEJLn4k5N6PfY9AY5VbyvMmIerlvB/k69O8
 yxcLAlmKICFg1SN8VUWqrBsjkv0ccgRuf2O3E8t35nEbrU5pqEI/2F+vxg3baTkCuRpX
 3v+Mq5tNd88KwPBikD9DlM7XsWT0+K0VHTIlia5olkwstVmaOGZ6hVPaPW/eQ12xKkkI
 YvM34lP1r4UHjInkcyw5rjp+wnbwq7Ln6VDv4u/wwvh3WOn7UE428AJobN862+uQfr/l
 xtuthnmXHzYy7d39zSSuxdH1RaB7NhPlSJ1Z/dEJf3ctnxJDMeQ+IpqW5LjruVk77MuL
 wDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892771; x=1791497571;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MJ+WKPt47hqbTXLOZ5dxmD68Mb05BenRvBGew98MdrA=;
 b=w+Lh6pngIjy1eeCdtJwJFdCDqoTgcnX7FYa9c/l9X5hX8lUu1KGAdL9ZRbGvueFAbB
 uaakp+rvVHh0zBJY2Vwh7r7Bm2OKinTze45bZtrI4oaUfcYw4GdzoBUWuLhUlwe9Vv+8
 p+M4eevLvGM8KnQZHF5tqMHcQDOSNPq/an9Reyj6z6BRLTn/xLJ1iJDCQIHWKkmK/SBc
 xauxGk7YRl12Q4SwvuDTUb6mHd7vBwPSnkCCFS+8YRO/4XHSf3kDejDLTOJlqSm7eIF0
 NqhvSlfzjBO5pxVyQMVnwpEBHB8x9/eEQvJuXsL/VrHiJE8L/IkXvQGqKeWYRm2oslFp
 AzHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvbR8qZDrMiewsjDxXJ6zcwAtQbG3UJhtZEUhyKGTlPxrhk7TeI/EYF+wk5YRWg2FBQX4CC63ooAuU@nongnu.org
X-Gm-Message-State: AFq9FYLw+V8yU6kqNh4GswioNe2TevDrzZVnDhofVi0rXmwl2c7u84+S
 KK8m53bivGitEJKsQWhSmX3HDbmSwD1CoYtYvskZsyckE75tHWYLmNEWsjv05jNGdHkcjmbeJXK
 +xchTAOnMZKqpfHH0aKBw8co0fPJf0oiKtxZBpPw1QQfHqutUyYrAGtn2IA==
X-Gm-Gg: AYBFou3b2iFOuWTe2JKdV3EbLbqLVc1ZtZTZC/8SC2CFwRNDWnRsw3UGgBlMB4EbPpc
 c44F/pasVK1fuytpZ1YpeRngzfVTDCcrzPq239HPXCue0EIga2XtE3a4NXtanr10ybhZ6iR1GGQ
 +bNhMUNUAuGj7Pwcjn7NK+EieN3IjTENtbCBXoyI1Hcguz84/9LhFWj7ytueTSzJV8qbiQfden8
 Im+yh8YwaBmqDTrukTqGo3ck7A4o5MES9LwH2O0I6Tww2/HXgsbPF9s8gFBXpY9beL5ohkz/Tpq
 9amZ8hV3+4nv7oCerDU9C+G33uWnWPksY2A+6dAFQEnVIkIBTMN7Vtr0/aFVpWB8tu/j0cDLzrx
 Rg3Dme/cTNH1e8RI7xAhCvsEdDuG9hrk7KxyvxSbn3QRDzblc6kmE2RO10OhEGMsw9Lb5bQ==
X-Received: by 2002:a05:693c:4094:b0:350:869:d106 with SMTP id
 5a478bee46e88-350086a0117mr223958eec.34.1790892770822; 
 Thu, 01 Oct 2026 15:12:50 -0700 (PDT)
X-Received: by 2002:a05:693c:4094:b0:350:869:d106 with SMTP id
 5a478bee46e88-350086a0117mr223910eec.34.1790892770073; 
 Thu, 01 Oct 2026 15:12:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fdb478sm1017739eec.22.2026.10.01.15.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:12:49 -0700 (PDT)
Message-ID: <7fa35104-b276-43ea-9deb-3a34a3e6ac29@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:12:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] target/riscv: Compile arch_dump.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-15-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-15-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX5Mx+07Py92+g
 5UjeYvSZ82aTMDYLUhWFOvhqVIuLIyvFxJclTPrihplBtVTsTHDi4mQ5G3rt9I09eLIj16z78TU
 xXCqyrNoEX23M2K9KIwDMVd4yCoYuFI=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abedae3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fkZp-GEFjr1xpXxCPPcA:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX494SE2dwAjCC
 7EhUG84TgSQ26Pkw6SZ1RaqiATOUHS4urV63AFEJPSRTOy9crApX0l2TD3XbNxKnJilfkMNdTyF
 9hfP0F+tKhS4D4bc2vWE20Bf3SMwc/KxuJoSAopCFLJkWZ1gOG7Em0F5HOxCeyciZkfKOTq8Si7
 QJI8VT1Yf2m6SD/VWPM56rUDMX6cm6pEnLAmZqBYONUUTYJ1rwKx0rxRCVYAV9R0U6sx+JdSTFz
 7HsnyNuWAQcNFugJEVGhXidSB/rv+3Watc5+eqx1vo4cRyecg1aixpPeTFTvgASF+yqvlYRp1kf
 s9I6IQ0kjBPtu3AZv66I0+AmuWCOkw7ckKE2xxXFt7GT/OS6AV2loblTwsLXIZ775I50dtJJT/N
 KYIK7i/sthvAiUbpYTD2soZM8NbTty1j2uXKJCu7jC8AB124yO50YqLtZHE9aJiF17/DY5YsFLQ
 4yxcXawoQJKuiLCm+ig==
X-Proofpoint-ORIG-GUID: GjK2HfKz4CbHrOgLMfrzZKLQUKbWx8rn
X-Proofpoint-GUID: GjK2HfKz4CbHrOgLMfrzZKLQUKbWx8rn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/arch_dump.c | 13 +++++++------
>  target/riscv/meson.build |  2 +-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

