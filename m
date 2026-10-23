Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F9606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ym7vtpGx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LRQuC/0L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFw5-0000kG-BX; Fri, 23 Oct 2026 10:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKFw2-0000jx-3y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:07:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKFvz-0005rR-Uz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:07:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wPr2109162
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 14:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E1pykhwSORbZwWS4vg9Dzwv8AmJ5HnVFtZtS5CmPkLc=; b=Ym7vtpGxne4PN1SP
 ijXMQrleq1l5X6K2rrt9OEkKqp9aBnd7M9WHlcsOi5WQPayfXdB7X/RzoIm1UNm9
 GvZEThIJKAdBPn07wUmMTiqXDcQN6wJnzWO/7ziai97aOfeGkIBCamj677qL4TrT
 0olXXXkFBex96Bv/Sh5DJJk3HPneNAk3X/OJ1CYLj7uJyyMkaYrFjozPIbWKqgJ5
 7PQDqbPiCt58hcvpNJDdwAb3TI9zs4H+yqEw8rIOSyGFB+ac0/N8htsmgxU7/Zrn
 mMDoopkOVzrAdPNqOCJMCCHI2jhOjWPvAFk649RfYlBN/QJd09gVDXCN3vMZKMn+
 OFVpmQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms40fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 14:07:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5376f1849bbso2986761cf.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792764465; x=1793369265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E1pykhwSORbZwWS4vg9Dzwv8AmJ5HnVFtZtS5CmPkLc=;
 b=LRQuC/0LDWSQhDATotd52YDZ1Qd2DTrFz7VQxzM51z/HhZwQGn2DrSMdIuyEr2V5Rm
 mHcEFO3s9Jl14bMogmbi9MAWDJuOn1zyG2njKCF97WgvHAILtQLdTtUA0fYtgN5/vhwh
 hmpn6o6h4V48gF3TZgB6qiCJ84C2XQQuaVFONlSwVrK2LKGs3qPCauBY3z77pHCp/dwk
 8hpEUQXWo3E+ZNumvvMgqgjn5e4+1Dgassnpfw5CZHixoqMpVF0tRFUO9o3sGEJ8AfAo
 zeaC9kELpuzgayzW97Wsk6bNpn9H1eBxi78Ng9R6xc4MC6nZ71yDLTNvgrZHWcaYiYhm
 n9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764465; x=1793369265;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E1pykhwSORbZwWS4vg9Dzwv8AmJ5HnVFtZtS5CmPkLc=;
 b=A/ROBHUuT/b6LOCjYFNiHx2WfnmU9jnhBPWo/AeT+tbfF/jZFsRDK80ZHT6y+NOv2G
 YD1urTekl+MEsiY8Ttxm9yuXYT7aUM/5QB9CF1+/gCIstnbFXCdPbHDOd959l8PUgMUV
 Sg0pHEBBbGAO8Sx9yiiHNQyEbBD09+dgQG8UezD/bIJU/l56ZCrxCRDirvj79JKWGEu+
 78WaD1BARDxgsjTSuUbp6ETN+SoUkr/9xJLuzjf9Gx68SjZau6L3xG5GAq7AH8jKcHxW
 fQs9zii2RNvHxFjMWu7d0HXadL6ZRbvwHPAHZ0bUZxrfGPjugHMG2nlEd0IAb89JDg0y
 yjlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMrcsFBy4mnKkHLf3e9cZfSWRv1xZJNCP8f2W09YLnLWS55XAflEUbCtshqw6KFg+245oQeyE2nfQ1@nongnu.org
X-Gm-Message-State: AFq9FYIuYdRdv8XgG47ROMbDOD+soYuakWBDUFmBSydXQQrfjxXHBJ76
 +A4qgKGlfG6/066BYLHLDFU1yLt041LhuhEbrE5W7xRsUjgX9u0ml+oKhA3joF+fWc+957JdqV5
 48f9VJpKAnxDx0aG4+xjA5Dt5iAqIgXZqsAFFLTYt51ko7ojFeUdEdv+oag==
