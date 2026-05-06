Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0695CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmR-0001Zh-6H; Wed, 06 May 2026 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmM-0001L2-Nl
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcmL-00008y-7r
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:59:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891f625344so10775835e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075946; x=1778680746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uN8T65pcJrUdZDCUXjXD1hQNK+NMnAn+DBz6aNKLp7c=;
 b=wX+eSdgkx6VCadmI3q2RkjVl8bsxON8tlu8sD+7pDZ87bMzOKLsj+WQ/L40AJaAIuE
 r5rpKNSiqOjZ26m3rwBnFxhcozN8yXDh9dAqH41TNgshJxtsttmBMHPCVy63wMYk0IFr
 1Dvsfqhe8CHc8pSIR5/MfQvkObDpz/puX/1h9Dj6XeXl2UUZlny9N+kG3WVkYHylGPqM
 MaMak/urO7+sgAxF7VoqznaoB9qo4WpYzxIl+GP5n6IoIh/DLt7QDUZ1nT0nGAgD+xXn
 +XRpJUXPo/RsKG42C2DKgpijMqPubygJKeegOHolovjjKu6NlR1Wt/evxvnq5qAxfo1e
 B95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075946; x=1778680746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uN8T65pcJrUdZDCUXjXD1hQNK+NMnAn+DBz6aNKLp7c=;
 b=HgxFFTQJ2Lb2sw0v6esHcMV1wOyTyeA+O1Sbbw8Ff1TSBdxNw8mf9NP/PSF60bBmB/
 SY/rl4kS/El/9cLeT8kJ59cxFo6CpuNVE7Gm/IITxunHcZQxuxw6eYjS0+OLUsgNXsKZ
 B6sc5kgu1MqyVxBNZ7wl2o1oQzFh9EGPp7AI2SanlovQopyIJl7iL6b+fEWeWDgVuqBd
 xTsXF/mmlpVRBzQ0UXlT6GyFzWZ4hzS8s6yupdVbN7z+X14c77fVLJ0F3rl6JcB9CZik
 h6B85IvZZuyzAv6tNArCdjWYX7x8+0jCzV26Bkxk2MRV/2SCdm8qt7ZRBxUNFJTjjF1P
 qYGA==
X-Gm-Message-State: AOJu0YxOiyvZ0A2kiI80juHyevLPQMjpKoYUuF7eZkXyrgkF1zltkQ3l
 KcyWu2YfVtnDSPcziwu5hTAj0Pm7Y9wqObYIvsGEGhJBmDAHNah6HZyHkmabC/RCx6jB294nWYv
 hEKVHHl8=
X-Gm-Gg: AeBDievH6GlxTr5deIn7/NSrirJ4Voqet8VI9mwzn4hClpdv669QPVIHu5PkpsslJrX
 q7fkU+E18TUFnzt3N9e7NaMAuXY3h8tmaYXW9414wtfyzGky3r68TKolYWFpGWG3hPH9+TVqaqK
 mF9fYrF/MSq/RoeLLdditQcGQY3Wg+cz5GbCuH4AE8lUpCbo5+pD5rVUxTrZ8VMRVNULlO5+hvK
 q6YFYHxATGAqG0xomqxtD3BOxEOeUrfctAKs44lxuLu6avdEdNyyGhn8+8RCalp0oSQmE2o6ZbJ
 Ehr5Z8fsBxyX0rH1vSGatvgnmPpAVP3Sy68VyGTfzC+cbjh/E4BIF9RiXSCW2Jf7uCDKXOvMTG2
 J96izjx52nRO02sP97DLCCGpl20kOxjZCIP1gDDSgIy4cpnJDb43Q4dMS7HDKy5joKBc8USUS75
 lq6Zk3tpLGh8jwjB5raro5mg5DVGI6nTHN/07Wi0UjDqIxjovIrrg1RR8V0h01e55yZGUBwM7sA
 VKM0qUZWGQIk7OzrWARnQ==
X-Received: by 2002:a05:600d:d:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48e522c0909mr40440065e9.14.1778075945900; 
 Wed, 06 May 2026 06:59:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53147bc2sm28581545e9.6.2026.05.06.06.59.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 029/110] migration: Revert "Add VMSTATE_UINTTL_2DARRAY()"
Date: Wed,  6 May 2026 15:54:01 +0200
Message-ID: <20260506135524.20617-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The VMSTATE_UINTTL_2DARRAY() macro was never used, remove it.

This reverts commit 4597992f624c015ceb51fedb4628b3fdb1e5bbaa.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20260325211728.89204-4-philmd@linaro.org>
---
 include/migration/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 1335abe2230..e3d6c06b7d4 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -23,8 +23,6 @@
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
-    VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
@@ -44,8 +42,6 @@
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
-    VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
     VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
@@ -55,8 +51,6 @@
     VMSTATE_UINTTL_V(_f, _s, 0)
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
-#define VMSTATE_UINTTL_2DARRAY(_f, _s, _n1, _n2)                      \
-    VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, 0)
 
 
 #endif
-- 
2.53.0


