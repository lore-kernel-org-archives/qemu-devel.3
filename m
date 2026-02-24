Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99348F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbE-0000kd-PL; Tue, 24 Feb 2026 09:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaq-0000KK-NH
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:56 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutap-0001IJ-7j
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:56 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso5066202a34.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944054; x=1772548854;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pBz8VycCUML/vNPwsdJc+qzGhunZE8y8+GOUDlPj+GE=;
 b=XGOqnRkK4To5lplvhom5nE5MxM9LH4PgNu0P94d60F41SfQ3ESBIoLzN9SfAnrvmS9
 xi4l/jgUFlwmWJQWSXsFBLKup7ewTwGPpB2KVtkqXfBoS1Dq7OJ31Ft7TJ3E8bzYy4TK
 9QOnYi7f9nA4R75NCrX6XhcuzMqGFD9EGGETQmITHugQjD4ZzaheS3FYtGP5v8cVoenl
 KYKMr1Qm+6yltpOdYD5+uQ2XdLg0s7JXrzg3XmrlXznP+QmTXIhBJNueqOUyfoI5NJtF
 geTFWOYQd8yQdfg6D91sZFZXqy1Ee9mR4fuACnvn8nUv9SgrxIW7pI46Y9eC4KACxGuH
 zWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944054; x=1772548854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pBz8VycCUML/vNPwsdJc+qzGhunZE8y8+GOUDlPj+GE=;
 b=XzAMC5GawVRdiaq3S3MztbBIF8T3Fo5my0dsqV/eNYJK27VQkHIZeeNh4neMNerZkH
 VB+IB1Raks/8D2ch7oLNkazsmp+bQZKB9h07jxS/LZd3vXbZICf9Bcle2ZWTYm2bGk5u
 khtD2ck6EEczjlbU/AbtE91giAhJYP/cgvBma1QHgDnxMz1neTv3K3frgLdTD8ZfexTm
 NSgPNQ/hFNq7Ni4sTtB9UXcIRQKDxzhIYVT7ZVmm/mwY85BCoyKpbRL3xOgBaBAoofXG
 TdHi15q43K4EWp18+LIrQ9Wa3n+H3sTIDdVvQPcXmeOrRw7Bx6TDHxRO2t358bzfv8OX
 M46A==
X-Gm-Message-State: AOJu0Yz9d6BxOytoIuhz6yiwORYlzseZsx72DLlbo1hSG1XKiDeCocj5
 5+lkYEAH0ug9U2F3SvlPn9jq/SkImLd7oyFtEgh2UJCJ9nmNt7GjlQI57++uDqsFRPmgd8L6qZt
 67HNBcis=
X-Gm-Gg: AZuq6aIs8OF9IZOo6RqSWnqwvuMm7PFbWHzEHYweWRRhJND6XcY7417J/aXQ7yik5cX
 2YVSivmbIInFYFL84uNcr6qS+sza8KpO9LFioSSTK3GKcrwuSPkHLcwKZmajWAZ1Ay0X2SutCun
 9Bj5RxI1uStcvWrscaHCtNRz9yzF1QZ20HvJdgn5LfjdBayIIHgho2o/slEpDPcehAmXLPauNwH
 1k2/U9HNnGrgmWcQR86fTDglT2zUSVP1JM8HFZf2Rs/6urFkd7eWwz9NQBGIRYEyZWm4pFHHyGu
 qbvuVBzQ90ch16y5gSKHsINaI64+NKNb2v9S6N2r0JsbMo8JaIeGnx9FWlBq+NOOYonlWYw9C9U
 xSSaqXNJfKNOGxM9HTAbAfA8/e8AcUt7g8qGW72T1FcoZWynN4PyGlVPqquGZcWoPDSXNVXFGZr
 LJm7TmQEcxVA==
X-Received: by 2002:a05:6830:3c06:b0:7c7:80e5:245f with SMTP id
 46e09a7af769-7d52bf5320fmr5016624a34.30.1771944053829; 
 Tue, 24 Feb 2026 06:40:53 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:53 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:34 -0700
Subject: [PATCH v4 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-10-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=m4nroGBdmsjJ8MqRlkpI324ArqPLJWX8Os4psbfwQzg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhn5eYXFiUFFepprs9/gihjuzvutXIaCz4Je
 Ae2k2cVx/iJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 AA0pD/0cq/GVvp+142kn351uciVEbTrwVBfvGhRpm6sDtxsyTsHJbNZBVjvvIzqlAL2OwobgVqx
 nL+fjkClEosuzO68und/qIQ91FSRwjpl0YUeCrectJ6VjaS5HWyJBpv78qdqV08u5au3pJlqIHl
 AC82ax94jfzcmRux5rt6ifOfP1z2SCNK9f2ZTBUESwYXEZoH25fxDKEsSurJB1IkoAd09WoqDS3
 fRd7Qc5Y8Ja60FtMpvFL4jMHJgFy1BfT9Rca4DxJ8cGghrBUDscv8bT5/+sv0pYLwPR5wHgtNpm
 Ol8pTN+XqsB58GcQIvSb7doJNatQtr5swo1AwxZH3j1ATvBtnxZYD2ouhR29jU52MuNf+qyNq/v
 U/XsHbV7lisADhLnhBWkDXxgPUXmePU0+9uVEfFfSE7jG6pvm4mC+AUO/CYaF96b+YgtgonfBzE
 VNf7tZnqXZuz26AD+Fq4z99MFEpNxLeWRDX6eq0RW7G+S4kghbOIJqSR3pM5wxqPRQj6Ixv+mHE
 uyJnIDjyqYkgvgtyEeMiw6U+tT6YGsPsfKgFwkMATAEw/QafVmqSTeVuB9YkW96gj3A2Ui/nowK
 3/BRFK9yO0SuRz+zzmzunl/KONxOM/iy8219jC9nTXmdRN10tJCeA+rDwd6U6eO5G6xf5ERutWm
 S8S77TIHRivhWrw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Add host_to_target_semid_ds() to convert host struct semid_ds to target
format for semctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 941f30d547..5b02006313 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -116,3 +116,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
     unlock_user_struct(target_sd, target_addr, 0);
     return 0;
 }
+
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
+                                    &host_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
+    __put_user(target_sd->sem_nsems, &host_sd->sem_nsems);
+    __put_user(target_sd->sem_otime, &host_sd->sem_otime);
+    __put_user(target_sd->sem_ctime, &host_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


