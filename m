Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0C2CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXa-0008Ro-Oz; Fri, 17 Oct 2025 09:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXF-0008PX-FF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kX5-0007tZ-Pv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so14358955e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707804; x=1761312604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OEYPB53kHwVQCaOw9m5gqu736DfdFavGxg/04G6lr6A=;
 b=EiDh11m3o10GZvt93lOiwKXul3rbjBXPNEnnMQEuIDHWSOmgiyLsZWXKgJ+lbmK0Yj
 WE+RNBUnSzg3gSpnKhrgQsUnK04UPmzLI7SvDdKGajiUAn1jNyjbOXLMZsCWA8155CmK
 +7LJC19/M4xB0IMseHLZQOVHRZADoDeBr688fAtS9Z1q0+U7l9cTB1l4DnBpk7QHZR5g
 HlziH9S0ccC+DtjrxfWWRsFDw3eob0TUrvA+bc8nhShPjrPcbLjR/IrKLTMzKtnKidTh
 LlpY+KHgfl0Y0H4dfGXxT7S6F0+3DMc+infmR98WknmxT9wnO9Kn9rSVsQtfDDDSBKGg
 jiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707804; x=1761312604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEYPB53kHwVQCaOw9m5gqu736DfdFavGxg/04G6lr6A=;
 b=VxXoYH0f06nll2tnayjPJpw029mZdN3/prGBG1lhRbCSMnlSt+2OTuh76jTq4o//pf
 MbALnFfcu/zB28rZwg2FeJjqChPE9ujdyslMV2LGvFr5v4S+fKqH94GdXb+5PMc46mVl
 nCrXR1La+GxaYnvaqFUUOZo1nfbzDVgc+7j98VaZEjLXwXNNYohlEeZMOL+QhCq53dW1
 eV5zFOsclL9pChswO3uPWMXFjRc14aXjwnWhgwtVMg+crrGYzcLZhiAnypKDcogRslol
 zrjtI69XvaG5FByrZzpMECSQNq7xJbf3drrLqRgz6GN5FYYV9eyEtX/sRiHydPtu0aru
 ECCA==
X-Gm-Message-State: AOJu0YxDIJWLyyyxLWNbsUj/+FlOr/KBWudF9xcoVrBc1BM3qDlWxcgm
 dwvZzyNsem0cGk3GXl/e+wQJDRBZQIaS8XLp9/IKpEFklNYLVUJ97q9iKbFmYKzJiZYchwyYJ5w
 RwRvcZ58=
X-Gm-Gg: ASbGnculzXmVMGW4m0Cri8Elu/atat+jPczNOetxydgGYAeyhFWWas+9bPxWrmqhy/5
 PPvjv9lvY5WusL9ZYxA7TOhy+tRcT1K1JycMdALC34jQW31oLuNcd8zuyqb3KhVc4OzLF83pvmg
 3ijK1CkfZDQwAE211hRkxBcXivkD6WnRDx83tXRiltzfnbnz35r/8Dj9lMqdFPQas7yp923azmn
 55TOLusiL1xSmlSHs4jPIAU270LNWT/F7nfi1uH4RjVkhwpoEjCM81sapookl7ab38/QEGgUh1L
 UvNDlNEGGCOWf/nkn2NnIw4E9s4TP0ChdGUjG5mWNy1iq7HQ8TInnRYl5aH110Wc9xywazjzpt7
 hcttQK/yVuzQSxwzP5/l/hyWhPSPj3LSihd0l+H8XbC+VI9xwz2QA8tLH6Ab/Hh/AeYK7fceCfV
 OTE+UYH7neTIhV4yq7Lmxtj4prqUvakzSlChRWpE+GeFTfTlQHkw==
X-Google-Smtp-Source: AGHT+IFaT1OyDuv6YQMg2f1/US9sZiB73IYyk2dh9rKGqSHZ1Pubrpvmaa823QcAw2iJkXfQZqM8dA==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr27599655e9.30.1760707804232; 
 Fri, 17 Oct 2025 06:30:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114428dbfsm81430505e9.5.2025.10.17.06.30.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12] hw/s390x: Remove s390-ccw-virtio-4.2 ->
 s390-ccw-virtio-7.2 machines
Date: Fri, 17 Oct 2025 15:29:49 +0200
Message-ID: <20251017133002.61410-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Remove the deprecated s390-ccw-virtio-4.2 up to 7.2 machines,
which are older than 6 years. Remove resulting dead code.

Philippe Mathieu-Daudé (12):
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
  hw/s390x/ccw: Remove SCLPDevice::increment_size field
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.0 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.1 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.2 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.0 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.1 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.2 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.0 machine
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.1 machine
  hw/s390x/ccw: Remove S390CcwMachineClass::max_threads field
  hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.2 machine

 include/hw/s390x/s390-virtio-ccw.h |   3 -
 include/hw/s390x/sclp.h            |   5 +-
 hw/s390x/s390-virtio-ccw.c         | 175 +----------------------------
 hw/s390x/sclp.c                    |  34 +-----
 4 files changed, 6 insertions(+), 211 deletions(-)

-- 
2.51.0


