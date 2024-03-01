Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ABDC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfseQ-0003xB-Ht; Thu, 29 Feb 2024 21:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseO-0003ws-0O
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:28 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseL-0005Oq-RI
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:27 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-68f571be9ddso12292676d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260162; x=1709864962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gMg1xISzMVEC9+nQFn/Ae6nNNVOV1dw9gITKfHRGtRE=;
 b=S95M/cTzoMVWcVmqy7Gdprf+l3BGSz1jZ5w7YT8glzUWhcEMeXg0aiFZX8nWyIeGxk
 bF0/e585X33wuXRz7NyA0nSrBhaM0l1i7cXsiFWypJ+SSacc8F7dD3q6nbyaWIIHcwPX
 1pnP0rR5bAflyEgWrsf6ED+IR0OfSGDmaH9a18O8/aJji9P4dH6j8vPxOMbZTBgIxML7
 PcqaUMhEoI+uOcUAVOep3citwKHvAZ7yfbgTOOv1qOJDzs72Rag90QuRXIBYWRixF2vd
 c+w2Q3bCEFd+IHW9ur3p8zZCsifKOAmmxH0+KrkPkmkm4RXwBXov6K9hn9dzfIdNB+DX
 t+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260162; x=1709864962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMg1xISzMVEC9+nQFn/Ae6nNNVOV1dw9gITKfHRGtRE=;
 b=WBLAojdG3iVXKmo7ndwZ8sDRzpHd5cKpKObaC2pMJ7WNKy4uE9AH/DsXUHRmBWM6+L
 0XI7K5IiL1YFF7/fTuBL3BTdrIWFcesUxvkvyJjuKhktotZMoESYHtOtfPl8xM9KgAj6
 XrIxZAfp5W+yxuZpAr4uiTl7zdAsThXELe6pfXh55ssTvWfCHz9ZComtq2+QR9RUs5ba
 VhcEosY92MJ4BkWvT1bSaaMR3YEGhG35z/MVHqigj2I4woxNrBJpxTiMBgY9rfAoKXzP
 KItFsiTx2QAJjq1gLqtRvsGK7mcPB0cHgRXE/NPZk/JFmn1ZwOs+gGdV43Cq4cX8y1+d
 uvWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVobAUKeuxvm/fP12+Ek0+YMqey6x5y8y3ksWxrY5QK3HkE4sKyCGjXG0Ip+jwnulgvCSEGv58sg+huVeQGsmylNcE24Fs=
X-Gm-Message-State: AOJu0Yy50QIQCrsQHi+d25aqRNT8vb60GIHFS5NyUKGUXlbrlUEWXdqf
 yCNzfF3dSVcAKFrYa1Q6aWbUEnBMUg0S0g3thCcxiodpI+HO0YIeB5fqPh8OYDE=
X-Google-Smtp-Source: AGHT+IFyUgtEWvxf6wivitp6qX5KB0cAQ8WlmcJ8xjq2a5zNNNqQpASsed0jENlnw5hOfLwo6eZCHA==
X-Received: by 2002:a0c:a701:0:b0:690:1e55:f6be with SMTP id
 u1-20020a0ca701000000b006901e55f6bemr478163qva.19.1709260162565; 
 Thu, 29 Feb 2024 18:29:22 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:22 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 0/7] Introduce multifd zero page checking.
Date: Fri,  1 Mar 2024 02:28:22 +0000
Message-Id: <20240301022829.3390548-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v4 update:
* Fix documentation for interface ZeroPageDetection.
* Fix implementation in multifd_send_zero_page_check.
* Rebase on top of c0c6a0e3528b88aaad0b9d333e295707a195587b.

v3 update:
* Change "zero" to "zero-pages" and use type size for "zero-bytes".
* Fixed ZeroPageDetection interface description.
* Move zero page unit tests to its own path.
* Removed some asserts.
* Added backward compatibility support for migration 9.0 -> 8.2.
* Removed fields "zero" and "normal" page address arrays from v2. Now
multifd_zero_page_check_send sorts normal/zero pages in the "offset" array.

v2 update:
* Implement zero-page-detection switch with enumeration "legacy",
"none" and "multifd".
* Move normal/zero pages from MultiFDSendParams to MultiFDPages_t.
* Add zeros and zero_bytes accounting.

This patchset is based on Juan Quintela's old series here
https://lore.kernel.org/all/20220802063907.18882-1-quintela@redhat.com/

In the multifd live migration model, there is a single migration main
thread scanning the page map, queuing the pages to multiple multifd
sender threads. The migration main thread runs zero page checking on
every page before queuing the page to the sender threads. Zero page
checking is a CPU intensive task and hence having a single thread doing
all that doesn't scale well. This change introduces a new function
to run the zero page checking on the multifd sender threads. This
patchset also lays the ground work for future changes to offload zero
page checking task to accelerator hardwares.

Use two Intel 4th generation Xeon servers for testing.

Architecture:        x86_64
CPU(s):              192
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               143
Model name:          Intel(R) Xeon(R) Platinum 8457C
Stepping:            8
CPU MHz:             2538.624
CPU max MHz:         3800.0000
CPU min MHz:         800.0000

Perform multifd live migration with below setup:
1. VM has 100GB memory. All pages in the VM are zero pages.
2. Use tcp socket for live migration.
3. Use 4 multifd channels and zero page checking on migration main thread.
4. Use 1/2/4 multifd channels and zero page checking on multifd sender
threads.
5. Record migration total time from sender QEMU console's "info migrate"
command.

+------------------------------------+
|zero-page-checking | total-time(ms) |
+------------------------------------+
|main-thread        | 9629           |
+------------------------------------+
|multifd-1-threads  | 6182           |
+------------------------------------+
|multifd-2-threads  | 4643           |
+------------------------------------+
|multifd-4-threads  | 4143           |
+------------------------------------+

Apply this patchset on top of commit
c0c6a0e3528b88aaad0b9d333e295707a195587b

Hao Xiang (7):
  migration/multifd: Add new migration option zero-page-detection.
  migration/multifd: Implement zero page transmission on the multifd
    thread.
  migration/multifd: Implement ram_save_target_page_multifd to handle
    multifd version of MigrationOps::ram_save_target_page.
  migration/multifd: Enable multifd zero page checking by default.
  migration/multifd: Add new migration test cases for legacy zero page
    checking.
  migration/multifd: Add zero pages and zero bytes counter to migration
    status interface.
  Update maintainer contact for migration multifd zero page checking
    acceleration.

 MAINTAINERS                         |  5 ++
 hw/core/machine.c                   |  4 +-
 hw/core/qdev-properties-system.c    | 10 ++++
 include/hw/qdev-properties-system.h |  4 ++
 migration/meson.build               |  1 +
 migration/migration-hmp-cmds.c      | 13 ++++
 migration/migration.c               |  2 +
 migration/multifd-zero-page.c       | 92 +++++++++++++++++++++++++++++
 migration/multifd-zlib.c            | 21 +++++--
 migration/multifd-zstd.c            | 20 +++++--
 migration/multifd.c                 | 83 ++++++++++++++++++++++----
 migration/multifd.h                 | 24 +++++++-
 migration/options.c                 | 21 +++++++
 migration/options.h                 |  1 +
 migration/ram.c                     | 40 +++++++++----
 migration/trace-events              |  8 +--
 qapi/migration.json                 | 53 +++++++++++++++--
 tests/migration/guestperf/engine.py |  2 +
 tests/qtest/migration-test.c        | 52 ++++++++++++++++
 19 files changed, 412 insertions(+), 44 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

-- 
2.30.2


