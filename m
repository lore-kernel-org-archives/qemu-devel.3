Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494FCC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4pq-0002Il-Sz; Mon, 03 Jun 2024 06:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sE4po-0002Du-Kc; Mon, 03 Jun 2024 06:22:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sE4pk-00032s-AJ; Mon, 03 Jun 2024 06:22:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57a4ea806a5so861950a12.0; 
 Mon, 03 Jun 2024 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717410150; x=1718014950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PtcgY3J5cKwH4HSd/mfppi0gHYmxKWMbddeXG0SSyRg=;
 b=LaNLa21WunQ0IFl2uGA5jYDQz9fX0Mycrqo5HpTpuPUcrmqbbQquLSseJuRhcfh6MC
 /ibYHt6WlvsnWNH4pfHi88S2oISCF/nh1pvKG0j3wJynohdzlPYBLoEij3EFH8BgvKch
 pR5dDDYmgfJ4r1tvOSi/Qn2L6KodG5JCZ3DzfmpGotvGD8rvhr8AgvopvZhP7trNbS8d
 /ZfasRBMJecrcFNO7NjrYDle9cHtUh1WKNc82PbHVT0nQKkO8ILy3rJ3Zg4bXE5Gvwau
 ZKfj8t8QHRZ7ckR+/x8uPXSzAIkPX7wmdtDHUQZX5cHWD75E0FDqHJbIu28aa/6DpEd+
 ItRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717410150; x=1718014950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtcgY3J5cKwH4HSd/mfppi0gHYmxKWMbddeXG0SSyRg=;
 b=w6PhrOx84SEczvYF4CF8qzb2BOHPuML/YwWBH+oaKNt1udX4aG5HR+gI84rTBd7NUS
 hm+yljXee065JCy60oiaEXsH1fycndqcuzS45KVjX+8wzF3EGUqgRyPmmk8m2rx3Sbgw
 zrUnUxUSHzrE7ekXfz9mr6t0n10VdpimrIzFouW8KUcuR7Xfcljd8wEYglVFGInzjXya
 1jj45ptE/So6fd1gymBFall4/mTL0UpsipRmIzImLV07EsNmdhh5/u1diIry4BWiGxam
 ZAMigShd3HSKpSrAmvGB0GSJgqF48ptCdGX4Ao6VKk1QUCHrWA08js0knPZO8LAU/xzu
 cNuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn7HCJn8ptDwpoq30F6QjJb/4kzQXdqJ6MxMVxzXwbPZIrVorCLicDEutkgp69Ro9ODAFREHgAv5I+qcp6ecIBr60UCgGA4wFkA1blJSBtQhGaSgmoS8V+VRg=
X-Gm-Message-State: AOJu0YzywAdHTxyBIneyB9gS2/OT2qTtFRluwxSjSQBUbvszFLWGvHXB
 6Jz79VV6VIiHq2Boir8nt1D7MXEK82YW3vo7K+0e7gtq0sRr+6bkXrG8kKI0lRSGIjL1MgBEhfI
 57nf2DVBMbml/0bNkqloTwz1b6pKYYD6G+G480g==
X-Google-Smtp-Source: AGHT+IGhxBQv9TB7CoqXJ4LZGzG2cqL0NxwrIQ1AfStdMTzph4uzvxwKVEZs9DcX+2frTk7z1Jg+AoR9Fh2TDzMwQLc=
X-Received: by 2002:a50:9e61:0:b0:579:f196:487f with SMTP id
 4fb4d7f45d1cf-57a363ffbf2mr8057639a12.31.1717410149736; Mon, 03 Jun 2024
 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-4-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-4-fea.wang@sifive.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 3 Jun 2024 12:22:17 +0200
Message-ID: <CAJy5ezpSHoLfmRdB+GW29-NP4_0ASrHRS20jxgoVbBzrcyezCw@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/dma: Add a trace log for a description loading
 failure
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e8aa3b0619f9b524"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e8aa3b0619f9b524
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:48=E2=80=AFAM Fea.Wang <fea.wang@sifive.com> wrote=
:

