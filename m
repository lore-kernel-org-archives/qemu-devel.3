Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A101EC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlVc-0007GV-OL; Sun, 16 Feb 2025 15:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVb-0007Fy-00
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:59 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVZ-0005gm-ID
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:58 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cfc79a8a95so8651015ab.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738693; x=1740343493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=R5YkOFB6sctSm8uDd9ewoLd6APfZT9X89d8Jqho0v8qt9OLyclU2wplyDDPjLnwFUa
 P3jOk0VZxZ8pJ91bD+DWUp2uISd3n192fFggWywVVTWoTvVYmyT9mvDjzLR2nBHXjuCN
 /WmHr39kPop3/MgBPhxVJprRhmkaJdjx6zgLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738693; x=1740343493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=XUbN8rygPWv+FNCfvvu+PwMHr4el6eXr4HwmtScNjxY5s5SejMfIaekJBX7HZla18Y
 pQ4Us1JSgomx3u47H3dOAfEH07S2QB0BiTotoXA5GqYetgW5ChY0zauFtU7AvcOrXmxW
 sfOOYqFc3kJQXCu3MmSNUnyF/GHg9hpd57zdFRmlCD/FZetysnFBaMhkV3E2WNF0JJtw
 8MOiakvAuOld+rgDG2+ZvLxsu5w3+M1MMEU4UKfgy24H1asl5GxedHKkzKOK07gEWMAr
 dqyJAHo66sDdwz14clbOcFlrx+hS8B89KucAskNg05VjFW71xobB1rNaHcKYDpMEvN/J
 jmkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+QVMQFlJilW3XWuNcrYNgNytLEXHco8zeqTEnpAD5Wa3Qns+fB523De/PfbA1DAlF/FVv+nfZeri6@nongnu.org
X-Gm-Message-State: AOJu0YwH6wajpVoHK2bAGYxc4hR8g/Df+NhWvBeXJ2qH6unV9Gy8ECGA
 TaG5BvF4vTvd9ENOH9gk/6OK0cNfg+hpJDtgMqTg7XFxt8jqx9/ffofnQDxaeA==
X-Gm-Gg: ASbGncvMn1YSTQDfi+2PKVW9NGcyUSMfvFKZfBEXiYpJMNKbkGU6TPN7X/GGvb7oFM9
 WBL8qqfHuBQ6TmWM8wGSX7YK3vZP+fXP4CmO6O1msco0bodinBBbByJNuWq37YynvdSdIOIRaQC
 czcsn1ZuzlQlHwPLoX5bhIrmKji1sh2tEbIBNICF0FL/+nfWOJdfr2fMmLUtcT0bbynZZausr15
 mdm6ytFQlwdhgmv9mCwx4M4f80fIC/p72LKiqVAl4uxe3h9sluXwtwqmaV/lPox/DqXTd4NZpoI
 7SjnYWFhsG1jXF+4/j4I6pmUgAfM8shq0RgBFcS2EadvuraxtALQ
X-Google-Smtp-Source: AGHT+IG1lIlV7TAI2qw+8rSe0qDw8P2CfBy6qkfganzRJzifaoZrwlkPUC7GKwykq9D/qATeTDz7hg==
X-Received: by 2002:a05:6e02:1446:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d2807b0baemr60764185ab.2.1739738693288; 
 Sun, 16 Feb 2025 12:44:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] x86: qemu: Enable dhrystone
Date: Sun, 16 Feb 2025 13:43:48 -0700
Message-ID: <20250216204421.3560012-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=sjg@chromium.org; helo=mail-il1-x136.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0


