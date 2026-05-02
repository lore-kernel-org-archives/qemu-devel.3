Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6B5CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsU-0007u7-QS; Sat, 02 May 2026 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsL-0007qn-E4
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:33 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsJ-0007CM-J0
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:33 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7de44ed7a11so2424846a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741890; x=1778346690;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4MKf6De/lMm9M73N3EIAo5PrmTbOcp6IZR9GOSaoP9c=;
 b=ak3+YEoOCyaCz0nSaQCgk5Jl4machKkfrjpKVx4ZQ3nk1ySIngvI4lbVaZhragm25l
 EJklJ1Gngzk7iUZBSOXKXnQPB+UXCuBBY3FyUp/vgIWzrmbeMCRrysBFMDZoDoZ7cnYs
 XzUYMf66tDrUTedjDBE3x3xCW5af8atdc4b/lxbzrjYCJS3dJsY8hkGsDow1ejvwU4YJ
 YruWk3znYutbBjbv6uS05CiAN4/+sRPpGjPEPgHNNajcmg/i+yKH/yrmsfeA0wwFcYne
 ZlP1kT1oHyBt5nPeOSaaJH8I0a6SBDzaUVRbm/E5GBv7HN7shcjB8dCchasjUXqYkKci
 +zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741890; x=1778346690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4MKf6De/lMm9M73N3EIAo5PrmTbOcp6IZR9GOSaoP9c=;
 b=YFJSK5nJnNvdHZH0HxZ1Lf5yIeE8qnT2bDUq3BG6y4LbmxXXlNdq96i2X+7Wga57uM
 fWzUIB4TbTWP+6DfKxUkQvHx4WEYSxSyH2jhuDGQnducUfnX811HLCQfIOPe94skzZxc
 +MXsvJu+Vo2xi43PwxVx+iuU9dMb48zd6nduuCPK+MEgTwXbKpXQtwFQAzqqYIAysUlr
 DB7lF9pkgnE1zOWwF8B3e0F/K5m6HSH6i8psERlDiT9o28hVrcc9mW+9nxDNqZjIS5+Y
 xgELWs/go6CHBwc1m4PscAbnxtZL83STUEp4UF1BBQlvAmfKXsnU4IQ9SvEQNuU6BUI2
 UjTg==
X-Gm-Message-State: AOJu0YwomvR+W2vr4TMWjTDX14Vx/EbnhaclM5h5HYG8W54rcL6ZwQnF
 tNYeg15M3LpvjszWSrs7hwKEcsTVWfy8e78dsqYdAs4PcF0FVMfFnaWpXV2PpsbIWL+mj2u0wed
 /cjPD/cY=
X-Gm-Gg: AeBDieufiRoWJs81ShQd3/oOv1N4GX2A/qBPGi83kZrCq1uxVr90pQZhSk5di6/21kP
 U8r1ZwPht5C+3bsK3yOoynHg9/OM4iWRiIZmpjjSFUujZFaturGcGmfTLMx3G1ky/j9+PjlH9EJ
 8Gg2vUTOMM0GYtAki3I0bzCXq+7EaQuVoEqYagdRpu66RYYgyds1e4ZGKh3KXLJtrgAnTYskZ3o
 1C+Ji5LdJ5YPQRBK6W8gWElQrBW6MCtwHmuMqnxFIj1BDKX/S3GicZT2n+yTDY0I5mWGsyI4/v5
 Q5lzYsPq7ep+rTfnXXzmkCFOTD6/87Rtt5htPaLrBC2RPRd9YYRYlsNIgF9gj0jI+RrqPT6DvAm
 jQqhGGkjaDs3ooMCfWpkL7ThQxUQBQaSN22pQ4KCv8znO5f1slrIkDomP3V/Z9Xy8mjbKDhCJBE
 BEko4CZd/sdiJPhfByCIJy
X-Received: by 2002:a05:6830:6a87:b0:7d9:71fa:3079 with SMTP id
 46e09a7af769-7dee1267007mr2445301a34.10.1777741890173; 
 Sat, 02 May 2026 10:11:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:33 -0600
