Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49259CF11CD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqke-0001wm-3K; Thu, 10 Oct 2024 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqkd-0001wZ-3G
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:50:35 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqkb-0000jz-HD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:50:34 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fac6b3c220so11682651fa.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728557431; x=1729162231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7eVMJ9rcEipcV+gHgHTv2JLBDt2AYcvL+WMBWxTXpk=;
 b=bdI9dNk+0zUNu5HVOwLyEqmihugD3kgTyfWF03Nvje/alAMl79aIVHc7IEpmfakRPS
 6wv3P7+p5ZDzlj1cohap+veZ5N+kHfeaeW2Tor0ZRxEp6+Tcg5jE7o0f2c58paU5bznj
 5nwkllHcV0/NYVcm3UDJxWozWDippFGpNIaG/NMCdbJPlZrfPg2QlBQTJ8R8dY3lOELr
 xjYqyuNb23pjBUMjTLxwQCcfymR1NGVs7QqHbN0T4H8hH1QqAOCGOzoIjuD49Z/gDN0Q
 n1JaDpq86L33nNy4kTGRplBtflWqFGpRqn6KgfrHwLMn4382R7TuYYAJ422jTwGXTqGh
 LhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728557431; x=1729162231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7eVMJ9rcEipcV+gHgHTv2JLBDt2AYcvL+WMBWxTXpk=;
 b=S/G0MyMt476aimY9saBVuoLMQFW0M8+4NIrWaYUOnWh8GzQuM6MdXR1pqFM4+Jykpn
 3TFjVNgz5mLoM69D9svs9++MhOJ9JjOR3/D/0QrjrkLK1nP8fFCPrWVJk70rz2yKaQqO
 xWge5BF5NiQcFMqCH+scQqRd5eSDxMmxDxARo4Wyxls8LJITYmT3Ub4yHP43dmO9YAw+
 uZ7iQNAdsJV1WumOB3iHz+DlxcIAG1WxL5eaBWriFJOGq2U2qbgJLgqhpw6VJmUAzAa7
 wdgho/uPfZyueFw2rXsoNKWkwY7I4f3of/dPjsNfDkOO3lL/llj4choMwXUeyeYS98U8
 gXWQ==
X-Gm-Message-State: AOJu0YzcZKkowszu5vphP/LLvmsb/22hEKlNlbF/faIr8heFUxMfwora
 9A+3V+DHa0WdSvW+PxPy1oGVpK31z1FFDmFSBT9bJivdXiHRQPbVPT9S1zXbNWsg7DR+v6qdifU
 y+a9SVmyYlNYE+Sb3JyCvBXsTQjZZsA==
X-Google-Smtp-Source: AGHT+IF8YPzZavys2atF65jnGZ82McrxOXKcaLZILN2GQkZ29UiHr5AxFYntPKxkSF6VuwoNgfACDBf231Hc8GidF6E=
X-Received: by 2002:a2e:a58c:0:b0:2fa:d84a:bda5 with SMTP id
 38308e7fff4ca-2fb1871e891mr57345871fa.7.1728557431244; Thu, 10 Oct 2024
 03:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241010092619.323489-1-r.peniaev@gmail.com>
 <CAJ+F1CL8VPo64DVty94FY4KyKr1h8_dbmrqLfy06VuMzoNyYYA@mail.gmail.com>
In-Reply-To: <CAJ+F1CL8VPo64DVty94FY4KyKr1h8_dbmrqLfy06VuMzoNyYYA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 10 Oct 2024 12:50:19 +0200
Message-ID: <CACZ9PQV0n7nXYDcNZO2N0L56RMHQgoyAJfi-603DP+ftFK_nQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] chardev/char: fix qemu_chr_is_busy() check
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a9d10006241d2371"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a9d10006241d2371
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024, 12:20 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com>
wrote:

> Hi Roman
>
> On Thu, Oct 10, 2024 at 1:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>
>> `mux_cnt` struct member never goes negative or decrements,
>> so mux chardev can be !busy only when there are no
>> frontends attached. This patch fixes the always-true
>> check.
>>
>> Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> That would be worth some new tests for chardev removal. It seems to be
> lacking. And mux probably need extra fixing. I can take a look if you don=
't.
>

I assume no one removes mux device, so no one observes the error. Please,
go ahead, I'm not sure I do fully understand what exactly should be fixed.

--
Roman

--000000000000a9d10006241d2371
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Oct 10, 2024, 12:20 Marc-Andr=C3=A9 Lureau &lt=
;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr">Hi Roman<br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Oct 10, 2024 at 1:28=E2=80=AFPM Roman Peny=
aev &lt;<a href=3D"mailto:r.peniaev@gmail.com" target=3D"_blank" rel=3D"nor=
eferrer">r.peniaev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">`mux_cnt` struct member never goes negative or =
decrements,<br>
so mux chardev can be !busy only when there are no<br>
frontends attached. This patch fixes the always-true<br>
check.<br>
<br>
Fixes: a4afa548fc6d (&quot;char: move front end handlers in CharBackend&quo=
t;)<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat=
.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a></blockquote><div><br></div><div>Reviewed-b=
y: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<=
/div><div><br></div><div>That would be worth some new tests for chardev rem=
oval. It seems to be lacking. And mux probably need extra fixing. I can tak=
e a look if you don&#39;t.</div></div></div></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">I assume no one removes mux device,=
 so no one observes the error. Please, go ahead, I&#39;m not sure I do full=
y understand what exactly should=C2=A0be fixed.=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">--</div><div dir=3D"auto">Roman</div></div>

--000000000000a9d10006241d2371--

