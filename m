Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA81ECCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squUT-0005v0-Ql; Wed, 18 Sep 2024 09:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squUS-0005u1-8u
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:13:04 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squUQ-0004yl-Ev
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:13:03 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f7528f4658so50271431fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726665180; x=1727269980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1UIao/Jz5H8HMYQFxpoEYcHdlz/BHFAG+1NToY/M7y4=;
 b=uC3wh7ofxzBlYtYf8fC6jrxngnOUjxUnyD50bL3Xgmda0EZAV/C9oW2owVpvuTnwwV
 xNkaF6hynUZgmHeTNW2osOeYy+Yyl1N7A15L9ooTdsqvOexEz8aHpnYHtFAiZ+IDgE4s
 iPV4/VPgeJpTAIZrc8FllLZgqU93IX4KAtEOuVcDLRxJPXzekpGuEm6NkzOWXOeSA+cS
 e87yMxdjfHnFZwqRUxZYZo60lX4oaZOoZHLInWMgPq1veZrYxNUw2ZDMS0AdYFrXhp7F
 ZAw9VH2er2FWE5KHRkPXv+WrTEhPKa1sYiTuso69TzRi/C1KA6yd3rfRmp8tP8uu9PYA
 Kk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726665180; x=1727269980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1UIao/Jz5H8HMYQFxpoEYcHdlz/BHFAG+1NToY/M7y4=;
 b=eZVOtvsTXGrqHv5lg537w8kTwlLKO1ZD0Q6MWvEwd4HCuIv6o/6LS7v8yX3eWqiHhP
 twnEDXS9B2LtnD9hVbxu4RcIFdT+kwJtzYgVs+FICuakTEqTjI92gZ/T+s6BBHJOY2Lt
 df2O/Yjqz5lhMEV78mj+5owHHhPGWlDdcdQra8dIN5PIjugHwrUwlLYE6vLmtypRENsh
 zggsWAdk/S11mlNIUXSTITRdyguasM3c2o5U59IGSl88emOdyb11HRJHebCZXS1srJPL
 6ulyy5xONLSnndqFmGjMCSD43wcuM/XJqGB08FHK58LDVjIBn3o47d/1vi8Sl94BI89I
 +2Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXspCfJa1+849pQo+43dDU3cbulS/EluxGySLeB22PnCQvxpKOx0Bm1p+rypiyjiDY8RZ7SC3zAKMhI@nongnu.org
X-Gm-Message-State: AOJu0YyFrA2oh4lcy46II5IgeAjY7tDt/CiG2I4PZ5Z79d15h0j29sp1
 FGkbo2Veip+EU0+guRBwFVV6LW0YroRL/CsX6/D8jRvNvjnYQaxrawG3xFRR4vwSWYTMaiXVYBJ
 vJyIRwAhEeH6ohE2LYpjU+Dlnev1ANEVtQ8kJTw==
X-Google-Smtp-Source: AGHT+IF5izfJa+xhgK0mjYVqlKJIK89IcU1cb1NpZfcXm0pryp2o/BMT6N8z0wfXVAWqfUbW+2JjG7UdxmVTGR7xheE=
X-Received: by 2002:a05:651c:509:b0:2f3:fd4a:eac6 with SMTP id
 38308e7fff4ca-2f7919fe8d6mr81760011fa.18.1726665180209; Wed, 18 Sep 2024
 06:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
In-Reply-To: <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Sep 2024 14:12:48 +0100
Message-ID: <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> Thanks Peter for looking into this.
>
> QEMU's cpu_synchronize_all_post_init() and
> do_kvm_cpu_synchronize_post_reset() both end up in
> kvm_arch_put_registers() and that is long after Linux
> kvm_arch_vcpu_create() has been setting some FPU state. See the output
> below.
>
> kvm_arch_put_registers() copies the CSRs by calling
> kvm_riscv_put_regs_csr(). Here we can find:
>
>      KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>
> This call enables or disables the FPU according to the value of
> env->mstatus.
>
> So we need to set the desired state of the floating point unit in QEMU.
> And this is what the current patch does both for TCG and KVM.

If it does this for both TCG and KVM then I don't understand
this bit from the commit message:

# Without this patch EDK II with TLS enabled crashes when hitting the first
# floating point instruction while running QEMU with --accel kvm and runs
# fine with --accel tcg.

Shouldn't this guest crash the same way with both KVM and TCG without
this patch, because the FPU state is the same for both?

-- PMM

