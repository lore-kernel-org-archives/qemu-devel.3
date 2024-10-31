Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F89D767F7
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZN0-0002pr-Oq; Thu, 31 Oct 2024 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMa-000294-Rl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMY-0007QY-SL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gI8QJXLbvQlRAcKrirWFR61Xh1xeLANavYLMQJ90kOI=;
 b=JaOIYePkj5kaHMmzkiQB0PHpPMEFH/nJU13ekEtGmmor7XlloSRnTYJgIh9VoxZ13+LwFo
 NnXDtZu5irJur324Q6+gLdHDsnzTwuO2h5NxOzlGRHY+pP8hcE9xTVNuTFDBwg5cSTc/fs
 rnOrJZvN5tPYW/4oxuMQ6hGNrxWlNF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kG1MiNf-OLm6GRMZLH0pyg-1; Thu, 31 Oct 2024 13:53:36 -0400
X-MC-Unique: kG1MiNf-OLm6GRMZLH0pyg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so7983245e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397214; x=1731002014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gI8QJXLbvQlRAcKrirWFR61Xh1xeLANavYLMQJ90kOI=;
 b=SSvd9wRlB7yyjts1CvSL7gnv8uTmsSbuzTwCRnN3z8g9PylzXRW2nClYPQCasrUeAX
 qZajIr2G5bCfQyzf73FpAdUdOMzxcrF0SLllM9Pfj7Zxp6QUftQx3RQTNCnrowLmkE6l
 QINbUmPM3G1HXpyt/4m3JzRk/DqnU+/hn9ntJH33OaX0qPEQI1YSD/uYaB9UghuZhw9h
 xuo01RYGFkQqDbK9EbV1uhAHjvmTlMXBCQ9kcooSjdup2OML24QMaGPyhOQkP/Eg5Vf8
 MQL59J2DMudjAU0wDKTh4hJ+v6+vF4kYkj9jBdjLakMHfNDLXSrXEWAs2RO8zGpWk7R3
 rM+g==
X-Gm-Message-State: AOJu0YwEIQKXWI51v2Q1EKs0GfCB+k4XAyydmvn1NXenngcuICdjwhSq
 kq4ErST5joC9bMBD22hQjTwWD6slOaJEpm+V+/LQFOm6wfRhfG8Q3aBto6LaBRXU/qmr236BWm+
 srO9lOK25yNC7GCbt+OjSK80Zetjh4k90njsb/5sO8pt/6/bcbr8TmqNikPER/Qw9AFZGDjuxsK
 YRYV8S40SAoVdlb/ENkcoWwcOsECyIrFGjkbVJPFQ=
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr14873665e9.12.1730397214349; 
 Thu, 31 Oct 2024 10:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoPnmzcJEFk3zWq3M6n0TOnoqzT/o89aclA9DYO1lTQTIvz117C0u29bO4GFqoQNIHyCDBSg==
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr14873425e9.12.1730397213849; 
 Thu, 31 Oct 2024 10:53:33 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e89csm2810264f8f.74.2024.10.31.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/49] target/i386: optimize TEST+Jxx sequences
Date: Thu, 31 Oct 2024 18:51:59 +0100
Message-ID: <20241031175214.214455-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mostly used for TEST+JG and TEST+JLE, but it is easy to cover
also JBE/JA and JL/JGE; shaves about 0.5% TCG ops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5e326ab1aff..d3bbcf7317c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1069,6 +1069,28 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         break;
 
+    case CC_OP_LOGICB ... CC_OP_LOGICQ:
+        /* Mostly used for test+jump */
+        size = s->cc_op - CC_OP_LOGICB;
+        switch (jcc_op) {
+        case JCC_BE:
+            /* CF = 0, becomes jz/je */
+            jcc_op = JCC_Z;
+            goto slow_jcc;
+        case JCC_L:
+            /* OF = 0, becomes js/jns */
+            jcc_op = JCC_S;
+            goto slow_jcc;
+        case JCC_LE:
+            /* SF or ZF, becomes signed <= 0 */
+            tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size | MO_SIGN);
+            cc = (CCPrepare) { .cond = TCG_COND_LE, .reg = cpu_cc_dst };
+            break;
+        default:
+            goto slow_jcc;
+        }
+        break;
+
     default:
     slow_jcc:
         /* This actually generates good code for JC, JZ and JS.  */
-- 
2.47.0


