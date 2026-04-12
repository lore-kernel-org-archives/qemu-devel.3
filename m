Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD4E937ED
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxI4-0006SA-Nu; Sun, 12 Apr 2026 12:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHn-0006Pl-Ip
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:48 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHf-0004U8-Jw
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:43 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-471618e202bso881308b6e.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009813; x=1776614613;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GYx14N1uigAfO7+nUb6U6pmUr1t2J4FtSk0xX48qd80=;
 b=ruWU3PSNjBoFKCHiDmxyEE3doMzXCbWmis1e7gqd03OoXDoRfvEPhxxOEseCj1TddH
 bWL8JtcMeZve0Tr81rTP1WqUd32yygdi2Z5n9cWkAoMxHhDsPvbfqNk21pyN76fir5+L
 NmGl/pllH0wq9oHLwxNhEy4qVcAFFlJLviq6yI3KIoHq8I0URkVxcFYS64QxTpKD0EXB
 xq65FoUV06c9UtPlqiPZ6V3vbgdsRZSH/YFQA53yQiWYOR85qdOyIZ7I78REc35cn6Tm
 GM7ZpkEg9fHLc/PxeJJOxSp/DzXl7U6VAgc9uM5pFs0utB6AbvG060s5Q4EkPkhj0UWM
 ysgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009813; x=1776614613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GYx14N1uigAfO7+nUb6U6pmUr1t2J4FtSk0xX48qd80=;
 b=Jdz3jhYBzk9jNjr5dhJg/Qzk9gJ3d8yT/tC9gRhJkxeiT9vC+IrnLRSeSrrecfXfwc
 iPr7VVq5lxKE0un3ugpc4m168BrEpraG9BdffCXs1RLbPz//IyChuaxxuxBJu8GAoy83
 K6ojucq3W8lK8G4kdpfo7NN4061Ni2MgxWslx+dqvutpvEQ6qeakTrzLVk/Ix+fmsWfc
 WnZ6Oqd53UGDOq7/fNnqOzlLHB43h8Rv+KTKTluTXMT+GUItb63aC+qpzBgNBC7AZF6L
 Dfryum0zuvmmX+15wfMs5EeqNJeUoHhfX5h091iAm+C/IwCfpJbl8+qbF1fcAaLqVHy0
 vwOA==
X-Gm-Message-State: AOJu0YwMnkI8J+bDR7C0dQ+Ud2kZBgKu9kMean267OzP+oW5bnnpN2FU
 bS9eDsXK4JdqqvBSto+DlXr9hUs01OD9kHUDoKN9VBTnn58GHw/7jUlSlcxq2prHPwI+KZPTB82
 XEVJOWqc=
X-Gm-Gg: AeBDiesriCSPorPCHnbE8S7EyxWYonSv550eRv3PHedil1ipXBLmXptSuTQSHTNnBk5
 RaKhMI6QryUiyIG6MR2EL0zyIcSt/8Ccw+wOU5fu0SE1m4U+CHaex9VsU2lGh05F31IGQb5TKa0
 q++4/hqYoUtyDYTqyowSwJV87vif2KX+NcqKO8c3XK2HeHN7h4Wj2wH9WaEwO3lHCeVFCte/MJU
 PhpYDE1CPTtQv41R8JunwqMMj1oe9+ToCn+LsGyVntiBrYJctPAe+0bG9+xq1MhsyBX/LvW9xgc
 RsknLZ0J5lb2/B0wurRl6F6QjKVlkUgijid0zxj340jzYa8h4KkBNRnrwNPAzBDzpV75lichI/l
 xv0eccRvBopN0iceqq9siD6UyZllUz7j2f08EnSpAWzPzSZSx5JBOK0ieIXtR9C0fyrLLz0WizY
 1Q0uXxcZskjQ==
X-Received: by 2002:a05:6808:6ec2:b0:467:cda:f15d with SMTP id
 5614622812f47-4789e71bb4emr4719965b6e.26.1776009812584; 
 Sun, 12 Apr 2026 09:03:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:24 -0600
