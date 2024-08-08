Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38048C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 16:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6Tf-0001Pi-EY; Thu, 08 Aug 2024 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yusuf.colak3406@gmail.com>)
 id 1sc5H9-0002CS-B2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:42:03 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yusuf.colak3406@gmail.com>)
 id 1sc5H6-0007Th-9w
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:42:03 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-66526e430e0so10370357b3.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723131718; x=1723736518; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jNNOFGUMabz5LcMMn5A0iat/PWcGnDNzNL3t3iaTSSI=;
 b=kvoE6tQqQfpvtISM2NZSSUrXDReGlwxVMBTzTAE8ZxrAzIeZ3ypEy7UbpRsCT6+De9
 qp3bIRZdz5i6l9sd49+61BmJwnCUYB55KbjPN8qKkFCj6jU729sdrC1ZVXMU7qr1qE06
 YE7NWFCmjspm9TkjWP58gfMEwh2bk2K/y4a39gMkZROrKV1D9xqrXh20DeQVfgtjIadc
 cAfd9bV75SmTUUHGPXMU1K/G3dhXYIYpuO4kApboPJY7xzhYdNw9LoYYFua6FdjM8dFb
 eyXj9BTHeXLditMIcnM7giHT5+AAb9MKPMlKRSYbf6XS7r3v8GPo/mp46iW+icN7zi0r
 QgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723131718; x=1723736518;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNNOFGUMabz5LcMMn5A0iat/PWcGnDNzNL3t3iaTSSI=;
 b=sWDgl2h3TZ2SLYVIRRTEI1juQMwgQvbZ6K1FSZ4ooOa6pSJM7RjBVoqn7nwZH1zNRY
 NOc4GD5ucNhUvi35C0eWM99S+MVQhgCuT6AOkCQaILAU4vLDQMnLMo2lkvuzSo7xTMAA
 FDu4taaltRPbmh+ZmoxzvS7Yg2p1HGcwz+JSaTFtq9f2OrPIN3BABnat3bfkYJKQuuIe
 4d2HaS5iPTdDUo9qlZu6FOmr4edaRPgDLAMWgLHHZMOBLGe8GZolheAIwx/AhS8GHj/G
 M8eEDWKyyJAHHQ2OX8ym1PQKfjYe1O2EEqSa8785ujXNJZ47/jP3LKCfhvH4q1VCiyau
 LEdg==
X-Gm-Message-State: AOJu0YyTajI5zvL6MYBNFDaTbHSFZBMta2F1bh5xVbaR1DwRajS04LPy
 Q1iMQcl7DZE/ecFUKCBJa7Mwy8BS1RNdkWVVhKgHFApupdlKBh9TJDP8LXTRyIzPAQcrpgFGFbX
 iPx/V7IZFzXGbE3NPBUJ55QgNwNLMSuoi
X-Google-Smtp-Source: AGHT+IEECZXQVuy5TRmRNFbpP3D7Ov19oL0Bn8VQ5NH/p2kX1a096boADy5elfx9EB54UtiDK2dy1Ge35gSznoXxW30=
X-Received: by 2002:a05:690c:4784:b0:64a:90fe:911e with SMTP id
 00721157ae682-69bfb7e5474mr21819677b3.31.1723131717626; Thu, 08 Aug 2024
 08:41:57 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Yusuf_said_=C3=87olak?= <yusuf.colak3406@gmail.com>
Date: Thu, 8 Aug 2024 15:41:46 +0000
Message-ID: <CANwC2_Tph=P2Ho-nm-x5C8wkbz5NX=PXDA5GvuP9cf08Gscrxw@mail.gmail.com>
Subject: bug?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ee37b9061f2ddd94"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=yusuf.colak3406@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Aug 2024 12:58:57 -0400
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

--000000000000ee37b9061f2ddd94
Content-Type: text/plain; charset="UTF-8"

I installed qemu successfully and downloaded emulator you published on
github, i runned

mkdir buildcd build

but if i run ../configure it gives ;




ERROR: missing GIT submodules
This is not a GIT checkout but module content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/#source

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.

can you help me with this?

--000000000000ee37b9061f2ddd94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I installed qemu successfully and downloaded emulator you =
published on github, i runned <br><pre>mkdir build
<span class=3D"gmail-pl-c1">cd</span> build<br><br></pre><pre>but if i run =
../configure it gives ;<br></pre><pre><br><br><br>ERROR: missing GIT submod=
ules<br>This is not a GIT checkout but module content appears to<br>be miss=
ing. Do not use &#39;git archive&#39; or GitHub download links<br>to acquir=
e QEMU source archives. Non-GIT builds are only<br>supported with source ar=
chives linked from:<br><br>=C2=A0 <a href=3D"https://www.qemu.org/download/=
#source">https://www.qemu.org/download/#source</a><br><br>Developers workin=
g with GIT can use scripts/archive-source.sh<br>if they need to create vali=
d source archives.<br><br></pre><pre>can you help me with this?<br></pre></=
div>

--000000000000ee37b9061f2ddd94--

