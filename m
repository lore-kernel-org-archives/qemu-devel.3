Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2288CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmVs-00073s-Rv; Mon, 20 Oct 2025 05:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmVp-00072T-Go
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmVn-0001cu-Bs
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so38405805e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953745; x=1761558545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8MK2s6hRCVOxF/CgPwpismBLzf6SDyszKQ/3a/5i9gI=;
 b=uDF7jXm754JX7+Vzq3bFJn6HCC+qFNPL3qTmeaMcZvwpotzonW7iUOypp9KyEbO1xm
 3zxZk8GXlpHgQd2N47DNerah2vqClrlrqfeli2Wvg/ttVbqWDMkUdElV64W3lyrbMTz2
 6PnU3Yhkzk5Fq80nkU2NIcPhVlcV3vvC/UVPpl4+0KK+L0HB31Gn/28BM8HnGcjZ6E0b
 A42UmHtHTb5z7+HDUPK1Fzje27fMhz98La4vufG4IIeey7vEs0/Mu1MxT53cHvIOfD3v
 5OuOgSeS9b3ouaMZL1x9s33j70uIxMpPsGIoxxZSa6V3t/rKZno+QVG/PGC+8uP3Tv8c
 CBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953745; x=1761558545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MK2s6hRCVOxF/CgPwpismBLzf6SDyszKQ/3a/5i9gI=;
 b=bb/a1qn4wm+SnPQCU7wKLxAaVGbGCrrn+aAC6RAhQBvi4AR4IX9lR/5CTq5KbtXrKN
 bGapXZE8CiZZftmx7jvQy/9Z0fvlKt92EikiAoRgRMOVygrx1F3zaGFZlQYQU30RQbtb
 MlMfjKx3O635/Y0DRzWkDCIkuBCGfIxfFXS1nAkA88KpByWx02cCQV8t7qKLz1OlQ4xP
 e6CkBsisswUqHlUTtuXdegO8avHzSemP/y5ZemYyV3qHvU7FhIKHkLDvn9Sh8Q1ZAkeQ
 /cnz/ARn6PYRctwNE0OaVhTmraBwnpK6VO9vv+WdCeJCHflfuM8gFgnD22ZR4H+d9YSp
 5u7A==
X-Gm-Message-State: AOJu0YzvmdO/lIk9/gMtPP4DuVrw2RW/JZqrWqG8AGsHz/thqLfMsx2e
 ZXBe1IENd2JbsQt/yj14jpCuXLCzn1nCbKufWPmPptlEb7ogBBmwgVVWIQ/oq4rQetJDU3aC1xw
 d1kf+wlM=
X-Gm-Gg: ASbGncuAQU7HPfMIx+LEQLitIEUBRAJD9CFf95gOINbLl5r5SxnKjoZgNdVTLZpb2NE
 MJdfsducwFly7yHphS8808tYk3CtRRELJ4VJmU4K/o+LpF2lHashkavd4QlO0D9EO5rYTzIJPmB
 SjAPPPjDujQm8pe/rXZWT5Fsoee/Xpv1KSNDi9/ZfLu0itSvsUsSqCd5NxWuBhl7752Jrm45BLT
 KEi717IqEF4nYZajgUig5Wv8Xeorn+Hpvx9cKKmDgNunRTb/yOgXVmILzV3WMiVVj9Dt0JlsDDQ
 7wFcr4YO9GNVnNPgQCqlqkNUosgCWXtFbxB5wRbJOVKpxYAPFZnL5kW657mkPpXphOIr7y73cdB
 k/gzN/CJP7Dtf+2WFi0LMcJyDL7QzIrK03eMh2n2B8CocmMNMKvxCu3fhP192v6Sy8EuTsEDeSN
 3SToOuQQSX/FQTv6P7JpeEFrIzf7wZCkMChy30pD4+rHodHEL0q8gBlh+zHty3
X-Google-Smtp-Source: AGHT+IGx4c/yN2yr04YQCricViA+0wR6TkQDQYz4970Pa8xVFsJtUAd04oGiIqAerAwclL1ngIdF0g==
X-Received: by 2002:a05:600c:674a:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4711791ad4bmr96403915e9.29.1760953744874; 
 Mon, 20 Oct 2025 02:49:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a75bsm14671897f8f.23.2025.10.20.02.49.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:49:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 0/3] hw/s390x: Remove s390-ccw-virtio-4.2 machine
Date: Mon, 20 Oct 2025 11:48:59 +0200
Message-ID: <20251020094903.72182-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since v1:
- Do not remove s390-ccw-virtio-5.0 -> 7.2 machines (Thomas)
- Remove MachineClass::fixup_ram_size (Thomas)

Remove the deprecated s390-ccw-virtio-4.2 machine, which is
older than 6 years. Remove resulting dead code.

Philippe Mathieu-Daudé (3):
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
  hw/s390x/ccw: Remove SCLPDevice::increment_size field
  hw/core/machine: Remove MachineClass::fixup_ram_size callback

 include/hw/boards.h        |  7 -------
 include/hw/s390x/sclp.h    |  5 +----
 hw/core/machine.c          |  3 ---
 hw/s390x/s390-virtio-ccw.c | 33 ---------------------------------
 hw/s390x/sclp.c            | 34 +++-------------------------------
 5 files changed, 4 insertions(+), 78 deletions(-)

-- 
2.51.0


