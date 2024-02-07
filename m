Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6730CC4829D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwL-0002sl-22; Wed, 07 Feb 2024 11:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwI-0002pf-M6
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwE-00067K-OK
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fe3141e1cso8096905e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323897; x=1707928697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XrdlyPxX7fzqYNhg32fjbzatjpy7oOVQl+tyM0KqaA=;
 b=snotOtLvwVpKbWPhm7wpatKLekwNvlVPtoYKSumMcrk+pBT4HZoElHixY+sDIio6sk
 QnG2BGi4uYqeGxNlYT+6hiC5qdI+iaVg3kIBkZID22k0/nI6nTSPLpari4EoTz4w04yy
 JLq9QxYNkt0sGli1lt5yDZxoO9ubF4aVzfQksEUXNtg5Zy8XkEPZFymzQ1ED3L9VfTOd
 mRgCBhT9D9vc8vqgLDpxC+6NQhV/Rs5lXFTMx6MUSGhN9qQiSRSGua9eE+Uggp8lhbbO
 yBGm0MyW7HLMZBEayr2MDgNz2hPyoAb5IEx7QBfKOwKWTcaDp//OJviUlzy3rM19T1tQ
 1ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323897; x=1707928697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XrdlyPxX7fzqYNhg32fjbzatjpy7oOVQl+tyM0KqaA=;
 b=YrKmQOHl0sTJn6oibELSsZyyI8rkwO/meeg+gw4aiIXGmIFS5wtnjPLAUpfXg+a1qb
 zoheXY2PObGpnDYU/aMNA8KnNlvKzq/VB5poBM8BkwdSV5/Q7ypWlD92JB4u6uLN4JYS
 JD2FQ/LxROfi16QmQobsnV8cwOnbc8PAPW8F0V3/3hugMNGgJTjOsD1VkvpHGM33vNI+
 Cb+3DvTTxSzj4hBXNfadoDytUw8MPq1/EEfsCSgL0F4vH/0Mn3MuOuDR/4gvCypmSE8N
 iHmD7ZX/95KqBGtwfSy4rnPFlvhLR7MUHsz5e/Z2pyyi3aAw3JV0I1IN/slTJXpIg0k4
 xrGA==
X-Gm-Message-State: AOJu0YyjfZazj3CanwOnFBobdD96TVRl/TPjPtWg58wlpdKLkfUKHEq9
 +ZSM9McTHUGcMuJLz0HaoRJTHz0qc3LEd5k8X9tg3Ef7aVDQtpjJWi3tcRxRyag=
X-Google-Smtp-Source: AGHT+IFQGxvwZitCIjiQ+EVKzNxoWSscx1eHsi9FZHJMvO9a1UWD6FjNkLw5mRtQ0nFveN87wXl8Rg==
X-Received: by 2002:a05:600c:a08:b0:40e:fb8f:debe with SMTP id
 z8-20020a05600c0a0800b0040efb8fdebemr4884119wmp.38.1707323897182; 
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZ5+acAuDUHb7TgMFnMsuwKsw3ljUwkqM34AK+NfpZnr7sWoJ37vTqNMlT1oRbxzAZOXObeySLPXnLBK7+4hzxOGV2pbYvkRU+sowfGEvZbY6aqidNUk8fVvW2KQGFs3kKfE6p/sY1/2l5mzRGqbhjAj21EMKolfmnAIPcYVXX8VZO/XbsJOc3cIQNYZFzw6rkI63QKcaSHkdLMvfLUIGi9pRbvmSCvYSsRlihLYfCv3WaWJ6jS3bQKc64tmMfPjmU+0bqWOIq+I3IHi7Rojsc5T4rHxJ74mWv6AuGsoJw+/rnonLz5Oo9zxHmv6NrT9t6LeC4mM2u4DoBYu/6aCCH5px7EbarTR8XqjuWUgn7rfGwCWyUuZajUNE+osp+wqcMkrgTDL2ABxQR548Tmnxxps3NRqiiC/xfL/a3yMzM636ZaI13s4luhrUDNuR6FY7gJXAvzl30CyFgmiiZK3I+LHmic0L6m6Bnn/EeaYhGr+MekZ3bjWr9Mq4Pyl/MdeO7nCThrQ4ApEctS2cTBexPqPptuap2rJZWGDBX7xGUpB48c/KrYFxrI4wWFOhXbJOvk2uQNtTjUtMNoRQas/h8l4HXXKEb30Vr4FlN5MCDmWBB2nIUMcvM2GqDtSGxp/40tV0lZ24FdgRHkOAoK5NvCOjiHotlyip61IC5ouFPjAt+OlmDaAVUDDh7aEET9fF0NhPw9SkSTu51am1736A44qTe7P8u/zqTDe+1NepefJO+stZyz/AvkJuM2QZm92D1oZ+VAfmIl8uXxxBZivTK2jqRJ5Opag2YoPl7tbEO+7kRSi+deJudFTkqWFlpeb2p1j9NVayvws=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c359600b0040ffe1ca25bsm2621888wmq.21.2024.02.07.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6709C5F890;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH v2 03/14] configure: run plugin TCG tests again
Date: Wed,  7 Feb 2024 16:38:01 +0000
Message-Id: <20240207163812.3231697-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
dropped the CONFIG_PLUGIN line from tests/tcg/config-host.mak, due to confusion
caused by the shadowing of $config_host_mak.  However, TCG tests were still
expecting it.  Oops.

Put it back, in the meanwhile the shadowing is gone so it's clear that it goes
in the tests/tcg configuration.

Cc:  <alex.bennee@linaro.org>
Fixes: 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240124115332.612162-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 3d8e24ae011..ff058d6c486 100755
--- a/configure
+++ b/configure
@@ -1644,6 +1644,9 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
 echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
+fi
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.39.2


