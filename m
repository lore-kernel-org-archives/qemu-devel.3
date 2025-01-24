Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EC9C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdf-0008MV-5T; Fri, 24 Jan 2025 11:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYp-00052n-QI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYn-0005fW-Th
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso16645755e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736172; x=1738340972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BuQK6peoOcUuSYgPPaEbb7kN/jXaBJX91yp1YJkWkF0=;
 b=VGOtBfrHPXIzxVWbYN9BQcqY8KJYvHoRlAS/JbEWK3qLAqsaICzG8azx09heF47Xry
 c4BkfeKkQcjIGMLKkkh11h60vvIV+5dwMjN+qh6SeAoYrXbcCEKxeffqQQqm9WMGVK3s
 Kflzmgz7VsJBNF8YugWOMvMWRxw/EPB54RaK6SdXWhJ96wooHWih2R8xdgMZoVXjo2nV
 bbr6B/a6R7LqtXhi7g6FnNvr8MqTY5t6AfqYGa0bR214w7NeT0O1gvOewnl7aDvydWIw
 lYL0EWTGn/J2BXjGdpVXOSWBQs3xatoo2hGvxgMpgdT+NHbGjHlk0fxKGm+okGQJ/jfO
 4ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736172; x=1738340972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuQK6peoOcUuSYgPPaEbb7kN/jXaBJX91yp1YJkWkF0=;
 b=M6q+AH+37uIdw1D4jT2PcqvqRnTg8s8VBwGIUm3Q/q2BOINiC/0PEa3KVXd0k6ixeY
 TjPESrYIz+LK82AcAFuge08FZat6ZAwln8fZY+5MNDBunY5aMkERvSJC9FqgBlZB2BM0
 7XqxnyGDViEek9TsgOqCDhfV0EU5vXcsz4lrDW/ItIaRq4EVLTmRNomXpF7iyh2AZsgM
 Ax0w7zv31A1x/izw33kIp01Ajt2w54syWOVREQ7S8oHSzWSw9pEc7qldMpxYXtwK/08x
 /huxE8oBlilqoZewkGEPcHQ0nJ2NgIQuVwzLMarPSa/c31/wOHS9UmcszN02xSenZs65
 73HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9qih1BU6y9iyOOu96pNWj17inC0X5I3LXQecaBTscd4UWL5lA5UgoduTxqb73lf1uiR77zVZ+ynoP@nongnu.org
X-Gm-Message-State: AOJu0Yym8BXFw63kjagAC1sIR3/HqDiJjDo7jA2MbebcFv0VSPH2ViW7
 dABDrFsQRZVVJOxdr8lBvxE0tmKJ72ULciy+BzhhmfK59CTYjf10TCT+KDaaStg=
X-Gm-Gg: ASbGncu2RLmRHLIHoe+zKVmpkoKS0HyUjwrxbNPtQ47noXvRhYoQYMr/B6Ak9h/M+Cl
 +fzsY1qFDEgDIsFD61gLjaidAs3R2OE67vmzYyUS0tISMBgHSOSHqzasVTd6vc4P86LTASnklRT
 t0iQJTobt2BW7k2VkadRE0faWAx4QSH9+gzrnVzfBbPofvSgxsP3WlcYifcvszV8yfcwgF0nuJp
 Krd6RN9tmvbTsRw+xv7qo0/NKVLgj8MG1/Z4sB1//FUJGIpaEAZ4bS2i75SFHVjYGrD2E7lku45
 ZjoZqMnKVHU=
X-Google-Smtp-Source: AGHT+IFtFzHtTCBva66MlwAH+wqO0plM+mQtGh4fXGAl7LKrDfsN5eueMZKnG7J/0NVh5xsryxmugA==
X-Received: by 2002:a05:600c:3b0f:b0:434:ffe3:bc7d with SMTP id
 5b1f17b1804b1-438913f01a1mr325246635e9.16.1737736172422; 
 Fri, 24 Jan 2025 08:29:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 44/76] target/arm: Handle FPCR.NEP for NEP for FMUL,
 FMULX scalar by element
Date: Fri, 24 Jan 2025 16:28:04 +0000
Message-Id: <20250124162836.2332150-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

do_fp3_scalar_idx() is used only for the FMUL and FMULX scalar by
element instructions; these both need to merge the result with the Rn
register when FPCR.NEP is set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6dc5648cb1b..d3575ac1154 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6307,7 +6307,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element(s, t1, a->rm, a->idx, MO_64);
             f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_32:
@@ -6317,7 +6317,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
             f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_16:
@@ -6330,7 +6330,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
             f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     default:
-- 
2.34.1


