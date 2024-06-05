Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C55C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 03:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEhPy-0000tP-V1; Tue, 04 Jun 2024 23:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEhPv-0000t4-Hi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:34:27 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEhPt-0007Eu-Ak
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:34:27 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6c55e3d2740so346674a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 20:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717558463; x=1718163263; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5VAYHFU492pz04tgjhSTWj5MtVeGwNywFm4FrzJrfs=;
 b=dUdc0h9C0Fpa3FBfXmi3ugKC2imdwB89uQrewON7q/DIBl7mGyk2BBxLEpdvAGJzWJ
 VYB26Lz8xFoM+I3aBRC5bqmX5ht04fdzLbAV6b6qF9ocRY8LovcHx7UHFN/BKYRBeCwr
 sIfeVtzrOmLJnJ1JN5ZBkPc3X7lsGAT4Cb57ljzpj7zDE6mI2xV+rI3CpeoECawNh2dG
 qASnrL0eOywFYTpO+/gx037bGKE2tMMhHrOuEQT2WLr0uqu8kF+elusWYf9De0mbDB6+
 +e9hT8QwId+PHy7hxBS/XFdVOxbuJoZqYEeIeZpw7nuBrayIXBkbdtdpToeSMgUWxREp
 6YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558463; x=1718163263;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V5VAYHFU492pz04tgjhSTWj5MtVeGwNywFm4FrzJrfs=;
 b=rR8jiVpWBujRORVzgcOYxPcdZQs/piYGeeh3+bOLJNOWwtR/+ldao8t2NZWWO1OjwD
 Tu7P6WC46byD2zRP/OreTOSgLEBBNHJGxBTXRy3uGY5t0v7hXrSfzZj1ZoFDVo2YUyaf
 Y1TqEOO0O/Kj7LIlEW30cLOW/irxo+ZQDvYteiy5YWTJVZ8xP8ZleeOVj/S/pJCkKV/D
 3q70Jm7AlbYmPzUYFUgE1ioZFl39cLo6aWxIclIyF/W1L570dkxJqPbFEJe9iYIhfV2r
 Wlaty7+EicDpR3mkmHKG5I6SlE880NtJeRvHID2t5ziXYjzsh2v5Ls743SmGXugF8KJ3
 XYTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrNq1/YhanuUhO4xNpNHfMZhDSGYA+T1BXLDFbaj3aB15PXZ39Cf2LPJ+bemPYGO0mlnCuHFKvkWbUYCSw4AYEy3Yew+A=
X-Gm-Message-State: AOJu0Yyw8WSFHcEZuy5OH1KqoKz/X2gWJF68NpZOSCD8lCQe6aOvOjdd
 ZIEIfGw1AsDnHLlQgKNw4eLm7oSVshM7Cgu3JUZNkrcadhWRyk2AQWNq3yr6/5TKjuZmP0RPJNg
 iI38=
X-Google-Smtp-Source: AGHT+IEqb9vtxMBSEwBbZUNtsCqXE5xyBD+LbeP2TQNQe51kDTXcSlkrUEgYd+rXk4ufEJWZeI3x5w==
X-Received: by 2002:a17:90b:1e11:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2c27cc3d5fdmr2232235a91.15.1717558463222; 
 Tue, 04 Jun 2024 20:34:23 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28067b192sm309929a91.30.2024.06.04.20.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 20:34:22 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------WYIS1LWe0NRq2HXlYwrkjJfU"
Message-ID: <d294f246-c31f-4329-979a-ceef0d8e7bea@sifive.com>
Date: Wed, 5 Jun 2024 11:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Beeman Strong <beeman@rivosinc.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, alistair.francis@wdc.com,
 apatel@ventanamicro.com, atishp@rivosinc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, liweiwei@iscas.ac.cn, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, tech-control-transfer-records@lists.riscv.org,
 zhiwei_liu@linux.alibaba.com
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
 <CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------WYIS1LWe0NRq2HXlYwrkjJfU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for pointing that out. CTR does not use miselect and mireg*. 
There is no dependency on Smcsrind. I believe the spec needs to be 
corrected.

Chapter 1 states that:
Smctr depends on the Smcsrind extension, while Ssctr depends on the 
Sscsrind extension. Further, both Smctr and Ssctr depend upon 
implementation of S-mode.

