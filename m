Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6468CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYVn-0007iq-PR; Thu, 11 Jun 2026 02:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYVR-0007bz-OX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:03:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYVQ-0006lY-2x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:03:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso86151815e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157786; x=1781762586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kcEBb80LGLjf44GeKDjfOmiUgct9oqqoDJwK8eSPijM=;
 b=CXXfNtZnNobBPZvOFZzGal1fI/ocD7CVHO317MWBOPj8KukOY1rBoXEaITO037S8bh
 2uBml4wnU8WV3lHSfgywdJ1LjzzzkPEbEz0kGvHjivGMXe2EPBgG8YW3rJWRaCMHujFc
 xsAKXldmopMuyp4RVMS2dVOb5P3M2zEGB4CbYlX1H79HIZA/k82zB67X81T3VJHl/ibk
 JkLv8MdzsYp8bZL3rIHcB+iHufusaUkXgxdk/ad2g5Bc9YGHEHdJbV2U22doNtlQEsey
 hSLnrNZvpCgDJzCBDTaXLH1U6AkniKaY5k3JeS7pwb4DIJHX5tvCYibnPUbmTLssfnUG
 Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157786; x=1781762586;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcEBb80LGLjf44GeKDjfOmiUgct9oqqoDJwK8eSPijM=;
 b=mGbe3n6c6Pc0V4eM5Xe2Cn4cUIQcNtj1JY2a5LOIDb2mopuLZXOxgoZUDk6m6vXjha
 9C4LhgncFW3LuwyF+PShzTByfjCQhmCEze/XyRFSxG1WT78GPGy3mZ1EM30jvB2YlAI6
 h1o9k+Re5STW+GGC7M68r2If4Mb3jUb6YGijaicUesY9e7PEyvtNl4MNiVawrpl+2rX7
 bcXbKNQ+/ECjK1pzDCGa+YkDEj++Jna7Rnm/swcS4wsCfykwmpM6Y1KXuJcLbzE3DphU
 d43q+pUZRdXxa29n3tlpxXYQ81pt75K2QPICRTL4TxVyCL0Xvnqo7WIPVwj/n++H+lg1
 91QA==
X-Gm-Message-State: AOJu0YxugO4WqwLkYtAqgbQnR8uj9D6DBrRSaS7IyI8e/254C4r0t1VN
 AYUbyQYAy/GFggphRl7q0hbpN12smVFZnbFjoUmtM1pZ+9I6A7bcm5ulWEyoXEtpPVxViiIIb42
 Obssvu9g=
X-Gm-Gg: Acq92OGMDvcsjvJCIZF3Gb3Vu/RRpc4G2xF0G3XaTAUsb1XVtZV7h65zDQKSHh9pPjW
 SYbx7gKPmGgirHhiNkgyYfZX+c0VRKcib++lABk+Ee0wFokjRA2I6+fp/8a76VSZKuRMc9teGlS
 3SP9WmtxqTY9K20CmMDAyt7Hy5krMan+MiUXRFfwxIcmvuO4DLAV4IBn0RlAWL0LzE/iddFmljU
 vhjWtkY0VB/PNNNixsG6HpztXZKI4yl72Xy3xbPSaowng0nmpzECyphnmnhomc9wkJWmLP1VhKp
 EG9SKK4T+PBgB9czfx11gZOMe1UMEi0LeZnqUleZaR4EBZnIMHdswRsptbIgQn5ztwUM6I7QU1P
 9O4GUwhWLtgzH2KMyKBDdJeo550V30YOAhFnaxiUCVnHaKVq2n4iDCu2V6ZTOSIFFeey3unuy09
 USpy8yw54ct9qCoBp1XtcP6OhDB6llsr80s7D6nHCOy3FFJnR/sy2yfJG/QFHelR0DTPUQ+7gnv
 MHav0Q4cRfDZBmuC5qScrI2cWlomzSXsoipcggo/blLuXuL1/ldTaS1Q/7D9RTkPLBxGqlN
X-Received: by 2002:a05:600c:1f8e:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-490e55e0256mr13007155e9.9.1781157786332; 
 Wed, 10 Jun 2026 23:03:06 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d046d5sm36562055e9.13.2026.06.10.23.03.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:03:05 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:02:33 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 19/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_filter_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-20-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-20-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgge55.182tap6hi5lfa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> include/plugins/qemu-plugin.h | 4 +---
> plugins/core.c                | 2 +-
> tests/tcg/plugins/setpc.c     | 2 +-
> tests/tcg/plugins/syscall.c   | 2 +-
> 4 files changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 909f19b7128..c38ae7db1b3 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -852,7 +852,6 @@ typedef void
> /**
>  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
>  * function type
>- * @id: plugin id
>  * @vcpu_index: the executing vCPU
>  * @num: the syscall number
>  * @a1: the 1st syscall argument
>@@ -869,8 +868,7 @@ typedef void
>  * handled further), otherwise returns false.
>  */
> typedef bool
>-(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
>-                                        unsigned int vcpu_index,
>+(*qemu_plugin_vcpu_syscall_filter_cb_t)(unsigned int vcpu_index,
>                                         int64_t num, uint64_t a1, uint64_t a2,
>                                         uint64_t a3, uint64_t a4, uint64_t a5,
>                                         uint64_t a6, uint64_t a7, uint64_t a8,
>diff --git a/plugins/core.c b/plugins/core.c
>index 45136bf950a..987e49b89cd 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -589,7 +589,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
> 
>-        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
>+        if (func(cpu->cpu_index, num, a1, a2, a3, a4,
>                  a5, a6, a7, a8, sysret)) {
>             filtered = true;
>             break;
>diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>index 595571cdfd9..9bb5bf0f5f7 100644
>--- a/tests/tcg/plugins/setpc.c
>+++ b/tests/tcg/plugins/setpc.c
>@@ -23,7 +23,7 @@ static uint64_t source_pc;
> static uint64_t target_pc;
> static uint64_t target_vaddr;
> 
>-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
>+static bool vcpu_syscall_filter(unsigned int vcpu_index,
>                                 int64_t num, uint64_t a1, uint64_t a2,
>                                 uint64_t a3, uint64_t a4, uint64_t a5,
>                                 uint64_t a6, uint64_t a7, uint64_t a8,
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index 8a823acfca7..2afd71895e3 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -171,7 +171,7 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
>     }
> }
> 
>-static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
>+static bool vcpu_syscall_filter(unsigned int vcpu_index,
>                                 int64_t num, uint64_t a1, uint64_t a2,
>                                 uint64_t a3, uint64_t a4, uint64_t a5,
>                                 uint64_t a6, uint64_t a7, uint64_t a8,
>-- 
>2.43.0
>
>

