Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4185C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JyT-0005tn-QL; Tue, 07 May 2024 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jxw-0005lR-15
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4Jxp-0006sL-2N
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:30:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41ecd60bb16so22951655e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715085030; x=1715689830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wx/6CI8YsxdL7zULZQpaCZPw1Wrj7TgMWK29VE0fJdI=;
 b=su/pFa1uID4NRvWrLncb6xz/2MHBeKy5ryzTeK9LH6EAmTPdd3NyXJANVMXvXXX9U8
 jgIjLeHgGsLKMVHGrbAWVUM8jmFUmzVsflHe5+ecSxncbX+NCkVCkx9v3xlVc+eiLl35
 b9IyY8m7iVMKRUjnCmXsNADFvBOTtxtrGKGX6DeYC0bOcONMZ1omSl2d/PwFXIPueb6i
 lhFjBtkq2b+ViliqpIAiWhjZR04OIVq2hSJlHrIxa4QIzIZemtx2XKQIc2rCPZ0MqQs5
 toO4kYEVWfyjBnPFObMTMckyu2AM8PJU1y7XzOU/c7bpIAzDVYXfqUED2ovjjRDtJQ/g
 xkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715085030; x=1715689830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wx/6CI8YsxdL7zULZQpaCZPw1Wrj7TgMWK29VE0fJdI=;
 b=A7DC4QcHIWXOHpJGWd3JM3ySDXsKMON9C94fQ9AUFScvDaaAPov/tl2QoNgdRqcBwX
 heZNq50IkQPwAmMVlIK4GpDU5obVcKYF1uUOqMjwHr5zJcvrwV08bDnW9QTSDwgTQR3Q
 j/fpOWP/9pN4aWBKvtsz49kd0J21pbQi9Pw5LFfUutndEL6is/aK9ZgCJk+gVCif9Rxm
 T/9DT3MR+6/AHAA38Zin/I5bNvFlMlq0QXKe+uFospxiScsWhXK/YOvrBseQ/1xO/qPK
 P1AfN0IcFPdBsv5gsGi5nzY2ofn1pXTgi+D9PgvYtdJQd4wHqusnrrwb3voAKx2BcjbC
 Qgag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRcS82a4KMXi1BLye4OWCpTJLUmhjMS7uAZa6lC08IBy8Ki8gfmG7iDwcaVt1xJeZxY5g2a4GiBfctqQ3MwCgwJdJYhg=
X-Gm-Message-State: AOJu0YwiReAs1cYhn8EfUF3ctg5Gqe2FaKpEztDxFFyqYTB+B/18nc/b
 hMdkNQbgUtu8Gayx8C99wyhlYLUY1KVRbjXMF/2V1uCt+J+hSfajCo1JYP8XpIk=
X-Google-Smtp-Source: AGHT+IEg/BW7aejSqNLApUIz0xaNANYGz4sl6pI++e0ZNwBHNd+pJ3eA4aJ6bYuSfRWMHQnlfN4qqg==
X-Received: by 2002:a5d:628f:0:b0:34f:3293:83d9 with SMTP id
 k15-20020a5d628f000000b0034f329383d9mr4983336wru.57.1715085029714; 
 Tue, 07 May 2024 05:30:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4303000000b0034f145b60ebsm5532523wrq.3.2024.05.07.05.30.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 May 2024 05:30:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mattias Nissler <mnissler@rivosinc.com>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] system/physmem: Propagate AddressSpace to MapClient
 helpers
Date: Tue,  7 May 2024 14:30:22 +0200
Message-ID: <20240507123025.93391-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Respin of Mattias patch [1 split to ease review.
Preliminary use QEMU_LOCK_GUARD to simplify.

I'm OK to include this and the endianness fix [2]
if Mattias agrees, once first patch is reviewed.

Regards,

Phil.

[1 https://lore.kernel.org/qemu-devel/20240507094210.300566-2-mnissler@rivosinc.com/
[2] https://lore.kernel.org/qemu-devel/20240507094210.300566-6-mnissler@rivosinc.com/

Mattias Nissler (2):
  system/physmem: Propagate AddressSpace to MapClient helpers
  system/physmem: Per-AddressSpace bounce buffering

Philippe Mathieu-Daudé (1):
  system/physmem: Replace qemu_mutex_lock() calls with QEMU_LOCK_GUARD

 include/exec/cpu-common.h |  2 -
 include/exec/memory.h     | 45 +++++++++++++++++-
 system/dma-helpers.c      |  4 +-
 system/memory.c           |  7 +++
 system/physmem.c          | 98 +++++++++++++++------------------------
 5 files changed, 90 insertions(+), 66 deletions(-)

-- 
2.41.0


