Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3160A2606
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=ibIB/Ztn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bpUtSpfL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThCX-0005y7-15; Wed, 18 Nov 2026 10:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBX-00056k-1r
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:03:00 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBC-0003il-9z
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:54 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AD6C114000DA
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 10:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014149;
 x=1795100549; bh=JeY/OzFJu79JKgruOIyx/0zK5jyzcn8SNLP15dAFbjA=; b=
 ibIB/ZtnR649AF9i9YNvKTFH3sSBld3PamioNqVMsmPzCzhrIjBSwMypN5m2LRyh
 7zv0Ok9Kef0NDJfmuveeLvVCD/dx1DB9o9ldO9UEXa4c1lIhV+x9Y0wlkGibtvm2
 JB3bn1vDos8sIdc1+xfG5dADwkYvaVjS2fFJZhDJ23s1j5+k2zFUF8NNPQJvBZ5L
 ICu0wWnNknqUeVtRF6oxmpDdVq7ZlHe5vH+pOo4CvryBKPjITbub7lpTwN/48pUu
 hWwiz3ad0Jo94AiZykS0JHyxpbrm3Qu2LdPWosSYcNI/R0iycH/uNAfpvhABe4BN
 MsKMyIO0K9Wr+CU7fGdukA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014149; x=
 1795100549; bh=JeY/OzFJu79JKgruOIyx/0zK5jyzcn8SNLP15dAFbjA=; b=b
 pUtSpfLf5U/ZizSFE2jhTJSxdNhnJtxwtdae9mg61XFYvRkqwTN/Oh8utnJ9pAef
 pQL3Cndg3PpuyM2sduWjk4W1UIs+bNAJ11hmNgfZsXzdUwX6AncCianGf/7b2WHA
 Wvd5AOFCf2ib0ykMLWct4qej39y2wNZWzY+/MweOWSPq3XpmIA/9Sj51hYYItWc4
 Yu9cD40SThgUkNtsbHaZzaAUOBnkKdMVWKLZ44qVEbJ4uMY5kBHUb8fv5dl2UIdR
 gx+uTEmqrUtxt7lWIwfkK1G7qbXAkA7zqY8qXNNGArQwCWxHGrJJ6N4mb/hpKlgW
 1ZAieNypcwrMxmwh9dChw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014149; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:LQXSUbe6u2+tVeklP6SEy+7MJW+3dRgqEsf00QuuLZhaNwZ
 /jg9jnX3liVwO5AUeGnaTfLVLV4vdiwjzJn4vFLRVWPuZERkBIQZdFaaN7dOA6RR
 eXGDz2Sz2LYh6vy1THLdiHOm3JotpoQBFfpYqpaXZZF/NEAkIWpL0gSLhU+9G+bI
 N0SQxMXmH0heBb3NmZJlWY8mdqU/Empe2zMR3ueMhBxWxKIFbOLqjmT1u9MylImK
 uAU62R9kxpwSrH0pbeC67asA/k6jZlmoAxTqsKPW7xHXM3LlycdnWPRYeCWZR9b2
 Kmc8EqFXDGCQCNAR0sdQeLAIq31fIJLtG4M7VwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:LH4xyR1aaGh923NJwDObZQBZDBVgMzODToJqo3VMDyg=:hQnyvlpU7cI68wCzqaFp5H3ncE8hTLT8vH+Gewr8Kv0=;
X-ME-Sender: <xms:Bb79atvi4-0bjhpPd3VK2fFQsM7juujO7FCFWuva8lc8bIGypwvt1w>
 <xme:Bb79avayuBfZGkL6zMCbDWPw-7521Y1RcSJZzSDLC8zvQl7efv90omjwrEPswGuP2
 YWarMmq1eJCVceSk62M7rTw3QIxAjqpI5me-UH5CPvGKZ-H_AQmn3es>
X-ME-Received: <xmr:Bb79asV-bq9O5zH2uyZQ7DORtqSqGjOYOi2J3KO_dJdvwJWuFCbwZXXvYV8hcgjCU5E>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMn1
 EO+SFlJpxrtFD9E+u7sxe+1aRrgSFm6OGn9cZpUFJsZbSWDHEIuhdvWUshQE0+iJfnRYp0
 7qSN0Nf5RVE5FbtuREk1yG/KvbGCWkZ8zqXfrzYyXCimFRI72Y+dtC43Ne3Y6e6Nt3mw1A
 tCaHqp3Hv8HndVl/vxmRlKLzqBtHNemKtgJ9h9TM6XG9YRKCN+sSZNOXsVeQiy/gGSKfIn
 YIdxQBkt7Y9H5LjplSc1RQIy3TUVWz5UBmWcTNSXcTbTX/wGlj1hou7YDnqypZ0j9Gxddw
 qkWpZUDHiU3KaG7mapZSSpUAw4Z1oshV2yvCjh1x9ejjoLe1mPmu+S/SksIA
X-ME-Proxy: <xmx:Bb79akQ5_qLA7LLRZslNcO48gqO0WHyoCqk1R-HNzePLNHhMIU_8xA>
 <xmx:Bb79aqPUJNnEgpL94WxnI4mA3EpF0uCiRMXnXAtsKA_12vhc-W-olg>
 <xmx:Bb79aiRr6s-niI7-1buCf6edFXln6XonoGafYhveUR4Y2eMmP_iRxw>
 <xmx:Bb79aojFt4aBVkbT2ugulVBsxTZ1FC6fyB5fI9VdkXeZXzRiwN35SA>
 <xmx:Bb79aiyE84k1j6EcIApo19J2pAu4QuMJ4xu2E72oTGmUbxwPsvd4LnKY>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:22 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:30 +0100
Subject: [PATCH 3/7] hw/nvme: fdp enabled helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-3-ed76fad7861d@samsung.com>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.159; envelope-from=foss@defmacro.it;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c8da01f11d0..5d4122309ea 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -385,6 +385,11 @@ static inline bool nvme_parse_pid(NvmeNamespace *ns, uint16_t pid,
     return nvme_ph_valid(ns, *ph) && nvme_rg_valid(ns->endgrp, *rg);
 }
 
+static inline bool nvme_fdp_enabled(NvmeCtrl *n)
+{
+    return n->subsys && n->subsys->endgrp.fdp.enabled;
+}
+
 static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
                                    NvmeZoneState state)
 {

-- 
2.51.2