X-Gm-Gg: AYBFou2bA7NTA5tqvxLrrPFfBAA9lP6oUO3F2BVfoGmWu4kdHR6SKLqMBobKl6FsgOG
 t/tGAk2h65O66TH6TgNy8gk2o9t2S5oHtJfjb8cMi6djcvlZpbwvLGOly/t/6ApdzeOv3EBVNHe
 VqBxUaKA8JaMK7UHXn302mKp/AWTHc0c+avUcKiN2eOVbjIxzlotlt5kagUfWnS7WgVNH5J4nfl
 UIYDJ/f1qYAiBv4GHhx8GA4fjt2TIb05TQFHsVo1sYDTOa/THicVEeyY8pKSsWjDTc/+kMp0MBS
 A2lXlJMc/mpuhcvtzwQN1+HbBzGdoYaFHcbBlQ9SFAscbbJZyLy0lr88vj4bIcDL0OYz+Own3VQ
 eTWmmrJte/M4906+vUMc2qgwMHEDseQzM/NqEhxR1otv1mhrIgW/VyDqnHp6qh4Yd
X-Received: by 2002:a05:622a:3c6:b0:536:6ecb:973b with SMTP id
 d75a77b69052e-536c297c171mr31636851cf.58.1792764464931; 
 Fri, 23 Oct 2026 07:07:44 -0700 (PDT)
X-Received: by 2002:a05:622a:3c6:b0:536:6ecb:973b with SMTP id
 d75a77b69052e-536c297c171mr31635731cf.58.1792764464126; 
 Fri, 23 Oct 2026 07:07:44 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536c18afef6sm16782491cf.27.2026.10.23.07.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 07:07:43 -0700 (PDT)
Message-ID: <5d3cea83-7d11-4949-9830-7116eeb7e043@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 09:07:42 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
 again
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261023135336.49641-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261023135336.49641-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfX6U+5PuVtV5yT
 Erkzj18tpT1OFZBu0UTyZXPiQpZHsmRK8H1EUPDy61+QJcJvSDZHSTDnDHpUYeKn8urJ1FChb2z
 j+Am6+e/hNiU29VyDaMXBhWaukyjwQgqb2x8yN/3GQdNU7wkY0GNtuxpOGy31HQUdJUad8dbVia
 1D0us/SAoy6jM8dBTtTRUohfulhVTiRuuHu6LEbTs118BrdIeGQFWkqHGHhZwofSWHpss+0tOSd
 /5nAo3uPhn8dYdTBb79sfa89NaQzIIn7r0RRG3bDPnwveAThaj9VWxIvFtaz2Is+APFKTPdlJVo
 +yAvJynxDaEmWcwM6HrAj6TLyxZ5qc/UCEmVjzEo30pGl28kq19xGyngYzLltrizI1K7yggZhgF
 168l/u8bzc29wkfRnIb4dPZHW+eBj3Jf2YTtkKNG4V6THHPQq9TAQ/Az7eDHe1+g87C0lQlGFj/
 8oa2TtAGVtKBZ+PYneA==
X-Proofpoint-GUID: vjoWiO6LLRtE-JFwUN2Af51U9TxVgLUI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfX0XIwWJ8rfj68
 Rgqm+OJSSIzk85dhDPkEukA4T/tTgcRe7/yv8qBPKQDPj4vqgAX63DRJDQyufFrFpz7zzguI5Zb
 78iY8dTdxJwvr/uw0xVP2YsGYyDNQA8=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb6a32 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=47CrpmmLyoWdOgbbL-YA:9 a=0ET0i1pdbDpE4CzR:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vjoWiO6LLRtE-JFwUN2Af51U9TxVgLUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/23/2026 8:53 AM, Philippe Mathieu-Daudé wrote:
> Commit 780fbbef2a2 ("target/hexagon: gdbstub - Add sys reg
> support") re-introduced calls to gdb_get_regl(). Since
> Hexagon target is only built as 32-bit, replace them again
> by gdb_get_reg32(), similarly to commit previous 7831e5f48d2
> ("target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()").
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index ca6d4a98369..85d9845cc94 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -96,12 +96,12 @@ int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>               val = cpu->globalregs ?
>                   hexagon_globalreg_read(cpu->globalregs, n, env->threadId) : 0;
>           }
> -        return gdb_get_regl(mem_buf, val);
> +        return gdb_get_reg32(mem_buf, val);
>       }
>       n -= NUM_SREGS;
>   
>       if (n < NUM_GREGS) {
> -        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));
> +        return gdb_get_reg32(mem_buf, hexagon_greg_read(env, n));
>       }
>       n -= NUM_GREGS;
>   

