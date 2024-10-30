Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F1D5CC9C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 11:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t673B-0000gl-B1; Wed, 30 Oct 2024 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t6739-0000gJ-5C
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:39:43 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t6736-0006ke-9I
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:39:42 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4a46d662fccso2187508137.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730288379; x=1730893179; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cpQfnz/tccCx7qUhYUD76jzdL0sccr5TZFMSFAAnZcU=;
 b=Kw89ueyyl6HKzx3fO9P7NpkSdQDq23Z28wJ3FHvriIET7l7NsbKNtqUC9OEmAhgudS
 62+rxMPjppiIQGKVt+FqgdrSMsg/lv8+/7uHkAnJ1onpyKDVB/gxarMucNOaNGUDd0f0
 VTTUMH3Zun1j4jGswigVigvLsKOxLXHoXNJMnyFqxU9u9tocU+54xG2BSr/xA5lCLTvu
 mJel/B8apmACCYiq+Y7nwDkSZnIQtRdXjfas6GvVbaPFOr3aByrBt9+jBzZZFq1jFbDE
 2DuMBU7yA5UFl7YUYL6vgv4NNp6PyRTwYnJpASCrSh4zujPuCVDCAGguYjQkt7kIq+/v
 zFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730288379; x=1730893179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpQfnz/tccCx7qUhYUD76jzdL0sccr5TZFMSFAAnZcU=;
 b=Q2gCruS/1/iogEs0LC1lgXCsVR2/0fxTHqEQx2MBuKfctqgPU4FM6cphpbzZYcFheM
 KpEzkAQbfqEMGOWULIAY/w2/t3kpK70YyJJkqMEbPgdjiv291iKNfeepoWCeeP/PNKpp
 lVLF7hzBuvTJJ+dy/L5De1PGh8D7RbObKG+lbymMwxyWl6m2r8XW0IFhltWFI/nN6HXl
 VFxsBQVz1F3TGEC3+O44g8BmjkLYq46GtK1bXxnlSXwkSHN5//gV5iUj/uQjLiuSMprr
 N27sP/b5MFq+a3QGZgcFdhO1iO8rewu5DdfRU9+9rFldjlJPgiqlud6HQWH2JZV1kcHG
 Y1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXvzGUYRYFxBDY88oT4nCj7tyv05dysyd/E9id4T6vz5GCfkaSysq42uelpo/eFf/UB9dRx3GWsKxK@nongnu.org
X-Gm-Message-State: AOJu0Yydkrc5IqI4eZfqP1xxluYBov2UqxO2gwtZDHpJJkYl+QKJLROV
 RNLSpqxd09mOPh4GOiVDdNOWcPBeGovdAHb8mvy1TcRqucwbhwTauX4snfU6J+pRmig63A7qX95
 52amOEHnKqYeMXcllVAk0b81gQkw=
X-Google-Smtp-Source: AGHT+IGQ5KW20xdgKk6VjiMAC9BwCoenGddkNOc/r8g4HNXZEgZqlStGHsmrAXg2vh1mz5e+Vmf1AQ8ZrgbfeEGvwSw=
X-Received: by 2002:a05:6102:304f:b0:4a8:c03f:f4bd with SMTP id
 ada2fe7eead31-4a8cfd8cd2amr13977733137.29.1730288379143; Wed, 30 Oct 2024
 04:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
 <a9595a5b-e964-4dd0-9725-278141b398a3@amazon.com>
 <53d9a4a5-367e-4049-ae7a-fa3442c46877@redhat.com>
In-Reply-To: <53d9a4a5-367e-4049-ae7a-fa3442c46877@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 30 Oct 2024 17:39:26 +0600
Message-ID: <CAFfO_h4T2Rx5YXCY+vvFgSCoqWDX-PR_Z7v2jX9fCNePk4a8Og@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, stefanha@redhat.com, slp@redhat.com, 
 Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net, 
 "Michael S. Tsirkin" <mst@redhat.com>, marcel.apfelbaum@gmail.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000032aee10625b028c4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000032aee10625b028c4
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 30, 2024, 5:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 10/30/24 09:43, Alexander Graf wrote:
> >> Hi,
> >>
> >> sorry about the delay -- the patches failed CI and I didn't have much
> >> time to investigate until now.
> >>
> >> The issues are basically:
> >>
> >> 1) some rST syntax errors
> >>
> >> 2) failures on non-Linux due to lack of VHOST_USER
> >>
> >> 3) failures on 32-bit due to uint64_t/long mismatch.
> >>
> >> While fixing (2) I also moved the dependency on libcbor and gnutls from
> >> meson to Kconfig, and added --enable-libcbor to configure.  I also split
> >> hw/core/eif.c to a separate symbol, just to simplify reproducing the
> >> 32-bit failure on the right commit.
> >>
> >> And finally, VIRTIO_NSM should default to no (the nitro-enclave machne
> >> takes care of selecting it).
> >>
> >> No big deal; it's easier done than described.  See attached patch for
> >> the differences.
> >
> > Thanks a bunch for looking deeply and fixing the issues above :). I
> > suppose the next step is to post v9 with your changes included?
>
> No, I can see that it wasn't clear but I've queued it. :)
>


Thank you for fixing the errors and queueing this, Paolo.

Regards,
Dorjoy

--00000000000032aee10625b028c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 30, 2024, 5:31 PM Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On 10/30/24 09:43, Alexander Graf wrote:<b=
r>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; sorry about the delay -- the patches failed CI and I didn&#39;t ha=
ve much<br>
&gt;&gt; time to investigate until now.<br>
&gt;&gt;<br>
&gt;&gt; The issues are basically:<br>
&gt;&gt;<br>
&gt;&gt; 1) some rST syntax errors<br>
&gt;&gt;<br>
&gt;&gt; 2) failures on non-Linux due to lack of VHOST_USER<br>
&gt;&gt;<br>
&gt;&gt; 3) failures on 32-bit due to uint64_t/long mismatch.<br>
&gt;&gt;<br>
&gt;&gt; While fixing (2) I also moved the dependency on libcbor and gnutls=
 from<br>
&gt;&gt; meson to Kconfig, and added --enable-libcbor to configure.=C2=A0 I=
 also split<br>
&gt;&gt; hw/core/eif.c to a separate symbol, just to simplify reproducing t=
he<br>
&gt;&gt; 32-bit failure on the right commit.<br>
&gt;&gt;<br>
&gt;&gt; And finally, VIRTIO_NSM should default to no (the nitro-enclave ma=
chne<br>
&gt;&gt; takes care of selecting it).<br>
&gt;&gt;<br>
&gt;&gt; No big deal; it&#39;s easier done than described.=C2=A0 See attach=
ed patch for<br>
&gt;&gt; the differences.<br>
&gt; <br>
&gt; Thanks a bunch for looking deeply and fixing the issues above :). I <b=
r>
&gt; suppose the next step is to post v9 with your changes included?<br>
<br>
No, I can see that it wasn&#39;t clear but I&#39;ve queued it. :)<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Thank you for fixing the errors and queueing this, Paolo.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=
=3D"auto">Dorjoy</div></div>

--00000000000032aee10625b028c4--

