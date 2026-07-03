Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A80DC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfjSm-0000ae-9l; Fri, 03 Jul 2026 15:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wfjSk-0000VX-CR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:22:11 -0400
Received: from mr-2001b-snip6-3.eps.apple.com ([2a01:b747:3000:200::17]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wfjSh-0006C4-RM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:22:09 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id
 EBD81180023B; Fri, 03 Jul 2026 19:22:01 +0000 (UTC)
X-ICL-RepId: 019f296e-4b2c-7a62-ab55-7e0f1abf9ce0
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQBYWwhbBA8fTAxRAkIFVl5UCh0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAsvcTINSARYdEZ2QgE7HlkGWXNdeEwFVRpecEUOSXcscl8LQQs4XggZCF0dB1hHFEcODxlaFFwYUw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1783106524; x=1785698524; bh=YOb/tn2Kfrty0e3ViJl3JB8YDMyIJyiBWio6yHW7XNE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=EHySBGOwN6Hp2uWQm8GbS21AiPvGw/EvPoAqkCmbMslY8tcOrLhGKVVfYp94+oPxzUXiKuMXULpzq8VXGRn0aKz9NMb87Aw9b2rn1uXAzpLex7sa/B9lOE7q8KgoijFdyS6mDrgU4vpl9CgGr+Km6HtVHiDn9jSFdzuS6/9b//HoyQku58mKpFx2i+MJDKJ/tBe1dmn89O8C59zYuDiWTZW8pwvFYv33Mu5iUyiJgR5xJobxJfWa+luDIDJOGNktwrO6nahJBYvbEf+2i1hA8uQmxjsbEx47i63pfkRzvQQkB0a/4sP2m+Zue5mfq5lAelQgpTGZGjWB/0eUcn9Lnw==
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id
 7E10A1800230; Fri, 03 Jul 2026 19:22:00 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v3 0/5] hw/m68k: add working floppy controller for q800
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <49d36fa3-da19-d723-7d05-794bf5d07dbb@eik.bme.hu>
Date: Fri, 3 Jul 2026 15:21:57 -0400
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCB4075C-D28C-412A-A468-5B571DAE4912@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
 <49d36fa3-da19-d723-7d05-794bf5d07dbb@eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-ORIG-GUID: nMuvS0oEOLYsBstw5kIQzkG0-xjBZNwP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5NSBTYWx0ZWRfX2qEeBOMVSaFK
 aPHIIdst1GiScOHs+ckgY0ltM8LDDcwHT2VPUX18kbziLIDai4L+dlbRTIWcwutfOb0J84AZYs5
 fNdWOoY2sBH7vFTkhIDbd03ZCEbJXXJ9xcCjvNHi8Smm3xfKHrXvBz8HUDI9ROt12C+1jwqkJDT
 7is3D4irG/XkcRoFX6XnOnfwHAYekzqRo37jvCXL8eok0K5Ijnm/TxzgLcGL+wEocM1u4FeO//M
 /43LI7WBLQdFlkJ4iX8OYBHDorZE+fOkzweDpCSp0uzbvFvVLcj+Zp9orGYHRA6bMm7lR2Ju2kE
 OcB9IhtNylvOoEKC7yP
X-Proofpoint-GUID: nMuvS0oEOLYsBstw5kIQzkG0-xjBZNwP
Received-SPF: pass client-ip=2a01:b747:3000:200::17;
 envelope-from=mhjacobson@me.com; helo=outbound.mr.icloud.com
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



> On Jul 2, 2026, at 8:26 AM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>=20
> On Wed, 1 Jul 2026, Matt Jacobson wrote:
>=20
> Including a changelog about what's new in v3 here helps reviewers to =
remember what this version is about.

Agreed; I intended to do this but forgot.  Sorry!  Here we go=E2=80=A6

Changes in v2..v3:

- fix cases where the guest could reach an assert/crash with invalid =
MMIOs; the errors are now handled gracefully
- use DEFINE_TYPES() in swim2.c
- fix SWIM2State usage in mac_via.h (by including header instead of =
forward-declaring)
- allow 720k MFM disk images in sony_drive_reset()
- clarify meaning of SONY_CMD_SET_MFM / SONY_CMD_SET_GCR with comments
- in fifo32_peek(), use ldl_le_p() instead of hand-assembling the word =
(and adjust fifo32_pop() similarly)
- various project style conformances

Matt=

