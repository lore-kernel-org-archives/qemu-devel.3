Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3E110AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rti-00047T-PZ; Thu, 26 Mar 2026 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtf-00046P-0J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtd-00035A-8s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dz+L/ZFzRhGiV9XvxFRjSQSjVSVWxdMC1Cm3ZHwI0zM=;
 b=Hdz6AxMdQpoGRzSSth83GMzuc4G8p7vAkbbIucPyp/TK8CTYneOlew4cu2kma6YzcURQZK
 8GlFZAEzwz3Q4UBExo7pw658JFmWrCVvWMVgTdA3TQI9ieOHuslCevWHCVlGvNCt6JUiDq
 qqur9Kd/oupfW8Bp0QAd9VCs4DZNwLM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zCJLgHXtONyD0Kh2Uc7v2w-1; Thu, 26 Mar 2026 17:05:37 -0400
X-MC-Unique: zCJLgHXtONyD0Kh2Uc7v2w-1
X-Mimecast-MFC-AGG-ID: zCJLgHXtONyD0Kh2Uc7v2w_1774559136
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfbf800204so57561385a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559136; x=1775163936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dz+L/ZFzRhGiV9XvxFRjSQSjVSVWxdMC1Cm3ZHwI0zM=;
 b=Nh+gIDqH39sD8091eNKxtzrA25ukCZFvABpyGjur5MaNu4PR7PwS29+cSEwc0A1Ebr
 jbpaQl9dd1G3eGClw2PoVo02klJQF774mOZJHBpHlh8iKMpXQsxoNfP5lyTElopbFZl4
 89y8AcVfciwG3BU9kUDTrRmFqfugZNoJzvMZ1BQKXkXN/EMEkp2lW2IkTD4m9qC9QJBL
 NMH1kSNZV3eRNd4kpRhDYvqGWcx63OojkiLS9XB0iYtnMNSOg4WHPUea1jhAJ3BF+9jJ
 TFH2HKwuNCNNZtYdyVpewDZWL01SzWZXeddUp4qMJ0p1Qgl2M/W7GWztpYu+svrqUOTl
 aOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559136; x=1775163936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dz+L/ZFzRhGiV9XvxFRjSQSjVSVWxdMC1Cm3ZHwI0zM=;
 b=mfzJGFb/nU7JvhYUlz/JmuaieAQdPUJ03lKCTxpR23rtjeu4yc0mXGhzHsfknuWLve
 xMWjNvyeFLmnqLkQsXhq33uMK5wKvy1AGxdZVwlDXc9cylVZeLv15C48MAxQotk29V1+
 06O/tzW1SWNMZmI3YvfUURNlhr0oNVGSz5LzE1whB7PxCODm++I4nPUv0/tRPGqlLdr1
 /rBqwZvV2FtrNh+w+fXnoRCTqgi9OfH4o+wGHIyyeIXJSRkiBYjVG/q67Dgi/R59cMsa
 NcNu0QJWcw9xY8twMvOMjoCfIW+F8NYAGXyLeQlZzq40bnkL5H6uIWKTwQFjg+UkBF1p
 YHjw==
X-Gm-Message-State: AOJu0YwWPlgoS9IzBbyWgTD0O0vTOCm1vbHMapLdowVn3GAxsPH6FA76
 5meQ/+UCZ2IqgEnz2I9VvbOiXeXrTnD0WIJX1D8flKAcCOLivtwd/HarrwodjbLKKqsWnxva6vM
 pAikJ1/z4qKAZuVD2DQauvAQ03c899Rz3VCPGZ/okeVLSE1M/QYkKcAbo4Qncnp7c0wH2wt2CXT
 i52XS1pQ21oyX/31Uzoa1SzqNGSeLCmDcwTBfITA==
