Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E06C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 04:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQDE-0001ru-CF; Fri, 06 Sep 2024 00:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQDC-0001ow-CV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:04:42 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQDA-00038G-WA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:04:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1DD27A445A9
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2024 04:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0308C4CEC8
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2024 04:04:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="S1L1kd18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725595477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IK2oZCb/n+9fkIu0LB+Ms6N9pDWneGGI6nu1dX5jJE=;
 b=S1L1kd18F7R61VDQDXWlaQOYUGxhGfFfbr4J/zwPrxZAnyhgNGf9rCTSUGe1yfxUWx6xRa
 rT3sBYYH1loWcz002b4ypDuGiAzmRKIbz/ITbwRpWACcWc/NEAp7UxiCChBNubIIgdFGRz
 zdo2iTvq4LccLgqPLYAsMecf04Ef0Ew=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a48453b0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Fri, 6 Sep 2024 04:04:37 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3df16ece2c2so1094675b6e.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 21:04:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUot8Hlgyo3ru0f0aRj5YnG4VMzAX8CJTJ0BOCL8HJ7LVA4nhykbKGe71m1JRzNXrw33YuLj/UjVrKP@nongnu.org
X-Gm-Message-State: AOJu0Yzc29mZg2Wkq38JYBu64563P7en5YVBA6oiB3M/AO5wLkVmv1BP
 I9G93kwMoYHuQ8ACFofrhLpX8Bhy5AONGlzuQtI0XbyKUnnOk8C15MTvqJ69+7Qit4mO52oO46C
 ONsOeiFM4btahiHScLEjcB78bduc=
X-Google-Smtp-Source: AGHT+IEYgNp+GzfSAdI6zC+MaI1H2KLXiXv+BkTFU9aZvKrGiBZDR9zGQW7wJT67BQnXT1Q21YZljV5KhKs/kWpDJpQ=
X-Received: by 2002:a05:6870:a406:b0:277:e286:88f5 with SMTP id
 586e51a60fabf-27b82e59afbmr1671046fac.20.1725595476617; Thu, 05 Sep 2024
 21:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de> <ZtnGA4mH0I2hdx4N@zx2c4.com>
 <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
 <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
 <b11ba2f4-ba4b-40fb-860e-e10e760562fe@t-8ch.de>
 <CAHmME9pjokr=ahBbJA9Ljf8jjOyfyRAk0Qo4YeDYO_gs78GGzg@mail.gmail.com>
 <7311f2fa-2353-48ad-85f5-5eae1f6cb65f@t-8ch.de>
 <bac8575f-1c43-1242-9113-ef7957b50e68@loongson.cn>
In-Reply-To: <bac8575f-1c43-1242-9113-ef7957b50e68@loongson.cn>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 6 Sep 2024 06:04:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9pEw7_A5fSAooZLM9NGEpRN+05woicq8-qEjMqgBB8DwA@mail.gmail.com>
Message-ID: <CAHmME9pEw7_A5fSAooZLM9NGEpRN+05woicq8-qEjMqgBB8DwA@mail.gmail.com>
Subject: Re: qemu direct kernel boot on LoongArch
To: maobibo <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 6, 2024 at 3:14=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote:
> yeap, will submit a patch to expose ACPI GED pm interface with FDT method=
.

Clever trick. Works well.

>
> >
> >> Meanwhile, any idea about adding a second serial to the platform? I've
> >> been futzing with it for a bit now to no avail.
> >
> > No idea, sorry.
> Will investigate the second serial method.

Thank you very much.

