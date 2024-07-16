Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE0EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkNH-0000k0-Bi; Tue, 16 Jul 2024 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTkMo-0000eK-Mn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:45:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTkMj-0005Rv-AD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:45:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59a47d5c22aso6577371a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721144717; x=1721749517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tnC94CA6Wtnoc/KfdjZwVUh67iEETLFKI5zEbjRRUA8=;
 b=VgM1KUNAc2dhMu7RUNpdWGxB1RBHBcsdRs+AidnAocZI4vN/BQ1EBKzJ3B2jONEfAN
 fSqCD/c6vMbzvMGoZSMscWLj7HRxY9PMo3yD7SjU9QYIp9Lns7Y3Aq3UR0kTAJ9kmIdd
 GM54Yb0Pp8/4sIQvDqFwu196q/6TxIAZuljLZsD381o4lDFx3lF4NpVKLJcCPRT/G9Nt
 s32EvsW86KxnAFXtOSYSGxp+HZSCmr6lZEWX4WRRAhE7ifVbQ2GtGHdQB/Nm/KuRHfdk
 C0kl5HOLvrRMBZ2KPn+vAwjPzfF+vEVr/11301yAlFO0cZ6gFsQMSr9Uhs9yE7Vzrw9o
 cKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721144717; x=1721749517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnC94CA6Wtnoc/KfdjZwVUh67iEETLFKI5zEbjRRUA8=;
 b=nD8gcLLWTH17+apuYedc2mCKgQfZZ0Mt1ifOtuE+79cJHQ5gN6/tzWTklzt4UQw9yr
 8SpCLqXZO4nUmC82WbbzFR6s/Ciw5WLLT5b20HFI+PkQwLtfM6ew9xtFZQkzBbpUyvCN
 8YO2x2FKgAQPrBRKFmAeLckyKZjGRqjPaeupkSKUQ15clfs1i7nxBrWADYn01L+z/nWf
 lFuu403SEkGoAys0RDci3L8JnVkafymmLs4YN4dm2nbbXEGjFslj9aTsygn4pj433msx
 3ZUcd1gUohdquKnzcpxagXamhfr13f8+vMw9xVHjBlpabjMcnYwVhQHRFugTUXaiu60p
 KYfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyhAEbEQ7vaugZ+C7E/LiWru8hcGoA57KCwLYEzfGmpVedEnGl4aDIdhwtCqTIviJLLwKmhLqSaGkSzey8Ju/OAOsgq+U=
X-Gm-Message-State: AOJu0Yw1ZlSGlNyztpW5yn472II2/4ahaKEc03benFvVi3163iwjvsMp
 vzXaGdLIQCfr2F0Jt7kEzK4J83Np78Ug7PJQxWXsgx+PxnlEcO9vWttKdtVMZmPQvN/VTGj5Rb3
 bxW/HkzsmnF8+l8Q7WECdG5xZ8Xvz3zHaIML5EA==
X-Google-Smtp-Source: AGHT+IEs3jK3hckx/cw9tJsCBh5KG0VMX0CBpcDARh/n27bdiCT/MjmCHK2eXWtkmCLOsFdtOEIw2E4nVUug/3GNFZY=
X-Received: by 2002:a50:8adb:0:b0:57c:f091:f607 with SMTP id
 4fb4d7f45d1cf-59ef00b4020mr1733294a12.29.1721144716935; Tue, 16 Jul 2024
 08:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
In-Reply-To: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 16:45:05 +0100
Message-ID: <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
<gankulkarni@os.amperecomputing.com> wrote:
>
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---

In target/arm/cpu.c:arm_cpu_realizefn() there is this code:

    if (cpu_isar_feature(aa64_mte, cpu)) {
        /*
         * The architectural range of GM blocksize is 2-6, however qemu
         * doesn't support blocksize of 2 (see HELPER(ldgm)).
         */
        if (tcg_enabled()) {
            assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
        }

#ifndef CONFIG_USER_ONLY
        /*
         * If we do not have tag-memory provided by the machine,
         * reduce MTE support to instructions enabled at EL0.
         * This matches Cortex-A710 BROADCASTMTE input being LOW.
         */
        if (cpu->tag_memory == NULL) {
            cpu->isar.id_aa64pfr1 =
                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
        }
#endif
    }

With this patch, for KVM we will end up going through the
"squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
set cpu->tag_memory and this is still using that as its check.

More generally, how does the enabling of the MTE KVM cap
interact with the ID_AA64PFR1_EL1 value that we read from
the host in kvm_arm_get_host_cpu_features() ? We care that we
have the right ID register values because we use ID field
checks to determine whether the vcpu has a feature or not,
even in the KVM case.

Since Cornelia first wrote the patch this is based on, we've
landed gdbstub support for MTE (so gdb can find out which
addresses in the memory map have tags and read and write
those tags). So I think the KVM MTE support now also needs to
handle that. (See aarch64_cpu_register_gdb_commands() in
target/arm/gdbstub64.c.)

thanks
-- PMM

