Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B3AC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdE8-0005DQ-Tq; Mon, 10 Mar 2025 09:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdE7-0005D1-EY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdE4-0007LB-FP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2243704f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613481; x=1742218281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8wsBHrEW2R8MGZ+WGci8/OshBt0vu3IpbNKOYBV/NOw=;
 b=YG24t2Fi0SvsLxBK06lJUCmCaoqEgTjM99+BSRGPPJT133umAZgv7Asu1D0JRTpSpF
 db3LGv/zIj5+YXF5ofn7j+chQvDGg88+wvlokSTUr2vuF4HAd6QWoWfXZGek8Nh86NT1
 lj9A23Ed8zu6/vqo5p1BERVQOq8xGTWEycvLixHdna/joMatwPOXF3kT+JGvE2rSWemz
 w+EKvFIdbcHHgzTDGz8wvXxLifqQkpJpUpe8BIFXujaHT1oiuJXJNXcP0cyNH/5UoCqw
 CxgATecH1K08NX1ZJE7Em9fYYASy3NCiQJfXudmEqVx7tTpY3lEG0dO8rmdx9hdTTVfc
 qZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613481; x=1742218281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wsBHrEW2R8MGZ+WGci8/OshBt0vu3IpbNKOYBV/NOw=;
 b=E2pC3p82DZaopHGnf23tohwS2yfrOhTqMflbyykgcwp2Prl7J6vAZePMUjNBjY++UL
 HDiIda7mxR8ZdKjb1z8iSLTJ70wV81D03ukAzcAUGW5XebhDsRt9FWaxKBPUrArjcyUG
 g/LU8JQsXvnko9/tW/GxcVtMwaV9P/BW1MBn5GOAdM3kD57oyV+ruWHn024M/dqo5h4R
 lOtPfW9CYb/l6D01oVRlq31/ohM7jXHo8r19oo0e/NeQZrMikFcAqi/LOBskYfvR5FFV
 9w6ThyfTCay3F62owwkJc1f1RYGc9F0Q3OhdXWaPpEG3k8uPvQtPNy2EaM9+52CPLljH
 xZ4Q==
X-Gm-Message-State: AOJu0Yyk1mQveQGqNLo2LKazuMwV7NLCrPYJkBhg4d+B8z7raOsIVOpR
 jrmFfmq179MIkJPDkOFhzMtnzdeKa9WleHSmWY2Ym4V1lEn2Vz1N+Vn/1Fw6tqe9mTwDlnMSg40
 aC8I=
X-Gm-Gg: ASbGncs5sab1Rjrg36TuiSbIEZkfI+4gEuBD0QWKy8RZ9Ey0KdC5NgCBf/6dxmdGdxV
 HADLEYRUrjR0UPfl6A38ttj3EoZJcFD2SeV9c3yZ38ddviHOt6ayjzaI04Si01Vki6XrllSDxjZ
 u580cbVcMdrBy8VIAtP27/HBfpzusYNfS1i3fARLe+bpUwL4uva0xPDpuFz+ssS4kKV9jXNVDqD
 lOfceDQ6W2nun9TV1weleJRfIV+P0Z+ixjUO1Q9rtwZx2+FWi6bUtS01EXWPhspxrBE1ToUdoZR
 ycPQA3X3m3qiciTDX0bHbgq7cMQvzwqpVClA5TQ7cFUzXMJUFme/ce+8j2UoBeEu2fEqW2+e0Z6
 MVXKmxKeY5AL7OB4lFIA=
X-Google-Smtp-Source: AGHT+IH5aTJZRwnMQaXYqYO7H16SBt1dUswJkXb/o2MG4CrgHG6t9CKYAzCn7qzGJC27sd3t6MwQOg==
X-Received: by 2002:a5d:648f:0:b0:391:2d97:7d0e with SMTP id
 ffacd0b85a97d-39132da92f4mr8198314f8f.42.1741613481123; 
 Mon, 10 Mar 2025 06:31:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015a29sm14672390f8f.42.2025.03.10.06.31.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 06:31:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] qapi/machine: Make @dump-skeys command generic
Date: Mon, 10 Mar 2025 14:31:15 +0100
Message-ID: <20250310133118.3881-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are trying to unify all qemu-system-FOO to a single binary.
In order to do that we need to remove QAPI target specific code.

Introduce the generic SysemuCPUOps::qmp_dump_skeys() callback
(only implemented on s390x). No HMP change.

Since v1 [*]:
- No QMP rename / deprecation

[*] https://lore.kernel.org/qemu-devel/20240530074544.25444-1-philmd@linaro.org/

Philippe Mathieu-Daudé (3):
  hw/s390x: Expose s390_qmp_dump_skeys() prototype
  cpus: Introduce SysemuCPUOps::qmp_dump_skeys() callback
  qapi/machine: Make @dump-skeys command generic

 qapi/machine.json                | 18 ++++++++++++++++++
 qapi/misc-target.json            | 19 -------------------
 include/hw/core/sysemu-cpu-ops.h |  6 ++++++
 include/hw/s390x/storage-keys.h  |  1 +
 hw/core/machine-qmp-cmds.c       | 13 +++++++++++++
 hw/s390x/s390-skeys.c            |  3 ++-
 target/s390x/cpu-system.c        |  2 ++
 7 files changed, 42 insertions(+), 20 deletions(-)

-- 
2.47.1


