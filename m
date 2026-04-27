Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D6FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRb4-0005Sx-6O; Mon, 27 Apr 2026 15:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRb2-0005Sn-PG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:26:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRb1-0003mj-1L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:26:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso98723815e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777317977; x=1777922777; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ax+jEJG+4aNV0XLK7AoyecSMq+lQMKnzIp/p3AVDwdo=;
 b=a0rZXu6XlEdWIA7YO5bb9RfJ3eLSdrbw/QL6UaME924iBSTzMiGgZFePTxDeykegBM
 YkQpg19qdUF9MBS9LknqsCIvumq7+3ch/rfOxt0mmKVw/zwb0vOXUiZQOtat2VStdE70
 XiC50X43ZDBwxL88cEkU1TqQj5iry5QZUo1K/ZZ+UDl2ASpvvdQNEVvel3DksqUWBIoW
 X2As1cvN/oer86vq3MrVWtHaz/6jOEf8Zkg/tmTZzgNgOapwp1VoeOzxbTQusayoOaHO
 M2UeVMcE+Hx8w/g3pXpHowziEea/6F1i/OIfZWXFxFSp6NqZuDa4c40OiFD3m0isx0Zs
 Z5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777317977; x=1777922777;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ax+jEJG+4aNV0XLK7AoyecSMq+lQMKnzIp/p3AVDwdo=;
 b=LgQyyZkAm3wZ1N1+bNL+AXjwClFqY4wO3OvoKuz9S1mcryKpk+BZY/F8p5Lwz76lE/
 RRKG90zm9LzRU7LLcdQdSrSRo1TWIxTvkOWmGuGn7wKDLQJrm02Vwy851uOek6MPLUYf
 0okbFnIx5gaK8KNaD683TuyeKtZ9E5wrX/LvPJG35qC2SAEhF6oZjrE5bm0zSjjtV8qQ
 Z/bQFtUGL4UbOmqrd/MvbsspFyRSlZa2hViUZPUuz07aYHa+JDNUfFSN0G3WP6ZrGlhr
 Nk6Yr6s3T0jvdY0Wn0Axt/VpUkFe40BYJAfJ6yj8VR8smeuGyx7pXuS3qjBSJd34UZbd
 RcBQ==
X-Gm-Message-State: AOJu0Yy7gx3dYMuAXIglAnAxYyTAhLgigqLTqZzkqQwtXVAlqc7EmFoC
 FdFLf+LaMVlN/mkak7bbEf3MoQNBgg97H5XBAy3Aj1DBblrCuw6Bg6Gl
X-Gm-Gg: AeBDievmFEermCaPoem55ARd9gbEA3C9Co5lSa6e6INuaigpRAWcYt371U6Qr9+FHxa
 Prj4JehPBAPv4MuOkFZHIrRunCe/MdLPgiBazQey1hc6Zwv+obJJrg9p2iibsMg9jAiecL22MVN
 ZpwGH9WguF4oVxX9m1grS/doPfgXsXLDyU2DD6UP+qB37WeSATkeO9uLsDhKDYN7pWyiCC8YOEl
 lTHUW0Y86Eo629FJLP3E75hp24H+7t0DhnuSA2xRXuODHlFL5XlF+LxlZor9oRCHE/4gtNB8Irh
 MS9XTcWy5tcSZYnzuNKL7ltZlGmT/GVD+8Uh8mgsSX3+oz5eUTlZ8o4lz87/TIobsYXyhz2bxFY
 2dZ4JN1CfKv43TqjYs8QEbfRj690MrDe09yZEyVgOUS85ImsA5Ct3nA6KJV5I0+FgBwDYYI4lXJ
 30Htbn96jXsb0QQkFc9AjROSX4cYnTjCvim+np825e
X-Received: by 2002:a05:600c:a103:b0:48a:761:57fe with SMTP id
 5b1f17b1804b1-48a779b1e37mr969925e9.0.1777317976680; 
 Mon, 27 Apr 2026 12:26:16 -0700 (PDT)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775defe4sm4750925e9.7.2026.04.27.12.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:26:16 -0700 (PDT)
Message-ID: <96a72d0c9fec24f3c710ecacfe8ab36e2d006d3b.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
From: Jindrich Makovicka <makovick@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 21:26:15 +0200
In-Reply-To: <CAJ+F1CLwkT9EJLFNDoW1Z6B7adrL=hr_3xUHE9m4K9K1AG=WJw@mail.gmail.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
 <CAJ+F1CLwkT9EJLFNDoW1Z6B7adrL=hr_3xUHE9m4K9K1AG=WJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x330.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Mon, 2026-04-27 at 12:52 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi Jind=C5=99ich
>=20
> On Sun, Apr 26, 2026 at 11:53=E2=80=AFAM Jind=C5=99ich Makovi=C4=8Dka
> <makovick@gmail.com> wrote:
> >=20
>=20
> Could you review & compare with the previous lost patch ("[PATCH v4]
> ui/gtk-clipboard: async owner_change clipboard_request")
>=20
> https://patchew.org/QEMU/20231206142243.510068-1-edmund.raile@proton.me/

The GTK part of this patch is basically my v2, with both paths using=20
gtk_clipboard_request_text .

Then there is the serial number checking I am not familiar
with.=C2=A0However, qemu_clipboard_check_serial seems to require info-
>has_serial set to true which is not done in this patch (only info-
>serial is set) so this half of serial number check is effectively no-
op.

Regards,
--=20
Jindrich Makovicka

