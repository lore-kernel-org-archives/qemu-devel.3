Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFD606A881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=cHGCBbI3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFkb-0006eg-NS; Tue, 17 Nov 2026 04:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFkZ-0006Y4-CA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:45:15 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFkW-0007ev-B6
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:45:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so7328512a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794908710; x=1795513510; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NEigU4jij5r91/pxWG3XKGaw/mSVdbAML+VHi2kgWDc=;
 b=cHGCBbI3nH2EMR1+vFAy6rQFLJiKqfDEfhV4MHTk2t9imUsTtxzxYlnRGFXLti100g
 pqh/9oOpBM92192bsm2CVX2wi/5HnGGtpWXghPdjXa1NjBLpgoIyM4oG2To+o8X/GqCK
 LgQM49zBNNts4Oy1mlSwMbUS82mmvdeeC8KfCnbTqDAeSz/JR0yGmj6zhOGaD/Fk3c/p
 pN6GukpSZuIWVHKog+IKAXOqObhU8BiaVBGMGo6ZzkPpYgET2g8Mzf5K/vCT2e2OkbNn
 xPY/9LRm8Nr0ibqVTRXoPcxeu3ev6J24Jp3qRPxs04qEQOG1SYF/DUxvoJ94D6a7JkTM
 0ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908710; x=1795513510;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NEigU4jij5r91/pxWG3XKGaw/mSVdbAML+VHi2kgWDc=;
 b=zBlKnyeiLMbf1qj3f+gyBxdadSPIzkRL6tb/Ema/6AMjObr6au4wiCseHZmb4cb8xq
 /FUPTNOhFMqIEtxPCaYDT+6nHNcMv66ilpHwWqo8FDnMVdNidBXyPquNZVxSsYq136FT
 RhpHFvckV1RZu29vJ1mcEpEYNMBLPqEB/MPRLaLr4EI7rLuzo5WLJg3558SX6RsAP2CB
 53DgSjhFg+HZUtybxk9ChbYLTkF4MsfI9xDrPxODWJB88ncwX4/yea4tHHi44a/PNEKv
 1rSi62tUFMKhIe82QqAPRO59aanYDwf+u0WejEDIYPq3CMs9eOFbWXmctN2Pmb9psnAy
 B8ig==
X-Gm-Message-State: APuU4Z9jGELchqyVe7SgKCJMyOD+QUGX2oJZgvlKVU/AvwGBbDcFQh3X
 cvXj6kzuaZ6UuJxh8O510M3KQGu8Z3xU9yR7Jnlgi8eaksiwzIYVOzfiy2gOcVjktunHHTEOWuq
 WFpdPvyl33+fN5/O2d4meFMFQDXU8xyksAvgOB/r+KOll/RLwGLXDJl6OGPE4coJsaDuxKhwB3V
 mpqzzAkxMdNJERwfQ4RxSQHYnHD2vX+X2J4ZkDSVtv3vQ=
X-Gm-Gg: AYBFou1ljj9M4FhyedJyBAXfH7JBu4OkIoxZouyLzyVIHAkuO/CILtC5fQNLZJh4cCA
 0NtRT9c/zO5mwu0xfOqB5ss1fvemPJP+moF6zC+49n70ZPf4j8TKxQueDZ6b2HIdtq8omL4PR/q
 SDaDVy4JAAt78J9E4VvG8EQBIu6ng+4s7CY4TBrBO5fuYxqGn84DOqdzGpzY0NCC1GkgP71V+ay
 XwjhQrPc3HcTT+EsAfEUEhMznAY+lr3PXkZFBDIdqJjYMaU8QcfPZrUsaS+bFcxD/x67b8kKu0P
 YdGn1148piJaGnjLj1y8bi+5xOsfQUsb9rJzDTIzRwT5x323FR4RdI4KVBe5nqQZezIwyntTBWz
 Xi+jObcuJ2/2FgE798wZlwiv4URGLlcWEu57iwkIur3IWx3yYO82jiYkG3x9PMbTnW4lciMaN/I
 QUgP5mVMrOXZmoe8DSF99OxXyxrzSuHxxPDfZbDXFdlRKBgdjydOZX04geY2PApq2PTl2xrjDAe
 QqU6EBYxGMhRUPIM9n8xVxxNcG3l7VNdKH0BY3kiB0zhRwEnd5/s4NfR9Rvwva7KVEiYU0csM4W
 KRJOXXmxgEnncAk5hYKATr85D+rytbgQMlN7kZXpcxKmdLYvZQwQfTQd3FnlgU0vjDE=
X-Received: by 2002:aa7:d6c7:0:b0:6af:9a96:5324 with SMTP id
 4fb4d7f45d1cf-6b7c0c16f4amr7636055a12.33.1794908709678; 
 Tue, 17 Nov 2026 01:45:09 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com.
 [209.85.218.41]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b869e96b3esm521998a12.1.2026.11.17.01.45.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:45:07 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso776898066b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:45:07 -0800 (PST)
