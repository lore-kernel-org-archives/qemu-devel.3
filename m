Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463C0C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneTp-0006ZV-2O; Fri, 22 Mar 2024 08:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneTm-0006Yb-Fu
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:38 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneTk-0004Un-NH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so2925515a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711112315; x=1711717115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWM6ZDeJKwoezpXfxD9FjRUizC2BeHNICr/OOtH40rM=;
 b=ccaIiCbzkkM/Z1YNsvPVmZtX6PAWhWg4MITQlDlZ9UtEjcM0l72q+5MyNwsNJp4Kt6
 vZamHpAjJ/c2B+EV+ONbgQbcUkn72cIEEI5suDLgasvwTH+Z4I7UaVff3zw20jaLrfYq
 RZnpV3w6DO0ceAynY7K7aiZ13ecI5qRgeSLqIVx0thfrzup4l7FU/5UU07Z5Q33boVng
 8X/W+Jzk+AuQyyKuJ9Mk4Z8wAvO5pE63CFEVmre8ovEcfO9e4GEJmHz9JUIelGlNVCoo
 MpV+Z7woOVg/eO2DeCGf86L+R8siuqLvNzp4MKqQf8ltCiK2pDASlUE42syWCVQXxhuG
 ATzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711112315; x=1711717115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWM6ZDeJKwoezpXfxD9FjRUizC2BeHNICr/OOtH40rM=;
 b=PUnNgDWXTOIL5pqXpIK0dVV/viuNYcHiqMFsm5UJV9XUXJjPEASsrANW0Ts/lY8JLF
 2GWUcVyD9wdrhFD6isYdTq0sjx9D+gSUs5XMsOzHwGJ1AYb1npVmvrOGFy4RVURY9D4+
 5uQkURWQw8l9VpSQfXC7UVDpJQh5fkBSEBh/D+OK5/ZgPd2n2HAbL+aTKqrrTiqEUh89
 KTjMfnKnRt2xSjCUZ/tubSCjxwGVKq0nFxdCsfqTvdT2AxUOWKIALTw0HiQPV40yCmDj
 u7e/9iYQ3BNMARUcZn+9k+ztWSGdp/dwJ3D948V1mkxow1nEPKgkt75J7ZloXgs8M1Nk
 WBJg==
X-Gm-Message-State: AOJu0YxxVp3ruXJgPR23X60shbloyXtzvUsU6yJLOMW9zhiiIgoBRlZO
 tlbNeeHQPEiagL6Fn/cfH73jDPdX4ICtI8ybzldrUPm9CJ6cMFVMxFc1Qp4Le6tguIDvvW18fOw
 PnNS6mtkYXV07rQp/OKjBxhQ/gKXR4KJYsLbiE6AsE5WRjw0h
X-Google-Smtp-Source: AGHT+IFptQIagiPub/5RjGeDmwZs7MFKbb3FreOdiLCOz8wpUWoWZo24Hu7T2GzGaw5sqxPg8EDCQnmqt4WCmQ4+d6I=
X-Received: by 2002:a50:d559:0:b0:567:a318:ac0b with SMTP id
 f25-20020a50d559000000b00567a318ac0bmr1657909edj.16.1711112314859; Fri, 22
 Mar 2024 05:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240321172251.1542718-1-stefanha@redhat.com>
In-Reply-To: <20240321172251.1542718-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:58:24 +0000
Message-ID: <CAFEAcA8fcp1Bzi9mya+tDE53jjRKJdF3JyCCZkoPd+TG7mVi7w@mail.gmail.com>
Subject: Re: [PULL for-9.0 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 21 Mar 2024 at 17:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit fea445e8fe9acea4f775a832815ee22bdf2b02=
22:
>
>   Merge tag 'pull-maintainer-final-for-real-this-time-200324-1' of https:=
//gitlab.com/stsquad/qemu into staging (2024-03-21 10:31:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 9352f80cd926fe2dde7c89b93ee33bb0356ff40e:
>
>   coroutine: reserve 5,000 mappings (2024-03-21 13:14:30 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> I was too quick in sending the coroutine pool sizing change for -rc0 and =
still
> needed to address feedback from Daniel Berrang=C3=A9.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

