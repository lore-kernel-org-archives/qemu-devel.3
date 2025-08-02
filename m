Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B87C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLww-0003rm-9d; Sat, 02 Aug 2025 19:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLs1-0004V6-26
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:38 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLrz-0006sZ-KA
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:42:32 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso1825117276.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754178150; x=1754782950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVlQwNjtMgvAbm23dBCZDYeq1xNwwku3Aggvwl5C6uU=;
 b=ukx/UYgqmTymtJCnoJ6CvQi7G98zgUZKUz6C1DlXgr/x/u9JiEMZTsRk2uUbRT65UH
 80Shw2xIiDCzqmJS6hOGd9oHHjEj3+IsoFWqcmeFqb8wKT1FWbPgikUDyxFHPbKM7Eo5
 UF/jMDjW9EfQmNUvHb9pSHsj+7Sham8EiA5jl03lArgLHxKdERKguVlhimkVyr06dPm9
 5kzlIENZ1+uGWhtTt3eYyT1HLZ4CRxC8dBK3q7JDUh/WbHfGwodchblrzW47psniV5qo
 wXCzrsEgprk18u43PO1G3r6C4amLeXUia0paNmM5bDV1iMIIXxDXHu5dMDniQOBZQsUf
 FaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754178150; x=1754782950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVlQwNjtMgvAbm23dBCZDYeq1xNwwku3Aggvwl5C6uU=;
 b=iwJkUUBmjCxMtZ6bP50aOfcwG4hB5Y3SGGdkIQ02Qy+CSwqsjjLP/DqN2P04SglzdG
 +fyW5pK/mr/SmlPRRWsmT7/XEUHIH/CcMvXDs5gQhq+zjzSQbBAatB5XHMfn2YoAnHqo
 C3pi6GFRkUohXBCKVTnqX2pcmp2dcUTDtILpVMBlyxhmt1qBCjEAMFxLc880sooHa1iM
 vRevwk3cW+cXRPaRJ0a6gZxfTz936cje77LWw1C1AaCW/8ODv0NTl+bK5wecVCfbo9Kv
 Roq0uHR32JA8wxMe2IKmD4dSa1Y+8j6fMCe3THGCwn+WwfnSRPsWNcosROSu9OEjrD5I
 3vxw==
X-Gm-Message-State: AOJu0YxseLFlPpFGtnSZDqkvT53l/mZc/ud5NpoH7jmy8gRMOnuc0RD/
 Oj/TokciqEUlwvUvGcVz5GFdqxp1jHSppSKGOhs/EBQMybxe9JpI7BmemC2WE/SginC/PRhcwaK
 sSLGOPBc=
X-Gm-Gg: ASbGncvFyf7pa3H7l525ZvJPlPgLgTBFCbtDRmWMF9bxKN02vftsF/uRVgya3nrzS95
 iC8Wzl6YDt/9XFTW+5EkBberblKPNVSKFbgYHuRE45OJ5Dy0ez77PviZN6iX5IsN0DUPOST9FzI
 eg/FMHX+O6960rQQqcH6f35Wkt4lf4zf4yPd7u2534svF20mrcRCehR+Atrbpb7RXsaZhgdU+Ak
 v0M5shLI/uQGUKVW8azPsUdutc1B0LFbSoXmZRxU05jjI1PxuBOCpqc1OwjmI9Jy7tnP1BuE7iP
 046v/KnyBDff1p5tpCX+6cry1SfVeb8cBZhQ90zJ4yRqO6C6MbQILLdqJp35UIykyxMKMffyo5d
 q9VMDGCFtCdBIfDFwaFpybtWk+AZUr1kKcr7/AH/8iM32dnvEB+Tn
X-Google-Smtp-Source: AGHT+IF5iQbg12HR9p2AMt8U1Te7fBcbAkW3+9V7bHxGML+WczUYQ8QtzRGrLfRZvZDoKQdtTJblNw==
X-Received: by 2002:a05:690c:17:b0:71a:1f26:5d1a with SMTP id
 00721157ae682-71b7ed84355mr49527207b3.11.1754178150515; 
 Sat, 02 Aug 2025 16:42:30 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a423f38sm18461527b3.40.2025.08.02.16.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 82/85] linux-user/aarch64: Enable GCS in HWCAP
Date: Sun,  3 Aug 2025 09:29:50 +1000
Message-ID: <20250802232953.413294-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d87d1a16e0..e71dcdec1b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -877,6 +877,7 @@ abi_ulong get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


