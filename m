Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE82C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfx-00083D-LX; Sun, 26 May 2024 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfr-00080L-WD
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:56 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006UK-Va
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2be00b445c2so2095051a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752205; x=1717357005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp2tqJpP1VGOVmvGLLfhZ7JUgsbCC6mxTTS1hPt+7hc=;
 b=QSQr1zwmIWOMN3tNggClR8hq+IKwpssUg8mWEfuH+UCrPzPqepzRF2Tu/YCXS9ppTI
 zWmzRzKnx/wwQUS1H0x7lWJVRui1pVyYP00tUwsTXrs+v9toEF648Zebx10jUmlNygz8
 uYxFJkcW6ptNTm3+IyN9MY6tF05sUVl6WdIc1xX0PfK5kD44GKmm71nRsHfPDlxLezOc
 jOPIuKXpAJe0gz5uPIQSKNq/6YCPBKafe/Lt3TjmAv+U4Xd6F91EH02d4Axu8/vxXWi1
 8gh41iqvPxc03e4eEWuJz8WoHiZNUVQt2R6EfvncIhOYOupnaWVqfkozMku3HhdUxqsC
 /B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752205; x=1717357005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xp2tqJpP1VGOVmvGLLfhZ7JUgsbCC6mxTTS1hPt+7hc=;
 b=izGuyxungX9ZbKGSWtLI5cMIJ7hP8dxGg7pu9Yh02P7bsVVKIC8/ib4TctqthX3dBU
 LzzhmBsFfyDT2HKM7srl3EWS3SJc2zxiwv3G40a1QNCnWwzTymrC0iYm54akGfS7VSnz
 BMQrJwDv3qpMr4i4aIfZBECGK2+bmoAqwfdMtRrGv7x6B/Itq/pJjJgKCzXGU3w2cDDM
 p95nNiNw9HFjuSIJcevCtOP6jfkFMB+VsBtLNfLYL+RaUnpCvh428LSqWRv0h2NVS125
 EuWpgPJuiCOOIpOTyjngWfB0VHRYKclOmjtKQYJ5Tq8Cp+19IrGTmvobba7ORx8CkO4o
 7zog==
X-Gm-Message-State: AOJu0YyjwPzT+vJXrIlOdkzPwAQ3PUoD8+5qLq+m8hub5Pd0XgImEJIn
 nO0to6oZNFOY/oXyzeSbnaXhThT/ZvOoOL8kLsRMlvDcTgn3iw37uCFw8rwH3Sw4K812+blcL5q
 a
X-Google-Smtp-Source: AGHT+IHMIwpEogrRlxWIqAGK3pFNhB1eOkBGk3i41bnmECJiULpR/xIT5Da0/yE7WaFiiffXgmVanA==
X-Received: by 2002:a17:90b:120e:b0:2a6:9c5f:828e with SMTP id
 98e67ed59e1d1-2bf5f202ad0mr6698267a91.22.1716752204830; 
 Sun, 26 May 2024 12:36:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 07/13] contrib/generate_all: Do not rely on ag
Date: Sun, 26 May 2024 12:36:31 -0700
Message-Id: <20240526193637.459064-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use plain grep instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 contrib/generate_all.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
index 651cb23..5ff0b3e 100755
--- a/contrib/generate_all.sh
+++ b/contrib/generate_all.sh
@@ -78,8 +78,8 @@ fi
 
 mkdir -p ${TARGET_DIR}
 
-ALL_INSNS=$(cat ${RISU_FILE} | ag "^\w" | cut -f 1 -d " " | sort)
-COUNT=$(cat ${RISU_FILE=} | ag "^\w" | cut -f 1 -d " " | wc -l)
+ALL_INSNS=$(cat ${RISU_FILE} | grep "^[A-Za-z]" | cut -f 1 -d " " | sort)
+COUNT=$(cat ${RISU_FILE=} | grep "^[A-Za-z]" | cut -f 1 -d " " | wc -l)
 set -- $ALL_INSNS
 
 GROUP=$((COUNT / ${SPLIT}))
-- 
2.34.1


