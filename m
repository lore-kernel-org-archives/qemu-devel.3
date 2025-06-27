Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F30C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8UT-0002HG-C6; Fri, 27 Jun 2025 08:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8UP-0002GU-HP
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8UL-000170-FU
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751028444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OnkoSp8MaM3c36dMHwBm3b1g4nNtVUcFSvR7bcGs9l4=;
 b=OdZX6NjlCsb3KVFqLtOcth0PI7yfv3nA876nLNAp1IMc43uYErjeO0+Yn2K2aAfHhL5w06
 Pq8uMmC8Wu1CguT6k7F1jDWt8a482X8rki5Z504gxZIfRKD4wVw0I0x2uTQ3TVX1Zlrcn1
 C8bAtELlNvTE6KtJnleb8jnNMXld9Vs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-f0Lie4u-NoKeldByIrf3mQ-1; Fri, 27 Jun 2025 08:47:23 -0400
X-MC-Unique: f0Lie4u-NoKeldByIrf3mQ-1
X-Mimecast-MFC-AGG-ID: f0Lie4u-NoKeldByIrf3mQ_1751028442
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2349498f00eso26343735ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751028442; x=1751633242;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnkoSp8MaM3c36dMHwBm3b1g4nNtVUcFSvR7bcGs9l4=;
 b=O0zc7EzyJxL3ev/HT3911aMD0k9wHr17c2b6yO8w2EqEDJamu3eLs2+C36AnhX4RCr
 cZIyrEM5vnFh88ylIaexCZ9CSWucrCcFHbfVASkJYn+nkoYSOJvFXi1dyDyeqE8kJn7p
 3qfGRxxPMYa+ehP3OS+EvbvjiTo7upe4l0g7sR7Kvc0W/mTXeujeH8RaxYNZfVzI66aT
 6i5nIdgT6NKZTOI/UTEeJL3n4zPZa2ALAHQAh7/ernxBWH5iRzOC4jDO4VkpZZ98CdPS
 XmuiaBkwXDmh1t7LR0arrSWh8YFb7xa0EhyyBbGZx24CAavzx2PqJPvicmDm9Jh7K/2+
 Sjow==
X-Gm-Message-State: AOJu0Yw0daGLg+tH7cA528xcgq1yrTcjZ0Ue67LFdDQbwboyAUSWuA0D
 /F6AG9h6ElRXlxH6Ka9VWW4izpm14Ax/bnu7bxLvi3PAzjxZtzSM0sgjR2Cl9AEyVKL0Y/ZxxcM
 0zYvBP8j90pADsVecb2zGuDZ3E1sg5lNU4ksCz70tydHu9yA6IBZt/4wN
X-Gm-Gg: ASbGncvU6wk+7Pd6R/auB7tnmudLqE/ldBBPL6n1K5v/YZqez8B2NnZ0Za6tjTijrPA
 ad2gnwICQK1edaGITIuy/tzYdNMC4SwVn0wB1T+I+qrsYkPdIUX6sstEa9Q5MH2nmyUc+MJirZU
 xFBTL2jftjVrxZYRFN0mFs+ZqdDvT+r6nNXaGpVNVRum7R6fLFdSDQKifkm1DpzVXl0n4xuyAnt
 mCveFcu4HlADl5sYWcONkw+reH/i+EnRLuhEg+86Byla+weuvOLiK4ir6dBPTjy/r51bnDpxOcb
 JjgKUQRDzkhCxn9aoF+PmLUn/uWoBWUZ
X-Received: by 2002:a17:903:8c6:b0:232:59b:5923 with SMTP id
 d9443c01a7336-23ac6375c83mr50971435ad.23.1751028441928; 
 Fri, 27 Jun 2025 05:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLP0JYAlMi7vxN7xAWhcEYfi5ScDGLTaBzPhQ9ta2HEgdZuJqOUnYTIE48MubBlmgiMTsCQ==
