Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B7CD1292
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraEc-00054o-7N; Tue, 02 Apr 2024 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rraEZ-00053k-E9
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:15:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rraEO-0003OS-0I
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:15:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so7132816a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712049298; x=1712654098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nO2HzaN0kDt/16pA7tNJlMUFkH3bORvVFVPgUTmBlU=;
 b=zWciNxR/VKe6N6fNNYTeVKOAUgta0AuMDRw8vb55AMI2haNSv8MwI0sHw2Dtg/fe4o
 aL8QQFDYYjvwmJ3iEXo6Jtou6VwHmL87neZ+0Wr0C5wAzEpKZGJ/4e20eO6BlfYXaFov
 tsFC7CzFRsfdRUB1ms/76M3L5l+gA5YLC2YwEvtj+svc6l3rtBlB0CfZogGJgtCmgvkt
 GJvlJ5iKCzDFn2TNCTq+xybrcEoDXBeeClIbskdZJFh2PZTNlK2ZBjwTabxu3ug8w32P
 DlV6RQCEwQz8T31QH6DZIDKCSlZF7BFK7yBz8X6mkAzzK+MiGEB8dWoesb8+jp+3UYDH
 TVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712049298; x=1712654098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nO2HzaN0kDt/16pA7tNJlMUFkH3bORvVFVPgUTmBlU=;
 b=Rxof/R5qlJ3P79rbfMw4Qua9vWxe11Q0AzNA9olC/L1tsh8HOizvJApTDk+WQpGiR/
 JTCrohhwpd/5knL8EcGGvVuz26FPcQd6iuXg1ycbnW0BWg78TegpzPW65CViyqy2EcHt
 Upx0cSz/idRRH/tXiGBK0mEkqFJImygJe+aOYcCNMqbY5CaJyVxyfIHja6EwSDHmasBy
 TnluFJqis+uVIIW7AyuA1RfhvTCaI49Rrpg0r/OFtLeSQremszGa9zkaQBNTIpf1aPla
 kWhUBaQD6C07BLOVkRtIbe29nNYYWy48vh1KtV3ck9olVbp7SpV3FvI0Rb+SvoOxkUC2
 sAlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe1R5fg0QD3txExyFVO1Wq86/9YUk63tVFJbT5GnmnOW4WunfiiB0FCM4IS9wZPduCVPblvrneFx8/CB8x9XtpOF9GRvY=
X-Gm-Message-State: AOJu0Yzgg21zIacGkUE7QULiEPhrdMSVJqYEuXLx4/B3EOy9wYzfvWfg
 vXldeMLA53bStUIKsmkYPQ0FqknAM0iHX5o4n7RqW02Phoh83pX3jXaULxkfH8HQ2dgZVWsDoso
 2n0DXMIy97/s8YzklCQNIDImtr7HoxvARAnpfdA==
X-Google-Smtp-Source: AGHT+IHVbqXratlzJGCgSPbtBg4eHVIT7J8n8WUA0cFZxxIQgLF5nno128ww6xMi0ESa613raBZ3QgSqUSt+VRszmDM=
X-Received: by 2002:a50:d698:0:b0:56b:cf40:f712 with SMTP id
 r24-20020a50d698000000b0056bcf40f712mr6719781edi.19.1712049298358; Tue, 02
 Apr 2024 02:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240329150155.357043-1-clg@redhat.com>
In-Reply-To: <20240329150155.357043-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 10:14:47 +0100
Message-ID: <CAFEAcA-=DFR-eRLz9XK4=u=Aq0O=3dWZv+nLcDOgWyWAt3iMCQ@mail.gmail.com>
Subject: Re: [PATCH] raspi4b: Reduce RAM to 1Gb on 32-bit hosts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Fri, 29 Mar 2024 at 15:02, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Change the board revision number and RAM size to 1Gb on 32-bit hosts.
> On these systems, RAM has a 2047 MB limit and this breaks the tests.
>
> Fixes: 7785e8ea2204 ("hw/arm: Introduce Raspberry PI 4 machine")
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/arm/raspi4b.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index cb1b1f2f147e8685a1dba6f137335ea0bc89bca5..85877880fc706d216de04ff1e=
081d66e6080ebac 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -112,7 +112,11 @@ static void raspi4b_machine_class_init(ObjectClass *=
oc, void *data)
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      RaspiBaseMachineClass *rmc =3D RASPI_BASE_MACHINE_CLASS(oc);
>
> +#if HOST_LONG_BITS =3D=3D 32
> +    rmc->board_rev =3D 0xa03111; /* Revision 1.1, 1 Gb RAM */
> +#else
>      rmc->board_rev =3D 0xb03115; /* Revision 1.5, 2 Gb RAM */
> +#endif
>      raspi_machine_class_common_init(mc, rmc->board_rev);
>      mc->init =3D raspi4b_machine_init;
>  }

Running "make check" on a 32-bit host has clearly fallen off
our CI config...

Applied to target-arm.next for 9.0, thanks.

-- PMM

