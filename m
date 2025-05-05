Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EECC3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 22:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC4DA-0003fk-Bi; Mon, 05 May 2025 18:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LToZaAcKCk404214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com>)
 id 1uC4D1-0003dS-M9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:22:47 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LToZaAcKCk404214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com>)
 id 1uC4Cz-0005jp-Oc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 18:22:47 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-22e3abea7e8so1070495ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746483758; x=1747088558; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jqO0x5cXWHJt1XEFG6wC08SK3tI3idJSXE7AdIKbSX4=;
 b=KhxazOFuhawJV66Z1pjAxqkxuNjFPTUWx+do6lGUlUDBy6uD0irkLNLeEQ4JjtYekK
 QAHxeiB+MOdm2tf+DUf1/91HYEeN3Sp+LH4JYboN6ZnQr0uuStxTc856oFP7mEy4bYjE
 52G/l+frwoJfkmYtL7MtoQ8739fvWMelUwIlacfZ+78+lsbzcXvc3sLknArgHS1C4Fum
 Y31TtAF/WVwvmPaLGCsLa0j/jD82MXJ8gnZUQLGwPO96ErB/FlRiYRHgEaJyjH7fbMYK
 +cggSqJ339efhEGzPr0r7KQOB29YDxtgniV4hOQbCEMVifPJkJ9391gvtBKfQTfIarbE
 YDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746483758; x=1747088558;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqO0x5cXWHJt1XEFG6wC08SK3tI3idJSXE7AdIKbSX4=;
 b=A9/ZSaaW9HmYo9Nu/U7q9JvAW06iKzxzH2+L9agbsJh0M+1GqPtQPMIMl1mUsSXJw0
 URbNmagFoSCpvDrfwG+enHFV10Vdqjg5ogQsPFobqCVfrFroohTaz/666uG4/YjIbHwT
 OIramKZhjv/W4uWl6LNpVvsJNnoG+a7evOB7ZSb+/AjCnPzkf06rciqhZWO95mKmj0Qt
 BIE5sEbdWQjXVAAM1zDcD7oe5knEgeUsbOyrI8QAhqU8DBuPB3KUzRBoLploDtbFes7a
 ii87dSAJNxDgPhs/e3SHZS/x5J10ms/vfDw9Mrs2otdWQOidOukypmxgUTGcqdVZeg3l
 cjIA==
X-Gm-Message-State: AOJu0YzSKP8y3324RQJEoLmTdTTJW8dlwI92b8SfiJJ63zWPgsKqSpHJ
 MLoyn0h4bYZNAbTsLM1yLVhd+roXY5pnk2zVscfQbLcqsCPIDp6ZL+FaxM2RuSOcNBO4rpRtwfU
 0iiEika3zlKxQy7GqPN8WQzMLx9AqBkDHcawn38M/1RiMgXlallYF0/5wbXHA0y+1S+9kF/qls3
 09a5KnjAaHOrAHnzGG+JhNioi+dXUhteYL8nwG
X-Google-Smtp-Source: AGHT+IGcRvcRCAKo2hSX5zf0jl5hVOLm72z+/ikED2ckElCXdviuBa6P1/2ny1xonP5hcwXE9up4ZQuj7syT
X-Received: from plhs15.prod.google.com ([2002:a17:903:320f:b0:21f:b748:a1c8])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc3:b0:22d:c605:a30c
 with SMTP id d9443c01a7336-22e1e8d326cmr132866555ad.11.1746483757977; Mon, 05
 May 2025 15:22:37 -0700 (PDT)
Date: Mon,  5 May 2025 22:22:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505222236.1616628-1-komlodi@google.com>
Subject: [PATCH] system/physmem: Fix UBSan finding in
 address_space_write_rom_internal
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, venture@google.com, pefoley@google.com, komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3LToZaAcKCk404214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

address_space_write_rom_internal can take in a NULL pointer for ptr if
it's only doing cache flushes instead of populating the ROM.

However, if building with --enable-ubsan, incrementing buf causes ubsan
to go off when doing cache flushes, since it will trigger on pointer
arithmetic on a NULL pointer, even if that NULL pointer doesn't get
dereferenced.

To fix this, we can move the buf incrementing to only be done when
writing data to ROM, since that's the only point where it gets
dereferenced and should be non-NULL.

Found by running:
qemu-system-aarch64 \
-machine virt \
-accel kvm

When built with --enable-ubsan.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 16cf557d1a..ccd2b50da3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3204,6 +3204,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
             case WRITE_DATA:
                 memcpy(ram_ptr, buf, l);
                 invalidate_and_set_dirty(mr, addr1, l);
+                buf += l;
                 break;
             case FLUSH_CACHE:
                 flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
@@ -3211,7 +3212,6 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
             }
         }
         len -= l;
-        buf += l;
         addr += l;
     }
     return MEMTX_OK;
-- 
2.49.0.967.g6a0df3ecc3-goog


