Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD66FC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEO1p-0003eH-NS; Tue, 04 Jun 2024 02:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEO1o-0003dU-Kh
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:52:16 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEO1m-0000kh-SH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:52:16 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80ac76f1226so3136399241.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717483934; x=1718088734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOC+SmDoNN1U0JhGwR655j1DQHHhWuybDBkRY9+XO30=;
 b=apTcDJpzFak7yzm+44gkag06lDgpW+mxT8XqSkwZctWlluK9qt3dsT98BksD0nqyPW
 9BRay0RLgwrmw2vSK0lpVpp/mhKeERnlK4lQk+asLn1MzVOIist/nmJo26ljda/yub7s
 SnomYrTsuTdhpllr6aJ5tR55r+79Bue/EKzBiBWnnP+g56S+tvlQCMvGWwndNsP+cyT2
 7/OFIvDisM2Z/GohDyM1ZJsEli1Z+egR7Foi9WUMBBc1dgFJnRlAB6YcjBBJAchqrIl/
 qfDgCmhRVWBvpkNKzvskkrLsi6VOUvn9cUynUm0z9kXEQX5VUc5mdCbM/7cD7WYC9Coe
 669w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483934; x=1718088734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOC+SmDoNN1U0JhGwR655j1DQHHhWuybDBkRY9+XO30=;
 b=uQRDjKq06h92z78k4tjIjiatKk0vU+Jcx5M0dUoKrldzX4pS8kiiY1NaEtJ9PgCggG
 eW/0usbzoWduu3DaqlChRExuxtXx9OcPlvD7Si1Vgx5BmulFYQRjV87JGHwAjDwnzV+y
 ehwt/7ndyDfO+xOcdLI5H8X8vs2mjHV5z+IMMH5fQZ0U+hG5dbAeaZqcnk7gLNbyfD0H
 ujusX6xpRDN1AIsar+p2CZf1xt510B1UBUiZ3kTQ4WbzVSkVXfJJyvHaGw6EgFwI0L2l
 4GvF8RH2j5Q9M/wY7Yt+8pRaZcu3n5Dss0W8L5XIXM+tiqoWttK/pNnyP0j5Y3aIuppS
 31bQ==
X-Gm-Message-State: AOJu0YzsxdQciTFbvfb3A8+X1OfeeW4U9bIzru2yUsSMRCL4unwTsk9W
 6OmVmIUfELFDwKPnjgzIyalKSjHqdNqF7PPFqMifhvbBrK01TPOmv2+LlpA0FbLB0C+IDE2zVZ4
 KVEIrR5b0b7P8gDdE8hvcD2D9XZ5qn6T+TzjqHHwFqWK0fcgv
X-Google-Smtp-Source: AGHT+IFpD9REoOSyGBCtFrKsRux05QLO7+XljyJHp2lp7l94jwIxicQ+CM4IkZIQUjOCTuqSsuRvw4lVhckeaW029zk=
X-Received: by 2002:a05:6122:d23:b0:4eb:177c:a815 with SMTP id
 71dfb90a1353d-4eb2bc02c7dmr1538446e0c.2.1717483933150; Mon, 03 Jun 2024
 23:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-3-fea.wang@sifive.com>
 <CAJy5ezp6pkpEqCHc+ggXi+-VR+u+3HKyn5inzasyqBR9FaGiog@mail.gmail.com>
In-Reply-To: <CAJy5ezp6pkpEqCHc+ggXi+-VR+u+3HKyn5inzasyqBR9FaGiog@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Tue, 4 Jun 2024 14:52:02 +0800
Message-ID: <CAKhCfsfnDK9A0hpV4cUQMfhg3VBS7_tzbZy783Q3xcePGZefJA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/dma: Break the loop when loading descriptions fails
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000be4b35061a0ae3f7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=fea.wang@sifive.com; helo=mail-ua1-x935.google.com
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

--000000000000be4b35061a0ae3f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edgar,
thank you for the advice, I will squash them in the next version of the
patch series.

