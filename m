Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYtS-0005I7-7w; Fri, 23 Feb 2024 11:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYbw-000396-Ue
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:41:21 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYbv-0000zJ-0z
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:41:20 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso1178187a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706476; x=1709311276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uwc3skI/3lhWv27HfxcoZupOGYnPlBilnkVkbOqzDSc=;
 b=XttGcnAM2hwBTcOasfxt0rI4bknHrQVg8evwEc4HJ7/F0SA4h8TLDQLz0xu8O5DgE2
 RW+jGREqs7KmgzTFsEP5xPz8a0kR+nj2jTRRZcfpPMQYGfMS3/I1i02TTEbPw8QMO0TM
 0gGRHG6/qIhcq3CJ0L5MGL7zuw6J5xMDymbQBvfEub0/qHz4CPGJIHa+kWCqR31RddIz
 FWP6wR/s1sPpE8lW0sc+4Orj3bP0xRsqEtaVWLca/nn+CvxJGwOoogq6mr5HFtwCWKGY
 iPF/f03SKwEaCOgF+RMC7TxztU3YmlItdL6uaaZwlOKm42Jj2H/7sbsonvXUaIPL5sW3
 nygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706476; x=1709311276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwc3skI/3lhWv27HfxcoZupOGYnPlBilnkVkbOqzDSc=;
 b=Je+0bvJh7c19nnGXXUAwtr3KI3isVCe7eYMIveHAvzcLynhRvnliwDPgQTUKZH3zDD
 nZptrMPcbvnZBktpzKnyfqwq77vA5i1W3vqZmVvFOQCADWwdpb9GWIWqIyeF1sNwZtD6
 75aW9htQVCRT9hetZ72PPXpavcaNUpp/GJKGvk13ZsgUqjjH/IDlhpBa8dy/9avEHDDb
 hXoieH/w38f165oOHrdrKaXFlPPV11iWLqlBhrIFGRWiBlCtGRg/zex3rLztS0k3z+H0
 c7y7AuuJ25JIchhJ6Q+qnnP+OQUpd/QJbmlBFsHo6ewWqW9BCzYC7rgg+ULqg4HIOOrp
 Z+dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTrbUSIdXTA4TbNv9RG1WRA9CDfTD5y8ZRew3KQ+wPYGTAB81DdRKqti+BuQsPK1PrmJ3Zakm9B0MnO8lE527kCrNajek=
X-Gm-Message-State: AOJu0Ywm5hAbbsanL5zZFetjOj8o8AObfgFxzeDFUpdr/3KeWHSJjcWg
 q9orFr8mRtdKmP/ignLyDYwOsL7R+i1MlLBMYOmjXEJNiqp1JwxXJpsENmtsA+6+/gGmhxv0hDp
 1BgXTZ6lLHuYYyhbRAkrsyd3ug5WTj8VoBZpdEA==
X-Google-Smtp-Source: AGHT+IGOSZ51UUpWlWbhYWiC9ZdKzZSar2gyQ+igUoMId2xpOgticGUN0ifZVWNzBiwV1FhNLrQgTz9YazLapRC6hqk=
X-Received: by 2002:aa7:d6cf:0:b0:564:a4e9:3683 with SMTP id
 x15-20020aa7d6cf000000b00564a4e93683mr278019edr.16.1708706476481; Fri, 23 Feb
 2024 08:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-6-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-6-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:41:05 +0000
Message-ID: <CAFEAcA9Vm7GYiObgdA2CiN=LKCY1yJ2qGTqN-Qx3ZN_-Hsi_9g@mail.gmail.com>
Subject: Re: [PATCH v5 05/41] Add GIC-400 to BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:20, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 167 ++++++++++++++++++++++++++-
>  hw/arm/trace-events                  |   3 +
>  include/hw/arm/bcm2838.h             |   2 +
>  include/hw/arm/bcm2838_peripherals.h |  37 ++++++
>  4 files changed, 207 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

