Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B1C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2sP-00089q-KU; Fri, 31 May 2024 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sD2sN-000891-RV; Fri, 31 May 2024 10:04:59 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sD2sM-0001zq-2w; Fri, 31 May 2024 10:04:59 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a3bbc0209so806982a12.3; 
 Fri, 31 May 2024 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717164296; x=1717769096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx3MMKy7kCmDPaUS3Gyku7yDneFjGPHG6Jk5q4bpV+c=;
 b=FchIuDg3DNYBiTYXz35U3OciUxwCtQDQT8PkzkTVbRSxeFZ94y7QkkzH1aIc+zTkX+
 w4AmooXKqD1sfzqOgcNh8hyTL/9AAFo+zq6O3Epbgv6GxZYpPoPR1C1AvK3qR2RtExYy
 IvWEKPIVN6O/QjYKMNmOUmFVGCR8/CfwkiGQbNjZ1N4RynW7OcVJW/WzSZW5CAWccn9E
 It4yJvzkvjdFj2/Rt2hse/JvWO1u0YoIjWRFKqRdfK8kIRyvtHmWK1MBfH7LkafHN/0C
 xZddiQDjiyQwGbHkFDiJ/i3Gw1DT+j38MotMun/oXqHqaykvR7fiDlThSVVATYTsM37L
 smtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717164296; x=1717769096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yx3MMKy7kCmDPaUS3Gyku7yDneFjGPHG6Jk5q4bpV+c=;
 b=ekGpWWO261Q1tE03o84Pa4y3vDRa+l9vMYVhTY66brIfFi+via7puBTACERt7ZpT7z
 o/swW+84/wWsyHHS36lmNnkwJcHeYFmAGLJG1tM2GgvtL5MQ/LF70ZFxQp4vJLm1+YyV
 23YvtEXkTQ3wE7cQsStn+FOVKoXC653y9ghJtaAwB0nqXIqRThBNf0DxmMMBH3an6NOM
 LLWzNoYp5yuZrA4+aEyJSE3lnJkWO0ueU3ID4YmcKIURBh0cdT3VlK942d0hVoxrlE9p
 jCHcoox3iGWt1uzHseWwrtLMPUSXWKPQlTNC7AmMHgz4KkoJTNQ83BI/cs7ShqqQv5Gs
 7soA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlkOOooZWqb/s83/w/aw+hRiB8EOZn6Jb3f5eMD7D021yIXuzIShOOVmwCwMRkgnBJMSfYzZZgaulcJhLwl1k5zLhbV90=
X-Gm-Message-State: AOJu0Yx93bhJPwbfv9iY/ZljCTi/KOo3SRNbkl5KuZp8SQ8y1Ek9eeVo
 PZDpp3O2TRO9FvHOpaBzSnfqpDxjRgbT5t6JZwLQxnD6B8tcWrLalvu3A3FrBlHE3w2bg0ATaDo
 YbwPfrGuhq0JhmMGDx5ekQAPUBXZM9Tb0fhE=
X-Google-Smtp-Source: AGHT+IGdAVczeRpi2EVjbaRcNPRKu4NPpRjWkZlmWg5Nf+pbZ88P16eGcuWoTHv4n1q3L6XIRV6sE3D/sfNXYdSHthI=
X-Received: by 2002:a50:c302:0:b0:578:6865:3227 with SMTP id
 4fb4d7f45d1cf-57a36450bb7mr1463021a12.30.1717164295557; Fri, 31 May 2024
 07:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240531124628.476938-1-peter.maydell@linaro.org>
In-Reply-To: <20240531124628.476938-1-peter.maydell@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 31 May 2024 16:04:43 +0200
Message-ID: <CAJy5ezpwQ4e5KkYLPT8_2zAH=B-MykETWQYKAgapCqrVJLXBzA@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/xlnx_dpdma: Read descriptor into buffer,
 not into pointer-to-buffer
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Alexandra Diupina <adiupina@astralinux.ru>, 
 "Konrad, Frederic" <frederic.konrad@amd.com>
Content-Type: multipart/alternative; boundary="000000000000db98dc0619c0775d"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x532.google.com
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