> Due to a description loading failure, adding a trace log makes observing
> the DMA behavior easy.
>
>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  hw/dma/trace-events    | 3 +++
>  hw/dma/xilinx_axidma.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 3c47df54e4..95db083be4 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -44,3 +44,6 @@ pl330_debug_exec_stall(void) "stall of debug instructio=
n
> not implemented"
>  pl330_iomem_write(uint32_t offset, uint32_t value) "addr: 0x%08"PRIx32"
> data: 0x%08"PRIx32
>  pl330_iomem_write_clr(int i) "event interrupt lowered %d"
>  pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data=
:
> 0x%08"PRIx32
> +
> +# xilinx_axidma.c
> +xilinx_axidma_loading_desc_fail(uint32_t res) "error:%d"
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index b8ab5a423d..1bbb9d6c4c 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -36,6 +36,7 @@
>  #include "sysemu/dma.h"
>  #include "hw/stream.h"
>  #include "qom/object.h"
> +#include "trace.h"
>
>  #define D(x)
>
> @@ -200,6 +201,8 @@ static MemTxResult stream_desc_load(struct Stream *s,
> hwaddr addr)
>                                              addr, MEMTXATTRS_UNSPECIFIED=
,
>                                              d, sizeof *d);
>      if (result !=3D MEMTX_OK) {
> +        trace_xilinx_axidma_loading_desc_fail(result);
> +
>          s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
>          s->regs[R_DMASR] |=3D DMASR_HALTED;
>          s->regs[R_DMASR] |=3D DMASR_SLVERR;
> --
> 2.34.1
>
>

--000000000000e8aa3b0619f9b524
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 3, 2024 at 7:48=E2=80=AFAM Fe=
a.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com">fea.wang@sifive.com</a>&g=
t; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Due to a description loading failure, adding a trace l=
og makes observing<br>
the DMA behavior easy.<br>
<br></blockquote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a =
href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
---<br>
=C2=A0hw/dma/trace-events=C2=A0 =C2=A0 | 3 +++<br>
=C2=A0hw/dma/xilinx_axidma.c | 3 +++<br>
=C2=A02 files changed, 6 insertions(+)<br>
<br>
diff --git a/hw/dma/trace-events b/hw/dma/trace-events<br>
index 3c47df54e4..95db083be4 100644<br>
--- a/hw/dma/trace-events<br>
+++ b/hw/dma/trace-events<br>
@@ -44,3 +44,6 @@ pl330_debug_exec_stall(void) &quot;stall of debug instruc=
tion not implemented&quot;<br>
=C2=A0pl330_iomem_write(uint32_t offset, uint32_t value) &quot;addr: 0x%08&=
quot;PRIx32&quot; data: 0x%08&quot;PRIx32<br>
=C2=A0pl330_iomem_write_clr(int i) &quot;event interrupt lowered %d&quot;<b=
r>
=C2=A0pl330_iomem_read(uint32_t addr, uint32_t data) &quot;addr: 0x%08&quot=
;PRIx32&quot; data: 0x%08&quot;PRIx32<br>
+<br>
+# xilinx_axidma.c<br>
+xilinx_axidma_loading_desc_fail(uint32_t res) &quot;error:%d&quot;<br>
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c<br>
index b8ab5a423d..1bbb9d6c4c 100644<br>
--- a/hw/dma/xilinx_axidma.c<br>
+++ b/hw/dma/xilinx_axidma.c<br>
@@ -36,6 +36,7 @@<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
=C2=A0#include &quot;hw/stream.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
+#include &quot;trace.h&quot;<br>
<br>
=C2=A0#define D(x)<br>
<br>
@@ -200,6 +201,8 @@ static MemTxResult stream_desc_load(struct Stream *s, h=
waddr addr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0addr, MEMTXATTRS_UNSPECIFIED,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0d, sizeof *d);<br>
=C2=A0 =C2=A0 =C2=A0if (result !=3D MEMTX_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_xilinx_axidma_loading_desc_fail(result);=
<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMACR] &amp;=3D ~DMACR_RUNST=
OP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMASR] |=3D DMASR_HALTED;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMASR] |=3D DMASR_SLVERR;<br=
>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000e8aa3b0619f9b524--

