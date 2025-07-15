Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341CC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 11:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdib-0006x2-2A; Tue, 15 Jul 2025 07:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubdhs-0006Tr-F5
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:20:20 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubdhq-00022i-MY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:20:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60c79bedc19so9409025a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752578417; x=1753183217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWMocM6QAqDQpxLmEfZwga6mJPOav7XzAWImkVKgVg0=;
 b=ojtAHhlrHFjYZTF5gnpWkwqDX3pTixhBF3/0UdyGWaOJdgX1LpbYt+MbDcCgXIVBag
 JjjOi9XQ9KYxKLnVybvk7cxxxnvMgzPCFagNYevuOL/J+BkxSKDAb9r5FUzMM3P7kuHs
 QJBw525JkvudOXgmqN/8nN522fTk3MyANprLXimcfnKZg46zq4hmACi0yX6juQrGNoBr
 6hWVhGYR4utjLgNBLsyXAZDIkh7PVAMJhS6NtSK4JSJ6EZ4odZ8ugApCTkHv0z8MGyPI
 IIlyGIiRLzdUIyUfj1TB6fe52kkHQeoS/crheoakBThwXFKmGWCJszQ0HeqOLKX12sMx
 PfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752578417; x=1753183217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWMocM6QAqDQpxLmEfZwga6mJPOav7XzAWImkVKgVg0=;
 b=DOc9sy+wqbp6Xvv2We4XNj8f9Q8MnwPAMiydj2pkvY18qwfkmUx2VMp41frDiKsv4J
 7Wdm+vepvMIbXYMU5ESHnnmWqEdhU+d7kaRXdXfmbk/ihSAY3wVCpAyJjJg/g36KIkOc
 0WBf/Hc2yqK/BJ9UzyWVce855cd2JhU/gPHw0Na4TgsW+jOMKSMpSzBov+WH5XzuX1AQ
 lIMU+OUFuXRi5BIBcKnCc+LdXNAnGMggQDL6USRwEAeQQUl7fb/1a2x78rI/LedurcFo
 fe97eHLxCnRsS5Ttnbd2Koa7TZvemkXan1Ced3sxWDcEcSiP1XAi/iW3RqMttogCkgks
 p5JA==
X-Gm-Message-State: AOJu0YxMRs48xfVkzWwHJayvMV8d3vVXXgh+LLn5U6bbBnr/B/zUXMAd
 ZsUgOaRgaDeYS4lW0/n5ywc4IjFxq/4PjkpBcoFIPapl5wYqsjzoZ9Qkj//HSe1mxDIHoG0j4cX
 FmcEE+9S8E6Q9NvVtdm/8KUL/m96FtMjPVkK8KZT8pQ==
X-Gm-Gg: ASbGncsSLYmgQRiiz02ZGHqxMR5quC3eyX/4Ql7/2F3ZCZV46rAFQvwBipyFxGTRJ6Z
 LPtkQrHnoawl1DqlzGi6p/CyJ8OWYZ+V/GCZG03uoyptXMY0MgyEKgLkhEID3N2dgplcxhJb7yM
 WeXVp5EnYtCSnqqxkYbakM2E4v+r9Z4Zh/AQ7tWEKJbrUtQ2VcUP5SnhbWLaHVSF+PIXNyhl25k
 p2kp62bFN8NwzSnRw==
X-Google-Smtp-Source: AGHT+IGONpUCo+IxO1tKzv5O38MP1ISShc22Rhi5hJsaeGaIB7iiVstZhqD7eyu6xC/22bIwAof4ukbNL6W0Fi2/k18=
X-Received: by 2002:a50:d7d9:0:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-611e7610162mr9553523a12.1.1752578416705; Tue, 15 Jul 2025
 04:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-2-philmd@linaro.org>
In-Reply-To: <20250715104015.72663-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 14:19:50 +0300
X-Gm-Features: Ac12FXwdICfN91AWnKKpVJqALD4LHikY9zBusPw1doN8k7PvE5O90gHwnCoCRZw
Message-ID: <CAAjaMXarV_CAzkfT8UJJgzPpMt6pbjUHT-FgHWwM5i=zbCr0dQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v5 1/7] Revert "accel/tcg: Unregister the RCU
 before exiting RR thread"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, Jul 15, 2025 at 1:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> This reverts commit bc93332fe460211c2d2f4ff50e1a0e030c7b5159,
> which was merged prematurely, re-introducing Coverity CID 1547782
> (unreachable code).
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-rr.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index a578698d071..6eec5c9eee9 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,8 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
>          rr_deal_with_unplugged_cpus();
>      }
>
> -    rcu_unregister_thread();
> -
>      g_assert_not_reached();
>  }
>
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

