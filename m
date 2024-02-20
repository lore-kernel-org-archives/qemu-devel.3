Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD677C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 23:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcZwr-0003Y5-2K; Tue, 20 Feb 2024 18:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcZwp-0003VN-BO
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:54:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcZwf-0001jM-0z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 18:54:51 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so8115905ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 15:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708473279; x=1709078079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WwXbvlqr67ux4FXJYs4OgB9FNwKkqSZHPiZWWDxeRzo=;
 b=l7b+GV1lYgbVhRDC1ft3cj4RRVMf+/lKR2jpDkm9WPQfZOW/sZW/ecNiTVz2w92+ZY
 z0G4FtL25F1rOqCxn0pGR/vAir3jCOe3GJdRmRkcDXhRDOrCaKgaz8sA6QJ+d6UR/l9v
 i8pTkjlE4NOXD7aq4MVtTMnJ6RbPsaeWQ98y1ysiAKgZ7yqmtvLPX3k1dsOeykNcH5bs
 asLgMPqf7VWhH2yRTThPMDGY4qNsh7/PszMQmRrZONoNuLj6ALX+vx8UgRXSv+uzpLXU
 n5X3mYF7IpQzKhmipiv+chEJusaLzk/VHQ/ld9fxgHxJ3JXlFScKwzHHYHfaw70FNUuk
 SYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708473279; x=1709078079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwXbvlqr67ux4FXJYs4OgB9FNwKkqSZHPiZWWDxeRzo=;
 b=a4+gM0UmvBIxRRo4FOR7IDEyRFzLWuRtEmwx9MK/Lt6DMjXK6g6dRT+J/HZVD5eOVp
 cRlomUApRNOJyAVr/1qvDAPAi/a+shf4TRlUOFVk3NQeOrfhsRXGw0WH1pkwb/qZBUPN
 087CiCd6xD8tYjb+AIX2MgHXHq28V9Zcj8on5voX9CMBAiBD+S82dGb5+DJFD0IAKRnO
 MycvdVfczOWLsikdniLFfp3Zi+FOpQzO1KGaTbnMadQYB5mXYwZLhsxN8PjjwuB8a4am
 qVHEc5C0QB/1IsK61zwjbqtsJ/iKbPzOoceflp2Ngu4Nr4zEhEH3piHfhONHlqS2nnh2
 iJ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWw5Lk4DrJXqCMaB+YkXVxlXspiEzeVACp91A/hX8kpyIbXtVXzVxwryLgGnMHUjPr1AePRVUl0AuPLVmaau1d++mTz/U=
X-Gm-Message-State: AOJu0YyL6ZGHK2N2KuKiiGa7A5ZVDYnzB9p2Q0SV/LXcRFJArmLx0BVa
 yt3ysLO4KMdKC3dDiIe5IqiY81jEVNimg8/5D36arn0gg9HJfa9TbaR/foEbQNo=
X-Google-Smtp-Source: AGHT+IHU14xURtKjAOAXQocEYH1Uz1LxO96Hj2uusBSGZRpkfScPyHMpxCP//Jyhsz7nq2Vqhj3UfQ==
X-Received: by 2002:a17:902:7843:b0:1da:2a91:8c08 with SMTP id
 e3-20020a170902784300b001da2a918c08mr16563702pln.3.1708473279067; 
 Tue, 20 Feb 2024 15:54:39 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 iz13-20020a170902ef8d00b001db9493104fsm6814177plb.79.2024.02.20.15.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 15:54:38 -0800 (PST)
Message-ID: <db20705c-7f29-43df-8c99-96dc573149dc@linaro.org>
Date: Tue, 20 Feb 2024 13:54:34 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/riscv: remove 'over' brconds from vector
 trans
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
 <20240220222510.209448-4-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220222510.209448-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/20/24 12:25, Daniel Henrique Barboza wrote:
>   target/riscv/insn_trans/trans_rvv.c.inc  | 117 -----------------------
>   target/riscv/insn_trans/trans_rvvk.c.inc |  18 ----
>   2 files changed, 135 deletions(-)

There are additional instances in trans_rvbf16.c.inc, including extra useless checks for 
vl == 0.


r~

