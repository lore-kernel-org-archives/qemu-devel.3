Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB9EC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 12:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivBh-0006qI-4G; Fri, 14 Feb 2025 07:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tivBf-0006q6-KW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:52:56 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1tivBd-0008IV-UP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:52:55 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaec111762bso453505966b.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1739537571; x=1740142371; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owhvxhaazV6aC+vk1VDvoO/TSQgrcGu/+wvMUSru++E=;
 b=C5lYAU8THpq5oYSGGCdUPK4A6qVYwqxMIoy6a8o6k3G435OEppkfu6q1q2aiUWlKha
 +M5LwQ3oSarr37gcvvAcuTQ20kQRrR3Pqhp/uK4bpgG9T1hmfc7AjWwDDYQxe9xuljGE
 lQPtgvI+30iDYO5pjmltTRm7ff1PEMGdGwGBDAelSKbZbYZNRsuSChdUd9/++YB6upS3
 rSRkkPHN+PUR/lDgqjSn3wpA0lIvNtmdRJDSpM8UmuA2NlumpwsL1QWHfaPrQB7EyqYi
 6vHg8qwOddNm20atmDn+i5drS8e/4/dQnOMEMdncaXl57zq2oreEG42c6ERIkXdqeWQN
 yTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739537571; x=1740142371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owhvxhaazV6aC+vk1VDvoO/TSQgrcGu/+wvMUSru++E=;
 b=gxREPY58TR7x9tjLRtPuGM+o1ZxWqfgrhZPPYEQ2MmcMTvpJ3Akek7Xp0wVPb5vKnD
 UB93Ia0RIGngTvJ2zX8mncnqlprdEGc3D6LORqBxi1IosfoeLL6fs9oYQ3PqnRPz4mfP
 ldLBeGh2bxDQNZY9i36MqPRlTBuPUEdSr7KoePPhNzSQalZZpPVa04z2g6KN2M/9Mowb
 i3kcHTUDDgZNsuGrfPVuxQv5VMzjy8devcvJ/Cb34bOnR01Goj/jeBon79lQf3Nouc0X
 vbozEcgQELiB5z3HEgfocdViL/ADxjMzgduBY83oQiRPawRTfs0m5kcUwmxycUf3pvlb
 oSfg==
X-Gm-Message-State: AOJu0YwrTHeH673hpZ27mhBv1iBniIWshq6f6q2IgzwG2HnPLo4ra+mP
 5FKFFIzS0kU8D873rriaknVW6A3B/dDxV9d1gSOGAWbp7YffP6eL7qT5zNVLoxdGdmIk/iRTtAv
 0Bn+yeqay7o5Pmbe0f8WJfOTPJznSdp1Jx/btpyTcmHH/aaQojQ==
X-Gm-Gg: ASbGncsc47hRS1Q7D4JQ/ZdTvoq2y9JWNtgqZts+5gmjuYHdiExc7X3bNxU5/+K8gOZ
 dpgx6NgSlOEhDN3cK8fSKkXfuRnDzyVpcPCIytWGCs3cYhnPRScXa9QmSC2YR7TzIWCz0c8m5PO
 fSYNeBbuLWucbX4vUXtcJI3Y0oXqrgTxs=
X-Google-Smtp-Source: AGHT+IGF1DDblLKLr2AJebhd3yLO89HnK6IfjFHaOCPgFrMqT2cqUlXbM+4vvIJgrs74DlVfMP6p+ZFQCTpnaQVAfq4=
X-Received: by 2002:a17:907:7251:b0:ab6:d7c5:124 with SMTP id
 a640c23a62f3a-ab7f347db92mr1228558866b.43.1739537571492; Fri, 14 Feb 2025
 04:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-16-alistair.francis@wdc.com>
In-Reply-To: <20241031035319.731906-16-alistair.francis@wdc.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 14 Feb 2025 13:52:40 +0100
X-Gm-Features: AWEUYZlNlEQSlkiL_cE60fjRrOJtT031gnZcWdYP7qZ7sgh7Y2oc7mVURr-mpiU
Message-ID: <CAJ307EhFCpK8aO7r7PHF7H=k=f9tstPe=aVKrMWv1y7m3_HSNw@mail.gmail.com>
Subject: Re: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x634.google.com
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

Hi Alistair,

I've an issue following this patch. When the system is reset (e.g
using HTIF syscalls), the fifo might not be empty and thus some
characters are lost.
I discovered it on a Windows host. But by extending
"TX_INTERRUPT_TRIGGER_DELAY_NS" to a huge value, I'm able to reproduce
on Linux as well.

I've tried to flush within an unrealized function but it didn't work.
Any suggestions ?

>  static void sifive_uart_reset_enter(Object *obj, ResetType type)
>  {
> ...
> +    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);

I'm also wondering if that part could not lead to memory leak.
`fifo8_destroy` is never called and AFAIK, there are ways to reset a
device dynamically (e.g snapshot, though not sure if it's supported
here).

Thanks, Cl=C3=A9ment

