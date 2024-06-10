Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F21DC3DA41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhLA-0002FY-2u; Mon, 10 Jun 2024 11:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhL9-0002FQ-14
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhL7-0005uh-Ix
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718034824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jtpi+70dcuK+iPUM7lz3SL1wDL7DuVPcE0zmNjAimls=;
 b=QfiyXmow6HxsJft4AVwxub8fPFGdr6nbve6nQf33wuBDaQwrW1eeLei3t6jRbDYoUgNSWl
 mGsdHBrcguWrK5J0EcbOujIPSnVVWszPPqpijAAaizSR+QAcj5Yv6NYKeOp+xnM7cHW/7O
 hcZBpLYhvSe68H/t3GGJ6TB6w2aRWFI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-GzhDx7ctPJ-E_w_273fvHQ-1; Mon, 10 Jun 2024 11:53:42 -0400
X-MC-Unique: GzhDx7ctPJ-E_w_273fvHQ-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-374b7648ab3so1334335ab.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034822; x=1718639622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jtpi+70dcuK+iPUM7lz3SL1wDL7DuVPcE0zmNjAimls=;
 b=ObofAV33/QgjC4h7rq7lMV5GURjh1fmZPdvaBmhVbn52xsHwbeQZ6oPE0ziRzQCxbB
 a3i9qQU7VE+pPad1PG62WNau1c/3DjPs+5ipK+BcgEAfxaqQTGraSyLOo4dXrzD0oC9j
 myCohX2iJi3vsBoMuLKm1QZll1X/o7s67WHCCLwAKx2NCgTPQOVqDE++8ciUX1aeI24u
 rgGK5Ya+c56kxq+ocItgM2SChnlazZWjV6zinnzmXPUI5Ye/4aw0dRyRQcLc7Z2BqMkb
 Bw+G31hc/W3xOuh+zAUc7mDPTdij9P0xfb8WbNGbV62yMkfhPMaqzWFEHgwaxaIPtA38
 36hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyKIHIDJnZUipVBfg/ohy0pi5MbiX9vkJ7nVb1z4dUbrHG4GctfMd3EMcREc+FGxyr45qbHsXcH+5ES/IH8hXwwjiSMwc=
X-Gm-Message-State: AOJu0YwphMuGte5116UOG/Ina+dDDDD0z0OsvZlXkUsxsK+2UbL2CWwE
 H3nRho/MJpZeYx4zOBB965J5Hqi1i0M5ej8MCYlavjvwEbYcX0iJl5UzlJGzXnVQbXYy9CmnoY0
 +TMBV9WAaYhQDOs3xXoY/3g+V/kQchErw7p49Qp08h9X4v9BBpiU7
X-Received: by 2002:a92:ca4c:0:b0:374:972a:f8ae with SMTP id
 e9e14a558f8ab-3758030843bmr128707335ab.12.1718034821820; 
 Mon, 10 Jun 2024 08:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+AMG7hwIKvyYdWJDdSoBahsXg9Ptl8Ag+MIpVhn+WCshEs+u+8xYb6ohoK77vXlN2bgr1g==
X-Received: by 2002:a92:ca4c:0:b0:374:972a:f8ae with SMTP id
 e9e14a558f8ab-3758030843bmr128707075ab.12.1718034821388; 
 Mon, 10 Jun 2024 08:53:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.118.89])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-6e3819ffa94sm5155290a12.85.2024.06.10.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 08:53:40 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, thuth@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com,
 mst@redhat.com
Subject: [PATCH v4 0/3] x86 cpu test refactoring
Date: Mon, 10 Jun 2024 21:22:57 +0530
Message-ID: <20240610155303.7933-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
  tests/qtest/libqtest: add qtest_has_cpu_model() api
  tests/qtest/x86: check for availability of older cpu models before
    running tests

 tests/qtest/libqtest.c              |  83 ++++++++++++++
 tests/qtest/libqtest.h              |   8 ++
 tests/qtest/numa-test.c             |   3 +-
 tests/qtest/test-x86-cpuid-compat.c | 170 ++++++++++++++++++----------
 4 files changed, 201 insertions(+), 63 deletions(-)

-- 
2.42.0


