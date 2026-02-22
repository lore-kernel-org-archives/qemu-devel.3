Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFCFC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAaV-00060B-JJ; Sun, 22 Feb 2026 09:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arunkrishnak2407@gmail.com>)
 id 1vuAVy-0008SP-11
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:32:54 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arunkrishnak2407@gmail.com>)
 id 1vuAVw-0007rU-EG
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:32:53 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c0e2cbde1so5925928a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:32:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771770769; cv=none;
 d=google.com; s=arc-20240605;
 b=YCfIkAjZW/6wEXdVEi5slN+HCTE4kaNyD7Jt+zOue4azKLhri55UzQbcOGRZZxExTE
 rwPdtCyncLeRJ2/aXhw5jMOCTCIpVVoD3QtRfECD70GIgxvU1OOztQmvA4SY5qMcl+jy
 4A4ox0sbOt4sraYiuqjukeIgNoH39m5EYejU/TaPVNXbtC1xhjacUCWrmdL6AzLi3Kye
 E4yKsY/QZ5HEetGNTdvrSPB7GMdBQzxh1eHGsJl2lk7RQefewxlJYUhY+v8NFPgl79i+
 ME3+yqYge2T1Tk+ZPBNhVx45tUwIzEZQA4JSCl8P569qTJb287dl7Xqt1+9eZsZgedi8
 971g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=tDfeZoyFa2hYpsT/t/S9hyAAb3saRAKkxqsZaoel5gU=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=hKrA2YFkNgL8Vd0YuAjvNC/Lji6CmyV1GHSKLLlrKJFcbyi0nyct8KsuvOH6/GTyv1
 vcUbqxWoboOQsRdNmC1DRYETIelkhoN09JqFml5goBlIXInuAn9Sj5xxozhhlw4P/udo
 RxfhX3iI76G7249WLcoFrbTiLWHrCRw3ci/nNVn59sZAz+vfrMK7HFxlgkW5C7Z04MXl
 ziEX86L3Av5DMZziqihmH5U3q6vQ+IetYeN8PLU1b0Skq2Un0/GerCFYBRWBGQllF0dc
 AFU2gVJBzCwUcWXZF+XOmUnsmN147MauHMm6nt6/LKKVoop3zZdez+medd9OFdIaT7+j
 3tqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771770769; x=1772375569; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tDfeZoyFa2hYpsT/t/S9hyAAb3saRAKkxqsZaoel5gU=;
 b=ET0k3jHEbktqJUwwlqIGeVsZHu8VjWaAgcZXNIkEulJ/fPixh+/GBOaX5stIgAWm5Z
 a7DqCozkdMP1kGfmn2+lsuD039OP6l0mJdgemNcFfG7rW/vJ6vfxey9SRWKufFMdjwjS
 ihuAU6qJ8fPtqTM6ODLtm5au3bvmJRwI5ExD6zNsrXq0upNZ4utiShJqrNWid+cBrxx5
 f/+ODoJ/3e6hS4MIQdXu7S4119IEl7n6wRgzvi+CgvX1iK8vCYFjP6p6ri5L47tDa+oo
 jE/PcDpROokMbsy7jy9ZffJOdcp3bzep5VVCWmMH75aiG6CBfamYsamtfdC9MPPGBWrA
 hNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770769; x=1772375569;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tDfeZoyFa2hYpsT/t/S9hyAAb3saRAKkxqsZaoel5gU=;
 b=XYJBMRFfwgU+B9IDvoRcICbfCotakZPx8isQf4WtkgajjeDoTgV87jPvCTQM1f6SsB
 Fg98gVfwVqaH8h5r0RfxAEW7dNSY5pEsZ6FhxnjH6LwygnjsB91TDG1AYEyAmz+3cZy+
 I8HFfIo/gRanngUytfCCM5O1Ak+fKNZ4ifZq4wOfBZvTlSmjUTyEMwN2NvnziFmF8a8s
 NyTm7oZMKBxd60Fgf7hWomTf8vR3tcwrsq/K4IbSZSO1oJg4ZUsWpiXA9mylYP+9TDfd
 9i7W8t08MvyuAx8TlAsn/GB19K4GIT94XYl+GrJiHrc2+861oGU6Tq65aDlpRnnpz7L+
 ospA==
