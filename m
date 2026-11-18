Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216F606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=hG9jPtiI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qDeOnvcI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThCP-0005lp-N0; Wed, 18 Nov 2026 10:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBY-000575-OO
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:03:02 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBJ-0003xC-97
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:55 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1B6CA14000B2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 10:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014154;
 x=1795100554; bh=A9q2SC81qbfg1j120eXPaQtkG8p0iseFyCNltrrxaIE=; b=
 hG9jPtiIsH+GzkV+/6OCgkiPaR/cACGMQ7DAyQ5XW5B1xeKfMW2B9yLiv3jCjm/7
 eGY42zAw2d2CssEHN7ovtgxPvL/ooUvReOUbdROZmPw8EUCP3TqQjfzEeumy28uE
 68L6TX96FiQIpIZAmVdnFsQweAxcJe9kUS/29e5h+8yUeR9f92CCm4JDLox1j4Ur
 xfnAuZ/D8VG9Ddc2Utq8iydZFs5LFFkDOOBmjnJlJxcW8BTgcBe3ZiHthsuHOvf8
 +9l4jBXXqpY3ZBiJzG2eycklUo1w0oOH7NXWXMUFHr7qMAsmM/B1Wv6RdVyT+V9c
 giHeclA9VSB2DFee1dgWUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014154; x=
 1795100554; bh=A9q2SC81qbfg1j120eXPaQtkG8p0iseFyCNltrrxaIE=; b=q
 DeOnvcIMRugP9ukgmyAOYaoJsWuY47kcM/E+pKAwfnL6Wi23VzZahqtEuszLmZf3
 IzJ9y2W1/6pEzArcyFlpOADFQQP0Xw6DOcCXDVHAxlt5PwRW7LOft/TpQSuwBM3y
 YZabuhGdt/x6Jn/Nrzeh8qx1jy7/1ttFHuYYfBfMiZu9kiZUCLIHfTue2opaFhKv
 djLqRhra8apzza3PyzjRbWhKqGVdfw4Rw9Pfg5LtSuVxJ/kF9v0ZXN4zjsuIGp/r
 QFBPnFtqqR7/oS1PsoapHgzaK8fK3vC9AI6+BATNMZdyAHC7ASXINDJozHTP+CEx
 15UOq+SokqZ8nx2qsBnaQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014154; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:DlNFwGFzWmadqcDq5U8sc9tE/JTnZKlMFw1dznCAnZQcjBh
 8h4WNzkmR/8xjt5NpI3gZN6dTlBp1hlGqPAbQl8sTLM0QOHpJEnQBCTVBSP2B/6y
 2lbiDkP04nAVqDQTuSBCIL5bsHxt+4HIWW2mqmdRQMtrhHGcGLvu+dXfQZ+VyJ3r
 1dv22uJdEjXbFKYxdgxnQtLsqlEio2U03y7+45SLQykvM9OIe8uPjt2zHce0Mi8y
 +dJlZ2y7Yn5ja6E1mB3BZt59oci/CFOVkSdtMQE50WrHKK5Wx5DMggKznbCfiG0A
 Wwcyb8U6HFaNthUy9kEYwfeB7irEOWm8/cem2OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:mw+VmU1a4lrLnHbIzZPGcrE/Ml+60vvlOf9grJX+g2s=:4nyWdp4G21MIx2iDnZLkd4om62RtzW5WGwGT3bz+Zzk=;
X-ME-Sender: <xms:Cb79ahy6x_FN7F703mWZaT2VoL73CEZ8qF0MAMtfvlO0RiD8W7wIjg>
 <xme:Cb79aqO_C0EA1lHFkJlPd0Ifx5qUad1mX7dOj7POfsJ9AtHVV4PLkpUXcbgrKy6Vu
 VMdG6usMplfYylTFtHJ0hWAnsF7QSChpgCiqoC6tJcLyYH0hMBgW6dG>
X-ME-Received: <xmr:Cb79am5Sqpow1UYns8U72dr2am41HJhgY1A-gFdTPZyf0OIjEBpjMDnJsFYb1MTguWg>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMtu
 Z8sYzo6tPAT6GC9qhX+e5LWoU5MV5XJOC7yLJNPGIzFrPDz4acPZjjDxbEYe1uayzqbRsR
 zqDItiX6tW4oR1wPQdz9PI2VDdKLFaAeqosUc7Ff2bbVYPMxHJuXcXuUXLenB7QDDxOKIe
 L5gz0Iqdtrnc4pSrpTFy+qvZiAej2DK/VMMNuG8E8I8j0odwwAMmUk1ZLykFGhXKlsvRnr
 QUcc6+e/OG5hXsHcs4QLYoLSbqEfCLzWCUFNjO1WRjjKvE/GWqyN5Ne3dcDnbIq7sh3uWU
 5d814WaD/w393jUm2KhU5eLDUedlRBchhjz2D27GOnoENz7x7UjgEEZkAHtg
X-ME-Proxy: <xmx:Cb79ajkubTn38li3gqr5DNUvvbUmQZtdO_lDU69WhumtjbmusNdL6A>
 <xmx:Cb79avQ-U94xMx41L2VLOcicHupboh63Jg0pW0nD37F3DEkqc5Cz8A>
 <xmx:Cb79aqF13vjJADQzadeQuRuJR2Dr68j1kv72XR4H0CiC5lH6ljA7mg>
 <xmx:Cb79asGKSEknlkwplrqvE547cZsu8cKvI2oR9Msnyke6VSy4-4_Liw>
 <xmx:Cr79arUAeIdMcxBPTaM9ad200TuHH10DnP7chqWRGRAB8bdz1Zg1NxTA>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:30 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:31 +0100
Subject: [PATCH 4/7] hw/nvme: get fdp events, use helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-4-ed76fad7861d@samsung.com>
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
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5d4122309ea..8fc0884fcda 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6372,7 +6372,7 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     NvmeRuHandle *ruh;
     NvmeFdpEventDescr *s_event;
 
-    if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
+    if (!nvme_fdp_enabled(n)) {
         return NVME_FDP_DISABLED | NVME_DNR;
     }
 

-- 
2.51.2


