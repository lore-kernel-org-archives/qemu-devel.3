Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hpJLepmN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNiOo-0003Zn-5P; Sun, 01 Nov 2026 22:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNiO8-0003PS-7P
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 22:07:15 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNiO6-0006XW-FN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 22:07:11 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b45f9ec1ceso2787407a12.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 19:07:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793588829; cv=none;
 d=google.com; s=arc-20260327;
 b=RFNvYiX9kOXuDU0eg+xQGEUAtvd0Fo/1J50retEMFnCBldiKun2QyA0Q934RMFb4dX
 k3JYOyePZSVXf/Xrbj/+BGCJOl7qLVgfqNi+5zzQWcBqXwgpv8H6kSfEeoA73m76J2z7
 0XlhIEbRs/aUXcpPl9jkIKj0jMJq9/FrDmOFo+piu9LrY/XFjUx30w2SBCaoDPdJM87U
 M4em1GmZJjiu0DD3/mH3zdyac9mSVGhoeR9nzu7EHYPu438C1YT7UjmTMZXYy0xlvpvM
 x1XsE+fJjcpL+/YwP0fAbPIX8QKZJlAQVgYIjkWg+H9sOgyjPEe7j+dJ6sMfNOZ7pReg
 /rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Ysznio8LIhbrNhMwmFi6gLvF+hQtGM6cCyNInXytu+8=;
 fh=C+7UfJv7ykF4HVLOJNADqAxDSwS/2UxrtliflcPOWD0=;
 b=FvgtZZBWw6qcNHTQkVnlwBvSJE1nesWH2xwOaPSnTKQvoYRrpbcctbXxRr1lniSZGm
 B7+JblDI+bEv7MGnEvrmQuBg3ACdqvwZV1B2DfTVI5pIzfhEjkCpxhDpSMM0K72/Mp3q
 JuvYUf/Kzjls4+1DKnkKy9Df7q0aQoIPRapE2+Yj4bDdXVpjsiVs5Teir4uk4Gbv9Frs
 4KE4KVha9XxWBuyiYu8aRgfplr6g2ev3JI+rspaX68pkiBT20RncIquf2lE/BksNBQIx
 n8AMscueSisaM8kieHqcZlAJmT3fgG45wjf16hnlwARApybibtZgYNl+o73EfV3HP0vh
 NQLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588829; x=1794193629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ysznio8LIhbrNhMwmFi6gLvF+hQtGM6cCyNInXytu+8=;
 b=hpJLepmNZ53OfnTaTdaqCJFdvjqxmMdPpXZ85NXafyHEQuGdxaLvWWX5e2L9lDucyU
 aO8qLQnHgVxNgleHLJextAo5xqdqXT8v0aTrovKU089OMiHzIeD1baO0R73QjNIE67gA
 nn8mk7aCSof0DQ8J83zhN9zLbD4UE1nZt4c/hKFGXpuvuo/kRZam27n2tsR35suL8HkZ
 PoM3bD3h1r8NRBctdXdQKyZlecilcbskeYRBa0NXR+agDjkrEg5slvXo4F0hKBbxDbOL
 +o/hyAx08c68aQ5copx/hdT5UbESdmIRm71l3dzEz6fGfriXy2/99V/OlSFXW/g6/H8K
 tdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588829; x=1794193629;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ysznio8LIhbrNhMwmFi6gLvF+hQtGM6cCyNInXytu+8=;
 b=iPBS67tmw7FZUe/KYsdY3j0ELm4X3/rxroFGTgRtnU5QoZg4n43hu8pwLP01yLuJsp
 9Ah1KbRR5pnDgBfvw5yoV4Ddkr18l3qzWbFvHy6h6FXQ4uYSQHdw9ifOiZ01zyHwsKDC
 c71KuzJM26+eYQH7BMtMQ7zCZbqKvb5PEAprOiaVlNC1rdnoeDpxtdDwGjjZTgwyM+V0
 OWXaCsY8KzOC2DVRCUXh1n7/3XyyB5slJRTcb/v8bKNmlXhljZGVU75mhR1NdQ2bK+Xz
 grQ7lg4vt8BayJrZIGrOnyYyrw6VbupDy9XdGX/oD1bheyhVj000/61gT1ri7Mk+/GdF
 uq9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgTKzrVZtwrP2DvxjA4HCdo6XVG2bd0K/AY650yhdvRd/3vsQaupJNeOu2UsuNsss3V2/uxMnBIPvf@nongnu.org
X-Gm-Message-State: APuU4Z9PmXr8t1bdJc5oCa9Pedk24sPtdNv1d+kBVBw+WZswj7GToyr1
 YTqF9yFWV8lXc8Go/vUexZCLYR7+FvtcGoQayke1QkLItyGJfgl/hkr/COFe5XB+VUEw3mZ5off
 LEouM3jWkL9QRdO4D1X09aQLKhmuO5wM=
X-Gm-Gg: AYBFou2dLFtI2+ZS9EJwAa92LvqSQ9Xq4Ykbm69zCoPz07BTKjETuuc6g8IPUkVVCHV
 CqsRsW8j9Gh2gPeIUtB33EJ2mGdmkzF7XAG2r9WmYSqS5VwSNqT+0eRWYEoxHttC8VVJNdSHB3N
 J7rvc2J9pGGUefMUxFvZQk5+515MPdMIiFk1MEXBy+v8gKE+y1levm4aHJtv88vQRBmKVcbmxnX
 EeGuyektV/zmS+AkhvJl0o/bur4UIjLqeYCX7oi4ZHo796toFrC/Olq67n+Y0/TYPGramZkStDw
 N89aAK+kLqiyx2nlz/T2TVOq5fpg6m6uc+GQDQJaYMkBpJW0Scd0NoiJRd55pOzBLv32rPqnTh3
 76hL8AQYi01FoIZSoT8HP+wi01Ql+9GyiQz1E
X-Received: by 2002:a05:6402:1cc4:b0:6b1:c774:58c0 with SMTP id
 4fb4d7f45d1cf-6b4d4d812f1mr6163810a12.31.1793588828434; Sun, 01 Nov 2026
 19:07:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <ba106173-fca3-6019-3028-122831887921@eik.bme.hu>
 <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
 <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
 <CAE2XoE9_b5UiE2+BXFRqB3RPv=M+8jr1HQy7rEFVEb6w1DdoGg@mail.gmail.com>
 <a479df5b-721d-c357-5c69-c3760a73e521@eik.bme.hu>
 <CAE2XoE-2w3A4=BeskGgp7NYUtkRVNkNufu4SZjW_OQ-KAQZvhg@mail.gmail.com>
 <6efa9f73-75dd-efd0-3fd9-6b2654b69737@eik.bme.hu>
In-Reply-To: <6efa9f73-75dd-efd0-3fd9-6b2654b69737@eik.bme.hu>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 2 Nov 2026 11:06:55 +0800
X-Gm-Features: AclHuK8P8SDKQOupp80GFDOIHp3NTFl6EuHgXjfpXxX0vFgO-CLq7hQlTWSRT8g
Message-ID: <CAE2XoE_Nf0bpoyYuW9G_OWAx1J83iANRf_=2vr4G_BqgRZThPw@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, 
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 4:57=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
>
> Is this conversion needed for all machines using all DEFINE_MACHINE
> variants or only some of them? If the latter why not convert those to

The is_avaiable add/remove no need all machines, only a small number of mac=
hines
need touch DEFINE_MACHINE, I'll do(expand) them when needed.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

