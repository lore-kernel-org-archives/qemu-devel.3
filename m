Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B90CD4F20
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 04:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm3jZ-0006tp-Ul; Thu, 05 Sep 2024 00:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1sm3jW-0006t0-2U
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:04:34 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1sm3jU-0005HO-3m
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 00:04:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7A7C65C56D5
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2024 04:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B9DC4CEC4
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2024 04:04:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="TF+gB9r1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725509066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZB0L6AWt7O9GuRKjd5K56lW5NclLlgV1CnS7q2mFX0=;
 b=TF+gB9r115jyMpsXVMSXC5wqInJva1W2AiKsVWea+6lovbwX1NSXjBj8uxLd1qIoiMht+9
 2Xj3paLzXgYXOPAVa/cpnmu/xndS/s8H2GbqwgwB/PQb8UETLR1pJDrWulcjNEV43hhzXx
 ODUSKn5RptXjPvgK6jr02D+fKgCzFgs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 93e44d92
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Thu, 5 Sep 2024 04:04:25 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-5e172cc6d97so194929eaf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 21:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUF/9dzuJ3hcXykIxMWKfUac9nPlq/7CZyP/ppg+ck5TbPREW92zwshnihoFnW1+1NIOZQuIVg8UcPS@nongnu.org
X-Gm-Message-State: AOJu0YydJuqCF+H4n5RoPPtI/6AikZhTYJ/NFs3KxJ1sMNxexcdjjMtT
 FcEiUE38QPqth4UtxIVbUZLxhNlpB+82lzbZDEQ6P1BIG5RzKQze37VALcQc5mZE3gEYsb6wDLU
 ZS12MV1tSR3c2H0qf+AgJbN68IJs=
X-Google-Smtp-Source: AGHT+IH0uCXUX5MCw6rQIPaEcR+5fLGNzoZXnn2ucPF8FOINUA4RpYGLiwuWhv8QOKXb/m9D5ymBA6tEsLCzP5Bc23s=
X-Received: by 2002:a05:6870:a925:b0:260:e713:ae8b with SMTP id
 586e51a60fabf-2779010da2dmr24968052fac.20.1725509064626; Wed, 04 Sep 2024
 21:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
In-Reply-To: <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 5 Sep 2024 06:04:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
Message-ID: <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
Subject: Re: qemu direct kernel boot on LoongArch
To: maobibo <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Sep 5, 2024 at 5:45=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote:
>
> Jason,
>
> With the latest qemu 9.1 version, elf format booting is supported.

Thanks, I just figured this out too, about 4 minutes ago. Excellent.
And the 1G minimum ram limit is gone too.

Now working on how to trigger resets.

Jason

