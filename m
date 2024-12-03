Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE461E64A93
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4Y-00080g-PF; Tue, 03 Dec 2024 08:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4X-00080N-Hu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:13 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4T-0001Fl-NI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:13 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2155157c31fso29323255ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232968; x=1733837768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zmI9g/pOOT7yYV6SSPmEYet4Klt+90zecwroUxkyTHU=;
 b=RIXUDHZ23iSzoiCuVilW1xRiR1YtqL/TSuDvxS5dfznfJYChcrPicz6APARXrJ4KX+
 h3xfVdr7dE8MejOuWcTjvKiBQGkATkCyC4ktJMqUo0GFS0H0rvwLmVzFdPR7EmkqK4fJ
 9upQCC3nXnpfqODyQwe1P018FZUYQ6fVHkpmFbKeS3N0sxfhBx2NnlMLb5sGSOM1ndTo
 GWZSMLPl0OVHKvqdvLdid1/WPD5x7jtciYaxE1JMVQLyONAc+sMpbvsfbFoO7IDKhF06
 Vg5DtjPMZ90oJabYtTBI0NZ+k5gMnb+6Dbuij4zBvQIwPjxyK+d6gfIVrUtrKC3P69fm
 av+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232968; x=1733837768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zmI9g/pOOT7yYV6SSPmEYet4Klt+90zecwroUxkyTHU=;
 b=HEXuL81QZaJHmjb2rQoAn2CmbmQurUspWMwVEDM3pw4Mh4z7zUZeyoasB9GKzeR4DX
 Qo7Bhp+q7yGGArUiYiExYKpLwwVQNIQh4ye2r0QJ9aPyWCD7ckdQHlqAr8Uo5+UWbANY
 jkWKE9wqeEEnJSXIBqwGWZMu7HMfMm71yZzaqsedM4OVXz3XgCsGTpT8NiGCstuvbV+g
 FuuSnVQDNXYqST4WHnDVFJG5n5l1ugzSEprqajLEWwSOQZSs3B6AJTVnM6GQtKveZTVQ
 MuC14muavbdUncrPK6dHAZTRIwhoD/O04Yc0kxsImgeqpaIsc+w9QzMzftRqO7/5Yr7J
 jRtA==
X-Gm-Message-State: AOJu0YzyAVgBjQ5MxExXlx2KT8jmIGtpL1f3dOzke7USqi4AJe6YU0Ir
 7jJeq8ndTaYYc+SEIpuZH5gT7Ar/i0fMoFTdEoqx08WoRUMpSacmIqDXtgKzOA==
X-Gm-Gg: ASbGncvob/bT0AVcLL1w+B37TgTQNjqUyrRyzUNCRHcrIeIJiutKffyZrQHiAP/4QW5
 +pCtxRGuoFh9D3Ox4TNH2klARJOgyOfZzvt0Rr56SsJLA7LM5Kvyaha61h0CBj7wRd7UEpAizfq
 Uh5RbjMj3jcY1SZxElzbn9G+mVupyfhfW2g4Zf6jwuaPj4QPhB1Hv3VnuW0sJYiZ0LbCo0wWwxJ
 KX0mHhqpl49GxPh+BfM1ITH5wEX1by9I6or5HBjWs8DPDEUd0CHv9k3VT4=
X-Google-Smtp-Source: AGHT+IHGx5y4qwghcabBpNR9C/Xx+7kvRX/Oz+5IW63TsL2HLZDZMvxuFlj80i+gMSnEL56IhJN4RA==
X-Received: by 2002:a17:902:f610:b0:215:bd3e:613b with SMTP id
 d9443c01a7336-215bd3e62bfmr40671415ad.27.1733232967511; 
 Tue, 03 Dec 2024 05:36:07 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:07 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 0/9] vfio/igd: Enable legacy mode on more devices
Date: Tue,  3 Dec 2024 21:35:39 +0800
Message-ID: <20241203133548.38252-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patchset extends the support of legacy mode igd passthrough to
all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
driver will read this MMIO register).

It also replaces magic numbers with macros to improve readability,
and aligns behavior (BDSM registor mirroring and GGMS calculation for
gen7) with i915 driver to avoid possible issues.

The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
stolen memory size to zero") is also added back so that data stolen
memory size can be specified for guest. It is tested that GMS may
related to framebuffer size, a small GMS value may cause display issues
like blackscreen. It can be changed by DVMT Pre-allocated option in
host BIOS, but not all BIOS comes with this option. Having it in QEMU
helps resolves such issues.

This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
with custom OVMF firmware [1] and IntelGopDriver extracted from host
bios. IGD device works well in both Windows and Linux guests, and
scored 726 in 3DMark Time Spy Graphics on Windows guest.

[1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/

Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
is not working on Gen11+ devices in my experiments. There is no hints
about that in old commit message and mailing list. It would be greatly
appreciated if someone shares the background.

Changelog:
v2:
* Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
* Fixed conditions when calculating GGMS size.
* Added Gemini Lake and Comet Lake device ids.
* Splited mirroring register declaration macro into a new patch.
* Minor fixes.
Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/

Tomita Moeko (9):
  vfio/igd: remove unsupported device ids
  vfio/igd: align generation with i915 kernel driver
  vfio/igd: canonicalize memory size calculations
  vfio/igd: add Gemini Lake and Comet Lake device ids
  vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
  vfio/igd: add macro for declaring mirrored registers
  vfio/igd: emulate GGC register in mmio bar0
  vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
  vfio/igd: add x-igd-gms option back to set DSM region size for guest

 hw/vfio/igd.c | 248 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 151 insertions(+), 97 deletions(-)

-- 
2.45.2


