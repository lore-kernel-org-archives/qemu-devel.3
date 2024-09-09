Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C477BECE581
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfuV-0008D2-V3; Mon, 09 Sep 2024 11:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snfuT-00083E-GE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:02:34 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snfuR-00085Q-QX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:02:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so5325876a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725894150; x=1726498950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRxlPrd/Ybys2LWD3ZftF27GtODdIWt5LgtCjZSmnPs=;
 b=WWmi9SsKovpn0JcietSM3wAY2ekhDfEScG4Tssc46EMU8sxTdBJSM0D1NocY+/qpzP
 znCWT0bbWcjzE8j8/hfUAkqiw7IyGQCZ85NBvcVcKqlUmubk3BWeZH2c7vN3NNi3nlfL
 tlFDvCzjfE2Gna54fgJwHSoF3U3y/QN1dTFnHfepegP9VdCKkesS2DmlUiF3myBtinyl
 BTP+QIdCO6d8B+s+G+zD+a7nU4+NoibHJrfBs0vDdkm8k55S3DkkM1OlKyiQb7Jsom0W
 CENnDckGZnmUqZAoLRFPpmSaEf6Nlh2kjhwpzmTkmqmZf1ilSmH+TKm33T7dA3fBpdKg
 GwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725894150; x=1726498950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRxlPrd/Ybys2LWD3ZftF27GtODdIWt5LgtCjZSmnPs=;
 b=KuPD46ZWJVlwVCBNnJ7X5Pq0wLONN/qiRfe5DHZsudbvxHDLEgWqf307v2JyYi27ye
 kJoHv6L0p8ZXnmL+1c3mIUVRCdQURUWMdguzzz1JA5iunH73eVp28RJsPCPD/mxiurbH
 SSRrPZ/ixwr0+EQyNG8XSfs4mL4dXe/2yoMy4Re/X23UroJPgeDfogKFR7a2eFHnWSWQ
 +RIs0qrovDQSJzETm/du/BZUJmuR5KxkysSP/r1DIa7lmkGV7CZhRK2z8txx9autZrel
 /mIpScnlpMGqqiRoEAbJrBJ8UIi8ye2FKBylCIjoaDDEN1OtYTw4oIkynhBucFfh02Ie
 E2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaX4t/5bG2cyQbO6YjkF6jxK5TcGp0/ByD10jHWoGxGs8+C1H4RhT8tZO/586hhQ8F0L4SKXnE3AaG@nongnu.org
X-Gm-Message-State: AOJu0Yw1wGwXIVVzmbblqKKANi8E7gxRXzS9JHTEkByZdl46Kwuu91bL
 tLaFUA4lQoN2Ogs0nZJUltBqASgyc4GqpT9wYPz5lNpVFO/imYETP+YONBysnXylbPV+1LhXk+2
 ybVJMGp81/jEQEd2tnoqTaROD++DfaOZINPIM7A==
X-Google-Smtp-Source: AGHT+IEGEaTPuE8V0gN590ux3qVAvH/IFNSzzCMBYGYkd/A0pGaYdlGMCUocAeQ3m0fkHkXbQdtqigmdU2u+vf75GJ8=
X-Received: by 2002:a05:6402:234e:b0:5af:30d9:e2b6 with SMTP id
 4fb4d7f45d1cf-5c3dc7bb1acmr7542748a12.23.1725894149848; Mon, 09 Sep 2024
 08:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
 <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
In-Reply-To: <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 16:02:18 +0100
Message-ID: <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 9 Sept 2024 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/9/24 06:40, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >
> > On 3/9/24 18:06, Peter Maydell wrote:
> >> This patchset removes the various Arm machines which we deprecated
> >> for the 9.0 release and are therefore allowed to remove for the 9.2
> >> release:
> >>   akita, borzoi, cheetah, connex, mainstone, n800, n810,
> >>   spitz, terrier, tosa, verdex, z2
> >
> >> The series includes removal of some code which while not strictly
> >> specific to these machines was in practice used only by them:
> >>   * the OneNAND flash memory device
> >>   * the PCMCIA subsystem
> >>   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
> >
> >> thanks
> >> -- PMM
> >>
> >> Peter Maydell (53):
> >>    hw/input: Drop ADS7846 device
> >>    hw/adc: Remove MAX111X device
> >>    hw/gpio: Remove MAX7310 device
>
> max7310 is a gpio controller which is at least somewhat compatible
> to pca953x. It is used on imx6qdl-sabreauto, and also instantiated
> by Linux with the INT3491 ACPI ID.
>
> Is there real pressure to remove support for such devices ?

"git grep" says the only place we use our max7310 device is
on the "spitz" board. The point of removing all those
elderly Arm boards is that all this code is ancient and
unmaintained. If we were using this device on the imx6
boards I would have kept it, but we aren't. I don't want
to keep old, unmaintained, untested, dead code in the tree.
If anybody does want to use it on some board in future
they can always pull it out of the git history (and
check whether it needs work to bring it up to modern
standards, and write some tests for it...)

thanks
-- PMM

