Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA13EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu7W-0005oJ-A2; Tue, 10 Feb 2026 15:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7T-0005nF-Ow
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:13:59 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7S-0007nM-0D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:13:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a871c8b171so7062155ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754436; x=1771359236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ckeVe3tsWcfwvi6KFoBnQlvySs8M5FAplWQQ803ci0M=;
 b=TwShTteJE8Gl80HEuEMXl9ymT/+MXAhlMH2W+H28D1cN6Jzv4zMRW0MeKn162IGagH
 Hv3LnTRLeUNyxKcmGSrgNF98CLriXeahovxu0QuijqsYPufq8v6bvsD5rwFfA5mlYKbf
 E5V12bxN+wtFQYCNHkfP8ScgqdOS10m4FuPVkpVNnNm6xiJb6nOtJxbVZZAA1pTWzf9h
 dVeuT1tivk+TQlYi/AJuUgW3cw96tjkHE0bVZuqxUvBUcS2637vqrqli7wARVV5rqNiU
 M6SnLIugaSjS7DGbEjRYigi0Zgi2Tw3czkEQ0n8/kExJaE1/40fki4qQpvGXn1ukUKqD
 OpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754436; x=1771359236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckeVe3tsWcfwvi6KFoBnQlvySs8M5FAplWQQ803ci0M=;
 b=JLWqUWfqWB/pQ+Q/W2Uo4oTFgrebjI3t6XInl1pbotQLNRKzfADWU8DTLlOSkx7/Bg
 7aDzko7EIKBMgUOFOvOEl+YEqXtkNlqQr45+RLnMzX4svBMMSvmQJaatLTnWiyqB9k8J
 3X1fbzf/K1viiFW6sl5tGa7d3SzYjbZHsYF2aL1h6wteU9tZHRjk96TZeRfi3sTwpZGU
 a64MLiOcdHh73a5HuDt6dEIBt/WMlSC+PtOKBkw7VjtyEoEDA/H8xoaO2IOaaeVlmDOE
 0c7wLOAxlfGYoMbu6lNOlTYgKEx4kiq9WMLhseJNF4qpMkA/ApoYtPJ2UznwSD/k/bAl
 kayg==
X-Gm-Message-State: AOJu0Yxm60OhaI4vF8MTzljQGIUiaFKjHu1LvtUG9eE/u2iSE+YD1IZI
 jjcPdl8zO8ZNyPgMf6OD5+f7Rk5KoQjXP9eRsjdzTpVN5BecXbwocPDNYtYcCk9m2YtUXt9xMTD
 aJGch
X-Gm-Gg: AZuq6aKQqrCA/NbbG78HtvaO2ev0rjS1MVepFLG+SucKci9cOE1Y09uzIDzI/iuX5af
 7LAFsFu5vST7JPUDos68HkgH51nFS7sMxD43+pSMPVJxs0G+UwIgAtt4Hhz+wJPrE23OgAsWQ/R
 ZLbOsJpxA0CJ1SSLJlUu9ladLTDJh0kba4TzYFEccRrKmgxLhSKIpwA/FLMBYEFY/9SukX6oAMt
 ZnRJVONl95cEo0ycuNWNBFN5rcmsZhg8j7sHIozQ2AqECGsIT2xNpLSrdp66dJNywzaSfMcY0mp
 CP1XjiZMqUAUrom9pAumwPVfnF6LotDCYdIyYkGPezumpAMKvhbEaEdaDRtE1sjBQDMVMcfnRHo
 38clmnVRbF+KHT7KKWtJCaia0strdFbyLgmg0HESXkFoWMhTOuPcTH8h/2Ps2C7kbWPdM7q5Xnc
 zJgLzCSneWPOVfkTMpDt7/cmF8RLEAhDWmbhJeJnF7o76boD8sL8UcCgzMtBBJ/kmp46FykVUhO
 lvH
X-Received: by 2002:a17:902:f687:b0:2a7:d5c0:c659 with SMTP id
 d9443c01a7336-2a95160bfa3mr168655805ad.5.1770754435855; 
 Tue, 10 Feb 2026 12:13:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e3e8csm13930031a12.21.2026.02.10.12.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:13:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
Subject: [PATCH 0/4] contrib/plugins/uftrace: add riscv64 support
Date: Tue, 10 Feb 2026 12:13:40 -0800
Message-ID: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

This series adds support for riscv64 system tracing.
Compared to aarch64 and x86_64, stack layout has different offsets for accessing
frame pointers chain.

To build and trace a riscv64 system (requires only podman and qemu-user-static):
$ git clone https://github.com/pbo-linaro/qemu-linux-stack -b riscv64
$ git checkout qemu-linux-stack
$ ./build.sh
$ env INIT=true ./trace.sh /path/to/qemu-system-riscv64
$ uftrace replay

Result perfetto trace can be downloaded:
https://drive.google.com/file/d/18AVzg5ftwJZyJMMbm_KcB4FMVSas6jVz
And load it on:
https://ui.perfetto.dev/

Pierrick Bouvier (4):
  contrib/plugins/uftrace: fix infinite stack unwind detection
  contrib/plugins/uftrace: add ops for walking frame pointers chain
  docs/about/emulation/uftrace: add info about automatic tracing
  contrib/plugins/uftrace: add riscv64 support

 docs/about/emulation.rst  |  23 +++++--
 contrib/plugins/uftrace.c | 128 +++++++++++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 13 deletions(-)

-- 
2.47.3


