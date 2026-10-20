Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4215606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sgDcwXpj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJHFQ-0001Fh-7R; Tue, 20 Oct 2026 17:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshit007k@gmail.com>)
 id 1xJFyE-0000tj-DN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:58:02 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harshit007k@gmail.com>)
 id 1xJFyA-0002AR-NS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:58:00 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36661f953e4so1684477eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792526275; x=1793131075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k5bVtPob8nDb670UIf/nSCwWgO6uUoQCRKkKN9lg+aU=;
 b=sgDcwXpjw4RMuYcHZsBYT5wdMNcrFJdUqKMirqusIeQoQjGSpjjc/+EF8vCS3lW1ZV
 MTC/pmyNB2but6y4vkfhEiMaf3vHEkjn0y394AdRi6X+FxTvhVGkD0o4Bbz0Vkv/9M/m
 J4eDo1PIcatH/yILURJPgMHLhoZLygq1UwOA3cXQDnG3d81ZwEjKee+DljVI1FgvAger
 LUeu/3+U9xepFuh2RXHp5+oFHTj6hkMbWgXDWXwRlnCNQxDPA5OOE3l+Hnv+A9SFCkeH
 HC5U8XuG78CA+jGK+uM/d2I7xjoY/yejeDreaNrcLdaHh121pss8bqK/0WnU4flCVkTs
 O8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792526275; x=1793131075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5bVtPob8nDb670UIf/nSCwWgO6uUoQCRKkKN9lg+aU=;
 b=yE+BZD77pXnRq4DQWYq0US1OHtbcsSbqSnhM72uO69dcSXIVYwKVaHTEFctmdnduyV
 UJ707xY3Z2IF7sJpJlu2pps4/YOBOSPHrrPzL4a0qjsr1aLs2yySL8jVBpazltrCww/R
 TrR2yemeH1rZuDwhmqKeO8YcRV+h8VFbUDLh2i4su34SHveFuXOud4mBs+aLdz/NJX/U
 gZdgTJA2W0RM/qHk0Ds9AoYTKR+XXMfBxkjve5jNUpW5gio9cwP1aCeJUIr17NncONro
 tm47RV5gpqrj6lvUTUstuyzGnDM3+rWdbe4EP+FvIvahdYTFIs9Op6d5mgaiD2xTLh6a
 nbMw==
X-Gm-Message-State: AFq9FYKw+7zLLKeH7D+FV7/8ZwylIC6SgifkWSTsz9B+9kBFEk5vqp+1
 AYIJd/ZElH3zJDHuLpyy/+JeSwlcfWwcBcwx9E6aH8TwIbvA7nPK1D8J+zaeoA==
X-Gm-Gg: AYBFou1HSgzrJnnHs8VCM/FqoTxypAdZysCy4tedSsAGxPP5s2ZYu7BORHe2SjkZ70S
 oHC3jTPbKJM7ZH6jB5O1vxXps0nlU6bXVU8IHLiRu+bL713k7xK6xHaAcV9zMS1nzesfv34RDbL
 DQRuZhA1q+FNFKJvtMaYmc0AIUPBRYniSlgiBVSNsObbdDM9mL/vtBAzXmeR1sG/A8pkoT/g7pa
 FTnzHWYZDUfBaqHtw23wrKZ971Xkslj8HtcMOKimIdAR6zaPBU14om7n7vcUY7125XB71fTFg17
 seN+a2oPe1mMdGK/WEh0iTpkMr7EXkI9VsxesKQxaxWNiqmMx47RhFuinDavUsbyy/lbb7aX++A
 e2D7MGSTR2JHiefPVovHtzkDCGK1dr+QYaXCnlX3EiOQrUCdvipAb3vl9axekJbSMQityIYX/AW
 sKxN8BPYGFKBoJJMUvHWXUisieM3eZ0wrDIHzUwHPUIUusME41JtFunPz26bOcSoO0ajIJi7ri6
 c6mnynVJIFHL4BGSw==
X-Received: by 2002:a05:693c:88c7:20b0:366:703c:5f0e with SMTP id
 5a478bee46e88-3674ef1f33cmr342221eec.35.1792526275412; 
 Tue, 20 Oct 2026 12:57:55 -0700 (PDT)
Received: from sys0 ([27.5.2.123]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm704057eec.8.2026.10.20.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:57:54 -0700 (PDT)
From: Harshit Mukhedkar <harshit007k@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Harshit Mukhedkar <harshit007k@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/sd/sd: validate migrated blk_len in post_load
Date: Wed, 21 Oct 2026 01:26:55 +0530
Message-ID: <20261020195655.135632-1-harshit007k@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=harshit007k@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:19:44 -0400
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Migration streams are untrusted input. A crafted stream can set
blk_len larger than the 512 byte data[] buffer, so a later block
read passes that length to blk_pread() and overflows data[] on
the host heap.

Reject such state in post_load.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4725
Reported-by: Karl Mehltretter
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
---
 hw/sd/sd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b1b3b1226a..6e7d04e25c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1073,11 +1073,24 @@ static int sd_vmstate_pre_load(void *opaque)
     return 0;
 }
 
+static int sd_vmstate_post_load(void *opaque, int version_id)
+{
+    SDState *sd = opaque;
+
+    /* Check for blk_len that overflows data[] */
+    if (sd->blk_len > sizeof(sd->data)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription sd_vmstate = {
     .name = "sd-card",
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
+    .post_load = sd_vmstate_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(4),
         VMSTATE_INT32(state, SDState),
-- 
2.56.0


