Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE1D33996
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RX0-00005z-9q; Mon, 28 Oct 2024 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWp-0008Bk-1Q
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWm-0000ph-H1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tMRIuMzrz5AYgWyltwp7b/wxA+vnT9YlYCqkEpP2Rc=;
 b=RYdtevgafYWTwBnjz65zBAXqpUGPouONFNAg1buvaKlCsRFRZZ0p9DGv+bW2/l6lv19YVm
 SaVlGJZKPdwcRSTsdYZZ47hOXA5SYCxgra2fj4SmIc9ApSgX0kGFYivgNgS6GvrdJvmH8r
 ZabMnDuEZdqXtPaCzZIhToOjOxcTVJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-MW4MJRO3OD6lv778VLaphw-1; Mon, 28 Oct 2024 11:19:29 -0400
X-MC-Unique: MW4MJRO3OD6lv778VLaphw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so29533075e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128767; x=1730733567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tMRIuMzrz5AYgWyltwp7b/wxA+vnT9YlYCqkEpP2Rc=;
 b=XycqhJq++BZY1CmPk/H8tyUwMAWJpsK8O10FZdnBABaYYoX35xd/WelZjbMgnoFnk7
 /rNSakHdgFBMaRYrNlB1jVhomhye52x79OJlPHmeBT2A5M2V4b4qN3S6lDdhMC0OCw8j
 dGqUaCDQnlIOsxXxGPgHYCWpObltG5J/usOKse9RCKbssE7s4OqcpKxfCEt2gRMnYJ9g
 ZxLYt3/MFZJbhM8obHHtfQODs5f+yi1BUZfgCeev/arJ3nQAGQ8T1AgTyWrQ83vo1gT8
 AOzu3tgERaaQF11SpY1+3sqhstSSUipov9etXVkbsFrO2ayvFuWIU8+mCX7kTBTL8UIW
 w28Q==
X-Gm-Message-State: AOJu0Yw+Twy+CuPiTUojOzSI79iZ2tNXriC7MkoJKtDDkvEySmiOO6jD
 R5KmWR6s08j/zQ00/tElHTlUaJmVWx3BABFsWBYiqi0Xp4iVVlo7kpN7vBufXU2EtJwAGELVR5w
 lNmZNP3UhK+XIuMTZpNOSCXgsH1bSdBKFuH/0V2SI/gTliHt/EwBOcUTyHN0rvw6MDV7uk2JLVJ
 JbaU6SWMP/YBciANVyhnS5unoIpTyqDrwt4Y/xSDs=
X-Received: by 2002:a05:600c:3c9a:b0:431:5194:1687 with SMTP id
 5b1f17b1804b1-4319acb12bamr56916905e9.18.1730128767346; 
 Mon, 28 Oct 2024 08:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkSoaq1Unsjd7Ai1DZix5lDZCQMJorN7SvYDXdKXKCeZ02mKGl/t41Wd+ML+8DjzwtCkt7uQ==
X-Received: by 2002:a05:600c:3c9a:b0:431:5194:1687 with SMTP id
 5b1f17b1804b1-4319acb12bamr56916715e9.18.1730128766881; 
 Mon, 28 Oct 2024 08:19:26 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3c7f6sm9780221f8f.41.2024.10.28.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 10/14] target/i386: add a note about gen_jcc1
Date: Mon, 28 Oct 2024 16:18:47 +0100
Message-ID: <20241028151851.376355-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6e89d4faef1..5d729e68c98 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1193,6 +1193,10 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
+    /*
+     * Note that this must be _after_ gen_prepare_cc, because it
+     * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
+     */
     gen_update_cc_op(s);
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
-- 
2.47.0


