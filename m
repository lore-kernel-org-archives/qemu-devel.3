Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A14C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPoV-0005yc-Dv; Mon, 27 Jan 2025 09:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPoS-0005wP-Mg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:10:04 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPoN-0001Bz-Vj
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:10:04 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so7853224276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986999; x=1738591799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJ7xkUQYCW6Q6JjkzKHpSAKv35gY9zQyjpYaT6M0TdY=;
 b=ajIXSFKyDo3cOxUEJlp1+8757vM5lem/q+uOtCWtqIVwzN3sutXS2UeGvNo11F6wsL
 8AaYRYAbK9yqUyTTrJOHG17nl100V6k610Ti4iFMcqqLaB/qjtWokjL7VNHT3sup8tD/
 NdC6CTA1wChA24i68/i9se6oL+4ZouRF6doU+aBHzt1Mi1thiS+ctiIUeLP2H1xDp+/y
 mYwvxKyfBhPEux5XdYkmLQXEKb3n1pEV3TkJiHLiS+9L/I0ql6KjDKF03+R0dJibmZLO
 e9jUYF97J5q+uydS40Jerei3PNApmT1pPXG4iuyPUGMZYbUjiJ0FH3HTyv/jbH7Fq4qA
 0Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986999; x=1738591799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJ7xkUQYCW6Q6JjkzKHpSAKv35gY9zQyjpYaT6M0TdY=;
 b=i+ZrPNC2xwnyrO3lGpyVnouxTwWvZjKpWcoP0VAJg8dNHkONexFB3f+CcgVUG2icXs
 p6OVvH8mbiIn6oXNKA+seb8OhdVUOUM/G+gotFUdbtR5kQERcEmrjlZsbagxXI0FhxnD
 s8U06VuVodirn+VI7z1+ZWDIIikrHHZZEgcjddRYaSnBYvBUmfYdJyfbJqA6haWU1h3Y
 TjX5Yy3g7K1cyF6jwcuuCaUix4UsJbMEJlikAGHba46Q43BPmJXOEz8JuoQ0C7GTb+NV
 fVriyr5Fh6Os+uZnOnQ198nAmsYuAQODKc0QM039AWJ4FcHtmQBeD7B01/4IvytwKA47
 ZyAA==
X-Gm-Message-State: AOJu0Yz5/Y1WDwpNM1qWpe9DONB0zEydTJCNt98/utBinrtIZRlQYzMf
 XmpwFBJ2e12tgwqzdf8M1dnR5tzOreUgs365muBLCicqPGWv9HO+fP58PQ+jYJhsMQVJW0zZNwq
 JMby9A2dlqpksgWIRZaCEPnzPDrn6kSMDj6HmBphAxRur7ncJ
X-Gm-Gg: ASbGncuj/NHkyPeKRH4Y2PP35zFRKo/rVPsTOVIGB5BNte/PyWyAmnRGzmoS9XTwLOS
 1zj9e2oOcVTa7f18NGdYmHbyY2IKfc9YQBqLC9vldiOKt8SpJKloajM8AuoHXXjo=
X-Google-Smtp-Source: AGHT+IGeYGuOaCChc2MYfCSKPUwzjUOmZT1rojKC8PRQHyFlAWHgl02PhXFQ5bcrQQkCcCPztPYwNHLXQ0XH7iigggs=
X-Received: by 2002:a25:c754:0:b0:e58:a26:6d9f with SMTP id
 3f1490d57ef6-e580a266e94mr14652364276.0.1737986998856; Mon, 27 Jan 2025
 06:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-8-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:09:46 +0000
X-Gm-Features: AWEUYZnrxXWnUMyfwlbvG3mWgV0LXRJcJ2T_93XbKIs0Jil4q4XadyW5wZlwi6Q
Message-ID: <CAFEAcA_M88CXQXF2N+=GU=QBFmQGYgMONXBnK1npR7Fu8AUw4w@mail.gmail.com>
Subject: Re: [PATCH 7/9] hw/arm/stellaris: Only create MPU when available
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 655bf85e89e..d87587225c2 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1128,6 +1128,9 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
>      qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
>      qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
>      qdev_prop_set_bit(nvic, "enable-bitband", true);
> +    if (!DEV_CAP(1, MPU)) {
> +        qdev_prop_set_uint32(nvic, "mpu-ns-regions", 0); /* Disable MPU =
*/
> +    }
>      qdev_connect_clock_in(nvic, "cpuclk",
>                            qdev_get_clock_out(ssys_dev, "SYSCLK"));
>      /* This SoC does not connect the systick reference clock */
> --

This isn't actually a behaviour change, right? Both our
boards set bit 7 in dc1 in their stellaris_board_info array.

With the commit message updated to mention that:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

