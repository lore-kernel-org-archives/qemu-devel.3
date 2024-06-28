Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB06C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPn-0005gj-Il; Fri, 28 Jun 2024 13:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPj-0005fk-S8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPh-0002EI-H5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpEB8RKh0nHTTV4SYs2ZNSxWI14Dka7ndAM1DOHLcLk=;
 b=FTmNe3ldfizufMmFLJ11LcU8T5I/vsmh7N4YGiCPyIMFUTYcxoZB5GWkKyI+ZPtHzLE7bl
 /epYgufu0h3LjQ9CUkP4dyDxbfjqBrrOY7fI7xL5oar0cmT+Ppw7Mc9MYzzzKAeeM4yzC8
 jR0BjrXCBzTHhguUM8OxPbBqqGtFbTQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-MpRZnYQRM4-QctaTEvycrg-1; Fri, 28 Jun 2024 13:29:31 -0400
X-MC-Unique: MpRZnYQRM4-QctaTEvycrg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a71e1625bdbso59775566b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595769; x=1720200569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpEB8RKh0nHTTV4SYs2ZNSxWI14Dka7ndAM1DOHLcLk=;
 b=W6+yhi4Wtfpo5p8lmjcJazelqSPyQsrOE9jZUmAWE5wIj5gMX1fxNEbqy5Qk95rdHV
 kcNJj05E/PoCUlq0DDTSyZMcbcjtCpyj3CFcfzD8tV7YWS6GwMX7CZqnXzH6qdUGtzkj
 9riAiK4jnFX2jTGnc3uqdSi5f+wbMMz87C5f4sPC0IspnOrKg4G8sVUgupTQTtvfwUqr
 WT3n/ImTa1nKjG/wL95NNbTPqcIx+o8sg+KhvlxiG9NHOPkfxFgrAAd20IYGqmi2tTz1
 BMwRZhfBQSA/6KAHBTI/zZYHtpj15HFLwpOYFoO1GbemoKbpep71Ul8iwv/J2qn/SIt+
 2wvA==
X-Gm-Message-State: AOJu0YzhpT8u/YQSW4H+V01ugVCucpSxXbALWZBEUfJ75SBTV90pXsK6
 kUxUW+zbuUJ0DDQdkQcdJj1MlwPmKvSfFMkmwxsb2hEqpGJwN8tbEfmHmDC+X07SGrdhwFb96Fj
 wabgSWiYjRKgvzQyJuL/edyx9qi4gZepB3RUrI3igbV/SZG2tcws64bPeVNquRspHDkKo8OCA2a
 OO1gw4w/mt98KTgZDjFOo2CgSedF3HrlCngmyw
X-Received: by 2002:a17:907:198e:b0:a72:61f7:7a0d with SMTP id
 a640c23a62f3a-a727f8be53emr800809266b.54.1719595769713; 
 Fri, 28 Jun 2024 10:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JhrTZXB5izSnjD0HY+jrEQJ3UHY6VbGMku7iSaWt+7eViISqg2e2qruSIDsTvhGPt0slcw==
X-Received: by 2002:a17:907:198e:b0:a72:61f7:7a0d with SMTP id
 a640c23a62f3a-a727f8be53emr800806766b.54.1719595769203; 
 Fri, 28 Jun 2024 10:29:29 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b56e6sm95334766b.202.2024.06.28.10.29.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/23] target/i386: fix CC_OP dump
Date: Fri, 28 Jun 2024 19:28:46 +0200
Message-ID: <20240628172855.1147598-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

POPCNT was missing, and the entries were all out of order after
ADCX/ADOX/ADCOX were moved close to EFLAGS.  Just use designated
initializers.

