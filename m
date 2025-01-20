Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167B0C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 04:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZjZA-000490-Qf; Sun, 19 Jan 2025 23:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZ8-00048r-Sp
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZ6-0008W7-S8
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737347946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7EUQaw4Ll2a8+txo9+XnUM3XuZIX+56OswJm7XLZiS4=;
 b=ele7wljbBp7vwA5Fzu7G9zSg4C2eJ1QiuHipFrq1tvmQwEN4oR3U2+2keqZ88nV0IRBbat
 vRUhSxcj3wrBCV4l1wb0bWiUHtPwfTszwrHEsGPmm3JoMmDeVcHlks9w9RY2TA4dtivqx/
 figWiQ6z49yxy30X9Z2H0r2TonJAHXM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-B4NI5QdHPeqKtICqqRsYiw-1; Sun, 19 Jan 2025 23:39:04 -0500
X-MC-Unique: B4NI5QdHPeqKtICqqRsYiw-1
X-Mimecast-MFC-AGG-ID: B4NI5QdHPeqKtICqqRsYiw
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-216266cc0acso81508235ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 20:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737347943; x=1737952743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7EUQaw4Ll2a8+txo9+XnUM3XuZIX+56OswJm7XLZiS4=;
 b=ZlUX/sAb9Fn1/NwQ99HdZDfmy2anZ8wv4YrUVQlbU+yCOdu+Te88gsYTliBOYyPU94
 XUtHqiGhOchTGIp2yi1BRvn1LcvRqvEdxn1RozV66s8EgLJ3Bu/1eEUXZcZHxhJeATVm
 zWkzw8YPlbzx4iKTTQ7F0ITxH5Iww1osBOWJlp7HWlA5pocPs3nbcsvW1Hsv+kdpWIwT
 HZ5br5eE8K6UT1Wr6pBM77HUsqrRR9omdMdqE8FUHbLc72tZBJ7qYDwgSllkJAjUyLEy
 lTwT0B/mlUPP24KbtySThjR2wSAL9U2rNNNtgVCqNH6X7SCOTjk5Y5GgkFU/n8rQkNhQ
 /mtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRHrnA1yWZCw1elqVude/0L0yqpBYkXVyMmTdchpEgNl8/1TKIBSzMfmB52tNeVdMLELKBiA2tJ3I/@nongnu.org
X-Gm-Message-State: AOJu0Ywl6Knhpsou8EUb7zBtXP0BrEOhoxIk6iYFd1dUPDkub1csnRhx
 GsAe0FKI+eR/u1O9U7QbsG9Q3u15wTKiW/LHBxxz2dmGcGAilapaSDwvOF60RC1yImEJ+yqLeSC
 2JsMYN2rZ7zQbnniyGkd+HWgjp9QkApXfrTR0o28feG5cY8JDPbQ7
X-Gm-Gg: ASbGncsmdgK0/S68DxJ71vF5s29D37I+zqQ9vVOzgkR+k+GGEWjmOQMFqludYS6/0eN
 NhJXNexgjdbnbX3ZEJAo4n/lkDsnyj7tDioeHkUeRYezj2FuHMtfV9TsSVG2YC6g27/2REyvLnC
 vgKsYRqnjm0flohF5dCn4fPBXlObr7z14oTjtvQ6NiQtBzWR9wJnbpEvZc/VC5N6il3Kv79Uh6R
 n//Pj4Z5gudc/XYcns8a1R4CP6hu3mo3afpPBE0adNHMbAqEdRzGCANiTpXTGF+5ZSh5k8untDZ
 qYPYKM5fEvMobH0K
X-Received: by 2002:a05:6a21:1085:b0:1d8:d5c0:ad74 with SMTP id
 adf61e73a8af0-1eb024c6267mr34606450637.1.1737347943183; 
 Sun, 19 Jan 2025 20:39:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhErxxxw5crfZylyCFSjPQ8b6liaGdQ9u6f4bTLBbFOEQ3RzJMFxr+aYDNtVdXkx3vp0C6iQ==
