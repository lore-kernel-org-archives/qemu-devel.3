Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A4C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgS-00051A-UZ; Fri, 07 Mar 2025 16:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgR-00050Q-Gz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgP-0001kL-PG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225477548e1so431615ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384600; x=1741989400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=tHEICw/U81rQ/yGMIdAP+wbkRDHHnxqeU7f7vqujqjqIqYVJTqj1rSfRYrFJBcre1g
 Z5xH/aGc4t/vmWnHJTY8jr0xlI+qYCOZWLI/wT08HzKzXmwkk2hgXh1DmlyL4VpDnLUd
 jGru8vsReuJiE3Tqc1Z8Wtczd0T5Ec6Snm9QNT4KvVCXi3KpcBD6NeuBX1/deNb4Qlx3
 4gPYSf+/C+fnRZrUVYGjTvypAlku2h0H8mneWp1WvBrYL6/Xog4pwoHlZ/xgb4afT7vT
 7qPEXQQzpR71y5P2VlEyr27KyxmVRDXMjfIbh3HjOHfqo4t3lhN5lFOoM/TGs9VaFV8x
 ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384600; x=1741989400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=grGmHE/FJOs3zldsnoE7YuKqC6FslwM9gU8ZaZZh26MxdL4sqHcOMxNlwZxUJAyLgT
 +4dmEkZO8PkJIsJRwn0XPE6BwweUb9plX2aJbEUEhl/4L54hjv3fpbqwSwYh9P17X+/z
 YNh251WldcZVKdhVC4FlnjWJ9EP2ak1QFdh3K9n5RwyD3sKON99vmGih8gcnCEhFulMk
 pJDthlNhoV36Dj3xuzzTigZ1CrFK58kozbPMKBDErkvlntloVhNsTrUFbWECsNPEbSqS
 aSeo7thFuOm/SqdNqKMBGfcRFsz5dPqHmUWCL0xmmug5RdZynB+NeZvEsouJGED2g6CL
 K5ug==
X-Gm-Message-State: AOJu0YzJDuNUuhPC+rzvwjysM5R6Gz3h05HMWDOJyDpBKG+xKcD1T7wY
 sn6ecIiQhtVE42cK0h/xu6HGkHshbLrwa5rrbuaIzrnS8wHkJhTIyx+WdKyBD+DE2E6OSZ1KenU
 z
X-Gm-Gg: ASbGnctg5AsAIiv5PLFJefFVph48+JiHN6ZRR8SfErdYX7R7jl3XY5cPBwQGpL9jCNm
 gSzx8QpN3ZsweJ4dtDiNn+RiVo42VNuFtTzpiCaVEgGV+7YLF3w06DYksEVe6VAYsF8mhuql0vt
 wWQoNTe4SX/tWjdLOkVyfYo/329+2a8CuvK5gH9SlGfI1BpQ24QtFsVxGi64jEIXm8HPE7KkIFX
 nTD0anVPr4uUxF9vFSNeOwhmVbYNHGYFjLkCG1Ulozhi8KcgMS/rC1BGkdwjQnRYqsNMn0V90E/
 DrP80ZRj1e807zXFD2zshVjf5rxjjxzYc4djSvh4h9NA
X-Google-Smtp-Source: AGHT+IEpBLPbNDwbFWHbtDFWg/F3o2uXMTLWPQlQ0zMSbaU7eLTdBBkOHLlJs+mEDdjKeNRx4XKwJw==
X-Received: by 2002:a05:6a00:3a0d:b0:736:362a:6fc8 with SMTP id
 d2e1a72fcca58-736aaae41d7mr6920551b3a.15.1741384600200; 
 Fri, 07 Mar 2025 13:56:40 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:39 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 7/7] hw/hyperv/hyperv_testdev: common compilation unit
Date: Fri,  7 Mar 2025 13:56:23 -0800
Message-Id: <20250307215623.524987-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index 5acd709bdd5..ef5a596c8ab 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
-specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
-- 
2.39.5


