Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DD606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfeCWzJm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn4f-0006jN-JW; Tue, 27 Oct 2026 15:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4e-0006ix-Gu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:08 -0400
Received: from mail-dy2-x09.google.com ([2607:f8b0:4864:36::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4c-0003rO-8L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:08 -0400
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35dc2af1f2fso61212eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130184; x=1793734984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=axdW/tOac228P6zOQN88dVIVns6F/k3LcWVq95PJ8OI=;
 b=nfeCWzJm8+yfN6jY1GAfEx+VU0uidFAllF1xxsuXcZPG1r2HnspHLUrlYw6RP2pz/h
 zE7UrKAfNrp0YZUdaEpJU9ezXKecJ8XwszI90TVVxV7Cxt28aMwJiRDLY3IsKNVjQY8I
 r/DZ94nzhDqoR84Pc7oMEMNTBDZhwxBPrymqZOO6YLuYgwvYcRASEi/s8ExKoG5svkTZ
 qTRbmq7r3YvXx/HYCpwl4gFuO3aDitT6W3FP9YMsaqP0gVKztXKQ+cQVvRkFoBNg1atX
 xxws66EpCFyaPAr8p44RNhFUhOqyGcqRMZWtZnE2cL1LKJ+2qEWulFmMROA4NxstdSfO
 Twrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130184; x=1793734984;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=axdW/tOac228P6zOQN88dVIVns6F/k3LcWVq95PJ8OI=;
 b=iqOvPYJ15rwImwdrpPU5OeMMmBV3TFiwoSUre5ZLRdTwcNtZhDyHjqsI97Li2hZ0hv
 McbPPhokYrZ/G1T8UkSYXZUyRDEYlctxXGVZgoqmXN3HaId66C/UdIUYCT6UWxMkHDBr
 UFrU2l5gYDhe9jf/C1vVy/5N3oaSFobwZIRFW8pzYxnUztT4j7kF5nrumeKSJtwBZf2V
 u2hR4Ir21v0nIMUM+B00JfHedM2TCMcfkPyuTa31jiplF6YoK+fy/FkmvxgFpCoNR5es
 XdgtFuiVa5ysUXhVpZ9vChUBMz3ShZDGercVdL4Z3JXdeovDrKAkPj0sHRF6xMTwjfAK
 +TGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwa8Y2Lb8aJC0sz7ge9HKKFKUh/TpNsKzW9tUMYDrGysOsO29cVEJkbgSkUPX01d1TcxOYlh6ApNXhj@nongnu.org
X-Gm-Message-State: AFq9FYLwnF9DDxNKw2uyhZ+YgtVXinAQZLV8LIGpydp81K5UvYeA8MJJ
 LyObi2S6gfE+82fTDot1ZI66fvB3bJ6GJpQqfSUySIuC8BuZan4EhVQz
X-Gm-Gg: AYBFou3pnpSQcgZYlm3rn3o31NtAkrqlR2ev2STZ1ce9/D0u9cqjLCL+/MCAsc51UVU
 glNNyUY/UMytaweopcgpi3tQIo13g3XApMMcd1B6jyBtlAz53Fmo8AFsYwyvmBMSrAqv5SHi6jl
 qQJHVKEBCoKuww1AHl5WCHqD9UZ2owt0zYGZ+7brUppGprHQQ7ZozP6qLcQZccCxU0HFUK0UeKI
 BNBx8ng2EoFgbCshX2GIxG+32Xf3XVV9PtxzB8DWOzQ3XT3XszdLmIOWAtYn9EuM4CtLcdpIA0A
 puEqsCrLQhGNfOa/pDMHPzJXMIRqW2FzoS81X5zHtW/nJ99SGH8+Za1CmkkbOIdJBgrxMsGquPG
 RjVWtl/fDt+pOvWXBq7PKkkmK648dNX+AePXyQXDnrZElGmS+5dZbaLEvOVJtix437j1kJgxPGT
 gsbJUDq6BSq8b2e2jUSvTwVW3zVsccRfCgLwSyoWJdhj4/afX0mITNRwzhU1ORgoruEUyyt2b1H
 +1Sh0O2k8El02VTojYNO2i4mIJSQi0Zp/+X5UkQ2gah0B/HXPTwY7OSxvQzkNpYHEh+YNFdFzCT
 sRmUlm/Dh31bF7rFcjyj75DaE5VdcnZjpV4lOVGlY5ipR3KFf7oldNws/vqL6w43YIWFkFaJrsd
 nj4m/FdrNR28hJJ8ZnaYFpyMXlxm5vdJ6VFxpzjZqeaRy56O4zio=
X-Received: by 2002:a05:7300:fd0f:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-36a20440ad5mr713599eec.32.1793130183934; 
 Tue, 27 Oct 2026 12:43:03 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:03 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 0/8] usb-mouse: high-resolution vertical and horizontal
 wheel support
Date: Wed, 28 Oct 2026 01:12:48 +0530
Message-ID: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::9;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x09.google.com
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

As of now the USB mouse only reports whole wheel detents and has no
horizontal wheel. Modern touchpads, trackpoints and free-spinning wheels on
the host produce much finer and often simultaneous horizontal and
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
   scrolling works and both axes can change in the same event.
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
deltas as integers in the same unit and Chromium turns them into
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
and smoothing and several host events can fall into one USB polling
interval (8-10 ms) and reach the guest as a single report.

Changes since RFC:
 - Patch 4 (new): derive the descriptor length with sizeof() instead
   of hard-coding it.
 - Keep the report descriptor comments in their existing column
   instead of moving them.
 - Check "hs->protocol == 1" for report protocol and add boot/report
   protocol comments in hid_pointer_poll().
 - Replace the 1/4/8/16 divisor switch with multiplier scaling in
   hid_scroll_counts(); the guest-selected multiplier now increases
   the resolution instead of dividing it.
 - Drop the stray blank line in hid_pointer_poll().
 - Move the reset changes into their own patch.
 - Move the new migration state into an optional subsection and
   convert queued wheel movement from older QEMU versions.
 - New input-layer scroll event and GTK/SDL support, so the host's
   fine-grained scroll actually reaches the device.

Changes since v1:
 - Added proper suggested by.

Reference:
Enhanced Wheel Support in Windows
https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-9f79ad7bb66e/wheel.docx

Open questions/known gaps:

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

Feedback is very welcome!

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


