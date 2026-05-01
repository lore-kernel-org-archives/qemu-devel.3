Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8942EFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIku6-0003ya-Mp; Fri, 01 May 2026 06:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktw-0003uq-49
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktu-0008Hy-3W
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso13607015e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630512; x=1778235312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J0oxSzs5Xj1EPDKnDrGEtP3tZDOMa7Ke42A06bFU/R4=;
 b=aGaq9gckjXkiNBMeoGrbJZ4gqvf3Jb23J1dyk50zxabl+6nG52q3KPAj/lteGxL6Gs
 gpx39xQwvjCuKqN9soY1JFEqwyG7ObIGuDJZzPh+L83mH1h1j+SG/7LbOrhzjY2bAvB5
 MZrTyt+hxjsktxroVFns2e0GsZgo8snTZ6fcCivy/U/Wb1wDqSRUIuKynL9zqRBsNCfT
 69cex9sNWTTqlXRUQ06/uggiAoP6qLe1rNQsn9iRo5xsD/WXks4yWV0ZD6HWrvfAGrJH
 Y5gIlbmHV6rUUbJzBJkybbU+mZDHHOs2TjSZ2Hk3rtEXI+3UBbB+S8EMb0eiQmDmt63E
 N0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630512; x=1778235312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J0oxSzs5Xj1EPDKnDrGEtP3tZDOMa7Ke42A06bFU/R4=;
 b=BQ3eKtDsh+euLYRWXTixwC+EmTTI/fR5H76GUyAbA+7KnRsVHyLggcVEceM2BHf2SE
 v7ahaY+Lcv4Q/MTxtrokin4FN7x6o3YroLLvegFp7KboJDDSp/5uK0utfIo5dtL3vcOv
 dy/daWqor40tC6tMuoOiMs1OEcXwxyI6M5/ulB9MOiGKb+NgGVZv3iR918r2wyHXhwzq
 8ZfYMdcfF1nYBidRgx5BCnZpY8AHji0C/B2gcUSJ6dPUULgY2dreAU1lCjsh5S5qQTsd
 JYsaqcNTAEVPMLzD3t5rKmsRrBaa3qicisAjagS2K2j2wdjfX0Jg3BqmhAcDEZQLwckN
 mo9w==
X-Gm-Message-State: AOJu0Yy92Htdi29f3A8vVmfU1mdmgLz2y52ol982nGxVMUlqlAJNzGJ/
 q4XeShD3/fsnBebTCqBUI6+rI1sIOAa0LnhZKWQ3cU52OZ+xc3s07myi1abgvUBeuhM0HAHuJ3q
 qidzk
X-Gm-Gg: AeBDiesrB2NOwjOhmo734VeiAUDVFTmFNuiqUnBoUf6Ld2+9tpTJakMjMBd164iqj1r
 F5Sw0N4Hb04rVuT2mwbTwnwRZ7x1TPXNoUAMyI1F/MBmxlCC/1Q3hOtF0eSDozt+GoiFQZuIBtX
 eKgLz12/JsZLzwbdvqbRDURu93/vzbSU/i2A7V4Yvs8se6dsS+hPK0qbd4c3gwPX+mQWHcrBPuQ
 Ddi5vubdg6hXcI6NVQ7NOt1lZcYub52Hi3G7AFGSXB+BfhssYXc1ZVm9U5K2vF9T6NDPft8Ajb0
 tTiOdvsMD3vgk7oHKfVc6407Voj60lNjbLkUK8y3eqaWo5AEE3Rxm7dcKWuOxDr6GBMa+Q03xWf
 GD3u3GAjfrYKOzMpSQ7gxbrYTpwdGpV28wgYWiJ44rxEHM9DPmzcdAIOHiMDaty57bNQ1efY7l6
 SMHruRTbJ/wPjF4sP1VkbKahBEyOn8KsacUD1WRnFb2rPvRYwuyf6E9hSkk0Os+OkXemaHQZbKh
 o4wX435VL6gyTlJer6ABH9ln19LpYLNInSjZywT54xKI1ACKg1L
X-Received: by 2002:a05:600c:e41a:b0:489:1ae1:4eb9 with SMTP id
 5b1f17b1804b1-48a84532408mr79466475e9.28.1777630512468; 
 Fri, 01 May 2026 03:15:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/28] qemu-options: Improve description for -smb option
Date: Fri,  1 May 2026 11:14:42 +0100
Message-ID: <20260501101505.3485916-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pali Rohár <pali@kernel.org>

Add #PRE and #NOFNR flags to LMHOSTS example line.
Include information about LMHOSTS path on Windows 3.x.

Windows NT 3.1 requires #NOFNR flag for successful hostname resolving as
described in MS article Q103765 because qemu/smbd does not respond to
netbios name verification queries. #PRE is suggested in that article too
and decrease delay on Windows 3.x for the first connection.

Signed-off-by: Pali Rohár <pali@kernel.org>
[PMM: Expand documentation to note what these flags do, and
 clarify Windows LMHOSTS paths for different Windows versions,
 based on discussion in patch review, fix existing grammar nit]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e780bc2ac0..98e39a1ad4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3415,7 +3415,7 @@ SRST
 
     ``smb=dir[,smbserver=addr]``
         When using the user mode network stack, activate a built-in SMB
-        server so that Windows OSes can access to the host files in
+        server so that Windows OSes can access the host files in
         ``dir`` transparently. The IP address of the SMB server can be
         set to addr. By default the 4th IP in the guest network is used,
         i.e. x.x.x.4.
@@ -3424,11 +3424,20 @@ SRST
 
         ::
 
-            10.0.2.4 smbserver
+            10.0.2.4 smbserver #PRE #NOFNR
 
-        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
-        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
-        NT/2000).
+        must be added in the ``LMHOSTS`` file. In this line, ``#PRE``
+        requests pre-caching of the mapping, which speeds up the initial
+        connection on some Windows versions. ``#NOFNR`` is necessary for
+        Windows NT 3.1 to tell it not to send QEMU NBNS query packets that
+        QEMU does not handle, and is harmlessly ignored on other versions.
+
+        The ``LMHOSTS`` file may be in different locations depending on
+        the Windows version:
+
+        -  ``C:\WINDOWS\LMHOSTS`` for Windows 3x/9x/Me
+        -  ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows NT/2000
+        -  ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows XP and newer
 
         Then ``dir`` can be accessed in ``\\smbserver\qemu``.
 
-- 
2.43.0