X-Received: by 2002:a05:6a21:1085:b0:1d8:d5c0:ad74 with SMTP id
 adf61e73a8af0-1eb024c6267mr34606402637.1.1737347942260; 
 Sun, 19 Jan 2025 20:39:02 -0800 (PST)
Received: from localhost.localdomain ([115.96.115.34])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-a9bcc3232a4sm5889604a12.30.2025.01.19.20.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:39:01 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 0/3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Mon, 20 Jan 2025 10:08:31 +0530
Message-ID: <20250120043847.954881-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patchset enables DMA interface support for writing fw-cfg files in
libqtest. The first patch is just a code refactoring so that fw-cfg
directory parsing can be part of a separate helper function.
The second patch is the actual patch that introduces two new apis for
writing and reading fw-cfg files using DMA interface. The apis are
tested by writing a new basic qtest for vmcoreinfo device in patch 3.

$ MALLOC_PERTURB_=255  QTEST_QEMU_BINARY=./qemu-system-x86_64  /workspace/qemu-ani/build/tests/qtest/vmcoreinfo-test
TAP version 13
# random seed: R02S33ea0ae4568aae69a6191a97e6ea37fc
1..1
# Start of x86_64 tests
# Start of vmcoreinfo tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-267380.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-267380.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -device vmcoreinfo -accel qtest
ok 1 /x86_64/vmcoreinfo/basic-write
# End of vmcoreinfo tests
# End of x86_64 tests

CI pipeline is green with this patch series: https://gitlab.com/anisinha/qemu/-/pipelines/1629670893

checkpatch is clean:

$ ./scripts/checkpatch.pl patches-v6/*
Checking patches-v6/v6-0000-cover-letter.patch...
total: 0 errors, 0 warnings, 0 lines checked

patches-v6/v6-0000-cover-letter.patch has no obvious style problems and is ready for submission.
Checking patches-v6/v6-0001-libqos-fw_cfg-refactor-file-directory-iteraton-to.patch...
total: 0 errors, 0 warnings, 80 lines checked

patches-v6/v6-0001-libqos-fw_cfg-refactor-file-directory-iteraton-to.patch has no obvious style problems and is ready for submission.
Checking patches-v6/v6-0002-tests-qtest-libqos-add-DMA-support-for-writing-an.patch...
total: 0 errors, 0 warnings, 175 lines checked

patches-v6/v6-0002-tests-qtest-libqos-add-DMA-support-for-writing-an.patch has no obvious style problems and is ready for submission.
Checking patches-v6/v6-0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exerciz.patch...
total: 0 errors, 0 warnings, 111 lines checked

patches-v6/v6-0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exerciz.patch has no obvious style problems and is ready for submission.


cc: kraxel@redhat.com
cc: farosas@suse.de
cc: lvivier@redhat.com
cc: pbonzini@redhat.com
cc: armbru@redhat.com
cc: philmd@linaro.org
cc: berrange@redhat.com
cc: qemu-devel@nongnu.org
cc: farosas@suse.de

changelog:
v3: first working version of the patch.
v4: refactoring without any new changes put into a new patch.
v5: a new qtest added to exercize the two new write and read apis.
v6: minor, coding style changed to standard qemu func prototype style - 
phil's sugestion. tags added and rebased to the latest.
  
all along, other review feedbacks has been taken into account.

Ani Sinha (3):
  libqos/fw_cfg: refactor file directory iteraton to make it more
    reusable
  tests/qtest/libqos: add DMA support for writing and reading fw_cfg
    files
  tests/qtest/vmcoreinfo: add a unit test to exercize basic vmcoreinfo
    function

 MAINTAINERS                   |   2 +
 tests/qtest/libqos/fw_cfg.c   | 202 ++++++++++++++++++++++++++++++----
 tests/qtest/libqos/fw_cfg.h   |   6 +-
 tests/qtest/meson.build       |   1 +
 tests/qtest/vmcoreinfo-test.c |  90 +++++++++++++++
 5 files changed, 277 insertions(+), 24 deletions(-)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

-- 
2.45.2