Beeman Strong 於 2024/6/5 上午 06:32 寫道:
> There is no dependency on Smcsrind, only Sscsrind.
>
> On Tue, Jun 4, 2024 at 12:29 AM Jason Chien <jason.chien@sifive.com> 
> wrote:
>
>     Smctr depends on the Smcsrind extension, Ssctr depends on the
>     Sscsrind
>     extension, and both Smctr and Ssctr depend upon implementation of
>     S-mode.
>     There should be a dependency check in
>     riscv_cpu_validate_set_extensions().
>
>     Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
>     > This series enables Control Transfer Records extension support
>     on riscv
>     > platform. This extension is similar to Arch LBR in x86 and BRBE
>     in ARM.
>     > The Extension has been stable and the latest release can be
>     found here [0]
>     >
>     > CTR extension depends on couple of other extensions:
>     >
>     > 1. S[m|s]csrind : The indirect CSR extension [1] which defines
>     additional
>     >     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size
>     limitation of
>     >     RISC-V CSR address space. CTR access ctrsource, ctrtartget
>     and ctrdata
>     >     CSRs using sscsrind extension.
>     >
>     > 2. Smstateen: The mstateen bit[54] controls the access to the
>     CTR ext to
>     >     S-mode.
>     >
>     > 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
>     >
>     > The series is based on Smcdeleg/Ssccfg counter delegation
>     extension [3]
>     > patches. CTR itself doesn't depend on counter delegation
>     support. This
>     > rebase is basically to include the Smcsrind patches.
>     >
>     > Due to the dependency of these extensions, the following
>     extensions must be
>     > enabled to use the control transfer records feature.
>     >
>     >
>     "smstateen=true,sscofpmf=true,smcsrind=true,sscsrind=true,smctr=true,ssctr=true"
>     >
>     > Here is the link to a quick guide [5] to setup and run a basic
>     perf demo on
>     > Linux to use CTR Ext.
>     >
>     > The Qemu patches can be found here:
>     > https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
>     >
>     > The opensbi patch can be found here:
>     > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream
>     >
>     > The Linux kernel patches can be found here:
>     > https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream
>     >
>     > [0]:https://github.com/riscv/riscv-control-transfer-records/release
>     > [1]:https://github.com/riscv/riscv-indirect-csr-access
>     > [2]:https://github.com/riscvarchive/riscv-count-overflow/tree/main
>     > [3]:https://github.com/riscv/riscv-smcdeleg-ssccfg
>     >
>     [4]:https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/
>     >
>     [5]:https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine
>     >
>     > Rajnesh Kanwal (6):
>     >    target/riscv: Remove obsolete sfence.vm instruction
>     >    target/riscv: Add Control Transfer Records CSR definitions.
>     >    target/riscv: Add support for Control Transfer Records
>     extension CSRs.
>     >    target/riscv: Add support to record CTR entries.
>     >    target/riscv: Add CTR sctrclr instruction.
>     >    target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
>     >      regs.
>     >
>     >   target/riscv/cpu.c                            |   4 +
>     >   target/riscv/cpu.h                            |  14 +
>     >   target/riscv/cpu_bits.h                       | 154 +++++++++
>     >   target/riscv/cpu_cfg.h                        |   2 +
>     >   target/riscv/cpu_helper.c                     | 213 ++++++++++++
>     >   target/riscv/csr.c                            | 312
>     +++++++++++++++++-
>     >   target/riscv/helper.h                         |   8 +-
>     >   target/riscv/insn32.decode                    |   2 +-
>     >   .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
>     >   target/riscv/insn_trans/trans_rvi.c.inc       |  27 ++
>     >   target/riscv/op_helper.c                      | 117 ++++++-
>     >   target/riscv/translate.c                      |   9 +
>     >   12 files changed, 870 insertions(+), 13 deletions(-)
>     >
>
--------------WYIS1LWe0NRq2HXlYwrkjJfU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Thank you for pointing that out. CTR does not use miselect and
      mireg*. There is no dependency on Smcsrind. I believe the spec
      needs to be corrected.<br>
    </p>
    <p>Chapter 1 states that:<br>
      Smctr depends on the Smcsrind extension, while Ssctr depends on
      the Sscsrind extension. Further, both Smctr and Ssctr depend upon
      implementation of S-mode.<br>
    </p>
    <div class="moz-cite-prefix">Beeman Strong 於 2024/6/5 上午 06:32 寫道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="auto">There is no dependency on Smcsrind, only
          Sscsrind. </div>
      </div>
      <div><br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, Jun 4, 2024 at
            12:29 AM Jason Chien &lt;<a
              href="mailto:jason.chien@sifive.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">jason.chien@sifive.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Smctr
            depends on the Smcsrind extension, Ssctr depends on the
            Sscsrind <br>
            extension, and both Smctr and Ssctr depend upon
            implementation of S-mode.<br>
            There should be a dependency check in
            riscv_cpu_validate_set_extensions().<br>
            <br>
            Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:<br>
            &gt; This series enables Control Transfer Records extension
            support on riscv<br>
            &gt; platform. This extension is similar to Arch LBR in x86
            and BRBE in ARM.<br>
            &gt; The Extension has been stable and the latest release
            can be found here [0]<br>
            &gt;<br>
            &gt; CTR extension depends on couple of other extensions:<br>
            &gt;<br>
            &gt; 1. S[m|s]csrind : The indirect CSR extension [1] which
            defines additional<br>
            &gt;     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address
            size limitation of<br>
            &gt;     RISC-V CSR address space. CTR access ctrsource,
            ctrtartget and ctrdata<br>
            &gt;     CSRs using sscsrind extension.<br>
            &gt;<br>
            &gt; 2. Smstateen: The mstateen bit[54] controls the access
            to the CTR ext to<br>
            &gt;     S-mode.<br>
            &gt;<br>
            &gt; 3. Sscofpmf: Counter overflow and privilege mode
            filtering. [2]<br>
            &gt;<br>
            &gt; The series is based on Smcdeleg/Ssccfg counter
            delegation extension [3]<br>
            &gt; patches. CTR itself doesn't depend on counter
            delegation support. This<br>
            &gt; rebase is basically to include the Smcsrind patches.<br>
            &gt;<br>
            &gt; Due to the dependency of these extensions, the
            following extensions must be<br>
            &gt; enabled to use the control transfer records feature.<br>
            &gt;<br>
            &gt;
