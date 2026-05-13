Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CAECD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNFA6-00041c-CW; Wed, 13 May 2026 15:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNF9y-0003xh-UW
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:22:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNF9t-0000If-Lw
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:22:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DIUUM33324660
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 19:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gFDUunjnvvOkzQaC2nlRS3FPnu3Z++fX0uAqw4H5nfg=; b=dUe27jOE3zFMRhpc
 j/1xN9r2lLK0/+8kZaXQR0M0MxFuZBGYpTiii2pmJbKzSb1wq7eAvc9MJBeM6BrD
 1X/dCQIr+6vVYkpqqYZVij6dPjPQ0BwuK8RLLLRO0PRh0rpnfh9+9KQmyhb2APdw
 AcLEa07mgXWFAN4HHUrYpDL+wtnuy3vDyWYFvfYr2jlqAKgow7lo+gT6/JSh61y5
 ldPsqjOJj8cNIiRg5yHQ10CXFiY3eeRZpmDLDYT/WRbXpCrXGysesf2whyRQ8r4F
 Rc97YWzxaWdMMDXfBMRJUb32bgNKUsvNQHqiuvmSqT0icMdigAeq+8MsLNgpqbPe
 puP8Ng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdb5ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 19:22:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e575a50bcso58227081cf.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778700133; x=1779304933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFDUunjnvvOkzQaC2nlRS3FPnu3Z++fX0uAqw4H5nfg=;
 b=ap1ytxJZpCQiEiGbuXGb+gF6t2ly1Bv1vM3jBv3OI52oVx23jWhclcw0wlmpeMr+4R
 rIVC03QIflisiVBYhQApg+dkx9Aamf7+WKfVnO4zq0aX+Nmx5Kd/Ty2XXUpp5AUW1vd8
 T4enUypyldQaRy9SxicwXC5O4FqRz+2WisxIR8L20tJJyKbpUCDDkoV4HAH6TpZGu8ij
 guBd0tG/FExMidnr/ki6xjN8f1+1uiTh9621wR6aK2346ltwhbgLZkcENqyrqnwodGw1
 GKjzHA3VEzG6PMtydMivJD/oYUpftnKcU68SzsE6eIW2azgYpTSYqDNXGEsTvOzAWI6K
 ERaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778700133; x=1779304933;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gFDUunjnvvOkzQaC2nlRS3FPnu3Z++fX0uAqw4H5nfg=;
 b=ASWG6MX/F1BBPOFhU52vPTUXGk2es3yUKc9ZxF9n+zMZMU0mLqEx8akfsZ/so2jV7I
 irkLiDoxR/B7Fb88pykrBk3SFH2sMQlFf79JRJvDZ9mcm5/GOdwXVAzfCLxPAUM90J1t
 995GDK4IYrvjsuSTWL+ppg9eIe2DaADhrB68KhZpRVz0/nXGY686AdP3ArR7FwblXYFc
 akYKmUbnGLqnPYeR+NyrlEN8Ww0liZaM7L8voP2vP+/mBBK+AaDp+7HYcGI0rmfmECAr
 b0gsXOJYNDR2U8sA33GieBwhLf9xEd49JAAl9QsazFHViWpH2jnWfsfd5yCNQCrxc2Bj
 eKYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hDQRNeZ4URTmUSlodDRf9JsamwwR0aAg0Iq8ZrCjl3IRTzM4S72LfwUOuL4VKIhpvwcbcxh9vBgoz@nongnu.org
X-Gm-Message-State: AOJu0Yyqy4px2adfKhYwLxPQjAxa4dlq+p23DJcqeOhb33bK2+T2QDSR
 oNspBa6p3rZYIfe1Xk6pKquB+4vzllw4/YWZ0xW/tpx5yR08ZCNhwutzzncDyP4rxO5REMJTyV9
 3RDGf651GmtuPj/ew8U5smhDN9y038sw8iwR4EQdN1v0WOOhgkyjCI3ciuQ==
