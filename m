Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B51C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk29O-0005et-9T; Mon, 17 Feb 2025 09:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk29L-0005dv-Ee
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:31:07 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk29I-00024W-PJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:31:07 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f7031ea11cso38608547b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802663; x=1740407463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARq/1TRKqEsZ4gBUkE4hvwxgchz6MW1Tv8bqqoM9pc4=;
 b=g38mFwCG415+eh+MyqAu0vew/3DJKqy5VbeaeEJ02S3kYkpOiEN+46Y01ITDo8TSid
 Il6XH3ljLci3gKxOW4k67ROUrkfVHjNetodV8tks4SviEU0YcS1+8GTk+zSjh6PhlJqd
 kcrBe/GDq5nofwZod+wlD8OR0brXkJi/V3W4clD+ZRNfM6tFcidfSd+ZPoQhRR3BXqzR
 UirXib1yyKi9RKwiAgYXDZQrJK6g6Ymjp3gZvPNa8s9Avf0Rib9iP+Ghv12sPIotOXy4
 yTdHnsTKGEswZS47+159IFLotdRPFb/6y5BHkTF0Lr9S+ASvPCmJriii7WO6sMYycjwx
 duuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802663; x=1740407463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARq/1TRKqEsZ4gBUkE4hvwxgchz6MW1Tv8bqqoM9pc4=;
 b=KMCW/a/NrE0U8HlsFngErxjj7aV3J49kjH0cAlEbaADlZaFXhczqy1F198hA8ATS6U
 HmmOGgaAhasMEFfrtbfUxlJsrPkN0b0oDsNEsqMSRzX3vAPbkDOZ6YJL7W04OV6JVcYp
 r22fXDsT1r8YO/l8Pl5WlaCRBM1bAOJ+QySkTIvwtMxaIl0nvSVVaYW3O06xwbJ2UNLD
 teAZbIjcx8AvqXwM3TeUU3GaPF1NMVRhqie4Pp34OjQ9a29OH/n0uHG65A5mHmjryPbr
 1AZ0iUxBx6o/Dc0s+XMRyvvfRD8Ni3k2Xi6cSyW5SOeTLL7HZfHorfe7s2NvPwVt34NR
 rnpg==
X-Gm-Message-State: AOJu0Yw51KvrwxZtwn2wUZIYeNQQjQkT3tXn1l8NG13kXNEk31iMd8yH
 uv3EG+1gEH/0Ik3whr0t/Oi+pqYYsBhNQeSrZaS9in1CHLI8alEGHszIH+fr0LiSaKwtHE+0qkk
 TWoJjpzHJty7pAWaPseAZkaHWTXiChQqD3xXGKQ==
X-Gm-Gg: ASbGncvFR8MrhBm8hRt8AzjXl88lQuCJHQ9ZOvC4q4PNExpDvWCWLMs7TzdgYyDYpNp
 cPLc41gmxXiptPCTP/pR1FcRxD9ZQmBGlLubzc6VDDJCw/FV3smFHOh3yccsRnJXS4MHnmrnsWA
 ==
X-Google-Smtp-Source: AGHT+IHmvT+gFOph3mDwoljmjoy7ZNxzNndZtzsN7fnMHh+0YlTlpJxc21zZ11RVTxNieiA4Iy0UP3Qipb1fp4hN2l4=
X-Received: by 2002:a05:6902:f86:b0:e57:37d5:e271 with SMTP id
 3f1490d57ef6-e5dc930450fmr6829252276.47.1739802663008; Mon, 17 Feb 2025
 06:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-7-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:30:51 +0000
X-Gm-Features: AWEUYZlnXlI-NGSvZYeCcYu0_dJAUTjh3skvtj6zlgRnXy4GpGwjgmm_sR2rS_E
Message-ID: <CAFEAcA-r80Di9snxMQ-7x6-9Hn93RUEoR-C8wkw40nRnN7BLjQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] hw/char/pl011: Drain TX FIFO when no backend
 connected
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> When no character backend is connected, the PL011 frontend
> just drains the FIFO.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

