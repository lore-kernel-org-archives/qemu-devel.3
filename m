Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D3C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwT-00030O-F7; Wed, 07 Feb 2024 11:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwR-0002yg-EB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwO-0006CG-Sl
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ff28388a6so7630565e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323907; x=1707928707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZEnJqnRtjHTYADU54FKGw8u/qLIoqp7a6/Lc+0JhOI=;
 b=gfcUw6FdsXwGE1FD/EB8khiaSdJWBLoVSCkCwzub66Pt9ORycJw6qomC4Ax0KEkTg+
 5pVXQwcuZxwr4HBP0vFIKWf02jbs/vDZ/Zslg+EyWGXoLuhpbBJKR+FfnTBc/Iy09MqB
 k/Vcl8lSdoG0koikOSBl1HNosyZTkED0pKCUY1qxahZoTCMCb2U/r674Y+v+ezb32kxA
 Wv3ZbEnZTGYFd8YxQqRerN5ELJR8so8nNUZyVAXvQme0IwOzHt/gvhgM1YSxXmJD/f3Y
 4ECXlDQGaprGub9HHWStS46XBRUGsOZQxJYk/Pv+Va8NX25tYLSK3oC3y1sK9dTqk/pV
 352A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323907; x=1707928707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZEnJqnRtjHTYADU54FKGw8u/qLIoqp7a6/Lc+0JhOI=;
 b=Rc+oORgAvldGKjsUd/36/udxOjq32YKfCos1CV0JVccCu9m88WLCTeCgWPrasgHUXB
 KyvVC34gJQNFV+m+ImU1MCTxhopXHw+WM2Zal0Z0gImywsvYX44+9EyEdNL5k17VJZlv
 9vV7uqfmFMxR/ehfclzQjfp4ms1E95tKVEUhLSkdS5tzCob2odJTuLn/JmpUDMVgZdOH
 y7WSI7xZ1JfvL+v6syNc6q11r3ofHeEY1jO6JuUYdsTzQPd9ZMSZNR4Qw9BfCzr+3AkD
 WWbUn5LyAlHVJyQvz+djbXLipZVPFDBJa7g2eTO4sxu96fy2GodgeOxAwVBPD+TQXtPK
 wo1w==
X-Gm-Message-State: AOJu0Yw0FaBl7ioFoeMh8bDMECloRdFwc3Vbr9RtwwT7vHPxdZXwQRCX
 rEFA7dM1zkJ3B5bnM93BvJ9bENpd1vn39tOtRuqqFNur1lUMkd0kvJ/q4OHkYsY=
X-Google-Smtp-Source: AGHT+IEs5VzykUrPZZ/a8E0suhAGYeAe+JVPGaxzI2YNKpjCClE233UfaCR0f5RWvU2Zj+QL6HW2hg==
X-Received: by 2002:a05:600c:1553:b0:410:2496:ccdd with SMTP id
 f19-20020a05600c155300b004102496ccddmr522761wmg.27.1707323907446; 
 Wed, 07 Feb 2024 08:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2twQPA/imKU8TXnjh8RXEOe87TDnJV7LjaUystw7Iipdfu4tRqFIR6jmxZLiZvq8iJJbbUyUtf4zHNMB+e5LW+khol3VhtpuFOqOUoMbF+Ko03I6/r0pPjSAi88ffV7sVliFGwb/eZPufsf8tCuUYnjAh3OSskNSFkveT6EDZnMUBxAVjRlepPxNHnShJRn4PAxzXvomj4+CEuuqmNKkaZ2xJGAkNDuCj+6E2siTpTHVmlmd803nIe2OOGdGmF2q6lvmZ6r6bkk62g8fNRCw4JlH14azS1pNP8cC8mQf7FwSN9zcG4lLVKf5B9Ekhrv+o+Itxh1PI5Jro2/byTmwEGc5FRkH1Eb6B6cqzY701LO6UFFaFuh17a86Z3T8+0E8nrrxERyZ8pXL29bE8FYLrqY25Hy8kdElo/ajUHWuovys/uUIbtFVhhUtGBd/3XtAtNgPBlI0Q5X/Md9xsDm60zH/AOhMRye27qoo6Fiprj6T9WjnolNhmvELVKO+G9TFQKJKh0BCWSfjdZbNOIZLZ+4zHTshILfRU+VUcd5VWRuvow+/9w9pbyt4NFOY3hspWqanUGC0lnuDKrrSufHDhu74Xccrhvx9w9mQl0PCYa+HjGCS3rn2RouU7i28kQCH49irLXqLCiB0ewuQHIvGHN6YuNk5xk5chcipTG/0xgjy1P3t/iWKx704X1yCDuwB0yOHbmaA8twCpazeb8Kt0Fe+ReQ8FNk6t6h3dlkV91fTvdgdtSu1Po+NKixtglHHqO+TqKeueteFkLYiJwFWA1gEkgfp+hrHfo4g/YQOFp0Lp+7HiD3yqsny4W6jiFe4qAnoFonlWW4OQwdl+U+pi1MNw8g7pAT5JgiL8
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b15-20020a05600010cf00b0033b4e58746asm1809148wrx.69.2024.02.07.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 292D85F7B1;
 Wed,  7 Feb 2024 16:38:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 11/14] gdbstub: Allow specifying a reason in stop packets
Date: Wed,  7 Feb 2024 16:38:09 +0000
Message-Id: <20240207163812.3231697-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming syscall catchpoint support needs to send stop packets with
an associated reason to GDB. Add an extra parameter to gdb_handlesig()
for that, and rename it to gdb_handlesig_reason(). Provide a
compatibility wrapper with an old name.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/user.h | 16 ++++++++++++++--
 gdbstub/user.c         |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index d392e510c59..1fc43e04af5 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,9 +10,10 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig() - yield control to gdb
+ * gdb_handlesig_reason() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
+ * @reason: stop reason for stop reply packet or NULL
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -24,7 +25,18 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int);
+int gdb_handlesig_reason(CPUState *, int, const char *);
+
+/**
+ * gdb_handlesig() - yield control to gdb
+ * @cpu CPU
+ * @sig: if non-zero, the signal number which caused us to stop
+ * @see gdb_handlesig_reason()
+ */
+static inline int gdb_handlesig(CPUState *cpu, int sig)
+{
+    return gdb_handlesig_reason(cpu, sig, NULL);
+}
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/gdbstub/user.c b/gdbstub/user.c
index dbe1d9b8875..63edca131ab 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -121,7 +121,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig)
+int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -141,6 +141,9 @@ int gdb_handlesig(CPUState *cpu, int sig)
                             "T%02xthread:", gdb_target_signal_to_gdb(sig));
             gdb_append_thread_id(cpu, gdbserver_state.str_buf);
             g_string_append_c(gdbserver_state.str_buf, ';');
+            if (reason) {
+                g_string_append(gdbserver_state.str_buf, reason);
+            }
             gdb_put_strbuf();
             gdbserver_state.allow_stop_reply = false;
         }
-- 
2.39.2


