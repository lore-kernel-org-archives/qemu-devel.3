Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF45A107760C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2wod-0005wx-Mc; Wed, 18 Mar 2026 15:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w2wa1-00030I-Lo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:29:21 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qguanni@gmail.com>) id 1w2wa0-0004VC-A1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 15:29:21 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-50912a097b0so1329341cf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773862159; x=1774466959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pZ1STxHanH7uDSXL/hEGwgt1+ssrfoHCJHHnIo3lWLQ=;
 b=a+vJkJQnmW7FPFzO5d03YwT6CN8EqJ18h3/s9YfWveywHiImPGxRVu3WqGzDzxb7Bw
 e+w88qmy/MRW1TY86UkgQ2KIzOAMFPEVHbd1xxMddHs1YoWvph6g5wU60n1JEFJeL+eJ
 qUQfxYRm4af2iBwDwYYiHcEKI5l0yAiHXBKy87PjCrShJxBDbryoRyAMpTIa4tm9bdhj
 oJ0vzIojACSgVgmj1A/cnsdqN/sYCw4UNCQgeXXn1hQvxZ/LKa1qMyglzg6xYwLb6tbI
 +dozrZMFMG/olLHhP3nZ32MT6EYdyuGyTxt2VCX2jm9zjtJ0bDR/+KYQ7j3LfgFiDOfe
 716A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773862159; x=1774466959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ1STxHanH7uDSXL/hEGwgt1+ssrfoHCJHHnIo3lWLQ=;
 b=asZIbCqsYndASlLtyTCyJRY2wuRHmq4K651sA/HxdyySKWbDRKVdy6D2QUPBU1Cy9S
 ljNIJUZSqu6F70BASLfmtXE/88DPNlOa+q2F9VLO4dgfNABMlC97MF8PVicGOk2vAVeE
 iEwfAIQKFIl4eATeE9eyRlFhaIydBnG6nG+yQGCdDi3K67GrXcuYbZnUj7KrNmAEAsrb
 1BxUd6o+fI6vshBfs1/3pxFnEp4/7bzbaR40jo9K3AubBYW7FLZjD7lM8Ddp+I9pbfv0
 +rqZYjfwJIfzZwIslhONaWHRpNpoCvCDDlqALcvipHNCRdBRKkHtkFrGkBsg+WAgaB4R
 Offg==
X-Gm-Message-State: AOJu0Ywwx1KC2kbUnlLZDYsKvOpSXIK+mtiqaUjUxHy5wkGOV4TfmBh9
 8BZMknckrN9QSxANF4PMWbklMhm3WpKayd+gQII7MwrvRiHUrYG3gFW8WJb50nKeFxI=
X-Gm-Gg: ATEYQzwG5+U82zlXxMX0Mo3lJVMEtZDN8OkRt9qUbJwxgipkM9x2umCFTlxqCc9pLjj
 YvOEHgGV7StTShtVdDoaoGCQF817+Ru1Y7tOe4te32J5Uck09BE54oMSsnFP2YHDjVDfRjwSgvu
 N3qiVXhQa1Eb5SDHT0kNRKhjnMNOe7dx/9lefLxcieypTTfVVidJxrleFzseNxpM90trzOqb5+G
 Q4ihtNArhDk3Qtmh45R/nvdUYvybMD3TIqtAJOhldEenwwKlwrvmaWC1zq0Vs4aZmbURiEm1HDa
 2UwQhQvp2BjKzAN/p4Xu50s6ChR/HQUUC/sD64kqdaTsp0/mapCCwNihEU5hfU98+5LuKMjdnDJ
 /Gzt6KwB4nvH5NZIqT7JASTsy1ob8zcnQcm4ldk9rSGQfh/L2S4Lp0hbgDlEJ3KlMz8uE/3cojB
 XeHnHJWGmJwO7UdN+R/18CLjPf5ehF4CxEdA==
X-Received: by 2002:ac8:5fd0:0:b0:509:23c5:328b with SMTP id
 d75a77b69052e-50b1485a788mr60445931cf.41.1773862158681; 
 Wed, 18 Mar 2026 12:29:18 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b135d523bsm28906831cf.27.2026.03.18.12.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 12:29:18 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH] hw/audio/sb16: validate VMState fields in post_load
Date: Wed, 18 Mar 2026 19:29:18 +0000
Message-Id: <20260318192918.65481-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=qguanni@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:25 -0400
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

The SB16 VMState loads in_index and out_data_len as raw INT32
values with no bounds validation. A crafted migration stream or
VM snapshot can set these to values exceeding their respective
buffer sizes (in2_data[10] and out_data[50]), causing heap OOB
write in dsp_write() and heap OOB read in dsp_read().

Add bounds checks in sb16_post_load() to reject invalid values
before they can be used as array indices.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3326
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 hw/audio/sb16.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 1b5e452a29..1838d3ef7b 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1286,6 +1286,13 @@ static int sb16_post_load (void *opaque, int version_id)
 {
     SB16State *s = opaque;
 
+
+    if (s->in_index < 0 || s->in_index > (int)sizeof(s->in2_data)) {
+        return -1;
+    }
+    if (s->out_data_len < 0 || s->out_data_len > (int)sizeof(s->out_data)) {
+        return -1;
+    }
     if (s->voice) {
         audio_be_close_out(s->audio_be, s->voice);
         s->voice = NULL;
-- 
2.34.1


