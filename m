Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C353C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLsr-0004NL-Ay; Fri, 24 Jan 2025 10:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLsn-0004MR-HZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLsf-0005yu-GO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737733558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TKhhKM+q6c110BfGDN5eQvke0FY1lCe9jFU80Za8wsI=;
 b=aVWesNnTtDJICiq6xmFd/Y7ectH+9nf6k+Sc2HphLa6Lo/V1CrEAV0QkfsIqK6T6eiuAP0
 l1qCxLXngqQjtVFu2j8BfovOdbO/plTpKxaAKm3PuAIhWMIPBQOjRxEVMPjmsozCg8ilUq
 MEIadgg2vN83ElcCe4zIgogUR8flyI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-iNhM7f9NOD-DQ9VoM-Pc4w-1; Fri, 24 Jan 2025 10:45:56 -0500
X-MC-Unique: iNhM7f9NOD-DQ9VoM-Pc4w-1
X-Mimecast-MFC-AGG-ID: iNhM7f9NOD-DQ9VoM-Pc4w
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so1025941f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733535; x=1738338335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TKhhKM+q6c110BfGDN5eQvke0FY1lCe9jFU80Za8wsI=;
 b=dseskmwPCSNrEsCR/PC3xxJubGNcLYbeSEHoLX3eNLbLRJ/zZGtboYcfccCR6SrJqP
 O9BKEtgUxk9OjG1hMII8jdTN1LjZdpGKDsDeASJqYz6luFkqapV4QrFmMrcPPJ+33lV4
 JLrE4b67EtOCEc1zrqiZqXiDKFpU+lbSr4p/M9C0wrW85JD0w3pMe8iSTlz0f0N1Msr7
 9qnM2uajDOaaWrE50/JWD3N128nxKIfjhSYBB2DVLoLzFYE2KFthy4/AmWirKlOUsL6E
 q/4xrEc5FncadfFWay7/v+LZAN3Yr1xM8CzQl1kZxP2yMjU41wY/ikQc+oC1VT5trrpQ
 2T+g==
X-Gm-Message-State: AOJu0Yw8tvGv9i41F/qNVmMb11Rwwts/8vPq0huz0QpvTDGfllQ1eW8V
 op+zm4kDm4v/sgO8CxYKLBCA4u8dYFzhtAkht6O5/zCrWWVqhJSJxr3XXoCRxbiVAyhPWsUCR4u
 92TaszaLGXHxifB09qop8rbtL0kVzDG/676AXKZL2OYI3ApksrlbJQ5DHX4sqNx5J0mUPF9y/dT
 nXVQBfxNvK5LLXy+5dUILraaTIyREk7xbBGGfFXw==
X-Gm-Gg: ASbGncsaM7bwn437YPE4bQlIbXE/XLzVw0LPMxNqZqgB8oNwtP7fihaTRF0Tlyp2LsM
 /BfR2x139WHoH2o2GCKfIC0T30zQS8jtpc5ocxK8zcgHo7bLBtJbM8Q4LjtvgkDBeIDRSOoDpD6
 WpDIl6B1s60JAHICtO6a2QWyN2UbmdXXjrP20wc3jwU9HCp3OLAywXSZCu5uK11FP03wkV2YZl7
 ZTBjrCL5uPzV8t0CB0Q2y3lW1k1lIsWNUVlqD3rekqNs+qMvqExU2mbhYxXlVm23l4w8wr1O4lW
 9hVJrC/5P6FB4gJ/S6Zd404Yw8pvMYPtAqJIBM8ZqPTMhSLzpOYo5S8=
X-Received: by 2002:a05:6000:ac1:b0:385:f7d2:7e9b with SMTP id
 ffacd0b85a97d-38bf5673c57mr17514270f8f.30.1737733535454; 
 Fri, 24 Jan 2025 07:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXnJKtyElxWcSSF108buYaRqLjCOgCxGE4D6o2oza4H48oVHlc8Wta/J6VaOdD1uSoGLY9g==
X-Received: by 2002:a05:6000:ac1:b0:385:f7d2:7e9b with SMTP id
 ffacd0b85a97d-38bf5673c57mr17514241f8f.30.1737733535056; 
 Fri, 24 Jan 2025 07:45:35 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1bbc8dsm3030565f8f.72.2025.01.24.07.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:34 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v2 0/7] physmem: teach cpu_memory_rw_debug() to write to more
 memory regions
Date: Fri, 24 Jan 2025 16:45:25 +0100
Message-ID: <20250124154533.3534250-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a follow-up to [1], implementing it by avoiding the use of
address_space_write_rom() in cpu_memory_rw_debug() completely, and
teaching address_space_write() about debug access instead, the can also
write to ROM.

The goal is to let GDB via cpu_memory_rw_debug() to also properly write to
MMIO device regions, not just RAM/ROM.

It's worth noting that other users of address_space_write_rom() are
left unchanged. Maybe hw/core/loader.c and friends could now be converted
to to a debug access via address_space_write() instead?

Survives a basic gitlab CI build/check.

[1] https://lore.kernel.org/all/20241220195923.314208-1-git@zabka.it/

v1 -> v2:
* Split up "physmem: disallow direct access to RAM DEVICE in
  address_space_write_rom()" into 4 patches

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Stefan Zabka <git@zabka.it>

David Hildenbrand (7):
  physmem: factor out memory_region_is_ram_device() check in
    memory_access_is_direct()
  physmem: factor out RAM/ROMD check in memory_access_is_direct()
  physmem: factor out direct access check into
    memory_region_supports_direct_access()
  physmem: disallow direct access to RAM DEVICE in
    address_space_write_rom()
  memory: pass MemTxAttrs to memory_access_is_direct()
  hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
  physmem: teach cpu_memory_rw_debug() to write to more memory regions

 hw/core/cpu-system.c      | 13 +++++++++----
 hw/core/loader.c          |  2 +-
 hw/remote/vfio-user-obj.c |  2 +-
 include/exec/memattrs.h   |  5 ++++-
 include/exec/memory.h     | 35 +++++++++++++++++++++++++++--------
 monitor/hmp-cmds-target.c |  3 +--
 system/memory_ldst.c.inc  | 18 +++++++++---------
 system/physmem.c          | 24 +++++++++---------------
 8 files changed, 61 insertions(+), 41 deletions(-)

-- 
2.47.1


