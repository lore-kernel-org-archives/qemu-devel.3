Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E45CC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZC-0007th-Ey; Fri, 07 Feb 2025 16:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ3-0007YW-HB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ1-00023U-Rz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso35978435ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962422; x=1739567222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=GDDtftl2YNbJMyOqjZ1DDD+giLrebeANc759D6Dqe6TaFsVYG0UocrYqYyjsGLupMe
 M9qRhzsFUNzu53mDKKjYqir98RWny9mSfPbQjmWZ4X5rr8m807Jx3GsMrN6YZfQCnYco
 j8078mBNHuX6kC/IV2BFY77JYnSqCHK3PcmjM4WDWUr557lE+ck5ZPuvRMC1GWtJ39Hq
 mB3cc4Bu2t6cr2oUSd9dDSrzV3Hm3IHDq8GXHkEbrYQzO3E84qQeRVe00ZuIjiSJtRFe
 ME1qCABedLpV2eZA51/fL28BvqBoLR200kQjjn8AKk2AegAhAoaGWpcrJKo4D1+Dvw74
 rgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962422; x=1739567222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=cpnQAXMXVcC/k8O8Hj0mW1zg9Hf0uZLwoQ3nt6a1ui1KkNNt5oTj+8pJ7iMmoFJ0uy
 6mp8MNEn1OCAspH+fQYkR0bJp1Atb/+fDVFUiD54P+/pOCcs2WQIFzQTOjQ82zydRXR3
 c723b9Jxlg5MlZ6qKVNgLPKYf9wjDPo32RkYj327O6ZM94abcFkmHCYsVVgG/c+EH6Ed
 zB72cl6TgTpPxwl4Up6kRhMZuJj8yw+Nli4l6Y6hULT/UJl2htkOC4HYqXkJ6Uix1Eza
 XIT/5t7rz/cMCiZKc5WpqlknfJSTzF9SP0XIIfHjmvljTgbJWjA2IfRtjXEyod2be9Fl
 VLyA==
X-Gm-Message-State: AOJu0YyrOv44KNNTs7ut35j2xBAjITjKG33ZqOHBIEpInCVBhzXMZYJF
 wZIGSidJtfVWXgn6l747iadU5ETTAGKEWm0Uofiwdn+pb7YFDdhSHuU9Fg9xXDSsbwZ6WejNIIw
 I
X-Gm-Gg: ASbGncvW+iyLg5cuEuBYJ3N+AoaukqJYpfKTkgXzEgQpUQstCh3U5fFSRmBrEv3K6/g
 iQ6tJmvEdo/NeQhzmT7aVJQYlsZrzcnm6FxjEq6VJZsWe7w9dF9ma423AYueuz3cM4umKmwVQzx
 BNChE/1dOcd+iIvF6eGNGZcbzoSxFanxtKZ6p6aeHspjB6BnUC1clIY2GwyRhTnfm1P4WNVLkwb
 hw01Z4z6UsrQGdZJq00J2Co6NFHuPt30IDZwrrwE/rdwIadteLY/TKcYgeOvh/GSI5rrGCrdilk
 +NTLHCLEjPZGXNMeVonaKowIZlLHv3aYrxNwn/QJw1CTe20=
X-Google-Smtp-Source: AGHT+IFaren9YDdUyiJvTOiSIzWWv8bzEh2926EDxkj5hB+hHcdtH0sXhCc6flL9cUv8CO4zGDFuLg==
X-Received: by 2002:a05:6a00:ac8a:b0:71e:744a:3fbc with SMTP id
 d2e1a72fcca58-7305d5159e1mr7476487b3a.21.1738962422412; 
 Fri, 07 Feb 2025 13:07:02 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 5/9] gitlab-ci: Replace aarch64 with arm in cross-i686-tci
 build
Date: Fri,  7 Feb 2025 13:06:51 -0800
Message-ID: <20250207210655.16717-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Configuration of 64-bit host on 32-bit guest will shortly
be denied.  Use a 32-bit guest instead.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 95dfc39224..7ae0f966f1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -61,7 +61,7 @@ cross-i686-tci:
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     # Force tests to run with reduced parallelism, to see whether this
     # reduces the flakiness of this CI job. The CI
     # environment by default shows us 8 CPUs and so we
-- 
2.43.0


