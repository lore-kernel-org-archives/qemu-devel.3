Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326BFD74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInm-0007La-4I; Fri, 23 Jan 2026 10:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInH-00072f-LC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:52 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInF-00033C-GJ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso25551025e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180988; x=1769785788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EClQisP1WNR7DbiLNLpY4ZP3UfFIJ6LXMnztCRYK/to=;
 b=oJrGdoOTxCE46auDHQs7pkVpy3rK6XcNkyZ7DMcE+Bw5uJbiM3Brv/VW2QWepDQNkj
 KbE22I++J5ZBjyXGv1E7g0ZvETjQgxGKTwa8knQwEftu1PUyDrE5CwUp10Gc5TwY7DU/
 yxD8r3V9biWfsybAgOofpjxZKKl3iWiqAZSXqCunLrpM93bukorkFVcUYn8mPR7tnl//
 7cIAbNjx2KLk4b4HFIKgyjtuOOVc4xWAx2nwKKthWZnSEQ3ERGt4LhIoPXpwQ4UyaXL+
 +4iXe3Pi8mmHFGlnAVi6RIgb+Wj360cKY/wV4LJOM0jftxDmXMHK35PUIt2z9KQtc+Sx
 GIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180988; x=1769785788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EClQisP1WNR7DbiLNLpY4ZP3UfFIJ6LXMnztCRYK/to=;
 b=iwrUDWWEeIkXJEQTjKioORBuceuSEZ92wPw8C/Y3npMaIYFKrcrDn/WluahVf4Z8E1
 DwZrvo+thcrQZiiLQ2uuxTTMozCEtXjV7eir5cNxsDMcnt1Tt92CtjnJz5CFpq2HJqgq
 F8gh9AFbBc6iQO33jGulWVCH+No405vBkX9jcAAcd9ETI/2QWtxRqNmo8+pcEMPFN397
 ttGmI35N62qO2bs2blFWGsJFaYMRdpI5IO45VBFbQDW4weS8aPNdhM9LJw1eDPGpNuRi
 36GQbSzQr10spC2CzbIBjuwcB9EsHURzy2Oj2L8e5NEVZmZcOHzw344QhfSMyj6uXl/X
 HsUQ==
X-Gm-Message-State: AOJu0YwCDfoOJ+hinVFCAsMzCuG2G2zZ3lwE7FGekDAyCg8XXp38v5GZ
 OAjnBpFlfYDDXuzb3eC3gQQTOJBdAcquvrkjwTllNd7DXIG759cHjJxkMwm4tVpyb1A05fNt+0+
 tHqceSO4=
X-Gm-Gg: AZuq6aI10IpjDujbG9qeYX907oM9IFEZwAmxeexdO/uHl7NdBYpryYTsPS7B9wT3Tad
 /dyGvym8scCP3PaPYE7nSH+CnKovEmO08sSRZOWiaYiq33sQbMitn1RyvvzcWUfUUyjxEedvJvg
 GrzUhkTs55bH/VCQ1wbhvEXOdcAVCFwsGx1oA1LlAth9Xseu9EjsHx2krRaqRg1wcGLXwqey/YQ
 LpRg7j2wDIVtj6tg21a46MNUYBL3QnX0tysncKljvcBmdsy2V0YXo83RPmlNVY3CYBi8pc+Ciru
 mOCO+1tOW15y+BWAXDYsuZE89Zc+OEub4EuYCydzZ5Pfxr5RqUMK9zO9Cm2A19AHzQC+4zmtQ0S
 bS1XZmjl/Pxb2EObafAy7qQFgPcJuzWM1MV7FWLQmkcWXE4ZcyfEEOHm87OyDim+rRukq5dkGvo
 PTKSzjhn+ATUseaSrH9PAWYXSZWHDGfKUATC+cjEkHnIu63+7UDel0ZJ2yrsQGOOY=
X-Received: by 2002:a05:600c:4ed0:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4804c9c9c02mr50627655e9.32.1769180987955; 
 Fri, 23 Jan 2026 07:09:47 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/22] scripts/clean-includes: Remove outdated comment
Date: Fri, 23 Jan 2026 15:09:24 +0000
Message-ID: <20260123150941.1877768-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Remove an old comment suggesting a manual shell line to use to find
files to run the script on. The script's exclude-list and its
support for directory names make this irrelevant.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260116124005.925382-3-peter.maydell@linaro.org
---
 scripts/clean-includes | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 07c0fd44e4..568033ee9c 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -39,15 +39,6 @@
 # removed.
 # Other files (including C++ and ObjectiveC) can't be handled by this script.
 
-# The following one-liner may be handy for finding files to run this on.
-# However some caution is required regarding files that might be part
-# of the guest agent or standalone tests.
-
-# for i in $(git ls-tree --name-only HEAD) ; do test -f $i && \
-#   grep -E '^# *include' $i | head -1 | grep 'osdep.h' ; test $? != 0 && \
-#   echo $i ; done
-
-
 GIT=no
 DUPHEAD=no
 
-- 
2.47.3


