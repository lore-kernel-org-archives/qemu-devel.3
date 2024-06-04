Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28903C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEO6o-0005Xd-3X; Tue, 04 Jun 2024 02:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEO6m-0005XN-5n
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:57:24 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sEO6k-0001kv-82
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:57:23 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4e4f0020ca3so237598e0c.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717484241; x=1718089041; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4P4A9iepjzZGqS6yex/oat1l+Ol0L3OkNQUVBtpzWYs=;
 b=N3txu6FIAZ3cgY7qj28kuO+/mlt/aXFZwMcbFmyYHceP3CZnLx9FOA42rZn0+vt/fE
 SNqQ2Ssfshvfnn2EyL0r9KrIqt42hRXxLMvYNB0nZExIm2lQuxy48i1XgraY5QFZ2IPG
 zgEq7zZNBmlcWeclB1IbDHAccBcYZAxp8ams8AJjBPy1G2fs9OwQHfKQL9W+eZ2eXO+g
 nYSqOgHQmb9p48u6S5awJ6ctZyQslx68uV5HlEzrCQdwke7TCAh8KlZjZkMaA5ErlWXH
 05ft+ZNNkhGeEFIKd3lIOmHKF3AFFXMy2BAE4QI0Uao7Y+4ssFjZPYAE2bjGqLsYvrN7
 m6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484241; x=1718089041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4P4A9iepjzZGqS6yex/oat1l+Ol0L3OkNQUVBtpzWYs=;
 b=hzurtdBUabeg9pY9/4aSKVQaMjJnq0HQ6hF8hIg/6Diu+GvWIeZjBqCOITrqKCqe4e
 YGBg2QE2+SJf5qTvJANrAVqX3EpC7ztsR8H9Ko5zyonsqLX4ejgiX774iYGKqlvchip0
 oR3ftr+zZmFFqN1oy+ZnuQI8uPUDD6PqHBDO9kqVPOx1EYIrNuXvUhxbfVkD9Zy3ArgE
 V8wz2ZbpJOjSjO+bM9CDVk8BZeYQJ7jc6FNB41PjMTSDLTP1TSPGEG41oOk0mhoDdm9T
 32L6o9+vFgWgnN0uHopZUsgbsR+87p/eVtCYBZyMn2OoBNJ5dgWG3pytc1cx5OnOCsB/
 bY3A==
X-Gm-Message-State: AOJu0Yxe2GIZ0fF4MRx1hbtTQFANeM4JVqn9Axq6US+G688LClMn5vDh
 no30JYKG5Qcnpg4UJx0w1ZLSQhH59DYmidBePg84vuvMEh/fETgt7THg90pgcVO43clkvafxw9A
 W0Syzl/E6JcuCilOp077Rs8bY9ELQNo4SBsyTbg==
X-Google-Smtp-Source: AGHT+IGBjYjgbc1qE2KzLX7xhidqy77mHimxwlY6p7Lotq/uszInbs+eABJMpw4bjh3YNoBuDlMzbKBztOoDaboBdAE=
X-Received: by 2002:ac5:c851:0:b0:4d4:21cc:5f4f with SMTP id
 71dfb90a1353d-4eb02e7bdf4mr9223483e0c.11.1717484241108; Mon, 03 Jun 2024
 23:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-5-fea.wang@sifive.com>
 <CAJy5ezocZnmYec5TenZNtOe6+2-OxzaRaSXLW1XYHL5X0Xd8dw@mail.gmail.com>
In-Reply-To: <CAJy5ezocZnmYec5TenZNtOe6+2-OxzaRaSXLW1XYHL5X0Xd8dw@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Tue, 4 Jun 2024 14:57:10 +0800
Message-ID: <CAKhCfscM=B0TD4k_SgKwAyRbg0zuzFAT+M8Rq3kTSrkUZBMefw@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/net: Fix the transmission return size
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000195ece061a0af665"
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

--000000000000195ece061a0af665
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just encountered this issue when running Linux, and the trouble will be
fixed after the patches. So I think they work.

Sincerely,
Fea

On Mon, Jun 3, 2024 at 6:31=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@gm=
ail.com>
wrote:

> On Mon, Jun 3, 2024 at 7:48=E2=80=AFAM Fea.Wang <fea.wang@sifive.com> wro=
te:
>
>> Fix the transmission return size because not all bytes could be
>> transmitted successfully. So, return a successful length instead of a
>> constant value.
>>
>>
> How did you test this patch, on Linux or something else? I have some
> memory that we had some trouble with similar patches before.
>
> Anyway, the change looks good to me:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>
>
>
>> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
>> ---
>>  hw/net/xilinx_axienet.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
>> index 7d1fd37b4a..05d41bd548 100644
>> --- a/hw/net/xilinx_axienet.c
>> +++ b/hw/net/xilinx_axienet.c
>> @@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const
>> uint8_t *buf, size_t size)
>>      axienet_eth_rx_notify(s);
>>
>>      enet_update_irq(s);
>> -    return size;
>> +    return s->rxpos;
>>  }
>>
>>  static size_t
>> --
>> 2.34.1
>>
>>

--000000000000195ece061a0af665
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I just encountered this issue when=C2=A0running Linux, and=
 the trouble will be fixed after the patches. So I think they work.<div><br=
></div><div>Sincerely,</div><div>Fea</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 3, 2024 at 6:31=E2=80=
=AFPM Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edg=
ar.iglesias@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 3, 2024 =
at 7:48=E2=80=AFAM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" targ=
et=3D"_blank">fea.wang@sifive.com</a>&gt; wrote:<br></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix the transmi=
ssion return size because not all bytes could be<br>
transmitted successfully. So, return a successful length instead of a<br>
constant value.<br>
<br></blockquote><div><br></div><div>How did you test this patch, on Linux =
or something else? I have some</div><div>memory that we had some trouble wi=
th similar patches before.</div><div><br></div><div>Anyway, the change look=
s good to me:</div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailt=
o:edgar.iglesias@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<=
br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
---<br>
=C2=A0hw/net/xilinx_axienet.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c<br>
index 7d1fd37b4a..05d41bd548 100644<br>
--- a/hw/net/xilinx_axienet.c<br>
+++ b/hw/net/xilinx_axienet.c<br>
@@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t=
 *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0axienet_eth_rx_notify(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0enet_update_irq(s);<br>
-=C2=A0 =C2=A0 return size;<br>
+=C2=A0 =C2=A0 return s-&gt;rxpos;<br>
=C2=A0}<br>
<br>
=C2=A0static size_t<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000195ece061a0af665--

