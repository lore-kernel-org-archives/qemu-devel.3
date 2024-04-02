Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD640C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPO-0007P1-OE; Tue, 02 Apr 2024 07:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPN-0007OI-5e
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPH-0006JI-6f
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CqXTgQBUdIvyYMJTBfhxcVv7+yEIfw3bh7QHrbI9K74=;
 b=bSaR+0iElB11ZcthX5x9UaaokATN7IxzfDS88c0Xqo+5AZmnqzBFKJh+7Yp2OLXYSB5kD0
 8hmrreOtwCvlUBFmk270ZatkIAxWgiucSoz3h7xZY/ozb/oHjfZYYN1lxdCcjPspR/7nY4
 BZftI4MCHxEzZVZP5ogf4lg4Tb9QMS0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-0Glsm8b_NWSWLzoKh7ifKg-1; Tue, 02 Apr 2024 07:34:13 -0400
X-MC-Unique: 0Glsm8b_NWSWLzoKh7ifKg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-414aa7bd274so24733455e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057651; x=1712662451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqXTgQBUdIvyYMJTBfhxcVv7+yEIfw3bh7QHrbI9K74=;
 b=R7GiofV/bLFrqMUm5dga/EBkotdBBwiQx1DsGWS9b6gfz7oep5/O75iFoKJ5Fay8W/
 +/gYHQHxrUD1AUUsxUZov0NucAIJvyc3aoD048EBXewv0TTVvUHYccK9g01iXS9KQjjj
 W/K8KiDkN1IxV5fzuLyTvzwjpY9cOz1YhWGurVLS2PyFbMUBcRXNaJ4/tcTMMjSwmg9u
 E+i+Q6ZLfaTQkakqe+ej0eH8wfpdmTqrqoChHrOR6Q0dj1l/tvizbeg8/je1jzZhlYw4
 tdNsH6HDifrLp0B7F9yfuXgvycDcF21MV2jXelNeMUvBM+oBPVXtdvyzG+M44Pfb5z/4
 Vx1Q==
X-Gm-Message-State: AOJu0YyNjUBiFlIEcUq48ZaNWxDvMZw7g8qMdpnQdMEGW7YAhEnHxPGG
 Yf2EZiy3+r4WQT18siCC3HxgYXZC+5sA+W8Rle98JNULLKwdCmrqXNW7zckldVL/7HaZGtCT9/S
 NYbS0/VIrkw80UQltPMvMReFCq2ZPGzxwKnkDz7+FY18OIjZy4HW5Uh9yjc97eMSlm66EirGGBF
 ZVBwchkLKl43w4amcTywW6wLBbsd8HJvYUig8u
X-Received: by 2002:a05:600c:a4c:b0:413:3941:d9ae with SMTP id
 c12-20020a05600c0a4c00b004133941d9aemr8721992wmq.31.1712057651583; 
 Tue, 02 Apr 2024 04:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg4KTJ2Cl5ZEhr8e3VHfqQOXwHn4SnYRgo3OOUKsuZMGzpo5wCIYnCOthPNe9b1fGTQ3icdg==
X-Received: by 2002:a05:600c:a4c:b0:413:3941:d9ae with SMTP id
 c12-20020a05600c0a4c00b004133941d9aemr8721973wmq.31.1712057651141; 
 Tue, 02 Apr 2024 04:34:11 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a05600c4e0300b004156da408b1sm3433873wmq.22.2024.04.02.04.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.0 0/4] vga: fix assertion failure with 4- and 16-color
 modes
Date: Tue,  2 Apr 2024 13:34:02 +0200
Message-ID: <20240402113408.18048-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These patches (the first three especially) fix an assertion failure
introduced by horizontal pel panning support in VGA.  The assertion
triggers with legacy 4- and 16-color modes, due to a mismatch between
the addresses visited by vga_draw_graphic() and the region that is
passed to memory_region_snapshot_and_clear_dirty().

Patches 1 and 2 reorganize the code so that the "bits" value
(used in turn to check if horizontal pel panning is taken into
account) is available where the dirty memory region is computed.

Patch 3 is the actual bug fix.

Patch 4 is a small optimization that would also hide the bug, by
treating pel panning as disabled in the common case where the
register is set to 8 (bit 3 is ignored in graphics mode).
This one could be suitable for QEMU 9.0 but is not necessary.

Patches 5 and 6 are larger cleanups and optimizations in how the dirty
memory region is computed.  This is enabled by the availability of "bits"
where the dirty memory region is computed; it is now possible for 8-
and 15-bit modes to skip the slow path and only read dirty bits for a
small part of VRAM.

Paolo Bonzini (6):
  vga: merge conditionals on shift control register
  vga: move computation of dirty memory region later
  vga: adjust dirty memory region if pel panning is active
  vga: do not treat horiz pel panning value of 8 as "enabled"
  vga: optimize computation of dirty memory region
  vga: move dirty memory region code together

 hw/display/vga.c     | 152 ++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 81 deletions(-)

-- 
2.44.0


