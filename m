Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E1C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3aN-0006BK-0y; Thu, 25 Jan 2024 12:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aL-0006Ah-2a
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aJ-0006nf-30
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso76632805e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706203933; x=1706808733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pwpt9wjrohdTqeijR7zcxx8QTW0iX7DDa8r/R2Jitvo=;
 b=ffEN8C6J/0/GnUh6VwPq7UqAq1k2VMI5tGwNquDViq0GDBmNPZ85MIh1UJ4YrXhdBf
 pAFOtlDj4LAdXKrNF97Z/JHaydMsjFoYCzf6bZ9mIO+DPwKl4LAarebz52Q/Gf8bv4u8
 3z9CnJg7ffEQDGvl1TX6cpW2lZmV7lQlL7diSfGqz+xv9m2ipiTFbg0hdbxnc7I5zMgw
 NchahjEkyVK99DTOI+mZZ1gk04IhSnSCypvrJDLnLGU8ctcaxv19lL7w6I/+ZFlbPk4j
 Q7RlH0BT5TzxnWE7WljXbHLWdk6OulF4dEnOiy4BIbuzMyPrawRL2Mqh+7aNHDAyfigp
 lC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706203933; x=1706808733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pwpt9wjrohdTqeijR7zcxx8QTW0iX7DDa8r/R2Jitvo=;
 b=X2KXg4vNnxZfpgveiq6Ljen0MvMfP/mO7PGu+Glq8kJBzat4SfdyexaeGWXKD/Uh1P
 rrRyTfho3r9FTdl2F5+/T3N2hg7qfusSoOCXkMbIN2osVprGB1w5DrkNn6euozryB4Gq
 9BM0fVxifcFBmYwBfrSerGP8tz8oUZ89D69MAdj9116pSawrcKNi1755TS4Uyp12EQep
 NrEur7RgsRclDbeKuAJwh3hY9pQNfb/6Z0Q++fzkdjDU7b7mz148+Nybv7d3qGvE58rs
 7+31SsiOsj8VvEzGOqIDstmfDNwsQAUhP6zVPhamO1QYZ1wJ7PSG1T24C/Es4Ad9ovU2
 uH0Q==
X-Gm-Message-State: AOJu0YwZ7DubNjoCQRfUUno+Gmwnz51hU8cNZkrvcTZhMHwr7rHbweNI
 TIt6+tPWWZPihp852AsWE3ZszZ9GWDOP2OJcYUlcQe2Qze8OdhmhvQzogh3YeBU73ZSZ2w8u8tY
 b
X-Google-Smtp-Source: AGHT+IFi4h1X/4FqYcA7zygtCKeBpB5zJv93wNRzabMViZCczgJpxD2VAaZD/LJ3PDL/hSLflIE6QQ==
X-Received: by 2002:a05:600c:5756:b0:40e:c69d:94f3 with SMTP id
 jw22-20020a05600c575600b0040ec69d94f3mr51726wmb.185.1706203932991; 
 Thu, 25 Jan 2024 09:32:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b0040e45799541sm3287805wmq.15.2024.01.25.09.32.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 09:32:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] meson: Enable -Wvla
Date: Thu, 25 Jan 2024 17:32:11 +0000
Message-Id: <20240125173211.1786196-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125173211.1786196-1-peter.maydell@linaro.org>
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

QEMU has historically used variable length arrays only very rarely.
Variable length arrays are a potential security issue where an
on-stack dynamic allocation isn't correctly size-checked, especially
when the size comes from the guest.  (An example problem of this kind
from the past is CVE-2021-3527).  Forbidding them entirely is a
defensive measure against further bugs of this kind.

Enable -Wvla to prevent any new uses from sneaking into the codebase.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index d0329966f1b..385b8247073 100644
--- a/meson.build
+++ b/meson.build
@@ -601,6 +601,7 @@ warn_flags = [
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
   '-Wshadow=local',
+  '-Wvla',
 ]
 
 if host_os != 'darwin'
-- 
2.34.1


