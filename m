Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D8C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENrR-00087W-5c; Tue, 04 Jun 2024 02:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENrL-00086P-A8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:41:27 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENrH-0006X8-RF
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:41:27 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4eb14c1a15aso858343e0c.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717483281; x=1718088081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zm2gmNUyLiYeot720PZVrFYl2KkhT9X1YFFONMEoscE=;
 b=ayjLK7LKa1k70BmfAAxATqmdQQBzhZeO+u1Y53YubpL1V63mj+4tVk3UYP3qfE7W1j
 5ArF3i7k0zEM4gBGz+8LcvmrdeoTUN+XL5X2oPKXqw7E3pSwuhyaHjr7hWtVH0zsvoUl
 34+gaO1B6RbyWNeHlZ2Y6KkpkuanNlXgxPgOb4eLGaeImBjVYFbH4JGtAtQcOT4HKY8q
 ty7G+j2uj416EmtfheJMv8Lp1mk627xDgVmYMdT9GNJoHlKDsRYg4GEcVHSEVMGvnKkc
 TYMZuN8T+ZgdExr0kadDKzc5S8NE9A/OckimY3doK7km9S0Ilc+BbOozleRP4weKI2yE
 7Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483281; x=1718088081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zm2gmNUyLiYeot720PZVrFYl2KkhT9X1YFFONMEoscE=;
 b=JqNnsP3GN8ixr+zTb90iEDVTlLtWnC2x9nfdn0j76KDntAWQuhnlsHM1J0K1KwRMQN
 hSMX1goVLeBIHn9gVO9G42F4YfPxg1SPENGYRi+50v+nqPNY/3/x9xubIgaSXpRUg9xk
 oGi+VDIW++QWPm4qiNhvxvKUS7CqO5q4CwN3q6hEVOywo/cNHK2lJAX8uVBOPMS1xzSS
 qi6JvQnKR9hOzAm/hNj8Ra1tPtCYLrws3vW6lNC0PXUjOyYJitVwzrsmco2Sms1b2Dmd
 ETyBHmAxG7hIv2TwC9TO3h3C6WppN20QVz2aYJPR/GbTCb9wrjJ2dJdNvguYdliQ9inY
 vZRA==
X-Gm-Message-State: AOJu0YyuffI798HWijc5SOZNSjVUEbOoW8fLe1XApA2ARn6UQPbLHrLt
 0rnPcXlI8GErECwcKorCU0nnDHZzPy++6JQK7hIT4LSEoQny6uDuRdwC5oPPs3734Vss6zUXI5T
 lXQ8/+bSsRLwaXhZYn7uek7vFvhSAMPUzIGdJVA==
X-Google-Smtp-Source: AGHT+IG45rJsRmI49kOjiXKUIYqrAnz2yUq+LkPMrhma6QwCgLxIkt+fFFcgzvwKsK7E0s+tYFTK5w+IrtGzbqthfrE=
X-Received: by 2002:a05:6122:910:b0:4eb:1b53:47a8 with SMTP id
 71dfb90a1353d-4eb1b5357bdmr4491058e0c.15.1717483281356; Mon, 03 Jun 2024
 23:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-2-fea.wang@sifive.com>
 <CAJy5ezr-_xnjXqtZnqaWSagMD8pGgU2bDUD0TsHxfkYvQYeHpw@mail.gmail.com>
In-Reply-To: <CAJy5ezr-_xnjXqtZnqaWSagMD8pGgU2bDUD0TsHxfkYvQYeHpw@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Tue, 4 Jun 2024 14:41:10 +0800
Message-ID: <CAKhCfscTZ7PVosWxoozYOpJUhVj=vYPChnEZzK0SYrd6KORi_g@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/dma: Enhance error handling in loading description
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e4b1c2061a0abc6e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=fea.wang@sifive.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000e4b1c2061a0abc6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edgar,
Thank you for recommending to me. I will make the change in the next
version of the patch series.

Sincerely,
Fea

On Mon, Jun 3, 2024 at 6:19=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@gm=
ail.com>
wrote:

