Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45BCC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0FD-0004Z5-DD; Thu, 08 May 2025 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uD0FB-0004Y8-Qe
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uD0F9-0002I6-UY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746706850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ouSsJkJAFWb+y7cBhlR74l80lG1mzvrlsj4ZPiMQWYo=;
 b=I9sG6mR9mFLbu4XFLff8BCIYJ2r3AVc590HnKRAzh5KdbmHL5QSbR6Vfy7LDwD2jdPUxWQ
 dlZGfTcxzjZpryhBCembyu+VLmO1A0pDkjQwdwSt61pF7N+l3rIqyZVDwpzKnVFTH250ON
 77owH1GRL8fy0mYbUxUuo4L+5Q/40tY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-VaSQOYrsMvqYwibZbub5VA-1; Thu, 08 May 2025 08:20:49 -0400
X-MC-Unique: VaSQOYrsMvqYwibZbub5VA-1
X-Mimecast-MFC-AGG-ID: VaSQOYrsMvqYwibZbub5VA_1746706848
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b1f6815dso257311f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746706847; x=1747311647;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ouSsJkJAFWb+y7cBhlR74l80lG1mzvrlsj4ZPiMQWYo=;
 b=qILHToK3lpr2WByRzkknI942l6PmEK9oE97sGJz+F/WrxNtRhpRFrQi/sH6OGJs7GY
 2Keh57QLg6QIZHdGFCoLrUZP7Da5rbTPtLJdbuQo38Bt4jsmcaTq17VqqQNNyWw63F0s
 /yfSVbzbz9X4vIvJ8KQM3NQoYjpn5plevGAjH54XDWitBKf9VdfyW+ZmxCkXrYDanijY
 5rh0wkFsjYSsbpJe7WgVsIxN1lKeFkEAno+ULweO1fr8mEvV1UysR3YuNo4mWBbbrema
 enql94goTPO/WfiipUQ5u9vRqoyrIs7Iv2+RO42mkNsHQsGnsyJGVU8f4MyAN1FsU/8H
 EBrQ==
X-Gm-Message-State: AOJu0Yxrscmo0JqC4eX4RmeGC0QShXWeesoMP0amoFxI5Z0OPckcEd96
 Zjrv3PkDSa2eW2+HjA3Pb3/YI+M4zHGSZAKZnVjo74Mn2qXV5ZULKEy95A+EGU3KIG/IBWYCrFC
 H+p9UAHwRXmKYsJU9k0wU53YSId201miwwc/qubsc1gOXCT8Mkp8CTFPGWXUcj3NdKYpBEW41OC
 w3uW99wQEi/Pipjs/EzT/CZ2VKHboELA==
X-Gm-Gg: ASbGncvAhK6TXH2eM7rO3+QBM+Fl4/3Fd2MK0hwZtQU+dNhNEB8PwjBIqDd1fwbsWkG
 cGy8nKiM6ds1+MUVdAYlwbgWeQgxIlgtp41iaxsRdRRYBDTWBmlR3QxiamGMKhgceVzEQVIG7fY
 syxoiwrlxkiRluqXS7cvfUGCYyD0eJLB5reFJec0UKhRoFtEXp3hh4bkVNhbdHRSmrj1QT/eTv4
 ZgkAHLIGIl5B7cQFOrhC17HJItTp5HSHUVzkszCnzL7lCdu+YltB7QHsdlUrGDmNUhMYY/ylapz
 U5MYew==
X-Received: by 2002:a5d:648d:0:b0:39e:e217:28c0 with SMTP id
 ffacd0b85a97d-3a0b49e9e67mr5953015f8f.10.1746706847183; 
 Thu, 08 May 2025 05:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaXbZbsw3Bc7qU0hDjxBIETTDuyEDiucBYldtQtPMiFBa6+EYXy/cFTbLQKMpE7tfhbTd7vw==
X-Received: by 2002:a5d:648d:0:b0:39e:e217:28c0 with SMTP id
 ffacd0b85a97d-3a0b49e9e67mr5952987f8f.10.1746706846786; 
 Thu, 08 May 2025 05:20:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm35275485e9.39.2025.05.08.05.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 05:20:46 -0700 (PDT)
