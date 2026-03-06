Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5DFFCB609
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWff-0004rS-MN; Fri, 06 Mar 2026 10:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf4-0004WE-2b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf2-0002js-Bu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so91114665e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809215; x=1773414015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rU++RBZU+fmL8WD1pH8gqsuKdHir+HDXpF1JUF63s+w=;
 b=qdDBpKTv97HnDoUEAdUUMasIFCFJaN9Y/lTbgcTrqIIkoOVmfjiZINwGbmz1p//8/S
 hvTTR4+6ddTUmV2etTvwf/SnY/TY6fvxns/fEHo3s1yuItOipi56WFwwtcgaNydg9UrD
 qlI0wXrziEiBi7QOeb1fLAj6uv+v1V3piMH88zaOD51U8iuX9riBowr0Q6lcJWNxtpgJ
 o/o0bWrYgc7EJiSCeiGy8JMKKhftxJt6T4NkWdea3MzCBR8pfTl/rNhnIZ0nNO7V3CUB
 94MIiYPKSY05WGtU7RVhjMvaxgIc3p5dBrynTebLCCMOVSl11W+pBpObf+vznZ9W2Q7s
 8xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809215; x=1773414015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rU++RBZU+fmL8WD1pH8gqsuKdHir+HDXpF1JUF63s+w=;
 b=YY1cVY4/38YxW5b5bbJciZE1HxJSL/bdFx7rHLBbA+kGAtLqUP15ztj66Ce914W0qq
 hxsGKxTFG/RXGvmxcAjCNj3fJq6iZO4McHOI8YP11pkBFurl4ROyEURCqEujwKbDjfQv
 R3AeFH3TQi3X6b6dx58qNAYU3RI2YHKFV0lBGrvHjwKiF+p8qpxWvHZK1XvafOLO80fi
 AxHDtcRoOicc/PYNcPn+j6qfTViyf3PePghEYXrItEABH3anxr4KmmXunHsg5iQr08gb
 beDcYVPzHLEyzK9WQta5kTwNiB8PWX09mkGXSzAC4uYbmmWLEsuBzDfbl5k7XRVBvew3
 o04g==
X-Gm-Message-State: AOJu0YxtSfoXEMozDvQmOy/5PL9cwq0H55LDl+o2mm/pX+IcrPa3xn1d
 2B7IwP1jIq3i/AZqvgi0zJFEBE1EPxTLC2yH/74IKdrreHxfAuOdbaL0Mn6FOfp4m8Fx7wjfCnX
 eZ/AE
X-Gm-Gg: ATEYQzwd4xkU+qN/2qSxnEFnzUPWsrpWUzCMIRl/jFCXhU4M9DNX/4wFpy5sQB9iD2H
 RHDDrcZRdqZ7FkFaLEfHOjvrQ/D380vdZwPJJgObsU3qQjWMsL38s6RH7LgNYC8F4k0DXMqfmOh
 tQQ/5eENiHS7fQfX9LV8WRFQCkFUOoTi9yWwPqTD7pMXqCwsNSaWGAkFhip57yF6R9/joyKqmtf
 3iY8L+bDqHRgl1DVl/kA9+FU4PBkilLWpgL2osQZTraZJ4uv+58EyM7W4O5qAmsAaSQVOajq3IZ
 us2OJ0WbeTzHWpqTLA8Cf09YPpJpy+kwKATmct9HyzBFQWvTly9AoTeVfeoHlQKweeHR2cVxSIa
 4Hr2e8TBIaGtlvpx4Aru95tGCMfrxjiIEn/7HPqqNzh7LJbVYsUEyuN804pbQ3iks6ir7UpOwUG
 eKVrZfY9esshcs8js++DnAYL1pzbazYkUGLRRpClZqgdWkIz114MYhC7JIRDVlckeIbJ1O7VCgc
 qrt35Rr2UwQyAzYBXAGau+751y+myU1cDhc1dW17Q==
X-Received: by 2002:a05:600c:8b2b:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48526715213mr35369995e9.3.1772809214787; 
 Fri, 06 Mar 2026 07:00:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/49] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1 is
 unsupported
Date: Fri,  6 Mar 2026 14:59:22 +0000
Message-ID: <20260306145939.2162189-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tao Tang <tangtao1634@phytium.com.cn>

Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
and return CERROR_ILL when stage-1 translation is not implemented,
matching the architecture requirement (IHI 0070G.b, page 176).

Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260304142344.3341444-4-tangtao1634@phytium.com.cn
Links: https://lore.kernel.org/qemu-devel/20260221101733.2995020-1-tangtao1634@phytium.com.cn/
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index af7a54143f..068108e49b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1407,6 +1407,15 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 break;
             }
 
+            /*
+             * This command raises CERROR_ILL when stage 1 is not implemented
+             * according to (IHI 0070G.b) Page 176.
+             */
+            if (!STAGE1_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
             if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
-- 
2.43.0


