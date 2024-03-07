Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6754AC54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riArz-0004OS-RC; Thu, 07 Mar 2024 05:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riArv-0004NB-Ux
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:20:55 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riArr-0006qO-G2
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:20:55 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c1ec2d05feso299638b6e.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806850; x=1710411650;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUIoAxak06g1eA3FZ4SX1yMCOAyq07X3SYL1Av4lwIY=;
 b=X7YhvUqs8DETveIOP544c2a4j3EIVT+eruIrDQWCk1yw7TkNlexpMi9YyIl9CAjk9d
 EMJI4aT6CR94JeC969MT6QiVJziKOIqr3u4gI0fSoA4dYrGVqw3OkusN8gqU1z6x1+OE
 EpxlVQ8X1mNIpe2YDsr/pf6zMEk3ojNGnrWFuv1B6RKloszy8PvwHsT4lz//DLNOiYEM
 cY046sYCMDpV0HmmVcFDjRZWpii8YmbXkL4y1HRoeWrS6Pfb061XBBAzY2lKoDT0vrqs
 e1O4fTUFBJRU0lFDypww0sSqmdqcqhUDcfM58k3pHbQqrNq8KFF93z3eivEu6qx/SZu4
 bl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806850; x=1710411650;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUIoAxak06g1eA3FZ4SX1yMCOAyq07X3SYL1Av4lwIY=;
 b=L6vIa94rLrY+Ed6cN6uxYHTFQ/w+R0W9eXKEKK1CcaFw46GqEE+8YMRfJExB5E6IuU
 5GQPHqnEW1kSFooomtXOtpiNgkNq6Tm6CXqyFka9wnj7To7OYE5lLhKAuROaUJyozyKn
 bNsDNwOn5kNvP0fgYP/by4gq+EYrpdoMrPkiJtKqYAPjdlVXGgKpDGBLLZN85G6sAUvS
 oepnvZ7AL/M0QS0fIRODT3PBL2185xBcVcp3pZ/7vJHmaKwRLVnToAxRlYEmI29Gwg8M
 aqge1tDvWXINBgElhOcdJ+2QD3sEkd8ARJHXGd+VvJc+cCLawqPywmGf9Xe+gmQJyZdX
 Iubw==
X-Gm-Message-State: AOJu0YwNzfjLUUxW/3k3B4TxCBWtbeZPXnSn1Zmd7FX6NYFMpri6WI1m
 92U4ieaEcqx0++rxmI+r+U4rjGRV4J3qfF7gF31eKBDG4mnmx8I6nT1ouG4K/tc=
X-Google-Smtp-Source: AGHT+IGimWN6ioy3F3yA1caxgIfXqumVFEZ+Kqhm5kqbYqf/vnP1o3JfU2UwS205OmFTuaupTdDTnw==
X-Received: by 2002:a05:6871:7a03:b0:21e:e6d1:616c with SMTP id
 pc3-20020a0568717a0300b0021ee6d1616cmr8507099oac.31.1709806849869; 
 Thu, 07 Mar 2024 02:20:49 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 s189-20020a632cc6000000b005dc507e8d13sm12348737pgs.91.2024.03.07.02.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:20:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 00/19] contrib/elf2dmp: Improve robustness
Date: Thu, 07 Mar 2024 19:20:43 +0900
Message-Id: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPuU6WUC/2XMTQ6CMBCG4auQrq2hnTKCK+9hXFQ6lSbyk2IaC
 OHuFhIF4/KbzPNOrCfvqGfnZGKegutd28ShDgkrK908iDsTN5OpVCmkgtPTSlN3XGjUWSZsjgg
 sfneerBvW0vUWd+X6V+vHNRzEcv004NsIgqf8ThpRFZaA8GL02LjhWLY1WyJB7mG2QRlhjtZKg
 aANyD8Ie4gbhAjNSRGWYLQqyh84z/MbfydH8hEBAAA=
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

elf2dmp sometimes fails to work with partially corrupted dumps, and also
emits warnings when sanitizers are in use. This series are collections
of changes to improve the situation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Remove unnecessary !! idiom (Peter Maydell)
- Link to v3: https://lore.kernel.org/r/20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com

Changes in v3:
- Split patch "contrib/elf2dmp: Conform to the error reporting pattern".
  (Peter Maydell)
- Stated that the relevant value is little-endian in patch
  "contrib/elf2dmp: Use lduw_le_p() to read PDB".
- Added a message saying "Build it only for little endian hosts until
  they are fixed." for patch "contrib/elf2dmp: Build only for little
  endian host".
- Added patch "contrib/elf2dmp: Ensure phdrs fit in file" to fix
  https://gitlab.com/qemu-project/qemu/-/issues/2202 as patch
  "contrib/elf2dmp: Clamp QEMU note to file size" was not really fixing
  the crash.
- Link to v2: https://lore.kernel.org/r/20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com

Changes in v2:
- Added patch "contrib/elf2dmp: Remove unnecessary err flags".
- Added patch "contrib/elf2dmp: Assume error by default".
- Added patch "contrib/elf2dmp: Conform to the error reporting pattern".
- Added patch "contrib/elf2dmp: Build only for little endian host".
- Added patch "contrib/elf2dmp: Use GPtrArray".
- Added patch "contrib/elf2dmp: Clamp QEMU note to file size".
- Changed error handling in patch "contrib/elf2dmp: Ensure segment fits
  in file" (Peter Maydell)
- Added a comment to fill_context() that it continues on failure.
  (Peter Maydell)
- Link to v1: https://lore.kernel.org/r/20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com

---
Akihiko Odaki (19):
      contrib/elf2dmp: Remove unnecessary err flags
      contrib/elf2dmp: Assume error by default
      contrib/elf2dmp: Continue even contexts are lacking
      contrib/elf2dmp: Change pa_space_create() signature
      contrib/elf2dmp: Fix error reporting style in addrspace.c
      contrib/elf2dmp: Fix error reporting style in download.c
      contrib/elf2dmp: Fix error reporting style in pdb.c
      contrib/elf2dmp: Fix error reporting style in qemu_elf.c
      contrib/elf2dmp: Fix error reporting style in main.c
      contrib/elf2dmp: Always check for PA resolution failure
      contrib/elf2dmp: Always destroy PA space
      contrib/elf2dmp: Ensure segment fits in file
      contrib/elf2dmp: Use lduw_le_p() to read PDB
      contrib/elf2dmp: Use rol64() to decode
      MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
      contrib/elf2dmp: Build only for little endian host
      contrib/elf2dmp: Use GPtrArray
      contrib/elf2dmp: Clamp QEMU note to file size
      contrib/elf2dmp: Ensure phdrs fit in file

 MAINTAINERS                 |   1 +
 contrib/elf2dmp/addrspace.h |   6 +-
 contrib/elf2dmp/download.h  |   2 +-
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.h  |   2 +-
 contrib/elf2dmp/addrspace.c |  63 ++++++++++-------
 contrib/elf2dmp/download.c  |  12 ++--
 contrib/elf2dmp/main.c      | 168 ++++++++++++++++++++------------------------
 contrib/elf2dmp/pdb.c       |  61 +++++++---------
 contrib/elf2dmp/qemu_elf.c  | 150 ++++++++++++++++++++++-----------------
 contrib/elf2dmp/meson.build |   2 +-
 11 files changed, 238 insertions(+), 231 deletions(-)
---
base-commit: bfe8020c814a30479a4241aaa78b63960655962b
change-id: 20240301-elf2dmp-1a6a551f8663

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


