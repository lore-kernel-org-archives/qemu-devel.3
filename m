Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663A1C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBEJ-0000ea-L7; Mon, 19 Aug 2024 18:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDs-0000Nd-PC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDr-0000gB-5n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-429ec9f2155so32782695e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107893; x=1724712693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RulEK3DCbnU7Owbw/MuovKDsIIhP6Bac4B97hBNqIY=;
 b=uoPHcZkma58+QDNF7uhIFH3gksh2ujuOrevBUB7QiHy7UZnVub/izUobHeNl4NxXRZ
 b6twkSUgfDxziOUyxbApgEZ0Up6LOmSu7tO305/KUKaL4w/nLTdqaHBnv9ZYxhP5ZYpc
 0B0fIUopMHsY54U2aI1NS6YTG2M1M51AbgIunyhkHSa8FT50lCkxygpGOd+tRBrXTdSZ
 +sJ2ruHRMygf0GRNJl+H75s90N9LzYn0sWMoOWE/oKxFxF+ZbAdgcgfucNYykxQFLKUA
 J2DF2LGl4pQ9RDHkVM0RoKXX7I+DkCpg7RidGx8ngmDIkz4xYkjr/Retw6dKucYzymFe
 /taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107893; x=1724712693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RulEK3DCbnU7Owbw/MuovKDsIIhP6Bac4B97hBNqIY=;
 b=Uo1iGAuDcxbzilcn/ef/bDvn2G/h4vBV3XfTGpAKmf8xLMx8QpPlp/+8+Xl/arCYTv
 oxqlPwS5IZYJEqU0aG2LIlIbdcY2ejfhMk3p+hMt/aMddmOdE9b7rjDNKTrDJgYH3TNi
 Tdv55HnhcAUR7xs8+aMHmUiAYjx/qXQb6zupdb67Wb+vh5ZxxagNu6JEzGuHqk4QG0eG
 wNS/rzLj1Kn0BbcHT2F2DoXiW/yBAvF3Ld+feDJy3zZTGsRWNq6xzPlFBnPWJl0nHCqX
 BtokqBLXafzsyw3x0LVdhbBk9d/PcYobi1t/THl6Fqd4MtNI+LH9br4WtnnVmE6gGEpY
 JvfA==
X-Gm-Message-State: AOJu0Yx3pXb4QojvUR+D2Wta8EkgAfbtwfaHKsrMBEjpU8Yf4XIO6PjF
 W5c8NP2S/+411aDV976KiBtyIfrFPRPjWG3oglss0r0lkj5MPgmBwy2PkX8+xrqThVips6prTZU
 aWZk=
X-Google-Smtp-Source: AGHT+IE8u2/Wy/h0QQmUJBU7uXeX3BNqiFYqg2ugvjEo9hv8lxpdlXIEp4jZRS4D8MUDebMgvcxN0A==
X-Received: by 2002:a05:600c:5029:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-429ed7af8f1mr96536805e9.21.1724107893073; 
 Mon, 19 Aug 2024 15:51:33 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed7945cesm122571805e9.40.2024.08.19.15.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/20] qemu-options.hx: correct formatting -smbios type=4
Date: Tue, 20 Aug 2024 00:50:59 +0200
Message-ID: <20240819225116.17928-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

processor-family and processor-id can be assigned independently.

Add missing brackets.

Fixes: b5831d79671c ("smbios: add processor-family option")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240729204816.11905-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index cee0da2014..d99084a5ee 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2704,7 +2704,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 3 fields\n"
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
-    "              [,processor-family=%d,processor-id=%d]\n"
+    "              [,processor-family=%d][,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
-- 
2.45.2


