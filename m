Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BE606AA79
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=BnjBCMgU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOh-0004PK-D5; Tue, 10 Nov 2026 10:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOI-0003Od-70
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:11 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xQnOF-00005J-PS
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:04:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso946448f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1794323042; x=1794927842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTTOBszhae6b65tYdYeG+YHSC5v2PqdRKV+Vycg+4ck=;
 b=BnjBCMgUO4t8QxddEU05wGBLxUaYpcZtKKaZAE7kYGbGYiz7ohO9Z1G4ITcmmhKros
 Ow/TeOTfqCzGCK60RntJtXd35vylpIvT0GzlR93wLGpY2toOo7jlkHTCh1FutMAKxsGv
 fZ9gdlr0D5+dysdfBlpzIRi4KBzyNncUdgbO81AzPzLDvD4UF/WhtOXCXSfNzPwm8gMF
 cMigD+F/fHQoYfgFuq1w6dXvRl+T2EnYJM9F9iTJfIxGdQRMZxdUB3cx13H3/dAHHdxv
 HnQbRdEj+D4N917/nx3R5Pyfd176GwqDeq3/fuTCCrrNqowmAQ5DKVbt3WyxUYBZu8d3
 88Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794323042; x=1794927842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NTTOBszhae6b65tYdYeG+YHSC5v2PqdRKV+Vycg+4ck=;
 b=sOgPgb+aoXuhDX70kaMR6NBXVI7+fmbOxnNBKqFrtL9VU5wPl9wvcarMIsTOBh/0Uy
 aMTc92McfKwp0k1TFW7tW+nt2z/oi0ObYLXPV2+ddfcYSvqTmenQ8R/lJGs+SXdn7ZgV
 4H0ccvCbzY3BmljfU6xHDwYobCqq0iOrWHJmb6lEaciIpZln0RsjvAy8uRKx5bdNqVfz
 Yo9c2YGl5RY/vFgBnK5S+AWzXvg0P83Q0vVrh/r/rTIy1YK0Ss3c66iBVtFW2CYcfD5M
 j/XG3E6M7/ooRY/gTh+rfdjFjc0PVNhG/w5XFKmzUMCy0tRorlZwwwWdnaWCKp8xZYDi
 rnVA==
X-Gm-Message-State: APuU4Z/BjRAjglTq05BWlIZ5EDoLplG4dJS8RI+35VA59WV9pLZ7b9sC
 VLEe2c/fgB5u+emUkRInwvrbqyHlzkilZFANwu+0l9IPm0tzTkjrRsIaQwt2UtGnNjinuW8kD77
 iswrlxhc=
X-Gm-Gg: AYBFou0vy2oSPJDc913Xf26bCyQD/pMUxJLGODV5HamrnNDqWLTrpHhKVQCyJaIVCZk
 Q0zI4F4K/FZ7613sDIM86cn0FWx8dv0AlKDLtp7icqFt6T2valJYl1v00en1X+6GHge3gVncDOo
 6APV6WuawIYA0rhpB4gm7b41I3UIm4ZoAqIrW12R0Oyv0D6R6VFw0LFQxuZAvT5WdHVvwpjW8vk
 YSPGXTS17kytnA/2b1x5fG4SESaBLTcCgW7ayMI53NJrigK2BnYoV/2LabJ3EDWZkeFUdcpbmTw
 Q3T2dvTYoIlZ6SKtVjtKguRaTTTZikF6rXOoVYLv5T/3Khg4k/CWBklxsNn0tKIFGSiy0RnWEJC
 lJ5ivWRiUuqOsUyShR/4XiZIHlW+VX5mJfTsPPUdrdorAl/7U+XgPokeqoiVXIFZ2JJUaBgTI1h
 SxRMqusHIYctYgBUkxMZEsZc9hQpaV++zMri+LptS9yM9ZCwdYRY1BT3JGCvG+i8JPl92J6MZpm
 D4ix12wszfgQa9RowWeIFdSAYor2K+E84W/uXP6xLkNFCRQSPtaUhUExD6an9y6cprD3Yb/+lSc
 z98Br/4JyLLRz6cNjvtcYhKREI1hDuKGb09Vfk7o1TBIu5ahbFDNjPI59ZTrO8wilNZDMHNY
X-Received: by 2002:a05:6000:15d4:b0:492:ea10:b073 with SMTP id
 ffacd0b85a97d-4982f2b4abcmr4483348f8f.18.1794323042429; 
 Tue, 10 Nov 2026 07:04:02 -0800 (PST)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm5116931f8f.49.2026.11.10.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:04:02 -0800 (PST)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, yanfei.xu@bytedance.com,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH RESEND 10/13] migration/rdma: size reg_resp.len by the
 register request count
Date: Tue, 10 Nov 2026 16:02:44 +0100
Message-ID: <20261110150247.193208-11-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::432;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The destination assumed repeat=1; set reg_resp.len to one
RDMARegisterResult per requested chunk so a batched REGISTER_REQUEST is
answered in full.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index db1f1e3fc6..bffc7d33ef 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3870,6 +3870,8 @@ int rdma_registration_handle(QEMUFile *f)
             trace_rdma_registration_handle_register(head.repeat);
 
             reg_resp.repeat = head.repeat;
+            /* one result per requested chunk (source may batch registers) */
+            reg_resp.len = head.repeat * sizeof(RDMARegisterResult);
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
             /* Making sure the register buffers to read are valid */
-- 
2.39.5


