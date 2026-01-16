Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BA6C982F2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgp22-0001In-PZ; Fri, 16 Jan 2026 13:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp21-0001IE-DS
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:49 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp1z-0000il-Jt
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:49 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2b6bfb0004aso1592897eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768589925; x=1769194725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DS0knvNd8W2ZcuFUx5T6BmLlPwXKP70beT+w9coo5GY=;
 b=l4M4m9UJPMwsb/wg8Js6gh9XjMA3799dmdTt+RG5TomBDwU9vJXnUZYo95YbUPFEIx
 tixvK2kiMpC3IA5uU3PyoMwAfkE7SU2B6jhl32WrB5EQGMt8rxiKSmcNWYF7iGmmwGYI
 HBuKHcU4J14Qaqo0iBZKNsOjj1VpCkAhpIa7INqlaHcobKYQbAEOvMTh66fLyFOuoAw7
 Hli2VyknCzojpOjUHumZmsZ5x79tbU3dvv/znC9JVRA5WBtsCP2Ejb6wnIc4AbaNCsP2
 RUtuneaXnzA61ZNxS8fMdYFioI0oiUv5peSqhZd8iUh+0D2sfOeSNGyFZZXXl5zyAmuv
 rLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589925; x=1769194725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS0knvNd8W2ZcuFUx5T6BmLlPwXKP70beT+w9coo5GY=;
 b=UHef3rsuZwbpGsAh2AMwl23f5yE7sGsZrAyPBBFmVv4QEhhqpjdSzHwS28xcFR64xR
 oGobgWd5YtY8mZ9Br1J1HrKsyfFu2v9ONj8Cd+Ni/fUQDQTn+BoLhLySwjB7tJAwICzq
 8AfY/8bYMOM2BLGD0+JG5xZmaF4C2o2BL+Y+RwFsFMHgW7TrVQTIwjhCZtV3N4RppO9H
 OWCpFwUnoxnm90tb0ANwx6woUoVdAERfns6wyvTamiKhnFJ7qexFLg4rPOUwAW+Lkoob
 d26V5GJAyXCeoxafkdjly2w9x8Ke5iNF3Iquf94D3gn1qF+dOzu8B6LtMIMhSA2KcyZo
 y/Ng==
X-Gm-Message-State: AOJu0YwubeynEr55DQh9O6LKA76g75xdQXYNALE1YP97Dg1fVVDweyPR
 QNlXw0mycXWDd/91cPvurVSJ6kOdzyRkw9ZFcrDOatexiuBgfjgH7t+AbCY8nSOeef0cGZxWBV2
 tRICL
X-Gm-Gg: AY/fxX6QJYluPNzx4w/P4yN0ZIbEZpngz5hu/oWiFuugLpYkixJRWj9TEa4aEfb6lyz
 VuYPuWWB6i3BmvVsDSbHFQdoRkTLzdWzqcP+Tgp/GWGzCAFC3inWGLlsMzxaq//hESQQ+jQZf7l
 GLzcdO/1t6tiG7r0uEbzkWwoL2FZ78a4XamD9M8M4mPULp/edtwacF+UfM2x1NDQPGhWCaRkt7e
 9G0HXuuZ0V/edQjON6oPqhTozGN4T3sqtFI4rTEQOR3Hd5+mmzzOg/6vNFLnnYFs9vQP+2grVsr
 /Fm1GyZPsBZhzh5mrb+OwZqW3yRbRiynOPljyuoGd2QxsowR8Yl3LLWdJ8n5g5tiDNy1uVY/OUt
 o1eyPhkTFFwLzd1m9i92ecHNM+gElytTRJKKVJjL7q1bVgpuc5hNWAg6Jj+kH1wlMJzfmxMlK69
 HTZgIa6uVB5lzC1Q==
X-Received: by 2002:a05:7300:50a:b0:2b0:52ac:92fe with SMTP id
 5a478bee46e88-2b6b410053emr3629915eec.21.1768589923328; 
 Fri, 16 Jan 2026 10:58:43 -0800 (PST)
Received: from gromero0.. ([191.8.214.17]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6c2de1f29sm1524126eec.15.2026.01.16.10.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:58:43 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v4 0/4] system/physmem: Enhance the Address Space API
Date: Fri, 16 Jan 2026 15:58:10 -0300
Message-Id: <20260116185814.108560-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x1336.google.com
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

The proposal in v2 was to allocate all defined address spaces
(CPUAddressSpace structs) statically, modifying the Address Space (AS)
API by renaming cpu_address_space_init() to cpu_address_space_add() and
by introducing a new cpu_address_space_init() meant to be used to set
the total number of address spaces in a CPU (instead of setting the
cpu->num_ases invariant directly, as we currently do).

However, Phil said that what he actually had in mind was to set
cpu->num_ases automatically in the CPUClass, hence without the need to
set cpu->num_ases using any AS API function, burying the details of
initializing cpu->num_ases within the CPUClass. This way, the
initialization of the ASes is reduced to the simple and unique use of
cpu_address_space_init().

v3 is essentially based on what Phil proposed in the v2 review, but I
removed the re-setting of cs->num_ases to 1 in x86_cpu_realizefn(),
avoiding changes to num_ases beyond the CPUClass instantiation.

First, because it will become inconsistent as new ASes are added.
Second, it risks causing confusion about the new AS API semantics, which
require using cpu_address_space_init on demand, as ASes are required by
the target, without modifying num_ases elsewhere in the code beyond
CPUClass instantiation.

This version, v4, a) addresses Richard's comments on using CPUClass
'max_as' field instead of CPUState (CPUClass instance) 'num_ases' field
and use enum _MAX definitions, removing the _COUNT definitions; and b)
removes math for setting cs->num_ases in arm_cpu_realizefn(), which
I forgot to remove in v3 and is now moot with the changes.

CI results:
https://gitlab.com/gusbromero/qemu/-/pipelines/2265804059

v1:
https://mail.gnu.org/archive/html/qemu-devel/2025-11/msg04406.html

v2:
https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg02298.html

v3:
https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg02917.html


Cheers,
Gustavo


Gustavo Romero (3):
  target/arm: Initialize AS 0 first
  target/i386: Add a _MAX sentinel to X86ASIdx enum
  target/arm: Add a _MAX sentinel to ARMASIdx enum

Philippe Mathieu-Daudé (1):
  cpus: Allocate maximum number of ASes supported by the arch

 hw/core/cpu-common.c             |  1 -
 hw/core/cpu-system.c             |  2 +-
 include/exec/cpu-common.h        |  4 ----
 include/hw/core/cpu.h            |  7 +++++--
 system/cpus.c                    |  1 -
 system/physmem.c                 |  8 ++++----
 target/arm/cpu.c                 | 13 ++-----------
 target/arm/cpu.h                 |  1 +
 target/i386/cpu.c                |  1 +
 target/i386/cpu.h                |  1 +
 target/i386/kvm/kvm-cpu.c        |  1 -
 target/i386/tcg/system/tcg-cpu.c |  1 -
 12 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.34.1


