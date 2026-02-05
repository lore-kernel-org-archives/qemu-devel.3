Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE97FECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38I-0004Ym-Nf; Thu, 05 Feb 2026 12:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38B-0004Si-Si
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0001R9-No
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:03 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-409470ad5bbso567224fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312418; x=1770917218;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zMRB5cl6b0x3xBQF2xIhi9cg3H2638SS+vUcUZl660=;
 b=XnWpflKIaea90mNlL9qxGIUb2+/n6HHTJNaFDFLqZmcpirsrFYmQm8Gen5Py8CG1k+
 b6HZimwY/k+fQyrJZyKCOHaERKH1DHl84aQ84voCjPMe3K3tJ/252AKp8MmBM8ogqZgi
 H0NO9jffwAGEmrJkLsQUVyIXm0SJS/1b68+ebus5JCS0zI4rl5roBrdj56uUav33Oddg
 HbLDwMgmDG6N5DGm+4X11x25QIB3lEP7aK4uSTTHQcuVqgcWWb5PBnfD/Cr66iT+XAMx
 A4vgNlJQ8V81N1CkNkf15SW+Fa0vd74SnySs1gYD4f9MqgqblwrFCPuUc3TUldyx2B/x
 TgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312418; x=1770917218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7zMRB5cl6b0x3xBQF2xIhi9cg3H2638SS+vUcUZl660=;
 b=qoeTTD8B1wQeC0voGgYkPLrMY0UVvO51y97c/NcHScUUTwl5yX1DjaTnQlswFSB5JA
 MsvLxDW8mK3nG5y3iPXboBAPPsV+OklzptyB5O4dYWMJJOO/ln5QCQavHFC4RgpBlkJe
 veuVtaEa8T0RkYlhWm74wova2cUQQ7DsgPFzZbUIpEO4Zmn1mxrhXpBhTAU3GbuRWJ8S
 imOoSy6Gssi9HHumZ9BDX9aiTZQQR3GuYTLqp9nWS6x00luDFtoWnmB4P/Tfwn/VTRjj
 MgWF8euFrhcpETOjGpLTBeoYfywcIKrlXdsBtedlgx3IvD0TbTBlwFebZonU4drNduYg
 WxnA==
X-Gm-Message-State: AOJu0Yx1T1P69Owq2vWw6DXGeUpFqYv9s93L+cuzxswKBbslXrFX9eNR
 Le+c8R6UNyjJ4xsDR38TtLknBcad3v+Lk5D0W2FkpjBgI4RVR6esBOT8fKtOfF54dhzQmPPHM+j
 G16Dh92A=
X-Gm-Gg: AZuq6aIeHDAiyhqnQ6h99uW4bOz07lFAdpBzMe30khY7ak91IP06FPTIXi41NQNRkir
 UYDZE+xzhCLm+GFKSoArEi8nDF2e7+G5lzHXigUP2PBn5jGhJrXW2l+JAVtY7VsLfm9ubxy0bDp
 qbP82JSiK1uw3a2Ctk1l5P9zy1xQQW/xdlaD8O486AYQKELE/cHP7oetICT2FDk0fp6MY+N1LTG
 Ppv7tAoIVgpsNWHdtnZYsIBFBIsRTbANNWKXwlGajDCI9uAKjDz3SRXP+xe5RFMjkcCLk9QYhhi
 KWURQw8inxORjMKhp0LuntG0jdFMVXu4wNFTBRZTTyGJ5mNtKpOfVursX8ZVmhi16y59bA7oab0
 xpeUXIrvp6vR/EamSfwKSdM0b7PEL791PJyB0s5vUmEJxKPg4NMPabHMsAaegADoozTMFdshp8U
 3aknUuQFL4
X-Received: by 2002:a05:6820:2203:b0:663:c5:2f8f with SMTP id
 006d021491bc7-66d09abf993mr79243eaf.11.1770312418542; 
 Thu, 05 Feb 2026 09:26:58 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:58 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:49 -0700
Subject: [PATCH 16/24] bsd-user: Add do_bsd_semget implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-16-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=mn3pAo1T3vu3XFnSQSKz50m+qTFKTmifK4AEQwgverU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbOs8cY3xJnlIJGFFHdTtjCpR2mLUBLt2zE
 LIbCq0B2/2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 ACzBD/0bhV+qUgSBcEO7lGkOn+z2wT3KKjRnzmL74u97Yd6uL+PK1AYqNIK9DBu0bsNewCh+e5T
 wVsAOGAGSU2Z29dACalEv2tEZsmX+a71O4SY5F7bNH5U+7A2rHDokMlMk2afUCovIWG+L7tDqBU
 /z8UM0ypS8kqGDcNfxtzWGOMgB+L8SeMq9+9sS7J0rabwrinZBy9764gLLjVupMNOQKFsaQanrw
 EjsnbZNezZBgeM1Tfms6gK3kjWIvNl43R0uNeLovfUfX0itwOy22Qhk3EM7XFKVqQj1XNi1+SL6
 1rulMBt5bpnKMTDSTJf6L+ggE8haeKfWXcmd7az3B+bJlKF1rUlEkIgZpGY5xFwSC2KS9b8Gtjy
 gfJ5w4OSYbPdrXpBxDxi9hXlAdd8GSOixJYLmS/VFMWsEmP2+WtDcQkD9rRukxX+/UXxagJzllW
 oRdMBpIBvs+fnhv+gVklCExNicefeL9wkZr3jYzlRHW+vbb4ybiyB3SHzUvy0heLomzv4acAJtQ
 g41IPm5U0YaSb+RJh9yoZ+nKAQrzK/InyDrllIAy8jMjoDWo8mkFa+APWKMKaSy8TCVFTRl5n3w
 BsIZz9WamyX5e45VxIUgLA7GRKU8O3cCVZd6lvH51TvFME2dq/S3pXiOUCcpY7t9HHp4O37pm5S
 phW4uE5dtcTtAdw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of semget(2) syscall to get System V semaphore set
identifier. Converts target IPC flags to host format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index b722c63437..18520548fb 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -77,6 +77,18 @@ out:
     return ret;
 }
 
+/*
+ * System V Semaphores
+ */
+
+/* semget(2) */
+static inline abi_long do_bsd_semget(abi_long key, int nsems,
+        int target_flags)
+{
+    return get_errno(semget(key, nsems,
+                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


