Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B079FF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cZz-0003YP-1N; Tue, 31 Mar 2026 13:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7cZx-0003Xw-19
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7cZv-0003B3-3L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-82735a41920so1964844b3a.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976912; x=1775581712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TsPQRSmTOs83385vSVuhSH4/+UXE7/8BJmaHbeTXL/o=;
 b=PNBlK0CqKBcDfbnVwqPVRykjDzQFODo0rdqRp+h3bVQ+CCXIOsqOo0vGES9kMUPSZn
 XJoJ3IzQ+zShdDE0D4QPs3ov8fHY9HjZh8+BgGWOFEhgz14K/Z9Pzi34XJXSHLzCoxx9
 03LV1+LP70u4VM/3/4w2mko6OU8W/5Msea9Va35MZ2YkOo8tFJRiV0MKrRnctCfwzWhl
 clUDyetRPbPwTIQjezq2Qsc1vLhhz+IrMMhKw12GJl3BVRdOudpZ6arPJr7Isoo8eNPU
 csHFiY99Z6EeADGLLEqleW6Um2URx4XvwDtw7mBL6YLE3rsgazTKHPUPwqQJCm40dUlo
 HIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976912; x=1775581712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsPQRSmTOs83385vSVuhSH4/+UXE7/8BJmaHbeTXL/o=;
 b=Yq1K1O0hnn5t8FLYzO5yr0PkuF1RY1Pzl25fJD+oTdxq8hyO6lmpYk9Evs/AIH973n
 o7oiVhL6ZJmqI7Nyag5Tr9gMKLWarqQhUH1urxmAUftNjK1ylXbwlqfBFCZUXnj+hj2L
 XHx5/6ywZnFDdV7NWY4n3kKsi12NIexvJHnZ4c6nQYUCH5HKRZmwJBvFFJP8U+0usduB
 IZ5MP49aApob1SF4Mk2bPjPR4zMzfRUTxZDTnmjKk7TLD+kcI9HKgEoRP5GF6e1iMNuR
 Kh+pe3Avg7/SYIo2HEniwwjcq9cgM48KYiZPFIl0olk0Sfy0u8l2izp+B8OVecaNt5sc
 e2OQ==
X-Gm-Message-State: AOJu0Yw9rTvonLrvoRBJh16Ttu1E6Z7Q532Heo9FRKTSpdFKlgL9kkcl
 yhW0I223W/OSZ2oZdcs3xyXD2PGOp2knJ3ayajISOPFGM9plYn2Aoa9KifQucgqn
X-Gm-Gg: ATEYQzzWljLnGTCbLoGnvqpUikAI5AGrr3a1aJJZf/pQXtwxdBp8DTnt3UFwN3xGoOn
 hl+rqdCg/xIrhhoVy8H7TQShK81YGVQrKD/tE7di7jp3nsfvx7+zNmX8O6RiYcVXvNQiB0WnTav
 KK7dx+Y3mm55clDFvZE87ZYDps1VEUAstM8CGeXbccLy2mm+NHJBm6Y87iMXGbKsKNZzFKjMtvN
 JgjcfPZc9Z4mBi0OLNinOH6b3jQrEfnsvL8EuJ4scx6ZwnqhOuPEthPh/h4KChstnWsFHEiqBNu
 1ijCd96c8bzEpZTvwy7e0prJK3++WbGktU8T7YMXEGZPAion7ZOEtAMmFuytuVAtHabZmeluSbx
 om6fIHZXo+bhXSEJau2xjjNWFnYvVQQ8xZURAY/Tc+LgN1vA2/V2n9UCoaU1mqUdai4HIXjMJtT
 sozMT1NiL0hWgsse2bFlbSZy9jRvM64yKyIUeB3mKr2bhMfpOh61/xB3Rr6EZu0hN5y1DJ/1WZC
 acHPSuNea7HkN33NcZl/OKzI/nJHiSAc3W9w71Vk6Hp9gTZ88m2/00moYpY/93pr/xisOq8lg==
X-Received: by 2002:a05:6a00:4fc5:b0:824:9bc5:e946 with SMTP id
 d2e1a72fcca58-82ce8abd4a1mr330627b3a.46.1774976912235; 
 Tue, 31 Mar 2026 10:08:32 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:31 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [RFC PATCH 0/5] Add high-resolution 2D mouse wheel support to USB HID
Date: Tue, 31 Mar 2026 22:38:18 +0530
Message-ID: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This RFC series adds high resolution vertical and horizontal wheel support
to QEMU's USB HID mouse device.

The current USB HID mouse implementation only reports fixed wheel deltas and
does not support horizontal scrolling.
Modern touchpads and trackpoints can generate finer grained wheel movement
and simultaneous horizontal & vertical scrolling,
however guests currently cannot make use of these capabilities.

Windows Vista onward their has been support for
Microsoft's high resolution wheel protocol,  including resolution multipliers
and horizontal scrolling via AC Pan usage.

This series updates the USB HID mouse descriptor and report format to support:
- High-resolution vertical wheel events
- Horizontal wheel / AC Pan events
- Resolution multiplier feature reports
- Simultaneous vertical and horizontal scrolling
- Boot protocol compatibility
The enhanced report protocol uses Report ID 1 for pointer input reports and
Report ID 2 for wheel resolution feature reports. Moreover, vertical wheel scaling and
horizontal pan scaling are preserved across VM migration using residual state.

With this change, guests can receive smaller wheel deltas
such as 25 units instead of only legacy 120-unit wheel notches,
resulting in smoother scrolling behavior in Windows and Linux guests.

Testing was performed using Windows 10 guest and Microsoft's wheel event viewer:
https://domeventviewer.com/wheel-event-viewer.html

Observed behavior:
- Without patch: wheel delta values appear as coarse 120-unit steps
- With patch: wheel delta values appear as smaller increments
- Horizontal scrolling events are reported correctly

Reference documentation:
https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-9f79ad7bb66e/wheel.docx

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Soumyajyotii Ssarkar (5):
  input/hid: add horizontal pan to pointer event path
  usb/hid: add enhanced wheel mouse report descriptor and packet size
  input/hid: emit protocol aware mouse reports with pan support
  usb/hid: handle mouse feature report for wheel/pan multipliers
  input/hid: apply multiplier scaling with residual accumulation

 hw/input/hid.c         | 117 ++++++++++++++++++++++---
 hw/usb/dev-hid.c       | 191 ++++++++++++++++++++++++++++++++---------
 include/hw/input/hid.h |   5 ++
 3 files changed, 262 insertions(+), 51 deletions(-)

--
2.53.0


