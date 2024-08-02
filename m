Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29b-0001Vw-7x; Fri, 02 Aug 2024 19:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29X-0001Rg-Fh
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:43 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29V-000458-M0
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:43 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so3103039f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643060; x=1723247860;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0Hc+tmyI2fNQswWMe99iI3Cy9S9k8Dxg+dtGkJKvsc=;
 b=Rb2vXvFkt2mn3vLamOLDFSAXUsegdlikrSXYsrxSsnUWr8bztrpbRQsnGzpcjR6LcE
 W1HcgiRJLO6qZQjUW8HkxIks0gBAyaMzYvC4VwC50sZ0hCfrvIu9fMEMvAtGnNoNYrGe
 dmCF6D0v7K2gvK9ZdL9WKNqkL87hyD38vvpPCj8IGXzi4vcwilyLVd9oh68m9BQVyopO
 ezgblLKAygVgO3KWrgPYRoKOXZC6JcadukREcDcuFJqwNvrdgxIuwjMBWeWeiF8xkhYG
 D8qHG3vmRAvYYo3e6DM9MiTEUHL4mAE3AWThO+CS6hvxwmHYgDB+6DFaNhXuocechY/k
 vc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643060; x=1723247860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0Hc+tmyI2fNQswWMe99iI3Cy9S9k8Dxg+dtGkJKvsc=;
 b=XXs7CsIiQGhiAy/xrX9kE2C1tASFmhZa71mDCzkcocvHUGhuVQONJ1XwF4LZtHgq4H
 wP1BZfy9tZRVaXGd4/PXq94IUKNnudt7dcXq9Ey/5uleirDC2Gx95SsYHznwm8zyIN/R
 eayCYCVjE8LHWH3LHpc0Heka3ksKLRl5JDcUJwIv0OVdE697UzNKq+gPYSVVg/zaueQJ
 v5GkFj9xJFeqbJlVOngLb/0BsmiOTbtdPrFB+l5Wt0z1rxc9MVzlUcl5Ar+O6q91XxP3
 qLYcTC1xMGCSPfBSx4uoAPNRRmPdHhsLPQ9DE1FP4SpcaTkUzFPgsyazN0K9GcKmH/n/
 ZgVQ==
X-Gm-Message-State: AOJu0YzIKZNvul4aF8Gn3sPskNL1Rc10KBXx3LdrRrmMZ3QtQKagyjps
 LsLWWob90GNNnELb+sdnbwQN/WNYrpNviGVnxAxHYXMKYSh/uH5+YFf7FlvSJYXJJWw16lRALhq
 Ofr0=
X-Google-Smtp-Source: AGHT+IHNPRICCGvgkgl8kGlCYZIWMu3VHcnnPJ540hiqUAA7KZyeQ/9qom0J8Sdm/SbB7oOnJGI9Lw==
X-Received: by 2002:a05:6602:1509:b0:7f6:8636:f89d with SMTP id
 ca18e2360f4ac-81fd4348a4dmr649254039f.3.1722643059875; 
 Fri, 02 Aug 2024 16:57:39 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 01/17] bsd-user: Delete TaskState next member
Date: Fri,  2 Aug 2024 17:56:01 -0600
Message-ID: <20240802235617.7971-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
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

The next struct member of TaskState is unused. Remove it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3736c417860..4ccbee265a1 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -83,7 +83,6 @@ struct emulated_sigtable {
 struct TaskState {
     pid_t ts_tid;     /* tid (or pid) of this task */
 
-    struct TaskState *next;
     struct bsd_binprm *bprm;
     struct image_info *info;
 
-- 
2.45.1


