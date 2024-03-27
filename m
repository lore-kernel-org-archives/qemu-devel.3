Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2063CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIQn-0001pE-EA; Tue, 26 Mar 2024 21:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIQm-0001nw-01
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:50:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIQi-0007xC-R3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:50:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so4962436b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711504215; x=1712109015;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vy9mtpiZDjnGnwzDy8nFIblwESvxD2vIkBXConD5DXM=;
 b=DhXMmiB8x5guDg1ScOk4Wb5BKHrCrj3Ctcktw3Vo8IlH2z+Z3Uhm5FK1ArRtHe6KsR
 aSYv3SPcPxd67zHDYDF3UdAIsrtB0K47v+T485UxpmNqRsDXdLqVN6NEZg22B/4SOve/
 9DTO/fC1K6mfpgAzrpDT3d2QsRSRKRhnYdvHbzalWl9GFk+oWzCT0MPWE4YvwMloWyNw
 EPbw28W1lfsZ50bDUg6CKzqizcRX9DV8bvHXD3Vcjx5Wgh6C0HFBDZlmJDi8u6JEDXlD
 HfZuGlcu9elEYLRQ+IuTRgQRg5v5DIxzMY52MvhEgCAMHJ3dSCkrqsBD9z2pt9lBzpqC
 dFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711504215; x=1712109015;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vy9mtpiZDjnGnwzDy8nFIblwESvxD2vIkBXConD5DXM=;
 b=M8iy2ky0BO5E4x3nL8UbN3Aq2y2qeIguMqlhFfPi67HBuCcvNuvuRw45eef9rkObsW
 uJGdQY+V/ptYvtKPOC3Y+FSlXxMXtLg52Y4Vh8WAZ23caGKBZtOYng9saW9H8DM4vCDC
 UZluegvDCyFahXM+7PSU7bYjP58qqY90OpK4wBUvonPFnVsYrCC+/O1DvCjBAtNO+WZG
 n4riLGRW3kycwY5FWToWjsmEZcHNJwsan378K2GqXFbDZBrKFTeQPy48W3diHRbEewWS
 Ma5a37GkZxGKteMXtu1rul1Qe3snC5YrBxS1219/J977D+YFMyik+5naNYFK2WP/vVIF
 kNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXchHaHQNVFjYWPhCvQC1lePnCkL5n+BTqOdpXzLY5P3mmAei0SvCUpLbybNS21Do3bmyhEPDgzp5pdgMWlvTVk3Wp2aD4=
X-Gm-Message-State: AOJu0Yxce5oGefb04zxsodhTG+Qic6V2SOu7hAyjhrPgCP0uDVK82NTi
 N/4DJWHWGTUfwJzP+YdRy+eIn92bLuHJatrpGhr07W2/y94EipLcqg9FCEWrSb8=
X-Google-Smtp-Source: AGHT+IHFMC+i6UAHnLjQX5HfLMhKlodZswgOZvoC50/F8cdOX1TVCCIqsPuBcWwLKEPtXJ6GNuN7nw==
X-Received: by 2002:a05:6a20:3547:b0:1a3:bbfa:930d with SMTP id
 f7-20020a056a20354700b001a3bbfa930dmr1054086pze.33.1711504215194; 
 Tue, 26 Mar 2024 18:50:15 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 r6-20020a17090ad40600b0029c68206e2bsm324520pju.0.2024.03.26.18.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 18:50:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for 9.1 v3 0/2] meson: Fix MESONINTROSPECT parsing
Date: Wed, 27 Mar 2024 10:49:20 +0900
Message-Id: <20240327-meson-v3-0-7e6cdef1be8a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACB7A2YC/1WOQQrDIBRErxJcV9FvTGJXvUfpIonafEJi0SIJI
 XevCIV2N8PMPOYg0Qa0kVyrgwSbMKJfs5GXioxTvz4tRZM9AQ41l9DQxUa/0kFZGNse3ACO5O4
 rWIdb4dyJ86HSTJBHDiaMbx/2wk+ixBkleSeAN0LVnCmpOypoP+OEs2feZHUz/b7ixka/FEqC7
 /L3RALKqdFOcy7bVln9NzvP8wO1Hw0N3gAAAA==
To: Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

To: Beraldo Leal <bleal@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>

Changes in v3:
- Ensured meson>=1.4.0 on Windows.
- Link to v2: https://lore.kernel.org/r/20240326-meson-v2-0-d9f9003775e9@daynix.com

Changes in v2:
- Added patch "buildsys: Bump known good meson version to v1.4.0".
- Link to v1: https://lore.kernel.org/r/20230812061540.5398-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (2):
      buildsys: Bump known good meson version to v1.4.0
      meson: Fix MESONINTROSPECT parsing

 configure                                  |   5 +++++
 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
 python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
 pythondeps.toml                            |   2 +-
 scripts/symlink-install-tree.py            |   3 ++-
 6 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240326-meson-b5e2c7a2fb2f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


