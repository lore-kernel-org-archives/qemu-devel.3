Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB748CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZZz-0000Bd-H0; Wed, 06 May 2026 06:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZZy-0000BG-6j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:34:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZZw-0001el-I1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:34:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso7369795e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778063646; x=1778668446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ipcKqYVGkANk/43C6r4btbr/X1oHjjbfpgsF/sty6pM=;
 b=g2+YJV5yBxxQx3PnpsLprCXvNDzAJyJFzjVHmlKVuZAWi4rM1LqBoUzQKJ/6F3DU+l
 QRCSlANeRNeSH+CEZ/EtsAGosZL8dyVKXPPR6mJPav7+pbWbbY2OY/skNkOBp1+vEdoV
 92UvbZYVPOaxtUkUiJW2YCsNjPqqk0GuCngpmi4UTb3ytesRRre1N2nUtsUOGrMUa1Mp
 eoWP7Mwoz2LSq2SVtfd+VQR9FfStjx+9Ph3HCoSwkyUUEa6miE8mWYBBho1XNERkTvdx
 RoQQRS7CP2kej1wZ6o9tD5yEcGbjmrjC9XM0lgV8o9OrirqVLB7kEFfUbL5zfXrwYAVr
 44lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778063646; x=1778668446;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipcKqYVGkANk/43C6r4btbr/X1oHjjbfpgsF/sty6pM=;
 b=ajzWKEvycLbmqm6DuTueELn9eNRoVl43YoOWRfIZDA+fxXotBXQ7Tn2eBB7Y0Frkhh
 VjEumfQrbl+1BvUyEyUwle43gsSdzxgQ4xLK/JAK4s6g/aWnkGGIVEl9KkyN0MTpE3Vy
 5XFERn5Furw5iRu0DeulxGmilVjmRvd0IBob5XRSfFrrYKLv5q1PquZusENBvUDS15zb
 6pgv3djFF/lI0zX7aRa3+BDffcEs7DYtaHVHfnBtFtJUKB/ypNMQLwg+VEAO/dGo/333
 oM7hifxiWV+VcxAKS28HG3yMArfNW/U7da5EySv01O/Wv3U2i0NFrV5SA7og/RqIrO2P
 Ozpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fRvqyp6nypFF2putv8IKrRdg5snoVomb6Fi2ZZ4fATB8FwYfzfLq/GLXKvXQjIGP9lt/TfRmrGHF9@nongnu.org
X-Gm-Message-State: AOJu0YyWo2eXvXUeFCiOxZqp0WZsm4zKyMbUSxOoi0EXU1wkyKYJj39n
 mUiE97F8SWaRb2EUVeGzEr92dWSgGIdU+sBguUXrv8LS4tqx5wPN0KvSH5pJCJUQqu2vakptsJq
 2YnTxd8s=
X-Gm-Gg: AeBDieskiD/xeroJrJtbgrWzwBY5LbzWT7BF+bGr4iqG4aIVJGb619UlBw/7fneNhaL
 9mqhnBJKWl7eJFO9l6Gr/M7FfvISOM+64TOuRrPNfdsINaGgIIbxa0Ff06bzrxgDrd0EXu+9jmS
 2Owx8KLteEYE2rb6bWtm6vl4iJFfdMUbXMYueH9H2r4yFVy4vNX/1fkTQdKMToRpycNTm2CyceC
 CuKbyXHv7QpPui6SohGwNFDHIIPsaa5wL/ITaZqrVlW8cH+ymeeIa1c36nHAxNacg2RNDa80AKc
 qblCvFINXc1JF1NC5WH0EWMfcrWhsYGk+MMiIJTldiA9nsiBbU/vBaw+Up4gZcPmjRz5WPEW9UY
 ZVRY26VBC3I24ZYca646z6VkrTi9DQ5RbsDgdVgYfbdwOExzCDlJbzPUHlmX2IB1HWc0BjtPu9M
 dQLXs67hcbkJyc/vyrdVlPh/IBLE0l1exJ9hy15HCAauj/qXpXe4jAXCSmMWqv3AxtKkcwBSO59
 Gpn
X-Received: by 2002:a05:600c:c11c:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48e5226c4f0mr29753855e9.2.1778063646355; 
 Wed, 06 May 2026 03:34:06 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm35275025e9.11.2026.05.06.03.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 03:34:05 -0700 (PDT)
Message-ID: <f1d68d0f-05b8-4f51-a0d2-f8f029c18d81@linaro.org>
Date: Wed, 6 May 2026 12:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/32] monitor: Remove need of per-target handlers
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20260427080738.77138-1-philmd@linaro.org>
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

> Philippe Mathieu-Daudé (32):
>    monitor/hmp: : Include missing 'exec/target_long.h' header
>    target/sparc/monitor: Dump all registers as 32-bit
>    monitor: Remove MonitorDef::type field and MD_TLONG / MD_I32
>    monitor: Extract completion declarations to 'monitor/hmp-completion.h'
>    stubs: Rename monitor* -> qmp* files
>    monitor/meson: Use SPICE with migration HMP commands
>    monitor: Restrict monitor_set_cpu() method scope
>    monitor: Make 'info via' a generic command
>    monitor: Make Xen emulation commands generic ones
>    system: Expose 'arch_init.h' as 'qemu/base-arch-defs.h'
>    monitor: Introduce HMPCommand::arch_bitmask field
>    hw/s390x: Reduce 'monitor/monitor.h' inclusions
>    monitor: Do not check TARGET_S390X to build s390x commands
>    monitor: Do not check TARGET_I386 to build target/i386/ commands
>    monitor: Do not check TARGET_I386 to build 'info sgx' command
>    monitor: Do not check TARGET_I386 to build 'info sev' command
>    monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
>    monitor: Do not check multiple TARGET_* to build 'info tlb' command
>    cpus: Introduce SysemuCPUOps::monitor_get_register() hook
>    target/riscv: Register target_get_monitor_def in SysemuCPUOps
>    monitor: Remove target_get_monitor_def()
>    monitor: Have MonitorDef::get_value() always return int64_t type
>    monitor: Reduce target-specific methods further
>    monitor: Remove 'monitor/hmp-target.h' header
>    monitor: Forward-declare the MonitorDef type
>    cpus: Introduce SysemuCPUOps::monitor_defs hook
>    target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
>    target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
>    target/sparc: Replace target_monitor_defs ->
>      SysemuCPUOps::monitor_defs
>    monitor: Remove target_monitor_defs()
>    monitor: Merge hmp-target.c code within hmp-cmds.c
>    monitor: Remove hmp_info_pic() left-over declaration

Series queued, thanks.

