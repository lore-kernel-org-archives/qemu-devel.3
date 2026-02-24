Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B7CF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutba-0001Sk-H8; Tue, 24 Feb 2026 09:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutbA-0000ku-Cb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:18 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb6-0001Kb-Be
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:14 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c307db9aso3033874a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944069; x=1772548869;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYGackA2bkmDICDd3P5+WxF3zAx2KI4dveSgUpAz0nQ=;
 b=zfmUezoLTkiJVeTiwJztWVUxP3AQavSPs4n5UfBD7FH2oLBCM2joIhLGXX97aYfFIn
 I5RGcItPOzXMWcRHIIvc+5twYfRFC+GO3FzpAoOSoCZymvCRjvrVJmh/iE77/2xiBkPP
 j/k95reKmrklexYPgcNpmNPrws5VEEIIEiYQu+VvdhLtF/DHZFElsozvn9EvsIEPlPHe
 YaklbJDI4iVYswMrRApRw/n9kZyoGCnBsWvD3Xfaet43P39Lk6X2wViJdBPjdk9icK2z
 FpKP3Y3jibL9azL1bDJYm/eEQg+l8pCBypjwgn7MMcLcuE569+2olSF5TquecA3rJ0za
 InMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944069; x=1772548869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jYGackA2bkmDICDd3P5+WxF3zAx2KI4dveSgUpAz0nQ=;
 b=IcCuNgnXd9xSkqp6nJML9hWEE1zrWB9elJshzNUZCQyYCHJ+2CKecp8wEmdxE4nrn4
 DJFUoM6TvxYbXCfFOOT0OgYStWuxj54rOwtZx77WAXt9HMDKIAn18jaZnHy9VbrBu7ma
 WaazPGldDZdqvUGnlKaq47rPDyFT5F6FwXtIrVTw8EEoqcpvzElR8kxPFUoHI4i2W3WG
 YPV7o7NWdd5cNH72QNICWFIroskhhiLq6jte/acqPl5RNUjIOjuckfa9UEDT1wqheCyZ
 yF3kgtjmYvk6K2qK4CVa0tvp0T1RvWSPwVxHLewTLJyKvaYsJtbKUhX0tcNgs0KRjZiW
 5XaQ==
X-Gm-Message-State: AOJu0YytiVbInhM4sTr7myqIn0hskDfeX0KULEEd/geXk7Wacri3XyQV
 ucllhFaGitbVaeM7MdbSDFL83LAietEGZv+f9j8hUYrdA/2O0mNYtHeurg2BZoSMJ7d11vKjZbT
 02dcp//o=
X-Gm-Gg: AZuq6aJL+C70CFs8q8UmS82hXELjjZ3x3ifaoYj9ij64ixylJnLlTS3Xka6dpfAXJOX
 TgoIeMHLjwFHX3/ky6rNQWh5cmV8NJDn05h5Cgcw3lngZyqQfMOJmntCGtGEO3xpBp3qrolwjyn
 I/LcIYHG9CAgVDh0Sky2Zh+fEGoi0IhxSGuTTzTaZOD8v3lTq/GzM3Z8h9hKqC1GmWBrOkygo4c
 nR8/ss5nhCWGZ3jHULah/PWWwr6wZC517ixR2TW79k7fNVW7KtqoSui3qpVXhoTC90Nm9D5/XGp
 MnHk6htMhENgW8rmuWKzbEBh5bi7TDWs72YJApy15PoBSP9Mv0TkB92Ehtdqf+U8FtEJ+ClZQBf
 d4GCVgIfGZCmC8ty4qm9CJaR0mIr0jM/m0c68tblKYfmgc58EO2zu7qdiH6WqneK7pn+oDWQ2q3
 v06vwufBPAcw==
X-Received: by 2002:a05:6830:40ca:b0:7cf:da7d:5041 with SMTP id
 46e09a7af769-7d52bf5327bmr5983161a34.21.1771944069084; 
 Tue, 24 Feb 2026 06:41:09 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:08 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:47 -0700
Subject: [PATCH v4 23/24] bsd-user: Add System V message queue syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-23-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=D3JiUPWJcH+meC/cZI0h7d8iJS/d6/OFbVel+kBR+zg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhosmebB18zuRS1Y++cTXrR3ZQLVTaKg9po5
 o8DVy7NYiyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 APabEACjNv+qRpKeXeaG8dOywMgAwtKuyBXDfYeFLuis9ZgYX5sVC/a/ZeEk5PKzbusPB0AtSHY
 ioIzxAa5/ws2A1RAz71IanyS/R83cD5lXpqSAfE09/4jmKbhaX+Q4LCJjHk/yiokCqu+GlI4CDz
 c8ERAFgADXkC9HGFtCuwtxeeK3TzbwL+/wSIVaUL2+h99VDC0yblJVY//oyT/tKZ/uNcnrNx6ym
 +lt5GEXIZfjSEfCY1tEiDSectYFuGhSXdIKg4+DQ5PkBgf+PmQeCYRjq7DuCmxTSL69Fm/uRY7r
 edC8hrV5n5Y1yJfzaSfYOZDKpnsFVjyjPJEsANhXplfnKMMlihxZKHgrB+XvvxcrtsALR8UXpe4
 Gv8os/HTv05ODRATDuLjV2vDoFcpnOBBpPR+l5dZde2nXmdbFwUOG514s8LakIzxOVVBQUZ6Zvj
 KyIyixqsTUDhdYcpkQBjKk+ho+1YcHBypR9Fy36Ab259/x8RVxWsPNRjFqiL4/0dCJ3oCITexga
 Na5nJ015lB+z5X3PHpWWyCvJODdJX+Tgq7xKSi96QWg4KYhndbmWu4ilHyUf0f5PZnSFr6W+Sk7
 u5RLIiGSRz0iZa0qzhPimjFGG6bdakqvSIItbNY55VbIt7CCSharwXSFq1IcZoFjwRD//dnG8ib
 +mQUcakN/8pCQvA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

Connect the System V IPC message queue syscalls:
- msgctl(2): Message queue control
- msgget(2): Get message queue identifier
- msgsnd(2): Send message to queue
- msgrcv(2): Receive message from queue

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 234bd78fd2..f39e521e42 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -894,6 +894,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
         break;
     }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


