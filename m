Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD2EC25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0a-00053h-9U; Fri, 24 May 2024 04:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0U-0004yd-O8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0T-0000Kk-8d
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72PbcHRv/pFHTWTtQDS+C3T5q7MCkz97s7uPdQE0p0s=;
 b=X12wOEFrzSirl9TMVUMcdbYc+zP6tDTPWtdaTSd62YjYiuotuetic7BEY42ANSk9K6xXV0
 wFRiXL7jsbgbO/FnnkRUqcxQO/fDIXq4X/Nh5BTgpD4outEsf3vfeUDIB0kztSQ9B66bHK
 Y6EX2u/crUjDGew//nexWCsy6Q6/c+M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-k4kATvNQNva3TXGFF9Gxjw-1; Fri, 24 May 2024 04:10:26 -0400
X-MC-Unique: k4kATvNQNva3TXGFF9Gxjw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6269ad7288so23368966b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538224; x=1717143024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72PbcHRv/pFHTWTtQDS+C3T5q7MCkz97s7uPdQE0p0s=;
 b=A1nzt5j3HZZDypg0toBVYJQaEUGi7zr181eQATCzr+Xtre07D151S0jj3vi88P0vFx
 yTu3xhqDFEoZ+NanCUq4HYDLq0QGoPY5XKbDr3YmYsGdNjRF7OSzTeSYtwo5HA7od7+n
 dUGqR1x7WpRBQoiTebMbLPYDsSfJQKeST1dhEFfnsN6h/E/6W8uB6lAt21ADTcPbBr2l
 j553BrQeMuPhzseUtOaXlHtYx4ffd11oMguJF6aQKdFUEICnzw/+wOscwS/ZVf3ogEHL
 kpUCwFNU1j1/6hrA6lPGpzPSXygbHzw20BXSoamNlkY0I2A7g5KVhNCqBdIp07o2UxQr
 edRA==
X-Gm-Message-State: AOJu0Yxm4BNoAzp6pP8xSZTVUS8MOQ/QXo4QAsk/Evg1AZHyG7LhHVdd
 3XlhLNsXSSCsSL/aiq8vB/BDybXxBuldTDq0zrCOcuyH2Dfyu2Bily9MWQ9JgodOyW4+ivX7rCQ
 Dbh1lRMAvCcHaYrqAhR7bAt89Wc2KL2fGGNLZv0++GG36K9Ywiru8pC1cXHrO+r6rlX4nEmAJDp
 T8kZOi7jA/rK7r94s4WUUZd1D8MsVwIjgR5Cqy
X-Received: by 2002:a17:906:2b82:b0:a62:2cae:c10 with SMTP id
 a640c23a62f3a-a6264f1600dmr109627566b.47.1716538224433; 
 Fri, 24 May 2024 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVe1dL0yunhUsZRGQ99Cw800q/hFGYEbQ+PG473cDCldXlnmQ5EkE3CLVzZ91/CxAnN8E13w==
X-Received: by 2002:a17:906:2b82:b0:a62:2cae:c10 with SMTP id
 a640c23a62f3a-a6264f1600dmr109625666b.47.1716538224009; 
 Fri, 24 May 2024 01:10:24 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8c287sm89414966b.162.2024.05.24.01.10.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] target/i386: cleanup eob handling of RSM
Date: Fri, 24 May 2024 10:10:05 +0200
Message-ID: <20240524081019.1141359-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

gen_helper_rsm cannot generate an exception, and reloads the flags.
So there's no need to spill cc_op and update cpu_eip, but on the
other hand cc_op must be reset to CC_OP_EFLAGS before returning.

It all works by chance, because by spilling cc_op before the call
to the helper, it becomes non-dirty and gen_eob will not overwrite
the CC_OP_EFLAGS value that is placed there by the helper.  But
let's clean it up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f44edb3c29c..3c7d8d72144 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4488,9 +4488,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         /* we should not be in SMM mode */
         g_assert_not_reached();
 #else
-        gen_update_cc_op(s);
-        gen_update_eip_next(s);
         gen_helper_rsm(tcg_env);
+        set_cc_op(s, CC_OP_EFLAGS);
 #endif /* CONFIG_USER_ONLY */
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
-- 
2.45.1


