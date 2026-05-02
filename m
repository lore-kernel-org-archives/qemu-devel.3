Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D732CD342E
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsL-0007qk-F0; Sat, 02 May 2026 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsH-0007pz-Rr
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:30 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsG-0007BZ-2a
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:29 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de4ed0593fso1693508a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741886; x=1778346686;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ybp5p160OfZe+6pwqfSLXO+0E11b8tht0nGSt70z0AI=;
 b=bPhm8GOWRfCupymuooWvt5oZ+/1I8jh+lIKlVik9oLI8jhOvyzJEJszmMVVzOTviSa
 H4O8N2ThV//dkqzWKyhYsIF7A99+U3sVOxf2l16pY+gVhVl8wCWbTq6DSNpAwu4/aJjZ
 sZbIVLKFLAt5zdzZ5awRp8dxXCJF4DqiSK2UzTj9WM0fIUeI8ao8BwzVocb0Slh2A+za
 o1UxruF3kW+TfWOtHTLUfoRW/hWqxvQbE7CbxFm1BhdY9er3hSl5gCJU8CttnKGpoa+8
 Fq3+0+YrAkPqn5odzEVQSw2X4E4r+LR/IPWUFkMtaEiQ9Es7WZmk420+/OltTrTLlx0f
 /T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741886; x=1778346686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ybp5p160OfZe+6pwqfSLXO+0E11b8tht0nGSt70z0AI=;
 b=JY3MbB5Li0ki2jpOGWmnXWzJ/Br65spyYzg5yzgKsw/ZcI0Sr+I1jo9hl5U7rh+FEO
 pgl/IFPDbUzAGZQ7d1A8pfrCdjWo3gu4VGs+eFtZNoFUQmnzw2caHxcLEviv87dmlbaK
 E4z7yYAFUJ766B+POfiiR62HM3M8gJ+B+gVJT9H9ZO4R5DUR3OIpwDMFJdXJwC9GpVHM
 CY4yea3lBjWBSB+Ncy9T6+ejVYpKCdyE+FApAs18KuJhvFHkXZjJ3/63mi9HbOkmiNfS
 0j3AUn1IEwp6EoaXknA0+R8wov97/ZyhiLiKXvHY2k3JLR9nSX+oTQf2543Wf2XLY0L0
 w4CQ==
X-Gm-Message-State: AOJu0YzGbBZTH35BaRAHQI3kU+nefWFFnJwuRNN9WDQf1DFUmtfD/PYp
 2sTDl5eP0p+62LHjvKFou1IbHoe0PSQZtCDdg7kqHDYLIwlOcpMai4ydxtKbDYTBwAdkSWIAScB
 f4E6mrGo=
X-Gm-Gg: AeBDiet6QlGhBqjiYV0lY1em9cjj96BpgtC1N1cLiwJ92zeX8omYZU6kxoZHIFKeKv3
 ssaMKY96Q20ciAv+n/4aWBsDhyvIzh44ddijQFlkJPg+mdUy9b90v+ateUg1IdPMUFluJqyqO7n
 b88W4MIIy+q/4ZSsIGyeIcc+geoEhi4tHc2Za1x1ipsj0Yg0HLCXrVayHcKDeJIoDD7bi7/+8WI
 VlmRLrucK33BykZ0mzp2B1+jLEkV1Yx6B/dj0+7UWqzyKcveIOCJ7cR0P4jw5PkPEXbbcqk/ZzS
 r2rXp1Kyjf72vSzMkFVonHCysbnF0zy31tMcTS07/4ykSBtEoU9F/FYtEef9/coaeOLZTyd9WMA
 +LLIniOgzh6bn6fFBxlI5EkB3y/KuHInTVjWGEzsRtgQ3J/GurhUnupRo41j5/E3+1QFeqUYHzA
 gN6zq7t5WdAlPxE8EL6NfA
X-Received: by 2002:a05:6830:83b2:b0:7d7:5b78:ef31 with SMTP id
 46e09a7af769-7dee12bbcbbmr2279707a34.12.1777741886676; 
 Sat, 02 May 2026 10:11:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:30 -0600
