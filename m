Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE9C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFG-00016s-TM; Thu, 22 May 2025 15:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF2-0000xk-IC
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006UZ-On
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:08 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso3759397b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940763; x=1748545563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGfL+RzDQIDa37K5e41+zNPdkMKsax67ftvf0bDSf/s=;
 b=vIjxZbveqNRQ96bu0Q3RB/F73yjr08kyrSrkEUvfREhTjLEkD8OYS2KoPE6a9BNb3F
 Cxl0CV/HnV/w9fV1QqIkQE3VE45/HfKUzTQEenwwIvlwNJdccNs53qFvTcDuOvsrY7Aj
 +V8ZzktzIY4l87pOW2JVddKD1Rtskbk1403T0uW0CURR0dDmGUcClLW0Uxx4cT3DTnoc
 cDU++ql+HalvbgKQFJDqp0WX1AMyhapySXxsXsVwAbCBM5fPH6eHW3dkdM9wl0r9krt3
 LZf+ShiQqeNlZg3Ny8qH2jyQdrFLIyMuBxXFCXb04A+o2Wg2YCYWLWM2mDE+uVYWje97
 9aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940763; x=1748545563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGfL+RzDQIDa37K5e41+zNPdkMKsax67ftvf0bDSf/s=;
 b=iGlQZxR7NrSPJxwtQTCrMimrmoMd+lvb9DgH4/0icI5dwWAqBKWvBvwgbHJyGDDTPB
 sDgRGHYpg4Z/quwnktNe167hv8NYxANe0AQFoA47DkEEcsyaWRMG8xSAN1JLPdtzC+1n
 ZWNEFV/pfs4zpgB+wDZSVOVJCIVzytJrCXl9wbQnfLQTaGCQgKS/MXkGFIB5R9aJuNmV
 diR6jPizdAv5Guw16Cgpbq6cY0bbx3hmxJLFjIifAQVz58ldTdiqrk4g/GSbdcZH32qm
 4HNqK6BU7v4wEVKbnWQjDktosOWDafvkuyYCt4ElnF4tig4FNvC/dCtfn8r9I6T25E3+
 4Guw==
X-Gm-Message-State: AOJu0YzXeaqFTusSFTFolDJVYhpbMIXPevU12mNG4A9LDlu4E9gWPFAR
 E1/MNMwSY3tRirTYLS1VjA3u4TBAkUC/8YFsVJbTdNtrxOz5gLa93cand66/mrPm3HPowWyCiyP
 c/9zd
X-Gm-Gg: ASbGncvCNtSx2Mr3vZmfmGSjDlN2NnCY5WxL247CI5plVJwDEKMlRi9TTiLLnnnZbUk
 pwHSGPqpOFzA9ZE5hNctP7OaJ+v3W1yIHV2i2Flico2IVC18dnP5bkUMYF/itgAU5xu6WlEMLxd
 6XapPeajLrgoYaSDJfTaK+OjCU106pBgNTTgsh9yL5A+I/DOOCDI76eG1ITk/328EYsVuDA7ww1
 /16zMT0/tPDmyDOXDLkwG5pcgVCFNLdSAcV5leKifko6gNCo0I8BEL84bcXRlhmkaF0WaRyGWm9
 U1GqXM8rR/m3xSuCa0lMrMr47lnUnW5T0+jjmUMKmAm6ME9LD3s=
X-Google-Smtp-Source: AGHT+IFTF/SCBFEPX9N7bmuaX/zk+D9G+U/ntpEA+/zBC4YxKIgLJe948mz8At1xXZ0+AwCrF+3/Kg==
X-Received: by 2002:a05:6a21:7991:b0:218:59b:b2f6 with SMTP id
 adf61e73a8af0-218059bb4abmr31951480637.15.1747940763602; 
 Thu, 22 May 2025 12:06:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:06:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 14/15] qapi/misc-i386: s/field will be set/field is set/
Date: Thu, 22 May 2025 12:05:41 -0700
Message-ID: <20250522190542.588267-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

As requested by Markus:
> I'd prefer "field is set".

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 3fda7a20bdd..6f79817e382 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -129,7 +129,7 @@
 # Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the
-# returned @enabled field will be set to 'false' and the
+# returned @enabled field is set to 'false' and the
 # state of all other fields is undefined.
 #
 # Returns: @SevInfo
-- 
2.47.2


