Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3792FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrny-0000Md-R9; Mon, 22 Jul 2024 08:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnf-0007St-W5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnb-0007uk-Tc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4UwUK1qyFt8jfRv5O/+Xfolt2iTAQ7FuHpfmrN0EbA=;
 b=VBNqbpYSuzpxKIPnbMWhqD76UvHTjyoSJqtCmt4ghzKEyv8UosaahoVaofZ0gPHjmm58p3
 6zyfdN0GLQX28uKAIL5jszMboHducXyypZ88yDFZHeuOyWn7nvwWIhuL54VeATdGOpwTHg
 poz/UPUQwjVb/SxfUiO7v4pPwdDREF0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-hYarwy8NMLG1VKJv20dvrQ-1; Mon, 22 Jul 2024 08:05:49 -0400
X-MC-Unique: hYarwy8NMLG1VKJv20dvrQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52efd629749so1736269e87.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649947; x=1722254747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4UwUK1qyFt8jfRv5O/+Xfolt2iTAQ7FuHpfmrN0EbA=;
 b=W8Cvl/kU3jv2p6P4OazL/iqeBCtikZsOp9KqRrVlRTgcCO9fcnZh0kmBDSndq3zV1P
 M4zDjF1rHn1V8e50kk5I+J3jp5BkAA0z4AvhWSsw7Q50Ea0j2duL7v9WbpYYXHeh4aqM
 jnAaAh7WxLZAyFEqvW+y98673j9YII5jUWXfR8mT2FW3r8oPB5KN2hUU3K2rAdzurKJC
 5e9zPSTO6ZCt7jukvbB7FoqRs8R20+H3JDE/WiYWCPNViGWuLRhGHK61gfdg7l57rngQ
 wK5MgS1WCc1DhGEKADs4CoHILgekfJraFh8aA4OnJUd/BpwnAW84Ae6BDKfD9IvXuCR6
 1Bug==
X-Gm-Message-State: AOJu0YwmsmTxpPnb6zOFM8R6TpsE/iOM3RVoKbHYD7tuFe4+3sjZc6J0
 uv+V/u3hp4h6QsvWc0KeN52mIwCyVv+kr33R9jfSXOqWRKgRO0P1i7n1/JxE0ofND2XQMuCcCWK
 Jvgn+PantnD6Fg9/GdimXiycxfOD1TvRZuic8zh42LA1r+4cc1dmXjoB0xm9KGedzdnSZqEOJP+
 vuLvw/xAnUiVTRTQOBqH6EcdRUhGbCvNF0TFZw
X-Received: by 2002:a2e:2e0d:0:b0:2ec:40cf:fa9 with SMTP id
 38308e7fff4ca-2ef167a6c3cmr45289081fa.29.1721649947726; 
 Mon, 22 Jul 2024 05:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuNxi/klocEARBunzUzS/wWDPUNc4nQwSBc4BYKXU+Z5Fzqo5X2tBdfWzpLoMmI7W2xClVPA==
X-Received: by 2002:a2e:2e0d:0:b0:2ec:40cf:fa9 with SMTP id
 38308e7fff4ca-2ef167a6c3cmr45288941fa.29.1721649947274; 
 Mon, 22 Jul 2024 05:05:47 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a3e642b647sm4913778a12.55.2024.07.22.05.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hpet: ignore high bits of comparator in 32-bit mode
Date: Mon, 22 Jul 2024 14:05:36 +0200
Message-ID: <20240722120541.70790-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722120541.70790-1-pbonzini@redhat.com>
References: <20240722120541.70790-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/timer/hpet.c       | 4 ++++
 hw/timer/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 58073df02b5..bbb1e5f0897 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -585,6 +585,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             break;
         case HPET_TN_CMP + 4: // comparator register high order
+            if (timer->config & HPET_TN_32BIT) {
+                trace_hpet_ram_write_invalid_tn_cmp();
+                break;
+            }
             trace_hpet_ram_write_tn_cmp(4);
             if (!timer_is_periodic(timer)
                 || (timer->config & HPET_TN_SETVAL)) {
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index de769f4b716..a5fafbc6796 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -111,6 +111,7 @@ hpet_ram_write_timer_id(uint64_t timer_id) "hpet_ram_writel timer_id = 0x%" PRIx
 hpet_ram_write_tn_cfg(void) "hpet_ram_writel HPET_TN_CFG"
 hpet_ram_write_invalid_tn_cfg(uint8_t reg_off) "invalid HPET_TN_CFG + %" PRIu8 " write"
 hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
+hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
 hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t counter) "HPET counter + %" PRIu8 "written. crt = 0x%" PRIx64 " -> 0x%" PRIx64
-- 
2.45.2


