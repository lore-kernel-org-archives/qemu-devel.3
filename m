Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB2E1093190
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VsC-0006xu-Pb; Fri, 20 Mar 2026 05:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsA-0006wW-Ip
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Vs7-0003dq-SX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b4915161fso374445f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997821; x=1774602621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1TY1VY1jtprmmfCeBS0KATuZXwDcROoiZliOErG0j+s=;
 b=DGrEqDZjfYLotNUOBg2uIUBM5cxLKBRUXrwaYaP4uJFpghRWjYE/ja3XyR18pzEX+j
 m00xjdQv0JuljbqSuhqqQN0/WqSjJ0tGLQxi3Kzo9Gcn1SxDQKubpUvN2SxqE8sMipjs
 X+sMrAuC7+u5HLfoeeK9OG819SSOydiuJ0hoKyR9LARJ2CylbmOsbYKYq9IjVR3QkTkb
 i91ooVr6C0TvJN+Xgj6/4sJ+jzqdeNTX4lwMYFNkkkF+TDVQWJO7nF+arhzykbraUFiQ
 rOyHxUL2HhRMq3W0u5HsFwk+3cpMFd9KVO1COYOS7qo0DxVrC6UmPH4RTBE4+H7lKs2h
 G7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997821; x=1774602621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TY1VY1jtprmmfCeBS0KATuZXwDcROoiZliOErG0j+s=;
 b=qBjThFvt2KmKDE4+Kf4CuozvwKOy+DANpALkzGWB+26IlIP6ENafUefV+eYywSgoBj
 zP/HmAIDMoYFfbGsHmxc9Z7KWoCLQWD13L9VEw7xjNiMUfGy605Qf+amUpbBN0RGfKga
 rbQOxaz3JyhN6ZRHai23xPBvSyEAHKlPfLWunM+nIxkru/YNKxGhpspot4nk83f22qSm
 zA+CIvZAUBIdwy5tJoWhHi6+Da/8MTK8CdPMUfN8oXEC3ZytRWvywvoZ14ZTCWSSD0J3
 ZLSA3VDOVr7II1RtVQkzdPV5vxkSmDbx6qGq+9++A1lqiWhKadrfr0s6ie06Khs7ZAOZ
 QSrQ==
X-Gm-Message-State: AOJu0YyLJbGHesXNzFizwX12N/623ZOQ8XJvVFUXAdZV2jAV3Z11VyyD
 OuTZyBqMSzRWsil8XF5VUkhKdY5AHxnei5L2oaIBOltb39pxma5cnIZyTLe6zztOCKPnCbpXpI9
 nPU2VaJE=
X-Gm-Gg: ATEYQzxXrU47F0Pae6uOdaZHE9OjkmL35c5qHFfTyA/L34cf8OBb6WJIgPj3Vf6+kc3
 ZkbyoaJhtJUGzzODw954xQQItL+7OAHI+rdljOqGTRMgJOjAsRy0usEx2QYe8A149bMjJJ5zLra
 hLaOWFGog7rgKbvoXaWu+x0vIo5OitnrUTPZL9J9By2cSG88LXkfs6Yew6KARZjxRLn18WhlmdK
 EtkDtf/+kboJeffUBFx7QhVDyoEJE4WDvzOcTLlV4S8MRiputxgJ2xlqWMknGlNtVVSsAUfgGOv
 xmnHISEbHlfaWDezQWTscWtNntxooXQwHmDUSFrodXsZ1Z3ZGpCO29kDlnfXj7Dz+PF1vOfYWEp
 mRWK8Z5KxeUTWAQIzrQ9BgVfmOpLKKJDKmJWIMGNRIy4SijsuN2VqDoLWNWTaV0rxKJpQOabZuF
 mzhafd6uJAqRf9gpAIUs5BMmT+TUlOAJlmkrqzFjVaQ5OXR/B1Lz5f+0jbg8U/m7LfuYD8UDlb
X-Received: by 2002:a05:6000:26cc:b0:43b:4489:d450 with SMTP id
 ffacd0b85a97d-43b6426410fmr4007303f8f.30.1773997821163; 
 Fri, 20 Mar 2026 02:10:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b647120a1sm4967301f8f.30.2026.03.20.02.10.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v6 0/6] monitor/hmp: Reduce target-specific
 definitions
Date: Fri, 20 Mar 2026 10:10:12 +0100
Message-ID: <20260320091019.59902-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

v6: Keep signed (Pierrick)
v5: Fixed mis-rebase (Zoltan)
v4: Remove duplicated hmp_info_via() declaration
v3: Rename MD_I32 -> MD_U32 (Dave)
v2: Change get_value() prototype signature, use ldn_he_p()

Move most of target-agnostic definitions from
"monitor/hmp-target.h" to "monitor/hmp.h" to
reduce files target-poisoning.

Philippe Mathieu-Daudé (6):
  target/sparc/monitor: Dump all registers as 32-bit
  monitor: Remove MonitorDef::type field and MD_TLONG / MD_I32
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Remove last target_long use in get_monitor_def()
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header

 MAINTAINERS                   |  2 +-
 include/monitor/hmp-target.h  | 50 -----------------------------------
 include/monitor/hmp.h         | 12 +++++++++
 monitor/monitor-internal.h    |  1 -
 hw/i386/sgx-stub.c            |  1 -
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 monitor/hmp-target.c          | 48 ---------------------------------
 monitor/hmp.c                 | 41 +++++++++++++++++++++++++++-
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  1 -
 target/i386/monitor.c         |  7 +++--
 target/i386/sev-system-stub.c |  1 -
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         | 25 +++++++++---------
 target/ppc/monitor.c          |  2 --
 target/riscv/monitor.c        |  1 -
 target/sh4/monitor.c          |  1 -
 target/sparc/monitor.c        |  1 -
 target/xtensa/monitor.c       |  1 -
 20 files changed, 69 insertions(+), 131 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

-- 
2.53.0


