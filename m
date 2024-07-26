Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD941C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 04:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXCdX-0006aA-8A; Fri, 26 Jul 2024 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdV-0006ZQ-5E
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:32:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdT-0004mN-KP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:32:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso2023215ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721968373; x=1722573173; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/b6pUbU9qFMBdN1kvnHQUdRlaiCYr0gxp6e7cIzlwbc=;
 b=VCrvv2XV24WVJ67XWRueZKbSJiAp1GUE7EPkOLX4czIklI0d8AHMukeuaTu8iZNlWE
 8gCEjHtP3Ze6sre/bltnkqx/RCx6UP1hgOSbEqs90JZdBae5t6gxr9sXbC/Is8G63sE0
 8TDyGXscqMxOzS+NQbwyi+1BQz7TO19M0142lxKBXgLPj+Ke3E2zgmZN/OnhBCBuTKqi
 09ZEfZwoiTtTiS//JWwwpOhMu2Faz1iTIKf5e91Jck8KBIbyhWruAs/+1pULWz8gDPKL
 hTBHFFaAVugb709XzoUbu/yMF0Xl6uXBsNnVlsu6WDAk64KDl8/wx4ZL47cxu8Ptfui4
 nNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721968373; x=1722573173;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/b6pUbU9qFMBdN1kvnHQUdRlaiCYr0gxp6e7cIzlwbc=;
 b=FqJnIgcDLknOBoxHLsG2GK5WjgbeuxLLqQ1e/S8fbp5R1OxQjBFX3JKgY2YCXcV9m+
 bAOhbonomJV+aVv0UoKIBes1yCkkvOB1rzo/9WKLepxFMpZrOjHjQDmpRH8XLwQRioG+
 ivtkDIBefM1LVRkcLUQZ0nUhB/OqcBvGhfh7hsqEt9zUxsSaL0lz9eajioGgd4unNjg4
 WcSeBtA6Gm9YlE7POuugxGUzTN++JML2HLDo8rearUuL19q1NcrynBPjgqEv6lQ/Hqzx
 TpeN1FCXQBkIP/Q+LD9qipTVFfwVrwfw62ojmTNPnUDF6gILg2qyGfWoOFLMBUT1jAuk
 NstQ==
X-Gm-Message-State: AOJu0Yx5JXyk0dYTmjwR6a3YsdlPv1lS9ws0s1D2fWa4Hv0V5u0iy93J
 gIYg8RbCkWKqFSCVZIANNJAwiGATO6y5vE2y29JsWp5S2C/BtiT3Nc34VWb9QZrqO/i+AnzEuJX
 CJqSd/mx4B4d9YtXT/pnvlt/ARlAvUcmO+8DzWvwNsOZggc6B63YuXhDv71R1L/mlleLbhZNo+Z
 fsImvqbJWGd8APmOUTVLFD+gY6CumPoBghMg==
X-Google-Smtp-Source: AGHT+IF8oSwh6PUwpCaDkrXLlGoZaYQvekgwagxtc6YD5H6CAmNRqWw4tOVKIkRB6myd7WJzMRLzVQ==
X-Received: by 2002:a17:903:2349:b0:1fb:8c35:6021 with SMTP id
 d9443c01a7336-1fed923f121mr45242825ad.4.1721968372762; 
 Thu, 25 Jul 2024 21:32:52 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f7b092sm22303015ad.246.2024.07.25.21.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 21:32:51 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/2] Let gen-vdso tool to use internal ELF header
Date: Fri, 26 Jul 2024 12:32:44 +0800
Message-Id: <20240726043246.10999-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x633.google.com
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

Let gen-vdso tool to use QEMU's internal ELF header. It could avoid
compatibility issue of glibc version in the environment. QEMU RISC-V
zicfiss/lp extension patchset will add "EM_RISCV" symbol to it. This
symbol is not supported in the legacy glibc. 

Jim Shu (2):
  include/elf.h: align ELF macro name with glibc
  linux-user: Add QEMU include path to vdso

 include/elf.h          | 2 +-
 linux-user/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.17.1


