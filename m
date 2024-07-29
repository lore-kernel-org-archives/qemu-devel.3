Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSUO-0001wj-6I; Mon, 29 Jul 2024 11:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSUL-0001mW-U6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:40:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSUK-00040S-9E
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:40:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34722so7609800a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722267639; x=1722872439; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zhPhz1WyFr6OWCnHNW2ET2Pv9i0NlzcL37aFa5r18w=;
 b=uTWWU4Fr2UmFsuyYvNucdMeYxsQL+SqfzE002WHUQEqKMWd2gPtx9KneILXkh055SD
 Sx4mlJ45sBLRqz/X8/hgf5rwncZ+M2CC/MVc0GrDaPF2QKkTxefGKRz3osAIbHPHvBhr
 p8UR6hlnnQiqi0ZS0iEmepErIZnqEhdxhW2jlhqVszi+bUdJGs2T3VK5OEBgfI/tVs1l
 GZwZtjedvdFroIa0N2cIK08SYdLND0ceR01J4obF3QM/QlVp5wU8+B+m2joUyPuQJqVm
 03fbV8RXFkBQehmnENmjJGfMHZ77Q1zZxNts1kidtm+8s/z0dYeyCja9UshmdxzaDqPy
 CJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722267639; x=1722872439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zhPhz1WyFr6OWCnHNW2ET2Pv9i0NlzcL37aFa5r18w=;
 b=QAck5ZgzHxJIcit3er4TLrw3J3BYgMe47OfPx7n86KvwbQziRTJle1tea3n4Hrbdm6
 FMUmp35mPRbWEOw6YkjXgDNTD7WnEdP/DKugLPUo+dpZXk+L6G7ZBh2kNVE0guJmvXfc
 eFnkWVPf64pbVjF8eJHCk+tW4Fpr1knaS8zT1oyT7NO0R6XgLyrc0JVUSnUavOVDuCoz
 kc+thJEmFwabwwnUntr3qq9+idA3t7G1ILYYHVg/c/Ut72reDGbbCpHp2m09UKB88jOh
 fSGZ0BppunA8fXvZ38MbB3tKWrxb6aQy6TW6cdUarOUlZMXf0xFd88cnb7yfqzvIgmRT
 zBBQ==
X-Gm-Message-State: AOJu0YzinCXQ4Z3kdX90KFkah6ZxLikB6ANE2Q/fiXWO5M4NG1Isd+Y9
 ufh7++TJfh5HHtMFhgVZutIm73e/s3xvw8eY6uYKtA0NLdfOKeSLubSlu/sqUGcfT5SQ4pPjV65
 6SMOr5Laohi+vJBLevTuRZm6sBQ/9oAvKU7XJNQ==
X-Google-Smtp-Source: AGHT+IEoT0tvTEpK+85ua9qidRo75KoESF2Khtw47/eR1YKy+iffuzZxjqEE5WIl4PlU4A9O/Hi1ChFn1ZPNi2vsqnY=
X-Received: by 2002:a50:8755:0:b0:582:7394:a83d with SMTP id
 4fb4d7f45d1cf-5b018be38a5mr7475620a12.12.1722267638615; Mon, 29 Jul 2024
 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-5-philmd@linaro.org>
In-Reply-To: <20240719181041.49545-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:40:27 +0100
Message-ID: <CAFEAcA9z61Wrvk45hVGuE134fOCJs2kr5hs5m6c9MEaarHm1NQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] hw/char/pl011: Move pl011_loopback_enabled|tx()
 around
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We'll soon use pl011_loopback_enabled() and pl011_loopback_tx()
> from functions defined before their declarations. In order to
> avoid forward-declaring them, move them around.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/pl011.c | 66 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

