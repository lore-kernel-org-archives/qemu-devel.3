Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DEB108E1ED
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQ5-0007YB-RU; Thu, 19 Mar 2026 07:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BPl-0007W1-Ju
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:19:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BPi-00046P-GW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:19:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48374014a77so5601275e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919179; x=1774523979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tsvpi0Nv6unOmAIYlVVsHJQ1gspFFY+qEHNCXl1oUAw=;
 b=Wc4ssFKzJcAoizE3uihYiqsoHWKvjFqqIlvxwq7VmdBtJa1ID3/EIIWYrWtzmKvilq
 FhjtshkliRMpcPtCZ8ODIG2WgQVejDyuy9lI0gfWnZXjTBSBWTlQSmFVOoStokHQ0Bcx
 k1xzYPgiFrsnZT4nISGC3wxJY1buu3C4k2MuOg3Eb8v+SJPRJMf+PC4D6gBj57OBLHGG
 P3JvtungNbZd6oFqRTpbvoPXz++XutEvAqGTzGdZ15pXvvV5y6ogSHZ7txtdkkmLvfIa
 O7t+og0fg2tg9c8OaAwodZwsPKGzY6f4uUbmglAxaXC5jrRkSjd0cd5pr/ZTxBdWus7T
 /79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919179; x=1774523979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsvpi0Nv6unOmAIYlVVsHJQ1gspFFY+qEHNCXl1oUAw=;
 b=OAznE/FH2nrrkZXncmpJddLf4RInvronrGCsS9kkYjHS4AWanmUF75f8sd+AdtnGu6
 Sv44S6Yzz1UYSoeHRj9/9bOe2sksADt4EqK0wY723RWJ/lmAqdvs9wPubQY37WBNQYmZ
 sx95kxoXEnPmeQAuhFpFeKspol/Kzf8+rXjgEOn40DItNk4tnm+EHzSCMCwfdoqqvRjz
 WwHPs9tfTVEN8XMTkghuQdqFzuMSQFpDqe/1F/TLy8LJBvc2XwtZfxVrAss/XvwzT5rP
 /SHb2C15s0Opt4LwyaVpGR9eo/4e5E3RzddB6EeSse5CtyuCvA1Hm94lUR3dD1x6ZtTt
 gV4g==
X-Gm-Message-State: AOJu0YzMQEds8mPxOwWzLPXFHchT+y5DXwvFBidpf1tVCGXfo1sZjY2a
 nXXQCmjNLxGVbp8vkOBS1KnejLDWxNqiZr40iIyuL0I6zySgT8eaxegLGv2zmztJtxek+P0pS2N
 6EgnmO9U=
X-Gm-Gg: ATEYQzxvjplu9WonnfZd1IUk6v68p4KH/JrkvYZYNn8hYX9Kj3TEnbnm63KDsxf4jrt
 /C0jHl5WdwAHkudyx0DV7exWEWq0UZLTRUkjED9/fbeO7WfVvIcUbcJcjx+FOhcMuwFp6r4Xmrr
 8ltAYAvYY21MyWOsBhL6cH8GETlnFXZxeO2uMTvm4cD9rOYOLGWvw3znhIebGgic1VlloMYx0cv
 TujjnCFlKprtk2nJ08adApPaCYqbzfx29pxAgfmnyxV1q2twGFfYq69pKvWS/6Q07DLsVKHQwgh
 h4RoPGS7CfvzgiDCsCLlS4Vm+bRUs+UpRmDteLsjwXzTvFEEZKyaunHErsz8j4B4lHMj1gu1kPG
 YLDwvfbDESK1yito51clcCM+0AazZhs1VIqFSv1RoD4/7nOzdWlgRQk2p3ephm4b7TB1Kng3ope
 x5iT6PV8yOYitev3krv0bhnSj6y6S9uQLFKDz50j2fDhOFhv7yH1fCz3t1DNkwncCNw9Qj/aj5
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id
 5b1f17b1804b1-486f442d3d1mr113139975e9.7.1773919178807; 
 Thu, 19 Mar 2026 04:19:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fd9845a2sm10632815e9.6.2026.03.19.04.19.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:19:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
Date: Thu, 19 Mar 2026 12:19:28 +0100
Message-ID: <20260319111936.68041-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace legacy ld/st_phys() by address_space_ld/st()
then lock the target again further legacy API uses.

Philippe Mathieu-Daudé (8):
  hw/ppc/spapr: Un-inline rtas_load/store() helpers
  target/ppc: Factor common ppc_load_epr() helper out
  target/ppc/mmu: Remove unused hash32_store_hpte() helpers
  target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
  target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
  hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
  hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
  configs/targets: Restrict the legacy ldst_phys() API on PPC

 configs/targets/ppc-softmmu.mak |  1 +
 include/hw/ppc/spapr.h          | 18 ++-------
 target/ppc/cpu.h                |  2 +
 target/ppc/mmu-hash32.h         | 32 ----------------
 hw/ppc/pegasos.c                | 67 +++++++++++++++++++--------------
 hw/ppc/spapr_rtas.c             | 15 ++++++++
 target/ppc/cpu.c                |  9 +++++
 target/ppc/excp_helper.c        |  3 +-
 target/ppc/kvm.c                |  2 +-
 target/ppc/mmu-hash32.c         | 24 +++++++++++-
 10 files changed, 93 insertions(+), 80 deletions(-)

-- 
2.53.0