Subject: [PATCH v3 12/19] bsd-user: Add bsd-ioctl.c infrastructure and
 termios conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260502-ioctl-v3-12-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8485; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=L5oWgaasv37SfpZktqhsjhO7ULMMl2LYv2E2ql7FUpQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/QzNnPiH1xBxFWnZ9Fp1Zus7C7GTc1xiyYW
 u7g9aGt3F2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0AAKCRBsHNEofbAR
 AKxkEACoebCvRVaU7ZG0WfKtE9mj7TzI5TQCnG4Jy0XNRvY8S9jUEWeSL9akFKQ39pjbgRTSWXg
 4ncQhWgdJde7pzEvpFQtddtMJFFKpo7I3MeQuWGs/3Db9/cARtLy9JA2TQ4qZf56Q8tDyA87WpX
 ImlKgdGdxLNPGGW8aFUZkqctXt2FEEXcwuyqPG7fS+N6ezajaYAobUmAaxkVAeubZratd3pNM6u
 OZBueNJyhwYnjCfE+55zOKFmM7NdWl9Kv/SZlcwpif+25iXSt8PfXOADwNwY9nK/ShhkosTHLW/
 aJgY7SFRuDJCQqqg/seR8oM3evE1n2vtPxHRGJ9Eb6WWJ4ZNeVXuzt7a84e44wD/egnhCnYlV8V
 Te6C5xhSzv2x5+lJV4LErkd+mSWA+2fTkkxIMRXxjegMYYs++2yVIY3WQ9XlfLCWftaUTy+XFBf
 w3NMphVeMz3tSVWqaPpEq1tS7AHANv3lVXL4/uD9XAmFlRcqtJR1v4Ud8/YqbR7auF9DimOe+N1
 0MITHBTA9tM8rqzE7CwgnbC5M0sPsq/dLF/stD7b4ZXjM/NDwByQbYLNY1by3xwXv864Brr5UdH
 EvI2tY+ulojBPhjELGJoiAqa3fPzYbDzscOMRiwBRHcYrpYIn3vUpVPg5EKNVPAUvEYwzDODbTY
 8cfUvQJWuRPydeA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Add initial bsd-ioctl.c file with termios conversion functions,
structure type definitions, and ioctl table infrastructure.
Includes target_to_host_termios and host_to_target_termios for
terminal I/O control conversion, along with the ioctl dispatch
table framework.

Style complains about STRUCT and STRUCT_SPECIAL defines:
  ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
  ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