X-Gm-Gg: Acq92OGPtuAHp0QwrvJIWP/RHi5FB6zRKCyLPTQIJC6KX1kHS8fVMFTH1sb95ZScPB/
 L6aQ0P8Lqk1iIo0a69TImyYH7/tiL2dR0OqPp8a+yBj8wr4hR1IiLUiiXtBE941kb9M2qpjmArt
 mLoJXK0g0FNu1HwQgH9had4tLsWmygXp2rSIctHyv5jK1rk88MiAiR54YWrDyxpvZ618tAHyn4a
 UFuwxNp68OnQWEP7+y3AYlsaqftA/ze/8Mj8EygINKieeA18TCqR0xds1oJ/CzcIdffKeRVOI33
 NeWaMJP9x4VClVch+qXnPe3BrSpLtTWx4o2IWGaiPvtio49z0OUGodmVvsUd0jNSHvWnJsdc7FK
 hjbyVyr6ncMLjUYitJPEHmf5sGruyO5SlgeaNaSN41jouIdx++uvWSe8gVk0=
X-Received: by 2002:a05:622a:2611:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-5162ff44ff2mr57787731cf.36.1778700132864; 
 Wed, 13 May 2026 12:22:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-5162ff44ff2mr57787071cf.36.1778700132237; 
 Wed, 13 May 2026 12:22:12 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-514cbca4b3dsm77860771cf.31.2026.05.13.12.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 12:22:11 -0700 (PDT)
Message-ID: <65fb6bcf-e33d-4971-8755-ea319c5c9d27@oss.qualcomm.com>
Date: Wed, 13 May 2026 16:22:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Update the local interrupt mask
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260513051841.1671987-1-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513051841.1671987-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EEAZ6eKLMyaYifNJ-99ODX-0oRhKBte1
X-Proofpoint-ORIG-GUID: EEAZ6eKLMyaYifNJ-99ODX-0oRhKBte1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE5MSBTYWx0ZWRfX6TzJxVstHXTl
 Uo/ex6ff27MO3wt/O0QMEa23jIvgz4aNxJMzaxARiiUhgkECN6GiJ+IeoI7n9YUXjqp6M2m/FlI
 kjNWQiTcJZ1DbSJjM1OtN8N6oPYpJwvjB53mEbbOhNAC40uu3TxsjAv704g1EtN6Ar1Pqg2fEF5
 /6G8RCoSO/7g0qEKD91DMxYu8ufq+8MV7bVBUInbHnSD2jjGLJXHY+2ZL8pRSmbM2yvKL8FJIE2
 e4ZgTk/6AEsqEevB2n0dR3FZ/Eaz7mMo1dOXECX35v8yLxD9W8f59DPdJuoSk8LTeI5+1/f9HhC
 E65g3/JyB61T+xmLAAVlqRZ+5UwNMj1l4DXAxrlFuj65vU8SzMpQpauqdnx3rCPmCQvJpvM9AZb
 5VcofZBuKUOlK030axGWYBZuFgRt361AL/7qvwhWQKFJ20naEjI7VwcZDrm7BXb4IG7BOuMOqHG
 iAiRsEHmU9zLB5ppcMA==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04cf65 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=oMgF9zA3Fa0iiefWR_MA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130191
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/13/2026 2:18 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec describes bits 0-15 as standard fixed interrupts. The
> AIA spec on the other hand describes bits 0-12 as standard fixed
> interrupts. This conflict causes issues for us as we don't dynamically
> determine if AIA is enabled when setting the *delegable_ints consts.
> 
> This means currently we incorrectly treat the LCOFIP bit as delegable,
> even if AIA is disabled, which is incorrect (see the issues mentioned
> below).
> 
> The AIA spec indicates that implementations can determine which bits of
> 13-63 in mvien are writable, so let's just make it bits 15-63 to match
> the main spec.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3134
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3135
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3138
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3140
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..db886aeed1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1777,13 +1777,13 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>   #define VSTOPI_NUM_SRCS 5
>   
>   /*
> - * All core local interrupts except the fixed ones 0:12. This macro is for
> + * All core local interrupts except the fixed ones 0:15. This macro is for
>    * virtual interrupts logic so please don't change this to avoid messing up
>    * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
>    * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
>    * VS level`.
>    */
> -#define LOCAL_INTERRUPTS   (~0x1FFFULL)
> +#define LOCAL_INTERRUPTS   (~0xFFFFULL)
>   
>   static const uint64_t delegable_ints =
>       S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;


