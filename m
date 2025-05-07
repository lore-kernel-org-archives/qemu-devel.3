Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41D0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoTk-0000sY-E2; Wed, 07 May 2025 19:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTW-0000ST-P1
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTV-00037a-9J
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so4548095ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661612; x=1747266412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO5E5SNmIeDx8PW0b+RfMLgVUuAcPfL8utSgWSmdyqA=;
 b=G7uQdYixsScwqWJhIZ4zII40QAv2UQZ3S3dQWiK/ouDtSsgfdpxJCbl5HaL8sszOsp
 O985keGHKG+iU1Wv0qzCRYIGykBJVJWuP4/J6igIgEcDOpZwPDx+bR6irfIGeg6kEShS
 P4IyJJvZ+SPPOVj6EfEs2foMzY6hc3dU22IPP+cwkVL8fGMEPnB7j/KuNAJyGuiiIDk0
 o0hOvL64CdBtzxv1i8bSWfrLe0AoSbFufl0XED77N6ibT3yHE/Om4Rr75VR9MS7IvBYQ
 hhIj3y0GLT94HyxatfGueLhtZ4cIcLAVKDMbL9sVqYkTRQ+/fOkqGNwb3LFYw9ZglaMF
 qy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661612; x=1747266412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO5E5SNmIeDx8PW0b+RfMLgVUuAcPfL8utSgWSmdyqA=;
 b=w/oOueZ5VwIQKpPKj27uRIEfaiLk0BizaC0cJzeurk1/OO2TzHiQFL9mezZEYC7lWk
 qvwPoL+LrFrKvfLWsgEOdLA2RWqelRxF7p7W3c5e6vM8JX35q0dY1kv6jMlgGhay6wyv
 rcsUsZgIWd32tuVePhrehUfjVtSWSKXlpExla6w9uTsNFpHAyOvIGpcn0M0W2GlgJH/l
 VXbZOyAxsCz3elCQpWKQtiO3DHC7fnzkeIWcLTGMOhB+78ii01Z/UiWKo9+B2U7neF8C
 gAnYiC/OUS2xhsnfB0RPQwFp/XsXy91/2UJKTo7kquxOQYaUBfZiqixldvDo8dn23TRR
 HEXA==
X-Gm-Message-State: AOJu0YylE1TqztwuerllmfG33e0LIz9XqpoyUey5gfTfXx5DoCSvui7i
 4WaWqOQoOcxFXZIIAtYbVrOl3mxaX6CNV8ezlM+yqTBygTZT+HldhEP2nkMYHTueo5FzQwJ1Q3/
 /CRSFdQ==
X-Gm-Gg: ASbGncujjVdcMzwhNfGTZ/1K8njW541sSVCtxIu5Mbm37gU68vJ5h6i2WCdGnTxBUj9
 rhFISx+xZieP/I6nHE/JRwKcRG6b6gapwX/inmW/UDmUbFxHmrg+Uonwil7YbDxe3qK9u6DhmrD
 BmMYEYYEtXdOUKGu6NOkWfRCKYVEAtxQONSAo14zBh65yjnt1Ym6kKG2JXX7XiM2LPyccXB4S15
 Wi1T+qqn8tpen8Bqu7dRnWTkvGwpHCv1PHXhEYx2G6XMIbJ20YWyGQHVUDlf9R0NuCEc4haPZq+
 pTrqBdEZfb5l2+/yO+ldpuPuQ1i6v255NqbkA2LC
X-Google-Smtp-Source: AGHT+IEHYf5gn4Kms+01AVGqYQpj4Yv7nVnKVCgM8oiazO1HdzL36aOMXIYItrwG0ce1halY5iExPQ==
X-Received: by 2002:a17:902:e78c:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-22e5ee1cc15mr64885385ad.50.1746661611918; 
 Wed, 07 May 2025 16:46:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 40/49] target/arm/tcg/vec_internal: use forward declaration
 for CPUARMState
Date: Wed,  7 May 2025 16:42:31 -0700
Message-ID: <20250507234241.957746-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Needed so this header can be included without requiring cpu.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vec_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 6b93b5aeb94..c02f9c37f83 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -22,6 +22,8 @@
 
 #include "fpu/softfloat.h"
 
+typedef struct CPUArchState CPUARMState;
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
-- 
2.47.2