Subject: [PATCH 01/17] bsd-user: Add FreeBSD tty ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-1-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12750; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9PqYfDLp+JL+z2iqielsRW/geVLSgR0zAZWSVrUXOvk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IfZm/P+bAn0JfFCGFvTaXi427u9wxLCueq+
 kQRiusew6CJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCHwAKCRBsHNEofbAR
 ABgYEADaTg7ErAMQ6u1nygmp7yIIm67zRGfUysF8LJiei4/cRDEs4NiLNYxf6EhDcdnAYawL4EZ
 mTGNXz/7MhSJeuP8DqdGR3wSA+KjB4Z6GW+/e/T6w4pJFkThJfLrn3cozqhtCbojX7VdlRxH+SI
 ZQdyRoTueplk1diVf+alDMnCQRFafaPOinqDlnDNuBklky1q/Jxng/YQG8O0I2EhulPmRUVnIXP
 Zoz4SvdLAGFNIzBR4fH4VjabID8lF4CIFthDIlSFwkEJSlxMcZ7fS4nq+IcsqhuPyu7pNmoMY8g
 zfn0F5mQRVACetq2yXOkbOmjfdDWV1KZEXGlm9v/qtNszdwmP9KDU1DTD891OPw9i+bpAYzqo+Z
 dVkn3zE5U7TmFvYLUq0AuI++uTm9+dH1FmCE6gBUZ2UpBrPcZ84UZJOzlRrJt5suTCa/FoJfMRi
 2JAe6naBkGrMwP4XTMRJ1Ac12aiSX22wZ3tGV/B5kVHmQv1IIGm+BCDPDJcOWm9TumhXm4xtZui
 SzPotFHTucBL8pNv32NhdziOQW1LGPfhUBn4yVfCh1P0buNvxjqaWwBdOqeJ63J4n7UxVMSFsxg
 LnYSl7iMlIOwnNpjO0w6ATWk2eWHqZ5Jbe1ds/UIJDU2miO5VLzF5xYm8PLfUNJ7ur9R46xR/ED
 NbeVESjNteTd7oA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x232.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-ttycom.h with terminal control ioctl definitions including
