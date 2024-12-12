Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B91E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjxL-0007II-E6; Thu, 12 Dec 2024 09:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tLjxJ-0007H5-BX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:14:17 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tLjxC-0003BE-S1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:14:17 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5189a440a65so359048e0c.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734012849; x=1734617649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EshlF8TL/2E+HqV4QLS6PY7Jyk3dO/uKpFbrw41jZhY=;
 b=ExtG519T0MrFQcuD4mdVnk9gy0XEEe+MguMO1JI6CAWE/Mm3VNDoEtKVNJR31fUOAc
 EicQBPwU/WWStKfQEOw7N/x2DfUvY1ZOMzU4mH0f2tmZg2kALN0de2AyITqcS0xP9kYy
 uEtzz0N7/0gdN2nmDD1X2vukt1GtmBAfgeCX7zYxWGP1BAgGFo5aWNiSlds5w3J8mY9n
 cYynRXZNE//512DCN6/r2kDy+FE7bSfiAWTn3lIcFS/wFKnR4sojuvfw4U3uSBidF39O
 IwvU2xT6nu+eOlX5w+fk15HgX1y2NxG8JMhzuW12FnZFyAPUYxWsTFgKvrgVafIxtb5t
 XtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012849; x=1734617649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EshlF8TL/2E+HqV4QLS6PY7Jyk3dO/uKpFbrw41jZhY=;
 b=QxPhThokK7gFgmCTxg8YnTo3fr4yM/SrsYuKDueCGvjVhBbVgxJKSDzwBTq2Qtuw8X
 +u3zFM4Qp3q79eUz3oOjPp6hUBLzbeKclhfFjOpJUvhUy33zfOY2cZ3En8QkkN2etHfj
 3taoJG6moggoRMWZUuJwEEcMeyFpRyvqSWDaDqxTdgck0D0ochKtkdeM9J+S+HoYzGyK
 TnBXKokBW58uA0tQkf8lC/qlRJYZEp8iwSLxE6Opce3biF5aXHLnJkxWEF8sAVO3i5qI
 aolK5rwW1n7SpF4nLpLsdiwhpo/ZB1nIWS2mV8Xs/ve1kTU9MwuXwUzkc9eKnM8EWrko
 Ds3g==
X-Gm-Message-State: AOJu0YyXT3+vcpWCfcgPcTWjXhImPg1tVEboQpb+kQxVuQ4hNmqb9/gO
 8+YfNEleGnR+86OXLrW6W3aOg4H57GDUNIdJqf1fWZY242qBdwY0hXwZ90+ZrIxSfnctyJKpBdJ
 KC2wdLkcIrj8Ojybhgn0H9S6aieQ=
X-Gm-Gg: ASbGnctyGVegOl9E5W+/TQ/qaYJxygDBA5cTG4+qvsdBaa/WBv90hGce0sIaBpH8GqZ
 y6OoMp+e1VQK/vXXBtxsJTdSif6Mrt+g5h5ttq/q2
X-Google-Smtp-Source: AGHT+IFdSj90bpigpHM9/SoEIuIZvJjnt68yCMRpY96UqUTfFZmbTSSOiCgQqgSlD6ycNN2TDZjwVsRHJPuHkHjwTIE=
X-Received: by 2002:a05:6122:2018:b0:516:2d4e:448a with SMTP id
 71dfb90a1353d-518c57506famr869031e0c.3.1734012848927; Thu, 12 Dec 2024
 06:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20241211222512.95660-1-graf@amazon.com>
In-Reply-To: <20241211222512.95660-1-graf@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 12 Dec 2024 20:14:20 +0600
Message-ID: <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
To: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 12, 2024 at 4:25=E2=80=AFAM Alexander Graf <graf@amazon.com> wr=
ote:
>
> The documentation says that Nitro Enclaves are based on Firecracker. AWS
> has never made that statement.
>
> This patch nudges the wording to instead say it "looks like a
> Firecracker microvm".
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  docs/system/i386/nitro-enclave.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

cc Paolo. This can be picked up for merging along with the 3 other
nitro-enclave related patches from me.

Regards,
Dorjoy

