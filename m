Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52901E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Yv-00049r-Rb; Tue, 07 Jan 2025 03:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XE-0000NY-8T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X9-0002zr-Rw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:54 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215770613dbso164907035ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236910; x=1736841710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lU4AAETY0OY/6zVpAJBO9tGMat7KF9t1zTzfvJrrP5w=;
 b=yQh5Wgd32jHWfz6PbPX6uXR8SPhfOnxp3MwElX8hVAR8T/Yf98ZS2TJIRKhk+QrAhS
 hR7uTQzgaPksaFFXAhg/hRIva28kRVvjCjMg4M59Tja1FRqRq/FSIFJb+X278s+1552P
 1618xaB1lSnOPC9D2Fp79okfE1tCC9w19w645bUQiGJusE6mnLEFngl515/Wl6PJ518H
 y4ppppq/uqiPtfYYjrrf567sn2fsqjDefUXd3jTW7XrP/Yn8SkBBKUsySta5lTR25/IQ
 zaTknhJickANYkMY6oP4qBJgSEv3yImwM3qbamNy2DDYyRlTxBwf1js2eGg9q0ak2ZZD
 jKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236910; x=1736841710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lU4AAETY0OY/6zVpAJBO9tGMat7KF9t1zTzfvJrrP5w=;
 b=FPakvXNS880sJD0aOivI1Iwvcm13K/0OrAAgfb8MaUK56+vps2Es1ey9SZ4QqD5eIj
 KoyhR8O8Bint3bLDzxhS+RTSt+BP5Cm0Z9F7lzokniUYDo9P6/mIcbsP/3050J/PjRvG
 XZ2Amu4nLXt3eQoASiDA0+fXDoYUTmueaAlUnlFbC/n8yv93ftzYHIile2e019nw0fb0
 rYpO/nxXBrGeVwHodNZW5kKKFAIV/C2WOwRd8enUQDCS8pX011tFJSuVtithCfvB2Vej
 f4mT2jft3gKrKmX1KzFJZXTbzFqceLmPjasAPHf9zp3s1UY9zqNjFd3hb3sOWY5hTZ1I
 inKA==
X-Gm-Message-State: AOJu0YzHAhz+qr+KAaWq6Db8v8W4SvVkkuEGcYoUv7evw2DA1AOPMZPD
 howtDQYfCXSHD9w/CkyCrL1rsulcB9oNM5fuACALRKdTrHKgguB0fQHWB/0ADHbwpQA5yOwb3/h
 a
X-Gm-Gg: ASbGncsGPoS+Qe4EvDH7+7FBUUYtYxQ4KGLY4nMM74qycJXvSaOD2+lkM2SWXuWOp5A
 Tee37Gd62RGu3H8MsL51I7vaQegB/9M7U9D7jfHqnMF2UXetbB7Uc5XUdp2tlHQKm1gFmorRFfx
 JMANLD77DumtDu33Qlpnie6G/lEYpL3T9qPJW1TPDzF8zCDiDj7kpX67H9eDRuDCLMymy/UqYT9
 ltz12gLzfIS8kljPLBbxBzZl+paD8g5lvH94lsnCK2CfcAn3LXtRqOCRvHayyaRL40tntke4PbM
 R3gVMnGzVyMaI0ZHJw==
X-Google-Smtp-Source: AGHT+IHcZ8mNhxSCCmq2W9KP1eB0ES/AU66fDue4DaLcox1Jh9XlU5V/nwkbSrKl1wtDVoFZM3ZoEw==
X-Received: by 2002:a17:902:dac8:b0:216:414e:aa53 with SMTP id
 d9443c01a7336-219e6f25dd0mr863461755ad.52.1736236910400; 
 Tue, 07 Jan 2025 00:01:50 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 35/81] tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
Date: Tue,  7 Jan 2025 00:00:26 -0800
Message-ID: <20250107080112.1175095-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Trivially mirrors TCG_TARGET_HAS_{s}extract_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 0e79e01266..26ce65b6a5 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -116,4 +116,7 @@
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #define TCG_TARGET_HAS_tst_vec          1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


