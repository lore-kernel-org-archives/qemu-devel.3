Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261F2F36BAA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4Hw-0006Ml-UN; Fri, 10 Apr 2026 01:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wB4Hw-0006MR-1x
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:20:16 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wB4Hu-0005NU-7n
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:20:15 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2cfd69b564dso2303702eec.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775798412; x=1776403212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeRb9OZMxqyROpUwNt/lYm+VexS0qBiKUzLUseP2hEs=;
 b=E0pG1cChPFA6hbxntZsky+61GpXVY3abNlia298RJmWrugP1f5yb9IhEHyV+DKyeY6
 3+v3Cnjqw3ZQJy2xzJXQ1FQcSlQHq2/5jdeteofVVqc06kSUY1YIYCCxH6TX0VGo12nT
 s9bt7Yhi8LCPG5/r/Ce8hL2xko7Jj1hFJVpU9ZJpYjf5EjPzAEkLHAH59Zr8H+2yQbxs
 8MnUI72f5V/iGDz3VDe6KsFAifTcdoEZc/kajQ2RwcpoL3VclYulVH9mcUJxCZDQMgpp
 EpbWPIgPvqDKyypZug55xdH42hx8z8JXUkAHCW8sChJhINXdGdWdASwYSepb1IIAIwPe
 KQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798412; x=1776403212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JeRb9OZMxqyROpUwNt/lYm+VexS0qBiKUzLUseP2hEs=;
 b=IQqeBsbL/3g1t2dP57CNOf96IqhstcID+N4OAg7FUlE+pW8dldzioHLa0Uv1iRqcf6
 1BlyQdwj2Xb5Wr5LHJ4IjfzP4jUpE93eO3cdrdRQo4kuA++8q4Tn0gfr9869+fzvZuDH
 NEiXefc9jRWuA4aF8BJ1JrwtgHFo3MQcEBSphs7xQJ4zfVPeBFyjTElEUj1ZxMpw0DhO
 /VFQSPgeUY2JeLm9KeAzx8WCFTGLRhS7kzbmv+sxWZ8DAGsYqVKLO9nvrFpEOJ8Zr3hd
 dyV8LHqGvBalzQ99spGM/I/IGu1oG6SrSa5O1ovqsefOUvYjS5xn0yE7bZpGU72qBlrg
 RiXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJzlN6BHv3Jwk/4Lquzsddr/TogQqMEwmsjV4VKOCln5AQuoldWXi868SqPGsXPGpZa32es6tmNnd/@nongnu.org
X-Gm-Message-State: AOJu0YzVcuvM2rqi0/kk4G/tFjDW0bwQRaWkcfUl3d4oC6aYB72MNZFg
 CPxAENZZkyfuzDo/OAzuKzBkqxxTIKPooWzOqvbS9gAvl21rMZCU9vSP
X-Gm-Gg: AeBDiev+Nd16s0aJbdWG2usaBdqQHkN+URLb0th1jLSmhngQozIXYIMySJgalpOWxag
 Z7vt9NFbGhEQuNWiHvkUF4ELMTaofobkABtEW1Edbix9doRRLXNbhDgPVYRz01QZYJ7F09MgcL7
 FNCj1PKEDCE3+JE+nHyo7DWm1NZyLNExgj1j6WI0ppq1Ipw9RBYSZA4U/6PSUw4W43s1VzGuMyX
 95FnD8Rp1rshXfLqaVleD5q6rNYWSfqMi0IDb8T5NIQcmNEmQvIAZHlIMwwKUXYQrQDRxW3dzVQ
 8sA9jMxZ6WiPkjwJxNa0OxMRc8JoDtC+m/PEds0m+jVuLPDv428eCXzVOq5hBVJaRN2zhcvA9g3
 5/FhTy52FLNd+YMpMpEi8mGF0dnG7T1zb/DDqycMW0y1+Edwj8OjDNHuzMr/cyRI82KbFwX3Ch+
 NlqXLfaFuTwWjvKiPKIp69PDWlDa80y9jobCk2/6rMMwIiNpEp2tyorDJ2OECQQg==
X-Received: by 2002:a05:7300:e82b:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2d5881ad24emr1107412eec.16.1775798412080; 
 Thu, 09 Apr 2026 22:20:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde70csm3407253eec.15.2026.04.09.22.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 22:20:11 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
Date: Fri, 10 Apr 2026 02:20:04 -0300
Message-ID: <20260410052004.79395-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <4303E81D-5539-4666-BBE8-BA58E3F72B6F@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <4303E81D-5539-4666-BBE8-BA58E3F72B6F@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Mohamed,

Thanks for the thorough review and the Reviewed-by tags on all six
patches.

On the observations:

> [1/6] Perhaps having a common version of this for fetching the
> instruction

Good point. The ISV=0 wiring in target/arm/hvf/hvf.c and
target/arm/whpx/whpx-all.c still uses cpu_memory_rw_debug() to fetch
the faulting instruction at env->pc — Henderson flagged this for the
library code in v5, but the wiring code was out of scope for v6. I'll
investigate factoring out a common get_phys_addr() + address_space_rw
helper covering both call sites and send it as a follow-up.

> [4/6] Do people actually use [exclusive load/store on MMIO]? And if
> so I wonder if that's an application bug...

I had the impression that virglrenderer hit this early on, but I'm
not 100% sure of the exact case anymore. The v4 emulation library
tried to cover the most likely ISV=0 triggers — load/store pair,
register-offset, exclusives, atomics, CAS — without fully exhausting
the ISA. I might double-check what actually exercises this path in
practice.

> [5/6] Maybe there should be a restriction to put a warning message
> somewhere if an op happens on a non-MMIO range...

Agreed, that would help debug guest issues. I'll look into adding a
warn_report_once() when get_phys_addr() resolves to a RAM region (vs
MMIO/Device).

I'll send these as a follow-up series once v6 lands.

Thanks,
Lucas

