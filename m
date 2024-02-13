Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D25C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpIR-0001zk-0X; Tue, 13 Feb 2024 04:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpIJ-0001xN-Ne
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:40 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpII-0000JZ-3A
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:39 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51147d0abd1so4661564e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817294; x=1708422094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D4k6QS4DbxEf/czoo6ZOLuGzDbZtd2vzfrrW34BdNw=;
 b=HQ2GL0xmS6dpzvNG1zKMXH05NUJyj9M587S0cZqwwnS3bYWaSDCd0Yx8yqhFXTreDE
 PFMCosJBsUjZ+ZCKJUoCOWJrac3jHz4UId6jutSz8OJS+MHlaplPgS5MCkgysw/m+PvB
 5V9a5+Ps8QgmPNHc0e4ljzcfNNmlaMUhh/cGULomRXJHx641dX4+PH1ToLeXmy2516pf
 NTLCPvWY9HhvzHAs9Cx+N9pk7XwCTedTQON2trXqNSZuWQUwkwI0nwayPAfMvI1mqega
 1Yc4IrGIJRxZMehYGdti5oI2JcDBVCWPOsq/7TVYalZ1hA2cAJazK9ZoA6cyfkaE4Ei3
 BvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817294; x=1708422094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9D4k6QS4DbxEf/czoo6ZOLuGzDbZtd2vzfrrW34BdNw=;
 b=JKILGcEE5gNEArgXfXB2eWfQxA0aOddHUrifDdbV8caDkpwkSxPN94BTUMCg1Rz+3e
 3REHMLoG5rAmFr/TT7JDIXJ6b1rHqFPCkJDcm9I5r7VRLaisnrJfnEViEde3mnWW7y+0
 FxsmAyLRuG6uhdesH8bme3Qhc6/SxYBflT6N2US5cpj+sWEvQU6oAEo6i03VW0DzsSG9
 CGzr0/L8njWkms2faz+ymAYubFPKRdiFsn/1XJFncotTg/JK0MKJR0qiFhf3ySfKvr7a
 SEwFcoQDdG+y9T4kmfCNnh7HO+VmRl9vsLWlTU0Y3YIUZ4fymVgTuP5CuFBOGl9GVk7f
 n21w==
X-Gm-Message-State: AOJu0Yw2d5gAZ/EAVpBQ2a0O0pq8LODZP1ffm7lsJYNZNrXLDqRtQus/
 +vBbvSyXdu/u7GG2+7FccKRkc9QdDP7NcvvlICntKS+eStzumqV3aQz38szzN3x+RVBVbvulOSF
 H
X-Google-Smtp-Source: AGHT+IGmztangyt9STYxskX8baMOTFKn/hsd2AhJhwa6hbruA7Q2KmtYNQmBxTPrHh3LRsiDYkj2uw==
X-Received: by 2002:ac2:4288:0:b0:510:323d:6402 with SMTP id
 m8-20020ac24288000000b00510323d6402mr5717195lfh.45.1707817294222; 
 Tue, 13 Feb 2024 01:41:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFrIXxKlxXokUE35s03grQlHknVsb6DsagIwUeZbRDNEM3CxNFaKCK52jurF+VdXOulH4H+0vl3FQ8WVFg7e/uuhrYoFUxkF02DKYmtBk7OUloSiPoW+1rVzlKaNlkkU4RbbA4Nb3RRNtmtp/uNiFDsuVJxPNVPtOUS3S0+Em9yNDHGGTsKCNuxAIHomMRR1Rh2tJ1TgtHj/pBAYO5AZzFFXzJX2lSdanPKNvieAmb4RflXVFvjq457WkFEb3vvNZw3GIOgz6VFVJW7LohBAv+22rsEAGPEh52vbQY7r851D0cF/wO5fLUPY2EOmnof7uk2vY3V01wkp2SToZAatld3+XDw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 18/18] MAINTAINERS: Add myself as reviewer for TCG Plugins
Date: Tue, 13 Feb 2024 13:40:08 +0400
Message-ID: <20240213094009.150349-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x132.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfaca8323e9..80528d3dc63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3676,6 +3676,7 @@ TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