Sincerely,
Fea

On Mon, Jun 3, 2024 at 6:21=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@gm=
ail.com>
wrote:

> On Mon, Jun 3, 2024 at 7:48=E2=80=AFAM Fea.Wang <fea.wang@sifive.com> wro=
te:
>
>> When calling the loading a description function, it should be noticed
>> that the function may return a failure value. Breaking the loop is one
>> of the possible ways to handle it.
>>
>> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
>>
>
>
> Looks good, a nitpick comment, I would either squash this with patch #1
> or move the change to return of error code in stream_desc_load() to this
> patch.
>
>
>
>
>> ---
>>  hw/dma/xilinx_axidma.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
>> index 4b475e5484..b8ab5a423d 100644
>> --- a/hw/dma/xilinx_axidma.c
>> +++ b/hw/dma/xilinx_axidma.c
>> @@ -291,7 +291,9 @@ static void stream_process_mem2s(struct Stream *s,
>> StreamSink *tx_data_dev,
>>      }
>>
>>      while (1) {
>> -        stream_desc_load(s, s->regs[R_CURDESC]);
>> +        if (MEMTX_OK !=3D stream_desc_load(s, s->regs[R_CURDESC])) {
>> +            break;
>> +        }
>>
>>          if (s->desc.status & SDESC_STATUS_COMPLETE) {
>>              s->regs[R_DMASR] |=3D DMASR_HALTED;
>> @@ -348,7 +350,9 @@ static size_t stream_process_s2mem(struct Stream *s,
>> unsigned char *buf,
>>      }
>>
>>      while (len) {
>> -        stream_desc_load(s, s->regs[R_CURDESC]);
>> +        if (MEMTX_OK !=3D stream_desc_load(s, s->regs[R_CURDESC])) {
>> +            break;
>> +        }
>>
>>          if (s->desc.status & SDESC_STATUS_COMPLETE) {
>>              s->regs[R_DMASR] |=3D DMASR_HALTED;
>> --
>> 2.34.1
>>
>>

--000000000000be4b35061a0ae3f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Edgar,<div>thank you for the advice, I will squash them=
 in the next version of the patch series.</div><div><br></div><div>Sincerel=
y,</div><div>Fea</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Jun 3, 2024 at 6:21=E2=80=AFPM Edgar E. Igles=
ias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 3, 2024 at 7:48=E2=80=AFAM F=
ea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=3D"_blank">fea.wa=
ng@sifive.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">When calling the loading a descript=
ion function, it should be noticed<br>
that the function may return a failure value. Breaking the loop is one<br>
of the possible ways to handle it.<br>
<br>
Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt;<br></blockquote><div><br></div><div=
><br></div><div>Looks good, a nitpick comment, I would either squash this w=
ith patch #1</div><div>or move the change to return of error code in stream=
_desc_load() to this patch.</div><div><br></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/dma/xilinx_axidma.c | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c<br>
index 4b475e5484..b8ab5a423d 100644<br>
--- a/hw/dma/xilinx_axidma.c<br>
+++ b/hw/dma/xilinx_axidma.c<br>
@@ -291,7 +291,9 @@ static void stream_process_mem2s(struct Stream *s, Stre=
amSink *tx_data_dev,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stream_desc_load(s, s-&gt;regs[R_CURDESC]);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (MEMTX_OK !=3D stream_desc_load(s, s-&gt;re=
gs[R_CURDESC])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;desc.status &amp; SDESC_STATUS_=
COMPLETE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMASR] |=3D DM=
ASR_HALTED;<br>
@@ -348,7 +350,9 @@ static size_t stream_process_s2mem(struct Stream *s, un=
signed char *buf,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stream_desc_load(s, s-&gt;regs[R_CURDESC]);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (MEMTX_OK !=3D stream_desc_load(s, s-&gt;re=
gs[R_CURDESC])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;desc.status &amp; SDESC_STATUS_=
COMPLETE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMASR] |=3D DM=
ASR_HALTED;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000be4b35061a0ae3f7--

