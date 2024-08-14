Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9884C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHXm-0000IC-CU; Wed, 14 Aug 2024 13:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXe-00008t-5X
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXc-0006Cs-G3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-201df0b2df4so842465ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723655527; x=1724260327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8jtLk0rS0EhtRCVLy6d5dSWwHGsq2dL7mHB8O5U19E=;
 b=zeEAHGBfCSAbIixCoDRrJ7O5y1lLmtbcYGX1IAVBts9a8oRVsT31WsJruJEFCfNxAx
 6vdSys4VMT+VIDA7pcgGg7QrVW0epM2TiY/7/a+DxxY+tQ71ltfmNtPA+HnxA2Wa1pve
 yYQ6h5/5HOnzCfTflKyZW9dQoT/c9stUNZRRZF1xWx0th3C5BydB76abI/UUXpC2SOt9
 1j49xFDxp8WqVXIqQtJtvW863n81Ls5LQ92+sEy47t7P6H5Z9xGDPbgPQcd5bBMc94lb
 aE+s9E/IDK8/LiFcEEZmpZgWlVf92IIQKaUGjvs+tq2ECO6lbOm2QNauw604Tch7RaZi
 2Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723655527; x=1724260327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8jtLk0rS0EhtRCVLy6d5dSWwHGsq2dL7mHB8O5U19E=;
 b=gnT/eswOSpFiVbvVoZrWOhv+IQPqs7dCfWH3r4hyROOTtj1G0PKGnrh11js4UDufdL
 wDyW2dayulfl2UnLjIhzeGNpp6jlWvN8fPPiw3vBnWyCD+c/EdDyVkkek1KO9TiAInt4
 q5DDc4/JMpXQHniyfBRsylPdP6QgvULRG5hrY0z6kPI4GoLGjIakZW/+ecCSsD2BKB2G
 ye0FlmX9sZ+aNRpHQHcmDPyYFsiGau+jOdbOcN2KvPkfPzdDePo+sMgaARZUk088dZrW
 XA3G+KVICt0/2nDMRbCFeWKJfKLp5a8/2D949Bqh5YNWJ4mJWWehYJPx/xochm69U4Gp
 iT8A==
X-Gm-Message-State: AOJu0Yygqh/+ApSc3nj67yqGG5byV2Od3vvmwAjNngHcJyTVXMsDsQG+
 jhSOjrbvKhYuq6DPL3zdgqww+821gBj1TtEBS4QY9+Ozv6ceoHNIXQpBpzT3Oe2KiAX/Qwn2uqJ
 HvBs=
X-Google-Smtp-Source: AGHT+IERRzizD6WdFAWCfPZg6Om1n+JiPPLwp3B/FbS7ZNeztWagWFiwUGTp5QjIt2c2704zR89fkw==
X-Received: by 2002:a17:902:b68b:b0:201:cdfb:2919 with SMTP id
 d9443c01a7336-201d638d821mr32538115ad.8.1723655526725; 
 Wed, 14 Aug 2024 10:12:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c8783sm31813895ad.245.2024.08.14.10.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:12:06 -0700 (PDT)
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
Subject: [PATCH 2/4] target/i386: fix build warning (gcc-12 -fsanitize=thread)
Date: Wed, 14 Aug 2024 10:11:50 -0700
Message-Id: <20240814171152.575634-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
References: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
 5345 | }
      | ^
../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
 5364 | }
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31f149c9902..ddec27edd5b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5770,7 +5770,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
@@ -5789,7 +5789,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool has_sgx_provisioning;
-- 
2.39.2


