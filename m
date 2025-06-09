Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D36C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKI-00078b-GQ; Mon, 09 Jun 2025 15:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <psingh.cubic@gmail.com>)
 id 1uOgCv-0002rQ-CL
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 13:22:49 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <psingh.cubic@gmail.com>)
 id 1uOgCs-0002tg-Gc
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 13:22:49 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2d0d25cebfeso3780028fac.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749489763; x=1750094563; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bBvAMitpJB38slqKe5uByFVDlwxkMIStUUpnjKg1DwU=;
 b=XKeAql5DvpiIvYo6ZiQXzNsa0nHkaYhW+U0hmYwnBAOjkJDxT8GdFApM32A13sz/p8
 0BHFifjtqHHn9eYEG3B0yqQNzcTrRq/zx9bjOvf0JiOvkkfX+L71wwYVTF043ep1vk8/
 AX6pn5hgcJmqpx26i2agHq7iaYqHZdH7eB+o+aN1oPHxu6GKzjfZgM3rI708yFIg2zOw
 gv2oN/W1eAamkPFJfEFFcsMDn7oD7+VKIujmMJJd69FSz07k/eEsr75e58p62NnlbvDE
 U8pg0zFuXEw3I+4Y7FJFdJSyddB0H/J6W+knRjLJnqtjPfgnbdKdSdx3dZWVTv57IGxd
 3VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749489763; x=1750094563;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBvAMitpJB38slqKe5uByFVDlwxkMIStUUpnjKg1DwU=;
 b=VrlvjMG0SMRFro9jqTmzU0W7/iw5opBoPKVWqgQ+ZH0znLF1SAt5yq21d0K7og2iLJ
 5586CTI+I2rF2NYnsUYLYeycQf8E5iOQufW0+g97qo518/kOHItJKSuTpWAMhRO8DeJx
 KvisW5jWHPN/1u7Z9PE52qDn9hNlCtzAEC9hVPlXa76NeQTPMRcNp1V7+LMtirS+CQ3J
 fFQgYLmLQGwwNAlpjMRmuR/y6Y5vZ/aIUrpx+P2HGQqeIEesbuw2r9iKC2+Woufvct/d
 EUMgpBDgusiXCZ+XJYWriqfIQU+ZtaUnJik4dTGuMpeH4FlqLLldfQwAgK8ahf0fKHOk
 0Y6A==
X-Gm-Message-State: AOJu0Yx/FR1nO3kGDPqZsdDCBhfxsPGVqSQS+LuZ/OH6+o51vDXOFmxT
 eWcLRrjeZD2spMQrUvCkMDv2bIyilnmnVPmf35FlNHrzBERfZ8ikMSVXzGmhRLXD53pLaPfcM1Y
 4USnq98cdglwWSwWBO51z59BkOFZnHk+RP+zCejraMp3p
X-Gm-Gg: ASbGncvEQoMm/ARAQrGZMiZSzyFxn4bV5qo9cDqUfX6zc1dIwe0Q6DedfMEQsmU8up+
 +3sNcAtcuPRomsHEbxUohqstPt8giklX05h0egpsftp0qpeJEFtw7afprpQL8PkkqQmJc4/mBnA
 FmpupAGuodn+ABlVVNJ8Mc7qP2ELOOY82EhQ==
X-Google-Smtp-Source: AGHT+IGf1s3CXzjy1zH8c+gkHPGDYu1/GiuDpKsibOZ4bsUTtVkMe1lNWQlo4ZXLNRofO4Eb8u9HnE+YEcjTbZgOQik=
X-Received: by 2002:a05:6870:8e06:b0:2e9:e9b9:fd7c with SMTP id
 586e51a60fabf-2ea01355dcbmr9182538fac.26.1749489763361; Mon, 09 Jun 2025
 10:22:43 -0700 (PDT)
