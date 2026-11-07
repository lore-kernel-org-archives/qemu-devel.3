Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613E606A332
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBruMbwQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPYzW-0002VK-Rp; Sat, 07 Nov 2026 00:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xPYzT-0002Ux-Mi
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 00:29:23 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xPYzS-0005Y9-5W
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 00:29:23 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc7d154ec4fso536825a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 21:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794029360; x=1794634160; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i/OaY7VBB3C3rPgl9fDtHdrR7oJN99XN5IQvvfdL8rg=;
 b=fBruMbwQ4tx2I5S4lkFuH/Yr1g6qqITUPPHqp5T8SOTZRZu5NBkEIJnTRcfzAlr6LU
 03frtmFXN+iNii4g7hvnHCmYl7Phm0v378Ab9UEhC7MJBUj0JAZKEd+XJjdzVEotLyby
 D5i7EHQskK+dXRJLzFQjX8xWAsKLfr2VtdsK+q3p+x0bJh2Eo5zjmJTWEQWjdnEmLmD0
 jNjOtbC1UFyAhzuh5y5WvibI8yymm8IIIkO5DGEOS+9oFPPjVNXZIZB6q+MTOKf3uib1
 CDqBwqKAdElBnVhicjC9pWkaEiaqI85hAlMn5jLQuHe0ZE2P7KdN1YkU0SDA39Bt07sf
 htlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794029360; x=1794634160;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/OaY7VBB3C3rPgl9fDtHdrR7oJN99XN5IQvvfdL8rg=;
 b=PAnGx9dsgxrEi+cFRWJoH5Q+68eaJt1WLoR+CWdMAB6yb4VOtGVLQ+UYomYGoypks1
 3UfVxQW4AeBJIkO91KIskxv6AzlO7ucIMZRvW8K1LYauUbZeE3evBwnhFFqbeo7yBcbe
 FPoVsFs/2QVVPdiaRQM38TBpL6ybIL38PZrZJI617sFpdtCZ8cWtUsphdsTFkY4YIxMl
 DqwT2BfgRqW8/GEAP38jFLK/kjdVHxumRgouUFffRbJbDpaFQ0PtQYOq25fnrfJFUNbm
 wqYawEO4feJjG2TBRpMDfIJ+gYRYeiJab67SB8g1GwiKJTYgfGfXAL3RkB44zFGZKTl0
 75WA==
X-Gm-Message-State: APuU4Z+WhQECgwIboOWrAaD2dkyAvpqJ4OMP5qlsxmTK15pnIs7RQEp3
 uo7EIcuBvxwFnnkJBXqECjOxYjrpKF3x6FKlj0JU+0EY4KD6sey+84a4
X-Gm-Gg: AYBFou2vFFnTh0UEIRerGpnW5prNy5bHdeQz7C3he4fOheMY0j4Is6gfKWy3/vFKkN0
 bNWzUKPEji1m8prEHFFI+dAR7pb1Z7slFC2cz6Ckm5RSCNtsN97YoKAN3EBbWjN5GsuNkI8H4G2
 dEwlzZLmpyqEy/gci2cJDcwjigr9+Ky/DDg0pQtwzev1XlgS6z2QKNfDsY0zhiWeqVg04ZKN6wK
 hVFqXLvHfvtSDzCRM/PF/Zj9FIUhqFAbB5+7WYbYyQvsknwLwmh0RK+mhH0tneVWDhprqILIjHU
 aMjAKZsJXMJotHxBYvcIseu6fL2jMeaadWEbXqNpbvpicDmdObW1AFKYszivG2Z00HbZYz7C+nx
 deYykrvqhPUC4cY63K4LPeOwTYaRNCEXklXD65FsnrdFxcIQ2s0gbFxmfQuNd0e8yak5Wr14Ljg
 RALCVK/PmemJWosvkpVDGTncNC9abptsHD76eWT3hkxW16KF3OjQau73c77kH1ScKEXGiWJnBDi
 aupjQ5Z+CKg2cxJAfrSOfJMnIOVooRDb1dDN6gJT1Trm482jCkhRR4Rnt33bzHucR86Tt8VncS5
 pfLp15l7pDHX8XDDfHSlcOGGWMw=
X-Received: by 2002:a17:90b:3890:b0:3ab:a3ee:33ad with SMTP id
 98e67ed59e1d1-3b0db6bbc23mr4962610a91.22.1794029359678; 
 Fri, 06 Nov 2026 21:29:19 -0800 (PST)
Received: from [28.0.0.1] ([2406:da18:294:1d00:2519:75b6:8407:b92c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058a7b29sm1762195a91.10.2026.11.06.21.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 21:29:19 -0800 (PST)
Message-ID: <f6bb05cb-a466-4247-ac2f-0ac9480dc820@gmail.com>
Date: Sat, 7 Nov 2026 13:29:11 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: use gen_goto_tb for vsetvli
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20261105074115.99275-1-chao.liu@processmission.com>
Content-Language: en-US
From: WX Chen <wxchen0913@gmail.com>
In-Reply-To: <20261105074115.99275-1-chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=wxchen0913@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/26 15:41, Chao Liu wrote:
> I would like to discuss this a bit further. In fact, we can divide this into
> five cases:
>
>     Case                    Condition                Current implementation
> ------------------------------------------------------------------------------
> 1. vsetvl  rd, rs1, rs2    vtype from rs2 register  keep lookup_and_goto_ptr()
> 2. vsetvli x0, x0,  imm    rd == 0 && rs1 == 0      keep lookup_and_goto_ptr()
> 3. vsetvli rd, rs1, imm    rd != 0 && rs1 != 0      new path
> 4. vsetvli x0, rs1, imm    rd == 0 && rs1 != 0      new path
> 5. vsetvli rd, x0,  imm    rd != 0 && rs1 == 0      new path
>
> Currently there are two TB exit forms:
>
>   - Case1 and Case2 is the existing lookup_and_goto_ptr() exit.
>   - Case3 ~ Case5 is the new split exit, which compares the returned VL against
>     VLMAX and uses two goto_tb slots.
>
> The new path can be improved. For rs1 == 0 a single gen_goto_tb() call is
> enough, because the successor TB lookup key cannot change between executions.
>
> So, We give three exit forms:
>
>    1. lookup: keep lookup_and_goto_ptr()
>    2. single: one gen_goto_tb() slot
>    3. split: compare VL against VLMAX and use two gen_goto_tb() slots
>
> The cases map to the exit forms as follows:
>
>    Case   Exit form
>    --------------------------------------
>    1      lookup
>    2      lookup
>    3      split, or single when maxsz < 8
>    4      split, or single when maxsz < 8
>    5      single
>
> For cases 3 and 4, we care about the case where VL is not equal to
> VLMAX. To explain this, let us look at VL_EQ_VLMAX first. It is computed
> in riscv_get_tb_cpu_state() in target/riscv/tcg/tcg-cpu.c:
>
>    vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) && (maxsz >= 8)
>
> In two cases, the AVL comes from a GPR rather than an immediate, so
> VL may or may not equal VLMAX. Using the split exit is fine in that
> situation. When maxsz < 8, however, VL_EQ_VLMAX is forced to zero. In
> that case, both VL values map to the same successor key during the TB
> lookup, so a single slot is enough.


Hi Chao:
Thanks for the detailed review! I hadn't noticed the maxsz >= 8 
condition for VL_EQ_VLMAX.

Thanks for pointing that out!

I'll take this condition into account in v2.

Best regards,
WX Chen


