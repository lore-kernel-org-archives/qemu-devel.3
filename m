Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F89D5D688
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98ax-0001Vs-Sg; Thu, 07 Nov 2024 14:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EhstZwYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com>)
 id 1t98av-0001Tk-F6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:05 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EhstZwYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com>)
 id 1t98as-0003KH-TQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:05 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ea258fe4b6so25991107b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009299; x=1731614099; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Z/XclSmqT8Xhgqma+tYcLYhVDFwTbVxhxPc4Sd2yjI=;
 b=ipc96J9GZq6QWQsckbNsetr6naEEjQigxVOuz7XCBliSo/UT9yHMg/k+oSmB9R2JEf
 3QmUSn8bgMw/k2UiZQbbO55srT2vMWfpJLYnK0//mR/raGdyx908XIXi0hrNqttvxHwc
 KheWPVoRS/sKdjXxb3hwj3K5UQjCBrJ4gTINDcCuoreqz/nTBJfUNTlGEzpsm7+DpBC4
 bA+ttdBe2bMU/HRmgNgciroWrBzdlhAOvHJSgMQS1YHwujW5JZKWLlPcocto4t3JSWNm
 Ikl/sWa2LXVYbW33RMU3+r5j85OHB/Gdix9SXStLw7dF+dWaYVlsgcdrrxRopou48k3r
 40Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009299; x=1731614099;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Z/XclSmqT8Xhgqma+tYcLYhVDFwTbVxhxPc4Sd2yjI=;
 b=flQKYCuuWh2r6twVBFs8mbl01EbLt8sUy/SxgVmajqFAGqWuPO7BA0bcuQUj0qvyNZ
 23nzOInty8hQr25Apb65sfQ/XCWZv0Eark/vLdwODlMu1VtK3boxlL7xXqU5Rj5eSZT7
 cbOK8fD/VZxWVLCSR7PIIoWtRXCeGNbim/eWnfQAMEsFrwNWNcXauqJuzQP/20F8sXNm
 WvQQ9MOPuY0y6NORKnqPeWmnotreHTaD2aASjOCtVUFBMIjqUEA3IHpadGRNcSTgKavb
 UohuMIPfyZGkFqYq5lMwiPQdl37D2DoqeYXoj6KDQmV51zdXNRVNnOYXbN9jmB3TAJnC
 17bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw6lAy4Pq0ix2k/9w5AYdO0uiNu2Eg5HrXNPrFEUjrKDr9X0fkAhSTNuF9aogVjydIpbisYiDSvy/I@nongnu.org
X-Gm-Message-State: AOJu0YybEafvi/XtvZbU386hO53wT0bZs7WU3UlxTjxZ+pdFockg48iT
 QajXrv5+Y8+rVwm/pSQmZz+4u8zUDLIFKmgcJtO1IX+8lMTEA6sjl9qkc/zza3RO558T2wTwwOz
 0mg==
X-Google-Smtp-Source: AGHT+IEoKLOtlze2ZJ2kJ2E+JQup5sz1gQfCuIsdgKc4JKTWxtcEwo2hpMqv8+7yB3w6Ijy1AVirAR//sig=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a05:690c:887:b0:6b2:6cd4:7f9a
 with SMTP id
 00721157ae682-6eaddff31bcmr1577b3.8.1731009298680; Thu, 07 Nov 2024 11:54:58
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:48 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-2-titusr@google.com>
Subject: [PATCH 1/6] bitops.h: add deposit16 function
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3EhstZwYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Makes it more explicit that 16 bit values are being used

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 2c0a2fe751..05179e3ded 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value, int start, int length)
     return ((int64_t)(value << (64 - length - start))) >> (64 - length);
 }
 
+/**
+ * deposit16:
+ * @value: initial value to insert bit field into
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ * @fieldval: the value to insert into the bit field
+ *
+ * Deposit @fieldval into the 16 bit @value at the bit field specified
+ * by the @start and @length parameters, and return the modified
+ * @value. Bits of @value outside the bit field are not modified.
+ * Bits of @fieldval above the least significant @length bits are
+ * ignored. The bit field must lie entirely within the 16 bit word.
+ * It is valid to request that all 16 bits are modified (ie @length
+ * 16 and @start 0).
+ *
+ * Returns: the modified @value.
+ */
+static inline uint16_t deposit16(uint16_t value, int start, int length,
+                                 uint16_t fieldval)
+{
+    uint16_t mask;
+    assert(start >= 0 && length > 0 && length <= 16 - start);
+    mask = (~0U >> (16 - length)) << start;
+    return (value & ~mask) | ((fieldval << start) & mask);
+}
+
 /**
  * deposit32:
  * @value: initial value to insert bit field into
-- 
2.47.0.277.g8800431eea-goog


