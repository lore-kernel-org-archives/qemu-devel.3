Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B30AC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1lxw-0004wq-Us; Mon, 07 Apr 2025 08:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robotika157@gmail.com>)
 id 1u1i03-0006cI-1l
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:38:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robotika157@gmail.com>)
 id 1u1hzx-0004YI-34
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:38:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4453049a91.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744015105; x=1744619905; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Lf0tjV5h2YCQpiVs0aqfqoycyicodWYZaAE5AEJ+L18=;
 b=lPpKQy7ivUMLv7X22x8RnrzH+xdoqA4YT+6vLZ6gbyMyiPG8Z3857VqJKPNdKfpB3i
 vADDDE8YRA3Du9T+xu8zp9WR30yiQmd6U3V6SwsP6znJEtr57FiamKNHQ+caJ1Q4JTOi
 0r3vsHjayUs9WKSpfElBSTd9Wes2L331ZNWAO00MLxxd6ckP7LMo6GkvKauqZYbDOHhe
 NpS4iLC2aK8r167ZmtzLOOLdyJ9zs2GZtUejWqVkNPk4gw49hHjg24fk9IinwykiOfuD
 4HV9EqchoKEDuC1iLp7z2g0miMadUdNYh9KrfX/2z76ggH8APdUj/PJWqujxNgqe3HDT
 Lmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744015105; x=1744619905;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lf0tjV5h2YCQpiVs0aqfqoycyicodWYZaAE5AEJ+L18=;
 b=GD9AMny8qDBLehIhSlkzgEyPK6zaJhWZQ2VJQtzNhumQc8XTPbsT3fr9AbNkR6mnTy
 97Tf3qVaI6kuzMVVC679+Qt7gPn2O6xdZRAJLnjcrhV2GcI8951/q8ilmYq0mQx0dB0E
 IjogHmuaq3YjWH7+Et62aiw2XPEApPxr0j/Rvfb4pxzmq7GpUDhmb6t4nnonZyPubOuE
 NEAoWb/ru8kM555kE0agsNJGf0qdp59dD9/nT4pFP28rq2nMPhStz/h2+F90W2pDBtA0
 Iymnyukw1qxHSOKWeGhDZuJXflKDWD0HkINU25LvtYHiRfHEWXC0vrCUiKtDxdAa75mq
 IA5A==
X-Gm-Message-State: AOJu0YwCOq2bsjj5jMYOrjYFLuVjMn+pRHrp51kfoLya6aCFXlDsqWtI
 64vXodjD44LpZN+ANrgIXGZ4hrkuEAxpNUbp/yTQMWoZhvGOOtdZarA7mtXak613RBFfBYgEozW
 xnNX5EzmllHn+xwN7ocUrFNyF1ZPcZQ==
X-Gm-Gg: ASbGncubSy4Us4kHZa39egLTRzi9YPLo1UFzqhV5WEOkG9mQCnjEbItIZ0A2zkGXbVt
 bIToF0ybu9YgyszLNyeGQ9c5CMZO1VioDxiAG0eOb1g3+OJW59CtBoY1Qn1pcMYtEE5EDWwCt5F
 XGRlVszFnh2dMUI/SVd7AA8hcBlA==
X-Google-Smtp-Source: AGHT+IGurO3OtIAOn6rPzobaH/8fqqCP3zIudR7Hujr4dysWCEvwwwWSBS7WKyGXYPND+9sw7eTz1b7E1VtcY4uxrz8=
X-Received: by 2002:a17:90b:3a05:b0:2fa:1d9f:c80 with SMTP id
 98e67ed59e1d1-3057a68c74bmr21063671a91.17.1744015105143; Mon, 07 Apr 2025
 01:38:25 -0700 (PDT)
MIME-Version: 1.0
From: robo tika <robotika157@gmail.com>
Date: Mon, 7 Apr 2025 10:38:14 +0200
X-Gm-Features: ATxdqUHxFGufcBLfZaTjbVegfHCRBnUlQ7bbuNg3T-XaO94EKxfZjOlHz3_o1mg
Message-ID: <CAApcxfJo8a7cHfauXQQ-3toeLsg3RJTzy1rPDdMYZHi=50p7Bg@mail.gmail.com>
Subject: Tape Drive Emulation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d33c7f06322c2861"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=robotika157@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 08:52:29 -0400
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

--000000000000d33c7f06322c2861
Content-Type: text/plain; charset="UTF-8"

Hello!

I was messing around in Windows NT 4.0 and when i tried to back it up it
asked for a tape drive. After that i tried all sorts of stuff from
emulating a generic SCSI drive to modifying the registry of the OS but no
luck! I would like an easier way of emulating a tape drive without physical
device passthrough. I admire your work on QEMU and hope you will read this
and develop a better way of tape drive emulation!

Wish you all the best!

--000000000000d33c7f06322c2861
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<div><br></div><div>I was messing around in Windows =
NT 4.0 and when i tried to back it up it asked for a tape drive. After that=
 i tried all sorts of stuff from emulating a generic SCSI drive to modifyin=
g the registry of the OS but no luck! I would like an easier way of emulati=
ng=C2=A0a tape drive without physical device passthrough. I admire your wor=
k on QEMU and hope you will read this and develop a better way of tape driv=
e emulation!</div><div><br></div><div>Wish you all the best!</div></div>

--000000000000d33c7f06322c2861--

