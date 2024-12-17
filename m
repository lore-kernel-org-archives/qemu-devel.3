Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B98E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNQvd-0001fG-5A; Tue, 17 Dec 2024 01:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNQvb-0001f6-DN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:19:31 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNQvW-0004Ra-Pj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:19:29 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so757557166b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416364; x=1735021164; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVseDjumnSWmx/oo0t9MAhGwt/x1D7g+yQ9rTqtao+Y=;
 b=Vc22R+0rlLbPXzv3pkOH7bVqeYVLgUL0UF48/h5G8ukc9rTzD2xnCKG2V57jxEwx6+
 1J86aTx13K6K5pnID9k8W3+hjXI30chSFJbPgivTwI8e3nHjkFrf0umDwWSLxZnAkltE
 eAvUJ2xZZF0JprKTWQQuc9yJFWjSK14igeY/9CJyO10uvIb66n40vZ57IZeGnmN277dA
 2/ze1cKyBQF5ZF+YeCVYBr8x5gfNDYX3AMshSOsChsNAnvovQLaHdOC1JWDsAIGfRoOT
 3w4VZ7JOLYfmt6jycO0LDE+IkWteNO+iAdV3BDSOqfEulE039qA9uiusD6p3V73B310Y
 HKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416364; x=1735021164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVseDjumnSWmx/oo0t9MAhGwt/x1D7g+yQ9rTqtao+Y=;
 b=XAhlGG0TdnKdXVuWUVNOvcWAtIRRMuAYD1D7WKbU27cMGSBYZWMqOuI2wK6cFMJzmV
 opfnSy7VDkdN5D9m+t6Gsb69gKA9bRyqB7nKP3a0kMg5KzyBZfcVD78MQku/KuV4iQ0R
 glG4u1VNSO7lfkwtrgN3opHpfyekkAsye1x/1aszypnji21Z9ukPfNLsrnfpoA5KF9DW
 3F2TAYM1Frkf2tNnL3QVGG0CvD30+R5B+MZsOEi56MIKLtH0S/IqqLZe+/WQ+cY67Xya
 OSKfMs1MAXPKSUjmvZpwC5AVYlG7P5UPeNwB91KnDtgUdVCMeW94FamJGM/F/Z2V7y2R
 IBgw==
X-Gm-Message-State: AOJu0YxyDYjjkuTeKGIlPldjkruhDEVeDlT3Dly6meQyjn+M2NQB8m81
 eVpxaGrV/cLBO5oOmUt5i+hbsTLKfiID9NkZMIWZqq+GWjBD3LB+gHgAfxqrfEFOHat1IL2DfHO
 aIq8mimVsiCqAORgtCOMOWvP9a61SCRkIcyw8WsBQQq26GwafXV4=
X-Gm-Gg: ASbGncsudCWaD2IurLrF9SgXXZzFA/szVBtzTlU4aVPBWatWOOwSymZhy5Os6TQEuG3
 7IVfdFECMrs9G5urFqBOWzAHxpAhGJ1uCCqsxdMQ=
X-Google-Smtp-Source: AGHT+IG24JO7EUDOo7Ny65cQDJ3t26epMC0OyIqWfCG2TFFR72z1oW9oxRsf3njI+TZYNUssMK9oCA2DkY6hl7oXKhs=
X-Received: by 2002:a17:906:3191:b0:aa5:1a1c:d0a2 with SMTP id
 a640c23a62f3a-aab779d16f0mr1072294066b.34.1734416363611; Mon, 16 Dec 2024
 22:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20241122032217.3816540-1-frank.chang@sifive.com>
 <b25e776f-43f1-4d8d-a103-64ddfce75412@ventanamicro.com>
