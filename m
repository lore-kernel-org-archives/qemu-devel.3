Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E46C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 12:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkjIh-0003aL-J4; Wed, 19 Feb 2025 07:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1tkhi4-0002PN-Bp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:53:44 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1tkhi0-0004rn-Vi
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:53:44 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30761be8fa7so66932361fa.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739962418; x=1740567218; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iJ9stCGeL3YQyXHv6c2zusw2mEv+Og/V0/o1mL/JxVg=;
 b=YhDqyFtKQoLvRiDExQAynNGodxPCsvw9HOzRZf3BaEb5sjDhz4oEyynkUJUr1oWhUL
 fLPfzMRbmQNytOBN84RUo4yhEp+uBj8dubO8B3IGGgktJFj/39Ru6J04LI8n2zslk/46
 frzxIs2eEtclk1fuHDl31OgBmhYBh4CrkTsg1q9sKTKS/HXy/GKSOWq+nuxV2RZ3d1s4
 p4CxTV9DemooKxfF5aR/S3DCcGTf8oNtPr1VFasySF69ZnVKmXlvVw3R3p8wc9ZntVbv
 IQ9mnk7597aBoXGzExJf8vGTf/tsJLneBi0MoO1plIOuaQl/H3u5AtRxYQxHj4qiMX7B
 twHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739962418; x=1740567218;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJ9stCGeL3YQyXHv6c2zusw2mEv+Og/V0/o1mL/JxVg=;
 b=wOMp10G1l6oeAo2AY8VyprXMGlCNj1A5f4wD/EM29xPwsEsl/DrVsnuHDsmlRX0pK0
 dmMjtE/gy9Uz2PTpzp0IlN8U6FOQocq4l6IytDKSobVvto0LSps72RO/L54d960TDYX7
 F8O5A0WRDjV2YbJGsIKpRN1HUWA17PmljrIXriqC4k4EbdbCFwjeUpWqPnCv8V0a91tp
 0oU8y6D+CX0NTGqDrDNBkycdiUCexCbQ26vKnb8Kfz+8b09QcJTRcoZznHBxjpjlztsC
 uQP+CJv9AAOLXnPhrS1ypn8hVThs7/LaQh4qOgQBbjpB1f+opWyN5RJX/3T041kuHbkL
 nkkQ==
X-Gm-Message-State: AOJu0Yx57wy10JX9VrbJax+ZAr9wX6wQEUTdk1U7W0BP72XgIyG97W2r
 ohh4D96KJXfBQnrl5ZIMtpD+p/913RwY97nfePj6VLtARCXo0B9hg6tS+VRobvIQFE89rJTnQ5y
 cPy+OlgC8pWuVFmCv6gLJXgivBeLCN3rf
X-Gm-Gg: ASbGncvQhxkIowEK1qKGu22DJLz533fRtaNf3U+AgT6JfXXoZ/06vliGXpFHKlsLZPM
 1oX6c9To1hl+YNyXKDO0RgNUFuGWA+38zXOSz2rYH1SXI8/xig5Iv6o8Xx3GnCksh3m2VG8M=
X-Google-Smtp-Source: AGHT+IFpAijT5/hhfxunQ1pw1IJzBl+1P3Lp7UZgWG38TE8PPrz8jr02u8u0AiiB21yhr+S/gDNi0E9te0raQRh5UzY=
X-Received: by 2002:a2e:8050:0:b0:302:2598:dec2 with SMTP id
 38308e7fff4ca-30a44dc4a86mr9012121fa.14.1739962417535; Wed, 19 Feb 2025
 02:53:37 -0800 (PST)
MIME-Version: 1.0
From: prashant patil <pmgpatil@gmail.com>
Date: Wed, 19 Feb 2025 16:23:26 +0530
X-Gm-Features: AWEUYZljgtq6oXFI5x0fFvnjpUt0f5ewCuLs30s6Bs5yyOLnODga6i_IpUFsrVg
Message-ID: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
Subject: Query on the dirty bitmap
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d1e3ce062e7c918d"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=pmgpatil@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Feb 2025 07:35:38 -0500
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

--000000000000d1e3ce062e7c918d
Content-Type: text/plain; charset="UTF-8"

Hello All,
Hope this email finds you well.

I have been trying with qemu for a while now, and have come across a
problem specific to dirty bitmaps. I have enabled bitmap on the qcow2 disk
image using 'qemu-img bitmap' command, exposed the bitmap over a unix
socket using 'qemu-nbd' command. Now when I try to read the bitmap using
'qemu-img map' command with 'x-dirty-bitmap=qemu:dirty-bitmap:{bitmap}'
option, I get one single extent which shows that the entire disk is dirty.
Note that the disk size is 5 GB, and has only a few MB of data in it, and
had added very small data after the bitmap was enabled. Bitmap output has
been pasted below.

[{ "start": 0, "length": 5368709120, "depth": 0, "present": true, "zero":
false, "data": true, "compressed": false, "offset": 0}]

Can someone please help me understand why the bitmap content shows the
entire disk as dirty?

Regards
Prashant

--000000000000d1e3ce062e7c918d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All,<div>Hope this email finds you well.</div><div><=
br></div><div>I have been trying with qemu for a while now, and have come a=
cross a problem specific to dirty bitmaps. I have enabled bitmap on the qco=
w2 disk image using &#39;qemu-img bitmap&#39; command, exposed the bitmap o=
ver a unix socket using &#39;qemu-nbd&#39; command. Now when I try to read =
the bitmap using &#39;qemu-img map&#39; command with &#39;x-dirty-bitmap=3D=
qemu:dirty-bitmap:{bitmap}&#39; option, I get one single extent which shows=
 that the entire disk is dirty. Note that the disk size is 5 GB, and has on=
ly a few MB of data in it, and had added very small data after the bitmap w=
as enabled. Bitmap output has been pasted below.</div><div><br></div><div>[=
{ &quot;start&quot;: 0, &quot;length&quot;: 5368709120, &quot;depth&quot;: =
0, &quot;present&quot;: true, &quot;zero&quot;: false, &quot;data&quot;: tr=
ue, &quot;compressed&quot;: false, &quot;offset&quot;: 0}]</div><div><br></=
div><div>Can someone please help me understand why the bitmap content shows=
 the entire disk as dirty?</div><div><br></div><div>Regards</div><div>Prash=
ant</div></div>

--000000000000d1e3ce062e7c918d--

