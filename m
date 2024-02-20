Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B77C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXOt-00042n-CB; Tue, 20 Feb 2024 16:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fRXVZQcKCjIYcaZcRWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--komlodi.bounces.google.com>)
 id 1rcXOo-0003yp-Hd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:34 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fRXVZQcKCjIYcaZcRWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--komlodi.bounces.google.com>)
 id 1rcXOh-0008Q8-8k
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:33 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60853aafd93so30134527b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708463486; x=1709068286; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TML7Jy3/d5bJB/Cd6AIs7tWz+tZ5nfzfNhH5YHq9Da8=;
 b=znCDrIPFVxYegOAz1wDAAKEVSA/HvM+jdOV07nTaIVrgR7oBwIZgaOqpI/LNQQ2e49
 GpROOTWbFn5DfJrNq4baToSAB/3wlG5debOb0YA+NVLSn6BKJXzOs039MM36aLz+qtWq
 C9flALSBu8RFcP+/vMWQ23X7XYNRWSZ3I1YZzLB2WJRlYvLvjq4QolLrtZacN7pCYZWO
 ASDHHGyuhDyQNyXWqz73vUezNsD6T3TGLGIQa8tn/BlV2e/ctGNQgTcsQWDFrD3bYmsx
 pMIKOKvlFSsnk4yKCvo5RN72+W5tAD2eGTv2MuNimpmGqvK+Nz5PwmmFOaTmVvWEkVej
 dKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463486; x=1709068286;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TML7Jy3/d5bJB/Cd6AIs7tWz+tZ5nfzfNhH5YHq9Da8=;
 b=rPJ8hwCHVXHYhltA/L/vy9R+iSLxv4G0Ktn1OV7x0laloaRY1NGE+mJNNCZHb5C6cW
 CvFR9KnQgdeVum9R7yJ56aw71oVsAiBDFMcFMhhOZeMFl+g3f0h3luBYowTTZgLpYuBA
 SRIhyGaydE8CWhu9eesrAkbdtxF8g4MVbplYBxNdMoJDGJulb9jL3bw5mSURl/FWyS+U
 scLsnpTP3i6FSPIwcIj+32Euwop0fobY6tDY2wM/6jpgjpzz58SBUVqxjFJnyLQVwHKh
 +VDK7WQdVkuIBd7eYY2Ouexh0jz/oYgkBswkqIDe90rjXGvsun7+EU7yHV4IZpPJiwm+
 V9pA==
X-Gm-Message-State: AOJu0YzYarF1jhr/As5uypYWmCurCy+GfAbBqg2Bc++Ysuj3dFYndWqZ
 dINmBJlCTWs1B+bunnDnfUqK3U/558Cvp3t7vco6P+/PMsx68V4Z62xj8KOLFuqrWMm+vO43Lf4
 IhejGCMLXLbuje3hJdTZZ9sI6CXbHHy1sIrJ1Krh7U6o/KB1oz73lQqJtG9XpFIjG9vMVoYY08L
 dvf+3DmeVU5cO7E0LgGrb0xiu2akiK2CnFeAdV
X-Google-Smtp-Source: AGHT+IGQuCj1kr9h/8hWPu1jC0cbn3plK5nKoOAinU/SB20UCVOrHPa8CKGaLQPE4eWt8JTxEarUAWwSavK4
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a25:ab6b:0:b0:dcd:5e5d:458b with SMTP id
 u98-20020a25ab6b000000b00dcd5e5d458bmr4407537ybi.3.1708463485651; Tue, 20 Feb
 2024 13:11:25 -0800 (PST)
Date: Tue, 20 Feb 2024 21:11:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220211123.2664977-1-komlodi@google.com>
Subject: [PATCH v4 0/3] hw/i2c: smbus: Reset fixes
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, venture@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3fRXVZQcKCjIYcaZcRWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Changelog:

v3 -> v4

Patch 1
- Removed the rest of the I3CBus class definition that I forgot to
  remove in v3

v2 -> v3
Patch 1
- Removed I3CBus class definition, since it was unneeded.
- whitespace fixes
- Changed enter_reset to hold_reset

Patch 2
- Moved pointer returned by object_get_canonical_path outside of printf
  so it can be freed

Patch 3
- Changed enter_reset to hold_reset

v1 -> v2
- Dropped 4th patch "hw/i2c: smbus: mux: Reset SMBusDevice state
on reset". After more testing and Corey's comment, I realized it
wasn't needed.

Original message:

Hi all,

This series adds some resets for SMBus and for the I2C core. Along with
it, we make SMBus slave error printing a little more helpful.

These reset issues were very infrequent, they would maybe occur in 1 out
of hundreds of resets in our testing, but the way they happen is pretty
straightforward.

Basically as long as a reset happens in the middle of a transaction, the
state of the old transaction would still partially be there after the
reset. Once a new transaction comes in, the partial stale state can
cause the new transaction to incorrectly fail.

Thanks,
Joe

Joe Komlodi (3):
  hw/i2c: core: Add reset
  hw/i2c/smbus_slave: Add object path on error prints
  hw/i2c: smbus_slave: Reset state on reset

 hw/i2c/core.c        | 19 +++++++++++++++++++
 hw/i2c/smbus_slave.c | 17 +++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


