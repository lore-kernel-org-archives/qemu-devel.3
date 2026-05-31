Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F747CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 19:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTmDl-0000ux-BP; Sun, 31 May 2026 15:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wTmDk-0000ui-1f
 for qemu-devel@nongnu.org; Sun, 31 May 2026 15:53:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wTmDi-0007BX-FW
 for qemu-devel@nongnu.org; Sun, 31 May 2026 15:53:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64V5ql9L945416
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 19:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0I9zbbd5W6x0Xb8ZvPu/QkdgllHVFeYCk7Y+KB0bR8=; b=ThqPnszVNncStfoD
 esLp5P35hzf5JYG87vsm4vDepbRpM6rkKk1CnZySRp36xVFrnN27OghhFxDF6rOb
 JSR+7twbHmH6OF1OwPhtVWIXE1TjjfpEtmoOdA45vDZzFCY4+ox7jZPDleMC7LIP
 qHjSpv7NyHbB7RjBwr89zPmsrXyvteMe8qEELona3LONdegqDUHaivhp92vDqMV4
 /10+4Jn/MER7i1YJCag6bdLeuLxTQR+Xyx6+zV8fvYrvySMNP9aXgAJ3fVBZK/qc
 27YNY6oNdkCOPCSvOsATdM0Q4QMAlHc0/Ts5gvRE81HxC5YpR7XF/4ZnnvY7w3bV
 Ug6nQg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fchqf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 19:53:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914d0204c67so1618041885a.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780257190; x=1780861990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0I9zbbd5W6x0Xb8ZvPu/QkdgllHVFeYCk7Y+KB0bR8=;
 b=d7+UHZxFIXM7ct21G8QN6gRYMldBbGVI+0DxErK0CIvEu8zASC1Qu++LI73VBWONUj
 NpkHTYXJN7+VNodD1YZD2PELTTzukd2cHgkzt3OWkpYXUPGBUoPxiKjLPJori6s7BMsg
 hr96VETCoipQFyZyW7fCfokzJJ6TLp3UoDlf7w19bqOrXWCPoOgfuhAvc40DOKIRtNlU
 xWc9LgDT/iBFMT7kJSVOmX12oJVb4c38XBNsQP6RG2b/V+lo3W0PdsuPxf8WjHo9evyq
 cxB/SaTUj4kWpj096NaNlXcDJw21Eo2m/O7LDNE5gvhGgyc6qeby0ASS5/9FE1VOaXCT
 9Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780257190; x=1780861990;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0I9zbbd5W6x0Xb8ZvPu/QkdgllHVFeYCk7Y+KB0bR8=;
 b=Hv+8mn6MFyzUTpklYnnbYUUhNN8tl+pOyJud/uVCv0g9sTuPQmspbJ4pn3pq3RLK63
 0yf7jfF/qspbaRGOclCv2TlwX26vFYAlz6ydtgD02z3aH8Whx7ks5dbwx61QGlXiMPrf
 CoIvbI9hTKdWtv03SomZjoE9+NCqd0ofHKeHtV6C0qqjyu55PSV4JKfPsVKwiFjJhMlH
 h2lPcsgKcK4VGScE+TbrP8S53kfZI/Fgqui+RAeqIooxqUpJ1ATIPGcA5Z5QGZCPZFR0
 CDKd9rbero4hZffVoBCYeStqVejHfLBSZYu+gyTyYiLgS0yYLKOBeneXQj0Ti0AtH8Jp
 RfDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UlIUIyMyolvkBl0Hq8vAVwmxEkhPf80PzX3/MIU7gEj6sMbwzj853eeByHAP1BHM+2IvqWY1Qomid@nongnu.org
X-Gm-Message-State: AOJu0Yxj7S12Ex3qHptoQeB3xp0zY7VWL/uNbeUoF1qQ0PFOZtn/4oZ/
 Z5cfRfvFD6h7uezyzWEL7Ip7NjwZVyQwFO9eoQRXhfPNLX19x+qJEsByPqfCtPKsiKKObvl0Iwl
 gC53+7q/yHVySZHiarzqQ3GZu69iMSGO0T75jCQCVelTK+f0PKMr0ocdapg==
