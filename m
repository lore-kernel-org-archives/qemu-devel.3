Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B101606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Em2HVj2E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmJT-0001Ts-S1; Tue, 27 Oct 2026 14:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJS-0001Te-Id
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:22 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJQ-0007Yu-7N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:22 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-36888ae05e7so40609eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127258; x=1793732058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/Xw4P8oYfL1xtc42O+/0mqWFb5e7sOB/XqErLVzAdPI=;
 b=Em2HVj2EERdDO/RN/I4+y+TYTjK3AJ10WelP2mYJFsbrR2WRj7LX7KZ2VN1mPGnQv4
 lLL4xCjcU0qirmrdHDQLzI82XW1yCciCVibrBvtBTAmyBDO8yYzaC0XpY/dIFkNNTmHP
 Qka/fO+vSctwCMJH0uLmZ/EGAG8fugukMntGOpga5u8FZptjVt1UAizyNrMF54YBglPy
 gtKtl0FxWO8sSwj1lq1nSyKdRcL4oczaZCCAs7yE3J/3fr9I+0bWcSaj1zXxIqIG2oQn
 8eVL4Ac8Yb9q5LqMVZU3/5VG6fajvWL1ZgoZCp6ko53Xu0xspxT9D1Vr1S8OKajyJm1p
 Srvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127258; x=1793732058;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Xw4P8oYfL1xtc42O+/0mqWFb5e7sOB/XqErLVzAdPI=;
 b=kYtZbMgYBggxwjZQBWqubUJz6Pn9tYT/w0lXilxFbErmfrHwCo5AHHjaSOtSS2k437
 Y5kqGWHGVvZGY+C3bGcz7Fu5Zy2iD+V9F3gmHEekvWRpkrl6KhlSzefTEYHrnKdCKRnM
 3UlD6rTg8sgc7dHWCmJtDdRWyj1u9+qIIWWfgbNNtn949vUNYYmkWxbPWZt8ZLgqXLPo
 qd1urP9tcErd+p/Ufk6EPyQP0Nmy4otc2GzfaYLSPxxlSDdzxxiJpgLcmYkWiNEKIZa1
 HSFviTpkjsfhTfkQ8erZatd8EIVO9RPiQL2CxO2zDoJjDoJuXCgJuHf0W7/yMb+xVqlx
 1R7w==
X-Gm-Message-State: AFq9FYJp4EkRHaNRfMGM8HcjAuKFEnbZgvHtUlWiJAoBNUqhtZEbRLx6
 0pdtm0v9OXx/1lkWOwyNkwCo4416xIJSy90HVcZzn6HFqwsU4E9B36sUdTbHrWVI2SE=
X-Gm-Gg: AYBFou3NTH46DEOy5hB8dXIYleW7i/L59prlPH+/iMx5PpkqiBvHoksx9qgPQPlUjFC
 nWF6Zg3HpZYMNbwaUJPPAMdWwc5PL/tdJXYEXvuRN3jL1bIhQuMlSuibOq6JdZe103o93ZypkJB
 5j8tUodmzuQa0x8IYaSPRHDYycXUWzTtlL9u9Fee0oufh5u1mcjA3t6CU0PbR/7wi814Gj5IQfE
 oytJXSfwShb0nKhG58vrHN5Hh8/7F4ZrzDGmCwijJwNMjs0u1WklZf6bLopcIoMCQGV2D2+NFCF
 K5hzuDsi5dXszJbRjYr0MUu6YUrSugM5BUatHw9CZAf2BdwRnJbxSQhp91it3K9IMG9KncyIdVQ
 Q9LRJ9IfcM/UbcYtcW0RMjwcVG6gY8ND9InWz1WefoTVz3skaWzJVNSJ9jOzJ/2X9hc6d4Q+rpu
 x+N7uNxUZjOeY5eMH7PwWEtmAq+INoCo/Ovlpa0/EfH/AjUOHfZ9i2ls2O8V+yqsgKJ3s09gdtF
 YK2lC6LuuodtHDSwyo2tcvXYciT1vRSxNCEHTPsEBYBxdLPo/8wlV9dtpCrGe+D1KagG1U+EMPN
 K3dcCglBf1V+d1wNyQYiSBPpilPiKelQy4ItQJdu3MJD4Ime13dK3InUMVDn3p+67+EfKvqHr7D
 AntbockBAxXvbfMZsB5+7gZLyj3znheZ3H8jjuMkwjy/EtYqcBmwZG5DQJTByVfnSMXc/SYM=
