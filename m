Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD3ECD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYTA-0006mC-HO; Thu, 11 Jun 2026 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYT6-0006lR-I7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:00:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYT4-0005tE-Sp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:00:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b7866869so81701545e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781157641; x=1781762441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IE/b6nh2S6S2K1dLNJCbwYnCQk0HSOmMn1HLPTVn/QI=;
 b=jrKKNy5Ma5nnjjzD36TyOU5apv46KGIQCu15oYYXZLoeTkFzPKBHQ6EwutTZmhwaq7
 d0SqQ6g6tkYN9wmhgZ3a+8ynUXQ9U6+srDsJkPwDSjiZ9QHKm89z8lDw5xDMracYZ3UN
 Sfatnsmu+NIVFl+iin+PTBng6vfUDWI2NG75fIC2Se/4ICfW7HpVvvnwe4ixhQ6ZPnL/
 5jmSeNXS04FYggtdFw0THYIplJr3OGYTI0giipb+5DJfiU+1zCwfn4kVACke+c69ysYr
 yQrUFS9w/p84TrCQFkBxOMtvodiHNVn1R2jxtEBTkjuGCxQBkh8Va6GOMKpcOKdya9x1
 l1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781157641; x=1781762441;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IE/b6nh2S6S2K1dLNJCbwYnCQk0HSOmMn1HLPTVn/QI=;
 b=Vpuq9adADeNZemhagaR8bRGde3BwepJAFrGndpMEEJPI73dpCFQOAMPgz1XP2XWfo6
 l4QxmYa1ElHJlZ5YvDbtAwfGZMRFCpAkTIJDrM4tZ+pcPMrmALeq9heSdCnjOM+JqaMG
 tyEApxBwN0D6a6emlIzVLm+0uGWnXt5/3ef/XtKR7VE+nuKVQYJjv0r5WNuvWI49fimC
 tzGAIOce15HPJcSJkGHq0aj4vulQ2pjDzhnHFRK3moobTGrGWnaa3ylmh+SzPrjK64gm
 GyjNWvEN5e9KBNgMEKn8aqJXXe3XPgmt3WRWSp9VFKL+NtCNIQfkT58YX+qJ0PSmcTMc
 K+Nw==
X-Gm-Message-State: AOJu0YzHoJVqmDD35XZvKrx3pp9OvXht67/0UHl7GgdXhnn8484dry/7
 71zqyJ22puYTfGMsuIvC2NL7015Ah0wnNubTv/ArFqV2CYkOc/XdRBW8OqIWkprh0HvbwTqyrSK
 cIQC9VfE=
X-Gm-Gg: Acq92OGaSe6o82kW89mdenm+bNPlI9V3oDv24M0h6HqZQieIYk9elkt5x//KXZMOhrb
 clHkt2Eor/3UpSPb4p5PZ60HMBR2PMhOi2GJyrB57lHNzLaFqHqy/RkqajlaF3NyRRx4MFKLcAo
 rPsGtYm+WDtYj+Ru5XiyzRFe5/2k0vux+pNR4lX7/WZa8ghDNertqNMBNUOxU2+vHK0TEVQO2kc
 7tk0OHK1nCdfNKK1A/DeILQtCqOrHEe8tHAarmrvpjSZbz5g6zXlCYsEy+JB6HWryVl36gYDhkK
 FWgqMZaV8uGsB83NodwEHqIkjBQz3VozyY1XwghIgAdMK1N5cl8Q0/CO9oF7+H5GJ5siKJ0Y6dP
 Lg3y4sWkpREhJNwnsEr2GM6PDQqRlRvS2wevZhJ5dWMHP6fQDwGIAR/sGLARuSfIWGkchWUf/0q
 ykSOy4jQ5h/N0454lk4jjLGlu1T7Mjc8Zk8P4a4PGZfCXSFlobEA3RfDQW75r9FbDoxfJ1VSQKB
 kV9uZUz07F3zoRLsS30vxgdd/a5iy69/F1g2L7KAkg9khNhKEwXLUT/4xVbi31FuP0mxvV7
X-Received: by 2002:a05:600c:c493:b0:490:b780:13f7 with SMTP id
 5b1f17b1804b1-490e5639b1bmr12195095e9.23.1781157640820; 
 Wed, 10 Jun 2026 23:00:40 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e44ba907sm23810845e9.1.2026.06.10.23.00.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:00:40 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:58:38 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 17/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_cb_t
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-18-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-18-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgge13.ywz44szsdoxr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
> include/plugins/qemu-plugin.h | 3 +--
> plugins/core.c                | 2 +-
> tests/tcg/plugins/syscall.c   | 2 +-
> 3 files changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>index 53daa09fc72..d82d996bce6 100644
>--- a/include/plugins/qemu-plugin.h
>+++ b/include/plugins/qemu-plugin.h
>@@ -830,7 +830,6 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
> 
> /**
>  * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
>- * @id: plugin id
>  * @vcpu_index: the executing vCPU
>  * @num: the syscall number
>  * @a1: the 1st syscall argument
>@@ -843,7 +842,7 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
>  * @a8: the 8th syscall argument
>  */
> typedef void
>-(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
>+(*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
>                                  int64_t num, uint64_t a1, uint64_t a2,
>                                  uint64_t a3, uint64_t a4, uint64_t a5,
>                                  uint64_t a6, uint64_t a7, uint64_t a8);

Unrelated to this patch: this is an ugly function signature. It could 
use a "syscall" struct to hold all of these values into one argument.


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>diff --git a/plugins/core.c b/plugins/core.c
>index d891da93040..878fc47cbe1 100644
>--- a/plugins/core.c
>+++ b/plugins/core.c
>@@ -533,7 +533,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
>         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
> 
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>-        func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
>+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
>         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>     }
> }
>diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>index 938646f9359..bfe12ad5558 100644
>--- a/tests/tcg/plugins/syscall.c
>+++ b/tests/tcg/plugins/syscall.c
>@@ -125,7 +125,7 @@ static void hexdump(const GByteArray *data)
>     qemu_plugin_outs(out->str);
> }
> 
>-static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>+static void vcpu_syscall(unsigned int vcpu_index,
>                          int64_t num, uint64_t a1, uint64_t a2,
>                          uint64_t a3, uint64_t a4, uint64_t a5,
>                          uint64_t a6, uint64_t a7, uint64_t a8)
>-- 
>2.43.0
>
>

