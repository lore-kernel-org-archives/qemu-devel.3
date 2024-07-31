Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB2EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3VY-0005sH-Cb; Wed, 31 Jul 2024 03:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZ3VP-0005Xs-U4; Wed, 31 Jul 2024 03:12:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZ3VO-00042k-94; Wed, 31 Jul 2024 03:12:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc65329979so44095995ad.0; 
 Wed, 31 Jul 2024 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722409932; x=1723014732; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqUrHUq3QdEciBMHLBZ6rnmhhMsloH6fwSe8W9PfSvA=;
 b=fyFUOEEYEHhzgnpXCGHrIY26K/WaCLQA6EFYHzFO2wnvlKQt2eOdRYxX5cQLH1Tw1o
 TAwAjgr/YLk4hcjNR3WptbAZ97uirr3Rk+vyhxQyBXiJF+TftY3LaSuNNP6VnxCmnwDT
 Z3FkyAr2WkY1M8GQxRgYGCuhrhBb+3m0JNTbH+JjOZvfWbhtRRQLcsDl8JPhhYyGEed1
 anudK5S4S6UwVj9yyCY4KzFzUgxWnl+bo5mOy8412q63656Z7orw1Jsmb69oZnFg26s0
 yEqnrAJbrh0ctE25eIQjI/Qnc3+NjnWoRCyGEq2h99R4xe6HHblROTvIx1+qBoeWzo+M
 +q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722409932; x=1723014732;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TqUrHUq3QdEciBMHLBZ6rnmhhMsloH6fwSe8W9PfSvA=;
 b=mIxAk+oL5IMRRwXEF7j7Yj1aJ7IlL3JHbiYV0QJDhJTe5SyMv2p+cBuTxPn9k26K+s
 4EeB0siIip01UAP+fL5d3qYLBkl4zwHXtavxLHR+5D/3EcwyHFhkjmnuzOSlcBwBQmGs
 HWCLIC0xgG1+TyRfnSva/jEDipFPqJwg4VW4ecDHSNGlVME8WKxV59EjFVzEdwjNfrpe
 xtLTVyeTVqx8g2eNu++65SE0VsyMf3n79AxAEo2fgBiOyE0lHgwXKSLTdGSSw97KDXre
 d9RvAbPs7K74WHwEgCHP4VmrSJU/xLHPtd88OlAV/6Hv8o9rRyjIu5JOJGU5+pr3Bq6t
 W16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgj5QEE2vbZTR1eMhhkgTsBY7DF4p+BHp52IKlCiMKDhN3iGpn695YQZVKmWy7oIDPwpGKjwvPcX/yfo7n2xp9kyVLtM=
X-Gm-Message-State: AOJu0YymAHisIP4Ozn7rnvrKRvCZsOme4BB+3OnG9Oeni7rTwC68ms28
 /DD45fvwluL7aYT1IVY2MHp8cRnhBOV8zqyDWsH0NO1Olno6rTeW+A0FLHk/
X-Google-Smtp-Source: AGHT+IGEZ87aaw2s1sEUVB+fWdKiAGyi97fT4Yj6i55de3eDPjo94Bd649rainm/SVpMV6yQvsUBsg==
X-Received: by 2002:a17:902:dacf:b0:1f9:d0da:5b2f with SMTP id
 d9443c01a7336-1ff04867678mr163485885ad.39.1722409932129; 
 Wed, 31 Jul 2024 00:12:12 -0700 (PDT)
Received: from localhost ([1.145.22.167]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cded14sm113670165ad.76.2024.07.31.00.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 00:12:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Jul 2024 17:12:07 +1000
Message-Id: <D33JD17SDW43.36W6DNK0B7X6V@gmail.com>
Cc: <qemu-ppc@nongnu.org>
Subject: Re: [PULL 00/96] ppc-for-9.1-2 queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240725235410.451624-1-npiggin@gmail.com>
 <5d5a2fea-3402-4e9d-ba05-3caede577d30@linaro.org>
In-Reply-To: <5d5a2fea-3402-4e9d-ba05-3caede577d30@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Mon Jul 29, 2024 at 7:43 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Nick,
>
> On 26/7/24 01:52, Nicholas Piggin wrote:
> > Apologies this is so late after soft-freeze, apologies. I was waiting
> > on "accel/kvm: Extract common KVM vCPU {creation,parking} code" to be
> > merged upstream [...]
>
> When we have dependencies like that we can ping the maintainer or
> ask if he/she is OK with blocking patches being merged via another
> tree with their Ack-by. Sometimes their original PR might be split
> in smaller parts to help us merge our.

Hey Phil,

That's good advice, thank you.. I wasn't blaming anybody else just
trying to explain my lateness. I could also have dropped the dependent
patches out of the initial PR and ask for a smaller one later. I will
try not to make it a habit.

Thanks,
Nick

