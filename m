Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024ECD7879D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAqQ-0002uN-Py; Thu, 21 Nov 2024 12:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tEAqP-0002uF-OL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:19:53 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tEAqO-0004WY-8i
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:19:53 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cf9ef18ae9so4363135a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732209590; x=1732814390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSYfZQtUN2o4b8G/ReClTSg634nDeYmIFhfu9vsCoVk=;
 b=eFUPHiAraO1MqFtyzZStwpIy3Izd4WhW8SHlasZlfFZtUdbLrWaYyEowgSX0o8GLEm
 ZouYNQTXliOphb97+MPOsqWLI5TosaX+iVdqQwEmR5uv4v0RmMlnc9w437UOpKXHyfwz
 kNilo7TILjvrOr7wuDHeHEv1Eya3bDJFATDGyUCrGJxWP2QTIaTbe4Gsrwidd8BD/TmS
 94INWgm/KEzO+joVtMdZ0HKTNJbL+Ow2d6EdRJ2k3D8hPdQmvWeopKTiRUIh4EDevjg8
 5SgKMWiZQhH72R1NLoWSiPTcX93/nkIL7VyaR1mQgiz3KdG2OR/8i4y1VhnPOGUIb2+I
 sqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209590; x=1732814390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSYfZQtUN2o4b8G/ReClTSg634nDeYmIFhfu9vsCoVk=;
 b=J9CZocw80uHcZJjlrnYDjDKBI7W0PIXZafGEjAwtWP+vjZC3gHbYjDSMKCIzEsyXT5
 4P6wOvWkjPg/dXTBGfezWtsk1iVjqOGkyfKIGf43qjlbkVG3Yx/R1GB+j6jzKQuvf8Oz
 WHnRzNatsKlPdJsXzheJfu3h/pxiVx2KexKmg9ZmcfqfKELRx9B8dMj4K1oJe1yC9fdK
 KEc3OgTgDe2PR6gNLyaSUiiYV9SmrkAgWc+sqtOKsiGDIIbBOsAiSLbT4iWXA9fRGj+v
 cVYS8nuR1nrBy2InTDS3Agu71DoR7H/s4YelbEI7F5pSdezRMbM4Myfc9x/lgExL74Fc
 olsg==
X-Gm-Message-State: AOJu0Yz7QmeLSIU7L8EJ7BUc5gy+f5OpHF1Oh0oQ760ZOPdXdNebe0RM
 NGuAb7KdRnEnfd6HFvmnA7fEqi8dbfyDVc7DTfBob3QeJQhxsD5bvMJk/S0N1ndcoA2GT4zr1Zc
 qp/YTQC+WdFPtJ2QJlWm/7eJdK8mkIGA0oThkhA==
X-Gm-Gg: ASbGnct37lQ9u8OQo43Q1ifO97LmNshmbZgzSbY+w9ko7dOUokzcRyv4oEA33MAFz1w
 G4ikzu8Z3LD5T4xHqpvCoWGEgIoyGKP7k
X-Google-Smtp-Source: AGHT+IFIQYgVWucdZUZm/MGwW8o/x69WrsFwDAecdywlBycUkKs34jmlCDdAqxm02HpSotRtW2wplRUR0jbCuDj5t9o=
X-Received: by 2002:a05:6402:42c3:b0:5cf:d1b2:b44e with SMTP id
 4fb4d7f45d1cf-5d007be495bmr4388140a12.1.1732209589766; Thu, 21 Nov 2024
 09:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20241121165806.476008-1-alex.bennee@linaro.org>
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2024 17:19:38 +0000
Message-ID: <CAFEAcA8KD4qxY18pJakSeziTioNYDQkd3VYcxYfq9y2KAON4Wg@mail.gmail.com>
Subject: Re: [PATCH 00/39] maintainer updates for -rc2 pre-PR
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org, 
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org, 
 John Snow <jsnow@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 qemu-rust@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Ani Sinha <anisinha@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 21 Nov 2024 at 16:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is a mostly testing focused set of patches but a few bug fixes as
> well. I plan to send the PR in on Monday. I can drop any patches that
> are objected to but I think its pretty safe.
>
> Contains:
>
>   - Daniel's clean-up of functional tests
>   - Another avocado->function conversion from Thomas
>   - Update the tuxrun baseline images
>   - Minor fix to the rust pl011 device
>   - Documentation clarification on identity

Should we really be updating the tuxrun baseline images
in the middle of a release freeze period? Unless the old images
are going to go away and break the tests, I think it would
be better to stick with what we're currently testing.

thanks
-- PMM

