Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A3EEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMis-0001NF-HE; Sun, 08 Mar 2026 18:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiq-0001DN-CB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMio-0003Ht-Pn
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso120488775e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009337; x=1773614137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MMwZN0BcCTHOYyyZ2QrOvcZPtu+WjOgZ4MJuxAH7NMI=;
 b=I03uV8+o5pE9h0Q1WCOa5HFSIba9R3KmOCh9/cG4idvpkAKtONp6OwUvDzwEWdofGn
 pEWOWJ9+XyMuEaEZ0l9D0eCX5ZQz1ZnPyIdWY/Ft21fEObat64kMUJ9hiyYmDlvOLXdF
 lwkPqDhJjFmsW3oUs1eX8BQCzHVXU6vvywHTl21PHv5fjsPwsxf/BALOeZzTnv4bKNun
 04TkCiPQtRWXqnz3a9B1im6k52h0ivhYcBQ5FnIGQJ0YyXcInRnpPIEU4L/6rGp+I4Z5
 3TlSBdW9ny2Y++ftKqY+dLsjbeHozjnm5Lvw+fQ90C4PwL3uydMnioX3nQVfX17lrJ3n
 MtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009337; x=1773614137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MMwZN0BcCTHOYyyZ2QrOvcZPtu+WjOgZ4MJuxAH7NMI=;
 b=Fd3Qo54YwLn/l6+b32f1vFgIcYTgS0f8wHolG67GQSUKCyCr0FGwLm8+h3SckQAbgc
 miB/Hy35o4p8ikSyvok3hs7tCHDcqEkyNgUKV0HSE/ejvHANXjU3RHwzGTw1R9nwPRSJ
 17x+XRH/2VJsaIGb5kktFtfILtr8nL7XhSJ/Ei3v7XqZ+D+C/Kf2nCJ3YEletPzLtIWq
 VV1PczsCqWv3efL5pBior7vmCTm6okBYa2ohId4GaMWAsEZSPQ3QgxsHpyzNFrzZadNd
 Fs2i9WF7TCXF5YM2MbxGB6A8s6LXrlraNrQH1A4xyGX2uE8LrXHa0p9gwOQPUwygCirD
 gMoQ==
X-Gm-Message-State: AOJu0YxdXge9fdQLa78Vx7Xq6NQ0N1DBzepBIUhcP52GdV+re6uczmVz
 qG5Qw65E23XdzP5iuGhq76aptw5epBkaQZQG8F126ZCv+0cvkkICBGXu/wqmrdNLaz2qARmpzSy
 MkTstVQE=
X-Gm-Gg: ATEYQzy/2V6aMIgoAKiHQtSJLyVDUPA4nd3WUtakJR37Is9obpRbqqeeSO8FfFV4iDK
 ipB3bTdIYeKdDc2+LvueaKDKsUOyyWNtkx/ExXT9PaomGkhYGsA+m/HoaeWyYqmKHWfSHIvLR7K
 5R7Vo126q5ZRVkaDc1wn+gXY5hqkpILwMAajvFmnFGJkpCcPCDEUPnlKly8Ye7XWojdhuE/2n+0
 VXO0OEt9Yqbjh68SyLdQWI86PtF7wSwUejnz04dahexlTGKu61V2qFhX8fNQmyUEksZTj6mtfMe
 wwK46kKfFn3gUT1sVDhpnogGtq8/OHRBCMiQel6HmtphR63TNKW6mzsRfHz2fElBsXW9fJhE2iJ
 PH8bo80L3SFhsC5NmL05zG+622D0uC9wlL0hTlmK5qjggvmtTXN3qWnJMV+Eu4YHLn0dIGEUjiz
 rCa8FNN/zPYBm/Sz/KKrMYQyJfFT1ZjMJ1JQbIigour4R/8bDNYwcGVQmlrCJR0JZjkc9OjTD/Y
 7kOH/L7Q5B/0doV
X-Received: by 2002:a05:600c:1e86:b0:483:5310:dc67 with SMTP id
 5b1f17b1804b1-4852695b81cmr160952495e9.20.1773009336882; 
 Sun, 08 Mar 2026 15:35:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm21709164f8f.16.2026.03.08.15.35.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/49] hw/nvram: Build fw_cfg-acpi.c once
Date: Sun,  8 Mar 2026 23:33:53 +0100
Message-ID: <20260308223433.25503-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20260225035739.42848-6-philmd@linaro.org>
---
 hw/nvram/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index b66f23605b7..26343359875 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -18,8 +18,8 @@ system_ss.add(when: 'CONFIG_XLNX_EFUSE_ZYNQMP', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
-specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
+system_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
 
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_otp.c',
-  ))
\ No newline at end of file
+  ))
-- 
2.53.0


