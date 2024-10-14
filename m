Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72149CF2594
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0If4-00042L-Iw; Mon, 14 Oct 2024 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Iep-0003yz-T3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:37 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ien-0006UI-No
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:35 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso683326566b.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903032; x=1729507832; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=16r80Tpf2UqmGEMZziwBekWDVj8Uzy9i8lU22uqLVds=;
 b=Rim9k7mpflH6getRgfy3Cf5coJVusyQ5boDlTvhwyKkWtTUNuSeuCd49qMDn6XAr9F
 Br2HfSwvCLdL58RbRFJU5ujyg6iGB6RyT3pcKerb2RsdzlqL4nZm2tieA2eY44R59oLV
 3vDAuW6u8E1nwr7oQ0KAVph+IvOK1YZ/Jxq4yYlBg0FKEOhMCm+CaCqAA0h2QUhvW4l0
 I0S6CNTDXVW4RQKlCVH5EcTsedPke7YRYPhmBXi4rHBWsHoUKlIdXzzOrcyAGOLaOHmI
 BLdz2AbP96GFNKCDSghztZ6RiBA6tJqCHuyO7bwzLAdY5vxs7Xz4bgTvBsW5Va31TLGy
 VUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903032; x=1729507832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16r80Tpf2UqmGEMZziwBekWDVj8Uzy9i8lU22uqLVds=;
 b=Xj/jk/ozX6Psb0zZj8lQAMUZsBpX+TghcmCZPTIuDStwsATRTOsFfA7QrJJihN+vXy
 QwEh4tQhoAqvaGtcX8pk1H15IG4exhLsLBpYRyNvO+VzH7m20tdjsMg7kLNQUgqp8/hO
 P7yRIrd4gnsPYKAkYp7el/j1LRE8xJTadjlwx4Wf/U8KyIBwR2DDms4nuxffgD+ejbgj
 UlD25f0/lwU5zl49iUEwmTJ9vVVkMnR8kBRGRpM6vBXC7RejyqHbV0cMl9Dl0WC0H2Ry
 a00YP0C7WPBAMjR3974YJlGRXI5T1irKH+ljpYirzomAAXvt3DyBF6XBS/f/Os1Src6R
 5xGA==
X-Gm-Message-State: AOJu0YzSWKiajJrGV9ZfULdnMwLcbreuR0KoCn7tpxY7ILworesS+tn4
 GqUlgLtGZJoV0t96YosbgNyG8yQG9pZmHhUJPY3a9CjxkvwKc9ssE9axzxNxgbs=
X-Google-Smtp-Source: AGHT+IG/qD3yjVPPMTbOAtDK7aCtF3uw9gxt5+pO0OcIRpYTuXxd7XnTEgH7fYzDeMbCnI48c6PBgw==
X-Received: by 2002:a17:907:7d92:b0:a8d:3338:a48c with SMTP id
 a640c23a62f3a-a99e3b20e9bmr794150266b.7.1728903032141; 
 Mon, 14 Oct 2024 03:50:32 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0b25226esm165504466b.59.2024.10.14.03.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:50:31 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Oct 2024 13:48:56 +0300
Subject: [RFC PATCH 2/4] arm/tcg: add decodetree entry for DSB nXS variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-arm-feat-xs-v1-2-42bb714d6b11@linaro.org>
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pf0H/LuxIUzJj3moViZHCxuJnlPyFIH1W6tdHF0Oiug=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EUGQxUVAwUFVyNmF3U3JkREwxb1RBSTVtZk9VCjN6R1I1dXQ1YnVSdzM3YTRY
 MmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnd6M2RRQUt
 DUkIzS2Nkd2YzNEowTjJoRC85Ymo0NFhzWlFPa1M1WkExVmI5ZFFBRUNjUWR4OWk2OFEvSGZJSg
 pEMFhQTTlYWXAwQ2J3OW51dzlpNm03OHFTZ0R4ZmIyK0R6djNvL1Zhazl5TFdtNEF0VW1nc2ZVc
 jgzdnJDV2FkClgzMTVCN0dMWDQwL1luVGF3bHl6MTlFaFhRNENTYnB0Z2ZlWGowU0xtdC95TVhD
 TjZXbjU3SnF5bXNGdlBReGYKSmM2RGJqcFU0MWl3aWt0Y244ZERSbllEb2tyU3Nkcm9NSFVjMFB
 GV0xrSkxVWWpQTnZTNWFnMHFPSWpOdlc1MgpoY3o1RTdBUCt5dlR2SFB4NWxOYTFHUDIxZlpYam
 tpVHV3aHh6dHMzem4zTTZQU3FubldybE54RnUrNnA0eFRpCjRWRExsSTh2Q2ZSV21rWlp2dHVwU
 lF4L0hlZVhzc285OGRaQ1V0V1ErRENyYUlHTzZhcm1RYnhBcDE0QUVvUnkKSVI3dHVJaWYwRy8z
 ckY2OXZ5dE0zcWhmdEVTRUJRbUtEdnBJU1cwZXBQem8rcnhrUDkvKzlxZDRPM0VSL1JMQwpJV1o
 rdytLRGI0b0ExdFVwK2s5Ky9rQ3QrdkJLNytLZnp5RVBQbnV6VFJSS2tMOS92d3g0SU5IQTZTdk
 hCV2pYCjZxYWR5ZHA4T1dLRGhueEhnNWJnNFRrS3JIWXdiajdRNE9SNkNCVTM1V0xvNlMzb2lwT
 nREbitXZXFBaWpYaUYKTHZpa1Q2cHFYaEJvajM0UXFJOTNNS0lMN3dIenpQVlE5alRGREVuTlVo
 Y1VmZElhMkRHWHlnZWFrV25PcHVodgp1cFhhVGpVZ3BMdnd1SGY4ZnhSK3M0U2J6RDVscG91SWl
 BTUdKZDFtM3Z6TWg5TStHK2N0TGVjL25WNWdRb0F4CldYY0Mvdz09Cj1VWjR3Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

The DSB nXS variant is always both a reads and writes request type.
Ignore the domain field like we do in plain DSB and perform a full
system barrier operation.

The DSB nXS variant is part of FEAT_XS made mandatory from Armv8.7.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/tcg/a64.decode      | 3 +++
 target/arm/tcg/translate-a64.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 331a8e180c0b14e2abe3ec641a867235574316f7..c4f516abc18224932082cdf3e7530edc7a304bc1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -245,6 +245,9 @@ WFIT            1101 0101 0000 0011 0001 0000 001 rd:5
 
 CLREX           1101 0101 0000 0011 0011 ---- 010 11111
 DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
+# For the DSB nXS variant, types always equals MBReqTypes_All and we ignore the
+# domain bits.
+DSB_nXS         1101 0101 0000 0011 0011 -- 10 001 11111
 ISB             1101 0101 0000 0011 0011 ---- 110 11111
 SB              1101 0101 0000 0011 0011 0000 111 11111
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 071b6349fc38802a62f4b4056e369c4d8b1ecf94..85e71599203eee62b4d22a0b10ed676cc815dab6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1959,6 +1959,12 @@ static bool trans_DSB_DMB(DisasContext *s, arg_DSB_DMB *a)
     return true;
 }
 
+static bool trans_DSB_nXS(DisasContext *ctx, arg_DSB_nXS *a)
+{
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    return true;
+}
+
 static bool trans_ISB(DisasContext *s, arg_ISB *a)
 {
     /*

-- 
2.45.2


