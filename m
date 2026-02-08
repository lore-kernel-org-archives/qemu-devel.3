Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33822EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASy-0002GX-Mm; Sun, 08 Feb 2026 14:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARC-0000du-FE
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-00008i-Vw
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:17 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-662fca4503cso2010681eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578818; x=1771183618;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EaA4KncShhMSBARaIRpHtOPczSd33UaOlsLATLzDa8o=;
 b=KqEJl1m82ChKnF4HCLJwskPL+dXFBRTV6DUMgq2sPvdOGWYXVUUdDdczJlfpyRSjYg
 eBQJQ6WXmKQdgbllqA8UNR0KcUxcymfYezPu0c72ZEUz4zVrBrCgVF2YSSqd8v8U3wCf
 li2G+IvZSIgwrgX7Dm2ES2uJiu+FT5eH/UJGPkLnV97/TY+FGoiIiV4qEM2zo3cQF+uG
 CUA0GWbaf3AG59Ki8G+1rfKN+tnVDyhuYoN2a/ZcGAbeZHmz7+DAj3g4TxANJYNAorqI
 dFbEcs1kEbk+To8kTIPoAJf65vuusJdH+KSbBDyFLZrpQhaog4cfWohkAINgxBOG/Sh4
 cLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578818; x=1771183618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaA4KncShhMSBARaIRpHtOPczSd33UaOlsLATLzDa8o=;
 b=hKoxXNBZ1OJNwn38ywIsUh0Finw7u7JY7aVPMVXCk05lCST1IX7rFEiB5Ylmr3ayUS
 k4VUXr8YGYsoug1gegB31b3ruNUjwRd9qpEbe0LzNpArEqyeINwIlWfooxnltrPjjS4Z
 X1dVogeh8cExrd4eRXVUdpItgItg3DMKpCsgKHQlAqoj94QUt9IO1frVMn40KtmV1RA0
 1x+PYUE/EbdeSupCuq63C0bRrxh4Rh1pDrC0FN8GrEg4RZ4lC0KGY8iLYL8+wQNfB18S
 cgKR+b0uPQ+sMnnGUOcpPp8A1eqd02sRe3RYdTOzpxbygFRO42cZMBleoJ2pYokel83C
 claw==
X-Gm-Message-State: AOJu0Yw3zw7UsWyMmOjK9dnW0luf78HTFddcTbYn5Wbka1MdKBkuj/a/
 jVULXJ2xd4SFiqivzJ8qKlo/DQW+5fJC7yKfKXhBn3MJi6i8iB1qgkk25nNo+ozzPMs=
X-Gm-Gg: AZuq6aJErSp9Z63/76jHFRjAJthdAeC1SDKXUCqWgrkZJ1dPVlk3NBnvO7xjczXuIJa
 Np5O3i+W40/gi36VjA3l8hetgM15e71AGEmWvdeyoHcFyJ735SJ0RhRnE07tTC7SVg6oBH2nD2d
 afBb9dd77ypb3mqeeF5MtNYbtsj53ZHZa95s3b9bWWUcY7plfQisWGAUUC2Nt7aiW5auJrTJuF/
 Bpc39sGrb/pW+cm5VT4a4+YJ3Fue6jRpsuojhFKCUNTtGslsBmeKUEQTTUisUtNh7jJ543jF4sc
 iUZImOSE9RQZyu5UMuhSryG/AIWP1b4vqSCe6a56Ct7WpE/1vaR8RTejSk07KOAYuE7zo64apEi
 lq2ma2i49xOHtrZZtXt8Co8vZENykdvsI/Qq8AArYcgz6mSgwDfOVm0CtNxdFjdFWDcoVNqBFLA
 ==
X-Received: by 2002:a4a:d0ba:0:b0:66d:f6a5:af97 with SMTP id
 006d021491bc7-66df6a5b08amr2627185eaf.23.1770578818259; 
 Sun, 08 Feb 2026 11:26:58 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:57 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:33 -0700
Subject: [PATCH v2 24/24] bsd-user: Add miscellaneous BSD syscall
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-24-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=szG/xZXrE8qd8oHdTyROrOW5mKAeC7tioEuFT6o17EU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONij8rcIncJZTU3ho71U62lolmIfKbz85HrN
 8pERfSL0JuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYgAKCRBsHNEofbAR
 ACRtEACPLSeJKOw+d7BKixqpTWdUiqUmGWjyrfK3zW3AbfNWr/3O4urYG2s1MsNKFRTbGM1lS2v
 tKBX/57x+6a67TzQo8VZBHfx3dgA+tJaL1y85dilyZHabTELkz1CoXPPmAiiVVgmW46NuKSvYET
 t9E3r8aTfsds4wQYifDT/XI5SvTfO17gmaqhUt/LLtdPR8wh1d3m+nHxeG9uXyCAUnjN5Iu/cC+
 xaEPKllhEx52qoNXUOlw1hI9dJgu6EenE039bRSoqwl1lo1ifxQPLwiBgfiGWHxxUqgi31DQ4S+
 IWZT/l4rP+iQ3DPBWMukW/zp2VP7KBVTkV6LoiDdaZUJ0xbYwqWUoeVEIf86IAy4sPCS4F4DshG
 /ji/r6CQKCHbC01B88qNhwbh56Ms2PfVRT8lhrdHlpQz30ezfmlTYdvflmckM8V0kGzPOugpDx7
 I6Mo37vi2Iz9hqUQ54NoZxqmzXS2Ya+luDyRHrfA0tXSMqQn90DOs9bbNCo13LBPoZ/3u9xDwqo
 WKi1vfjtM1Q2sVj0F0PknJaVEesWgIdnVBXnVPeaxEndWz7RMHOc9PmeUgmmnb81w5ucKFzV6Ks
 WGdbqyB/6W3u7qjvo1dQvhT+GscEi1NHcGfXjxrzd1tj21oi4Mi+7Gxfe1FGJe8hRYs/tQHjXjo
 9bSFgQfEDCWP8XQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Wire up the remaining miscellaneous BSD syscalls:
- quotactl(2): Quota control (stub returning ENOSYS)
- reboot(2): Reboot system (stub returning ENOSYS)
- uuidgen(2): Generate UUIDs
- getdtablesize(2): Get descriptor table size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b081420ee7..1acc70a2dd 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -934,6 +934,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_obreak(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


