Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3146606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=oSSewWQV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s5H0gYee
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRVa-0007V0-Vl; Thu, 12 Nov 2026 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV6-0006qn-Fu
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:52 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRRV3-0003VV-AQ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:53:48 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E11C57A01BC
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 04:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794477222; x=1794563622; bh=83JLLb21nkZCBNd8GipOTO6ugZrk18ZT
 2YKA0KEE2gk=; b=oSSewWQVO5NpKsQZndX5guUXCOCE84YvelnRMJogs4BuxclH
 wgimb7zQhzTt1zUDWX/GYXPRLkHJtKWc0VlqpwBhCDCdFaFi691TPpqrvF/YM2Ks
 8gWQBVQYnbfFmhiT3u8Kt9FE64gOAtVDSqNDLSbvIShXIcFr3QqFQpRHW3KzKPCv
 vLKYs9k1MtlzUsvRLuCD/xfg4mIVVIeub0+7nbgcH5R1s1Jq1WzFXdUR2epWFCIS
 uRy0c6whJO31Dzo/q6cH2a8ZIVlUKupoNvF+6qd3F3Rt6yNTy1jm6mPXVB9wVme3
 +03FkUL0wg0U9BgAbroslr21RlsMzUlDOwdlAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794477222; x=
 1794563622; bh=83JLLb21nkZCBNd8GipOTO6ugZrk18ZT2YKA0KEE2gk=; b=s
 5H0gYeeqywmyMIDus2cIRGq9bgzDLaOnpKxStlySWdR5PTPTJovKuE1Xrpq81fJQ
 5THW39adlP3aR8OLyDxgYKsMQZ5sht3YYWWsfTe7uLVEbKv12TAdUD7U0r6IzO4F
 In52YhL5HBedOrrTOj0ugoE9pDG4/9HRd7W4GgK1tRaauxesgEzyEqmQ0mLRgDhz
 1kSKfbvme5CEY9wktwY+YpxKqSEaJjgT8PR7DMFHw+f8t3C3QAs00o0AFdLAPCYl
 zXB8ISmbBaeZSrVpAzbKVfZK7k1mZv5KTON2jMMYRS6c14WbtOkaPaPUATN0e7gF
 OsEmclU3JPjFmg8D5pW3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794477222; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:DAVf736gLV2HMLUXZ+uoyH+OvuHYo9JBorWzmybETjSHf2L
 cAOPM19k0sM5FWZohHx368uma/KQ2T6fPXS8W12YzAE/YxPU3pTPRor2ZhYDCAx/
 EPd+lAMeJhIl2qk/oXCJP3XkDsOOPoNLEKSDBAJPzgCGGwxg0pZAQt0c9EInbr3d
 2kmULoV2RAU8a+ULBEFbwHx835mg1/GJ2LfWpo888bLQF7D5dsxdoOZtRwv8cYvV
 /0ppooao5dM6NeEwHY3L7qa2d/Ns60USyiagyjuGca9jgism9vYd7ZCN02FaUkVL
 jQFQOAhVdDsPfrBzDMfy+34KfmzXxOLFjMILm4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:PXKfjzRCx9HL2YAi8SSsT3xQB2VH22tuf9zrCIy/VYk=:MJlwrm96PI7R8iP/zhmZkLeUi31zS8pWmFR9wE+6zuk=;
X-ME-Sender: <xms:poz1asffHB4qhBGGVnLjDxoF2MbcbKnCktum6YpkcBBSehxWx15KEA>
 <xme:poz1anJryKSTD6MTmAA6AgduZjDqMbDJwFq6LF2gDpPfhTx3ojr241boRgzLXLF-3
 uqH0fHRn8zoAYSGh8d9RKu2Rmc80m4x5xhhQX1FlWNK2Wy2XhuC5KFF>
