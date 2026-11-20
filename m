Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C95606A6E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Se8/GJD9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtK-0002XC-3D; Fri, 20 Nov 2026 15:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrR-0001AF-Fp
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrP-0001ug-D3
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:28 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so788652f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205126; x=1795809926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jqaJoBWzttMgghzDuItN9fmBIgP/5WwcVslib+c7UTE=;
 b=Se8/GJD9u6eYzwsTb5jZ2t5vkD9OksKDPxjFiMQ+EZOsQsR22dqEz8XGvjscxjuzSK
 vJVTbSzBP7/AiJuD6dX4V7Kx+yZLyWHN0/oXQdaqzYJJi5XGWBs5iuNApvkVCvIWgMeh
 z48y3nECZlAkICILtxP4Xp7fR5tHKGbsYNE6tF5VxiB2CkFIeWWmCOWvrVPDJR68JJRk
 9r4e6yw/wMXi3v13RIoYPzcUtZSgtzA4FFeHA4DA6XsMgerXFCF867433o+fW/FxjpVG
 pQWIY7PK/KRn/GT9PSxkN13X8hmEAHDD5EOPIjQ3S+NcVpx7l/NvH+3lp1JzGSd+4e/U
 hPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205126; x=1795809926;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jqaJoBWzttMgghzDuItN9fmBIgP/5WwcVslib+c7UTE=;
 b=AuHrpsYxg1wTD12033ectH6Z2PekCZ6eA2EwusRRqriLirUEMvqFQS/E4IFTF2mRf5
 iekhGLO0IuO05lPkhg2m+iZcSsTsTuzNP6zbYYTFsfDLrdksZZYy51V+XP/G9SplgIb5
 iPV4QgT+IfSMDgdXWgtRNcY/g701LQEHiD2sjm6wQV7LsZITT5zOYiKQa6Mbz0abE6WV
 JeM+g/pc1tWhifmWoV7c/fFz7gyzRF3fv83Y3HJR95Es3O2fPBhw0MEx/jTR7xtjXBzp
 VftQCjMXsd+znoH85PjpDiIWLYap+Ih16Og9pSnydxlaObU+ee7MMcopVNazBzfu8wqJ
 VLiw==
X-Gm-Message-State: APuU4Z/Eh4D7W5j1Lcy5jFj+n2iWF/JgCkIMrONlSbGX8LdfgK3Q5f3O
 eMygSu+r/o3bWKMt34f+MUsxwC4lMer2EeeYlFln7Gd/LVh4v7sbqlhVZoAdhtVRwYZrqRO8Ef5
 SObUd
X-Gm-Gg: AZFdTZfku3hyzHhTOBMqSwWYx7Br2hKoSy+kL9GQKHaEHFPOK6W8gFuHrLSLG+7SU7r
 QkmOxzV7u5L0rKnGoCYXBbPgsFYvidnHW7Ah2L6wQn9Y8UM5/QDcKQa5wmSoWIryPgAo77y6B3t
 lB7X9lfSCUly4yUbEDvvmnVqkab7TMr/KQ/1UjzkOUhspQCXWMJF5nkZKid6LJZ7lhkyHQ4Sbd3
 UxlxJWBSR6hwZndlhe2cFNgdM9oP2mY9Kol5HTmRwL5hQqHM/Gi1DIfR4GGfD6/70akCkcMHJ+s
 fRs7kBwsd1itMPRUaap2xfvoPKXfQlS9bSzUGKdIAd1Tluk44l4Qn5k5A5m2fVm3MuK+uZJMCFU
 cgWnDC+BJLO+1vqJYzl9o8fnF819DpY7aXbH0iXwLBHQZwc1PTBkeY8RlKTJV0I5QUVD0xiurpp
 XSLrA0qenqEGpSPAL5von+kQg7h2oAqZ5MT0bREyufUU6Hp0kCzuzPQkG+t1/wKAhO0vgG8UGzr
 fBYYdq6VyuugBXdKBNMooV000t+iMnB6/BPxMQUweOSjGO6Vlsy64sxA5//IwKKuZhnqejR1jb3
 j0P4YV2GBBK33yJ6iXKZWoGMQjY5
X-Received: by 2002:a05:6000:184d:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-4abacfea55cmr8822312f8f.8.1795205125547; 
 Fri, 20 Nov 2026 12:05:25 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm7413199f8f.40.2026.11.20.12.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66E785FC5A;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 20/22] MAINTAINERS: make LIU's entries consistent
Date: Fri, 20 Nov 2026 20:05:08 +0000
Message-ID: <20261120200511.822573-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All the commits and s-o-b's use capitalised entries.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c5d0b07aad3..5d1444ff661 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -367,7 +367,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
-R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
+R: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
 R: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Supported
-- 
2.47.3


