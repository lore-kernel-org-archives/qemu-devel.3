Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B28C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKNQ-0005qT-OT; Wed, 12 Feb 2025 16:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKNO-0005fB-7X
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKNL-0000as-HT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439554db49dso2144735e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396069; x=1740000869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiKngVfPjgICo61bJ6KOaQ3JYL9QFGgGpEIcPT8GY7I=;
 b=kqUIPD2T6J/fHNorYBIO/Ek0VhimvegC3WwLDmD10tqkiNMjoaWrGlFtDt2YZHtiZc
 fcqVl7VX0+8My9u+CfqVjwQlt4OXBr0CkGWCh7si/ynnFQPgoBtVCArNCYGu7hc/bk4w
 UUOFsxOUI6Sx2oX8gklMSTqtQBETTb/86q4MhDAHfm7lnt0pM+M2otEBifsPkwmYhjCR
 AKQVL34xkMZrCUBh7oiKEXLExPyY51omuuFZ52SUrgFqxLvbUiK3nVUgD8+rTkZo0r2z
 sKnDftpqNUVTbTVDhiQlI+0UGmVrF6eCjx4DaBxzBQ01CDx4kcf6HY+y5jy7jD07KyX3
 YU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396069; x=1740000869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiKngVfPjgICo61bJ6KOaQ3JYL9QFGgGpEIcPT8GY7I=;
 b=weNrO6N36OawJu8IEFRqV6NQzIEu8nqHBYwgX8AizWFbC3tmKftW1bYmriVuYoyWhG
 Q6HA4v26Bu6A417Djy0GXi7IovD6bujo8VyAGt1UFvkGi8srGBsqLI+dp1c5YwEVsmph
 rmsAOXijm9zia0O4IHpddUe5J76ruE4wkOdLMsaM+aoO21qko/RRMRukGrN15bNVce0P
 wE8Bl7RFLdo1SoNYBXIx7KtVLnW5bkNATs6OsatA2sC6ddPAcceNoG0EGFXp7fTOZ2OW
 GQcCKX2DYa+29EsIwlf8d7WybmzSUiZcturlb48mAJDwvIVgdGcC+jbWZiN0DIvAVcVG
 pD9g==
X-Gm-Message-State: AOJu0Yxk3phqKPILnWnLhIFLAOSGXH+EHHbEQJqw21C9csCo7lOIkqAK
 C8HwtAvsbuuFwgEhVAJ6Monw9F4pcp2xGIAKw/MUUgFPtV7WJWehIBMDYPdta+BpDP2PqjoneKv
 byCE=
X-Gm-Gg: ASbGnctu1c7TNXiObl95nrt4FnqahqoBJa6703ShgIMi9BQgSklXirfKbEBCN8NwRo/
 Il88QzRf9HPUAhMFDOJuFHLt26uPHgi2b/V24WV7tUNZBRmfj5scuOw6kgzYE9pTtVPchmciLq/
 a5f7DcZYV1aDl5lRYzhp7vWv9KTpfSwtf7fPW6/b1kd+eZnS3HR4Rhn2ODw3U8cU6Lc1aatYBT6
 oNCrvJpTKQhhoPxka0xl7908Yyt/WRRfeUJv8O3Pzk/lSiNPQyFr9qbjqBQEYgk+ENWUcUL1eB1
 bfRKgykK4gNBfCNaUMYq83ciqUKpzjLKr/yQsKMkNa4Wg2/fN01rqoR8vh399jea8g==
X-Google-Smtp-Source: AGHT+IFuC4/cNISXdOz1oIRCPIv9IXWacPeLZcD5Ss6BqOLS17CfEMQbz67Hd4q1gUhBA7DZx0StHw==
X-Received: by 2002:a05:600c:4710:b0:439:3e9e:929a with SMTP id
 5b1f17b1804b1-439581b1d5cmr45940235e9.24.1739396069461; 
 Wed, 12 Feb 2025 13:34:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06d1f2sm30611705e9.18.2025.02.12.13.34.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/19] qom: Require TypeInfo::class_data points to const
 data
Date: Wed, 12 Feb 2025 22:32:49 +0100
Message-ID: <20250212213249.45574-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

All TypeInfo::class_data point to const data.
Enforce that in the structure, so future class_data
stays in .rodata.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 1d5b0337242..31adc2ef174 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -488,7 +488,7 @@ struct TypeInfo
 
     void (*class_init)(ObjectClass *klass, const void *data);
     void (*class_base_init)(ObjectClass *klass, const void *data);
-    const void *class_data;
+    const void *const class_data;
 
     const InterfaceInfo *interfaces;
 };
-- 
2.47.1