"smstateen=true,sscofpmf=true,smcsrind=true,sscsrind=true,smctr=true,ssctr=true"<br>
            &gt;<br>
            &gt; Here is the link to a quick guide [5] to setup and run
            a basic perf demo on<br>
            &gt; Linux to use CTR Ext.<br>
            &gt;<br>
            &gt; The Qemu patches can be found here:<br>
            &gt; <a
href="https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; The opensbi patch can be found here:<br>
            &gt; <a
href="https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; The Linux kernel patches can be found here:<br>
            &gt; <a
href="https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; [0]:<a
href="https://github.com/riscv/riscv-control-transfer-records/release"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/riscv/riscv-control-transfer-records/release</a><br>
            &gt; [1]:<a
              href="https://github.com/riscv/riscv-indirect-csr-access"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/riscv/riscv-indirect-csr-access</a><br>
            &gt; [2]:<a
href="https://github.com/riscvarchive/riscv-count-overflow/tree/main"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/riscvarchive/riscv-count-overflow/tree/main</a><br>
            &gt; [3]:<a
              href="https://github.com/riscv/riscv-smcdeleg-ssccfg"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/riscv/riscv-smcdeleg-ssccfg</a><br>
            &gt; [4]:<a
href="https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/</a><br>
            &gt; [5]:<a
href="https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine</a><br>
            &gt;<br>
            &gt; Rajnesh Kanwal (6):<br>
            &gt;    target/riscv: Remove obsolete sfence.vm instruction<br>
            &gt;    target/riscv: Add Control Transfer Records CSR
            definitions.<br>
            &gt;    target/riscv: Add support for Control Transfer
            Records extension CSRs.<br>
            &gt;    target/riscv: Add support to record CTR entries.<br>
            &gt;    target/riscv: Add CTR sctrclr instruction.<br>
            &gt;    target/riscv: Add support to access ctrsource,
            ctrtarget, ctrdata<br>
            &gt;      regs.<br>
            &gt;<br>
            &gt;   target/riscv/cpu.c                            |   4 +<br>
            &gt;   target/riscv/cpu.h                            |  14 +<br>
            &gt;   target/riscv/cpu_bits.h                       | 154
            +++++++++<br>
            &gt;   target/riscv/cpu_cfg.h                        |   2 +<br>
            &gt;   target/riscv/cpu_helper.c                     | 213
            ++++++++++++<br>
            &gt;   target/riscv/csr.c                            | 312
            +++++++++++++++++-<br>
            &gt;   target/riscv/helper.h                         |   8
            +-<br>
            &gt;   target/riscv/insn32.decode                    |   2
            +-<br>
            &gt;   .../riscv/insn_trans/trans_privileged.c.inc   |  21
            +-<br>
            &gt;   target/riscv/insn_trans/trans_rvi.c.inc       |  27
            ++<br>
            &gt;   target/riscv/op_helper.c                      | 117
            ++++++-<br>
            &gt;   target/riscv/translate.c                      |   9 +<br>
            &gt;   12 files changed, 870 insertions(+), 13 deletions(-)<br>
            &gt;<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------WYIS1LWe0NRq2HXlYwrkjJfU--