> On Mon, Jun 3, 2024 at 7:47=E2=80=AFAM Fea.Wang <fea.wang@sifive.com> wro=
te:
>
>> Loading a description from memory may cause a bus-error. In this
>> case, the DMA should stop working, set the error flag, and return
>> the error value.
>>
>> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
>>
>
>
> Hi Fea,
>
> I've got a couple of small comments:
>
>
> ---
>>  hw/dma/xilinx_axidma.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
>> index 0ae056ed06..4b475e5484 100644
>> --- a/hw/dma/xilinx_axidma.c
>> +++ b/hw/dma/xilinx_axidma.c
>> @@ -71,8 +71,10 @@ enum {
>>  enum {
>>      DMASR_HALTED =3D 1,
>>      DMASR_IDLE  =3D 2,
>> +    DMASR_SLVERR =3D 1 << 5,
>>
>
> We should also add DMASR_DECERR =3D 1 << 6
>
>
>>      DMASR_IOC_IRQ  =3D 1 << 12,
>>      DMASR_DLY_IRQ  =3D 1 << 13,
>> +    DMASR_ERR_IRQ  =3D 1 << 14,
>>
>>      DMASR_IRQ_MASK =3D 7 << 12
>>  };
>> @@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)
>>      return sid;
>>  }
>>
>> -static void stream_desc_load(struct Stream *s, hwaddr addr)
>> +static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>>  {
>>      struct SDesc *d =3D &s->desc;
>>
>> -    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d,
>> sizeof *d);
>> +    MemTxResult result =3D address_space_read(&s->dma->as,
>> +                                            addr, MEMTXATTRS_UNSPECIFIE=
D,
>> +                                            d, sizeof *d);
>> +    if (result !=3D MEMTX_OK) {
>> +        s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
>> +        s->regs[R_DMASR] |=3D DMASR_HALTED;
>> +        s->regs[R_DMASR] |=3D DMASR_SLVERR;
>>
>
> ... and map MEMTX_DECODE_ERROR to DMASR_DECERR and everything else to
> SLVERR, for example:
> if (result =3D=3D MEMTX_DECODE_ERROR) {
>     s->regs[R_DMASR] |=3D DMASR_DECERR;
> } else {
>     s->regs[R_DMASR] |=3D DMASR_SLVERR;
> }
>
>
>> +        s->regs[R_DMASR] |=3D DMASR_ERR_IRQ;
>> +        return result;
>> +    }
>>
>>      /* Convert from LE into host endianness.  */
>>      d->buffer_address =3D le64_to_cpu(d->buffer_address);
>>      d->nxtdesc =3D le64_to_cpu(d->nxtdesc);
>>      d->control =3D le32_to_cpu(d->control);
>>      d->status =3D le32_to_cpu(d->status);
>> +    return result;
>>  }
>>
>>  static void stream_desc_store(struct Stream *s, hwaddr addr)
>> --
>> 2.34.1
>>
>>

--000000000000e4b1c2061a0abc6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Edgar,<div>Thank you for recommending to me. I wil=
l make the change in the next version of the patch series.</div><div><br></=
div><div>Sincerely,</div><div>Fea</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 3, 2024 at 6:19=E2=80=AF=
PM Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar.=
iglesias@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 3, 2024 at =
7:47=E2=80=AFAM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt; wrote:<br></div><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Loading a descrip=
tion from memory may cause a bus-error. In this<br>
case, the DMA should stop working, set the error flag, and return<br>
the error value.<br>
<br>
Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt;<br></blockquote><div><br></div><div=
><br></div><div>Hi Fea,</div><div><br></div><div>I&#39;ve got a couple of s=
mall comments:</div><div>=C2=A0</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0hw/dma/xilinx_axidma.c | 16 ++++++++++++++--<br>
=C2=A01 file changed, 14 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c<br>
index 0ae056ed06..4b475e5484 100644<br>
--- a/hw/dma/xilinx_axidma.c<br>
+++ b/hw/dma/xilinx_axidma.c<br>
@@ -71,8 +71,10 @@ enum {<br>
=C2=A0enum {<br>
=C2=A0 =C2=A0 =C2=A0DMASR_HALTED =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0DMASR_IDLE=C2=A0 =3D 2,<br>
+=C2=A0 =C2=A0 DMASR_SLVERR =3D 1 &lt;&lt; 5,<br></blockquote><div><br></di=
v><div>We should also add DMASR_DECERR =3D 1 &lt;&lt; 6</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0DMASR_IOC_IRQ=C2=A0 =3D 1 &lt;&lt; 12,<br>
=C2=A0 =C2=A0 =C2=A0DMASR_DLY_IRQ=C2=A0 =3D 1 &lt;&lt; 13,<br>
+=C2=A0 =C2=A0 DMASR_ERR_IRQ=C2=A0 =3D 1 &lt;&lt; 14,<br>
<br>
=C2=A0 =C2=A0 =C2=A0DMASR_IRQ_MASK =3D 7 &lt;&lt; 12<br>
=C2=A0};<br>
@@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)<br>
=C2=A0 =C2=A0 =C2=A0return sid;<br>
=C2=A0}<br>
<br>
-static void stream_desc_load(struct Stream *s, hwaddr addr)<br>
+static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct SDesc *d =3D &amp;s-&gt;desc;<br>
<br>
-=C2=A0 =C2=A0 address_space_read(&amp;s-&gt;dma-&gt;as, addr, MEMTXATTRS_U=
NSPECIFIED, d, sizeof *d);<br>
+=C2=A0 =C2=A0 MemTxResult result =3D address_space_read(&amp;s-&gt;dma-&gt=
;as,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 addr, MEMTXATTRS_UNSPECIFIED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 d, sizeof *d);<br>
+=C2=A0 =C2=A0 if (result !=3D MEMTX_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMACR] &amp;=3D ~DMACR_RUNSTOP;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_HALTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_SLVERR;<br></bl=
ockquote><div><br></div><div>... and map MEMTX_DECODE_ERROR to DMASR_DECERR=
 and everything else to SLVERR, for example:</div><div>if (result =3D=3D ME=
MTX_DECODE_ERROR) {</div><div>=C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_=
DECERR;</div><div>} else {<br><div>=C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D D=
MASR_SLVERR;</div></div><div>}</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_ERR_IRQ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Convert from LE into host endianness.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;buffer_address =3D le64_to_cpu(d-&gt;buffer_addre=
ss);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;nxtdesc =3D le64_to_cpu(d-&gt;nxtdesc);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;control =3D le32_to_cpu(d-&gt;control);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;status =3D le32_to_cpu(d-&gt;status);<br>
+=C2=A0 =C2=A0 return result;<br>
=C2=A0}<br>
<br>
=C2=A0static void stream_desc_store(struct Stream *s, hwaddr addr)<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000e4b1c2061a0abc6e--

