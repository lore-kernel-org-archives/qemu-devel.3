Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDCD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumu-0000xU-2A; Sun, 01 Mar 2026 23:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwums-0000wj-RW
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:42 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumq-0006nn-Ac
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:42 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso2452934a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425298; x=1773030098;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cuON0t/50ogMo6c3lruWdO8pZIhZu0gPHa1YdYOyFQ=;
 b=hCf/reeEnCzx2snEYGGfSDLcGWUBYSTPOjFm2CCR6wmbqPXnoLERMejbGuCH3vAho0
 CSaVsoZFwplJMb909q2a5GbRiO01fBlTdhsvDQhxi3ZzZtFm55xcHyn9L7pREqitoMei
 073q3wOPNjft+obm/cBVCpKehdOpuJnV6LEc469KEUyf/a8j53DZCbDoSNdEiBtlF9Bh
 TY1LucUY0mENnmg85xGL9+5KvMe+tDUyT3EMotbHY1JZdksUDJesseejs6bsOb0czhd3
 bw1r4HHbFSltBn5q1DdDNkuVgcqoyqRaPDL/b81+KKZdeKXiw8mAsa7FLWAf2P7MPynh
 No/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425298; x=1773030098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3cuON0t/50ogMo6c3lruWdO8pZIhZu0gPHa1YdYOyFQ=;
 b=r+XSvPHCG10leAA7hpnzL+Ijpzdr7goc+rBsbV1YcsTWNJm66JIxx3EMelnVfVKLZQ
 Dsc6DFNe8q/vh0u5LCijD1iY/jpJM9C5u7aZnMIAbxnPr3EU5Nj6VbeOUn4UcIlPfmcK
 gSUK8D9KN0b3nJzw/V8uvISUBWiNIMFaN3gEFiimc65RQvixfsrz9aIsCiMJGDt6C8qR
 1CnRTBzD78BQL9JfdKJRMWy+s82a2mrTYF0oQ3ukR/z/p5B0WnCTTtfhxsyx9GgKsDqj
 IaWei9e0HcilD7p/x/FngLVftKvRxfSCnYzVZSwOy/3EBiFrHKuRb/le2TqmK8kyqq04
 35dw==
X-Gm-Message-State: AOJu0YwbGr//GCEf4mtxNIGe3kWb8rSgh4TEgCBg1IyY8EMHNvcDfdUt
 Xo9Zyx11w9u+UM0kwE6YzZXjZwwkKhvC2OMpjnKuXDxfYg0T3uxBouvq0YPIRewMpkQeKWTEVwV
 1UH1e
X-Gm-Gg: ATEYQzwpYY14SUWluQuWkNgkiXU5WNJEr+Iw2HiU0qkWXHJcHpWTAiKon6F5sjGJaBP
 IjwvB0j82pRTKbL6hgSmf4vtQdAfyRsGz3YPL1PJmUZI+YxdLKLDtB2rZMNII+TY+VJDuwuor2T
 3VpNSb3g5DiCNyVR9ks4enQ3GPuivNsswcjTHuMDddxSdcITapwsFYSvJULEtXmvgkFYlDoEaVX
 XOEpt0AHeKwMNbPrPvuWxMHb/Z3tel48cZITFC94EhMBOFKlPXJ7X2diTEHsXdiObjkK1Awshwd
 nK92eEyckN4nIiHV3hJbMr1ud74prcKrkZH3XPWmp5vaS8uOtknFCeFu2tcAJTRikC34LvMZTtQ
 Or8m4Ntv+GOk0EAmk3Fr9Rl0xcF2H8pMOAgb0vMeCwqkxRJbPUmRYoVWcpA2sX49L6QCdr7qURk
 J7kBEb1ipbIA==
X-Received: by 2002:a05:6871:eb07:b0:404:2fe7:e184 with SMTP id
 586e51a60fabf-41627097c9cmr6752632fac.43.1772425298553; 
 Sun, 01 Mar 2026 20:21:38 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:37 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/27] common-user: Drop __linux__ around .note.GNU-stack
Date: Sun,  1 Mar 2026 21:20:52 -0700
Message-ID: <20260302042115.83410-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GNU-stack tagging is a toolchain issue, not an OS issue. All the
toolchains require this for ELF.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 common-user/safe-syscall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
index 74f7e35694..2f714cfbe8 100644
--- a/common-user/safe-syscall.S
+++ b/common-user/safe-syscall.S
@@ -22,6 +22,6 @@
  * assembly needs an executable stack and the whole QEMU binary will
  * needlessly end up with one. This should be the last thing in this file.
  */
-#if defined(__linux__) && defined(__ELF__)
+#if defined(__ELF__)
 .section        .note.GNU-stack, "", %progbits
 #endif
-- 
2.52.0


