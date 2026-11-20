Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244F606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=gJPrdaPe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FP5FxAJf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNkz-0001ey-Lt; Fri, 20 Nov 2026 07:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkm-0001NQ-3o
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:13 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkj-0007yJ-Gy
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:07 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id C38111D00396
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:30:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795177804; x=
 1795264204; bh=aQipEKZMpKTAwW3KNIdry1hSneNyBPVb9HlZnJ//kcQ=; b=g
 JPrdaPecFehJjH25yIPhZaWglFY7AMnUiMhzDcmlvIqEco7QufOxFiqreTjT3kea
 drIYSJHu1qCwSPYxPJTVrsK2jh10sJ3KhP74DK5bTuX6jde8XcRVP4He21sUc1Da
 y8wc4b+q3rHtJ3QoyAtLghs2mGBmkZgkUFXviGnVsoOr7gZXCZbRAbRIXGHrpmnr
 2jVap1TKGHYFf/EYLXAPpLzfKtWBSaRNrfuEfiIJjwvTcwK9Hm8lXtMfgXQKZSem
 /Icv0LjRc6x7GtqE94aAl0crbDccLg9Iw0RdVOhiSxYu96VHmbb037Td3BEyqvRa
 JvN08rsNBrFIjhujkLh4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795177804; x=1795264204; bh=a
 QipEKZMpKTAwW3KNIdry1hSneNyBPVb9HlZnJ//kcQ=; b=FP5FxAJfj7Su5t1Rc
 H+CFnTpHQ8dAaKEmyvwdgIWKJyYYU4Xq7XNX9O9NH1/NvzGH6+Ag01zja65Or46J
 1ubtqS+PBYmZldhpaNStg7tqDdD2KhJpyTA33jilcyAyP9B6MCI1Afi2MTiA3G03
 Vl3uW3XukSDV/ZZ1BnnzRLYsx8EFbWN1ia7rFskUM/SJbGK/nL5o9/fkpr00IZg7
 RHo4PmI4hoQmVplHCxfzyQmjeJ6yO1yg8gb4wrBnAQXavTe2cjjZDvXCWuGrWp80
 pUqaN/B8iR6J0IeRBMd9JuVtX4jfUYhoAS8mO4rPdrCQPmX7tO/oSoY86iLjRQEK
 Qm6Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177804; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:Ju7Omh/kPD7Hrs0fYHTASurAKhKFdLVyoe7kE/FHzKISLCD
 41r5EQhzIYkMpB3JltNw2rfD1T+amoyvGe2P6jf3M8G8B2jCWuR+yFZUkei8mWgj
 ZCmXXgDwIAfkJ2I2H4irH1XMKYhQRpsBHnrnZoMaDA/xQKE1A0XVSItRz6CulG3D
 lnQevLQ3HJ1/PgWpa1wsqt2/WRPkZQ4dyIcDqt1kcTs6xHxpAYemTL2bSASeqq20
 n4XBiJAbzBEzustOyMeVBjXL1czrKy79MWF2ejWMP5wT4R5QFstW8DX4yLwp5nq9
 qwnjKSNMUfKHL98hxMyXIv4k4R8xqMxN16KIk2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:OK4We5emm/fGyedBDp2HgtTGclDc6LGm9HKl/LyGygs=:XiwQjiCBjMo6TDIEHyREAyLWo343krnwedmxA4bIYyU=;
X-ME-Sender: <xms:TD0Aa3WcOVxeRhffAK2wlY7KRRSzj8C6Zu6aTqjMfS-_Tdh83BHcKQ>
 <xme:TD0Aa5obQguw6WraSAAFN-pg1-n__yMlyZmWeZjN7qgytNWzrFqkt4wmbrhdAp9Iy
 7YGHaZfiurHvsZNqxjpLck0L6lk6O3T5nCc4lWi3yVVpY4-G6LIK9g>
