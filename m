Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E2606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nl+0UGAa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4dQ-0003UY-0c; Thu, 05 Nov 2026 16:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xP4dK-0003UG-Cw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 16:04:30 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xP4dI-0002eo-PB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 16:04:30 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b56c3677f8so2345975a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793912665; cv=none;
 d=google.com; s=arc-20260327;
 b=E9P0TVwhOWuRdL43bMxMhO6A73MUJ+NOqEhEvtN5lDRaHG47jYyiCpwkxXi5JRZWI3
 iHNiCMNd7/72lD6jXoXqnr/UahbOiknHXlpV6A5C9bsJ0+nS0POq70euYqsecdRWofuW
 yQqPPbspph5K1ngC6OxP5K24/MnyRJcDX5/3IrDUl3CYxJDVel/Vqj8ix7TCQQwcSX1p
 QT8gyF7SG/y8039d7TgkNPEa7Ry5+QdrVDPe1WJRHxjEfXxUncG3Od9dfZvAGGdqvm5j
 s8vnT+jBTBokJ1IXuTJOUWRz5mNWZvlorIBEKJJ1nw5Nfy/M++zj87y83hDy7Qenhgx9
 1pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=JDJfQiosIkKg0Nim0dHM2KXrqf6rEjkscYMM+7IB690=;
 fh=jfRPEWUvAyU2i0kH26gvrAMdb/xRh8Xmg2a60lkgoTY=;
 b=fZD6M35ka9Q8AcPNqR6pPg+jEXjNzzx1MBmYQo/V1sSRWuOYN3RfnKpoMZ85+eWBin
 WgSwDFhnr1/b7bPLgvy/I/2r186EnSXCX8Y2rquLpQGWVVxM4XJ8law1mnDADebQRUBK
 MGbS7o+iAoNCNfecZY+Sscrg91JewUik3p2xhBFHkG/QaVbQ/VvDoiLErqoaqbrdLZSQ
 qwrIVRZgTW0cYXRpDlVujOgvV0sQXOml/WTiRcrOMR9nRQgTPlIh2+vOr25shhkrzFCO
 o/tum/evQBe+pdoEve7z8wCMEAKaau8BmRZtGA/KUZ/uGlDt14qHA1P+8X2MgA+f1Cel
 1WvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793912665; x=1794517465; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JDJfQiosIkKg0Nim0dHM2KXrqf6rEjkscYMM+7IB690=;
 b=nl+0UGAa+9BOVEPHYoYJKKkpPbiAZhf7u5oRo1qH6A2c85xHr2HAaa4vs7AkQopCHf
 CxO9Z5Xp4qweX59bzaLOIrzFHrgR989HM+hup2D8VRv+7O4HpRbLxdIOcpFnPhZ80kcY
 dlslc8UxLfe7TtV/7YUbiK9BSkgEpiY4qp3YYodaRqAWphEO4jqfKVPTF6vOgClW+Z22
 qWFWvoflGZXugZ7+25UPZERFi16T89oWgupnRGzvlBG+NbYhE0r6GX8od6GN+px4Dr0m
 jeux7nJXwpj+GGBwOQGuq0QpQyQ+7ZXJjz0hatUigA0dCpSkn0V54X3ck4YhB/jTpefI
 uk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793912665; x=1794517465;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JDJfQiosIkKg0Nim0dHM2KXrqf6rEjkscYMM+7IB690=;
 b=dO63YPp7USI19WqAQ2L5t5Jlke+azUyEmpIN5NBayUjQ/cpLDm6rlqSudHiNRfU8T0
 YSbqmd1ikOb5CLrecSQ701DIiEiulovqRUxsEuyfB/vp0Dy5iZF8XAY2nhm3rCbH8088
 SoPIlZ/7ZtgCGKvWTVahKdKN84BbyfVoIG2t9pB9D/t9JjtogJHXsE1vVT42isfA1PwM
 r5XumxU0QhjbcNbxgw5mQmuj4gGuNpJG9Ym2uEpmotnqXqFsPL8gqrga+9KBRSGYKv7Q
 b5QX3grY8lxg+MTLIuSeyLTK6vh3eVtWB1i85TFaLBM3XJYV/nHq6ZDJhg8mog7kkM1K
 VZwA==
X-Gm-Message-State: APuU4Z+JoGkUoUE7zzY/YRHD6lPT661vkuWtnEN7PN0nQxuhKfxIPjqy
 LDW3dZ5/Ml+wh8lLqzlHiHVGTWSzLJno9GyP8mWQJWOHbNGXRTZ1j0oxPi+nm3Vxny7ziZ1+Bv8
 9wpeeMqcrnFHKSTHRAz2I5xPUXsZuRt30nqn+
X-Gm-Gg: AYBFou1S2bxKFuhzbIjpU7XqLm9+uh9vh4nIdSKkYcEX8+1MxjAygaRgSSd6bHnlSXM
 z3GGJuye35Txx491bpmC2GJRM5UFmg9pE+qMI5BknrJPtrtfIvYafAQexoFt91Y0N1l70u6iKvo
 n+uFXEhf7hhLx0XKB5TxiV/XJic5YSdvP8lEkSlID+vwtOJjY8+bgJYktlEKh4SiT8hQCdXIY3v
 xxVyO3o+VMVvXsERssUxsi7r3oi/9cGEI7xjOxhH9vuqnntY9Wsa5RgpC+tUdEUKXiQlu4eJzYj
 +y31K0Yz27ocXI8IaE4EltYnojuiPxOzM24GKMnFpwxr3Ww1hR/tXAevQUsO/vzrWbHfpWjUXc9
 DpbNTcgWjN16M4+G9EFKjpr0hu3gYVG8pQySLxMRhgG7yT49UFZXHUnm5WmN6rAke9Mw2QQ==
X-Received: by 2002:a05:6402:1f89:b0:6b5:7770:ce2d with SMTP id
 4fb4d7f45d1cf-6b5977e18c1mr310582a12.26.1793912665199; Thu, 05 Nov 2026
 13:04:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Nov 2026 16:04:14 -0500
X-Gm-Features: AclHuK8LwrsQt355zjJDbMFTWZLvA1Kg8r_KwUwfzbWdfhmveI4ka8T9MfOxea4
Message-ID: <CAJSP0QXzingvqA1F2q-QH9GvtMz7YpxDK9RsDEF5JMCE6vA+Hg@mail.gmail.com>
Subject: Pierrick is maintaining the AWS GitLab runners
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,
Pierrick has volunteered to maintain the AWS GitLab runners that
QEMU's CI depends on for x86_64 jobs. I have given him access and
updated https://wiki.qemu.org/AdminContacts to reflect this.

Thanks, Pierrick, for helping with this!

I'll continue to handle the yearly Amazon sponsorship applications.

Stefan