In-Reply-To: <b25e776f-43f1-4d8d-a103-64ddfce75412@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 17 Dec 2024 14:19:09 +0800
Message-ID: <CAE_xrPiXqvCz9Eeu=B140_Yjg7othZUUQCdYRiy=GW0_8Dk6RQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Add Smrnmi support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003f06140629714786"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000003f06140629714786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:46=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Frank,
>
> Sorry for the delay.
>
> It seems like this series is breaking the "make check-functional" test:
>
> $ make check-functional
> (...)
>   9/10 qemu:func-thorough+func-riscv32-thorough+thorough /
> func-riscv32-riscv32_tuxrun TIMEOUT         90.03s   killed by signal 15
> SIGTERM
> 10/10 qemu:func-thorough+func-riscv64-thorough+thorough /
> func-riscv64-riscv64_tuxrun TIMEOUT        120.08s   killed by signal 15
> SIGTERM
>
> Ok:                 8
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            2
>
> The reason for the timeouts is that the tests are trying to boot Linux wi=
th
> 'rv64' and 'max' CPUs, and the timeout occurs when trying to boot using
> the 'max' CPU, i.e. it is using a CPU with ext_smrnmi enabled.
>
>  From the cover letter it seems like we need a special OpenSBI to use the
> extension, but apparently not having a customizable OpenSBI will make the
> extension misbehave.
>
> My suggestion here is, in patch 5, remove ext_smrnmi from the 'max' CPU.
> We can re-enable it when our OpenSBI image has the proper support for it.
> Like this:
>
> $ git diff
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 3480767b35..f3fb1c432b 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1429,6 +1429,12 @@ static void riscv_init_max_cpu_extensions(Object
> *obj)
>       if (env->misa_mxl !=3D MXL_RV32) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
>       }
> +
> +    /*
> +     * ext_smrnmi requires OpenSBI changes that our current
> +     * image does not have. Disable it for now.
> +     */
> +    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>   }
>
> This will make 'make check-functional' work again. Thanks,
>
>
> Daniel
>
>
>
Thanks, Daniel

I will update it in the v10 patchset.

Regards,
Frank Chang


