Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC4C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk23x-0001SJ-5H; Mon, 17 Feb 2025 09:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk23v-0001QH-Aq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:25:31 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk23s-0001KT-Of
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:25:31 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5dbdbdaeedso2406630276.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802327; x=1740407127; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Klwl8j9fJtwkONRCxBfElOiHGMV6PR7z65Grl+CdRR4=;
 b=GpF566qd3upc8+RWtxTtVJK6J69Gmta2F6Y6TyP/BoIZ2WOf8ManHwf5UiiQJjU/K0
 llBHkLXEqRaNTEuE64JA6URvwvOVPjacWfisSs2oIKGMekAvBvQn7wz4/D5lp6ewYjmR
 HUUc5uaqVmC+WyQy2n478eskB6zXzFfYo3O4Dkc78bAPPGGHlxvuNw7B4a38zLIZNIW9
 E4cm45IyhB1fi9Tl5ZvrIPwZKhu1xZ+8T3FAU8FV1TmSKI5x+GLCb/AfIvg2ykJY+/fZ
 ozPpuNDsgM67vn0Td6v+Lnd9QWiQygJ3j039ey8YNDRkoMGgOZKZ8KifTijpLB91thQk
 xkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802327; x=1740407127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Klwl8j9fJtwkONRCxBfElOiHGMV6PR7z65Grl+CdRR4=;
 b=F2PKzNd+MKa+7YyMu8WCVEBK3gYI5eez4XlBjPyYawirWYiF/Z/Hna/jFMeJRdy5n2
 Ss7Mu/247nYhueRfHWta4o+RSPr/HgoKurztWYG1NI5Irk8LVwIsC7zaOCE+a8UqNDyk
 BV/zcXQu7EcmZVzqCBpSNOTZ2Z+wYTxMMoaNWhYdv/ADhL/Ouq9zCCOA/Q7stMMSrSLX
 uakJCnU4p2Urt6DLq/7ZQJAO99uGO4osDP0dHUp8UINFuNO48H47AJZPHvwgZrH/ils7
 LYWrFEa7Evq7DmX/ItsLnwO9OzLG+5YuAFFqRWUzGWsWJKkRV9JCDHBChe3KJVcYLuj/
 wLBQ==
X-Gm-Message-State: AOJu0YxX0ZbrOrkWtjPMP/xl7DBlOAbqYofTrRzWH/r2yCQjiLsi0siX
 Sng/4QV0dmGiYU1UyEfetkPIyEUGbBy8TmsN8TE3i+8cExaTMggMMdKYL6HArZ4Q/5tGtcBZcwR
 IQjmoe0Xh/z+XeJsKkpJ3HTIY/8mNJfq1QVS+cA==
X-Gm-Gg: ASbGncsvK1WQNplfqVr7v7whjGrwMbUl2nR/+kkop2fqPWisfTgxGqL3GATcUoZbsjL
 oMhwUx6/lycA28ewqprWnD5R8x1tJPys2r9bmXAnBdEBRvdu2At2vlxBKq7RAyvJ8moEQti8U3A
 ==
X-Google-Smtp-Source: AGHT+IF066er0vfriODEHWb3kxBnFTDlASVw6mNlV0HAvqB+v8oCylhFxZV8PzuJLgwusY25geOgfLXf9pg0YSW9mk0=
X-Received: by 2002:a05:6902:2204:b0:e57:442a:befd with SMTP id
 3f1490d57ef6-e5dc91f5e7amr7347827276.32.1739802326579; Mon, 17 Feb 2025
 06:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-4-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:25:15 +0000
X-Gm-Features: AWEUYZlBg7uVbVWyBO3wgSoK3No969-zQetpTIUZtucNNe9zc3mPEJUzIgm0fdI
Message-ID: <CAFEAcA9iKwXEWNFBRQvVny9ZgnCf_VHj_PRtyKBa-WFG-U0Rsg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] hw/char/pl011: Introduce pl011_xmit() as GSource
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Extract pl011_xmit() from pl011_write_txdata(). Use the
> FIFO to pass the character to be transmitted.
>
> Implement it using the FEWatchFunc prototype, since we want
> to register it as GSource later. While the return value is
> not yet used, we return G_SOURCE_REMOVE meaning the GSource
> is removed from the main loop (because we only send one char).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

