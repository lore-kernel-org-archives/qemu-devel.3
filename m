Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B50FF4BB8D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzsK-0002sK-Ix; Tue, 24 Feb 2026 16:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeM-00073U-5i
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:50 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeK-0003Jz-Q7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:49 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cb48234b08so616485885a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771959647; x=1772564447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bk/eXpdbcN7o/uDfc/Kx0OpCs/nYFAS5JbHpc51C+sk=;
 b=kvnZk8ItMxGFS9m25ZuNNtIeJW//z0Q50hA31ONVjEDMOx6q/vE+oWKT74RP+nc3MR
 FQ99XGat6Khy/p8h1tyPPvMbk9BmK7TY13Vwv07aYnbWxL4oGZAO+iOwOwRJ/mku5sJB
 chIYdNO8rEWbrIquLwNbNfeAsNxcrQXCvy3wjdVU6fFnK9jq6Cr+zUFmEo2OtPv7XMnF
 k8TOYrxc/Sk87lAio80Ff14+YfK5hd94CT3XQMZSL6IC126UyTlfVOF+yV7fdLm1/A6V
 cVkDy0EukKCpLJxgdRFEYmV5k3nS8ILo1WDIc4Uv/wp7wKC7RBgFjj76aIx50eHlU0/6
 nXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771959647; x=1772564447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bk/eXpdbcN7o/uDfc/Kx0OpCs/nYFAS5JbHpc51C+sk=;
 b=EizHaxOAeF3ghU6VutTFQ9ESBWThGu0dVvODWwvkiSE+Rl+QO4JPTGYtpUQbJwv2im
 B6af4evSDhU0zmkplfGfdZpvrDRV0fq0k//tIKbn++JAeqibRMfZOFb66/p3UsPpbsbN
 qC7tr8DchiTDpZTeSlpOyatH+Zekj+wDbNIe+jhOSPGx/tegb3jE90TPe3NDVd7PJ6BU
 OIxOL4npFNhpIcRc2Pbl91KcP56rMbfxrky5YWizONMLO8/oUNyh9E5OOq+T8LSFhhss
 hEQjEuG6uIBAFOP8zAh+niylcfeA5TyMZEqrQK6iaBaH/CNGUf0y9CFlk+lbnT2LBx/p
 d7ig==
X-Gm-Message-State: AOJu0YxGRH1TNO1x5X9BTXDoTk7MRL/jMXeVChHkSJjEG2RZpugF6ak9
 lRrf8k8YlW0l4KQ8SIaKGC9tOvqRFroIyOXsmRNWB0swZslkiwS6z8OhI9zUaA==
X-Gm-Gg: AZuq6aL6KL6go32/WfZQe7Q/ruxAdbNgVVkt8uNBQgyn0+O1Orc0CP3auhiqKd4N4Ux
 Q5sSwwk7etlUADkLWcsMi2sncvBPzjYBnMLzz382qYFmQey4O+JwfAJ1WWSmpex/EwqUuObAIgf
 YDGnTH+M9YN8vJVwso3/K5dXKKLv5QB8ahpMI8LP1LGnJpk6mDxfOMspigaCeuIC71CdzOuQmSU
 HCWvGo1NAdYpbppii1pANMmkE48HMmawgSpb972m5NQquzi3pynbnMRiFbJDMM5j7Dk3edou0vd
 YiKJ/i8qEn7AxcxqxsQmgcW29dAN862e8hb9iLUFlghBzXb3wkEKOe0CiblpIag/wZBobm/Z1l0
 TkTzv8vz28TWXgGYkxjsT96sxESwpbDMc7hDPI7NOYYlmJcqOtiO6U7+G2IMIivzuSCA+qnL7wx
 nqZ1UgSjls7M82t54FyoVztoH9qth4hoLULAsjiPWmHXBczRMBDgo=
X-Received: by 2002:a05:622a:10c:b0:506:a617:175a with SMTP id
 d75a77b69052e-5070bbd9882mr188919981cf.22.1771959645901; 
 Tue, 24 Feb 2026 11:00:45 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d3a2dc8sm102616291cf.0.2026.02.24.11.00.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:00:45 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH 0/2] hw/misc/ivshmem-pci: Improve error handling
Date: Tue, 24 Feb 2026 14:00:02 -0500
Message-ID: <20260224190004.84187-1-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=dahamilt0@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:23:21 -0500
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

This series addresses two error handling issues in the ivshmem
PCI device:

1. Handle the return value of kvm_irqchip_add_irqfd_notifier_gsi()
   which was being silently ignored.

2. Check for errors from setup_interrupt() in process_msg_connect()
   before continuing to ioeventfd setup. Add ERRP_GUARD() to make
   the errp dereference safe.

David Hamilton (2):
  hw/misc/ivshmem-pci: Handle error from
    kvm_irqchip_add_irqfd_notifier_gsi()
  hw/misc/ivshmem-pci: Check error after setup_interrupt() in
    process_msg_connect()

 hw/misc/ivshmem-pci.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.50.1 (Apple Git-155)