X-ME-Received: <xmr:poz1apFzL3nwGD9GgGndG3_PHqaE-0l_GmSdoIPqnQ33pqaXdEqkEJo0LvRNaq4768aWU9FrzKWi-7oLpUI3GlE>
X-ME-Proxy-Cause: dmFkZTE3CeDfcMEXDb1AO2Xbz4IACaczEsb3qSa1Q4Hq5FTVjJhj8Y9VBn1iru9ytSDqxQ
 bByCi1g0aPAEi6RAPMvZkKxXxE7pNoJV4kjOfetVk0p1fi9yf5MiEfmJDXIkWqWpm4bMv+
 OO4uSBDdldzUmUdepBUrUTe/Pm9mrxzO59S7KEYcSCiERlbP62OHVr2R5oBFtQdgNK67es
 D7xA9UI/auWEs87gNotTXn2pOSq4iVvixuW7Lhf4Ty2KIfCWpsglAzX7TFY5jWcQ6JSbSf
 5zwu33zGik0HGziQiq+8BQO1n6f+ZvaWgrckkCdqZSEvFcJkXakLUbk45KFNb96z+N9EYM
 ch+COFkWxFoBNYkNXFOcDO1w++6I7qJtkpOC6LLqchmWrxUlRwJWj+UrkgmmtguwAQ2FpY
 xxM069cimo97gb9Kq/zNmvCX29ZpUwHEpWIRXd8ktNYe8nNSfvhBM1Cfj6eGSGgEud1XJD
 ucJUcZI0oEPBBWH2rFGbDImUzBzEzRuRG0D3+dXPeJGOqs/IhOPeosyQAAvxrkWObXpqM6
 BQf8Gmb/r3fb5i3TBWwoRpxwXKWGRrxDepoW4FG4pDru9dZ3vpQFcJXBdsjNkOEliJPL/3
 kjnaJsGXM6Svv8sEmjOLHWeGvcziXUwMAiTXQElvodF/NCP7whEgS8pPTWmQ
X-ME-Proxy: <xmx:poz1aiC8JXqy_H-sY_FWTnE8OY2hLvMKsbJvMJ3Tq19zO5rsTknESw>
 <xmx:poz1ak80WV93zPsRYwauffhhR7Pdvlmxbkc1EkOi9dUWxsfFuYUmlQ>
 <xmx:poz1amCvu1zO1SwAweZ-rJbWoMFsWutRHD_wEWR7BE1Xc0YZ4H7Pmw>
 <xmx:poz1ahS7b24zTvrdPFfJh2fmsE9UjtnsTWDhmWQYPIcG5vIQbWT65A>
 <xmx:poz1aniHeytFJHr0AI_cdBHhBS1l5ZEZ-IUTJNGDyVkIXEz2Zs5LjtzL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 04:53:41 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 12 Nov 2026 10:53:28 +0100
Subject: [PATCH 1/3] hw/nvme: reject fdp.runs smaller than the lba data
 size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
In-Reply-To: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=AgfOxjW/9GaL9RU+r9CGq1PhXXHkOh+8vlrysn/5rVI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekF4ZWo3Y0wxaHJqL3ZTO
 GJUYWtrTVdWOTdGbkw1MkpjWGw1eGhsZDVSVUtYTWFYSjk2WjdTClZwLzVYZ2ZGR2s3L0s2bXFD
 KzFrTkdaaFlPUmlrQlZUWkFuU01GNVYrdWpPczBYdWFRZGdCckV5Z1V4aDRPSVUKZ0lua2lySC9
 NMTZjZUhsQmxrYit4ZTc3RDlQK0NFL3FkMk0rbzIrVitsR1pLVittSmNpcThVSE9lK01Vcm4rQw
 pMN3htQmQxYXVlVkFlN3lROUpPcTVCc202NTQrY2JVNCt5WFdMUDdPNmFDcTVSa1cwOFFXdkZne
 jFVMjFwTkg4CjFRbzFsZUw4cWptRlJva0h6ejlkZEY2dVg2WStPcW5XNWRESzZlZHFJeHJYck9U
 Y2VhRjNkclhVRWxIeG1TSnQKcll6bnZ2eXptTDl4OGIySERoeGxObW5tVXFiUEpjTllGTnBsZER
 1OUhCcC9aM1k4ZHRWYzFyQ2pKUEtoOTc5VApidjhmU1g0eVQyTmVkcVZvUitQdDNobUNzYnMxcm
 ZmVXQvOFNYakdwTVN3bXU0YjNTYTdIdEdPemhRNHQrTTlzCjNQK3J6VlJ4NmkwUHhsM1pLMExmV
 FkzVmJWUGZFVC90ZHptdlFRZS9XZlM1OHhjQlpwK21qZz09Cj1PeDR3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
is configured to be smaller than LBADS.

Reject such an invalid configuration upfront.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 2ae26a9acbd0..37d45bb4d533 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -485,6 +485,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     char *r, *p;
     uint16_t *ph;
 
+    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
+        error_setg(errp, "fdp.runs must be greater than or equal to the "
+                   "lba data size of the namespace");
+        return false;
+    }
+
     if (!ns->params.fdp.ruhs) {
         ns->fdp.nphs = 1;
         ph = ns->fdp.phs = g_new(uint16_t, 1);

-- 
2.53.0