X-Received: by 2002:a17:906:6d02:b0:c51:5f6:cf70 with SMTP id
 a640c23a62f3a-c5105f6d8d6mr19018066b.1.1794908707286; Tue, 17 Nov 2026
 01:45:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-10-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-10-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:44:54 +0800
X-Gmail-Original-Message-ID: <CAMXXpfb=YccAe4QZFjqs_N-xLTQZam+sy+FQWq_UOVR+_Etp_A@mail.gmail.com>
X-Gm-Features: AclHuK-8EnK5n4Y2fqFsqp-PAyKrYGp4oG-iyJCcB_p578YG7nVdR4nHKW5Fskw
Message-ID: <CAMXXpfb=YccAe4QZFjqs_N-xLTQZam+sy+FQWq_UOVR+_Etp_A@mail.gmail.com>
Subject: Re: [PATCH 10/13] test/qtest/riscv-trace-test: add test-ntrace-simple
 qtest
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e6f3ce066075bf4d"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e6f3ce066075bf4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Add a simple smoke test for the ntrace encoder/trace ram sink integration
> with the RISC-V 'virt' machine.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  tests/qtest/riscv-trace-test.c | 59
> +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/riscv-trace-test.c
> b/tests/qtest/riscv-trace-test.c
> index fe1cc85358..66069f7a56 100644
> --- a/tests/qtest/riscv-trace-test.c
> +++ b/tests/qtest/riscv-trace-test.c
> @@ -21,6 +21,7 @@ REG32(TR_TE_CONTROL, 0x0)
>      FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
>      FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
>      FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
> +    FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
>
>  REG32(TR_RAM_START_LOW, 0x010)
>      FIELD(TR_RAM_START_LOW, ADDR, 0, 32)
> @@ -99,7 +100,61 @@ static void test_trace_simple(void)
>      g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
>
>      g_test_timer_start();
> -    for (;;) {
> +    while (true) {
> +        reg_tram_writep =3D test_read_tram_writep(qts);
> +        if (reg_tram_writep > reg_tram_start) {
> +            break;
> +        }
> +
> +        g_assert(g_test_timer_elapsed() <=3D timeout_sec);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_ntrace_simple(void)
> +{
> +    QTestState *qts =3D qtest_init("-machine virt -accel tcg -d in_asm")=
;
> +    double timeout_sec =3D 0.5;
> +    uint64_t reg_tram_start, reg_tram_writep;
> +    uint32_t reg;
> +
> +    /* trTeActive :=3D 1 */
> +    reg =3D test_read_te_control(qts);
> +    reg =3D FIELD_DP32(reg, TR_TE_CONTROL, ACTIVE, 1);
> +    test_write_te_control(qts, reg);
> +    reg =3D test_read_te_control(qts);
> +    g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, ACTIVE));
> +
> +    /* trTeEnable :=3D 1 */
> +    reg =3D FIELD_DP32(reg, TR_TE_CONTROL, ENABLE, 1);
> +    test_write_te_control(qts, reg);
> +    reg =3D test_read_te_control(qts);
> +    g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, ENABLE));
> +
> +    /* trTeFormat :=3D 1 (ntrace) */
> +    reg =3D FIELD_DP32(reg, TR_TE_CONTROL, FORMAT, 1);
> +    test_write_te_control(qts, reg);
> +    reg =3D test_read_te_control(qts);
> +    g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, FORMAT));
> +
> +    /*
> +     * Verify if RAM Sink write pointer is equal to
> +     * ramstart before start tracing.
> +     */
> +    reg_tram_start =3D test_read_tram_ramstart(qts);
> +    g_assert(reg_tram_start > 0);
> +    reg_tram_writep =3D test_read_tram_writep(qts);
> +    g_assert(reg_tram_writep =3D=3D reg_tram_start);
> +
> +    /* trTeInstTracing :=3D 1 */
> +    reg =3D FIELD_DP32(reg, TR_TE_CONTROL, INST_TRACING, 1);
> +    test_write_te_control(qts, reg);
> +    reg =3D test_read_te_control(qts);
> +    g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
> +
> +    g_test_timer_start();
> +    while (true) {
>          reg_tram_writep =3D test_read_tram_writep(qts);
>          if (reg_tram_writep > reg_tram_start) {
>              break;
> @@ -116,5 +171,7 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/riscv-trace-test/test-trace-simple",
>                     test_trace_simple);
> +    qtest_add_func("/riscv-trace-test/test-ntrace-simple",
> +                   test_ntrace_simple);
>      return g_test_run();
>  }
>
> --
> 2.43.0
>
>
>