--000000000000db98dc0619c0775d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:46=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> In fdf029762f501 we factored out the handling of reading and writing
> DMA descriptors from guest memory.  Unfortunately we accidentally
> made the descriptor-read read the descriptor into the address of the
> buffer rather than into the buffer, because we didn't notice we
> needed to update the arguments to the dma_memory_read() call. Before
> the refactoring, "&desc" is the address of a local struct DPDMADescriptor
> variable in xlnx_dpdma_start_operation(), which is the correct target
> for the guest-memory-read. But after the refactoring 'desc' is the
> "DPDMADescriptor *desc" argument to the new function, and so it is
> already an address.
>
> This bug is an overrun of a stack variable, since a pointer is at
> most 8 bytes long and we try to read 64 bytes, as well as being
> incorrect behaviour.
>
> Pass 'desc' rather than '&desc' as the dma_memory_read() argument
> to fix this.
>
> (The same bug is not present in xlnx_dpdma_write_descriptor(),
> because there we are writing the descriptor from a local struct
> variable "DPDMADescriptor tmp_desc" and so passing &tmp_desc to
> dma_memory_write() is correct.)
>
> Spotted by Coverity: CID 1546649
>
>
+ CC Fred.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> Fixes: fdf029762f50101 ("xlnx_dpdma: fix descriptor endianness bug")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/dma/xlnx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index dde4aeca401..a685bd28bb8 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -619,7 +619,7 @@ static MemTxResult
> xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
>                                                DPDMADescriptor *desc)
>  {
>      MemTxResult res =3D dma_memory_read(&address_space_memory, desc_addr=
,
> -                                      &desc, sizeof(DPDMADescriptor),
> +                                      desc, sizeof(DPDMADescriptor),
>                                        MEMTXATTRS_UNSPECIFIED);
>      if (res) {
>          return res;
> --
> 2.34.1
>
>

--000000000000db98dc0619c0775d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, May 31, 2024 at 2:46=E2=80=AFPM P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">In fdf029762f501 we factored out the h=
andling of reading and writing<br>
DMA descriptors from guest memory.=C2=A0 Unfortunately we accidentally<br>
made the descriptor-read read the descriptor into the address of the<br>
buffer rather than into the buffer, because we didn&#39;t notice we<br>
needed to update the arguments to the dma_memory_read() call. Before<br>
the refactoring, &quot;&amp;desc&quot; is the address of a local struct DPD=
MADescriptor<br>
variable in xlnx_dpdma_start_operation(), which is the correct target<br>
for the guest-memory-read. But after the refactoring &#39;desc&#39; is the<=
br>
&quot;DPDMADescriptor *desc&quot; argument to the new function, and so it i=
s<br>
already an address.<br>
<br>
This bug is an overrun of a stack variable, since a pointer is at<br>
most 8 bytes long and we try to read 64 bytes, as well as being<br>
incorrect behaviour.<br>
<br>
Pass &#39;desc&#39; rather than &#39;&amp;desc&#39; as the dma_memory_read(=
) argument<br>
to fix this.<br>
<br>
(The same bug is not present in xlnx_dpdma_write_descriptor(),<br>
because there we are writing the descriptor from a local struct<br>
variable &quot;DPDMADescriptor tmp_desc&quot; and so passing &amp;tmp_desc =
to<br>
dma_memory_write() is correct.)<br>
<br>
Spotted by Coverity: CID 1546649<br>
<br></blockquote><div><br></div><div>+ CC Fred.</div><div><br></div><div>Re=
viewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">=
edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Fixes: fdf029762f50101 (&quot;xlnx_dpdma: fix descriptor endianness bug&quo=
t;)<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/dma/xlnx_dpdma.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c<br>
index dde4aeca401..a685bd28bb8 100644<br>
--- a/hw/dma/xlnx_dpdma.c<br>
+++ b/hw/dma/xlnx_dpdma.c<br>
@@ -619,7 +619,7 @@ static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMA=
State *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0DPDMADescriptor *desc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MemTxResult res =3D dma_memory_read(&amp;address_space_=
memory, desc_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;desc, size=
of(DPDMADescriptor),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc, sizeof(DP=
DMADescriptor),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MEMTXATTR=
S_UNSPECIFIED);<br>
=C2=A0 =C2=A0 =C2=A0if (res) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000db98dc0619c0775d--

