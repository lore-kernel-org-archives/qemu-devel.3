Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5755ECCF9EE
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiYp-0004gQ-DC; Tue, 28 Oct 2025 08:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYn-0004gH-J0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYk-0001zB-60
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so3653142f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653534; x=1762258334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oO6cZxSE253WPrBSrlyXKEcK5u6TWYmszNG4NH9uIts=;
 b=RU7Kez4CG+zw2jub4Vr7l3ms2Fo954rt8NO6ngkb9XNtDDBGBDXKwcc3xBeHgTJmm5
 1fuf1a++erXLVUfqz1vHLsMO7Uk1vzz4xeGulqRXKxycvpbjQLy8vBOVHmshiqU/2cjo
 HmdEetYsUmpTVhqUXgTJab4ZG7vrD0TzjAhhatmO50VCAC1O+hg8eYC/2+kOQWZgKhbb
 3XFZ2HGP3Od+d/q552YaUqHIDcygXVCL6jLukO6/tziwv/nuCaDF6yAlb6l0SasdBd6o
 2PwfGkwcObb3lk8RIjDYkDG/jtHqWLdsVZ4HWtnwWEWDfbUgM2tsvE98DQgUudwCI9Jd
 IdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653534; x=1762258334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oO6cZxSE253WPrBSrlyXKEcK5u6TWYmszNG4NH9uIts=;
 b=rzDyb/TKKNaRlaz1JMUS0lIWW0FnaIOGzm7i9Us7H2GhftrKh1kkhYEDv5LrJKD/2F
 1y4bsWOObPEe4+QfIpYdYmd88/H1H1okIOZ3KjkCL5nK31HG7HZdXDQC7zL7hJyQ6tV9
 fUa+jojDSPJg3F1/HEL6qSzIyjebdExAtqvObzPdqbAqtzxokxPUkrAkgQ5AHou2Wk44
 zAA/wdy3eimWzMOa2AOtgp5D/W3WermYmGMavIYjMNDXLGBbMYqJPXrUkyBOkPOvz2YT
 +FohmR/NSePlPnDhs5fAisr45zBy0uUGZUTdW/b/BLanwPchCvb2Em1IN64WjTFeOFXB
 0y8g==
X-Gm-Message-State: AOJu0YydK4ayMk+hElbdKxQWNkjO7AAmCnR2IfbUyntdcHlvoq1INYyi
 Zf8kGukBpmpXZFj4OGYFCNAmvO8BMRTsGL2WZ8JvPEzQ8HC9r/WTl33c9IqZnp9osQY+XXL3ILa
 EU7fm2oo=
X-Gm-Gg: ASbGnctDutWs2CMtRY+J4I/qKPNT4jDy98aW5eTTap9Bf9gH6NB3Gr5Q1BhXLfZKaTe
 PydHhqZ7dcc04ysqi44fHwI3aLqUv+gYdR0Qk1KsclEX7Ph2XQ8NxYzIQ01Lu+dodMocHDH/i6w
 Odd1tDzjstLBDgmQAUDth+yvxYzKBq4N/PB5O+2UAIn2tnxLDjqnZtRFrE8SU8ulntVUUFq/LnZ
 oSsEiISTSx1orbC5lqP3odIq6NLH6toC8s2DWEoBOMwC+im8s1nlpHKiCwp8uz48cqbdK3lXkTV
 /6tWJABOVz42bczGHQ7lp8ZwOh4G/KpZdTRgyT0FPSobE6S6C+vMotuutiAEsZjGEWDWlacAR32
 KeWBoKAdNJX9+65EJuwXn0pRnVmMxU1W76bCb3JHfMCWcsobBcE/7agxb1KlcjbdbyT7tM+m9wl
 mm9Q0k5C2eLttEmWII
X-Google-Smtp-Source: AGHT+IGOSR7SQEavUtbZVB5F27AaM4NuCeiI3mV2ZNxceoW5bTxHQbJNorb4TfLQyJgg9m+Y84a5IQ==
X-Received: by 2002:a05:6000:220b:b0:3ff:d5c5:6b01 with SMTP id
 ffacd0b85a97d-429a7e59e35mr2723217f8f.19.1761653533605; 
 Tue, 28 Oct 2025 05:12:13 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm19994094f8f.25.2025.10.28.05.12.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:12:13 -0700 (PDT)
Message-ID: <17fa30ff-5837-4baf-8a1b-ce59c180b17c@linaro.org>
Date: Tue, 28 Oct 2025 13:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] Misc HW patches for 2025-10-28
To: qemu-devel@nongnu.org
References: <20251028074901.22062-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/28/25 08:48, Philippe Mathieu-Daudé wrote:
> The following changes since commit 36076d24f04ea9dc3357c0fbe7bb14917375819c:
> 
>    Merge tag 'next-pr-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2025-10-25 10:42:55 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251028
> 
> for you to fetch changes up to 7dbe2d7df094aa8af2d8fcdf08fccce70b1ca5bc:
> 
>    hw/riscv: Widen OpenSBI dynamic info struct (2025-10-28 08:19:18 +0100)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> Various fixes and cleanups:
> - Set FPCR exception flag bits for HPPA non-trapped exceptions
> - ConvertVirtIONet::vlans from pointer to array
>    and remove VMSTATE_BUFFER_POINTER_UNSAFE()
> - Remove redundant QOM typedef when OBJECT_DECLARE_SIMPLE_TYPE() is used
> - Have various QDev / SysBus helpers take a const device argument
> - Improve errors when loaders parse images
> - RemoveIntelIOMMUState::dma_translation leftover
> - Remove most target_[u]long uses in hw/riscv/
> - Fix DS1225Y MemoryRegion owner
> - Simplification refactors on Raven PCI Host Bridge
> ----------------------------------------------------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

