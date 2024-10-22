Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8295D2C56D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gpw-0000yD-So; Tue, 22 Oct 2024 11:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1t3Gpu-0000xN-UC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:30:19 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1t3Gpt-0005wa-BD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:30:18 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-28862804c9dso2549079fac.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729611014; x=1730215814; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2TNLnfd2oFEQRQR4fa45cRVV4srtwKMBCvJfOSUNmAE=;
 b=m4k+LSGc96K4njnMbPUCpjBqIiNvNKK/494CowuWtRg+G1fYLKTnd2A3kpBthoh/QI
 elgkdPWFBBo5K1dqTrWuokP9tDCzqHGMT+4670C6L/FaHQrivGGA1L2tybnnlQhZYphY
 ZxMXJsSFxPHrmYHlT+JSdwg6Ul3hQ7HMtKg4Uolgr8vAhD4RdCcO+r7Q/oFFV31x8C3U
 5TSjQuqMSq8u2/QK2fEX96mnXRTWH0m+yA6J87URGBGBxWSSrZ/lgPu9wkyZAmyJUK2g
 fUFGsXmQgXBU+uKuoYttFlPCpZBktaOLm3wPgaKXMkOu8abrdNNQfaGLxLJx09YxGBjL
 AGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729611014; x=1730215814;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2TNLnfd2oFEQRQR4fa45cRVV4srtwKMBCvJfOSUNmAE=;
 b=UZo713t1KGrbhBcO1T24c5gqWzMu4Gax+vBn10+hKEUDZK7i3rcaPpQedrjT32froo
 m0UbDlPQrDo6Dj9fqMxf8hoPOks3RWsOdE+gPbZ+eDopO544fd03SK8iSdYvY7BpTTDv
 3siq0sd8xqGn+Doe2d/dPCz50uvaHVDMZov3ClsaNvN1h4GdDPt6s2HxuDE/QoRZe5y9
 +3TYh5aGYHYp/C3OyBjhGyOQXABg9x5FTShbvP+5c+emrSn59HK1CR4SxvZMloM1aV9+
 BGoziX1ICheqlGU0/rSB09N3xQByTO2QFvI98Wf8Mpm2YZ0e0i6UML7TWyEYiRci8Y6Z
 AVww==
X-Gm-Message-State: AOJu0YwST8VQ3Q9JgFHnOWv58KNGw4k9bInZQenSAc8LfQsH3XXXmsOg
 0bZ/9X0TQQglx737XVZkQZObk/TVPihDDeZKyB/NncqnpbRZTLfmDl6zuu3GEqYh61oJV9ABbK3
 teM6qd2XIJN3z3tX7eY9ZX6hoOQ/4OA==
X-Google-Smtp-Source: AGHT+IHo3A5AhfKWtFbVa8JY7HGcedCKyvXn8mVIgxCbt/aZYIaGcqhH9/7ZhyJVqdOZlnWL5AUbj6ed+u+anYXOwhA=
X-Received: by 2002:a05:6870:d10a:b0:277:d8c3:b539 with SMTP id
 586e51a60fabf-28cace95fe0mr2113472fac.16.1729611013718; Tue, 22 Oct 2024
 08:30:13 -0700 (PDT)
MIME-Version: 1.0
From: Sam Price <thesamprice@gmail.com>
Date: Tue, 22 Oct 2024 11:30:01 -0400
Message-ID: <CAEekfLZyGKsa4o7cEStbbXC6nCa9jFQmzm7SVcT_Ct1DwKC32Q@mail.gmail.com>
Subject: is there a guide on how to add command line options?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000128b6406251272bd"
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=thesamprice@gmail.com; helo=mail-oa1-x2e.google.com
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

--000000000000128b6406251272bd
Content-Type: text/plain; charset="UTF-8"

I would like a command line option to set register R5 for the microblaze on
boot.

-- 
Sincerely,

Sam Price

--000000000000128b6406251272bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would like a command line option to set register R5 for =
the microblaze on boot.<br clear=3D"all"><div><br></div><span class=3D"gmai=
l_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<br><br>Sam=
 Price<br><br></div></div></div>

--000000000000128b6406251272bd--