--000000000000e6f3ce066075bf4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
dd a simple smoke test for the ntrace encoder/trace ram sink integration<br=
>
with the RISC-V &#39;virt&#39; machine.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/qtest/riscv-trace-test.c | 59 +++++++++++++++++++++++++++++++++=
++++++++-<br>
=C2=A01 file changed, 58 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/qtest/riscv-trace-test.c b/tests/qtest/riscv-trace-test.=
c<br>
index fe1cc85358..66069f7a56 100644<br>
--- a/tests/qtest/riscv-trace-test.c<br>
+++ b/tests/qtest/riscv-trace-test.c<br>
@@ -21,6 +21,7 @@ REG32(TR_TE_CONTROL, 0x0)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, ENABLE, 1, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)<br>
+=C2=A0 =C2=A0 FIELD(TR_TE_CONTROL, FORMAT, 24, 3)<br>
<br>
=C2=A0REG32(TR_RAM_START_LOW, 0x010)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_RAM_START_LOW, ADDR, 0, 32)<br>
@@ -99,7 +100,61 @@ static void test_trace_simple(void)<br>
=C2=A0 =C2=A0 =C2=A0g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, INST_T=
RACING));<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_test_timer_start();<br>
-=C2=A0 =C2=A0 for (;;) {<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_tram_writep =3D test_read_tram_writep(qts)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg_tram_writep &gt; reg_tram_start) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(g_test_timer_elapsed() &lt;=3D timeou=
t_sec);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qtest_quit(qts);<br>
+}<br>
+<br>
+static void test_ntrace_simple(void)<br>
+{<br>
+=C2=A0 =C2=A0 QTestState *qts =3D qtest_init(&quot;-machine virt -accel tc=
g -d in_asm&quot;);<br>
+=C2=A0 =C2=A0 double timeout_sec =3D 0.5;<br>
+=C2=A0 =C2=A0 uint64_t reg_tram_start, reg_tram_writep;<br>
+=C2=A0 =C2=A0 uint32_t reg;<br>
+<br>
+=C2=A0 =C2=A0 /* trTeActive :=3D 1 */<br>
+=C2=A0 =C2=A0 reg =3D test_read_te_control(qts);<br>
+=C2=A0 =C2=A0 reg =3D FIELD_DP32(reg, TR_TE_CONTROL, ACTIVE, 1);<br>
+=C2=A0 =C2=A0 test_write_te_control(qts, reg);<br>
+=C2=A0 =C2=A0 reg =3D test_read_te_control(qts);<br>
+=C2=A0 =C2=A0 g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, ACTIVE));<b=
r>
+<br>
+=C2=A0 =C2=A0 /* trTeEnable :=3D 1 */<br>
+=C2=A0 =C2=A0 reg =3D FIELD_DP32(reg, TR_TE_CONTROL, ENABLE, 1);<br>
+=C2=A0 =C2=A0 test_write_te_control(qts, reg);<br>
+=C2=A0 =C2=A0 reg =3D test_read_te_control(qts);<br>
+=C2=A0 =C2=A0 g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, ENABLE));<b=
r>
+<br>
+=C2=A0 =C2=A0 /* trTeFormat :=3D 1 (ntrace) */<br>
+=C2=A0 =C2=A0 reg =3D FIELD_DP32(reg, TR_TE_CONTROL, FORMAT, 1);<br>
+=C2=A0 =C2=A0 test_write_te_control(qts, reg);<br>
+=C2=A0 =C2=A0 reg =3D test_read_te_control(qts);<br>
+=C2=A0 =C2=A0 g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, FORMAT));<b=
r>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Verify if RAM Sink write pointer is equal to<br>
+=C2=A0 =C2=A0 =C2=A0* ramstart before start tracing.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 reg_tram_start =3D test_read_tram_ramstart(qts);<br>
+=C2=A0 =C2=A0 g_assert(reg_tram_start &gt; 0);<br>
+=C2=A0 =C2=A0 reg_tram_writep =3D test_read_tram_writep(qts);<br>
+=C2=A0 =C2=A0 g_assert(reg_tram_writep =3D=3D reg_tram_start);<br>
+<br>
+=C2=A0 =C2=A0 /* trTeInstTracing :=3D 1 */<br>
+=C2=A0 =C2=A0 reg =3D FIELD_DP32(reg, TR_TE_CONTROL, INST_TRACING, 1);<br>
+=C2=A0 =C2=A0 test_write_te_control(qts, reg);<br>
+=C2=A0 =C2=A0 reg =3D test_read_te_control(qts);<br>
+=C2=A0 =C2=A0 g_assert(1 =3D=3D FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACIN=
G));<br>
+<br>
+=C2=A0 =C2=A0 g_test_timer_start();<br>
+=C2=A0 =C2=A0 while (true) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_tram_writep =3D test_read_tram_writep=
(qts);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reg_tram_writep &gt; reg_tram_start) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -116,5 +171,7 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;/riscv-trace-test/test-trace-simpl=
e&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_=
trace_simple);<br>
+=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-trace-test/test-ntrace-simple&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_=
ntrace_simple);<br>
=C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
=C2=A0}<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000e6f3ce066075bf4d--

