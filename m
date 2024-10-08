Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBFBCED266
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 05:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy2aa-0007Pr-1K; Tue, 08 Oct 2024 01:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy2aY-0007PI-1M; Tue, 08 Oct 2024 01:16:50 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy2aW-0005dw-Ii; Tue, 08 Oct 2024 01:16:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e9f98f2147so1507833a12.1; 
 Mon, 07 Oct 2024 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728364606; x=1728969406; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4usHwfkRIDlgmuAY7IxnQbjJSY0Oadp0F12eznaDMR8=;
 b=iDqkRc3hUSfl3fcIKs4EkU8UFkOKA+7f9TfedKjVU2DvHNibUEt+wsmf7luX2stFRD
 T6d0P/BoCI1Ax4a7565cgSGD01a/IBp7JypVi0lO3XFsb/Ao6Bxzm3iTl6VV8js/oP+Z
 uMbDJevDLaNb6eNY9yTfOcc0vVbK7HwvPZRCk76MQ8q2UPtwLH1VpDZDaUxBwq5vHk4C
 K+bvAy2VvcoTnV9xnLaoLVPWrOvM5KfGYzSw+epfpAT1YjTTThO/o1QVuFTQ3VPalu1N
 7oC9OwT4nkDY+KAN/FV4HXPArBAyuOsQeYU5S7RQHCAtSBzQh6VSeS2tRYxZEvmvNhPI
 ra4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728364606; x=1728969406;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4usHwfkRIDlgmuAY7IxnQbjJSY0Oadp0F12eznaDMR8=;
 b=MVEPNXm8rgnlqGc/ekwNdIAqKGa1SPAuN6cL4zvSyGx0kqf8avywpmZ3LmpVdBAdm6
 MylPBpv7tndMB7F5CGqbl+CSfAKOTpN+3hZ24zNuV7fuUXZAWCnN+4qsjc29Pnk2GHhR
 H/9qkDs0OnIFDvMhoJk2DypfEbJcH4af5IYeeS4u9Oy5kf2xPlwV/Yc73dy+c4shofjN
 dRhjNYYjHa4l5uQLqCIrHo17+8mRM4x0+xm4xP65KKOoIf+yMbWquw/ILCEk74KnzfTU
 xb7uupYuTKE31Ha3Ouyi7Ry/NnWJyjZ5EAGhI1kh+DApxnRrl4nIJiSwAPacK3lGB7ht
 ab/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5sRKV23S0/7/sXA3n7OPQrm1wfu2syJUEDu9nOYxCUtrcGTMpDCyQ77E4+2DNfIRX8TqQKooFeiLJ@nongnu.org
X-Gm-Message-State: AOJu0YxVO5XL7sbUoIPtnUiCaYVOAa7bEGztB+/UoWWH3cTAKzY7Upfp
 8OV/vB1dHOWGpE3B78RMgipB3eld0FgpqpGj2fW2AI5QCDhoMccQ
X-Google-Smtp-Source: AGHT+IH0/F2yK8ckujDxoCQtiMVTmtKuDw/iy9DHhMHHSsUMxRLEhHX+QXbN7dX4nQNzSpqYPWV/Gw==
X-Received: by 2002:a17:90b:17c7:b0:2e0:808f:ef9e with SMTP id
 98e67ed59e1d1-2e1e631ef86mr16943763a91.26.1728364605608; 
 Mon, 07 Oct 2024 22:16:45 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20ae6a212sm6559814a91.11.2024.10.07.22.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 22:16:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 15:16:40 +1000
Message-Id: <D4Q648828O0X.3AM47674H807M@gmail.com>
To: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Richard Henderson" <richard.henderson@linaro.org>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: PING: [PATCH v2 0/2] target/ppc: Make divd[u] handler method
 decodetree compatible
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240812085841.1583-1-iii@linux.ibm.com>
 <c7416776312932df4e4c27cf040189fd098cba3c.camel@linux.ibm.com>
In-Reply-To: <c7416776312932df4e4c27cf040189fd098cba3c.camel@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Wed Sep 18, 2024 at 7:56 PM AEST, Ilya Leoshkevich wrote:
> On Mon, 2024-08-12 at 10:53 +0200, Ilya Leoshkevich wrote:
> > v1:
> > https://lore.kernel.org/qemu-devel/20240731100953.14950-1-iii@linux.ibm=
.com/
> > v1 -> v2: Add R-bs and a targeted divd[u] patch.
> >=20
> > Hi,
> >=20
> > This series contains two fixes for the same issue: divd[u] touching
> > uninitialized ctx->opcode.
> >=20
> > Patch 1 is a catch-all solution for all issues in this class. IMHO
> > it's worth having something like this until the legacy decoder is
> > fully eliminated.
> >=20
> > Patch 2 is a targeted fix for divd[u] only.
> >=20
> > Best regards,
> > Ilya
> >=20
> > Ilya Leoshkevich (2):
> > =C2=A0 target/ppc: Set ctx->opcode for decode_insn32()
> > =C2=A0 target/ppc: Make divd[u] handler method decodetree compatible
> >=20
> > =C2=A0target/ppc/translate.c | 5 ++---
> > =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>
> Ping.

Hey Ilya,

Sorry for the late reply, had some time off and taken me a while
to get back to it.

Yeah this is a good fix, thank you. I have queued it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