MIME-Version: 1.0
From: PJ Singh <psingh.cubic@gmail.com>
Date: Mon, 9 Jun 2025 13:22:32 -0400
X-Gm-Features: AX0GCFv4wvMNzA9eO47qfeBoajRs8CAXTB3oOyrInFwBqKYEAp0ZDcI2Q0Dgq8s
Message-ID: <CAPUuJsMOHWQW7bb9_S0Ofj-t840A3mMg+nD57hceASktkbSGhg@mail.gmail.com>
Subject: Embed QEMU terminal into GUI application (Cubic - Custom Ubuntu ISO
 Creator)
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e22736063726d34e"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=psingh.cubic@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Jun 2025 15:38:31 -0400
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

--000000000000e22736063726d34e
Content-Type: text/plain; charset="UTF-8"

Hello Everyone,

I want to embed a QEMU window directly in my GUI application. Are Python
APIs available to embed QEMU into a GNOME GUI application?

I am the developer of Cubic (Custom Ubuntu ISO Creator), a tool which
allows users to customize Ubuntu and Debian based Live ISOs.

Screenshots & information...
https://github.com/PJ-Singh-001/Cubic/wiki

Source code...
https://launchpad.net/cubic

There is a terminal window (
https://github.com/PJ-Singh-001/Cubic/wiki/Terminal-Page) in Cubic that
allows users to make their customizations. However, this is a chroot
environment. I want to replace this with a command-line emulator, so users
can make more advanced changes that require services (such as snapd) to be
running.

The terminal in Cubic currently uses the Vte.Pty class (
https://lazka.github.io/pgi-docs/Vte-2.91/classes/Pty.html). My plan is to
replace this chroot terminal with a command-line environment emulator
running the Live environment of the OS being customized.

Is something similar to Pte.Vte available from QEMU?

Would some kind person point me in the right direction? I would also very
much appreciate some tips or guidance from the community to help accelerate
my learning process to achieve the above goals.

Thank You,
PJ

--000000000000e22736063726d34e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Everyone,</div><div><br></div><div><div><div>I =
want to embed a QEMU window directly in my GUI application.=C2=A0Are Python=
 APIs available to embed QEMU into a GNOME GUI application?</div></div></di=
v><div><br></div><div>I am the developer of Cubic (Custom Ubuntu ISO Creato=
r), a tool which allows users to customize Ubuntu and Debian based Live ISO=
s.</div><div><br></div><div style=3D"margin-left:40px">Screenshots &amp; in=
formation...</div><div style=3D"margin-left:40px"><a href=3D"https://github=
.com/PJ-Singh-001/Cubic/wiki">https://github.com/PJ-Singh-001/Cubic/wiki</a=
></div><div style=3D"margin-left:40px"><br></div><div style=3D"margin-left:=
40px">Source code...</div><div style=3D"margin-left:40px"><a href=3D"https:=
//launchpad.net/cubic">https://launchpad.net/cubic</a></div><div><br></div>=
<div><div>There is a terminal window (<a href=3D"https://github.com/PJ-Sing=
h-001/Cubic/wiki/Terminal-Page">https://github.com/PJ-Singh-001/Cubic/wiki/=
Terminal-Page</a>) in Cubic that allows users to make their
 customizations. However, this is a chroot environment. I want to=20
replace this with a command-line emulator, so users can make more=20
advanced changes that require services (such as snapd) to be running.</div>=
<div><br></div><div>The terminal in Cubic currently uses the Vte.Pty class =
(<a href=3D"https://lazka.github.io/pgi-docs/Vte-2.91/classes/Pty.html">htt=
ps://lazka.github.io/pgi-docs/Vte-2.91/classes/Pty.html</a>). My plan is to=
 replace this chroot terminal with a command-line environment emulator runn=
ing the Live environment of the OS being customized.</div><div><br></div><d=
iv>Is something=C2=A0similar to Pte.Vte available=C2=A0from QEMU?</div><div=
><br></div></div><div>Would some kind person point me in the right directio=
n? I would also very much appreciate some tips or guidance from the communi=
ty to help accelerate my learning process to achieve=C2=A0the above goals.<=
/div><div><br></div><div>Thank You,</div><div>PJ</div><div><br></div></div>

--000000000000e22736063726d34e--