X-Gm-Message-State: AOJu0YwHcZWJSV7tjBX95P4RsPWsWMG73KMyMBn2mGqa8W4G6yhYq6zl
 sFpb1nYqtPGf6RfKkkQhLi6XTA0pEDwdIfWPGHzzP11bqz/03FrHOUgNDAq0kHul2PCNN/BlgdT
 9K14plAj/2MPciD7PswZrE7hcwMyaplUarVaZ9Ifeog==
X-Gm-Gg: AZuq6aJnNdxw8ejbHJJr/KW2ZmKprZEkUrBdgoIem2q5n1VwRhjGqw12ug+NdcPLjEc
 wNgGKqb49O9wHUGgEigkePUuJUuZlyKdmsDaxs4LjORJ24KbyW9WN4ON4G1713E3rhAi96SoDWI
 5NkBPFj+JDB3b4Z+5W33vWf/WAhPlC4elB6RPb0DyrBTryPFxzsNO+lMH0jNPGUp9s3NqNXTk+r
 eG/TAs9DLLUq31mMTbKS6F5b4MUCBO9tus1P4dnOCJhI2V6wb5Utz+9OxFrxCcYvq3LU7Idu8Sp
 uI6IbcIr0Y5hiPfywSrX4nsqTiMahOH+ub47+TCYUL8noKGs7ZKdBeGxdivfzJPQOiriAM62JbL
 lHi6RZRZ5tEYtaitbXs8HUsi0BK/Eu+1nLyVIkinOwICS2AUKeTo7nuthzrGu5VuUxC8s2bzrFT
 AdK1Kt4qM/Nwh8JmDtcgZFvA==
X-Received: by 2002:a17:907:6d1d:b0:b88:775c:bd6b with SMTP id
 a640c23a62f3a-b9081bbdb65mr325219466b.46.1771770768826; Sun, 22 Feb 2026
 06:32:48 -0800 (PST)
MIME-Version: 1.0
From: Arun Krishna K <arunkrishnak2407@gmail.com>
Date: Sun, 22 Feb 2026 20:02:37 +0530
X-Gm-Features: AaiRm50_FVNRhb6CITLRSQnxu20DV1IycO1GnhMjcaJXx2RnN97uZ9ZXVmELKek
Message-ID: <CAFMJydPKfWTMkpJRoLwBZ4jkqfH69jFEsQwvn-cPety04fsnkw@mail.gmail.com>
Subject: Potential GSoC Project
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004ca61a064b6a8784"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=arunkrishnak2407@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 22 Feb 2026 09:37:28 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000004ca61a064b6a8784
Content-Type: text/plain; charset="UTF-8"

I am reaching out to you regarding a potential GSoC project, as suggested
by Warner Losh.
I have been researching potential areas for contribution and noticed that
QEMU currently has several missing ioctl calls. I am curious if
implementing these would be a suitable topic for a GSoC project or a
general contribution.

I want to be clear that I am stillevaluating this idea and am not entirely
sure of its feasibility or scope. My current plan is to focus on the
discrepancy between the ioctl headers and their actual implementations in
linux-user/syscall.c to identify unimplemented ioctls. I also noticed that
the current automation relies on regex, which I think can be improved in
complex cases.

I am interested in building a more reliable method to identify and address
these gaps.
If this is a viable path, I would appreciate your guidance on how to best
approach it or if there are specific areas within this topic I should focus
on.

Thank you for your time.

Best regards,
Arun Krishna K

--0000000000004ca61a064b6a8784
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am reaching out to you regarding a potential GSoC p=
roject, as suggested by Warner Losh.</div><div>I
 have been researching potential areas for contribution and noticed that
 QEMU currently has several missing ioctl calls. I am curious if=20
implementing these would be a suitable topic for a GSoC project or a=20
general contribution.</div><div><br></div><div>I want to be clear that I am=
 stillevaluating this idea and am not entirely sure of its feasibility or=
=20
scope. My current plan is to focus on the discrepancy between the ioctl=20
headers and their actual implementations in linux-user/syscall.c to=20
identify unimplemented ioctls. I also noticed that the current=20
automation relies on regex, which I think can be improved in complex=20
cases.=C2=A0</div><div><br></div><div>I am interested in building a more re=
liable method to identify=20
and address these gaps.</div><div>If this is a viable path, I would=20
appreciate your guidance on how to best approach it or if there are=20
specific areas within this topic I should focus on.</div><div><br></div><di=
v>Thank you for your time.</div><div><br></div><div>Best regards,</div><div=
>Arun Krishna K</div><br></div>

--0000000000004ca61a064b6a8784--

