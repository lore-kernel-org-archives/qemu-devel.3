Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC18C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJJ-0005GX-Pf; Tue, 23 Jul 2024 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ4-0004d4-6G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJ2-0007AD-Bw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4UwUK1qyFt8jfRv5O/+Xfolt2iTAQ7FuHpfmrN0EbA=;
 b=E5i2m/iMvShpZYWboL4kItjAqy3wi7dP6cgOY8Gv2nuf+gchKpNuLFCmofM66CFAC5aPQg
 83F4HXnRJP4tEYV+I+I7AvERfGgjcvwnitmInCU4kw7a9yB8pxSyE5rNILPifYWanAiDWO
 Sb2Nf3IfX9YI3C93ctNa+8ZGk+SL/Qg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-S-FNa-odOm2Zc5HSaRm-FA-1; Tue, 23 Jul 2024 10:15:50 -0400
X-MC-Unique: S-FNa-odOm2Zc5HSaRm-FA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso38070985e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744149; x=1722348949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4UwUK1qyFt8jfRv5O/+Xfolt2iTAQ7FuHpfmrN0EbA=;
 b=W2KYipbf2uMl25G/8b8c6EQxjwrF/IS4qNBYPJQI2jJRpmT4TWFGXKMocURrpUIXFj
 FMc0h8XHN0QhssDophKMLvUjNEaEXERND5ov0iknT70RCOimM1jaz4mrpentcGnFXWL7
 GmRPWTqChBprHCtlDSr5GV2ohGrDEuiuQA1+Lu7mr7/ps4K2aOk6fRfN5T4jkpB+jYgy
 iomxJuNZAJn9u8AAMjFeFCibXzbM/T7QeaifjF+6gF/jORVAffA/ysWWdsD+Mgkqkd1W
 981aK0xkhRfMZRE+TIABNajf0Cl3G6S7sL4kO+pIorOpYT12bJlGxBigMBvx+gs0KPci
 gfLw==
X-Gm-Message-State: AOJu0YwZBGP0T3p4ATX5jkeLS+He6D02qSrDKVK+gBoLOkqX4SH7wIeC
 l+1RPCwfBmi4b9YZbhCyY/08nh86zLbv74Mdxof1GBmhigToF6hvD2aHdqyv///L4LqvJW3avfq
 ZViDBkLmOrjOs+mpMvaPP0VvCUhntCT0p21NMT8W44nS40GppuE2Pu2QAzQ301sYkzMS5j9FmkJ
 KygtsijNZcwzg01zEufYzLH0ETl0pQYDRU1R8W
X-Received: by 2002:a05:600c:c8f:b0:426:63f1:9a15 with SMTP id
 5b1f17b1804b1-427dc522d2dmr70943835e9.9.1721744148810; 
 Tue, 23 Jul 2024 07:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6NSUjybDJ6E5Uoo/bO34cTzL8+q0jMFDFnq1KXWKKtp+hW8IIjDHNVg3A5Y8xOkDN0CvuHw==
X-Received: by 2002:a05:600c:c8f:b0:426:63f1:9a15 with SMTP id
 5b1f17b1804b1-427dc522d2dmr70943665e9.9.1721744148354; 
 Tue, 23 Jul 2024 07:15:48 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ef3f459fsm15797165e9.0.2024.07.23.07.15.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hpet: ignore high bits of comparator in 32-bit mode
Date: Tue, 23 Jul 2024 16:15:24 +0200
Message-ID: <20240723141529.551737-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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