but that's fine. We are doing weird things with macros, and it's fine.
We can't put parens or do while (0) around these since they are table
building macros for files that are included multiple times.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
new file mode 100644
index 0000000000..94110d4ad5
--- /dev/null
+++ b/bsd-user/bsd-ioctl.c
@@ -0,0 +1,219 @@
+/*
+ * BSD ioctl(2) emulation
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/types.h>
+#include <sys/param.h>
+#include <sys/disk.h>
+#include <sys/ioccom.h>
+#include <sys/ioctl.h>
+#include <sys/sockio.h>
+#include <sys/_termios.h>
+#include <sys/ttycom.h>
+#include <sys/filio.h>
+
+#include <crypto/cryptodev.h>
+
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <net/if_var.h>
+#include <net/if_types.h>
+#include <net/route.h>
+#include <net/if_dl.h>
+#include <net/if_gif.h>
+#include <net/if_gre.h>
+#include <net/if_lagg.h>
+#include <net/if_media.h>
+#include <net/pfvar.h>
+#include <net/if_pfsync.h>
+#include <netinet/icmp6.h>
+#include <netinet/in.h>
+#include <netinet/ip_carp.h>
+#include <netinet6/in6_var.h>
+#include <netinet6/nd6.h>
+#include <net80211/ieee80211_ioctl.h>
+
+#include <stdio.h>
+
+#include "qemu.h"
+
+#include "syscall_defs.h"
+#include "bsd-ioctl.h"
+#include "os-ioctl-cryptodev.h"
+#include "os-ioctl-filio.h"
+#include "os-ioctl-in6_var.h"
+#include "os-ioctl-sockio.h"
+#include "os-ioctl-ttycom.h"
+#include "os-ioctl-disk.h"
+
+static void target_to_host_termios(void *dst, const void *src)
+{
+    struct termios *host = dst;
+    const struct target_termios *target = src;
+
+    host->c_iflag = target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
+    host->c_oflag = target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
+    host->c_cflag = target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
+    host->c_lflag = target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
+
+    memset(host->c_cc, 0, sizeof(host->c_cc));
+    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
+    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
+#ifdef VEOL2
+    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
+#endif
+    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
+#ifdef VWERASE
+    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
+#endif
+    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
+#ifdef VREPRINT
+    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
+#endif
+#ifdef VERASE2
+    host->c_cc[VERASE2] = target->c_cc[TARGET_VERASE2];
+#endif
+    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
+    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
+    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
+#ifdef VDSUSP
+    host->c_cc[VDSUSP] = target->c_cc[TARGET_VDSUSP];
+#endif
+    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
+    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
+#ifdef VLNEXT
+    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
+#endif
+#ifdef VDISCARD
+    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
+#endif
+    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
+    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
+#ifdef VSTATUS
+    host->c_cc[VSTATUS] = target->c_cc[TARGET_VSTATUS];
+#endif
+
+    host->c_ispeed = tswap32(target->c_ispeed);
+    host->c_ospeed = tswap32(target->c_ospeed);
+}
+
+static void host_to_target_termios(void *dst, const void *src)
+{
+    struct target_termios *target = dst;
+    const struct termios *host = src;
+
+    target->c_iflag = tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
+    target->c_oflag = tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
+    target->c_cflag = tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
+    target->c_lflag = tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
+
+    memset(target->c_cc, 0, sizeof(target->c_cc));
+    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
+    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
+#ifdef VEOL2
+    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
+#endif
+    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
+#ifdef VWERASE
+    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
+#endif
+    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
+#ifdef VREPRINT
+    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
+#endif
+#ifdef VERASE2
+    target->c_cc[TARGET_VERASE2] = host->c_cc[VERASE2];
+#endif
+    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
+    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
+    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
+#ifdef VDSUSP
+    target->c_cc[TARGET_VDSUSP] = host->c_cc[VDSUSP];
+#endif
+    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
+    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
+#ifdef VLNEXT
+    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
+#endif
+#ifdef VDISCARD
+    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
+#endif
+    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
+    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
+#ifdef VSTATUS
+    target->c_cc[TARGET_VSTATUS] = host->c_cc[VSTATUS];
+#endif
+
+    target->c_ispeed = tswap32(host->c_ispeed);
+    target->c_ospeed = tswap32(host->c_ospeed);
+}
+
+static const StructEntry struct_termios_def = {
+    .convert = { host_to_target_termios, target_to_host_termios },
+    .size = { sizeof(struct target_termios), sizeof(struct termios) },
+    .align = { __alignof__(struct target_termios),
+        __alignof__(struct termios) },
+};
+
+/* ioctl structure type definitions */
+#define STRUCT(name, ...) STRUCT_ ## name,
+#define STRUCT_SPECIAL(name) STRUCT_ ## name,
+enum {
+#include "os-ioctl-types.h"
+STRUCT_MAX
+};
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+#define STRUCT(name, ...) \
+    static const argtype struct_ ## name ## _def[] = { __VA_ARGS__, TYPE_NULL };
+#define STRUCT_SPECIAL(name)
+#include "os-ioctl-types.h"
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+
+struct IOCTLEntry;
+
+typedef abi_long do_ioctl_fn(const struct IOCTLEntry *ie, uint8_t *buf_temp,
+                int fd, abi_long cmd, abi_long arg);
+
+struct IOCTLEntry {
+    unsigned int target_cmd;
+    unsigned int host_cmd;
+    const char *name;
+    int access;
+    do_ioctl_fn *do_ioctl;
+    const argtype arg_type[5];
+};
+typedef struct IOCTLEntry IOCTLEntry;
+
+#define MAX_STRUCT_SIZE 4096
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg);
+
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg);
+
+static IOCTLEntry ioctl_entries[] = {
+#define IOC_    0x0000
+#define IOC_R   0x0001
+#define IOC_W   0x0002
+#define IOC_RW  (IOC_R | IOC_W)
+#define IOCTL(cmd, access, ...) \
+    { TARGET_ ## cmd, cmd, #cmd, access, 0, { __VA_ARGS__ } },
+#define IOCTL_SPECIAL(cmd, access, dofn, ...) \
+    { TARGET_ ## cmd, cmd, #cmd, access, dofn, { __VA_ARGS__ } },
+#define IOCTL_SPECIAL_UNIMPL(cmd, access, dofn, ...) \
+    { TARGET_ ## cmd, 0, #cmd, access, dofn, { __VA_ARGS__ } },
+#include "os-ioctl-cmds.h"
+    { 0, 0 },
+};

-- 
2.52.0


