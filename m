Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE8BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPRX-0006Eg-Bm; Mon, 10 Feb 2025 03:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRS-0006C2-Tk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRR-00045Q-68
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oFPydi/thWVcFrf6ykPHeR18OD+lG302LPGv1zAztGc=;
 b=HI32oEIcueGAxrL/jGb5WT3kgpocuwMUEt7TtptPcf1exGE/gx5OEjnx0Z+mYR7aIUyqiA
 JY57MeL+BuJ21jAVixmSyKHxEs1UGKdAc/0rhH4Mm8qmtOetYIrx+aKVgV+BzMsOl8kfl8
 nn1KW43WJbrZw7gwRew/HbHrMop8f80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-YlipzA0AMCeo3l3Fqhxjwg-1; Mon, 10 Feb 2025 03:46:54 -0500
X-MC-Unique: YlipzA0AMCeo3l3Fqhxjwg-1
X-Mimecast-MFC-AGG-ID: YlipzA0AMCeo3l3Fqhxjwg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dce0d3d34so1076037f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177213; x=1739782013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFPydi/thWVcFrf6ykPHeR18OD+lG302LPGv1zAztGc=;
 b=r6dg3OMgGSXivKZ+MpjSjIDj7XCcAZSzec7Z9nL/YMtGyjfY4Tbo9BajZYi9HHlmYm
 m0Ub5Tp5Ztk8Z3reAinjRsw+kcdwuVoQsPyNZOLEZRVRdbcI8j1g86khs+ZDRHkqQhWC
 R2gnnJvseH5rPDAfFXcfm1Te9WrqbeWAzpY1l97ElEQA+8tFlxoK+esYbvj2s1hAS6Pu
 QDjcsHtMSZCtQQdEJJ6OOflNkVH7ZUjkZnMGBclnyWHOZd85VQBpwQ4FYLrG1SDpM8Ph
 1gfDlhbEe5kKzXHR1I1f03mDSfbkjqymNwZgpBNuxYPGPzA73YoCJ1juzvZubNlQEVqe
 Qy4Q==
X-Gm-Message-State: AOJu0YwYD09IzWr9brjIQY6rNL501iAFF+yMi8qjwL8xdMny/hKGQG8I
 jrJ9h9E1rro837vJSd7CTg6y1fP7dCKi8LXLcEW2xtAbcyI5/z8XzSUafmhctGj/vnypLXnAtRC
 h2YQTT3B1I2/Fw8EZi4RXYWsyCad9jW8CEwH5RDft08bjNoOPKZzOjeGnT0jfjQmUiNBefo6VKo
 D+AITAvzmNf6CG01iGA9UNgZWUEMSTFZV+
X-Gm-Gg: ASbGncsUnWgrYu4FmIej+nEmZA5ECeIIkaQV25rHopwuon9v0c0bz49bd61+2jtVoWZ
 DVHMABe9q8uUC4aZaHZ8Q7oJTlQpD9DsrueUy6wwNcxZpSfNAJv8/om4L9RqeDnMejmZmKv7GSy
 AYgjhwjsozHB0GbAvrwQFY5RW2caj63mor9RzPhZAzT2DujO/fVBaC7hAIda81Q3aZJvUZWi1z3
 80e5Os7kWIAUlVGEJxUiomF4N/AloGG5MJkmEqNxl1McY36OjD667Vh3kIM+l8kLgxptTNY8gex
 Ytn1AqSkSMI1gV/6iWtOaI0cE2N2dbeYBcc0BcV9u3ahJZtKX9ioyd0aYaUrGMbGmg==
X-Received: by 2002:a05:6000:156e:b0:38a:615c:8223 with SMTP id
 ffacd0b85a97d-38dc90e23f7mr10248369f8f.10.1739177212657; 
 Mon, 10 Feb 2025 00:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsfMhfWccpiancSi+TzQmVuyl/OgtHCzMpnvxK59lNL7W92fJI2NshAJqzYgeH6IacYrJPNA==
X-Received: by 2002:a05:6000:156e:b0:38a:615c:8223 with SMTP id
 ffacd0b85a97d-38dc90e23f7mr10248308f8f.10.1739177211808; 
 Mon, 10 Feb 2025 00:46:51 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dda26c6f5sm3837110f8f.68.2025.02.10.00.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:46:50 -0800 (PST)
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
Subject: [PATCH v3 0/7] physmem: teach cpu_memory_rw_debug() to write to more
 memory regions
Date: Mon, 10 Feb 2025 09:46:41 +0100
Message-ID: <20250210084648.33798-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v2 -> v3:
* Rebased, only a minor conflict in the last patch.

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
2.48.1


