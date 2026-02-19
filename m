Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0013BE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV2-0002ky-HY; Thu, 19 Feb 2026 00:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUz-0002k4-FL
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:49 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUy-0001dY-0o
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:49 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6775a46c6dfso199470eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478567; x=1772083367;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VwG9IGFOxqmSGM/oPn87UQ+8mXvbE6Kw5MD0BJdObFs=;
 b=MvoikVlweCGZhCLTcNAQN+FV0dksYWHzLDFIckR2lRxWtv6Mh7PtKovwaS0U9SY6iz
 HhzqnnNql2m2uc+5G46bAOu42imA8AGnMLHcPn9ktzPVpN2G9p/wHKK0K7EPnJ+AGj85
 4kbL4VA9ygg7hsxiT4etsIlIvJMIqUhqGKxeuJD46yAz1zqSiXOKudekaiwSNoqpXOqk
 JjsuoIubXl8Qb5xTcCBWVlgUbsXc3HwI7X7Gaxt5l2dc+P/xEJw3X95PlNjc+iQCRE+s
 W8UvCmfV7FrYWYfeeCqbxQzff2f/LN2mYCaa/CPxMXcl16nesO5D/64Haqvd2i7tOM+w
 yG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478567; x=1772083367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VwG9IGFOxqmSGM/oPn87UQ+8mXvbE6Kw5MD0BJdObFs=;
 b=Sq4ifjQwsiGm/K7B5aj4n43cjIuy8BJAZboV/rIZMUxpKNKnEtfwoYJwwIk44HBIwG
 F/0YbOli6BFM+FVxoZsn7Jf7o1ytK7Rv9L8aH27AgoYX63/5DGT9aUfxnl6NTW8/2zsM
 ouQTlydVgX77VTImN/OEdMiZN9DhbYV9cKBvQFK/5cQXuO1SO/oKR8jt0zWgi1sC1pci
 eqPCUj/D3vMLgxTQKO0hY9O4p5LHkTyyjogRRbMXeNCi9uOohJY2xMgFYYptYUfiaSEH
 5f8Q9PEnwW+Wci0pc3sTmv/TVksoVtiAnfX3uzjGdJWkmrIGK3fpnVSWQ1oyEDQUEqLp
 +Xqw==
X-Gm-Message-State: AOJu0YwohG2XWsDF76e22WXeSi9QjU4LlsDh3Uwr/rg9U2RM3PctzN01
 c38rQOPX9EFmkrPxs2+VaM21Kh7HhBhz3FmwnNUnS+Q7WejrP8FM3LO8pzG9D8JBrEk=
X-Gm-Gg: AZuq6aJuW0i4j0MoBbkUcmBdRZ1iKY8HT5RRaJXhvC3WRk34svd4WxkRiDpnOLxzX3g
 LT/xDTv97rGtnSW7iZuCleNiJwbFeayeD9HGiCX/699RThD+A6wugz7XZadsz3/C0/XbpMvGEwa
 eNq4aGG9d+fB5a2bVpVoe40QE95wpKQGd2ShL/mQbitKNwDvoudFoGNkoM46T8PHFCIUHKTIEQH
 xDYCj+Xm8fdRXIt0n9Prb1pcmDeCnYaC9+h7uzS5LDpMvlAiyTZowY+YAyiUfmQIkRTbcw+hrVD
 jhk4c5m1qAj9J5lDnovdPBOl/ul9rdkJxISTpaxKSP4bQc3FvOjxVWNBf3Q7bEr1Gg/GRdTaWs8
 1Zc2v/hk9Bo7po14W9qXUdAOtV5OnDf6p2Gu4nhKsewbOcPaID18YO66LltrvaLT3uBbvnPxn+/
 dNd65WMqps3w==
X-Received: by 2002:a05:6820:178b:b0:663:23a:caf3 with SMTP id
 006d021491bc7-67858fe8353mr7939762eaf.13.1771478567005; 
 Wed, 18 Feb 2026 21:22:47 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:46 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:32 -0700
Subject: [PATCH v3 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-9-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=fgH3524EO/JRuA2EMdN9nWxqm50+gVm4UNlg5mR95Uk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rmJiZsBg8rmuiKPUCyTUBTapM+KvgxiUDN
 9OYmq2oVbGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AKlZD/9sT+mcR3O9dgSmNmNfAKPFuF6T5NbFtTQfUwGPywJr310y86yX3nfJeSa8Rg6iFEc87zu
 /nFX8G2DfQaPP6o7l1rjFVZZ8MvKksWptzlw8H7uEeX8WrnQ15RcDHddbuWJ8fZQFxhUggTmKrn
 LxQ6wXU5X2ptvlyPas2u9XaoAUbn0QWNxtRfLFkhmzH/L3/oCvqIEj6wQMJj2gta0AV+Wi36Aiu
 4gLudyU88VH6Bx6+5yUtertZx6azgnsuLbz3/Ye0nw6wMvRm7vfzLHHur0Sy6ym71PTCAx5JWfX
 7yftCSyA1s4wolbgz0/r1Fsxp3lKcIb7gv29d8FnK9+xnZvsyXWqNk+L4XtRnhWqLE4HGbe/fy0
 lqWYkRM6VY1dEjvGOIgzDUBLLVCmL9KyN3LKVRBmTjzUWI//tFR1Dh1hmQLSn7U/lW2zxzafZGS
 j5RNZmlIwRFYocJ7sYfn9XgaaLTapoJocCLKSMruZeBe33Y2UQ27Nyz9nJ/5IGjATLVMyMDfraT
 eP2sgXwrtqrk0xhBaWqHHCiURTP/098bZX/b8r9JsQkzWsagVfDVAWN8cetS6OmewjXG4r5Wl/i
 tNmYoqZgGdRxDVfO9E1Cn4N6oPg9gD05nuImBrr9M4dkqVmJ9aW2D5teWYICbadWKFmQTAJEuwm
 KiloukQYAkNQBHg==
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

Add target_to_host_semid_ds() to convert target struct semid_ds to host
format for semctl(2) IPC_SET operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 65fd7b72e5..941f30d547 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -98,3 +98,21 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
     unlock_user(array, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_ipc_perm__locked(&host_sd->sem_perm, &target_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
+    __get_user(host_sd->sem_nsems, &target_sd->sem_nsems);
+    __get_user(host_sd->sem_otime, &target_sd->sem_otime);
+    __get_user(host_sd->sem_ctime, &target_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+    return 0;
+}

-- 
2.52.0


