Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF62C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUr9-0007Pw-Kr; Mon, 27 May 2024 03:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUqP-00078K-JT; Mon, 27 May 2024 03:32:33 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUqN-0007tL-Uk; Mon, 27 May 2024 03:32:33 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-65b4d0a7391so5303512a12.2; 
 Mon, 27 May 2024 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716795150; x=1717399950; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXJIyZ9Om05O3Mew//oQ/ybUA0XciHhO8eLbeRreUmY=;
 b=FuvQtRdf0ZAONA8xXoHBghNay8PFfDMmiumwuZmuFFT6sve7IOTGnqo/dFmaQV7IZF
 xBgISzCYKO8QQy3vFeboPbeyzfSh9FRf1rmGcGMxbppwPNvPwXAn4ixwEmiUKexDiX5t
 cUiFgAgUzZrf3MMMYha04nT3TF7frnrphj1/urV/Zi1/+YgaQr5Etp7GUaubHdWB/KzZ
 Yi4aae8xpI2MlnwyAiNxjTPuQOSJOMcF+ExA4OXDBBC7wzXymw08sywVwpxzZwH/HC1F
 BSyQCZiAHzus3YYJh/74sn9M9Y4UR0xnCVVbXjE9WIwwZND3lGmf1KUwzgh9abGSczWD
 3TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716795150; x=1717399950;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FXJIyZ9Om05O3Mew//oQ/ybUA0XciHhO8eLbeRreUmY=;
 b=L1GIxMnn/RG3LxX3EBE4lD7A7s0u+D4IVWQVO2Ffvx4sAwnZCyd2FeticdjQdblH5T
 X3dui+ZvZJUVkZqe0+w5jCj0T+EgPnThLUTgJ+N8tmucPgyV7GJIZVq7iQSuIl5tdsb2
 WgNbESyJNJ7y1bYKQbeDUzOZwNjsYGzTf93Tvs7mK/D/kiR7ms3iU27FYpUCb6gP+5nx
 8TACyH4GJh87wcGje0KL+5Oo701JY3k1trvmrMyU8VB5S6orczUN9HuJv0wlIlFknPDP
 gx7vttZKXSHmYq8vRg5q6/nJdBckMuxrfAGffxJYpZo4HfPcHBe+Xk9FbeFqaJuZ5/Gg
 OjHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb4ApFbXBTyZCuyGzb0gtIOimspbWm1xyiQBFUHT9WMVdrSdEX2LIt2yAxQyvnW7E1/I/Bwvbx9xAcCClTDMoThiMkunN0sFyUsAbOqcmvR1dy/yMR/9F4cPY=
X-Gm-Message-State: AOJu0YxtY11hFoNUoot6N6GK1dCANCNklKP6i6gLiQUSOFYbb8R+Qabu
 1AiAVTNA0q7Ne1rmIipn1/DI7opahYZDY9PnGqe52gsG+GGQQczOoYoe9yoX
X-Google-Smtp-Source: AGHT+IEylBrdTX1SXuIKcxK6C9gXIUYoF1wxphcgwnv/exlj23P7GpjTZaVjWyY7XetLNReqTnRmSg==
X-Received: by 2002:a17:90a:ea0a:b0:2bd:6536:9abd with SMTP id
 98e67ed59e1d1-2bf5e15648dmr7866294a91.2.1716795150136; 
 Mon, 27 May 2024 00:32:30 -0700 (PDT)
Received: from localhost ([1.146.73.168]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f30c770sm5102597a91.11.2024.05.27.00.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:32:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 17:32:24 +1000
Message-Id: <D1K935B9TYYV.3GMTXCVHSWP0G@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 00/10] ppc/pnv: Better big-core model,
 lpar-per-core, PC unit
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <66c95ef6-8f94-4661-bc4c-8f5f7abcce1f@kaod.org>
In-Reply-To: <66c95ef6-8f94-4661-bc4c-8f5f7abcce1f@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon May 27, 2024 at 4:25 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/26/24 14:26, Nicholas Piggin wrote:
> > Primary motivation for this series is to improve big-core support.
> > Other things like SPR indirect, timebase state, PC xscom, are required
> > for minimal big core support.
> >=20
> > I'm still not 100% happy with the big-core topology model after this.
> > Maybe one day we add pnv big core and pnv small core structures. But
>
> I haven't look at the proposal yet, but indeed, we could introduce
> a new TYPE_PNV_CORE type for big cores only.

Yeah. It's still tricky because big-core structure contains the CPUs
if you are running in small core mode. So it would really have to be
a PnvCPUCore and PnvPervasiveCore or something, where the former is
either SMT4 and 1:1 with the latter or SMT8 and 1:2 depending on mode.

And some of the "CPU" type operations in big core mode still need to
operate on the small core.

For now, the accessors and helpers seem to be not too bad.

> > nothing is completely clean because big core mode still has certain
> > small core restrictions. I think for now we take a bit of mostly
> > abstracted ugliness in TCG code for the benefit of not spreading
> > hacks through pervasive (xscom) core addressing.
> >=20
> > After this series, power9 and power10 get through skiboot/Linux boot
> s
>
> Have you tried SMT8 on powernv8 ? I remember seeing a hang if I am correc=
t.
> I don't think POWER8 deserves much attention anymore, we could deprecate
> POWER8E and POWER8NVL. However, we should at least report an error if we
> know a setup is broken.

Yeah it does have some problem. Maybe should just disable SMT unless
someone finds time to work it out.

Thanks,
Nick

