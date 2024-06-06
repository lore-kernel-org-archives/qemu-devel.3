Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D74C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4zQ-0008BE-Q0; Thu, 06 Jun 2024 00:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zO-00089L-Dl
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sF4zM-0008Ik-Th
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717649075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LeOo2RhnL1JFYcrMdhc2fIpLlnfyf8Xj3EB8ZeiRGGc=;
 b=QKEFPH+4kZlGh5D/aEPHGYyq/zOnpZAspFdz1SxXuRRKcdlKGD303FoAfah4Ty70Js6ZX5
 AyB8/c9GPQDX0JvdwuNLNShe+V1P0owy3CTtGZvJ9PKdOlb9TW6YTEcybaQurR76VL2c7f
 uQj+BzZPBE0yDZJvDoo9hBiavlHbG6U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-C1YyY8dzN7ipZ1Pt96Cu5Q-1; Thu, 06 Jun 2024 00:44:33 -0400
X-MC-Unique: C1YyY8dzN7ipZ1Pt96Cu5Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f61b9823cbso6827095ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 21:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717649073; x=1718253873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeOo2RhnL1JFYcrMdhc2fIpLlnfyf8Xj3EB8ZeiRGGc=;
 b=bX81pQdjCH7aRLFNxm9KZPdRg/8O5B1qoVbyXKAUaeR1Esft4U86UL6cAsllE1Le7W
 kzynDZCgKlwtVEfb/ql0WFym7JQ7lLlIv4C+9ZIQbig7CsUgFhjQjR+jj0Y2d7pVm64E
 T4DvW6tK5jGLU/Yf5R+fy74+VpATNnoT1XsETA+CW+hIz9XBdwvB1jdgQttw7UTYRYNX
 MTqR7bD7Nxmnvs6t+A9Uv7kWMip4/zKmICW2i/xO2WjzOHN/EVC2gnLoGiKoi+iZTRNS
 SSkpUqhBYVpCp4LQ350qMBUWyk9ZvNqISUIATOEY4VKiYI3BZbAlUecld2fsHMGqc4tM
 zPcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvC8rAeppQZCNmDHj2BSdE6/5k16BwZmdXvLKHTbH+n6Y/rRYXcNwIZfAESVXD+YiAZYXlo6oimK96U/JCp2faKQ9VuLY=
X-Gm-Message-State: AOJu0Ywx9D/rReSVSHq01GKWh9yHSGVSq7Tp4ISAZ8VI5xK7hxQA+ejO
 SUhoN/OBfiI4AvGHJyRqAftQBfmEr9pfAMO0YmdF3TRvCj1/yma/L0dk2rrFrf7vgSDMK3cOdD8
 J4jq29375Yzd8+QQvK6yQeoxvRNLqDX2k7bxBdIZwjeixai8wfFqU
X-Received: by 2002:a17:902:e80d:b0:1f6:7815:2325 with SMTP id
 d9443c01a7336-1f6a5a86e00mr56677405ad.56.1717649072886; 
 Wed, 05 Jun 2024 21:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA39QnxdUsgyZgGiheBupaY7MRNaPlgankuRMiijLbb5wxYoY/PLmntYteyTtPyCOZH/oDDA==
X-Received: by 2002:a17:902:e80d:b0:1f6:7815:2325 with SMTP id
 d9443c01a7336-1f6a5a86e00mr56677235ad.56.1717649072454; 
 Wed, 05 Jun 2024 21:44:32 -0700 (PDT)
Received: from localhost.localdomain ([203.163.239.242])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6bd81b9e2sm4057165ad.295.2024.06.05.21.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 21:44:31 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, thuth@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com,
 mst@redhat.com
Subject: [PATCH v3 0/3] x86 cpu test refactoring
Date: Thu,  6 Jun 2024 10:14:16 +0530
Message-ID: <20240606044419.8806-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new library api to check for the support of a specific cpu type.
Used the new api to check support for some older x86 cpu models before
running the tests.

CC: thuth@redhat.com
CC: imammedo@redhat.com
CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: lvivier@redhat.com
CC: mst@redhat.com

Ani Sinha (3):
  qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
  tests/qtest/libqtest: add qtest_has_cpu() api
  tests/qtest/x86: check for availability of older cpu models before
    running tests

 tests/qtest/libqtest.c              |  84 +++++++++++++++
 tests/qtest/libqtest.h              |   8 ++
 tests/qtest/numa-test.c             |   3 +-
 tests/qtest/test-x86-cpuid-compat.c | 159 +++++++++++++++++-----------
 4 files changed, 192 insertions(+), 62 deletions(-)

-- 
2.42.0


