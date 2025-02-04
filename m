Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5169EC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKSS-0006oJ-5Q; Tue, 04 Feb 2025 10:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKSA-0006PK-Em
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:03:09 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKS8-0003OP-HW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:03:06 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e589c258663so5416269276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681383; x=1739286183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVwOgDmF4gi+qCbLpHs+nCN3M6GyYgsFZqSNBxemEzY=;
 b=La3RdU1F7lpHA80amG37/+GJny90piOzpw5G5z0zIW2RxmuHLtVfNXvzmbAt37z9fx
 kPAzkM9SkY1oMvNDg95vuigvG0/iVL+YZZeLhk9RTPVTbfV0osHb2ZXVzeYqk4Aguxq9
 sBVOZvQO3dxj8YUTZqYjocuF4U81gLhHEVqWSSM8qZevqQqEKZ0djVt7dmULFKPPyJFW
 hJvtorzOW51/hFF6aRAD0DElBCGwu2lJVJDHdSBqWZ/VJl4hryXdRJGzKO/a0MLM1m19
 aZnu5jQ6/i1GilJwSf3BVntJtF3pR3qile5CFrhvGZGsfHOrZDV0zRVIRtR6WVal/ZBw
 Q/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681383; x=1739286183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVwOgDmF4gi+qCbLpHs+nCN3M6GyYgsFZqSNBxemEzY=;
 b=wzcdLArqL/ZG1rN9B5gbR/1ubXwhwo21qr766njo5g/ztCao4HUHjwPF7kHenZ0yo/
 OR0aS+OuE5O0eKiWYS9q4htfy4W3hg8f7Rxh61VC554qSUutgGMSuKY+ioxtOmUb5VeR
 YCinuvzIY2WpHONkacUByo7vj4IKKuBsabA2pR04JS/D+cs9cRPaxozDB2dYA8IMcJ0G
 kY72i4L4rW2XVc72vpLdHFMszSQPCsk0NE6k9zgE0SJ1ulPkj1kn6Xq1yNJH5VNjyYsN
 JrTr2HuWzgn3GIA6pxBLsXzurlfy4bB7dYLdVqGiJjZdt3ZQgS/bo7OJ29QOgR3U0h6K
 rBlw==
X-Gm-Message-State: AOJu0YxagPlS/0Pw7j+goWds7VXa3vWJMez/qF4g9BOIr6+uQOufjC7N
 uJvEZ3jzt8eZJEVrE1GYKbba6B8ROoqP6MgETLWYi4B/+dqWVJ6rYx6b5wHcCdUucA2J47LAj7U
 nomu2ZB/AWZovf/ee7hL8YFMkFj3FE+W6hQLhvg==
X-Gm-Gg: ASbGncv5WMCUTxq7Gx0DgnZwRR+qAKz56D5CRjDY+OQeNXsCR9k2lGMjkIu4wdLtozX
 ONr99cVakIAxk0hntU2PHW5VTnDpYJUrbaxEp7r0Izp0rLTOpVGUaGFVwAJ9xWzxZPM5dXaZkKA
 ==
X-Google-Smtp-Source: AGHT+IE2+k4dNWOkjUTNBGQCMdedxo5hXuTuw4YJ3BG8iG4wy/uAUcm0YywyQycDBV42GKSiyvDT3lZDO1LQJv3KK84=
X-Received: by 2002:a05:6902:98d:b0:e5b:16b3:ed03 with SMTP id
 3f1490d57ef6-e5b16b3ed8emr2138400276.32.1738681383020; Tue, 04 Feb 2025
 07:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-3-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:02:51 +0000
X-Gm-Features: AWEUYZkhKyrTk-DrJEK9mRsV5YS6tnbUjpd1wInUYBoaRRy0O3OpFYDsFvLcKMQ
Message-ID: <CAFEAcA-q-SBmM8QSfMvNwpiYohzjBRTyTuYc8fW1-a4=25YpQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] hw/arm/raspi: Merge model 4B with other models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>, 
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 4 Feb 2025 at 00:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Except we alter the device tree blob, the 4B
> is just another raspi model.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/raspi.c     | 114 ++++++++++++++++++++++++++++++++++++-
>  hw/arm/raspi4b.c   | 136 ---------------------------------------------
>  hw/arm/meson.build |   2 +-
>  3 files changed, 114 insertions(+), 138 deletions(-)
>  delete mode 100644 hw/arm/raspi4b.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

