Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CF5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZpO-0003L9-NR; Wed, 24 Jan 2024 04:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZpM-0003Kj-GA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:45:48 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZpK-00066M-Iq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:45:48 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a30b3a9e9c6so205093066b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706089544; x=1706694344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PXcbFBmtwBAGh4cCKPENK1zKs+Y2Eis4Z+AQx49ny8A=;
 b=E7pae1NtmT+LK1ATavQpGWnLCGpaQoyhRKMpCSKtnZQj8G1IYxb1rXrPGhrimPF6iA
 ofwyPYdfWoi9R1GBTNn1hNIK+TZp6v2LHstnEiYdnjIwCs7wVBu9cyQxblUlUHM/nnMM
 DNN+6Ip/cEposvSFxV8pY/yy/6V9gQJ2yyv5bxTYoWzWrckcKRd4OwGkc4ghyGdT6Tmv
 Ga/xOjF9/zr2Uyh9X8mLTHUx56BCyr4O8asAgnNtPMu5jIi6wHoa65lF9euAs1mE4Lba
 psSr0ByXX6MyhdvuL6Woig36xQIAVVfzTDymMXF157YGBUmc9RlBmBGrP1wgLuNJ/zGh
 eOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706089544; x=1706694344;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXcbFBmtwBAGh4cCKPENK1zKs+Y2Eis4Z+AQx49ny8A=;
 b=Xmxo/UV6JkHDB4NKgGHQdcwHbgGVTt9uqGc20CLsxTY+s6BElBsS4hMxlkYP3HGkLo
 NbdVKnfGqEHoLzwwFwzE3+ekj/xJLBKO5sSA44L05p3+TvmNzGiitnnKB6riuS4aFBFp
 ucwy/Y9US9W1gHTmHTOaS3s2fbq+C00+N1xN20TJLWL5N1J3ladFV11BeCCZwzH/PRwz
 pfUzxokj3JKs432esTozgsVxzL/CdfFVpid5LDtOy4refujXU51C+BPm/Oj7go0Z3WGf
 K/DzTFIMqUTUJyBLYrv2d1QGYQwZFhMwLi+wObgsU5TGonHDwSqTU9cE+0B4joJA5F7c
 /BzQ==
X-Gm-Message-State: AOJu0YzXgCUlj0equW1PoBDv+4aP6ztLizufhi0Hi84jK5Za/jtYw2yT
 bk5ReejeQb/soJ6QHCZwy5VbiO64j9sFJoHd0We0LjyqMPTc99uKWVQAvcmcOQxJlX2NGUPaF7Y
 OOrU=
X-Google-Smtp-Source: AGHT+IFyRJAIyMqH/e6PCw3r9oYeHMPiReMqPONgZ3xsyXC41oS5gmUUd/forPcRlYwI51Rrt7td4Q==
X-Received: by 2002:a17:906:4698:b0:a2b:2615:25d1 with SMTP id
 a24-20020a170906469800b00a2b261525d1mr340653ejr.90.1706089544113; 
 Wed, 24 Jan 2024 01:45:44 -0800 (PST)
Received: from meli.delivery (adsl-90.37.6.163.tellas.gr. [37.6.163.90])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a170906455700b00a2c70ec1533sm15010038ejq.66.2024.01.24.01.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 01:45:43 -0800 (PST)
Date: Wed, 24 Jan 2024 11:34:56 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 1/6] accel/tcg/cpu-exec: Use RCU_READ macro
User-Agent: meli 0.8.5-rc.3
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-2-philmd@linaro.org>
In-Reply-To: <20240124074201.8239-2-philmd@linaro.org>
Message-ID: <7rf45.nwdug15ftmcv@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Wed, 24 Jan 2024 09:41, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Replace the manual rcu_read_(un)lock calls by the
>WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
>"docs/style: call out the use of GUARD macros").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> accel/tcg/cpu-exec.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>index 67eda9865e..6b3f66930e 100644
>--- a/accel/tcg/cpu-exec.c
>+++ b/accel/tcg/cpu-exec.c
>@@ -1070,21 +1070,21 @@ int cpu_exec(CPUState *cpu)
>         return EXCP_HALTED;
>     }
> 
>-    rcu_read_lock();
>-    cpu_exec_enter(cpu);
>+    WITH_RCU_READ_LOCK_GUARD() {
>+        cpu_exec_enter(cpu);
> 
>-    /*
>-     * Calculate difference between guest clock and host clock.
>-     * This delay includes the delay of the last cycle, so
>-     * what we have to do is sleep until it is 0. As for the
>-     * advance/delay we gain here, we try to fix it next time.
>-     */
>-    init_delay_params(&sc, cpu);
>+        /*
>+         * Calculate difference between guest clock and host clock.
>+         * This delay includes the delay of the last cycle, so
>+         * what we have to do is sleep until it is 0. As for the
>+         * advance/delay we gain here, we try to fix it next time.
>+         */
>+        init_delay_params(&sc, cpu);
> 
>-    ret = cpu_exec_setjmp(cpu, &sc);
>+        ret = cpu_exec_setjmp(cpu, &sc);
> 
>-    cpu_exec_exit(cpu);
>-    rcu_read_unlock();
>+        cpu_exec_exit(cpu);
>+    };
> 
>     return ret;
> }
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

