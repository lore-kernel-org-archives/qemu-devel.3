Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55FFCCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDb-00055C-KV; Tue, 14 Oct 2025 09:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDX-0004rw-3d
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDT-0000yR-PP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjuuT5ps9Dfi0wcjSzFfW+GOqbh1dg4/Hs0SayeiIrQ=;
 b=GcXlvhnl3Rurz/OqJ1+MRm9JQnzm5ub5l3ugEi9Sz9Dg8Sgjpql9cRwlds7D+jkY4yoc8l
 WjDUHg8zGhhFFJtNPmoGxTOGfTgbeAlx2gpFiYjVQFXzrp9R5V1M6J3ijthIV1j9b8LEuq
 aX1/Y95eQ+4NfByJZK+QxO9rWbDWoL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-m020g0RuNYeHTRlk2LDHgw-1; Tue, 14 Oct 2025 09:37:24 -0400
X-MC-Unique: m020g0RuNYeHTRlk2LDHgw-1
X-Mimecast-MFC-AGG-ID: m020g0RuNYeHTRlk2LDHgw_1760449044
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso30829595e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449042; x=1761053842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjuuT5ps9Dfi0wcjSzFfW+GOqbh1dg4/Hs0SayeiIrQ=;
 b=CaPoKkpYAPs8ot1orJk49uaHxQNFUYJfqTwFkclp55O3XycVs6MFiNAvy++tVaCer0
 wRW04n4fUc5z1XpFKRiL3FIIVXAf0JJmmq6WrnQnD38x8OQWHSZFEeYwlBdQMFM8j0SI
 VokQB2w63YhgTtw50DS0nDchqvVwmrFv6RfUpz0hAr604u541YzmFFAMUOoDvNJuUBsv
 xl39HomaLhzIyC6We8z4Ml5YBByUKCPYmM/gniajMrH27ietbFZ2j0vmlTQOR1EZZ7xB
 vJuhnZ1H2F+/AcAetfA9IfZFZCoC+KJGWyX2qH05Zq/FlGCvYMI+OBM2YZj/TQr+XsbO
 EhsA==
X-Gm-Message-State: AOJu0YwDy13orWeMqhcO2b3La3NSXoqk2WZhlAWuuBVH7/0CSCumyvAl
 tubVfyt1tdOHREejgDsXChILn6ive4yFVQkc9WVA65F1JN7FJRZCBGQIzuSI66CPCriOGERq9DK
 Rjokw+jnVS+kpus5YLw57SwRhv1i/LzX+3CjjnjDQM8ji4YghoZzlVNQD6wfMgTr23Z+vQVYVo1
 9fkzn5pn7rQss1W7umb9NMPRn5Xh0/W0tto8Kwhb2M
X-Gm-Gg: ASbGncsAtdNWBOL2U65SetLqHw4rG7Eyjt6oS7Unub/MemZVfSyn+TEFmr7Poa+uBJH
 aWFcjxC2ziWWkT6gWfQv/ImN4N2x31mKo2bUOQ/bkHH89Bo41hj30/8O1Gowt7qKIhw0SVqjsWF
 LSfXAwg9v4S9/KlZJxU97aIF2B3AG2h5MTCJdtFqdyjyMnkQB3nFVS46qig/mqvUTpyp9CL812h
 PQrBQdTnButYYtbv4o/6f6hX7KZWoikKsgrkoDB1lDROe2nsm2YysFcCnHPPe7hpNxVRvs2GK8M
 ev0esvxKyjxL3wbHmWzt/51wrGq7abPeWKRGtTdSvVAS7Slp4I1FrX1s/g1iR6pkK+iCXk4ozYf
 wGbrdElRKTVW+cOyH+wjKyFStO1Gb0Z6Jp88tFH00btI=
X-Received: by 2002:a05:600c:6487:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-46fa9a8f0cemr160858255e9.5.1760449042458; 
 Tue, 14 Oct 2025 06:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz9AQzpHhBkTuqISA71C/vLz0QatAKj7rneETun4Wd4LAeAmU2VW/RUC3bf8fCj5r+f9ysxQ==
X-Received: by 2002:a05:600c:6487:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-46fa9a8f0cemr160858095e9.5.1760449042048; 
 Tue, 14 Oct 2025 06:37:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ed61d31esm4697479f8f.52.2025.10.14.06.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/28] rust: hpet: fix fw_cfg handling
Date: Tue, 14 Oct 2025 15:36:49 +0200
Message-ID: <20251014133713.1103695-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

HPET ids for fw_cfg are not assigned correctly, because there
is a read but no write.  This is caught by nightly Rust as
an unused-assignments warning, so fix it.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index e569b57b93b..bb4ea8909ad 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -40,7 +40,7 @@ pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
 
         if fw_cfg.count == u8::MAX {
             // first instance
@@ -60,7 +60,7 @@ pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64)
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
 
         fw_cfg.hpet[hpet_id].event_timer_block_id = timer_block_id;
         fw_cfg.hpet[hpet_id].address = address;
-- 
2.51.0


