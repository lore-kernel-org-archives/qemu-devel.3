Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1734BD1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjH-0008Vz-QX; Tue, 15 Oct 2024 11:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjF-0008VT-To
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:44:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjD-0000Tl-AQ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:44:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20caccadbeeso41621205ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007093; x=1729611893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaR1kDH2Bf+l69hgvZCXqIUYxGHmIwLgfUQ5KPkPEPs=;
 b=wX2lUx/ss+LkpkiPbceI85npjakfpQo1R1XqIBGReXoIB2cznkF6grostbpUe+K1kH
 iQeLdnffsbbSC4rCoHITAN6wCA8vV22Nx+xv+V0qBhdVvsTDgy+Pl9AXfjlluV4dHUn+
 X5ZbNPDTkttKLl3UtCU2jutimSeMyvsouXwaLUlRwvGW2L2tnjvcwF9fJ1Ceth4xo5Gq
 oVVmDXYjiQTz6CT/sDaXCl1x+B8dUvhPhpbi2bl9NGH5lGTUkUUBdMXD9RyW4sJATRxW
 nXI3t9QJRdLCfhmLmigVkiOoZGeMm4vYJEQvUHy/dyPDULKWgFuctXQ/1c6GE6oohOV5
 s3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007093; x=1729611893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaR1kDH2Bf+l69hgvZCXqIUYxGHmIwLgfUQ5KPkPEPs=;
 b=Hn1HzAt8NXz4oY4G0C61cd7d/U0oH+xCOhS4xQ5PwXjrVsY09ffmcysJ1Vx4NRFdpH
 TSdU0S0NNhU0bteLif4gSNhyLCWcqxTaT1aq47gXsuG9ntVuDLPK35IwyV70ns+hN8LD
 9yOMk48CXYRJV/0b+g9Pl6HkxjeWGhkUu3VU+8wneBbxxHPq1GLBciH//NTQOgAbyFWK
 dQqrOqMdxqhyZi5JteZoUxeHTiNpednZTYFM5IH8Yes7FiPQgbjiJ+vOD6WKkfro8PUd
 0cO7KvYjuTVyyvzkJHmRzTi/jfK4K6DNn3Hg6GO66u02kVPqLLsTTrw9fuLkhoLaKaf9
 8PgA==
X-Gm-Message-State: AOJu0YxNv9FWzPwEQX42ZRvdVNiXE4bFc8ACt/8/O3aSLgCyGCVzef2N
 hfF6TOPBlta+42BCAcdVza3p0hDPxhsXoZN1DusOWPJGUUUhiwV8FbqXM+u334Cno2RAxlEE7Te
 c
X-Google-Smtp-Source: AGHT+IGKcLoA1fzV1i2vd0BYFIhCf5eW8oz28clBDDmuWcA5pYS+J+GtFWNAX2+LyzrmWAwMLgC0aw==
X-Received: by 2002:a17:902:d552:b0:20b:7ed8:3978 with SMTP id
 d9443c01a7336-20ca147e967mr224903405ad.26.1729007093610; 
 Tue, 15 Oct 2024 08:44:53 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f828adsm13463945ad.41.2024.10.15.08.44.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:44:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/33] qemu/bswap: Undefine CPU_CONVERT() once done
Date: Tue, 15 Oct 2024 12:44:10 -0300
Message-ID: <20241015154443.71763-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Better undefined macros once we are done with them,
like we do few lines later with DO_STN_LDN_P().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241003234211.53644-2-philmd@linaro.org>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index ad22910a5d1..b915835bead 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -140,6 +140,8 @@ CPU_CONVERT(le, 16, uint16_t)
 CPU_CONVERT(le, 32, uint32_t)
 CPU_CONVERT(le, 64, uint64_t)
 
+#undef CPU_CONVERT
+
 /*
  * Same as cpu_to_le{16,32,64}, except that gcc will figure the result is
  * a compile-time constant if you pass in a constant.  So this can be
-- 
2.45.2


