Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1430C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 09:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzCJ8-0003rJ-KZ; Tue, 23 Apr 2024 05:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzCIx-0003pW-OK
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:19:13 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzCIv-0006jU-Ti
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:19:11 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-518b9527c60so6235057e87.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713863947; x=1714468747; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZo4rpsnvQfm+Oo0XVHWkYgZewv0qBjrbr3g1M7/QoU=;
 b=O2ZJAsZp2fVYgUVE9jHIvQIQsC8mlu3Tfii9aXtYlBYtDRtREA4DQSN0MHVprpZRET
 YS8M0uZVDHhmRzi29hDmINQ1k+XFJRo3Woqs3412+zYi0qGAxntDf9+sGxH82SaEiGLF
 zZ86JoS8R9y2FTMt0RMLVSzHiLa8wJcGWaG6iY/48vKedv4GJwcbv6dIdPVTFRi0qOrd
 CmVjcJK+d5DLIKhtmslCtv/ydsq1zrNWVsHfBdoJoW2EHvMRKE4BtT8rWIh3cj/MBdId
 PSICfLjdbLjnOVZrX1l5J7eljZ61YdjDpOQMZjmVNMSZujQ8XSn3Ewm7Swun9/gBHrTx
 FTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713863947; x=1714468747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZo4rpsnvQfm+Oo0XVHWkYgZewv0qBjrbr3g1M7/QoU=;
 b=LvcB1MdHPMwe/nIAbiE0c1dP1YnVrb6vlPk8Fr/y/+lJVSHWA0WTL53XCA9BLu3GE9
 actSbffY+TR0KJ+ov64qTBPS8Q4F6VUHRPGaVJ8vvx/NXorD9ohNG8YKg9eZYiR65P8M
 J26WTz2BJkWqKPySK7sAmeQZUwWFcvmudsAQZWAHWJeLF9yoeO3Fb6e2kfTSDjDv6ClN
 3QYzsMA52dbf7tZD4oX69QOy+nrcSrAd7WgFBtOPkEETRk1hZN6sTAjJ39uOBOajF6oE
 R0t0PoAmniJ1DiJL5aJNXm8FxVjfe6/CzBjseO1Hhoh362itvTvj8ynI6rlN9pjaMr8B
 nXUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhbaBjylqIUxESPee8KNbtHiCsBbBLeI7zryof5Oci/fpNmHnvVm5Jq+LfG0T4zXiX2cu6AylD2xGj7eJ5X1sMuLFnUI=
X-Gm-Message-State: AOJu0YwePloT8oe41hbKFjtC++wnRnCQaaCcEVIdASLntpMx7dJ6p723
 iXiIR+7kMkYiz83T8wzOJx6FtIdsEC/kcimVgVJTgC35SKE43b8BprP2lhnisme1f3HZOyVPO5O
 Dc0w9X1827k5Fuoo+29QuqoubYrna21cOy7VCEw==
X-Google-Smtp-Source: AGHT+IFoWTzxEoZNLjqb4BPAlGHvrXGLHIeKn2uLtPPK68X2WLUcRkDbBr552gi9VaJLfqnz1B0Q963pHlAvHW1FoeU=
X-Received: by 2002:a05:6512:683:b0:51b:6366:3459 with SMTP id
 t3-20020a056512068300b0051b63663459mr5002854lfe.67.1713863947028; Tue, 23 Apr
 2024 02:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
In-Reply-To: <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 23 Apr 2024 12:18:50 +0300
Message-ID: <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
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

On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > > > > Since VirtIO devices can change endianness at runtime,
> > > > > we need to use the device endianness, not the target
> > > > > one.
> > > > >
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: eb9ad377bb ("virtio-sound: handle control messages and str=
eams")
> > > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > >
> > > >
> > > >
> > > > This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> > > > It is unconditionally little endian.
>
>
> This part of the code is for PCM frames (raw bytes), not virtio spec
> fields (which indeed must be LE in modern VIRTIO).

Thought a little more about it. We should keep the target's endianness
here, if it's mutable then we should query the machine the device is
attached to somehow. the virtio device should never change endianness
like Michael says since it's not legacy.

