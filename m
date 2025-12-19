Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E224ED7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfF1-0008VU-Mu; Fri, 19 Dec 2025 13:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vWfEv-0008Us-WB
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:30:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vWfEu-000692-G1
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:30:09 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f2676bb21so25614975ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766169004; x=1766773804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKcqJVYe/vLiu38SEkAldo6XxLVKbWh0yS5xPcEV7Ms=;
 b=k4Ryt9zG6X417IreFt+ins+G2puaWbYEwoCqFr4/puQlU9Yu4G7ATvFljKLN67nycq
 zMArrOnJhlPJbxoVMXVHymPfOpPpxT3Re2kN7f9zo0cHxd6m9PVcy3ZkP5toAMd/XmkC
 XNgI1hL07CrEYx6fl91UUjnyAMIPc0XAhand7hpojAtWQGTQoH8RyuiqrszVe8PZTogw
 98ERCsc2+TKtx5mlb6IRfven7/iao6BsJmlkLmTbWqo6atv0iV+UhZTohHBrvtlARSwy
 8+2qchvWAq8WreuVgiG04G8kHQMuOlqxesa0DBPkBypOA0qjgmXv071+GnmO2eL/S04S
 dGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766169004; x=1766773804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKcqJVYe/vLiu38SEkAldo6XxLVKbWh0yS5xPcEV7Ms=;
 b=SpVI5LdDLZcsw911VrOcRgGlciKe3BOuljm/H3ddi2PXJ+kO+foAkKKueIbgEyBaAy
 MjDKKgr67/onNTfjbUuBJtEAcjfqlVAY4/6RPJVtbaapkUDDcFq2xIC1ob0ar1VBA8Rj
 oqOyoHwtgwhWuaepihjHN/buenmIXuhRz07YsuLMlJ0E4mp0C1oU8FnlwtVfbIrXqiKb
 z2M4dyhpP3dYP6fKXpe/MgTNKF01mXvHgOh5Z7SaWOks3LtFYRAn/tfkF1R5bYXSNuhJ
 v4rT44TJ9oMBM3EFSnOFXkxAeaQ41n9NeIGQTOpQqaI7hBv+z4nmPYGuz66sY+IF/HLL
 DpFA==
X-Gm-Message-State: AOJu0YxgDnHYeICqlAefRWYap6rdph2Ai74La4GiUwp4ROQVbuRDcSLu
 KFfRFpTfji5dkG/3AYTk3zNUtBnlEs/yp1CU46eKnpd7cquokTfIKs6rFoxWZreAPaY=
X-Gm-Gg: AY/fxX5+a/YwuF8VIjLh2vyQ5U+dYZGTNy1JZKXOTO1ts/JPg8gX5S0qzzS3zgf0fVY
 wrICkKoU+aT602Uu0kqoE5dE+aheJCBhxbG7Kwa3SlQjv1lY7uEIJzFmyTy3hgSkBYa00g7gLJQ
 SQeCuCxAU4EvLuKGcOFd8vhxkAwa2Qanc2e1kehnjLE7i4tkhs3t17fVv8WBKg2KUJx+cJmcf7T
 l1kKmaQViDRGMfDXd4durNvky1l4Lk3hY/iyTrMP/zxoLYr7qlZX5au2yzA5XhG45HD4cky/ImJ
 QPxZh/9FA1BUP+11QxwtBiH+u3+bJclM2rDQLdlxWU2bGhc2yu33DFCvrr/yCZGKiLTlcwFM7AG
 MQWT26fh/71ocTsDmJtbmkwLP/D4wW5mFPzMpB7nQlQYq5PB61F49H7hBy4VxeZWXxWSAwJD5e7
 o7ZOZCSC8iEs9cwD5WOqTVJeFMXdqDYHf9xvz98teaw3BVB+ZaLW4v3agmRxbNOHPiLA==
X-Google-Smtp-Source: AGHT+IGOYRspIQH1+x+Lk2xjaNKu5+2a1EzPzgAIMWqYuouOFED47EEGrEy8sF/MODiXOtkuxh4XpA==
X-Received: by 2002:a17:902:e806:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-2a2f242a26amr33994735ad.27.1766169003882; 
 Fri, 19 Dec 2025 10:30:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d86esm28729965ad.74.2025.12.19.10.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 10:30:03 -0800 (PST)
Message-ID: <ba85936f-7e35-415e-95a4-08f2106b311a@linaro.org>
Date: Fri, 19 Dec 2025 10:30:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-7-d24a4048d3aa@rev.ng>
 <72480685-f451-496a-a3c7-03d8d82a58fb@linaro.org>
 <owv5bslwggdhicnomhxrdpxaom76v6ux2gtla2ocwovqqgb3vc@kner23aosqmx>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <owv5bslwggdhicnomhxrdpxaom76v6ux2gtla2ocwovqqgb3vc@kner23aosqmx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/19/25 7:27 AM, Anton Johansson wrote:
> On 17/12/25, Pierrick Bouvier wrote:
>> On 12/16/25 3:51 PM, Anton Johansson wrote:
>>> TYPE_RISCV_CPU_BASE is used only to initialize the correct default
>>> machine for 3 machines. Replace it with a runtime check.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    include/hw/riscv/virt.h         | 11 +++++++++++
>>>    target/riscv/cpu.h              |  6 ------
>>>    hw/riscv/microblaze-v-generic.c |  3 ++-
>>>    hw/riscv/spike.c                |  3 ++-
>>>    hw/riscv/virt.c                 |  2 +-
>>>    5 files changed, 16 insertions(+), 9 deletions(-)
>> Using directly class->default_cpu_type instead of callback
>> class->get_default_cpu_type() works here compared to hw/arm/virt because
>> default cpu type does not depend on accelerator used, and we already will
>> know what would be the runtime target at this point.
> 
> Ah I see, appreciate the context!:)

It's subtle enough, and when I saw your patch, I forgot the initial 
reason why we needed the callback with arm virt. Reading again through 
it made me found the difference, so it was worth mentioning.

