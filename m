Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2CACA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuYC2-0002sy-TG; Fri, 05 Sep 2025 11:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3A_-6aAcKCjolabkhauckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--pefoley.bounces.google.com>)
 id 1uuYC0-0002sR-Ti
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 11:17:37 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3A_-6aAcKCjolabkhauckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--pefoley.bounces.google.com>)
 id 1uuYBw-0001FI-Up
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 11:17:36 -0400
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-4b335bd70b8so39833471cf.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757085444; x=1757690244; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Lg9HVuz+A1FnOUJ3knlqpDY3nmh19aERu5ysQdwzHfo=;
 b=hHYwcrc7GxXE2gk62FdR+MiBIdEmSAfVW9Zx+JqWdfzidDv/UL2cZ0WhIHfeCNtFKf
 O5VYTYmk4545i5PN5i+pHh1aq3WyQKdChY73x+YD8mbuAsFGp7QXDnriWwg8VfVaTzqe
 hsBfTmWIyT+zzRmKE0n21lzR9eqZco+4inCe+gB0bHhcO6K4LfBED7TSYfjU6K42UoUW
 uD2463IeEZJu8QrvF5qGmV2QFXTmZge/OXeewLF8uqy0JWbzl7CzekB1ERXOERK/5B6K
 +pBpRlF/0yy76rLC1UMNWnWZhx6w1GkRG6ti1Br2n9z07XB6Nv+0Gw+pxcItO6/41FKL
 8Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757085444; x=1757690244;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lg9HVuz+A1FnOUJ3knlqpDY3nmh19aERu5ysQdwzHfo=;
 b=BHSa5t314lS19nGLZMGoOZl97+6Lel+X5doEPUmf56YhMuM6hw7cT5DwL8aMZEtzsF
 YQj/dIgRoqrp6TC/C41HTfQRaB0k/9oSj/idscXpBGT6pncr9ls2FprPT/oOQNMUCTWs
 hqCt0ldeJm/W303Ra7sIj36Sc/db8OinR2NH+HnlrdskSreOCZr+RjJ62FbLGtJ/qxhF
 aUSQhuO4I3xqxSWqB4trhbEqYzF3ybkLxYi1Zubegni7saw9duLPV8sAniDITZffYOlh
 Q9try94ZxnXAHGGSrLjpvqjIkwvr/vA37PLgyJ5snvREuTlS4BArI/iU8+fvqodBsRhC
 mXkA==
X-Gm-Message-State: AOJu0YxNzeCR1bnPq1+F6IOBMwekKS+kxtGjQCS0X0UttohnRvI91dEE
 pWZ+udzz8qfe5uVci1hGcMfaY9sSqMISVNQpXbkMBJV/KKb8RRVknXOKPa2ThKBd2Lwpec6dNuV
 w/XvZlO/dh6B/jcW8RuAgUs1Yk23CnDmL8+YBZy2EbsfYLl6zwAbScFX4mGzxvyuL0cveHfvddX
 aDgQeBcZKttEnSXdrkgNFOqk18vEPFEXlgzQhDDeG2
X-Google-Smtp-Source: AGHT+IGM/+L8zEUGzWEnQtU4HEvkTbBW+snxkQSU3OsfAnxHuja0RCvsPDL8u7FWtU6VwmhKYCJSocscOO3m
X-Received: from qtbih5.prod.google.com ([2002:a05:622a:6a85:b0:4b5:e643:b1ac])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d92:0:b0:4b5:dadd:cec1
 with SMTP id d75a77b69052e-4b5daddf1e3mr81389091cf.59.1757085443784; Fri, 05
 Sep 2025 08:17:23 -0700 (PDT)
Date: Fri, 05 Sep 2025 11:17:11 -0400
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPb+umgC/1WMQQ7CIBBFr9LMWsxAwVpX3sN0UceRTqKlAUM0D
 XcXu3P5fv57KySOwglOzQqRsyQJcwWza4Cmcfas5FYZDBqHPVrVL0prQotu5I4c1OMS+S7vLXI
 ZKk+SXiF+tmbWv/VPz1ppxYfW0rXtLB3x7EPwD95TeMJQSvkC2w1Iw5UAAAA=
X-Change-Id: 20250904-9p-11c0405ae7c5
X-Mailer: b4 0.14.2
Message-ID: <20250905-9p-v2-1-2ad31999684d@google.com>
Subject: [PATCH v2] 9pfs: Stop including gstrfuncs.h
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 pbonzini@redhat.com, 
 nabihestefan@google.com, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3A_-6aAcKCjolabkhauckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--pefoley.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

gstrfuncs.h is not intended to be included directly.
In fact this only works because glib.h is already included by osdep.h.
Just remove the include.

Signed-off-by: Peter Foley <pefoley@google.com>
---
Changes in v2:
- Just remove the include entirely in favor of osdep.h
- Link to v1: https://lore.kernel.org/qemu-devel/20250904-9p-v1-1-e634cb374c80@google.com
---
 hw/9pfs/9p-util-generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
index 4c1e9c887d00c44bc073bec00c07ed09d3868bf5..b71fa2cb3785349c6b4d2b9591f5ea4f917844d0 100644
--- a/hw/9pfs/9p-util-generic.c
+++ b/hw/9pfs/9p-util-generic.c
@@ -2,7 +2,6 @@
 
 #include "qemu/osdep.h"
 #include "9p-util.h"
-#include <glib/gstrfuncs.h>
 
 char *qemu_open_flags_tostr(int flags)
 {

---
base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
change-id: 20250904-9p-11c0405ae7c5

Best regards,
-- 
Peter Foley <pefoley@google.com>