X-ME-Received: <xmr:TD0AazR4xKE5v6Mk5QyL615L8AmIPuYIXe4S3PkESrEawIA5VfBw3OlNyEU7rk__RS03LSmDQdxAVwpUVVcx34cBfjN_EbqicpnMJo6GE9ig_yjHsFdImC9mbw>
X-ME-Proxy-Cause: dmFkZTFExTPYgg8rgO42EmNi083fhhkydGLyZE921u8lzGuruqpOi7Ge9E8B6a/id363MM
 M8BuWLLMO4fVvHkeGeOvWlpeoA6GU35EKJN3DgbiBVzuwXF8r2cHQLJg8fU0rGl2E0dOeO
 s+Nw2MlKxrILceBWhs3BK1ffPSR4HqonM4K29WT+QrvPJ096TStn1G84JjDR/oel6TQubk
 pyaFkaRhqF5OW/axUdI48bq8biSN19b82iagHYFTHVCw0Gkg9xAKDwvCK7KO0j7WxrJBUI
 ZB+43jhea1ublyYSN1UTeSHfOMWuASCGqIz4XcJ9chfm7jLNIur7l8entiBUQTObBo0PdH
 PjlFWipGkjgIJPq4TsqlP8xAxENKazdtS5T1VBxu3zFZtZN2cpx8rewXm7lCZZ84lcpzGs
 uphbH4AzQrIpd8uS+09koAQAGKk4VR7pyFit/zU8N520ALDLKp2d6DMKBLlPM8CFuWoRxl
 24KjUZbbJsJUJpPl2ixeJZQdxJZ36Ek+DM4v12YRH4V3wXEQw2kv+SGPUWownARxlL0yWp
 Wp/AGfOjyi4L2LIAEBn4KEdMe38iWDy8NvRRJG45zgJO/kGIN+Q805bOrh47d3EE8RqujS
 SDCzH5HVScJBitF4XqDvuI7ZV2CEOW3VRZcBmCDSkIV03IdS0vHuFY+p93uw
X-ME-Proxy: <xmx:TD0Aaz3h_to2O9dQIE4VyHwn5KzNlJAyOy5LvAl-Qb_gjGH4qizu0g>
 <xmx:TD0Aa_Byq1qnx2Fn-u1OgH9LRrsz28kFuXpeqTZWEoRCRPP-wHPsng>
 <xmx:TD0Aa_itbC4-4CtP-jafOKiDLofxvpQefbjStJa4UFTV0weivZ81lQ>
 <xmx:TD0AaxNxcQESrPvD3h4Ph4zB1oO0v9vBBLVBrAMpC9APKNkVPFyQvQ>
 <xmx:TD0Aa4dnz3t-zLy9oBCvABhnZP65prjGCuDDBPGyhGszI3BAztyXBCSb>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:30:02 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 3/5] hw/nvme: fix open zone zrwa allocation
Date: Fri, 20 Nov 2026 13:29:47 +0100
Message-ID: <20261120122949.1044-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120122949.1044-1-its@irrelevant.dk>
References: <20261120122949.1044-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_zrm_open_flags incorrectly allocates a ZRWA resource regardless of
the zone state. A ZRWA resource shall only be allocated if

    a) there are available ZRWA resources; and
    b) the zone is empty.

Fix the state machine and error out early.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5e8788a257da..16860ccd9520 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2038,10 +2038,19 @@ enum {
 static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, int flags)
 {
+    NvmeZoneState state = nvme_get_zone_state(zone);
+
+    bool zrwaa =
+        (flags & NVME_ZRM_ZRWA) && !(zone->d.za & NVME_ZA_ZRWA_VALID);
+
     int act = 0;
     uint16_t status;
 
-    switch (nvme_get_zone_state(zone)) {
+    if (zrwaa && state != NVME_ZONE_STATE_EMPTY) {
+        return NVME_INVALID_ZONE_OP | NVME_DNR;
+    }
+
+    switch (state) {
     case NVME_ZONE_STATE_EMPTY:
         act = 1;
 
@@ -2051,8 +2060,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         if (n->params.auto_transition_zones) {
             nvme_zrm_auto_transition_zone(ns);
         }
-        status = nvme_zns_check_resources(ns, act, 1,
-                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
+        status = nvme_zns_check_resources(ns, act, 1, zrwaa);
         if (status) {
             return status;
         }
@@ -2080,7 +2088,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         /* fallthrough */
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        if (flags & NVME_ZRM_ZRWA) {
+        if (zrwaa) {
             ns->zns.numzrwa--;
 
             zone->d.za |= NVME_ZA_ZRWA_VALID;
-- 
2.53.0


