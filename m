Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD885606A6D0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pt3CyTyI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3Tp-000768-ML; Thu, 05 Nov 2026 14:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3TW-00073F-Dy
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:20 -0500
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3TU-00023I-Ig
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:18 -0500
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1ae18eb9b69so2402799c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908214; x=1794513014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C4EgeH4l0uyLYKeF5zJdc4rnfEQB3gJLz5sUJ+eP1Ak=;
 b=Pt3CyTyIZdRSTBcgwWM3srnQWtSc9yhbemNr2c56DGb5RwUgXt2LNcKeVs/be5r6HG
 OWwLAofLvgiMIjqoiC+xOP1fEpJd4prCo7x3GjpDCUIxCDxUHc9+9Tbwcc/dnva4xzWp
 6uu/KxQBy7Cvw6z1yR1e/FAnAhfFhmuh/j5gIqFWQgfd1P7S6VzhEr4Y4gU2g8OiipIS
 ofC68YYA3qP9URL8n5y9/zh6JyYbPqLAwg+pKIIShz8BNh/ZSKTmblgT45cEk/hthPAS
 Wp+ARpiKuBcJzW7wbO4eSrHyNHpr9sh+3DJUMCmFd4cSJ5D/PG1cSn5RB8URFl6h2LNA
 X5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908214; x=1794513014;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C4EgeH4l0uyLYKeF5zJdc4rnfEQB3gJLz5sUJ+eP1Ak=;
 b=E1x3aOi8mLXZugnwG9OJISC8I9amZt78jHdBXk4SorNGLUKbk6LVTLAkzyhkj9mmAE
 eCLgQLVWMt21x2tFtwU9ZD8x2qV7Pm0cwLrYRZICPx3AhTTH9UwlRgaa/2MNcPehDkwT
 bIOO6nPON0qISIvWbE552fcDdbDE7fMxtr0LdIldRjmqZM8mW3JNFRdpXQRvAprYyNGf
 1iM5ugKptUCXWMwov1UnCaywwqaxT3SmGFycIRCb625jAtHPABvghdyVhVdJqxD4tZdJ
 wkoK1cBnIQOTsSji8Eo4geR7SzJlRG/NDPKQFbchYVolgLPkavuGBJJEKahIG1Hl1O0i
 wuBg==
X-Gm-Message-State: APuU4Z/s2CBepSu0GOKqNpLPRPXEECx5p2GG7WlXoZpeesQkHwCVOMpc
 GAIFArZPJfqxlXG5ldxc5FS8npPYf11OXzHjB4AEBg/46pNWh/AZlhRn0Z5nnwKGseY=
X-Gm-Gg: AYBFou1q9BMzwHpz5KqWfL2MLRNoGJU9lAkyrfme/fM57pOVX8SHdvE2TDDpgcEhsEs
 Ng7M1BwE33JNHT3/2NxIkI+ViWtt0hlCyzqCSKi3sh7cB2OxebBiKReHu7Hh5GzhUN/ns+Hj+0N
 TiRNtFZbDMR4eZa6PlKvY9CtbvXsDLZVIWmAkJdQtI7cgUJp0kHlAx4n7OqD3A16o/mENztConU
 v+z2+1ZQezAGRwrjZLYlgncYx0hGjoDgILM4eMV/jNPn6N/vCE9FJCkrYZh9eBiWkI5IM6nawDN
 PQF035EMgrTltPXxNHUfligZAF/oCXhI0H9IcQmrQ7dPaTm7HMTDiVTM6eK4Q0MAE/uyPlZ21+w
 JFhS6ehRppK3X4mL8GLs4DI2ATyyriu7+KnO49TMkkwFYc9yWDRKj7CFSXu457LINUYmM+X8Eo5
 SkQvfZPFKsfOqakEXHrrwLH7VCXvp9yyPXyDIPdz5o2b1B9YhTH3hawRqPHNRNCaW8b67KpaMNN
 bpgDRZtYeSAWXn0BeY+MbXWXZAQEMyWgElSf9n4DnSVvnFVteWlsOfWCl8nbcYFcd7ty65Nnoj7
 anddtuFJjp3cp7u6JlTkhpPRd+V6+CdPUkVAz8KO4hqaWLTUF7UyMdEnv+MMPm5DJU6lPw==
X-Received: by 2002:a05:701b:2318:b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-1b25d359e6cmr8228c88.41.1793908212648; 
 Thu, 05 Nov 2026 11:50:12 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm19459875c88.4.2026.11.05.11.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:50:11 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org
Subject: [PATCH v2 0/4] hw/(pci/scsi/virtio-mem): Avoid call to target_info()
 in class_init
Date: Fri,  6 Nov 2026 03:49:53 +0800
Message-ID: <20261105194958.1117-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1230.google.com
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

With the multi-target work, the goal is to move to a single
unified QOM tree that applies universally across all targets.
This complements the migration away from instance level
properties to class level properties, which again aims to
ensure a fixed QOM object model for each class.

This requires that properties are either unconditionally
registered in the class, with invalid options rejected
at runtime (for example, during realize()), or that distinct
subclasses are used for specialized use cases that need a
distinct impl for some targets.

Also access target_big_endian is not allowed in class_init, so
we can default it to 'unspecified', then call target_big_endian
under realize()

v1: https://lore.kernel.org/qemu-devel/20261013200525.1340-1-luoyonggang@gmail.com/

Yonggang Luo (4):
  hw/pci: Avoid guard loadparm with target_s390x() for s390x in
    class_init
  hw/scsi: Avoid guard loadparm with target_s390x() for s390x in
    class_init
  hw/virtio/virtio-mem: Avoid call to target_info() in class_init
  hw/microblaze: defer PetaLogix endianness default until init

 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
 hw/pci/pci.c                             | 18 ++++++++++--------
 hw/scsi/scsi-disk.c                      | 18 ++++++++++--------
 hw/virtio/virtio-mem.c                   | 12 +++++-------
 4 files changed, 33 insertions(+), 26 deletions(-)

-- 
2.55.0.windows.3