Subject: [PATCH v3 09/19] bsd-user: Add FreeBSD ioctl command table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-9-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>, 
 Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6982; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=I1zUZcRoN0AavMrbb0busjGq8VSBnJ7JiP+9/NBBMOI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QQnWEQTEoYNMdLJN8d6o+chiQ0TfpnQLPH
 F7I2OsS+OKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AK5yD/0delKKIEkTVfzn3jVy2TsZFutyrq9dzwNj2nkpE2XvgHh8/Jh+DdNWJRxkjW5ngMzoQHt
 fHfTKZLF+QJQJyKb8nJ+jqzBbwYG5SlIrq71Zs0sdWg9O+4jOvwLjCvLDeAHxLpYx0AGRIAU5rp
 kQU8R/Mywj5CIAFNHsW/3IbhHKqW9IXmt8sPc7SFrxtQddltNT5T6oXs4E4+8Ndy4Ku2P2EurZm
 hqXdoyzPyzZin4grOEdN7nROsEkXVzxODd+cGPbTvG5wANdlhatitG7AUaV3oHYmaLV4XpPxoP4
 4HlLpwMxhpUHvYSrcKXdWXL5J+D6/PhA1bFjZu4bFsbRw0Mx3Cbs+9e43iz/A1snerxmN/P4yr4
 PgnxmRhXsCQL5F7jcT0x8EBST44+aMFBw8Lv+rb0n6zhhwNjeVq40ctHLT+Q0dV8Ikr+FNtfpJ1
 DNr5VgLBmtdKo9Rj0lj3Z8GyLBMi55fMgLqcr7LngvHLIt81KwUPOqrduk4L7NjALiZ3//FybS0
 mXQsSPO/esmui+GnEWVrmateBMZd37858yduXaUOiwO+dK6eqX86AdCKJ9nfuJKkjNR53oHu8iB
 VBjqpfkop5F3fL7l0WrqLbu4XtvNlxoGq42Tk6I2WfydkXFnHFTiqfSN76e3uxucYG/bMPe2QdU
 JRXjualOJMaKPBQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add os-ioctl-cmds.h containing the complete ioctl command table