Date: Thu, 8 May 2025 08:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RFC] meson: require int128 type
Message-ID: <8c8f9a7e77e25a87b54335f7c376cb079fe67655.1746706766.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

compilers that QEMU requires support int128
(though arithmetic might be more challenging).
As virtio wants to use int128 with bitwise opts only,
make it simple by failing configure if not there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Hi guys,
any feedback on this one?
Lightly tested.


 include/qemu/int128.h                                | 6 +-----
 host/include/x86_64/host/atomic128-ldst.h.inc        | 5 -----
 host/include/x86_64/host/load-extract-al16-al8.h.inc | 6 ------
 meson.build                                          | 5 ++++-
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 174bd7dafb..299bc8f0bf 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -479,18 +479,14 @@ static inline void bswap128s(Int128 *s)
 #define INT128_MIN int128_make128(0, INT64_MIN)
 
 /*
- * When compiler supports a 128-bit type, define a combination of
+ * Define a combination of
  * a possible structure and the native types.  Ease parameter passing
  * via use of the transparent union extension.
  */
-#ifdef CONFIG_INT128_TYPE
 typedef union {
     __uint128_t u;
     __int128_t i;
     Int128 s;
 } Int128Alias __attribute__((transparent_union));
-#else
-typedef Int128 Int128Alias;
-#endif /* CONFIG_INT128_TYPE */
 
 #endif /* INT128_H */
diff --git a/host/include/x86_64/host/atomic128-ldst.h.inc b/host/include/x86_64/host/atomic128-ldst.h.inc
index 4c698e3246..2c313f4168 100644
--- a/host/include/x86_64/host/atomic128-ldst.h.inc
+++ b/host/include/x86_64/host/atomic128-ldst.h.inc
@@ -11,7 +11,6 @@
 #ifndef X86_64_ATOMIC128_LDST_H
 #define X86_64_ATOMIC128_LDST_H
 
-#ifdef CONFIG_INT128_TYPE
 #include "host/cpuinfo.h"
 #include "tcg/debug-assert.h"
 #include <immintrin.h>
@@ -67,9 +66,5 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
         } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
     }
 }
-#else
-/* Provide QEMU_ERROR stubs. */
-#include "host/include/generic/host/atomic128-ldst.h.inc"
-#endif
 
 #endif /* X86_64_ATOMIC128_LDST_H */
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h.inc b/host/include/x86_64/host/load-extract-al16-al8.h.inc
index b837c37868..d8c838a420 100644
--- a/host/include/x86_64/host/load-extract-al16-al8.h.inc
+++ b/host/include/x86_64/host/load-extract-al16-al8.h.inc
@@ -8,7 +8,6 @@
 #ifndef X86_64_LOAD_EXTRACT_AL16_AL8_H
 #define X86_64_LOAD_EXTRACT_AL16_AL8_H
 
-#ifdef CONFIG_INT128_TYPE
 #include "host/atomic128-ldst.h.inc"
 
 /**
@@ -41,10 +40,5 @@ load_atom_extract_al16_or_al8(void *pv, int s)
     }
     return int128_getlo(int128_urshift(r.s, shr));
 }
-#else
-/* Fallback definition that must be optimized away, or error.  */
-uint64_t QEMU_ERROR("unsupported atomic")
-    load_atom_extract_al16_or_al8(void *pv, int s);
-#endif
 
 #endif /* X86_64_LOAD_EXTRACT_AL16_AL8_H */
diff --git a/meson.build b/meson.build
index 41f68d3806..38186524da 100644
--- a/meson.build
+++ b/meson.build
@@ -2966,7 +2966,10 @@ has_int128_type = cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
-config_host_data.set('CONFIG_INT128_TYPE', has_int128_type)
+
+if not has_int128_type
+    error('You must use a compiler with int128 support to compile QEMU')
+endif
 
 has_int128 = has_int128_type and cc.links('''
   __int128_t a;
-- 
MST


