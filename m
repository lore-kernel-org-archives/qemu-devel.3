Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E96C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 13:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sArCp-00013V-Me; Sat, 25 May 2024 09:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCm-00012S-DX; Sat, 25 May 2024 09:13:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCk-0007DU-QQ; Sat, 25 May 2024 09:13:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so13246975ad.3; 
 Sat, 25 May 2024 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716642775; x=1717247575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0D+PK4/V4lEjUiaigwaSzrNATEloiDqoARfAOKB7zAg=;
 b=Od0FdJW4MvnZa2+lErCvAArP5MJQho9VsJav7h/5WVuMBiXifEC7sPbzqaN0IGz6D+
 adxE0vtbdFQ+QnEGfjQBgqVoRReW9o/sDrMcq4Js1vECr+NRk96G54s3n7UVN174vABp
 I09bnJEoFU4ft/XU1RXxiBps+erSHOHsa5x5viQjgrUeWLp7e3Wfb19qqNJXIRFrqfB9
 dcD1YgfA5DxpU1/JqR9feyPO9z4/u/kgdk310I46zZxhfCj5KkN7kuUB2hT2l+4UyhnQ
 o7wdls5HyEO1SOnIuuVcx+8arAHu6gZ9JSWyWnCZ6EIr8z7vyzFKvw4udSzw3caxoTil
 lj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716642775; x=1717247575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0D+PK4/V4lEjUiaigwaSzrNATEloiDqoARfAOKB7zAg=;
 b=Oo066HXDYfE9SUJ2OAQY2/1RFiwkyCPES5bSvZ6e0HLQLZq5k4Xpn/HrJCv7IpGftR
 D6aLxg9BflWTMaqiNWubGQCGb3WUqRrckA+U3byytU4fTua1qr1mKZnXjPCiWz/FuufL
 xOJ1vipTNuC2A1PDhCjNLHKqpJ27VcOIEkpzGjbeChM69h8sxjoLFtLzWyjT/1PBGs/+
 1InqO/RyDq9vpEXoxaxFCY1s8UqyS323UKWWrxgYZA+QhHceUPY3gspr2Z1mjcTuVtTo
 WXQGjFHNULnCCxgqZlP5baC/ggYEjVMah1ZB3Iyg9P+XqSSX6L0WZa6s1JQ4wuOX+HS7
 0Y5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNX4OK/FP7+OJrT382ve5eOm5+H9eUXX+UQH3zokoZ0cIFz2Lt6i7btJoBp52w37ELZnF6XB9vHEfg8GdpWmrHtPb39rw=
X-Gm-Message-State: AOJu0YwNncuWE5ju6OuzyTjDBI3xjZQ0CUE8+08WFwjPxPpnLsn9GSIv
 uQvMxJs6e9QRoYF2R+V21RYMvY87x4JZJCq5p4DTMzywWWEK7bIHZG+5kA==
X-Google-Smtp-Source: AGHT+IFwmVMbIzDCVT7Zr2+qT8t5uL1ZQcSHBR8vI6nA3P1bvR4AUM1CxJhYnOkVEzAgjea7ZdeMMg==
X-Received: by 2002:a17:902:ce82:b0:1f4:6f3a:a133 with SMTP id
 d9443c01a7336-1f46f3aa6a8mr10278525ad.3.1716642774899; 
 Sat, 25 May 2024 06:12:54 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dd1efsm29653525ad.291.2024.05.25.06.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 06:12:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] Fix s390x flic migration and add some more qtests
Date: Sat, 25 May 2024 23:12:37 +1000
Message-ID: <20240525131241.378473-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

I don't know s390x enough to know if this is the right fix, but I
could debug the migration hangs this far at least (and the patch
fixes the condition that would previously result in a hang on the
qtest).

Also we could enable the test_ignore_shared test that seems to work
on s390x and ppc64 at least.

Thanks,
Nick

Nicholas Piggin (3):
  hw/intc/s390_flic: Migrate pending state
  tests/qtest/migration-test: enable on s390x
  tests/qtest/migration-test: Enable test_ignore_shared

 hw/intc/s390_flic.c          |  1 +
 tests/qtest/migration-test.c | 25 ++++++++-----------------
 2 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.43.0