X-Gm-Gg: Acq92OGfPv4XCKtb3qd7StjrNthqxVGD9FGyHOL71Deewm7nDF3xhqG/0+9UGT6uW/X
 ldkFGufBKjIue/g2/kJTqPO7xLI3lTJN+2cTxVLHeGbj/DWVK7K37XCQeD3i065Ov9uMevG/dY1
 e1pSH561JOfi4K0zYL83u+K+tNV0eoAhzG6rFdk+MIJY5w0c6lbm1S+UwZ5mEv6LhbYOVqdsk76
 A4IrJu49a0zzZNGhO0vARzt8Sl+BRr61hAaghdNHb5GTlKOmhbzqcOtd4BwXpZvHdkSd4IILCni
 BXgXM5Ygz5U2Uv7wvpE1UMv4NxvH/GnL919ASUzD2vIvsgF8BDtQpUCj4MbdV1rL5bjnM9phWCt
 IUHpopV/OmQdrICZEeOgXfHfdQOySJ0zZAPQ0wgIckJDvaXHTux7oRg49l3d466hAXJG0
X-Received: by 2002:a05:620a:1b95:b0:8cf:d717:c22e with SMTP id
 af79cd13be357-9153d9f87a7mr1355164285a.28.1780257190056; 
 Sun, 31 May 2026 12:53:10 -0700 (PDT)
X-Received: by 2002:a05:620a:1b95:b0:8cf:d717:c22e with SMTP id
 af79cd13be357-9153d9f87a7mr1355158485a.28.1780257189559; 
 Sun, 31 May 2026 12:53:09 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-915325fbaf7sm840674985a.31.2026.05.31.12.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 12:53:08 -0700 (PDT)
Message-ID: <0ecca170-beed-400e-a606-d32c6211be7e@oss.qualcomm.com>
Date: Sun, 31 May 2026 16:53:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: mask vxrm csrw write to the low 2 bits
To: Abhigyan Kumar <314abh@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260530102100.78150-1-314abh@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530102100.78150-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ig0Vu0maf4zi83A3EqZ9f5axNSkDR5sc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIxNiBTYWx0ZWRfX4pDzF1hDyYDn
 MAIiyxhp43c4R9jbXXy9ioHH0KWGAGl1xfzohGj8QIeZFRWBVHmym3y5MWxrCG5lfmj690GhdTS
 R+iw2oGzYrhxhYNc/zPkIXHi847stz4qAk4OsPhNVVys6sZ2gqmdg2UD+/uzsmxw4IvKVndDJc9
 EVZwsGuD6qLl0NMwT+nZ8q2m/luA08PmG9X+STiOZZQoqzpOYYQkax7G9gllOaG3eSwgqTjy0C+
 +wpeLh0reenn+FHgnUXxRY0FCG/eVDv/PhlIhYZTQUBHGhyr2CGm7NCQ2nbqcI9BI9mtlDw4NNF
 /4p8BzAzdQRd/Q4CKjSnObRIZAIJjM+jQvyViJql2dvp9ivlqTAQy7XzXqjo6OyYCnySE4Yx3Dk
 1IMtSaelX/73iXMlMo3JQEvN4NX5qE/cvf4YBAHofDDVpduHuW8pxlKuI+h108p6koHEcKHpmk/
 l2qOeY+O02oi1MwKlfQ==
X-Proofpoint-GUID: Ig0Vu0maf4zi83A3EqZ9f5axNSkDR5sc
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1c91a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=SJkb1_gNzY3JbkFYywgA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605310216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/30/2026 7:21 AM, Abhigyan Kumar wrote:
> Citing the RISC-V specification:
> 
>      "The vector fixed-point rounding-mode register holds a two-bit
>      read-write rounding-mode field in the least-significant bits
>      (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
>      zeros."
> 
> QEMU wrote full value into env->vxrm causing read of upper bits too.
> Used existing macros for bit-masking. Previous had a hard-coded value.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5514e0f45..7b98d66db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -977,7 +977,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
>   #if !defined(CONFIG_USER_ONLY)
>       env->mstatus |= MSTATUS_VS;
>   #endif
> -    env->vxrm = val;
> +    env->vxrm = val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
>       return RISCV_EXCP_NONE;
>   }
>   