X-Received: by 2002:a05:701b:4513:10b0:147:8a40:cdf3 with SMTP id
 a92af1059eb24-1a6ce209ce7mr125864c88.24.1793127257605; 
 Tue, 27 Oct 2026 11:54:17 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6da44c132sm75324c88.18.2026.10.27.11.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:54:16 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: qemu-devel@nongnu.org,
	sarkarsoumyajyoti23@gmail.com
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 0/8] [RFC PATCH v2 0/8] usb-mouse: high-resolution vertical
 and horizontal wheel support
Date: Wed, 28 Oct 2026 00:18:49 +0530
Message-ID: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

This series adds high-resolution vertical and horizontal wheel support
to QEMU's USB HID mouse.

Today the USB mouse only reports whole wheel detents and has no
horizontal wheel. Touchpads, trackpoints and free-spinning wheels on
the host produce much finer, and often simultaneous horizontal and
vertical, scroll movement, but the guest never sees it: the GTK and
SDL ui turn every smooth scroll event into a single wheel button
click and the HID report has no room for anything finer.

Since Windows Vista, Windows supports Microsoft's enhanced wheel
protocol: a Resolution Multiplier feature report per wheel axis and
horizontal scrolling through the Consumer AC Pan usage. Linux
supports the same multiplier through hid-input. This series
implements it end to end:

 - Patch 1 adds a 'scroll' input event carrying the distance in 1/120
   of a detent (WHEEL_DELTA units). Devices that do not handle it
   keep getting wheel button clicks from the input core, one per
   detent.
 - Patches 2 and 3 make the GTK and SDL ui forward smooth scroll
   deltas on both axes as scroll events instead of rounding them to
   clicks. SDL needs 2.0.18 or newer for preciseX/preciseY.
 - Patch 4 derives the report descriptor length with sizeof() (no
   functional change).
 - Patch 5 makes the HID mouse accept scroll events and track the
   wheel in 1/120 detent units. Guest visible behaviour is unchanged.
 - Patch 6 switches the mouse to a report-ID based descriptor with an
   AC Pan field. Boot protocol keeps the 4-byte report.
 - Patch 7 adds the Resolution Multiplier feature report (ID 2,
   physical maximum 120). Once the guest enables it, each wheel count
   is 1/120 of a detent.
 - Patch 8 clears the wheel state and mouse_grabbed on reset.

Sub-count remainders are carried in a residual per axis, so slow
scrolling adds up instead of being dropped. The new state lives in an
optional "HIDPointerDevice/wheel" vmstate subsection that is only sent
while wheel state is in use.

Testing was done with a Windows 10 guest and -device usb-mouse, with
both -display gtk and -display sdl, using the wheel event viewer at
https://domeventviewer.com/wheel-event-viewer.html:

 - Without the series, deltaY is always +/-100 px (one 120-unit
   detent). With the multiplier of 4 from v1 it was +/-25 px.
 - With the series, deltaX and deltaY arrive in steps of 0.833 px
   (one WHEEL_DELTA unit; Edge maps 120 units to 100 px), horizontal
   scrolling works, and both axes can change in the same event.
 - Migration from a QEMU without the series to one with it completes.
   Migration back to an older QEMU only works while the guest has not
   enabled the Resolution Multiplier and no wheel movement is pending;
   otherwise the older QEMU rejects the unknown "HIDPointerDevice/wheel"
   subsection (see the open questions below).

Why the guest cannot match the host 1:1
---------------------------------------

