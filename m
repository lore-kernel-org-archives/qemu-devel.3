Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E603606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JDuWKRLt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3ex-0007H8-1Q; Sun, 25 Oct 2026 15:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL298-00017H-IP
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL296-0007r3-21
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so16837145e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949793; x=1793554593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pVZDcXuwxB2XHshzAUvbr8ZgmjZpIgGIEJq9RatEHk=;
 b=JDuWKRLtvqkVszUl0Tl5SHPbh9uZZxqwX8TriO9wLuUPzwLCmPE3ZtTGOfuR5Nw7dJ
 9Gf+Xa/1A+maJZNab75IMELWfiKhLEajXhnlA1dua4cCw72pnb3vBXEQgsLgjBrl/hxX
 a9zpRASeAhcsJgmIzmnp72tiq7IpJ+68GoO0mVUaUXYZiQB6vLWvdfLHEnAteKGH2uy5
 OHvdmtFiphw844f+SYpQqcLAFgsJ2lIsiCN3wRMjJxMfA9AYIVeAVxFLi6h+JYzgdSxS
 EiKFVDbChExZlI+dAnVO5c+9NuY9Jg0WRCaASkHl7FYZ6kMf93gF9iZdo5EXIxM0ldlN
 kwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949793; x=1793554593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pVZDcXuwxB2XHshzAUvbr8ZgmjZpIgGIEJq9RatEHk=;
 b=1BoG56SokFOngtDjDFD7j2zzE4sfquElihVHiwnrD3WLxjW/80+Z5q6GJ8ttkKv2aE
 z2eq0VwY/xKylq5hl9Szfox3Z973SmDE4ayZOTczdk7lwtAVk4sM/aoAaPUZKilUm6P+
 M7ppJUrpqHuiG+9L4gr63rp4uDD59BV53zw8f6m/mM4hhiq7zDwMK6tGZSXrHokNxZlw
 wFYYXDM60GA3h1OG4o9evRiqYKtlvsni42rW7RU9jbmPVvmJyqLlwCd79lTEzCFgxBLO
 gHTQ8glDnU1paXs7Zw1PMv02cy2TiX2hCK++P9zxHVoHWu02W6/3mKNrxM4PFOhFvy61
 pcpg==
X-Gm-Message-State: AFq9FYJlWm5m1BwshL0/jiVGbD4APUOYD+KINl5un61Uc3Kc+jVAhpqj
 tkFLU8+9DBSceiHeSr8RS1SqnBhfy1H/B4ArvHYHvE5IcdWqt45Jni1ER3OQ
X-Gm-Gg: AYBFou3xItqEFs0Lypk4ZoEtwHWrsPcryLa78ab6EvjXsoiA/JIpFgcPxHpkcfc16fE
 z/xx7dPyj14CjlLOtnZw8qyHI9r9agnKHfJZwUYUG45NAmSZZEO/ENqSNUVo+N1fKm4wggnnB0+
 UONbHVfTI0MrZNFPumpWtCEmJD6kQVSoYTnZz55ePJNWa5miiCcgvYUkxVBTQaqJxmFEyo8c1zY
 tzY+xJ3h/0tNFF0LwkQbGUa5PkBLnIoxxd76CKVNDxemB+6Ejqou39L7BCafRMRhneqctyMh9Je
 wSKIL4y9msbhRoc4LwEzqoS+/osf51sXOiziOXsEpDoNiDAHhb89ncrCLrswqTKswBAaON8SpA8
 riIRIJk8d53k32sxWFPgO0e/XNcF949jwCQXiE4RDjVXwXT5B9ssXx2PEQkqWEMNJsomQ5lC/PL
 GKKyubXjkyNphHPWXmF0YZ8nutQy6AQAr/XXWyJBpH9mwzpXZssloPPsVebFrKz1GBQA5s9h5Kh
 +dRHYOHnmSiMFlqQwJd9xsKx2yOhVzuYMigQsRo3xJTbrJeAQPmH93stlI=
X-Received: by 2002:a05:600c:5908:b0:4a1:d45a:3ae9 with SMTP id
 5b1f17b1804b1-4a35aca41f4mr65530225e9.15.1792949792877; 
 Sun, 25 Oct 2026 10:36:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:29 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 0/8] Fix OOB access and overflow bugs in display,
 audio and SCSI device emulation
Date: Sun, 25 Oct 2026 17:36:17 +0000
Message-ID: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=tristmd@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 15:13:16 -0400
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

This series fixes eight security bugs across display, audio, and SCSI
device emulation backends. All were found by manual source code audit
and reported via GitLab confidential issues (since made public per
maintainer request).

Summary of fixes:

  - Patches 1-2: ATI Rage128 2D blitter integer overflow and
    width-vs-stride mismatch leading to heap OOB writes
  - Patch 3: G364 framebuffer top_of_screen OOB read
  - Patch 4: SM501 framebuffer/cursor address OOB reads
  - Patch 5: NCR710 SCRIPTS engine infinite loop (CVE-2023-0330 variant)
  - Patch 6: TCX blitter source address OOB read (host memory disclosure)
  - Patch 7: Artist display off-by-one OOB read
  - Patch 8: GUS 16-bit DMA heap and stack buffer overflow

Each patch includes a Resolves: tag pointing to the corresponding
GitLab issue. Patches 1-2, 6, and 8 are Cc'd to qemu-stable as they
fix the most severe bugs (heap OOB write, host memory disclosure,
heap overflow).

Tristan Madani (8):
  hw/display/ati: fix integer overflow in Rage128 2D blit bounds check
  hw/display/ati: reject 2D blit when width exceeds stride
  hw/display/g364fb: validate top_of_screen against VRAM size
  hw/display/sm501: validate framebuffer and cursor addresses
  hw/scsi/ncr53c710: add instruction count limit to SCRIPTS engine
  hw/display/tcx: validate blit source address against VRAM size
  hw/display/artist: fix off-by-one in VRAM read bounds check
  hw/audio/gus: fix 16-bit DMA heap and stack buffer overflow

 hw/audio/gusemu_hal.c |  6 ++++++
 hw/display/artist.c   |  2 +-
 hw/display/ati_2d.c   | 25 ++++++++++++++++++++-----
 hw/display/g364fb.c   |  8 +++++++-
 hw/display/sm501.c    | 14 ++++++++++++--
 hw/display/tcx.c      |  8 ++++++++
 hw/scsi/ncr53c710.c   |  6 ++++++
 7 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.53.0


