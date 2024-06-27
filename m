Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C7C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMt2R-0002x4-W1; Thu, 27 Jun 2024 13:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMt2Q-0002wm-G6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:36:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMt2O-0002yP-LT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:36:02 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c81ce83715so5263622a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719509759; x=1720114559; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8z/RSPkstqM1nkgI4KVmu7rINoW/sGuRRsBQUp4R/AY=;
 b=DuxVS8GTcEc+1ZfN4JjF/sNACEwJ/sab8LFeS0l028U3Gm5KNr0QTfjIdprrZieQu5
 7w4TEfDMyBM5fxkQSNnxDjieACdW2+i9oA8FnsyUECLyShYSsqKLq40f7PVMJ2BfCvn+
 jG532YuK3SBy93swQMynoLjsSH0+i5WjWWxt5RrwRLck0e0Oacr4FrKxpEhf946TBBFn
 K1WH+/txXpqVmHrbqM92f6ET91ChU2RKljPQJybH8f6zKh/rBOKXBJFhZX2PXSnP8kQp
 DirHhHECv5/x8VHryQfMBettZf4bCWZqUnkPEdwxjIihBwW4lQ276BVK47LEoRjhdqq+
 0ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719509759; x=1720114559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8z/RSPkstqM1nkgI4KVmu7rINoW/sGuRRsBQUp4R/AY=;
 b=JhY2tzJjE4zjO2thwdAPlFmF/sAeLrOoRjPTHEMLq3DUrZAwGKynohQYhflUSfjeKv
 EqCqayOsa6yfgPw3yq1R9VSdF8nnvsiKi/dxdU+fdnGrXees2bkydNHcrg18RFxyX49t
 3lM3SW+zK06bZzcFTZq0RLjB3FRzhFoCWgAdWGbBHRnpK6c/pqmSn5UEVN91sGgpex6w
 2HxZgz6XFN8xtn4my/1UAUJNDZS4XS6i8z1YN+LdeCzeRndept+GWkJysg0nt4Nf6R0S
 N71J7NmHh/yHh7Wi0QCndhcYnUbHdQjJ0w4nJ+/JLXgvrOv6yxRLcVCcTJqCk9Rikcka
 vEXg==
X-Gm-Message-State: AOJu0YyBwEfQP8jIMAsG6yt1hLz23bfrMDcCG9WoEy5UmQPJNk2gUYMG
 NwR6nyX9K+Sjuq6r/iHmSX4GzkuJx58kvqfsUBO7wma6kAzUqeqXoAyaoPnCLU/+mKnu1QmuaS4
 xgY9PFgunRGiGXxM5/4hi2WRVgEE=
X-Google-Smtp-Source: AGHT+IGraRLz8idQXE0mAmRflNvX1Il76b8p0XdjObRp6YnIYebaDZfYL29cAKUoAC2dNbM5EPhmDpagM4ixIEaxQEQ=
X-Received: by 2002:a17:90a:8c04:b0:2c8:b6b:15cb with SMTP id
 98e67ed59e1d1-2c8581d1e42mr12120659a91.17.1719509758969; Thu, 27 Jun 2024
 10:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240627020207.630125-1-gregorhaas1997@gmail.com>
 <OSZPR01MB64532802F85690BB7C8BAA998DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB64532802F85690BB7C8BAA998DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Thu, 27 Jun 2024 10:35:22 -0700
Message-ID: <CAMqWt3rcN+y3ND34Rz9d5A32rNBh4MTRBNkx44wt_w22g61XUg@mail.gmail.com>
Subject: Re: [PATCH] hw/core/loader: allow loading larger ROMs
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005f12e1061be2908e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pj1-x1033.google.com
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

--0000000000005f12e1061be2908e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xingtao,