The scroll path is now lossless on the QEMU side: every fraction of a
detent the host UI reports either reaches the guest or is carried over
to the next report. The guest still cannot reproduce the host's
pixel deltas exactly, because the smallest step a USB wheel can
express is one count and with the multiplier enabled one count is
one WHEEL_DELTA unit (1/120 detent). Windows delivers WM_MOUSEWHEEL
deltas as integers in the same unit, and Chromium turns them into
pixels as

  deltaY = units * 100 / 120

so the guest sees deltas in steps of 0.833 px. A host movement that
does not land on a whole unit is split: the whole units are sent now
and the remainder later. For example, if the host scrolls by the
equivalent of 26 px:

  26 px * 120 / 100 = 31.2 units
  sent now: 31 units -> 25.833 px in the guest
  carried: 0.2 units -> sent with a later report

Per event the guest is therefore off by less than 0.833 px, but no
movement is lost over time. Movements that are a multiple of 5 px
(6 units) map exactly.

The remaining per-event differences between host and guest come from
outside QEMU: host and guest browsers apply different scroll scaling
and smoothing, and several host events can fall into one USB polling
interval (8-10 ms) and reach the guest as a single report.

Changes since v1:
 - Patch 4 (new): derive the descriptor length with sizeof() instead
   of hard-coding it (Alex).
 - Keep the report descriptor comments in their existing column
   instead of moving them (Helge).
 - Check "hs->protocol == 1" for report protocol and add boot/report
   protocol comments in hid_pointer_poll() (Helge).
 - Replace the 1/4/8/16 divisor switch with multiplier scaling in
   hid_scroll_counts(); the guest-selected multiplier now increases
   the resolution instead of dividing it (Helge's simplification no
   longer applies).
 - Drop the stray blank line in hid_pointer_poll() (Helge).
 - Move the reset changes into their own patch (Helge).
 - Move the new migration state into an optional subsection, and
   convert queued wheel movement from older QEMU versions (Alex).
 - New input-layer scroll event and GTK/SDL support, so the host's
   fine-grained scroll actually reaches the device.

Reference:
https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-9f79ad7bb66e/wheel.docx
("Enhanced Wheel Support in Windows")

Open questions / known gaps:

 - The descriptor and packet size change is guest visible. A guest
   migrated from an older QEMU keeps the old 52-byte descriptor until
   it re-enumerates the device, but receives the new 6-byte reports.
   Should this be tied to a usb-mouse property that hw_compat_11_1
   turns off? The same property could keep the wheel subsection from
   being sent to older machine types, so that migrating back to an
   older QEMU keeps working after the guest enabled the multiplier.
 - Only the GTK and SDL UIs produce high-resolution scroll events so
   far. VNC, Spice and Cocoa still send wheel clicks.
 - Linux guests are not tested yet.

Feedback on the input-layer interface in patch 1 is especially
welcome!

Thank you,
Soumyajyotii Ssarkar

Soumyajyotii Ssarkar (8):
  ui/input: add high-resolution scroll input event
  ui/gtk: forward smooth scroll deltas as high-resolution scroll events
  ui/sdl2: forward precise wheel deltas as high-resolution scroll events
  hw/usb/dev-hid: derive the mouse report descriptor length with
    sizeof()
  hw/input/hid: accept high-resolution vertical scroll events
  hw/usb/dev-hid: report horizontal wheel through AC Pan
  hw/usb/dev-hid: support the wheel Resolution Multiplier feature report
  hw/input/hid: clear wheel state and mouse_grabbed on reset

 hw/input/hid.c         | 187 ++++++++++++++++++++++++++++++++----
 hw/usb/dev-hid.c       | 209 ++++++++++++++++++++++++++++++++---------
 include/hw/input/hid.h |   8 ++
 include/ui/input.h     |   6 ++
 qapi/ui.json           |  45 ++++++++-
 replay/replay-input.c  |   8 ++
 ui/gtk.c               |  34 ++++---
 ui/input.c             |  82 +++++++++++++++-
 ui/sdl2.c              |  28 ++++++
 ui/trace-events        |   1 +
 10 files changed, 531 insertions(+), 77 deletions(-)

-- 
2.56.0


