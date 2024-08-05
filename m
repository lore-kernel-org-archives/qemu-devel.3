Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D597DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawQq-0001iW-77; Mon, 05 Aug 2024 08:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sawQh-0001gi-JQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:03:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sawQd-0006tc-4H
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:03:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71080f4c006so1182347b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722859385; x=1723464185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pm0ToWhyLLk+9BvKX2Gsihv8o8nRCsOsUa85cU8/M/A=;
 b=pOt4ES6SDevW0jpUbh40ZDHkzK4B/76vvMCsXG8WGAXAgUwLoJhBFpwIWhsyxmB8py
 b8SfY1T3S06Dyi0MqDG0c9W0yEcxPJyRhC6qObl0ezicZs0Mgp4yTrGg6u9UxN20YBh6
 3bg3/NeE6RAEKMfceiCi+hpD60NY4lBmop/tbKEq6QCrsC4PgRzqH8WHN8jILC3E4UWN
 xJt0dO+tPEP+radhrYB9pmcofvJz/8/ghAPqbM7WbpfIkOAh/bkUu5xErzASw1cDl28/
 vQYstcDRSBKs5DVvkStjPJZlWTD9F9omAYd15yILIL4fcJOHdbuEDWefuEzRreaDxT9Y
 wi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722859385; x=1723464185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pm0ToWhyLLk+9BvKX2Gsihv8o8nRCsOsUa85cU8/M/A=;
 b=SDv7jZMvQb++gWBNoGrIV9uUfr6B73owzs+wFihHr82TUDxlp7IND2RzlVEXK6K+yl
 cJb9C6BWZZAx6k33MTPk77W6wRmWzhNF5e98lL8gtMyW3L3zQx3UaHKAmLpvfP37TPTQ
 LX2gptLcjLp7YrOu7AzGJhihc1VCbz1wLrbvPJMQPfgc9BTQJMbJRICahQhVxreOqGSK
 dMwXf0AM5GZe4x7vUUE9ZztDW1S4dJP4muMxw7aFpnugdqtoObn7gZOINlw9C0+te77I
 VkP9jIff2rfhj5uVRsQC9JGAdzxl536b/On3NKwqb2V18yowXr2rIrkBZr+7s5BiBOYp
 sEGw==
X-Gm-Message-State: AOJu0Yy7YAcAPPsbOwn6siLd7uf2EOKIwgepPfZv42l/vFmuST2KpTay
 qaq0E98CBU54y5adtSOQ1/tXusxP26vZ3h8zydqVioZOsxX/3bCg9rQgPvRP6aXV0O9vR5fOFzn
 f
X-Google-Smtp-Source: AGHT+IFKxwMgeuvRugxbaFNbaJ1/F7c1Cphqa6TA/acLa0YDi8YkTIlozfHePiV3PviGm2x9265sOg==
X-Received: by 2002:a05:6a00:1744:b0:70d:2693:d208 with SMTP id
 d2e1a72fcca58-7106cfd19a6mr11255947b3a.15.1722859384872; 
 Mon, 05 Aug 2024 05:03:04 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.133.97.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdffd9sm5231041b3a.129.2024.08.05.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:03:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 0/1] roms/opensbi: update to v1.5.1
Date: Mon,  5 Aug 2024 09:02:58 -0300
Message-ID: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Hi,

OpenSBI v1.5.1, a bug fix release launched shortly after v1.5, contains
several bug fixes that we ended up missing in our refresh to v1.5 a
couple of weeks ago.

It's a purely bug fix update from what we already have in v1.5, so I
believe we're justified into doing this update during the bug fix
freeze.

Alistair, the patch was created with --no-binary as you suggested in the
last OpenSBI update I sent. Please fetch both binaries from:

https://gitlab.com/danielhb/qemu/-/commits/opensbi1.5.1


Daniel Henrique Barboza (1):
  roms/opensbi: Update to v1.5.1

 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268312 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 272504 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