>
> On 11/22/24 12:22 AM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > This patchset added support for Smrnmi Extension in RISC-V.
> >
> > There are four new CSRs and one new instruction added to allow NMI to b=
e
> > resumable in RISC-V, which are:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    * mnscratch (0x740)
> >    * mnepc     (0x741)
> >    * mncause   (0x742)
> >    * mnstatus  (0x744)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    * mnret: To return from RNMI interrupt/exception handler.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > RNMI also has higher priority than any other interrupts or exceptions
> > and cannot be disabled by software.
> >
> > RNMI may be used to route to other devices such as Bus Error Unit or
> > Watchdog Timer in the future.
> >
> > The interrupt/exception trap handler addresses of RNMI are
> > implementation defined.
> >
> > If anyone wants to test the patches, we can use the customized
> OpenSBI[1],
> > and the customized QEMU[2].
> >
> > We implemented a PoC RNMI trap handler in the customized OpenSBI.
> > In the customized QEMU, we use the Smrnmi patches and the patch from
> > Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> > the RNMI signal with the qmp command.
> >
> > [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> > [2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v8
> > [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
> >
> > Test commands :
> > $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> > rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> > OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> > -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> > -qmp unix:/tmp/qmp-sock,server,wait=3Doff
> >
> > Use qmp command to inject the RNMI.
> >
> > Assert RNMI:
> > $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> > (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi num=
ber=3D0
> value=3Dtrue
> >
> > De-assert RNMI:
> > (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi num=
ber=3D0
> value=3Dfalse
> >
> > Changelog:
> >
> > v9
> >    * Add Zicfilp support for Smrnmi.
> >    * Change the existence checks for 'rnmi-interrupt-vector' and
> >      'rnmi-exception-vector' to use 'num_rnmi_irqvec' and
> 'num_rnmi_excpvec'.
> >    * Add warn_once messages for cases where the user sets
> >      'rnmi-interrupt-vector' or 'rnmi-exception-vector' property withou=
t
> >      enabling Smrnmi.
> >
> > v8
> >    * Set virt to false when trapping to M-mode by RNMI.
> >    (Thanks to Cl=C3=A9ment for the suggestions.)
> >
> > v7
> >    * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
> >      checking codes.
> >    (Thanks to Cl=C3=A9ment for the suggestions.)
> >    * Add the missing REQUIRE_SMRNMI() check and remove the redundant
> >      check in 'helper_mnret'.
> >    * Rebase to riscv-to-apply.next.
> >    (Thanks to Alistair for the suggestions.)
> >
> > v6
> >    * Delete the redundant code in 'riscv_cpu_do_interrupt'.
> >    (Thank Alvin for the suggestion.)
> >    * Split the shared code in 'helper_mret' and 'helper_mnret' into a
> >      helper function 'check_ret_from_m_mode'.
> >    (Thank Alistair for the suggestion.)
> >
> > v5
> >    * Move the patch that adds the Smrnmi extension to the last patch.
> >    (Thank Alistair for the suggestion.)
> >    * Implement an M-mode software PoC for this with implemented handler=
s.
> >    (Thank Andrew Jones for the suggestion.)
> >    * Add a commit message to all patches of the series.
> >    (Thank Andrew Jones for the suggestion.)
> >
> > v4
> >    * Fix some coding style issues.
> >    (Thank Daniel for the suggestions.)
> >
> > v3
> >    * Update to the newest version of Smrnmi extension specification.
> >
> > v2
> >    * split up the series into more commits for convenience of review.
> >    * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts=
.
> >
> > Frank Chang (1):
> >    target/riscv: Add Zicfilp support for Smrnmi
> >
> > Tommy Wu (5):
> >    target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
> >    target/riscv: Add Smrnmi CSRs
> >    target/riscv: Handle Smrnmi interrupt and exception
> >    target/riscv: Add Smrnmi mnret instruction
> >    target/riscv: Add Smrnmi cpu extension
> >
> >   hw/riscv/riscv_hart.c                         | 40 ++++++++
> >   include/hw/riscv/riscv_hart.h                 |  4 +
> >   target/riscv/cpu.c                            | 18 ++++
> >   target/riscv/cpu.h                            | 10 ++
> >   target/riscv/cpu_bits.h                       | 24 +++++
> >   target/riscv/cpu_cfg.h                        |  1 +
> >   target/riscv/cpu_helper.c                     | 96 +++++++++++++++++-=
-
> >   target/riscv/csr.c                            | 82 ++++++++++++++++
> >   target/riscv/helper.h                         |  1 +
> >   target/riscv/insn32.decode                    |  3 +
> >   .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
> >   target/riscv/op_helper.c                      | 54 ++++++++++-
> >   12 files changed, 342 insertions(+), 11 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>
>

--0000000000003f06140629714786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16,=
 2024 at 9:46=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"mailto:dbar=
boza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi Frank,<br>
<br>
Sorry for the delay.<br>
<br>
It seems like this series is breaking the &quot;make check-functional&quot;=
 test:<br>
<br>
$ make check-functional<br>
(...)<br>
=C2=A0 9/10 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv3=
2-riscv32_tuxrun TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090.03s=C2=A0 =C2=
=A0killed by signal 15 SIGTERM<br>
10/10 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-risc=
v64_tuxrun TIMEOUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 120.08s=C2=A0 =C2=A0killed by=
 signal 15 SIGTERM<br>
<br>
Ok:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
Expected Fail:=C2=A0 =C2=A0 =C2=A0 0<br>
Fail:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
Unexpected Pass:=C2=A0 =C2=A0 0<br>
Skipped:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
Timeout:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
<br>
The reason for the timeouts is that the tests are trying to boot Linux with=
<br>
&#39;rv64&#39; and &#39;max&#39; CPUs, and the timeout occurs when trying t=
o boot using<br>
the &#39;max&#39; CPU, i.e. it is using a CPU with ext_smrnmi enabled.<br>
<br>
=C2=A0From the cover letter it seems like we need a special OpenSBI to use =
the<br>
extension, but apparently not having a customizable OpenSBI will make the<b=
r>
extension misbehave.<br>
<br>
My suggestion here is, in patch 5, remove ext_smrnmi from the &#39;max&#39;=
 CPU.<br>
We can re-enable it when our OpenSBI image has the proper support for it.<b=
r>
Like this:<br>
<br>
$ git diff<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index 3480767b35..f3fb1c432b 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -1429,6 +1429,12 @@ static void riscv_init_max_cpu_extensions(Object *ob=
j)<br>
=C2=A0 =C2=A0 =C2=A0 if (env-&gt;misa_mxl !=3D MXL_RV32) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isa_ext_update_enabled(cpu, CPU_CFG_OFFS=
ET(ext_zcf), false);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* ext_smrnmi requires OpenSBI changes that our current=
<br>
+=C2=A0 =C2=A0 =C2=A0* image does not have. Disable it for now.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), fals=
e);<br>
=C2=A0 }<br>
<br>
This will make &#39;make check-functional&#39; work again. Thanks,<br>
<br>
<br>
Daniel<br>
<br>
<br></blockquote><div><br></div><div>Thanks, Daniel</div><div><br></div><di=
v>I will update it in the v10 patchset.</div><div><br></div><div>Regards,</=
div><div>Frank Chang</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
On 11/22/24 12:22 AM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_=
blank">frank.chang@sifive.com</a> wrote:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; <br>
&gt; This patchset added support for Smrnmi Extension in RISC-V.<br>
&gt; <br>
&gt; There are four new CSRs and one new instruction added to allow NMI to =
be<br>
&gt; resumable in RISC-V, which are:<br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 * mnscratch (0x740)<br>
&gt;=C2=A0 =C2=A0 * mnepc=C2=A0 =C2=A0 =C2=A0(0x741)<br>
&gt;=C2=A0 =C2=A0 * mncause=C2=A0 =C2=A0(0x742)<br>
&gt;=C2=A0 =C2=A0 * mnstatus=C2=A0 (0x744)<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 * mnret: To return from RNMI interrupt/exception handler.=
<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; RNMI also has higher priority than any other interrupts or exceptions<=
br>
&gt; and cannot be disabled by software.<br>
&gt; <br>
&gt; RNMI may be used to route to other devices such as Bus Error Unit or<b=
r>
&gt; Watchdog Timer in the future.<br>
&gt; <br>
&gt; The interrupt/exception trap handler addresses of RNMI are<br>
&gt; implementation defined.<br>
&gt; <br>
&gt; If anyone wants to test the patches, we can use the customized OpenSBI=
[1],<br>
&gt; and the customized QEMU[2].<br>
&gt; <br>
&gt; We implemented a PoC RNMI trap handler in the customized OpenSBI.<br>
&gt; In the customized QEMU, we use the Smrnmi patches and the patch from<b=
r>
&gt; Damien Hedde[3]. The patch from Damien Hedde can be used to inject<br>
&gt; the RNMI signal with the qmp command.<br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/t=
wu/master" rel=3D"noreferrer" target=3D"_blank">https://github.com/TommyWu-=
fdgkhdkgh/opensbi/tree/dev/twu/master</a><br>
&gt; [2] <a href=3D"https://github.com/sifive/qemu/tree/upstream-smrnmi-v8"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/sifive/qemu/tree/u=
pstream-smrnmi-v8</a><br>
&gt; [3] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-06/m=
sg06232.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-06/msg06232.html</a><br>
&gt; <br>
&gt; Test commands :<br>
&gt; $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,<br>
&gt; rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized<=
br>
&gt; OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic<br>
&gt; -bios fw_jump.elf -kernel Image -initrd rootfs.cpio<br>
&gt; -qmp unix:/tmp/qmp-sock,server,wait=3Doff<br>
&gt; <br>
&gt; Use qmp command to inject the RNMI.<br>
&gt; <br>
&gt; Assert RNMI:<br>
&gt; $ ./scripts/qmp/qmp-shell /tmp/qmp-sock<br>
&gt; (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi nu=
mber=3D0 value=3Dtrue<br>
&gt; <br>
&gt; De-assert RNMI:<br>
&gt; (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi nu=
mber=3D0 value=3Dfalse<br>
&gt; <br>
&gt; Changelog:<br>
&gt; <br>
&gt; v9<br>
&gt;=C2=A0 =C2=A0 * Add Zicfilp support for Smrnmi.<br>
&gt;=C2=A0 =C2=A0 * Change the existence checks for &#39;rnmi-interrupt-vec=
tor&#39; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;rnmi-exception-vector&#39; to use &#39;num_rn=
mi_irqvec&#39; and &#39;num_rnmi_excpvec&#39;.<br>
&gt;=C2=A0 =C2=A0 * Add warn_once messages for cases where the user sets<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;rnmi-interrupt-vector&#39; or &#39;rnmi-excep=
tion-vector&#39; property without<br>
&gt;=C2=A0 =C2=A0 =C2=A0 enabling Smrnmi.<br>
&gt; <br>
&gt; v8<br>
&gt;=C2=A0 =C2=A0 * Set virt to false when trapping to M-mode by RNMI.<br>
&gt;=C2=A0 =C2=A0 (Thanks to Cl=C3=A9ment for the suggestions.)<br>
&gt; <br>
&gt; v7<br>
&gt;=C2=A0 =C2=A0 * Rename &#39;nmi_execp&#39; to &#39;nnmi_excep&#39; and =
refactor RNMI exception<br>
&gt;=C2=A0 =C2=A0 =C2=A0 checking codes.<br>
&gt;=C2=A0 =C2=A0 (Thanks to Cl=C3=A9ment for the suggestions.)<br>
&gt;=C2=A0 =C2=A0 * Add the missing REQUIRE_SMRNMI() check and remove the r=
edundant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 check in &#39;helper_mnret&#39;.<br>
&gt;=C2=A0 =C2=A0 * Rebase to riscv-to-apply.next.<br>
&gt;=C2=A0 =C2=A0 (Thanks to Alistair for the suggestions.)<br>
&gt; <br>
&gt; v6<br>
&gt;=C2=A0 =C2=A0 * Delete the redundant code in &#39;riscv_cpu_do_interrup=
t&#39;.<br>
&gt;=C2=A0 =C2=A0 (Thank Alvin for the suggestion.)<br>
&gt;=C2=A0 =C2=A0 * Split the shared code in &#39;helper_mret&#39; and &#39=
;helper_mnret&#39; into a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 helper function &#39;check_ret_from_m_mode&#39;.<b=
r>
&gt;=C2=A0 =C2=A0 (Thank Alistair for the suggestion.)<br>
&gt; <br>
&gt; v5<br>
&gt;=C2=A0 =C2=A0 * Move the patch that adds the Smrnmi extension to the la=
st patch.<br>
&gt;=C2=A0 =C2=A0 (Thank Alistair for the suggestion.)<br>
&gt;=C2=A0 =C2=A0 * Implement an M-mode software PoC for this with implemen=
ted handlers.<br>
&gt;=C2=A0 =C2=A0 (Thank Andrew Jones for the suggestion.)<br>
&gt;=C2=A0 =C2=A0 * Add a commit message to all patches of the series.<br>
&gt;=C2=A0 =C2=A0 (Thank Andrew Jones for the suggestion.)<br>
&gt; <br>
&gt; v4<br>
&gt;=C2=A0 =C2=A0 * Fix some coding style issues.<br>
&gt;=C2=A0 =C2=A0 (Thank Daniel for the suggestions.)<br>
&gt; <br>
&gt; v3<br>
&gt;=C2=A0 =C2=A0 * Update to the newest version of Smrnmi extension specif=
ication.<br>
&gt; <br>
&gt; v2<br>
&gt;=C2=A0 =C2=A0 * split up the series into more commits for convenience o=
f review.<br>
&gt;=C2=A0 =C2=A0 * add missing rnmi_irqvec and rnmi_excpvec properties to =
riscv_harts.<br>
&gt; <br>
&gt; Frank Chang (1):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Zicfilp support for Smrnmi<br>
&gt; <br>
&gt; Tommy Wu (5):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add &#39;ext_smrnmi&#39; in the RISCVCPUCon=
fig<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi CSRs<br>
&gt;=C2=A0 =C2=A0 target/riscv: Handle Smrnmi interrupt and exception<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi mnret instruction<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi cpu extension<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv_hart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 ++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/riscv/riscv_hart.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 18 ++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 +++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 96 +++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 82 ++++++++++=
++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0.../riscv/insn_trans/trans_privileged.c.inc=C2=A0 =C2=A0| =
20 ++++<br>
&gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 54 ++++++++++-<br>
&gt;=C2=A0 =C2=A012 files changed, 342 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; --<br>
&gt; 2.34.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000003f06140629714786--

