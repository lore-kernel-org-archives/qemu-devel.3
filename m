Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9998C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu5j-0007kK-Pm; Wed, 21 Feb 2024 16:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcu5U-0007S4-9w
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:25:09 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcu5R-00030T-6a
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:25:07 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-364efe11f6aso34880665ab.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708550703; x=1709155503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ly+eHYKQZikrFS/T0BXws43a/vi7lieY+J3mVy2jsZA=;
 b=cKpfn2OF7PG9IWt7MZR/tCp+InOVmwZkddvfBAhX/Iw7w6eNUiigKKsrLeRKkpXKj+
 q/8DlEXG/g/seGicKLJ2UzHfuY1GGOCkQU3s2zj9QZciwhNtDqW0x37qNdBeKG9KJl0n
 z42v3gyxGZQkQ+z2LTBmyo+FlWBhZ4dy3SPNHbSgd9tvmzrmCwH8Mgx22FvlX6opfojM
 K2ecqnNtx13QNmPjGHlsbTvMqNT9pCsD+9+H4e5lPVj9NtNQImAOJK10giYmvRhpEmmE
 DsF36KJnGZ4CeLpDZXaUTJkFsniVe5hU8pdgP4Y6Wllzh+y6x757mYigrbRtRAXtEZ5H
 geJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550703; x=1709155503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ly+eHYKQZikrFS/T0BXws43a/vi7lieY+J3mVy2jsZA=;
 b=G9lYkf1miGFEVm1ZzdxSvvKy/EPdIWXWHnXjNNJdIMn7wiH4BPz+dKokrDtwcpQbIe
 EC85fCn+fB/ag5IjuglnrWnPYgGqJdIKmQDJuTeDYwqjZW7Q8B+hFWTwNB0vhL2z4d8b
 r/QkKbopTJrGJ8aCkEQmLzwTo4oRChKxfHwppidoIkgH13A3VuyjIYPYtk6ddsWC2Kjm
 l0o40wHm5YeceCgXWAEWbIHFq7cuauR95AEA3aK6g8rhpwanYyXI3pk4AucmtJcSgdSJ
 cL8L93iW8hKz99yDwqlONVlg2VCKmGrRDNvcwBavfRlIl/Abq+jalE9A2fb74NCJwMO6
 JPag==
X-Gm-Message-State: AOJu0YyL9ZbinymQtIn6uBn7iDHB/P5bscowCYcAN1UXJw5SkIcdDMSO
 Cd79w9dZd4ozci8hIhlvJMljTe2R6NScbPReXk0cjntOkjxOMmF3YRwmwy/FEIXNLheYZTeGhaf
 4
X-Google-Smtp-Source: AGHT+IGK6pT3x21ohZeqqOWJP2Rl/lBGvx8tHnhd/lf68oxWonH5oSiywYNblf/BsErpk5NMJhmLfA==
X-Received: by 2002:a92:db4b:0:b0:365:2575:6d3 with SMTP id
 w11-20020a92db4b000000b00365257506d3mr12339494ilq.30.1708550703268; 
 Wed, 21 Feb 2024 13:25:03 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a63e151000000b005dc884e9f5bsm9138691pgk.38.2024.02.21.13.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:25:02 -0800 (PST)
Message-ID: <401679a5-ff0e-4911-acef-5774681f2e1d@ventanamicro.com>
Date: Wed, 21 Feb 2024 18:24:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] riscv: set vstart_eq_zero on mark_vs_dirty
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com
References: <20240221022252.252872-1-dbarboza@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240221022252.252872-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Richard,

On 2/20/24 23:22, Daniel Henrique Barboza wrote:
> Hi,
> 
> In this new version we removed the remaining brconds() from
> trans_rvbf16.c.inc like Richard suggested in patch 3. Richard, I kept
> your ack in that patch.
> 
> This change caused the 'cpu_vstart' global to be unused. A new patch (4)
> was added to remove it.
> 
> Series based on alistair/riscv-to-apply.next.
> 
> Patches missing acks: patch 4.


I missed your acks from v4 in patches 1 and 2 . I'll add them back in the next
version.


Thanks,


Daniel

> 
> Changes from v4:
> - patch 3:
>    - remove vstart >= vl and vl = 0 brconds from trans_fvbf16.c.inc
> - patch 4 (new):
>    - remove cpu_vstart
> - v4 link: https://lore.kernel.org/qemu-riscv/20240220222510.209448-1-dbarboza@ventanamicro.com/
> 
> 
> Daniel Henrique Barboza (6):
>    trans_rvv.c.inc: mark_vs_dirty() before loads and stores
>    trans_rvv.c.inc: remove 'is_store' bool from load/store fns
>    target/riscv: remove 'over' brconds from vector trans
>    target/riscv/translate.c: remove 'cpu_vstart' global
>    target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
>    trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
> 
> Ivan Klokov (1):
>    target/riscv: Clear vstart_qe_zero flag
> 
>   target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
>   target/riscv/insn_trans/trans_rvv.c.inc    | 292 ++++++---------------
>   target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
>   target/riscv/translate.c                   |  10 +-
>   target/riscv/vector_helper.c               |   1 +
>   5 files changed, 100 insertions(+), 251 deletions(-)
> 

