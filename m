Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C764EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 07:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSuZG-0007uR-K2; Thu, 25 Jan 2024 02:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSuZB-0007u8-8M
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSuZ7-0005Dn-N1
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706169264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=3GMv1D3+QCNucXmRriHeD3OGUE5G2x4xAYPTPQDKrrs=;
 b=a35O5Hh/xZNUgvmjZI+pcSEBjD0guwxHia031Rz+Qhe3BGPnl7MhZLQn7NSyiMJyrSO5F1
 /ziWE6pqD2pJzpBHlYSsdfRWpwBTHPW5wfx1Iv2D8cCuuQRxcJ3Rt5/ftYKP0VbEWURApc
 kyfeO7aZmD4To44ZK5YvyANecf90o+U=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-NlLgCtEUOjKEUpu5jGmmrg-1; Thu, 25 Jan 2024 02:54:23 -0500
X-MC-Unique: NlLgCtEUOjKEUpu5jGmmrg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-46b17f53ec4so97509137.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 23:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706169262; x=1706774062;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3GMv1D3+QCNucXmRriHeD3OGUE5G2x4xAYPTPQDKrrs=;
 b=nptwRG8IfA1jDbNnhkk2k8A2wRNQe44NJgJACxRcKlKhWqipJ1+rgQ0k/3dabn/aVl
 O0ICTDR8xTkSCWG5TC7YcPzgco3xfqWufH3HK/KIcC9vFNjT4EGH3eoA0ZDB5QdstY+H
 wkurTy63KhWrxkYfAZkaqkncpHShvF8gDAjOoWWWVpptIFHgil0CW4BPmlvhRXeF+eAc
 jAtKhTmGT7uILFHQ1wX5QPWIL1fxN2CmAqWQN6GTzhhfEO/DSV96ty+6y4YMvzofdru4
 weuZrFTzDRk6ukavffWoVP9SpwNhboDoqtNaBWC0caI5zP9gl/59pQuQEimHMisYJGBz
 xRtQ==
X-Gm-Message-State: AOJu0YyCf0Fnu5rgfIlLwcE2pZan0eLurxE9PfOfedWnwSJv4X9PTIRF
 ee69Q2oPs/934Ko50UW9WN5A98Qtjtc66w7u1CuUNnnbmrxAM1rjCaS/tsfP0cb3SY1cya0WqZu
 C/j1CPua8igXxIjaJK49jNXCqFvnMSELsEXsKu8OYYve6Yz7uOzMVlcWG4hi6xi7CicmicfvuI0
 EqkLt2N4mkaLcFRB/HGDu21J3jfN6IHzzPbl0=
X-Received: by 2002:a67:f553:0:b0:469:a5a6:6cee with SMTP id
 z19-20020a67f553000000b00469a5a66ceemr411404vsn.0.1706169262214; 
 Wed, 24 Jan 2024 23:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzQlnDEEn9b4FUtA4IuQNvy7tdj9gFk899x1lrPGj0TNikPpasa9FqgyBAQGNw+4bpCnwCsPCz88gL55v9QvA=
X-Received: by 2002:a67:f553:0:b0:469:a5a6:6cee with SMTP id
 z19-20020a67f553000000b00469a5a66ceemr411401vsn.0.1706169262010; Wed, 24 Jan
 2024 23:54:22 -0800 (PST)
MIME-Version: 1.0
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2024 08:54:09 +0100
Message-ID: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
Subject: Do we still need pre-meson compatibility hacks?
To: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ca0469060fc07cef"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000ca0469060fc07cef
Content-Type: text/plain; charset="UTF-8"

Right now configure contains a couple hacks to preserve some of the
semantics of the pre-meson build system:

1) emulation of ./configure by creating a build directory and a forwarding
GNUmakefile (requested by Kevin)

2) creation of symlinks such as x86_64-softmmu/qemu-system-x86_64 and
arm-linux-user/qemu-arm (requested by Peter)

Neither of these are a lot of code, but if people aren't relying on them we
might as well delete them. Do they have any users still?

Paolo

--000000000000ca0469060fc07cef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Right now configure contains a couple hacks to preserve s=
ome of the semantics of the pre-meson build system:<div dir=3D"auto"><br></=
div><div dir=3D"auto">1) emulation of ./configure by creating a build direc=
tory and a forwarding GNUmakefile (requested by Kevin)</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">2) creation of symlinks such as x86_64-softm=
mu/qemu-system-x86_64 and arm-linux-user/qemu-arm (requested by Peter)</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Neither of these are a lot o=
f code, but if people aren&#39;t relying on them we might as well delete th=
em. Do they have any users still?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div>

--000000000000ca0469060fc07cef--


