Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D10DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErOa-0001WC-BL; Wed, 05 Jun 2024 10:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOY-0001Vn-L4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOW-0004j1-Ke
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717596820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LeOo2RhnL1JFYcrMdhc2fIpLlnfyf8Xj3EB8ZeiRGGc=;
 b=YEfw+QlBusXORn+p8qjJicNXPd44UWYkQKYjFNxia7FnmioK4wN/2B2O3QwIRRWZ8wzHbI
 2bBoNEOXdJngC1ojTKbJ/xQ1px+WM37WyNYDGYsY2T8yjbiCV68lIve1JHF6Rpb0EG/kQv
 FqHSu0+quKcQg4qI+YOp/0a07k33pb0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-jxSZ_ijQMfqG3MJlObHbww-1; Wed, 05 Jun 2024 10:13:38 -0400
X-MC-Unique: jxSZ_ijQMfqG3MJlObHbww-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6cdc904ae4aso2026240a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596817; x=1718201617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeOo2RhnL1JFYcrMdhc2fIpLlnfyf8Xj3EB8ZeiRGGc=;
 b=BwDhXqKGNaVfr3ZynWDRu6XwNR/yt/LCVKG3AByJm5hZzMxbpImAt5CcBnor519LL7
 /U+NYQse6Kg65elQVANWPyaYrm7y1daBegAZlevGK1vJ5bgz2regwAVcUtHZxIYArGmt
 XZmTkBCkwp8MjdgO9jud25AkpIVGm0ZaNE0hEkMePFFWBJohBbIKDmNsF/mai7FMvKiT
 7rgS7zwK6DXdWkrwzbGWztQteZb0gvLD6hY/xZZBfvZL97EsF9S/tWeT7gXmXZjuPkqi
 0DWgdG4c5dN1CFTmnUi2m9qyuE+2jxPrqkgacLNz2uczChm/lv5Vp9meEivTYS6jywAx
 GOBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrqudaG4zIo1P/yO274iUw0zSBidHR9zpQ4d6bQZEzLDkIYZEIUu8UKVp+sMiIzZfp7mndJwsMM6+o1LTfdTojRDKEKvA=
X-Gm-Message-State: AOJu0Ywy1GL7m76NbpM/ae3/GK0apgVHmBgvOoRQMFQlKJ6uw3fExo9j
 2nSM+qbOHDj+A1GBI71VSUE7cTY9r6hbgiyn4ZGU3guMeXswWLyQVPMH7B5Hj/OXahoU57D4q7Q
 xY11XA0FSKJduNifdPYivxbDxotnE8jYxCrm2IhowUS9/nUHtdoym
X-Received: by 2002:a17:903:187:b0:1f6:a506:4eb with SMTP id
 d9443c01a7336-1f6a5a86af6mr32889095ad.60.1717596817532; 
 Wed, 05 Jun 2024 07:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMsppmX375OeM7T7tJpvBxjrpD0qePyoYzoa5zhyKiVFY9YmGN+i4TTOuHUfuqA39q9ZKJKA==
X-Received: by 2002:a17:903:187:b0:1f6:a506:4eb with SMTP id
 d9443c01a7336-1f6a5a86af6mr32888775ad.60.1717596817108; 
 Wed, 05 Jun 2024 07:13:37 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6323ddac9sm105225665ad.173.2024.06.05.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:13:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, thuth@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com,
 mst@redhat.com
Subject: [PATCH v2 0/3] x86 cpu test refactoring
Date: Wed,  5 Jun 2024 19:43:13 +0530
Message-ID: <20240605141316.91955-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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


