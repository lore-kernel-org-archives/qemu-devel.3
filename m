Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5CACD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPz-0006z1-Gm; Wed, 06 May 2026 22:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPv-0006fo-BC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:47 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPt-0007hF-WA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:47 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6967080e6c0so201467eaf.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120684; x=1778725484;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/QyHxhh955w/HPRpKuYJ0dcnEhs1tLz/1RAUl0qOaU=;
 b=DKBgifPHSmsFU1i4zCrDM40YNY3fR1hRsoG6oIsTt5WdKF54yO6pGbX6K5kuPFk4V6
 BUlnNc/fApJTzBXXpDYp0dt0bnIh/GzGCZH8+w5qwva2S3YAOSc395qdr8pxtHoP5WTy
 QmYciGcjVjPmYsEonhOFotgOwNFETMlurl7N1Hs/zGe03rAdyqXvtec77PjOY0G2nuwf
 fWUoQV3KQmZFx3di6ym9xrfwF6+Wmd1RRUP8M0vC07HvGPwJ/YqIDRE7lSrYNST+crXJ
 YdZiNr/Qym5ptrYVy765oXfEcTzdKokXTvVvmik3IsEuXqo0zrpsjlmSuTULdMV29ekQ
 jupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120684; x=1778725484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/QyHxhh955w/HPRpKuYJ0dcnEhs1tLz/1RAUl0qOaU=;
 b=A9nquyA9mffMlPd5LiFuL+EslNHHLAtTOlDufEwtOwNwARP4nTpQ05pX/XcOpfr+98
 bT/3fzIYOBGt29EGXpeRbW7rllHk3lAR+/o8G3My9duFj/FxlTlfXPORufZ8cdsDHCvf
 YYfgAG2GzdAO4soKSy3sALakay0pEYZhDdHoYlM7zjwNhTnxZJZtX3sPAl9Hh8pLYtHN
 4DpXm/PcikqPG7TCjbekc4ldxkZVhpejtXzYQ0hkoatUcjJ8lIWKoa4YjKqvc8vyeTny
 vqQ28+sOa2OTmowJi3tBR+mwrSLETpQ9Fhwd8E7J91ZELGT2NN1TuBiBw5Yyd+jEFSos
 TaZg==
X-Gm-Message-State: AOJu0YwjBEfybe+LmLpTnJm65nZrN6nzXn9WSMfYt9ZN8CjKJDqGAHv8
 CP7E2KqFK1Guc0I8UxKdSeSTAuOt/V3u37cOl/MlBhDrDgqSNYOs2ehyzcTHEvEWWjG5IWDGEgj
 kvN/iTHI=
X-Gm-Gg: AeBDietZsWf1PEvsO8Q480qx5DO/lWmIq2+vizsixEp8WAfWYP6Fesgq3tEPvVZxvPg
 XrK7CM2T5k0R6oM7TqnhWP8hoEfbn8WO27Vd9vtsagNsXs1oC+O+NgwWmstzr1EdPypf3knKbzp
 oJMP6MGa0n7QzxjhSpYDPNIwtRl9H49Rp4GgWzHqfUutEZOgkI9eF0MWCZTecnRMV44+NYUNs76
 o7e6lSTxf3lb2Q0PeZNsKGTx2p94B5zeEHRB4VOPdscmzGiAm5ukLUwf+nAg0eK5zV5nuJoPQVg
 NharvP5XublbvGCnX3UlgAPHbhz3H1WCpNbNMvOwoF5L5HgLqnp8uH7qwtEBWqoUElwFYB5jEm1
 VNy+iPK1vwVt9fGJnw9pG8dMOY8EAW1t9c/Kcl4Mo57WS7TIwmAfzakk/dEm4+jiuVSRUXaUS+A
 t0EShTxVfJ8ghsjk2dbCTZ
X-Received: by 2002:a05:6820:168c:b0:694:9f3a:da8 with SMTP id
 006d021491bc7-69998c8fb79mr3511806eaf.12.1778120684583; 
 Wed, 06 May 2026 19:24:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 21/25] bsd-user: Add target_to_host_sockaddr_in6 function
Date: Wed,  6 May 2026 20:22:15 -0600
Message-ID: <20260507022219.44171-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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

Add helper function to convert target IPv6 socket address structure
to host format, handling all sockaddr_in6 fields including address,
port, flow info, and scope ID.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 69d1ea1718..d2eb9105fc 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -249,3 +249,14 @@ static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
 {
     return -TARGET_ENXIO;
 }
+
+static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
+        struct target_sockaddr_in6 *tsa_in6)
+{
+    __get_user(hsa_in6->sin6_len, &tsa_in6->sin6_len);
+    __get_user(hsa_in6->sin6_family, &tsa_in6->sin6_family);
+    __get_user(hsa_in6->sin6_port, &tsa_in6->sin6_port);
+    __get_user(hsa_in6->sin6_flowinfo, &tsa_in6->sin6_flowinfo);
+    memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
+    __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
+}
-- 
2.52.0


