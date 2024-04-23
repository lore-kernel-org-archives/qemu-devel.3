Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B666C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBp4-0007O8-Be; Tue, 23 Apr 2024 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzBp1-0007Ng-TV
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:48:16 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzBoz-0001p3-Te
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:48:15 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso8060506e87.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713862092; x=1714466892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZrocSU7E+3pdItMEQM+CJosd1rfJFSkX3lL2CKS0f0=;
 b=AiQ8/uqkJuXRyJFJTFkXPSWldY+gTcoZowIQIeZwInqXYqchMBW8md2C1g6vrzyjH0
 AWHA+f52QUCC6Sim/LcegdjG/yZ+PuXOlMlD1OzF+etvA2RDruBALTxm5+GFthR0Oeg4
 WNmSxYd0T82vtgpC/rWRbkzB8SzcjbAXzsj357SWZbhq/9xQ6bmYmJRaK4WVQAYla23O
 spHNv/OEJBOx9HNOBwg4Vs3uhIWkJVfjyDmAAw0CRqsZ6DUAf6iFhk1UH8PJECeE2K/9
 8avGdgBv2Dsj9wKqT+PF1RLBKD2P2x37NzgpDjTZVlcanfXZa8C/yeCzyqgjY7Z064Cy
 L9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713862092; x=1714466892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZrocSU7E+3pdItMEQM+CJosd1rfJFSkX3lL2CKS0f0=;
 b=sMiIgzmFRSKYL69OOABlTqpqNnyvCRHPCxrLVz1sVMTwWDl8EOdHiDRvrz4VXN2iE4
 JQ9De5DMv3Xg1xQVvy8Nr+RuS+OxSSnyBtwrLFlrZ0ExxnSDg4Asbolc9w3n+Dum73oH
 JkIgu+6nN1LKdnE49Jn0iugxnBSa+XWH4+s+jucfbG7H+TVvfIOV3X/4Y9zNOVkSKbwr
 fjyl9GCoYgUpduvAqi/L5J6id0P3OfsMLVZWJ9iLXsv9m2qja1X8/9DHqaymT08kyQZg
 C6uJhWqjYQWHA0rT+n3kebaiBRtwSsjCSQW8YZRUwNGz78PeYcIv7uaseY3p6ZFxY93+
 be0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDB1IW61EeSyjh9wg0nCPcZ+Dv9e6bkNxbvRWUrL1S8KrIonSKWZxdKNpgNTNOnTWLIGO8RPqZnCClPhpNAQpe1XJyLsY=
X-Gm-Message-State: AOJu0YyPwxbS57NMLOv2gH1X+bcnuSTy45anUDrbMHp8OUV8Y6KuZvKl
 cyrH9Gz43rAaEl41fGoKQsM1yL4sh8T+BuVTTCMqEk7BZnQtiJ1pT9vGggIRmSHHNkimTnlqc5b
 tB0SZVpUo4Relmxf+OvaduwqiC+tYE3a/QNFnKg==
X-Google-Smtp-Source: AGHT+IFjHnBFeqcWSSvLhtmheqoDY6f9usPDXn+/a0Wl9n2Owuq9DbKPRIuwZYKczheQM5owWYKuOHAajsgrzxYaw6Q=
X-Received: by 2002:ac2:4bd0:0:b0:516:9f03:6a92 with SMTP id
 o16-20020ac24bd0000000b005169f036a92mr12403533lfq.43.1713862091677; Tue, 23
 Apr 2024 01:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422170913-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 23 Apr 2024 11:47:55 +0300
Message-ID: <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > > On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > > Since VirtIO devices can change endianness at runtime,
> > > > we need to use the device endianness, not the target
> > > > one.
> > > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: eb9ad377bb ("virtio-sound: handle control messages and strea=
ms")
> > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >
> > >
> > >
> > > This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> > > It is unconditionally little endian.


This part of the code is for PCM frames (raw bytes), not virtio spec
fields (which indeed must be LE in modern VIRTIO).