Fixes: 4885c3c4953 ("target-i386: Use ctpop helper", 2017-01-10)
Fixes: cc155f19717 ("target/i386: rewrite flags writeback for ADCX/ADOX", 2024-06-11)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu-dump.c | 101 +++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 40697064d92..3bb8e440916 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -28,69 +28,70 @@
 /* x86 debug */
 
 static const char *cc_op_str[CC_OP_NB] = {
-    "DYNAMIC",
-    "EFLAGS",
+    [CC_OP_DYNAMIC] = "DYNAMIC",
 
-    "MULB",
-    "MULW",
-    "MULL",
-    "MULQ",
+    [CC_OP_EFLAGS] = "EFLAGS",
+    [CC_OP_ADCX] = "ADCX",
+    [CC_OP_ADOX] = "ADOX",
+    [CC_OP_ADCOX] = "ADCOX",
 
-    "ADDB",
-    "ADDW",
-    "ADDL",
-    "ADDQ",
+    [CC_OP_MULB] = "MULB",
+    [CC_OP_MULW] = "MULW",
+    [CC_OP_MULL] = "MULL",
+    [CC_OP_MULQ] = "MULQ",
 
-    "ADCB",
-    "ADCW",
-    "ADCL",
-    "ADCQ",
+    [CC_OP_ADDB] = "ADDB",
+    [CC_OP_ADDW] = "ADDW",
+    [CC_OP_ADDL] = "ADDL",
+    [CC_OP_ADDQ] = "ADDQ",
 
-    "SUBB",
-    "SUBW",
-    "SUBL",
-    "SUBQ",
+    [CC_OP_ADCB] = "ADCB",
+    [CC_OP_ADCW] = "ADCW",
+    [CC_OP_ADCL] = "ADCL",
+    [CC_OP_ADCQ] = "ADCQ",
 
-    "SBBB",
-    "SBBW",
-    "SBBL",
-    "SBBQ",
+    [CC_OP_SUBB] = "SUBB",
+    [CC_OP_SUBW] = "SUBW",
+    [CC_OP_SUBL] = "SUBL",
+    [CC_OP_SUBQ] = "SUBQ",
 
-    "LOGICB",
-    "LOGICW",
-    "LOGICL",
-    "LOGICQ",
+    [CC_OP_SBBB] = "SBBB",
+    [CC_OP_SBBW] = "SBBW",
+    [CC_OP_SBBL] = "SBBL",
+    [CC_OP_SBBQ] = "SBBQ",
 
-    "INCB",
-    "INCW",
-    "INCL",
-    "INCQ",
+    [CC_OP_LOGICB] = "LOGICB",
+    [CC_OP_LOGICW] = "LOGICW",
+    [CC_OP_LOGICL] = "LOGICL",
+    [CC_OP_LOGICQ] = "LOGICQ",
 
-    "DECB",
-    "DECW",
-    "DECL",
-    "DECQ",
+    [CC_OP_INCB] = "INCB",
+    [CC_OP_INCW] = "INCW",
+    [CC_OP_INCL] = "INCL",
+    [CC_OP_INCQ] = "INCQ",
 
-    "SHLB",
-    "SHLW",
-    "SHLL",
-    "SHLQ",
+    [CC_OP_DECB] = "DECB",
+    [CC_OP_DECW] = "DECW",
+    [CC_OP_DECL] = "DECL",
+    [CC_OP_DECQ] = "DECQ",
 
-    "SARB",
-    "SARW",
-    "SARL",
-    "SARQ",
+    [CC_OP_SHLB] = "SHLB",
+    [CC_OP_SHLW] = "SHLW",
+    [CC_OP_SHLL] = "SHLL",
+    [CC_OP_SHLQ] = "SHLQ",
 
-    "BMILGB",
-    "BMILGW",
-    "BMILGL",
-    "BMILGQ",
+    [CC_OP_SARB] = "SARB",
+    [CC_OP_SARW] = "SARW",
+    [CC_OP_SARL] = "SARL",
+    [CC_OP_SARQ] = "SARQ",
 
-    "ADCX",
-    "ADOX",
-    "ADCOX",
+    [CC_OP_BMILGB] = "BMILGB",
+    [CC_OP_BMILGW] = "BMILGW",
+    [CC_OP_BMILGL] = "BMILGL",
+    [CC_OP_BMILGQ] = "BMILGQ",
 
-    "CLR",
+    [CC_OP_POPCNT] = "POPCNT",
+    [CC_OP_CLR] = "CLR",
 };
 
 static void
-- 
2.45.2


