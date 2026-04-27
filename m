Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BDBFF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOBo-0005WJ-S2; Mon, 27 Apr 2026 11:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3L4XvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1wHOBn-0005W9-Fg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:03 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3L4XvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com>)
 id 1wHOBm-0003ts-0N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:03 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so142949895ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777304879; x=1777909679; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WOhzkMHUiVCqCReOD2M5KMTjOaB/5LbW3HHZQI658KM=;
 b=j09fSMQUtcMbuGHPEaZkKdEjUXHUr5ve7tgNlZzbWxOdJPDY6xHCJEFecMmNAEvHGn
 jKtssKp9vTGEgqVC4DMsJWZMzjewwVrKHC8kL3U700gEum0pg44ByjXeJELG3qb/r2y+
 ZEkgq2qZ6IeRuBY0ipJJb6QR6mv0JnWepxG6F6wu1/VSQ+CLVqtKNOpIx0aYBge3EuIQ
 TbBMH/RpLyt4dGd477SBhBR+IBZ9kLgH5ixWeTNXZtM1D54Xp/NUxOP9zMcvqcaccgyx
 rEo9WHEXzeCVkivdBb5uOOgUdkZC18iL0lheExxGm4wZ8Nj9IECI+3BhkOHIayeaNJ8p
 TEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304879; x=1777909679;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOhzkMHUiVCqCReOD2M5KMTjOaB/5LbW3HHZQI658KM=;
 b=ApdCS6o0+ZO5QKLRVKcLd1etrK7l+ErQFKi5I8B093tVC3VQSohl1LqEglBlnDECgu
 dygy9QczTRYTB56i5gO3vd5egD5dJVqUzKm/YwNcTYHlYdaZmeKlh9f0cmthSSZNO3t4
 tVaBccGag/2LbgzwsPb6IFQhvRPLlzgrXqvJSPV7L3qQ0F2GkyfnJnfpdVUu25N9Ee4d
 pnX1KnNCjH/ADoIJsQ5p3Ht+p1tZfC1mFOMuN6+w9oWC7SvY/plY1Jh7ENca/aOLe9fl
 N3Dt2k8+xDuW05gfoJ+N2CTLV2o9Z9gm19tEf1xwMUNvBKEIG7SdyJ+KHAnDrgYEAzH2
 tjOQ==
X-Gm-Message-State: AOJu0YxDw5Og46nU+ipTgKycMWzyhniH49us3Q4VZNIYUcFeSH+inGU0
 /UN5By12PEYzCxoto78rLXlk18ZxTU3aJ4U7ucyzaYHeOwf6zJg/6ElQk4dUbZCOQyn9tYwX7g=
 =
X-Received: from plbw10.prod.google.com ([2002:a17:902:d3ca:b0:2ae:cd79:6345])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:166e:b0:2b0:a957:304
 with SMTP id d9443c01a7336-2b5f9e85b42mr457920065ad.6.1777304879240; Mon, 27
 Apr 2026 08:47:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427154441.1918536-1-rkir@google.com>
Subject: [PATCH 0/2] improve qom debugging and fix a dangling MemoryRegion in
 rutabaga
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3L4XvaQQKCk470y7w44w1u.s426u2A-tuBu1343w3A.47w@flex--rkir.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi, this series of patches fixes a dangling MemoryRegion
in rutabaga and also brings the debugging changes I used
to locate it.

Roman Kiryanov (2):
  qom: improve use-after-free debugging
  display: rutabaga: unparent MemoryRegions in unmap

 hw/display/virtio-gpu-rutabaga.c | 1 +
 qom/object.c                     | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


