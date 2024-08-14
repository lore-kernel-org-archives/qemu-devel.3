Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33261C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHXm-0000IM-BA; Wed, 14 Aug 2024 13:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXf-0000AU-D8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXd-0006D2-69
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fec34f94abso637775ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723655528; x=1724260328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7PkrlYQr/V3YMS3es97SiZgcfp3AW/tKZmcfuYfGEw=;
 b=kf7g1y9Ey8R97LoppDxkenw136vJQ4PhuZrSQOsEKGkYQj5wBrPMvKNGB536gHMWqY
 NHJ8qtXb48V+XIXQy2ZdpUpaY++PE7SmA84bfBgMJmw9KzZMIP0MGxz6BRSglKlswvw+
 3aD5R0PpfJNAOc0KbIBY679SZDL+N+iwXX6NHFPiDjgx9Wy7AJM2EpjtOolpIRy9gxcO
 pld36CtomUNrTt/2+tc7YHEnSleQuK7MQB5jaaCPn24JDjwDiOMQfjlHt5A8YiALnmCp
 jCh4EyAHVKRVPs1tm/AhCZvU5ZR2OiBjPUDYqDW85AA4mRVLCRLBrMZc4sxgmX+Bj5TM
 L8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723655528; x=1724260328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7PkrlYQr/V3YMS3es97SiZgcfp3AW/tKZmcfuYfGEw=;
 b=PH1ltmBGUiyi/YZqTazVTkmXlXiVcCh76kO34Rx5ACAp2GMaBSrDBdoRcyNCWm15B4
 Lg8l8OpMqkH8c+M0U9JDx1JN8SZCCeySGgj662Jkpnx44E0oGSXLUCuWzQ//mxN/3RqR
 ug3Lw03GY4xcW0pZviD9ibFP622MCXqkfSqMGELcNATeuApIFX0ojC7ATBwctK98WlFw
 2BQKc6Ep9XeamdtPBvcirPwN3Uak+xFaie1CaF8GRHHZynTyJoYbRFxit9fWB8IYsGpk
 T2CRRdoQ4Y/OtlONiTAyVPmIC40mES4fKc/7uTEFCXZ06MJ3dwl9ebit7Z+br98v7cS2
 OSDg==
X-Gm-Message-State: AOJu0Yz3Bj2UevzxCu9tEBWUhYDgFNeP54KRuZh+/qY7Y/Z2hJ4GRowy
 Ozqe5HbUDpOAVx45sKIrBZExyhHiMHJMgOvqeH4Kd8bRtW5bIl1I21Wie1pkq7n5y6vIbTQgOIv
 vHsQ=
X-Google-Smtp-Source: AGHT+IH1edYhLET7/RIFW48bFtTCY7hghNR+eEBNjSEPgKc65lUBwapnO/P1culqyBP8m+YCz6d0NQ==
X-Received: by 2002:a17:902:d2c4:b0:1fb:7b96:8467 with SMTP id
 d9443c01a7336-201d651f85emr34242465ad.63.1723655527854; 
 Wed, 14 Aug 2024 10:12:07 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c8783sm31813895ad.245.2024.08.14.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:12:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/4] target/s390x: fix build warning (gcc-12 -fsanitize=thread)
Date: Wed, 14 Aug 2024 10:11:51 -0700
Message-Id: <20240814171152.575634-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
References: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Found on debian stable.

../target/s390x/tcg/translate.c: In function ‘get_mem_index’:
../target/s390x/tcg/translate.c:398:1: error: control reaches end of non-void function [-Werror=return-type]
  398 | }
---
 target/s390x/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c81e035dea4..bcfff40b255 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -392,7 +392,6 @@ static int get_mem_index(DisasContext *s)
         return MMU_HOME_IDX;
     default:
         g_assert_not_reached();
-        break;
     }
 #endif
 }
-- 
2.39.2