mapping TARGET_* ioctl commands to their handlers. Uses IOCTL and
IOCTL_SPECIAL macros for table generation.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cmds.h | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-cmds.h b/bsd-user/freebsd/os-ioctl-cmds.h
new file mode 100644
index 0000000000..5f138fb3b0
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cmds.h
@@ -0,0 +1,149 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* sys/ttycom.h tty(4) */
+IOCTL(TIOCSETD, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGETD, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSBRK, IOC_, TYPE_NULL)
+IOCTL(TIOCCBRK, IOC_, TYPE_NULL)
+IOCTL(TIOCSDTR, IOC_, TYPE_NULL)
+IOCTL(TIOCCDTR, IOC_, TYPE_NULL)
+IOCTL(TIOCGPGRP, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSPGRP, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGETA, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETA, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETAW, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETAF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCPTMASTER, IOC_, TYPE_NULL)
+IOCTL(TIOCOUTQ, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSTI, IOC_W, MK_PTR(TYPE_CHAR))
+IOCTL(TIOCNOTTY, IOC_, TYPE_NULL)
+IOCTL(TIOCSTOP, IOC_, TYPE_NULL)
+IOCTL(TIOCSTART, IOC_, TYPE_NULL)
+IOCTL(TIOCPKT, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCSCTTY, IOC_, TYPE_NULL)
+IOCTL(TIOCDRAIN, IOC_, TYPE_NULL)
+IOCTL(TIOCEXCL, IOC_, TYPE_NULL)
+IOCTL(TIOCNXCL, IOC_, TYPE_NULL)
+IOCTL(TIOCFLUSH, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGWINSZ, IOC_R, MK_PTR(MK_STRUCT(STRUCT_winsize)))
+IOCTL(TIOCSWINSZ, IOC_W, MK_PTR(MK_STRUCT(STRUCT_winsize)))
+IOCTL(TIOCCONS, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMSET, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMGET, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCMBIS, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMBIC, IOC_W, MK_PTR(TYPE_INT))
+
+/* sys/filio.h */
+IOCTL(FIOCLEX, IOC_, TYPE_NULL)
+IOCTL(FIONCLEX, IOC_, TYPE_NULL)
+IOCTL(FIONREAD, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIONBIO, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOASYNC, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIODTYPE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIOGETLBA, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIODGNAME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fiodgname_arg)))
+IOCTL(FIONWRITE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIONSPACE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIOSEEKDATA, IOC_RW, MK_PTR(TYPE_ULONG))
+IOCTL(FIOSEEKHOLE, IOC_RW, MK_PTR(TYPE_ULONG))
+
+/* crypto/cryptodev.h */
+IOCTL_SPECIAL(CIOCGSESSION, IOC_RW, do_ioctl_unsupported, TYPE_INT)
+
+/* netinet6/in6_var.h */
+IOCTL_SPECIAL(SIOCGIFAFLAG_IN6, IOC_RW, do_ioctl_in6_ifreq_sockaddr_int,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_int)))
+IOCTL_SPECIAL(SIOCGIFALIFETIME_IN6, IOC_RW, do_ioctl_in6_ifreq_sockaddr_int,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_int)))
+IOCTL(SIOCGIFPSRCADDR_IN6, IOC_RW,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_sockaddr_in6)))
+IOCTL(SIOCGIFINFO_IN6, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_in6_ndireq)))
+IOCTL(SIOCGDEFIFACE_IN6, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_in6_ndifreq)))
+
+/* sys/disk.h */
+IOCTL(DIOCGSECTORSIZE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(DIOCGMEDIASIZE, IOC_R, MK_PTR(TYPE_LONGLONG))
+
+/* sys/sockio.h */
+IOCTL_SPECIAL(SIOCGIFMAC, IOC_RW, do_ioctl_unsupported,
+    MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+
+IOCTL(SIOCGIFCONF, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_ifconf)))
+
+IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_short)))
+IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_short)))
+
+IOCTL(SIOCGIFMETRIC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCSIFMETRIC, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFMTU, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCSIFMTU, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFFIB, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+#ifdef SIOCGTUNFIB
+IOCTL(SIOCGTUNFIB, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+#endif
+
+IOCTL(SIOCGIFCAP, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_cap)))
+
+IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFBRDADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFBRDADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFDSTADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFDSTADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFNETMASK, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFNETMASK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCADDMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCDELMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFPSRCADDR, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+
+IOCTL(SIOCGIFGENERIC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+
+IOCTL(SIOCGIFDESCR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_buf)))
+
+IOCTL(SIOCGDRVSPEC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifdrv)))
+
+IOCTL(SIOCGIFGROUP, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifgroupreq_ptr)))
+
+IOCTL(SIOCGIFMEDIA, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifmediareq)))
+#ifdef SIOCGIFXMEDIA
+IOCTL(SIOCGIFXMEDIA, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifmediareq)))
+#endif
+
+IOCTL(SIOCGIFSTATUS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifstat)))
+
+/* net/if_gre.h */
+IOCTL(GREGKEY, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#ifdef GREGOPTS
+IOCTL(GREGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#endif
+
+/* net/if_gif.h */
+IOCTL(GIFGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+
+/* net/if_pfsync.h */
+#ifdef SIOCGETPFSYNC
+IOCTL(SIOCGETPFSYNC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#endif
+
+/* net80211/ieee80211_ioctl.h */
+IOCTL(SIOCG80211, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ieee80211req)))
+
+/* net/if_lagg.h */
+IOCTL(SIOCGLAGGPORT, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_lagg_reqport_lacp_opreq)))
+IOCTL(SIOCGLAGG, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_lagg_reqall_lacp_opreq)))
+IOCTL(SIOCGLAGGFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_lagg_reqflags)))
+#ifdef SIOCGLAGGOPTS
+IOCTL(SIOCGLAGGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_lagg_reqopts)))
+#endif

-- 
2.52.0


