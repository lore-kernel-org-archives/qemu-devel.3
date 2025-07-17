Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C79C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCq-0004gr-4a; Thu, 17 Jul 2025 14:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSO-0004co-Rn
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSM-0004KR-7N
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDBnlPqeGv4rwPb8eQVz5uOF6kllE9KhwMqiqUrgjcE=;
 b=HkyNIwDdXGHcqFzE++IkQMdC285jVxkTBLIjzIH05eYCC7/1vddlXl64c/Zz4s2zexELCV
 7D57RyWGKgKsGWtd6s0VY+u/DnMbiq1LepakiXcmmQkcfQn+WdPSExw+XYM+YqV6ptfEJQ
 hRjMdXoUwF2vUBcwMuHBhKj1Auc6n70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-NlHHr0ayOBKuHmvPZcSNZg-1; Thu, 17 Jul 2025 11:23:31 -0400
X-MC-Unique: NlHHr0ayOBKuHmvPZcSNZg-1
X-Mimecast-MFC-AGG-ID: NlHHr0ayOBKuHmvPZcSNZg_1752765809
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so6261255e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765808; x=1753370608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDBnlPqeGv4rwPb8eQVz5uOF6kllE9KhwMqiqUrgjcE=;
 b=Tjo/CpOqyQV/txyiqZc2JkGd/Aiksm5yAcLGOLId70/T6y4FUJj6hIniY3RoOl6v3D
 +FTXknzsUWYUwEL/4I4/+gatxwFlnRSowqNseAUBM1I1THrHun3fss/55oKdNRAyNGwx
 aYt31Z/jb6htvifX6dSCb3zccJEL2qXgyViw3zbRamim5U2wb10zqpGgUkVlBSKdzXIV
 VjjPjcggH+TxF8kqGk+U4b/8czoQHSTPQuwUVz0Hq6WbkjG+pbmi1/Qlgf1PEHDoMbFe
 SlQnet+gHwu7Sv5NRGIQr65BuWpoKw9wJWTm1fGQ91R/ygkx+uovR1cJHzBBMl8FWgcv
 2z3A==
X-Gm-Message-State: AOJu0YyC13E7P+87XIm7NDfqgXSjonrMVTvQTe2o3jnjQ5dDY1wY0/Q0
 uvJqLVO5jfbJ60ExqOZ3kQTUYtrPyW6XttxcasQprFg4uXSRMJmLHIIYkaHaEF5koGHlpV1W5Bs
 YfjdQgin4rMgUnIvXFRXTDljkRPSqGgPQJB1GCGKTstxJl5R/3yq6N5MO/5Ke9FhI97ELTm4apS
 g4R2+vpcl3hFrJ4U6pAkjXPwIxqr3T6g8Naf6YaDIU
X-Gm-Gg: ASbGnctwNBDRcJ/aweFULMDjfFx3j2naahoDpuqnW9AXhPfYOPsixRXepKotzAbGiPk
 vZrxd+RUWpFoxU6NLhPZliOF3XEXrxq0VEMMUx33GDtVtufW0JvueFGVtYQ4xg/ARmxviNEXi+l
 ZVexHWO4f4aAaoqiun+LNoR7KsYEhT8vAoY/p2A0Z1fdnwrRBwTYFSA+tyMRNYkD2z6w2HVexbh
 PgbCSQfyW+/S+Md73pw81iHoSASqKXxC2rrmW3DOWYpi3iG3YcO2lFRTfg/1H4WAjWqYx7hmyq4
 C8AVHM/N0tNZD4aMRhcje9w0+kkKa7GWDro3Baydp7w=
X-Received: by 2002:a05:600c:3b15:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-4562e36c7b1mr64527205e9.20.1752765808328; 
 Thu, 17 Jul 2025 08:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyN8eEMJD/Pih4TSdIuIrq9ldSM/t9VtjwaF21Y2H3uzUD9WAPATka0Ucye/+U88+to8Ecjw==
X-Received: by 2002:a05:600c:3b15:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-4562e36c7b1mr64526895e9.20.1752765807843; 
 Thu, 17 Jul 2025 08:23:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f9a53asm25053995e9.30.2025.07.17.08.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 4/6] target/i386: tdx: fix locking for interrupt injection
Date: Thu, 17 Jul 2025 17:23:14 +0200
Message-ID: <20250717152316.353049-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Take tdx_guest->lock when injecting the event notification interrupt into
the guest.

Fixes CID 1612364.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7d69d6d7b06..1574e7d76fe 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1126,10 +1126,15 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
-static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
+static void tdx_inject_interrupt(TdxGuest *tdx)
 {
     int ret;
+    uint32_t apicid, vector;
 
+    qemu_mutex_lock(&tdx->lock);
+    vector = tdx->event_notify_vector;
+    apicid = tdx->event_notify_apicid;
+    qemu_mutex_unlock(&tdx->lock);
     if (vector < 32 || vector > 255) {
         return;
     }
@@ -1179,8 +1184,7 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
         error_report("TDX: get-quote: failed to update GetQuote header.");
     }
 
-    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
-                         tdx_guest->event_notify_vector);
+    tdx_inject_interrupt(tdx);
 
     g_free(task->send_data);
     g_free(task->receive_buf);
-- 
2.50.1


