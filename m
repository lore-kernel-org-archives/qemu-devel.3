Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D3CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 05:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXut7-00036u-Bn; Fri, 12 Jun 2026 01:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXut5-00036h-9r
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:57:03 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXut2-00005F-03
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781243805;
 bh=VFezI15tMR3GS1GkURiId4hExSOJTMFhQRwNNEbzu3Y=;
 h=From:To:Cc:Subject:Date;
 b=xGU0DdDPM2GvN2+0Fez9dooUuhLN7CJKlyONN3a/J/JGaMkz+hDuaZVrG8zKydvWy
 N+GJCBMNQ1Op5UGsyRl+SRmXqrtbPNNP0udgV0ZPs3DaiAZgk3EU83jNokj/F3K1N1
 H2R8HjhvjAmIGQeEqTPhPG0KySLhEIp8bIOWQmqBX6S60Lg4HO/y4oV6piMf7S8jhv
 qfTJtuAzYootpjIqO8M8n5+9ySd0pAHojIiyQoYaremRq2cVxAfd3Gbhk6vnn2hN9n
 0hu0gYIjnjcTg6poP0BtGpD7Q4qK3YRiBLn9eYB+yW+IpvihKS4eFSAPsZ9lZTi2iu
 HNravGMReqeXA==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 46C9F2FF557;
 Fri, 12 Jun 2026 05:56:45 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 025CB37C941;
 Fri, 12 Jun 2026 13:56:43 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH 0/1] plugins: fix syscall filter return value type
Date: Fri, 12 Jun 2026 13:56:41 +0800
Message-Id: <20260612055642.589337-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

The syscall filter plugin interface was introduced by me earlier. Its
sysret value is declared as uint64_t, but it is semantically signed --
negative values encode errno codes -- so it should be int64_t. This
also makes it consistent with the ret parameter of
qemu_plugin_vcpu_syscall_ret(), which is already int64_t.

I did not bump QEMU_PLUGIN_VERSION: this is only a signedness fix, and
a version bump is better left for the next significant plugin API
update.

Thanks for your review.

Ziyang Zhang (1):
  plugins: use int64_t for the syscall filter return value

 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1


