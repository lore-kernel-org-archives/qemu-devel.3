Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B1AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 13:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATa7-0007wA-MF; Thu, 01 May 2025 09:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uATa6-0007vt-6R
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:04:02 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uATa4-0007uk-Ed
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:04:01 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-707d3c12574so7708357b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746104639; x=1746709439; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQJornPVe5ldMMmwLNqhVEzpHWR+B/YEikdhNfTc3vg=;
 b=qWm/y2TvBAkGRpikx7fwlPEqMHslHmJ6fhc8y9qC2nHk+iwVbJLS/tfWko49hkZqEr
 ZPoO4ugreK1lwjxqf2gdt0G4S7svFLiz3uR7xTi4xXOB9f7S2qdq1AytflW/zgQnZEWQ
 L+52EEu0YJLLfQOONt0Ds69EYrPu2HW6HDQN1N8ngrQUDgJV+XShNRTv4dA+NKMXxVYT
 6Z1OyxJoHF2NXqcQzBfRj7NqKoSJdYga7/6WLVne0M1x+rmDi2tGAkAPgtL5QktxGCPi
 hbHpWF3MtdpmFuzDrT66R+p0X353mcv+JAxYBHxxHlEgdr6lk+Xnvvm5IXDZGsSCa2t5
 2SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746104639; x=1746709439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQJornPVe5ldMMmwLNqhVEzpHWR+B/YEikdhNfTc3vg=;
 b=HRDjyIiXAbhQ9BJO2XbqPZD729+fdwdZNXUKfmeHoKzdKk/iLk3I3K+IYYF82kU0yg
 wESxf5qfxow4Mu0XWP5yz7XrvGtfk6unLuAZOWqhFj/cwrhehSsuLoLNz7oVsD1cZ0By
 dowOUHqCx3UHls9Vm+tVpElwuf4Q2tEpNAzwWRK6G5PIASgoqk/f5iyOWZFqfTQDuRnr
 p3fet4iX8mFE6Bz7vTLXeGxPvYMgOjxAhQ4q/LfbleO31Ewd5V8idzF5OBt5T9KE4y2Q
 MlcO6SDkkPPCSNpxRs5u/dAVfVI06fPLPWejF9TTQDixKi5Unoo8/s/E5MXoz9pHBnW1
 KnBw==
X-Gm-Message-State: AOJu0Yy6VNu7BSQbk9fV71RgEHM7pk9dMRcJTUdueF9muRM6nxhuvVXJ
 5m8+rl6XpsVXBqB8/JueYrJEyGoCEU55CzYyTfqLlSxBWBX1GQTbSOZSeKjm3Htej0tsRrRRYJ6
 6/QFvfKngfAydgctFTk36Dh+crBOKGaBXe6DAeg==
X-Gm-Gg: ASbGncvPLmgNyeh0r1MbS5Mh2qgWyUAr+hbc/1upfumFFVFo0dt1+cQV2G5MVeQVH5Y
 Yt/aytvRg6u6GbPv+PfD3sFu6bRxWIeKyQds/fPuluniivJH2eIKMTy29lmziT1rpgTJNsYT21J
 XQoi4O8QnGiZ56MvZQiFUu18k=
X-Google-Smtp-Source: AGHT+IGquXSUOToVs+OKGwxyfVHaTPpN1n1MQG6GtE3lBt2+qLtBoVk9EbseXNx+l+QzBTST1PUCQVbTBX2aadafduY=
X-Received: by 2002:a05:690c:6104:b0:6fe:c2b4:f099 with SMTP id
 00721157ae682-708bce5e233mr31589247b3.7.1746104638948; Thu, 01 May 2025
 06:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250430154712.57125-1-stefanha@redhat.com>
 <20250430190420.GA65554@fedora>
In-Reply-To: <20250430190420.GA65554@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 May 2025 14:03:47 +0100
X-Gm-Features: ATxdqUGs0WuglevyfDSPx_K1VQbLFhARunX6dl_OTzHlq9wmhpyw23y4PhmKidg
Message-ID: <CAFEAcA9W9-RHE-J4eHUSHbTLKtfVjqyR6A0jAKiN6-fihoPXkw@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 30 Apr 2025 at 20:05, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

We're into 10.1 now so you should update your email template :-)

I have created https://wiki.qemu.org/ChangeLog/10.1 now.

-- PMM