TARGET_TIOCGETA, TARGET_TIOCSETA, window size ioctls, and the
target_termios structure for terminal I/O control.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-ttycom.h | 237 +++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-ttycom.h b/bsd-user/freebsd/os-ioctl-ttycom.h
new file mode 100644
index 0000000000..94ffa06558
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-ttycom.h
@@ -0,0 +1,237 @@
+/*
+ * FreeBSD ttycom definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_TTYCOM_H
+#define BSD_USER_FREEBSD_OS_IOCTL_TTYCOM_H
+
+#include "os-ioctl-ioccom.h"
+
+/* From sys/ttycom.h and sys/_termios.h */
+
+#define TARGET_VEOF     0   /* ICANON */
+#define TARGET_VEOL     1   /* ICANON */
+#define TARGET_VEOL2    2   /* ICANON together with IEXTEN */
+#define TARGET_VERASE   3   /* ICANON */
+#define TARGET_VWERASE  4   /* ICANON together with IEXTEN */
+#define TARGET_VKILL    5   /* ICANON */
+#define TARGET_VREPRINT 6   /* ICANON together with IEXTEN */
+#define TARGET_VERASE2  7   /* ICANON */
+#define TARGET_VINTR    8   /* ISIG */
+#define TARGET_VQUIT    9   /* ISIG */
+#define TARGET_VSUSP    10  /* ISIG */
+#define TARGET_VDSUSP   11  /* ISIG together with IEXTEN */
+#define TARGET_VSTART   12  /* IXON, IXOFF */
+#define TARGET_VSTOP    13  /* IXON, IXOFF */
+#define TARGET_VLNEXT   14  /* IEXTEN */
+#define TARGET_VDISCARD 15  /* IEXTEN */
+#define TARGET_VMIN     16  /* !ICANON */
+#define TARGET_VTIME    17  /* !ICANON */
+#define TARGET_VSTATUS  18  /* ICANON together with IEXTEN */
+/*                      19         spare 2 */
+#define TARGET_NCCS     20
+
+/*
+ * Input flags - software input processing
+ */
+#define TARGET_IGNBRK   0x00000001  /* ignore BREAK condition */
+#define TARGET_BRKINT   0x00000002  /* map BREAK to SIGINTR */
+#define TARGET_IGNPAR   0x00000004  /* ignore (discard) parity errors */
+#define TARGET_PARMRK   0x00000008  /* mark parity and framing errors */
+#define TARGET_INPCK    0x00000010  /* enable checking of parity errors */
+#define TARGET_ISTRIP   0x00000020  /* strip 8th bit off chars */
+#define TARGET_INLCR    0x00000040  /* map NL into CR */
+#define TARGET_IGNCR    0x00000080  /* ignore CR */
+#define TARGET_ICRNL    0x00000100  /* map CR to NL (ala CRMOD) */
+#define TARGET_IXON     0x00000200  /* enable output flow control */
+#define TARGET_IXOFF    0x00000400  /* enable input flow control */
+#define TARGET_IXANY    0x00000800  /* any char will restart after stop */
+#define TARGET_IMAXBEL  0x00002000  /* ring bell on input queue full */
+
+/*
+ * Output flags - software output processing
+ */
+#define TARGET_OPOST    0x00000001  /* enable following output processing */
+#define TARGET_ONLCR    0x00000002  /* map NL to CR-NL (ala CRMOD) */
+#define TARGET_TABDLY   0x00000004  /* tab delay mask */
+#define TARGET_TAB0     0x00000000  /* no tab delay and expansion */
+#define TARGET_TAB3     0x00000004  /* expand tabs to spaces */
+#define TARGET_ONOEOT   0x00000008  /* discard EOT's (^D) on output) */
+#define TARGET_OCRNL    0x00000010  /* map CR to NL on output */
+#define TARGET_ONOCR    0x00000020  /* no CR output at column 0 */
+#define TARGET_ONLRET   0x00000040  /* NL performs CR function */
+
+/*
+ * Control flags - hardware control of terminal
+ */
+#define TARGET_CIGNORE      0x00000001  /* ignore control flags */
+#define TARGET_CSIZE        0x00000300  /* character size mask */
+#define     TARGET_CS5      0x00000000  /* 5 bits (pseudo) */
+#define     TARGET_CS6      0x00000100  /* 6 bits */
+#define     TARGET_CS7      0x00000200  /* 7 bits */
+#define     TARGET_CS8      0x00000300  /* 8 bits */
+#define TARGET_CSTOPB       0x00000400  /* send 2 stop bits */
+#define TARGET_CREAD        0x00000800  /* enable receiver */
+#define TARGET_PARENB       0x00001000  /* parity enable */
+#define TARGET_PARODD       0x00002000  /* odd parity, else even */
+#define TARGET_HUPCL        0x00004000  /* hang up on last close */
+#define TARGET_CLOCAL       0x00008000  /* ignore modem status lines */
+#define TARGET_CCTS_OFLOW   0x00010000  /* CTS flow control of output */
+#define TARGET_CRTSCTS      (TARGET_CCTS_OFLOW | TARGET_CRTS_IFLOW)
+#define TARGET_CRTS_IFLOW   0x00020000  /* RTS flow control of input */
+#define TARGET_CDTR_IFLOW   0x00040000  /* DTR flow control of input */
+#define TARGET_CDSR_OFLOW   0x00080000  /* DSR flow control of output */
+#define TARGET_CCAR_OFLOW   0x00100000  /* DCD flow control of output */
+
+/*
+ * "Local" flags - dumping ground for other state
+ */
+#define TARGET_ECHOKE   0x00000001  /* visual erase for line kill */
+#define TARGET_ECHOE    0x00000002  /* visually erase chars */
+#define TARGET_ECHOK    0x00000004  /* echo NL after line kill */
+#define TARGET_ECHO 0x00000008  /* enable echoing */
+#define TARGET_ECHONL   0x00000010  /* echo NL even if ECHO is off */
+#define TARGET_ECHOPRT  0x00000020  /* visual erase mode for hardcopy */
+#define TARGET_ECHOCTL  0x00000040  /* echo control chars as ^(Char) */
+#define TARGET_ISIG 0x00000080  /* enable signals INTR, QUIT, [D]SUSP */
+#define TARGET_ICANON   0x00000100  /* canonicalize input lines */
+#define TARGET_ALTWERASE 0x00000200 /* use alternate WERASE algorithm */
+#define TARGET_IEXTEN   0x00000400  /* enable DISCARD and LNEXT */
+#define TARGET_EXTPROC  0x00000800  /* external processing */
+#define TARGET_TOSTOP   0x00400000  /* stop background jobs from output */
+#define TARGET_FLUSHO   0x00800000  /* output being flushed (state) */
+#define TARGET_NOKERNINFO 0x02000000    /* no kernel output from VSTATUS */
+#define TARGET_PENDIN   0x20000000  /* XXX retype pending input (state) */
+#define TARGET_NOFLSH   0x80000000  /* don't flush after interrupt */
+
+struct target_termios {
+    uint32_t c_iflag;   /* input flags */
+    uint32_t c_oflag;   /* output flags */
+    uint32_t c_cflag;   /* control flags */
+    uint32_t c_lflag;   /* local flags */
+    uint8_t  c_cc[TARGET_NCCS]; /* control chars */
+    uint32_t c_ispeed;  /* input speed */
+    uint32_t c_ospeed;  /* output speed */
+};
+
+
+struct target_winsize {
+    uint16_t ws_row;    /* rows, in characters */
+    uint16_t ws_col;    /* columns, in characters */
+    uint16_t ws_xpixel; /* horizontal size, pixels */
+    uint16_t ws_ypixel; /* vertical size, pixels */
+};
+
+                        /* 0-2 compat */
+                        /* 3-7 unused */
+                        /* 8-10 compat */
+                        /* 11-12 unused */
+#define TARGET_TIOCEXCL  TARGET_IO('t', 13) /* set exclusive use of tty */
+#define TARGET_TIOCNXCL  TARGET_IO('t', 14) /* reset exclusive use of tty */
+#define TARGET_TIOCGPTN  TARGET_IOR('t', 15, int) /* Get pts number. */
+#define TARGET_TIOCFLUSH TARGET_IOW('t', 16, int) /* flush buffers */
+                    /* 17-18 compat */
+/* get termios struct */
+#define TARGET_TIOCGETA TARGET_IOR('t', 19, struct target_termios)
+/* set termios struct */
+#define TARGET_TIOCSETA TARGET_IOW('t', 20, struct target_termios)
+/* drain output, set */
+#define TARGET_TIOCSETAW    TARGET_IOW('t', 21, struct target_termios)
+/* drn out, fls in, set */
+#define TARGET_TIOCSETAF    TARGET_IOW('t', 22, struct target_termios)
+                        /* 23-25 unused */
+#define TARGET_TIOCGETD TARGET_IOR('t', 26, int) /* get line discipline */
+#define TARGET_TIOCSETD TARGET_IOW('t', 27, int) /* set line discipline */
+#define TARGET_TIOCPTMASTER  TARGET_IO('t', 28) /* pts master validation */
+                    /* 29-85 unused */
+/* get ttywait timeout */
+#define TARGET_TIOCGDRAINWAIT   TARGET_IOR('t', 86, int)
+/* set ttywait timeout */
+#define TARGET_TIOCSDRAINWAIT   TARGET_IOW('t', 87, int)
+                    /* 88 unused */
+                    /* 89-91 conflicts: tun and tap */
+/* enable/get timestamp of last input event */
+#define TARGET_TIOCTIMESTAMP    TARGET_IOR('t', 89, struct target_timeval)
+/* modem: get wait on close */
+#define TARGET_TIOCMGDTRWAIT    TARGET_IOR('t', 90, int)
+/* modem: set wait on close */
+#define TARGET_TIOCMSDTRWAIT    TARGET_IOW('t', 91, int)
+                    /* 92-93 tun and tap */
+                    /* 94-97 conflicts: tun and tap */
+/* wait till output drained */
+#define TARGET_TIOCDRAIN     TARGET_IO('t', 94)
+ /* pty: generate signal */
+#define TARGET_TIOCSIG      TARGET_IOWINT('t', 95)
+/* pty: external processing */
+#define TARGET_TIOCEXT      TARGET_IOW('t', 96, int)
+/* become controlling tty */
+#define TARGET_TIOCSCTTY     TARGET_IO('t', 97)
+/* become virtual console */
+#define TARGET_TIOCCONS TARGET_IOW('t', 98, int)
+/* get session id */
+#define TARGET_TIOCGSID TARGET_IOR('t', 99, int)
+                        /* 100 unused */
+/* simulate ^T status message */
+#define TARGET_TIOCSTAT  TARGET_IO('t', 101)
+ /* pty: set/clr usr cntl mode */
+#define TARGET_TIOCUCNTL    TARGET_IOW('t', 102, int)
+/* usr cntl op "n" */
+#define TARGET_TIOCCMD(n)   TARGET_IO('u', n)
+/* set window size */
+#define TARGET_TIOCSWINSZ   TARGET_IOW('t', 103, struct target_winsize)
+/* get window size */
+#define TARGET_TIOCGWINSZ   TARGET_IOR('t', 104, struct target_winsize)
+                        /* 105 unused */
+/* get all modem bits */
+#define TARGET_TIOCMGET TARGET_IOR('t', 106, int)
+#define     TARGET_TIOCM_LE 0001        /* line enable */
+#define     TARGET_TIOCM_DTR    0002    /* data terminal ready */
+#define     TARGET_TIOCM_RTS    0004    /* request to send */
+#define     TARGET_TIOCM_ST 0010        /* secondary transmit */
+#define     TARGET_TIOCM_SR 0020        /* secondary receive */
+#define     TARGET_TIOCM_CTS    0040    /* clear to send */
+#define     TARGET_TIOCM_DCD    0100    /* data carrier detect */
+#define     TARGET_TIOCM_RI     0200    /* ring indicate */
+#define     TARGET_TIOCM_DSR    0400    /* data set ready */
+#define     TARGET_TIOCM_CD TARGET_TIOCM_DCD
+#define     TARGET_TIOCM_CAR    TARGET_TIOCM_DCD
+#define     TARGET_TIOCM_RNG    TARGET_TIOCM_RI
+#define TARGET_TIOCMBIC TARGET_IOW('t', 107, int) /* bic modem bits */
+#define TARGET_TIOCMBIS TARGET_IOW('t', 108, int) /* bis modem bits */
+#define TARGET_TIOCMSET TARGET_IOW('t', 109, int) /* set all modem bits */
+/* start output, like ^Q */
+#define TARGET_TIOCSTART     TARGET_IO('t', 110)
+/* stop output, like ^S */
+#define TARGET_TIOCSTOP  TARGET_IO('t', 111)
+/* pty: set/clear packet mode */
+#define TARGET_TIOCPKT      TARGET_IOW('t', 112, int)
+#define     TARGET_TIOCPKT_DATA     0x00    /* data packet */
+#define     TARGET_TIOCPKT_FLUSHREAD    0x01    /* flush packet */
+#define     TARGET_TIOCPKT_FLUSHWRITE   0x02    /* flush packet */
+#define     TARGET_TIOCPKT_STOP     0x04    /* stop output */
+#define     TARGET_TIOCPKT_START        0x08    /* start output */
+#define     TARGET_TIOCPKT_NOSTOP       0x10    /* no more ^S, ^Q */
+#define     TARGET_TIOCPKT_DOSTOP       0x20    /* now do ^S ^Q */
+#define     TARGET_TIOCPKT_IOCTL        0x40    /* state change of pty driver */
+#define TARGET_TIOCNOTTY TARGET_IO('t', 113)    /* void tty association */
+#define TARGET_TIOCSTI TARGET_IOW('t', 114, char)  /* simulate terminal input */
+#define TARGET_TIOCOUTQ TARGET_IOR('t', 115, int)   /* output queue size */
+                        /* 116-117 compat */
+#define TARGET_TIOCSPGRP    TARGET_IOW('t', 118, int) /* set pgrp of tty */
+#define TARGET_TIOCGPGRP    TARGET_IOR('t', 119, int) /* get pgrp of tty */
+#define TARGET_TIOCCDTR  TARGET_IO('t', 120) /* clear data terminal ready */
+#define TARGET_TIOCSDTR  TARGET_IO('t', 121) /* set data terminal ready */
+#define TARGET_TIOCCBRK  TARGET_IO('t', 122)        /* clear break bit */
+#define TARGET_TIOCSBRK  TARGET_IO('t', 123)        /* set break bit */
+                        /* 124-127 compat */
+
+#define TARGET_TTYDISC      0       /* termios tty line discipline */
+#define TARGET_SLIPDISC     4       /* serial IP discipline */
+#define TARGET_PPPDISC      5       /* PPP discipline */
+#define TARGET_NETGRAPHDISC 6       /* Netgraph tty node discipline */
+#define TARGET_H4DISC       7       /* Netgraph Bluetooth H4 discipline */
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_TTYCOM_H */

-- 
2.52.0


