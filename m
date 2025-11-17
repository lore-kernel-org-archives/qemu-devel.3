Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05458CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2mS-0006Wn-Qk; Mon, 17 Nov 2025 12:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mQ-0006Vk-O0
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2mO-0006jG-C4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:12:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47755de027eso32059975e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399558; x=1764004358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LeGIsKgjXUpY7siwK7h2OvBlSAO20bFJdWrBioItVhk=;
 b=BXrXLMGZC7euNw6Ke4kjEYBMI0i1dZ7S/HwfdF4cBQre3vjSQkfXm9DCu0FcP1/N7G
 7ga/GMraS4WFD7DgeBAVWttH+GkKBXNXN9lWc3YDayva+DPUDWYsUMgs7YQxHTYeXF8t
 /wIlcAOeiI/Ym/lAw40wr2q5L27UEVK6PTHEGVVafuPkLX9jwNIE2Mzkl5HBRZxwGpv0
 ORlMr42xG8m0r6OqwPQuYvGowHY1s8pbmqj0qedFKD9srUul8iWrjW0l9P9Kzgbb9mxm
 Wn5pwXs7KhNzNmPpCiGDRyD/WlVYlLgpEF624urGLoaQjmoehIMZSxqQs2PYOCuy3Gns
 vLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399558; x=1764004358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeGIsKgjXUpY7siwK7h2OvBlSAO20bFJdWrBioItVhk=;
 b=jknabHYti0vrae3XjxVZKqbShifHM0Gu2VnHq6Q8a46dqXGMPsExDVYnLefpw+5J0o
 Va3TDwSDRgGi46/gQTksB/VLMixIcP9SWRQ5GcZhGl2kP0iWG3PRwbG6btARAoPllXh+
 wEEc4ua3S0/Tp2W7DcF3yOmKpKhBlUbPswU2fwr7ZYJ0Pkr70vi45CWtoHXfvU6viPaP
 wq5h5Xz6ls5TBR204cawN5FEjhRu/bTLpGfrh6COuRaIsRYJIxAr7Jsra9zyPIwbKEFB
 4n2Cl0dJ/1gVmxyaJ95VmpDQV0y2vncuCWMEeMTdH6n67/rIPLybDsv8mX5txcHl0HgE
 cU0Q==
X-Gm-Message-State: AOJu0Yzud393JtR4yIB/5v7Zg9IcjJcOLxR60Q6XW+QjUXhyjxN3qkzk
 z6mgwhjVwf7J6H5I/fsBFtSNRPRknDu2gW/w+sQy9Et30jHdZ9REVwCF5KDyzzZnss9i7m83+1g
 9sDOCfmBVTw==
X-Gm-Gg: ASbGnct8jOTD2EADN9FLf8vtzFEoeO3t+PwZgrnr7V/cqE4mc5iHvpnNNy9O61CZXRB
 4Wg5Zs7Itco8/mWxg2f9iC4cGpeJQAmH27rcare/3vIh/v/UNUf/tm6n5U4jnQ+PH9K7w5B1oSu
 /bzIUv2yk/91wUjhb85snTWHH1nZjBqVMEe9MFm3pwqYbhMifJRwyrxa7UnC3y7ygUtPfPd3QYi
 Ig+68hiDLrsMxDRdHkLZSAQ3+GZt2yayfqaU2c5/MJ8a0XIboYPSJvao3WCQDS3boFHqenxojnL
 hreDJzTvzwpqd1X4HQozKPBxLrup0kxrI5qurcqr+pdcNcqO8YBKGeAAVQWjGPx1spn4CBXji0o
 2CKkWBEIvQO6ERl+FmfjPMUMHd4sX71XWt7MEwVUFLlsgPtnzbwilDemc9lMGV9y6eKZZKRfyWm
 TU6xL1MhRWqCX6HACvd14uK0IGUkGGBOsVdGiFjExt3UpCwdceow==
X-Google-Smtp-Source: AGHT+IEcUEPZdVuGr21TJ8hLxCN8R2Dfoy0DYh5l4U3tL6rkLMMNQ2UrLldn6511HXCUJ2kg24mpMQ==
X-Received: by 2002:a05:600c:5487:b0:477:9e8f:dae8 with SMTP id
 5b1f17b1804b1-4779e8fdb3dmr66365925e9.0.1763399558298; 
 Mon, 17 Nov 2025 09:12:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779a684202sm138842195e9.10.2025.11.17.09.12.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:12:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v3 0/2] docs: Update around MIPS/PPC host removal
Date: Mon, 17 Nov 2025 18:12:33 +0100
Message-ID: <20251117171236.80472-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since v2:
- Generic 32-bit host removal message (danpb)
Since v1:
- 11.0 -> 10.2

v0 Cover:
- Clarify MIPS host removal
- Mention PPC host was removed

Philippe Mathieu-Daudé (2):
  docs: Correct release of MIPS deprecations / removals
  docs: Mention 32-bit PPC host as removed

 docs/about/deprecated.rst       | 2 +-
 docs/about/removed-features.rst | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.51.0