X-Received: by 2002:a17:903:8c6:b0:232:59b:5923 with SMTP id
 d9443c01a7336-23ac6375c83mr50970925ad.23.1751028441464; 
 Fri, 27 Jun 2025 05:47:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bfcesm16731575ad.135.2025.06.27.05.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 05:47:21 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v2 0/2] migration: propagate vTPM errors using Error
 objects
Date: Fri, 27 Jun 2025 18:16:57 +0530
Message-Id: <20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGSXmgC/32NSw6CMBRFt0Le2Jp++Cgj92EIqfRBO4A2r02jI
 ezdygIcnpPcc3eISA4j9NUOhNlF57cC8lLBZPW2IHOmMEguG97KmgXyQS864ZjCOiKRJ/aaa43
 tJJVRHMoyEM7ufVafQ2HrYvL0OU+y+Nn/vSwYZ1J0or51urkr8yA0Vqfr5FcYjuP4Ak6gAMa3A
 AAA
X-Change-ID: 20250624-propagate_tpm_error-bf4ae6c23d30
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=armenon@redhat.com;
 h=from:subject:message-id; bh=zEH3XEzHJHJmnX/DkwHw7J/m8IwDLMhcK5yMSZxvtMA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bcpHP7JIUOCF3e6FMp/mv9hFq5VpUpfiF8+954HhBlZ
 16+1elBRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIn0L2D4X9l1aPrXn6ufvVco
 8/ygkqrz/67lgUt6DVM5nuZ8K2GzNGRkeBLFfzSO52cuz26Z9xtCz+VyLxK/vGlCg3pC7sR2+wn
 SLAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, when a migration of a VM with an encrypted vTPM
fails on the destination host (e.g., due to a mismatch in secret values),
the error message displayed on the source host is generic and unhelpful.

For example, a typical error looks like this:
"operation failed: job 'migration out' failed: Sibling indicated error 1.
operation failed: job 'migration in' failed: load of migration failed:
Input/output error"

This message does not provide any specific indication of a vTPM failure.
Such generic errors are logged using error_report(), which prints to
the console/monitor but does not make the detailed error accessible via
the QMP query-migrate command.

This series addresses the issue, by ensuring that specific TPM error
messages are propagated via the QEMU Error object.
To make this possible,
- A set of functions in the call stack is changed
  to incorporate an Error object as an additional parameter.
- Also, the TPM backend makes use of a new hook called post_load_with_error()
  that explicitly passes an Error object.

While this series focuses specifically on TPM error reporting during 
live migration, it lays the groundwork for broader improvements. 
Most methods in savevm.c that previously returned an integer now capture 
errors in the Error object, enabling other modules to adopt the 
post_load_with_error hook in the future.

One such change previously attempted:
https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html

The series does not necessarily have to be applied in 1 go. Each patch
can be compiled and tested separately.

Resolves: https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
Changes in v2:
- Combine the first two changes into one, focusing on passing the 
  Error object (errp) consistently through functions involved in 
  loading the VM's state. Other functions are not yet changed.
- As suggested in the review comment, add null checks for errp
  before adding error messages, preventing crashes. 
  We also now correctly set errors when post-copy migration fails.
- In process_incoming_migration_co(), switch to error_prepend
  instead of error_setg. This means we now null-check local_err in 
  the "fail" section before using it, preventing dereferencing issues.
- Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com

---
Arun Menon (2):
      migration: Pass Error object errp into vm state loading functions
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c |  39 +++++++------
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/vmstate.h |   3 +-
 migration/colo.c            |  13 +++--
 migration/cpr.c             |   2 +-
 migration/migration.c       |  19 ++++--
 migration/savevm.c          | 137 +++++++++++++++++++++++++++-----------------
 migration/savevm.h          |   7 ++-
 migration/vmstate-types.c   |  10 ++--
 migration/vmstate.c         |  44 ++++++++------
 tests/unit/test-vmstate.c   |  18 +++---
 18 files changed, 182 insertions(+), 128 deletions(-)
---
base-commit: 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


