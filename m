Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8807C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgFyC-0002hV-89; Sun, 05 Jul 2026 02:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wgFy7-0002ge-JA
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:04:44 -0400
Received: from qs-2003d-snip6-5.eps.apple.com ([2a01:b747:3006:204::26]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wgFy5-0007mS-8D
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:04:43 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 8C7993000132; Sun, 05 Jul 2026 06:04:36 +0000 (UTC)
X-ICL-RepId: 019f30e0-f310-7b81-a828-bcbd6598f085
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQBYWwhbBA8fTAxRAkIFVl5ICx0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtaCzMIQXAsDkZ2NHs6Hll1KQBdAUtxWBooCzIOPQNYcVx0Mws4XggZCF0dB1hHFEcODxlaFFwYUw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1783231478; x=1785823478; bh=7eVh8K6uYY22TYxaXYUEJ0BbqBIp0QYHotqoA2T58vc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ib1qXoDm/v8sP7uXxnGTOtFedZYe8v7tQMqGnN5JIbK31+Uath8BdXBCN1q1BCas6tgEIQyBLgAnZNjN6LEO3jCbebEmaaKCa7Xi/8h+SWkXnIaiJNH4+gT1VlJgaLMhHuLq/65oPcrQHNc+J040KF/IHdJYNnEwMJY0kP8j6P6xX7RL8Fo+syB4XFbWXoBh0erKF5wlOx8GJ6AtM0fVadDYQ1gdlA+LIYFMB1ge3Rxc/GTGek/mAbv6zjYAfxeiHDMUYal/mpXqctxY/jPT7MOnFCDdcWdeBJmISWFFIzr7UjwP5X5y/c5Q8VdyAUfpYu5xlctTPJDvQkVPaWwrvg==
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 A2571300008E; Sun, 05 Jul 2026 06:04:35 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v3 4/5] hw/m68k: add working floppy controller for q800
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <ebca8322-0e62-47bd-a4df-d5f52d5d4e39@ilande.co.uk>
Date: Sun, 5 Jul 2026 02:04:34 -0400
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19C19CA9-DDBB-4BB2-83B5-C9B7E05F7FC2@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
 <20260702022927.46510-5-mhjacobson@me.com>
 <ebca8322-0e62-47bd-a4df-d5f52d5d4e39@ilande.co.uk>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-GUID: NR7FHn1t6-d6vNY7bWIV6rSq679s9hez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA2MCBTYWx0ZWRfX1YTm2kjnGQ/p
 1zJakf+Svmiig0v3YonErajLVlr1ieCejmMry4vU664Ber9LS+3y0kd1EJP+AwwO+H2TzQDyWyu
 aTGJ1XAa3UqQyJE2rS0wnPHTaFi5XhJG6HdZNjaN5/Au/MKFRULvYUC++i3DKbDyKgnrQZlAjFg
 pp7zJlsOmshE7aEw/oi97kGC8D7SAs6kDYV+jPZd8ci/FjdLWfvmx63zjMFf9cuRB4cMjly+Ldt
 8ojZyjEMuLbn2a2JAPW1kbR9lu8X3yaD3U0TRbPF8YSM0xJ4SFr/Zh+m3B8bFQDP7ToHyuBIXFr
 9HAJFWaAmj0T0Z2sDkc
X-Proofpoint-ORIG-GUID: NR7FHn1t6-d6vNY7bWIV6rSq679s9hez
Received-SPF: pass client-ip=2a01:b747:3006:204::26;
 envelope-from=mhjacobson@me.com; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks for taking a look.

> On Jul 4, 2026, at 3:30 PM, Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk> wrote:
>=20
> This doesn't look right: in general we should avoid accessing a device =
state struct directly unless it is absolutely unavoidable.

I'll handle this as part of switching to a GPIO (below).

> Can you move this into a separate via1_swim_update(v1s) function as =
done for the rtc and adb devices as below? If possible I'd like to =
minimise the per-device logic in mos6522_q800_via1_write().

Yup, will do.

> Given that SWIM2 is also a TYPE_DEVICE, you should be able to expose =
the sel signal as a GPIO on the SWIM2 device in a similar way as to how =
"nubus-irq" is defined in mos6522_q800_via2_init() but with just 1 =
signal. This allows you to connect the signal with =
qdev_connect_gpio_out() (see hw/m68k/q800.c) and drive it using the qemu =
IRQ functions, which should avoid having to reference the SWIM2 device =
itself directly at all.

Good idea -- I'll switch over to using a GPIO to drive this for v4.

Matt=

