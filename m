Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15379FA3751
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0c-0006lz-J4; Fri, 02 Jan 2026 16:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzm-0006gA-5U
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:46 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzk-0000KM-KA
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so10413254b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390458; x=1767995258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pu2TYG/+F91diJrA2qUvqaX2TgetOgZbJlelL7PNoU=;
 b=U+9NoAEygNIZZ1QN3mt0X8JGaujblsfu4Vaaq6ZZfw1/ziHCWYuMKpqrHxSGkPpDJe
 5G2E/vbQbBnudVazEGTy1hzekufJXntsIL5aPSt9h/X3Mmz+k5ZX8zQuimMl8/3t7FI7
 ZPTeQInKgrKFB0/ZuovbUn36CiHgo1ohEfPbDSbQVLjxzgQ1XSWEvlVYD78OSwUcy6zW
 No2CgLwVKk+uD3+3ir/uHwwhzkRPdH2uttDmlq/kzULPBcS+iJizo+0pu977tjz9g78z
 TSCA6N/LxZuPARdiDTUCXgj4D27Qv2v+vhyBKRosF5ba5fDZquHE36YlVhqZto3oAK4k
 WLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390458; x=1767995258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pu2TYG/+F91diJrA2qUvqaX2TgetOgZbJlelL7PNoU=;
 b=qJhT3heB/ATYha3F3G9NiusP2X9L4l2VLDuAMssLsf9U5JUCSTpYSxFA3azIwfPSDm
 WuNikIeOi5xYPFSzkohCpnB2xO9xlNH33KlJT5D4YEojdI59fB9iUIlElnOkp3cErzsh
 +rbIzk/1QzjM1X2ZsYPjdbB28sB3EpOvtVn1gwc4lf7hnhuhP2Yhyqzj2tOQUqqrHVzY
 bH6X4Br0dmuoH50DDJyJbG1GhAcdR/74ZUMKI99DbGZ1Q+rU+EpdNuE7vz1puT0jVBnY
 CPXD8mnA+6usLEZVkKRXEi2s0RdKhT6GKm1WXOk0RyBAwqQCI8Z4vrD9VzCB2LIpOo8j
 10FQ==
X-Gm-Message-State: AOJu0YzfljWW5AoKI/i6C8PRaQg8OvWzi5JFNs0xvwgYhIL1k6CwpIUZ
 /7lJngKoJUDhv1Lqzc0z96Fj5N2SgxmCaLuKTS+9nSAkfbi5jErljrYOxv2eyDVwBkYf+G62gG4
 GLznp
X-Gm-Gg: AY/fxX462YXKz2c5fk4y01nXvo/pgp1XUKsYL+KpW4EBspZxuBcXkyLfXU/RfXqO/ag
 iLZt3QUA0nbcY1hHkXbY5AuY8dOdlr99QSPInm3DEeOVig0sGYy675vRFWCWjW4Qa05yY6cLmMd
 XBnrGhXhBTQZhlh+9Wf83q576xTl/aV5VXSEVYicPsve0tw0lPgESeJika/1yPNFeBlXCTWcpAn
 udlDLTAswSa51wsUQHh9aHjGQUKq50A++INsbg9UQ+Bb21XWkFh4VlMIGS7dr1/+QSY57uwvFWP
 lvwYt4p+TtOP0ZXStnu2vmfNQCI+CH1FqyqtOIrvxu4Z5ncAP1yH1r0lPGHAIZUk6MgZKiE3vGI
 ns6mguhqdrw+FgwcyDVLz3joKWxzXkiRpo1CQ2PEZ4hiQqT0KwDWe1AZ7cv/CrSwlsDg7Ic7I5s
 pWcHGGj5q5JabXvqUficIgW5fxzaQQNEUC3hZaKfeRCCsAI5uIxoAM2S56HYbDpp22uWaRzf60Y
 UY=
X-Google-Smtp-Source: AGHT+IH4kz/oDchq7ACVeeEruIeG2hMWKlg2WdEIYIDziA/4jpQZqa+tGJMlf2RZOrYkpHcFeHzTfg==
X-Received: by 2002:a05:6a21:6da6:b0:366:14b2:30f with SMTP id
 adf61e73a8af0-376aa0ed79fmr39018810637.66.1767390458299; 
 Fri, 02 Jan 2026 13:47:38 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/11] qga/vss-win32: fix clang warning with C++20
Date: Fri,  2 Jan 2026 13:47:22 -0800
Message-ID: <20260102214724.4128196-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/requester.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5615955b6f3..74489fcd0ae 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * To prevent the final commit (which requires to write to snapshots),
      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
      */
-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
+    ctx = VSS_CTX_APP_ROLLBACK;
+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
     hr = vss_ctx.pVssbc->SetContext(ctx);
     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
-- 
2.47.3


