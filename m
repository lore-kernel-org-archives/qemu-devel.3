Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE10EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhw-0000BL-5y; Thu, 12 Sep 2024 02:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhp-00081c-HM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhn-0003Uo-RP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso5187445e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124006; x=1726728806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/ZEidfxNqICq7WM8b0XlnmkWjSILpdbASTELUMU3dY=;
 b=l3HdcZPozICfqf1Mr53aNrvyK+Y4gwzGmDhFdEzcFjqGiU6SPwv8DTTvjz+kQ1a3g9
 vvvZO39u+ApqPnP2zzOLBGeF8KuCaj+Uhl3KyvUfSy/cVtsFAwRRT/bg0ah1BLK9OeK+
 DAcJ81omqxl611Gn4mP05nnWf6LLWXfYQEv0eGH5ZBAwSY/10h50WHbUewwzCklVzhWj
 5dNcyZWTAFQfNFCnIM0fb+dQRdilXLQjPFGmz16l15Og8+lpCGSRe2HbXcThus/ko0tn
 yNSjsPcvdy6aUjMSalnn2pzi9zhqBvwtZYd4tIPfUXht22ew+70iUM3iExWbstmFVuym
 aHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124006; x=1726728806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/ZEidfxNqICq7WM8b0XlnmkWjSILpdbASTELUMU3dY=;
 b=M/1CvG9i9kuQfg6Yq+x2+3ab2MajQ2KNxSbVEr1qJu6gzUdkwsFBXsGwRi3NB8at9R
 wTdUPf51qJeWx5ijSXXZLIynKHXTS6/Bzv1U1abmf8FTaSJl6tMJsiuTcJ9MBc2mOf/Y
 zq9uAdvghVgdoHQPXg+GsPzePwjoTWJwBP2f8VIbR5g0hfSNo544MLhlTfdPvDQ4lLhl
 uGsMsIsWy6FNHJ+Vp2XE5t9FHIJv620YBjDyhS2O3vUvVeKs6D1R0G10EJCD3fHJKTFu
 sEuD9ytnIq4UjxLdtLDZ4md8dDBrRXZLTWaf0JvcF65Np/6BNYbrfzMJ1DBUVeFbWNz9
 +gWw==
X-Gm-Message-State: AOJu0YwthuB7QUqcjpcXS/3tZMKDKQEtqYe8PGf5IM/SlrMJ01EwVNzI
 D4X0uWGjNH7dTPGcCb7EzhDAIs907G7YUS+34jBLjkij2tzvrOvce1HktalFrnJ5RJLmF4x87sh
 Y
X-Google-Smtp-Source: AGHT+IFZUo7enOXoUsmDKR7ocQmuv7sY3P1Lbn7auOyPA9sjmt2xeu2Iz/9yd+CIeDcsrgNJTUHm7w==
X-Received: by 2002:a7b:c453:0:b0:42c:de34:34be with SMTP id
 5b1f17b1804b1-42cde3436e0mr9697815e9.3.1726124006044; 
 Wed, 11 Sep 2024 23:53:26 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8162dsm162743385e9.29.2024.09.11.23.53.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 55/61] hw/misc: remove break after g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:24 +0200
Message-ID: <20240912065227.67848-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            g_assert_not_reached();
            break;
          | ^^^^^

Solve that by removing the unreachable 'break' statement, unifying
the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-29-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/imx6_ccm.c | 1 -
 hw/misc/mac_via.c  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index b1def7f05b..fd5d7ce482 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -301,7 +301,6 @@ static uint64_t imx6_analog_get_periph_clk(IMX6CCMState *dev)
     default:
         /* We should never get there */
         g_assert_not_reached();
-        break;
     }
 
     trace_imx6_analog_get_periph_clk(freq);
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 652395b84f..af2b2b1af3 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -495,7 +495,6 @@ static void via1_rtc_update(MOS6522Q800VIA1State *v1s)
                 break;
             default:
                 g_assert_not_reached();
-                break;
             }
             return;
         }
@@ -556,7 +555,6 @@ static void via1_rtc_update(MOS6522Q800VIA1State *v1s)
             break;
         default:
             g_assert_not_reached();
-            break;
         }
         return;
     }
-- 
2.45.2