X-Gm-Gg: ATEYQzyOZ62yJg6DZVHZMGPpkyHbdLv2DnEqKxTx30T5deWP7OYcFm9Ps8UGmz9+h+E
 6mimeZXbrHmOoZVH9aQxIS01NEfrHdEXJQirc9o+KAlcI0lmzGilS1A0fOYIGn+3OwBtG4rbj+Y
 +bA6azhKV0YXkb5NXVmz54/5huL3uX87b8IWc+Ik4leoZuQVtMM6EQncgJMJR5rPZEBNNUdOsQG
 gTgbBCvFJ9/d+sxjdz/ZSommhPvdbM+74obzYhn/bA0Psm9YY8hk+4OzhdYg3rhrRmzUYidFU7y
 UlohRj+3iBwgR2syVqD81ga4qt9fK7OKewlSLZQhh1K67AtGMedeQyzOY0GMaTP7w2pS2Wj+W13
 AiwYyXVV88aU=
X-Received: by 2002:a05:620a:4406:b0:8c7:f79:bd70 with SMTP id
 af79cd13be357-8d001098936mr1219419485a.44.1774559135973; 
 Thu, 26 Mar 2026 14:05:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4406:b0:8c7:f79:bd70 with SMTP id
 af79cd13be357-8d001098936mr1219411985a.44.1774559135326; 
 Thu, 26 Mar 2026 14:05:35 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 00/11] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Thu, 26 Mar 2026 17:05:21 -0400
Message-ID: <20260326210532.379027-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CI: https://gitlab.com/peterx/qemu/-/pipelines/2411892214
    (1 warning, 1 error but looks irrelevant)

RFCv1->RFCv2:
- Collected tags, dropped on ones that has major changes
- Replace word 'dump' with 'save' all across the series [Fabiano]
- Patch 4
  - Replaced it with a new patch to make analyze-migration.py work
- Patch 6
  - Move the error_prepend() into the new helper [Fabiano]
- Patch 7
  - Fix stale comments in vmsd_create_ptr_marker_field() [Fabiano]
  - Recover is_null variable and around [Fabiano]
  - squashed analyze-migration.py changes to make it work
- Patch 8
  - Fix vmstate_check() [Fabiano]
  - Fix comments / English [Fabiano]
  - Introduced vmstate_load_next(), hide ptr marker details, avoid using
    (void **) casts, etc. [Fabiano]
- Added one more patch from Fabiano's RFC series

This is an RFCv2 series.  It is based on Fabiano's migration-staging
branch.  I've pushed this tree here for easier reference:

https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null

This series implements a new vmstate flag that allows real dynamic array of
pointers to be migrated, so that QEMU vmstate core will be able to identify
NULL and non-NULL pointers pointing to any kind of VMSD (or base types),
then properly allocate memory for them on dest QEMU.

The first planned user of such is Alexander's NVMe migration series here:

https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com

This is another alternative to solve this problem.

I tested analyze-migration.py with this version and it works with an idle
dump from the nvme series (after I rebase).

Thanks,

Alexander Mikhalitsyn (1):
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_AUTO_ALLOC

Fabiano Rosas (1):
  vmstate: Stop checking size for nullptr compression

Peter Xu (9):
  vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
  vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
  vmstate: Do not set size for VMS_ARRAY_OF_POINTER
  vmstate: Update max_elems early and check field compressable once
  vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
  vmstate: Introduce vmstate_save_field_with_vmdesc()
  vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
  vmstate: Implement load of ptr marker in vmstate core
  vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC

 include/hw/intc/riscv_aclint.h |   6 +-
 include/migration/vmstate.h    |  88 ++++++++++--
 migration/savevm.c             |  28 ++++
 migration/vmstate-types.c      |  36 +++--
 migration/vmstate.c            | 238 +++++++++++++++++++++++++--------
 tests/unit/test-vmstate.c      |  90 ++++++++++++-
 scripts/analyze-migration.py   |  22 +--
 7 files changed, 408 insertions(+), 100 deletions(-)

-- 
2.50.1


