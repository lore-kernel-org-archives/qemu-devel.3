Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62147C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ecq-00032E-Pr; Thu, 16 May 2024 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7ecY-0002pn-Is
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:10:23 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s7ecX-00070G-0C
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:10:22 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b4a7671abaso370496a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715879418; x=1716484218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U5CRlFT5PQ5CFopr2tKKPVYCkCLHgBdgLGHNDjlYi54=;
 b=PZ2a3UKaSTlmD9E0t8jxwuYXURdlAYRqNqn3ka7AOP4FZjCyNxD1n3cSfq6vRoqinw
 C3xMl5igYBRyNL3oRD1cRq0ATUeccYwlj984s9kOD4JGBzrDFZH7ViitukNbvUyBn4/R
 4NAPN5GRAK8nGls/c44FsezyoNaE1yWzuYzGrLEZzJb8e4h2M9RxWZrLKKeugjCUalge
 MgRSDbrd/pBLj96pPINPWoCU0pRT6i16qRYl2zgc3dbDAhTKekAJzxmlW6LfA+gpt37w
 cWOM0QQLfG5DMwO8TyAOmr9ljMdYW+LbTErr+HB+D0DErSvBFi83hvWQok+tTjuaZmMQ
 fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715879418; x=1716484218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5CRlFT5PQ5CFopr2tKKPVYCkCLHgBdgLGHNDjlYi54=;
 b=OC0glussk0qZrRGFtuPiiD3xSxlgJq8qpyDOS/WzcWo1ls3Jrq/9SUu1BueaSIP2yH
 ylqel5zQ6dhKfadK/wfcvXuuRQm8iQdoVrMUBjvnped+YeR7rl97UH4mgfKLwa/fWPgG
 PTJAGQpYvVssM2pd70y9gOBatdYw9xzPSr7ClTN9A9GWlPZK7mBZKliMYVBwclRuWCFV
 q24nOypZ+V//jcnWuyyCArv8I7ABmCtpqlSqmebHOC6iEK9sWVSaOgAhhsYaKq9EA7SL
 Y0JAUkaBijqNZkR+wkLWC/ZjwbCU9GPxOjkPWEH0GmWvkyxGZNMjscvNxO+bYzrH/PVM
 ac9A==
X-Gm-Message-State: AOJu0Yz217cOrpxNjc84lHAfKa/VUiHmQs+q+1P3YpxgAeEohVkG/de0
 GAJYm4vbM9/sZQk4Rbhjq7YU0c6k0LNpjNQKfEmpzfEkKQBY+1TypnGpxCBm69zWV4mXLC4qk/p
 +
X-Google-Smtp-Source: AGHT+IEEEaM2Vh4fWktiaERhFXtH0iXl8cXtp2kUHNspdn0p5Obqe0mFxBm8HtJXQDcR7bJ7zscHFg==
X-Received: by 2002:a17:90b:4a51:b0:2b6:226a:ddac with SMTP id
 98e67ed59e1d1-2b6cc7803c7mr16850032a91.22.1715879418450; 
 Thu, 16 May 2024 10:10:18 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6aadsm15769257a91.50.2024.05.16.10.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:10:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 akihiko.odaki@daynix.com, alex.bennee@linaro.org, mjt@tls.msk.ru,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/1] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
Date: Thu, 16 May 2024 14:10:09 -0300
Message-ID: <20240516171010.639591-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

Hi,

Commit 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
changed 'reg_width' for vector regs, a change that I believe to be
unintended, and we're unable to print vector regs in GDB ATM.

The following is a gdb output of a simple program running with
qemu-riscv64 when trying to print the value of 'v1' after a 'vle'
insns:

(gdb) p $v1
$1 = {q = 0x0, l = 0x0, w = 0x0, s = {57920}, b = {64, 226}}
(gdb) 

After this patch:

(gdb) p $v1
$1 = {q = {9781192033638379298842687819604544}, l = {530239482618432, 530239482618432}, w = {123456, 123456, 
    123456, 123456}, s = {57920, 1, 57920, 1, 57920, 1, 57920, 1}, b = {64, 226, 1, 0, 64, 226, 1, 0, 64, 226, 1, 
    0, 64, 226, 1, 0}}
(gdb) 


Michael, this is a good pick for qemu-stable.

Daniel Henrique Barboza (1):
  riscv, gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()

 target/riscv/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.44.0


