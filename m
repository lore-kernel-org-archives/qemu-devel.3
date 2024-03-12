Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CDC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk711-0003N1-3C; Tue, 12 Mar 2024 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70x-0003MR-HN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70v-0000c5-Fp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41331166961so8584225e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268691; x=1710873491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4gPCByx8mAmPa3WgEs07nx3Ff/naJHLFmK+kpZLMiRY=;
 b=bTP0Ep5b0C4QE5i4b/f9ebCKKS6ilIrhQJHrSePMYIviVi95d3/gWeVCOg6clt3MJp
 xO2DbkjuqxVBkzlXdvx/qI5X2NUErt5T37dPqTLxciGYhk8v5Vy7aM4Vn01mkvtLq14K
 Asa1WtLb53TLAfmqeWotiuvJV6Dbcr2jiJ5mjy0SwO9dPAI7VDmUDA/aO37Pp8T1BxWB
 P/X2edtreZPc0zU2DydJjtMKmzQwpYpEqJloThD6caqXn2fkBrw0wWhLuzRm62SCFALH
 c6O5zp3KgLXt8TwFCDGQ09Z77ZuavOQ8H0VwoxpBLxWX03fnCwXu4DKS1xStsFnj0fFF
 4qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268691; x=1710873491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4gPCByx8mAmPa3WgEs07nx3Ff/naJHLFmK+kpZLMiRY=;
 b=Cl+rY1WEH9W5zZnNLHq/yGWQYJPW6vebisLiz4QEdRaTwuAMgBYfgfz4AxFXOd9emT
 gZH8RgEpVIuqNexg48uUOkVAWMPgGXIImEsdc+S3KJOsV+m5QmxhjnS9n0fenqaMrgDR
 JEqIz5x1fKiHNR+DIMu5I84KIh3JepNMKZikPVkC9x8qnr60gSjMDVZ4SWeca7m5p1MZ
 i6AtiQxBb+mWsruyw5OAmCr8n+MQffwZuuon/R9EuPTAsFaJkCFy0sRCKxNQL0prwqe6
 dLXuM429o4srgxjNq60ZHkSFg8GWEYczWlKGlza5W2jQMtANMUzRPcZ5y5S+AZh3QU0C
 vkAg==
X-Gm-Message-State: AOJu0Yz+7O1RPFW83enZXqYFxeYO5kUAKANH90ivJm85hCslex92FJVn
 0pJMEC6oXMvxowh5xB/A24xOQJYXL+JCYcP+vgGBmIDZX+au3Q1olWK7MquWSMPALaEnhxSWZhq
 0
X-Google-Smtp-Source: AGHT+IFUxPtrSeS1JwpdHjPdCXG99JnFmcVMrZnTpJ5WIQGPZs/hN4gN1iCUx9vYvcOtyfsZLf02ng==
X-Received: by 2002:a05:600c:1d0e:b0:412:f6ce:8152 with SMTP id
 l14-20020a05600c1d0e00b00412f6ce8152mr7656123wms.31.1710268691506; 
 Tue, 12 Mar 2024 11:38:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] various: 7 minor Coverity fixes
Date: Tue, 12 Mar 2024 18:38:03 +0000
Message-Id: <20240312183810.557768-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patchset fixes seven minor Coverity issues:
 * four minor nits in test code
 * a happens-once memory leak in the af-xdp netdev
 * a harmless wrong-bounds-check in pca9554
 * add a report-write-errors-to-user in mac_nvram

I don't think any of these are worth backporting to stable;
I just picked them as easy fixes that reduce the number of open
Coverity issues we have.

thanks
-- PMM

Peter Maydell (7):
  tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
  tests/unit/socket-helpers: Don't close(-1)
  net/af-xdp.c: Don't leak sock_fds array in net_init_af_xdp()
  hw/misc/pca9554: Correct error check bounds in get/set pin functions
  hw/nvram/mac_nvram: Report failure to write data
  tests/unit/test-throttle: Avoid unintended integer division
  tests/qtest/libqtest.c: Check for g_setenv() failure

 hw/misc/pca9554.c              | 4 ++--
 hw/nvram/mac_nvram.c           | 5 ++++-
 net/af-xdp.c                   | 3 +--
 tests/qtest/libqtest.c         | 6 +++++-
 tests/qtest/npcm7xx_emc-test.c | 4 ++--
 tests/unit/socket-helpers.c    | 4 +++-
 tests/unit/test-throttle.c     | 4 ++--
 7 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.34.1


