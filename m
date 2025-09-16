Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB39CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZp2-0006un-Tu; Tue, 16 Sep 2025 13:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Y6PJaAYKCh4SO5CHTAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--yubinz.bounces.google.com>)
 id 1uyZp0-0006tf-Uf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:30 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Y6PJaAYKCh4SO5CHTAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--yubinz.bounces.google.com>)
 id 1uyZoz-0008A2-04
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:30 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e96dc0032e6so8297361276.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758045027; x=1758649827; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rVlErkAKc50MZMZDYr0nE/2HAp3uCy7UnfuAK6J/Eh0=;
 b=rOMKTZ+af+6hvOjhhlWUtFxBXQraUdy5JKnA1WOnlsNGOxRhPOPUXikMR1JjC1kaF8
 FpI+z3Eu5MP1diCcreZRYfdFMQD70qv1t6QBRXQeFCBhb/5ovNDQfdI2PIrt99SbcmeA
 9ilkIp9QrT7MYCo2fygapD8HCKzKd9PmTsQbGSgoRHcxvHemB5t0jLWv7vF4F1i9Z3UE
 7EtaVdr4NuXitNYOt80x9r0AAhGdaDhaqZaJ+N0YDqXcjkIUx9P1ON+F93iB/dDpetkN
 7XMISISMkiQUsiyjkilrzAS4UT9M7fgkH92BnyQ0YMrCZ5Bp13Tb4DYLvM+9yzxogQeO
 2i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045027; x=1758649827;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rVlErkAKc50MZMZDYr0nE/2HAp3uCy7UnfuAK6J/Eh0=;
 b=egM/jGwPq/35EHUSPIOI7Mggtzajx3PC79Pm5xeBExUhgznukPt+/hB4fCiHSBLsdu
 0xLGQgS/vr/oQRJKqMeQIsv5177uDFgJK1dwJOp8mhuFp+p+Z5z1P9NU9zOszY7KPISA
 NEIFKQvMudMob7OZHoYxKNSluHOCYY2ewqGZ5GQyO3G7UblICvEZn8m5tSUsg0vDKyBz
 cCPp3XPYzY1OG/8aQH9zgkQRLnBu7c/SxMVb4l0o4owmil0EZuzSKc6Elx5dqaHep+RR
 HzoU1zgovfv5qnkUMvCdwDLk0Ym4EJToUfx9U/qo/OMA0PPZbVUQYPc6xQP1e4Ccv1+G
 vTIw==
X-Gm-Message-State: AOJu0Yxm37v/58T9cPKzm+eorEAaJEFlV5PxP2ELk692jssldQvRUQBX
 rLQVHWCOjqrM8LMT4OHiQg2HbFijGfkNtz3kKiOt5Mtvp3Z8ot9NXotxbqWRhCrfcMGI8Y9P6cE
 Qiu80BIuz9MpVQQqzXcvnTVGEDb2UiOKSPk1uuMUrIHukVZ105xcr/7U16rHZXYnKMiIU+6Qpt8
 T9viTUjrVMmKkgUndVSzHRHp7N7CqaQ/9XL2g=
X-Google-Smtp-Source: AGHT+IGN4ZKUQFs8/oLG+fRBfUoUkdh3rLmQENSz6qpfnt3vqYO84J/Am9XPes8XlzIJeqAS8VC4q2EI/Es=
X-Received: from ybbgr6.prod.google.com ([2002:a05:6902:6206:b0:ea5:bb58:2a02])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2d05:b0:ea4:156d:2cab
 with SMTP id 3f1490d57ef6-ea4156d2eccmr6513816276.0.1758045027069; Tue, 16
 Sep 2025 10:50:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:50:14 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFajyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3cLSxLySRN1Cc8Mc3dTUgqL83GJdg9SkZLNUAxMLsxRzJaDOgqL
 UtMwKsKnRsbW1APUixodlAAAA
X-Change-Id: 20250916-quanta-q71l-eeproms-0ebc6e0486d7
X-Mailer: b4 0.14.2
Message-ID: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
Subject: [PATCH 0/2] Add drive-backed EEPROM support to quanta-q71l
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3Y6PJaAYKCh4SO5CHTAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--yubinz.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Overview of Changes:
This two-patch series introduces I2C EEPROM devices (AT24C64) to the
quanta-q71l machine model, representing the Baseboard, Frontpanel,
BIOS, PDB, and BMC FRUs.

Improvement to QEMU:
These changes enhance the simulation fidelity of the quanta-q71l board.
By modeling the FRU EEPROMs and allowing them to be backed by drives.

Impact (Before/After):
Before:
The quanta-q71l machine model did not include the I2C EEPROMs for FRU
data storage.

After:
The EEPROMs are added to the appropriate I2C buses at their respective
addresses. Each eeprom now can be associated with a QEMU driver backend
by using the `-drive`option.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
Patrick Venture (2):
      hw/arm: add eeproms to quanta-q7l1 board
      hw/arm: enable eeproms for quanta-q71l

 hw/arm/aspeed.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)
---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250916-quanta-q71l-eeproms-0ebc6e0486d7

Best regards,
-- 
Yubin Zou <yubinz@google.com>


