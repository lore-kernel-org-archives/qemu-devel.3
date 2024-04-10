Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E1ACD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVqk-0003H4-Dd; Wed, 10 Apr 2024 07:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVqf-0003CZ-Hf
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:10:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVqd-0000ES-TS
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:10:37 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e6f4ee104so2842227a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747434; x=1713352234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWJ8haMrz/OQpydWXDXs0EfuocOmYJASl59aPKDepuU=;
 b=XYCc3cnAI64chNy3EOJ4MbfCI3pIsdiJX0kjsVTB+PsIjsD+i7668mQFxZbdMO69DC
 KXFLixK8/RIkfOAQQjTVmfn5dG3MZo/qwzPlMjuRHpoLp1N84yhWXqJIZ9kGob3WmZcy
 RvmbADA1Xqg8xsDClDnrZQinFz54rrDCgwwPUtRuLcf/plLR+w/5BXibQhJ5UOAj6LCz
 Rz7WrfG4EhWJOtlpgLa8EApvaZRQ7escrWOgCq2w8LoFq0QOLYaOTzfUYpKRaOJCD+Bx
 cno6xIz80ksiIBtOamm3olDrOfZUTBc+cQGqSfcbXmLKFa3uaC27DpId4rap+QRU7GHz
 3FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747434; x=1713352234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWJ8haMrz/OQpydWXDXs0EfuocOmYJASl59aPKDepuU=;
 b=PTUUebeiLWS07ZJqxOQCz1+QKxe+U4RjAYxkBHlf//BOxeegNy5bIKzGztShsgP5iX
 X8U0xfVRZYTGMULlnbZCxT74g8DsdKbu0At+U/6zYIwzDPhF6sQ8POU4GkJZ1KaL7qu2
 wXOx9wQmIQQBMe7iqTgVYkk1GHERczyyBHMTOYSM9Y7UrHF4k9SLe/42kUZFmbUW+QxX
 kXlxF3Vui3WVpUwaAzZw0OLrClCOg+lMnVwBKufMIVjrz2Wwf/7UZtFvrb47k1FynwKz
 lJIE28Ocd00lLbwjEcUKiQepnyy4Om7JruDqHzolLWORDRDQBo8d0dBFTA7QkPW4LEZW
 mftw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo/WBr5gLYhOKpj+6VTnuangn0BrCgGnEP/lj4zQ1+KNOEznwMft0BV0Sw/pqR8oF3aLVOPNmavg05L28qfnms1NVsYhE=
X-Gm-Message-State: AOJu0YyYCBLUdehRSvud8luDWYRjZFWAkh+cCfx7YBqiDgs2IN1C1SBA
 /+zGJTv6wrXcrOYpP01zXtnCqdGEKZi5RS4Dv8IG9b5u0bWnwGe29DmD4v2yzpMoswnbk8K78Yu
 T4VC+G2orzU/xFCXCgGJdLt5yo54=
X-Google-Smtp-Source: AGHT+IGWvSW2wLEVssQLWwFvjIekn9ST4Y/n9PTd+1wDj4gm6/wiJrSg3Py6LxERsol1jCEh23/gykINJ608Ocj62hY=
X-Received: by 2002:a50:d498:0:b0:56e:2148:f517 with SMTP id
 s24-20020a50d498000000b0056e2148f517mr1395762edi.33.1712747433978; Wed, 10
 Apr 2024 04:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-2-vikram.garhwal@amd.com>
 <87bk7y5gpz.fsf@draig.linaro.org>
In-Reply-To: <87bk7y5gpz.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:10:22 +0200
Message-ID: <CAJy5ezr71cwbTOSKTGTzDN_CO1HKVyYitWPed-1DRkxEfQuZsQ@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 1/7] softmmu: physmem: Split ram_block_add()
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, 
 jgross@suse.com, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006474480615bc16a7"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52d.google.com
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

--0000000000006474480615bc16a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:35=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Vikram Garhwal <vikram.garhwal@amd.com> writes:
>
> > Extract ram block list update to a new function ram_block_add_list().
> This is
> > done to support grant mappings which adds a memory region for granted
> memory and
> > updates the ram_block list.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--0000000000006474480615bc16a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Mar 1, 2024 at 12:35=E2=80=AFPM A=
lex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@l=
inaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Vikram Garhwal &lt;<a href=3D"mailto:vi=
kram.garhwal@amd.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt; writ=
es:<br>
<br>
&gt; Extract ram block list update to a new function ram_block_add_list(). =
This is<br>
&gt; done to support grant mappings which adds a memory region for granted =
memory and<br>
&gt; updates the ram_block list.<br>
&gt;<br>
&gt; Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" ta=
rget=3D"_blank">jgross@suse.com</a>&gt;<br>
&gt; Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd=
.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kern=
el.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>=C2=A0</div><div>Reviewed-by: Edgar E.=
 Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.=
com</a>&gt;=C2=A0</div></div></div>

--0000000000006474480615bc16a7--