> Can you reproduce this issue?
Absolutely! I encountered this when trying to load an OpenSBI payload
firmware using the bios option for the QEMU RISC-V virt board. These
payload firmwares bundle the entire next boot stage, which in my case is a
build of the Linux kernel (which is a standard configuration, supported by
tools such as Buildroot [1]). My kernel (configured with the default 64-bit
RISC-V configuration) comes in at 9.8M, which is copied into the OpenSBI
firmware of final size 10M. Then, I run the following QEMU command:

qemu-system-riscv64 -machine virt -m 4G -nographic -bios fw_payload.bin

and get the following output:

rom: file fw_payload.bin: read error: rc=3D2147479552 (expected 2303760392)
qemu-system-riscv64: could not load firmware 'fw_payload.bin'

This is from my development machine, running Arch Linux with kernel 6.9.6
and root filesystem ZFS 2.2.4. Please let me know if you'd like me to make
a minimal reproducer for this, or if you need any more information.

Thanks,
Gregor

[1]
https://github.com/buildroot/buildroot/blob/master/boot/opensbi/Config.in#L=
95


On Wed, Jun 26, 2024 at 11:11=E2=80=AFPM Xingtao Yao (Fujitsu) <
yaoxt.fnst@fujitsu.com> wrote:

> Hi, Gregor
> >
> > The read() syscall is not guaranteed to return all data from a file. Th=
e
> > default ROM loader implementation currently does not take this into
> account,
> > instead failing if all bytes are not read at once. This change wraps th=
e
> > read() syscall in a do/while loop to ensure all bytes of the ROM are
> read.
> Can you reproduce this issue?
>
> Thanks
> Xingtao
>

--0000000000005f12e1061be2908e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Xingtao,<br><br>&gt; Can you reproduce this issue?<br>A=
bsolutely! I encountered this when trying to load an OpenSBI payload<br>fir=
mware using the bios option for the QEMU RISC-V virt board. These<br>payloa=
d firmwares bundle the entire next boot stage, which in my case is a<br>bui=
ld of the Linux kernel (which is a standard configuration, supported by<br>=
tools such as Buildroot [1]). My kernel (configured with the default 64-bit=
<br>RISC-V configuration) comes in at 9.8M, which is copied into the OpenSB=
I<br>firmware of final size 10M. Then, I run the following QEMU command:<br=
><br>qemu-system-riscv64 -machine virt -m 4G -nographic -bios fw_payload.bi=
n<br><br>and get the following output:<br><br>rom: file fw_payload.bin: rea=
d error: rc=3D2147479552 (expected 2303760392)<br>qemu-system-riscv64: coul=
d not load firmware &#39;fw_payload.bin&#39;<br><br>This is from my develop=
ment machine, running Arch Linux with kernel 6.9.6<br>and root filesystem Z=
FS 2.2.4. Please let me know if you&#39;d like me to make<br>a minimal repr=
oducer for this, or if you need any more information.<br><br>Thanks,<br>Gre=
gor<br><br>[1] <a href=3D"https://github.com/buildroot/buildroot/blob/maste=
r/boot/opensbi/Config.in#L95">https://github.com/buildroot/buildroot/blob/m=
aster/boot/opensbi/Config.in#L95</a></div><br><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 26, 2024 at 11:11=E2=80=
=AFPM Xingtao Yao (Fujitsu) &lt;<a href=3D"mailto:yaoxt.fnst@fujitsu.com">y=
aoxt.fnst@fujitsu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi, Gregor<br>
&gt; <br>
&gt; The read() syscall is not guaranteed to return all data from a file. T=
he<br>
&gt; default ROM loader implementation currently does not take this into ac=
count,<br>
&gt; instead failing if all bytes are not read at once. This change wraps t=
he<br>
&gt; read() syscall in a do/while loop to ensure all bytes of the ROM are r=
ead.<br>
Can you reproduce this issue? <br>
<br>
Thanks<br>
Xingtao<br>
</blockquote></div>

--0000000000005f12e1061be2908e--

