Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C60606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c8gJh916
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDM-0003fi-IV; Mon, 02 Nov 2026 08:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDF-0003QP-Ls
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDE-0002Kw-0j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso21004015e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626594; x=1794231394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7mJxSl9hEehX76DF71T1icFKPtJFCUvWiJ0CWSu2boo=;
 b=c8gJh916wd3zWSKp1ZWXSa2Otf6uLJPvGND4ImDm1nCAS0msOfRM2sIqBIEGEm7vwh
 7O1MPy6ZV+Ic3yt/oFwmRFSnUCxKpHALUSOr44dKnE29JYbEXzuaWu7ondO01Yu+0gyE
 YsW5dfHIZtZ9ep1maRzJ67GA8/poXLNCv7pmKEGqFNg+Uk3cmWDmVR38Uxbxy+9XI66M
 vGG7md+muhw42a2cXty/2oChcM7YbbYkv75x3TyUradwT4sku0z3zWPKDXFSXo7Mok+l
 xOc4dhOR6QWNwL4TFrYQ7m0Ey98InQJof6bdo53M2a5+kv+Ld3DtM+pgGB0mooeIOcjq
 qGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626594; x=1794231394;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7mJxSl9hEehX76DF71T1icFKPtJFCUvWiJ0CWSu2boo=;
 b=Izpkaae4JSZ+0EKvogAZjR/OxSR0IFhkuObVztgZoA36AYSk52UqvkVu2sV75kWcOB
 +1NSbkNvf7JWMcUuoy/ZLjeSsSV+C6EvdVxiu1paisRi5n7y4UmxteoLvoadpuMiyfOe
 bY6uHHopxPy5Fc7frX0z7ZJSOrxCfcjQ7ExGCztGJnLkOrxkgMmDDUMYbJiAZTHJZf4p
 I8CbmCAzSVuM27g4stNi/R3czTi9g4R8nRU0YRxXeNeG28e31cZu7YFcBXEHq+S8OMek
 byf4FiINLRYCsepWXDEUlXUjBS/SE9Qy6PvVSm9AjMxKrPReNc2Na3lsyXvHRDNzh4Rs
 HIJA==
X-Gm-Message-State: AFq9FYK38cuehlrl+PDlcjQXHYX/WPa+zv2Biq4cMKpYWloLD/kS/EUt
 o7h9BBqrWtuODSPnuJP7I9sy7KBuyoraYKYG4ENw15OIUE07Jm/yDTz9zTOTsUCPTxAVrBIoABc
 JjIsb2pg=
X-Gm-Gg: AYBFou2+EMK2Kqks0XErOw0PHbUOITZ2dDTnustcS4+7J9QlfQuLYcNh5OTpsfTBSe8
 mL7pDlmasE64TGIn0iuYJuWDEAWyrshH7VSu589pRhFyLlZha4eYCiaoUzrcTbrHU6nZDp0/dS4
 T5cFepuXDH4UdTRpftpl81dPNokcvSKzZ3h89hlETI5W8xE9HGIQ5wJRxuLIlHlLGoM0sqEAAYz
 Mk+3B/8CHGs4i0ZYqmqb7+eaykYBY/LyRRUX0XNrCMxeh4U9TXe/U5uCQo6a22UBhrX2WDLFLYT
 34i7ckywbKV75qk25bjnUoxVz9UZCVROF77RbDH39uPr4NMs/N+DGV/unR5V0gzpK3xynmRLuRJ
 Cw4IpkNmm9Nk8ZSbm69Jm37iHyBXmaqLnxSlmJCkO+H7TKtL4XOKXpudBzp16qUxdh5AiYYu2Zx
 2tV8FvN7Fg8r2dHSi19sgc+1RhW6HoGNdM/mkAVhzbVklkG3STEl1D/4fhYzRUgfvC8noWwMZpq
 DG8w3JxlpyVtKW508hxL4Ro/2uhghgizg9yArRSEApDnw+9yskT27wwteLd+ajZKOwyCqFc0Uac
 JiVKrz58rnW8X/V47cdUwLIHU+xE750NZQQsl34ro7KocSq1bcMpZeaUE6DVD514YanDU8fQ4oJ
 Uipml2DGdPG5Y8RKji8kHDhUpzoAzjfQV3w==
X-Received: by 2002:a05:600c:3554:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4ac1737c474mr219205455e9.17.1793626594289; 
 Mon, 02 Nov 2026 05:36:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/47] hw/intc/arm_gicv5: Regularize spacing in config_readl()
 switch
Date: Mon,  2 Nov 2026 13:35:40 +0000
Message-ID: <20261102133547.1375701-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In this file we don't put blank lines between cases in switches,
except that for the switch in config_readl() we've written it half
with blank lines and half without.  Delete the blank lines to make it
consistent with itself and the rest of the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/arm_gicv5.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 2b08f8feec2..d354ac6b992 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1469,53 +1469,41 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         }
         *data = v;
         return true;
-
     case A_IRS_IDR1:
         *data = cs->irs_idr1;
         return true;
-
     case A_IRS_IDR2:
         *data = cs->irs_idr2;
         return true;
-
     case A_IRS_IDR3:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
         return true;
-
     case A_IRS_IDR4:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
         return true;
-
     case A_IRS_IDR5:
         *data = cs->irs_idr5;
         return true;
-
     case A_IRS_IDR6:
         *data = cs->irs_idr6;
         return true;
-
     case A_IRS_IDR7:
         *data = cs->irs_idr7;
         return true;
-
     case A_IRS_IIDR:
         *data = cs->irs_iidr;
         return true;
-
     case A_IRS_AIDR:
         *data = cs->irs_aidr;
         return true;
-
     case A_IRS_IST_BASER:
         *data = extract64(cs->irs_ist_baser[domain], 0, 32);
         return true;
-
     case A_IRS_IST_BASER + 4:
         *data = extract64(cs->irs_ist_baser[domain], 32, 32);
         return true;
-
     case A_IRS_IST_STATUSR:
         /*
          * For QEMU writes to IRS_IST_BASER and IRS_MAP_L2_ISTR take effect
@@ -1523,11 +1511,9 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
          */
         *data = R_IRS_IST_STATUSR_IDLE_MASK;
         return true;
-
     case A_IRS_IST_CFGR:
         *data = cs->irs_ist_cfgr[domain];
         return true;
-
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1538,7 +1524,6 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         v = FIELD_DP32(v, IRS_SPI_STATUSR, IDLE, 1);
         *data = v;
         return true;
-
     case A_IRS_SPI_CFGR:
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
-- 
2.43.0


