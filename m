Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5835D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZO6-0006Mr-5w; Thu, 31 Oct 2024 13:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMe-0002Cy-JJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMd-0007Qs-6h
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfEeFlk+R8zAtiR5LLisxBU0J+MuZk7bSGG/G+70Ejc=;
 b=fqR5FNy1A0zDBnPx1HJmXlVBqdaX4zToT7x4ZjFT27k1KinCXnDmKHpK2foox/T5rOfHtN
 9Ye0iqESnMLrkpoq7kVm3troQ2TpuzYjxJScLaJ93qr+aBuN/5qfr5LEWY19abftm1G1NE
 9bYrWDVOAHC60kU9oPerI7ghSOwsLII=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-qKMKySbROpCKqWaVv6Re6A-1; Thu, 31 Oct 2024 13:53:40 -0400
X-MC-Unique: qKMKySbROpCKqWaVv6Re6A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539ebb67c28so867046e87.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397218; x=1731002018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfEeFlk+R8zAtiR5LLisxBU0J+MuZk7bSGG/G+70Ejc=;
 b=s3mFnjM6Wn2Bf0W5iGfwU8KUMi3qEp7QzOgtB+x5jpK86mJnYkq659Mf+cGF+DxbIM
 B+sdy64D5A4QcqYNdxD6hqsirkby6kgMAd6UDQcvnNGKxZDFBFzSo7N7i3KVAnL7KeZJ
 B9XGgYKAekdtLl+eYWzgVXdNp0Ey+qZlIpUWj2elVIDuyIHAtp9oW/5n8b8mTYVBbI3j
 ZYWIhzGbjaD5Edf6tic3ArkDHE5PQO6ot2W6DcIf9p2Brm9HPaNFTo5sN7lSS4OVOgeK
 hwbrlvHePbw752mtKH8wVPBh6Yz96pjMbuXW989y/4FjSIuEO21dGFYq/qyJjnLjcprG
 jJbg==
X-Gm-Message-State: AOJu0YyQ3lT46jxM3x9fB9wlkKtRHb/K48XlfsKMFsMTw20Vo3NOchC3
 qD91r39+VU9f+CSG+L79pfsltIGnIbk0BTTxMMXCN918W5R53MKgPHH9z6Msj2q39AEcsApZe1v
 /JB/hY6OeXAZO2WRRcVVk3wuO4fjVZ+4cCZ4PqUHZ1mj4yOemMyfu7/W7ZvwLo972mkiEEm4FkQ
 de0ONz7kzy9YbonMFt4q3npmoslH9jCdhEU47ZCPM=
X-Received: by 2002:a05:6512:1150:b0:539:de0d:1e35 with SMTP id
 2adb3069b0e04-53d65dd0926mr643293e87.1.1730397218250; 
 Thu, 31 Oct 2024 10:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGYXaep6CJhsFfQm1gg7rF6r/EhfsuVtciyLHvoL1opdrd2iBcI+ntav+jw1ldxahjggZL/g==
X-Received: by 2002:a05:6512:1150:b0:539:de0d:1e35 with SMTP id
 2adb3069b0e04-53d65dd0926mr643265e87.1.1730397217713; 
 Thu, 31 Oct 2024 10:53:37 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac74ced8sm769988a12.17.2024.10.31.10.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/49] target/i386: add a note about gen_jcc1
Date: Thu, 31 Oct 2024 18:52:01 +0100
Message-ID: <20241031175214.214455-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


