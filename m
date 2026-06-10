Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46601CD98C8
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDmD-0006p1-75; Wed, 10 Jun 2026 03:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1wXDmA-0006or-Ua
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:55:02 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1wXDm8-0004KG-RX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
 s=gw2_bookworm; t=1781078098;
 bh=JV2eQqx6NVRJ5au8EJALAsLiH2qx8yivCf2C06d48M0=;
 h=From:Date:Subject:To:Cc:From;
 b=EQnFK37vKsKyw2uZAiVnga4jBn02FCuRw2I6XZbRozirXex6pKlvTQCtsEmWuQghz
 uBWa44/isaVm41ujI+0YNq4Tsd6CMVJo/s/Ck0CRZ655Cc1h7XqBnfCHPswnqctfRa
 ZAxzQx+1iC484MbKjybJCAFiPdB11vMBKxs8fkH7glUQkD66YXelWv7/TwIw3919eg
 zhIQndkL4RIWYrCuryaH0mYN5ZLbI9ykt3MDXYk7+UPOQieB5YWElmVlBREXJ2guB2
 Ab71RTyijKCBFKkCn5/2yBfCE36B7zi7ww/yOk28OEqa7hn9Oj//KFTPI+ZpdhnhZe
 x/nk/5fsKkLaQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
 by gw2.atmark-techno.com (Postfix) with ESMTP id 233EE3D5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 16:54:57 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com; dkim=pass (2048-bit key;
 unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com
 header.a=rsa-sha256 header.s=google header.b=D3dtzJQ3; 
 dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 7DD522BA
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 16:54:57 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so119509775ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atmark-techno.com; s=google; t=1781078096; x=1781682896; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+K9VinuW1cYSYNkLo69lnQLW+bHmMekXkSBk04MDlb8=;
 b=D3dtzJQ37S36B1JWI/zG/oxmrPQVAgUbOCcDa8bWbuAvrJTXbtZLZd28M3GNPnF+yj
 UmACbiYMygsXwmx4/v2/CM4VV1lAVUab3oan3E9mIIr4NFxyhnZnEqDuxOxVZcDnrYxY
 V/odkiUW9RbCPzvcikeltuhRD2tEvaJdj5hyqJUvMvW0ThLZOLm4Azw9jhh/KOPIvpxr
 sRgu3rVWq4VzeEiEZcBO9O59FLInFxQB/tlOtDoJ+BMD0GGsgSWJg4IrtPrkMKVcANza
 shkBSIehKkgxaHR2XKyymRfKoAEynTAG/ivCkydFFx7GiA4EronzlBUT++IecSR4m0v5
 nWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781078096; x=1781682896;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+K9VinuW1cYSYNkLo69lnQLW+bHmMekXkSBk04MDlb8=;
 b=idb+bJC5YnpoCSZiCbh4jbbfjBv/cWaTuDCAq42izmWKFin7IWmXY8EeXZ0xNrqUoM
 o0NAnO8VqgwNiK4HLxxTgvD65uqp8rhAQs/mxfwO1d3y80OpJUDGlL3F0Bx8GzG9lOUk
 7K26IKcYAMq+qwfdGtXoGUuppGP0l3hTvHJcgU3RIP9fhRyG1KM2gTx/WbAmqCu1uF+p
 CKozUhcea721faAWF1jSINNNL0GNIdHrWaVd4BOa7A2b+eWAlcxc6zI6BuqyOZqp7Top
 6lwqfqk3s581harcDOsrDNRJIFI11VG7udN2iq5jOIcV4k3hqtVHcXBWfQQUlKRFhrLJ
 ETow==
X-Gm-Message-State: AOJu0YwXaonmeWfBO9P796CVYMviu5sTTOSs+Mzl6dRvR5prwBe0eiRc
 nXaK9D5Vy2FgMYYEX4m3MZ5q/OGsjfJR4zXpY+qkhZQTbXuTDrVBXK3y1LrUAj07jlxvh5VC/yr
 6S7G8hguoHXGrhbbUU7r9C/nfBbu8awvDIFUxL0rRQV84VeTk2/nfYkaIzQ==
X-Gm-Gg: Acq92OHZwEgDso10Se16vX82x0h+8Xe+QofIpfzVNgwkcL5fZHRqnby4zoDrpZHb3EZ
 +VfXPSO05lrzVAKIN6Ftj0m/3ZgTv50SULUCiPxQlgqrj4oil/75OKJXJm/cX0J3pYfX2R0rxhU
 svVerCXSVMH8I2uPVCL9kV5v0GIXlYKNPiVaqRCvwdnanBGeFXJ1zvKZI1CAeH9xdkFrC1O2jza
 YQKY6s5b2NKID/Gfjm9NRqKjE1f1lH7mBrapjKtNwgKN34pLdEWEjEe/VxhiI3i1+2rlZU40xpS
 DnUykbpooHvmN8Av1ZO6uYRNwoBoxzoVVrr3yoWKjWJ7PXRKOVnE3fmpe1Pba53UumkIP8g+17s
 HLqYrjehJL/wyk/oehDmUhHP3shEg9DqTLw8x/Wem3GEl8c2UPR/QY7T70PeIRbFkEqdhCW/oHd
 RGM9hb
X-Received: by 2002:a17:903:2b0d:b0:2c1:b8af:18ab with SMTP id
 d9443c01a7336-2c1e847f410mr301013475ad.19.1781078096279; 
 Wed, 10 Jun 2026 00:54:56 -0700 (PDT)
X-Received: by 2002:a17:903:2b0d:b0:2c1:b8af:18ab with SMTP id
 d9443c01a7336-2c1e847f410mr301013195ad.19.1781078095895; 
 Wed, 10 Jun 2026 00:54:55 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2c16609e234sm244218025ad.53.2026.06.10.00.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 00:54:55 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Wed, 10 Jun 2026 07:54:52 +0000
Subject: [PATCH] linux-user: add preadv2/preadv2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-preadv2-v1-1-cac1737308bd@atmark-techno.com>
X-B4-Tracking: v=1; b=H4sIAEsYKWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MD3YKi1MSUMiNdMzNDM0MTI/MUMyNzJaBqoHhaZgXYpOjY2loANlF
 Ml1kAAAA=
X-Change-ID: 20260610-preadv2-66161427d627
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=JV2eQqx6NVRJ5au8EJALAsLiH2qx8yivCf2C06d48M0=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqKRhOSHHLlaFy1AcTTHsA5J6PSxhudbXOhKPbc
 DeELkdunEyJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCaikYTgAKCRDyimB/1oxx
 B3mJD/9mK0EhuGUp1NkR26pmZYl+aQN1q0V2TWelsem26Mi8y+z9UXQ9fY8+ZBFQ4PyYmc2j3ED
 FvJ6Hj5nJ2f0E5uxNjWmOi7tXb+B9G3ywxLFZdfvJHiqex65KcUdHM4ZXrMiTf0AA1mfaAVB1cl
 XPQmoW6A6dhs3bwiMSg7j10dlsgtej/hKpjdqF7O0uSdOlEKweowMRsG2VUxrxZtvXFo8DjUFsp
 XATENG8rDJbYGAY9/UoxSeFa1AgGDPq915T8SvimC1iIEsIzGYU3OM5uIGv/OR8hNgtG5dP7QFC
 ckjsGJD2aHZmzdNfVy2ohe1RFf/tidUAcS5dsMm1Xol0KNCQSEQ4N1yELkVDr/nDGPL4r8w+zu5
 MSE/QYJuP8/v5qAvoFy1iamS+rqxBGxKwD3ECAXA0CXc6OkkrPiTLazTCjGTa+x4nA0gjkX84WS
 iwdmhYZrM/x4y2262IH00/aJRVo2sj6IMrkzjpSlN6xNcUBQc4/FkNoACQpMt8t4/6qlZ0Dtkg1
 mThh/H412MVX2ugUeulgfDRpLfgBnA8tTv2DogarUTuCdDZ2z5KxzU6aO3pzUtVs+Vgg81YAKlQ
 OCmUVYGWsw4EwqmqFCszauKnqli8n841SduN3f74sQsH4TWK/h83LMmVawRdNOonYbngmi/s7LF
 bkKPaMeUdkpHzjA==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107
Received-SPF: pass client-ip=35.74.137.57;
 envelope-from=dominique.martinet@atmark-techno.com; helo=gw2.atmark-techno.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Some programs apparently use these, like the python test suite.

The flags argument (rwf_t) is an int, with values shared on all arches
and does not need translating.

This was tested manually with the following python script:
```
import os
fd = os.open('test', os.O_RDWR|os.O_CREAT)
os.pwritev(fd, [b'test', b'ok'], 0, os.RWF_HIPRI)
buf = [bytearray(3), bytearray(10)]
os.preadv(fd, buf, 0, os.RWF_HIPRI)
print(buf[0])
print(buf[1])
```

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
(the 80-column checkpatch warning made me wrap a couple of long lines
I'd find easier to read with 81 columns, so if you prefer I'd be happy
to resend without wrapping for pwrite2 safe_syscall6() declaration and
call, but it doesn't matter much either way)

Thanks!
---
 linux-user/syscall.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7d7a7b489cf93663c24b4e872f509793b7a06683..f1d98857d42dbad54f79f0b1ba5887334bae8fa4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -741,6 +741,11 @@ safe_syscall5(ssize_t, preadv, int, fd, const struct iovec *, iov, int, iovcnt,
               unsigned long, pos_l, unsigned long, pos_h)
 safe_syscall5(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
               unsigned long, pos_l, unsigned long, pos_h)
+safe_syscall6(ssize_t, preadv2, int, fd, const struct iovec *, iov, int, iovcnt,
+              unsigned long, pos_l, unsigned long, pos_h, __kernel_rwf_t, flags)
+safe_syscall6(ssize_t, pwritev2, int, fd, const struct iovec *, iov,
+              int, iovcnt, unsigned long, pos_l, unsigned long, pos_h,
+              __kernel_rwf_t, flags)
 safe_syscall3(int, connect, int, fd, const struct sockaddr *, addr,
               socklen_t, addrlen)
 safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len,
@@ -11894,6 +11899,39 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
            }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_preadv2)
+    case TARGET_NR_preadv2:
+        {
+            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+            if (vec != NULL) {
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_preadv2(arg1, vec, arg3, low, high, arg6));
+                unlock_iovec(vec, arg2, arg3, 1);
+            } else {
+                ret = -host_to_target_errno(errno);
+           }
+        }
+        return ret;
+#endif
+#if defined(TARGET_NR_pwritev2)
+    case TARGET_NR_pwritev2:
+        {
+            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+            if (vec != NULL) {
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_pwritev2(arg1, vec, arg3, low, high,
+                                              arg6));
+                unlock_iovec(vec, arg2, arg3, 0);
+            } else {
+                ret = -host_to_target_errno(errno);
+           }
+        }
+        return ret;
 #endif
     case TARGET_NR_getsid:
         return get_errno(getsid(arg1));

---
base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
change-id: 20260610-preadv2-66161427d627

Best regards,
-- 
Dominique Martinet <dominique.martinet@atmark-techno.com>



