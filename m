Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4076606A321
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttS916bE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNKRP-0002UE-9C; Sat, 31 Oct 2026 21:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xNKRN-0002Td-Tk
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:32:57 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xNKRK-0000PJ-Un
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:32:57 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so2363324eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793496773; cv=none;
 d=google.com; s=arc-20260327;
 b=GN9NWI2Wegim4M4Ru64pJlhU4xMbyFDuYrkzvSG8NjICu9OMrdlH8qbrFU+7pdH75Z
 awaq3fAFpusbMoqMo4qI78rT4AND5p5pSHJjNC5qOjevWrPRPkhUJRDVkZ86qi43pLiZ
 +Xj6z0H3Oacf5x+NzLx14ZCAJDWfG6yz+6lCPAr8JNtyku3OBA3cG3VqmT4iJrnQWRYO
 csuAsHGCjfcx/wY2byn15bR42p/kZVAdtXljUARp6YVCC2b9uml2gHwCKU7OvF3xmLFd
 jX0q7qh983e7FstSYJaEdKpUVaxULKe9D6drKJGOrjIiQLbOvoeU/JgXMqZ4zUEPnWS0
 DSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LZI6FIpJFM2JgQGaViE4fFRO+g/rFEt9/AYRZHG2N8Q=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=SkE8ysotBxljVQZcmgJm8btNduyZisHGibThQxybuteU/2Nx6pmJRzyYTvFbu8lviK
 r45/pL0jhMMQA8uyAemLGKv623jOHJiUncynNBWfXkmm5YFYkOX8cws4pqCEbBXHq3C+
 /J030R5peTD4VYudxiToMd5MUY3skT5F21LeW32Q4hlJB/600O5+zQOdG6PdIrud6RN2
 RpMXOpBLZwaq+jsaNoPJLCy5C8J9a+VuD2MFq3m/R/t1bLkgUxSgf8NCgCgfl0dIX+jy
 kDsrW703JIaRaAge1NTVuwAhTWKdmbVQwu6WFIAL6/aBxLtnSYn7RPlUl2dlOMeJMGes
 gjbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793496773; x=1794101573; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LZI6FIpJFM2JgQGaViE4fFRO+g/rFEt9/AYRZHG2N8Q=;
 b=ttS916bEElKaVSCncDRm6q4w3GAHq194uHfAnNRfUcD+zZVj5Cuh+ASbzVCviIPhGb
 JXMc+whghhf7IsTArAUaA0PHmZxDiCJTnteQi0T0oWsQw50GFbv5CqLwSLZqa2Y4i9u6
 IoIA7ptpNyKKU/imxnbfGzjLzIdexQ3VEz/ts7rvgTCH5AKOCjqSrprUrL9qjPyyE1uQ
 QORd1Bt45siyV/vuAjHsU29jsGxrc2sAZtkfGyHazjeXBo9eMrI9D2F3D/2CKJ+mCvZt
 wo8l0fwYrlUQsvB5UYXIEIJ6zLidGjBzDsHq9DuCM+kG4L7bbp4mlf7AyN63lX77G85W
 rboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496773; x=1794101573;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LZI6FIpJFM2JgQGaViE4fFRO+g/rFEt9/AYRZHG2N8Q=;
 b=lIFqwaOTqR/PI2UQb4RWYkUZWUN89h3qqZk5yityYVSGew10Z9UR3MEHfiu7nsff9S
 zlPCale+cJrgb8OvUuOPJIbSyRMx97rTmRtismole9jrjdatOhtmrb76Q8/xmDAQZj2z
 r4f0LXSIebByZRn9YVzJPQy6HcuuQz3zixFrNyndgq0iPkyA4UK7EH+rX1IaMhaaRIQp
 Mh+WyfwSVf1UYgbWpULo4Qa8uKAaAz1d4sj088K93uW/JoSlTHFs9Udmbgj2ZhuBBkhA
 KtxWs+Ti2328jdMi7iYT+vbCcscnhJplkyp7Qlc1JolKD+JEnMlq3cPHJ1pV0bJKzqJD
 V3Dg==
X-Gm-Message-State: AFq9FYJiAPTu2Isn3mqMOpj/6rzuczscJDR2KolxRcOJ40/mquvLPKos
 InsRWQXVP42iO/iEOcu6uThJ4Ya8euqxgalQFVAZJCj3c+DTMrDsD2PrXVDPPI6w9KU85Vm8vHd
 oD0xfSyHiI+1ihdgHndlpAg+GGU26aMM=
X-Gm-Gg: AYBFou3+aPZvIgat5cMieO7JKkJITnYUIlrcdsOE7ZzYLzcxm4wI4ZBLqTYTE/iSdJX
 lOlO00i5QQ6ay7vZkg8hrrbf3AeYrVrwR6vOZcBdM2Zu/JhYCR+k3/wk4TqTPJjUWSpg1gZLeR5
 QOqLH3A09IQoNN3EPij/07YcPOaVyWz8SUti7vUYrallasFNjX3XRntuIQnXI8GeUCcgkHvwd2/
 X0M5ADNYiDnbIM/ff2u0DUtFNEI+bKSi5F7izFtQZTRCV2B7BXeo/Xzgsv4ytqSgxkoc6HZxJ5d
 IJyj/ttWDYV3XyKIcbAc2OiR1nlJaq9EkrsJv1XEesBBqMlMF1WcpHyiodC530111RIlEp04Z9A
 t8taBLEuKNqf/OFmDhPD3mAoKT6s2B+5J99ZET0rihAM4qluH9Na38oPC+OiXZRC13Pdsnok=
X-Received: by 2002:a05:693c:6316:b0:369:fbc1:89c2 with SMTP id
 5a478bee46e88-36a4235f4cemr9075684eec.8.1793496773016; Sat, 31 Oct 2026
 18:32:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031082849.1306244-1-pbonzini@redhat.com>
In-Reply-To: <20261031082849.1306244-1-pbonzini@redhat.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sun, 1 Nov 2026 11:32:40 +1000
X-Gm-Features: AclHuK8vb4UBx9ca_wFUNaxMAOIxsGdVBEXPfSv20H66Fc7Ogxa6GWw7reR9TGg
Message-ID: <CAGscdFu8E6q6CObDiMbxje1UOZpnO4CiQwFmABSgv3VxGhHqqA@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: reject VEX.NP for MMX instructions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, LOTS_OF_MONEY=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Paolo,

I've tested this patch against the real CPU (Intel Core i3-6100 to be exact).

Your approach with is_mmx() is way better than my local patch in terms
of completeness, as it systematically catches all MMX instructions
encoded with VEX prefix at once.

The only thing left to test is the OSFXSR check change.

Test program I used to verify this patch:
```c
#include <signal.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

sigjmp_buf buf;
volatile uint8_t* code = NULL;

void handle_signal(int signal)
{
    siglongjmp(buf, signal);
}

int execute_code(void)
{
    int sig = sigsetjmp(buf, 1);
    if (sig)
    {
        return sig;
    }

    void (*func)(void) = (void*)code;

    func();
    __builtin_unreachable();
}

int test_0f(uint8_t prefix, uint8_t opcode, uint8_t modrm)
{
    size_t i = 0;
    if (prefix)
    {
        code[i++] = prefix;
    }
    code[i++] = 0xf;
    code[i++] = opcode;
    code[i++] = modrm;

    memset(code + i, 0xcc, 16);
    return execute_code();
}

int test_vex(uint8_t prefix, uint8_t opcode, uint8_t modrm, int vex_l)
{
    uint8_t vex2 = 0xf8;

    switch (prefix)
    {
    case 0x00:
        break;
    case 0x66:
        vex2 |= 1;
        break;
    case 0xf2:
        vex2 |= 3;
        break;
    case 0xf3:
        vex2 |= 2;
        break;
    default:
        return 0;
    }

    if (vex_l)
    {
        vex2 |= 4;
    }

    code[0] = 0xc5;
    code[1] = vex2;
    code[2] = opcode;
    code[3] = modrm;

    memset(code + 4, 0xcc, 16);
    return execute_code();
}

int main(void)
{
    code = mmap(NULL, 0x1000,
                PROT_READ | PROT_WRITE | PROT_EXEC,
                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

    if (code == MAP_FAILED)
    {
        perror("mmap");
        return 1;
    }

    if (signal(SIGSEGV, handle_signal) == SIG_ERR)
    {
        perror("signal(SIGSEGV)");
        return 1;
    }

    if (signal(SIGILL,  handle_signal) == SIG_ERR)
    {
        perror("signal(SIGILL)");
        return 1;
    }

    if (signal(SIGTRAP, handle_signal) == SIG_ERR)
    {
        perror("signal(SIGTRAP)");
        return 1;
    }

    memset(code, 0xcc, 0x1000);

    uint8_t cur_byte = 0x00;
    while (1)
    {
        printf("%02x: ", cur_byte);

        switch (cur_byte)
        {
        case 0x34: // sysenter
        case 0xcc: // bswap
            puts("skipped");
            goto increment;
        default:
            break;
        }

        printf("0f:      %d %d %d %d\n",
               test_0f(0x00, cur_byte, 0xc0),
               test_0f(0x66, cur_byte, 0xc0),
               test_0f(0xf2, cur_byte, 0xc0),
               test_0f(0xf3, cur_byte, 0xc0));

        printf("    VEX.L=0: %d %d %d %d\n",
               test_vex(0x00, cur_byte, 0xc0, 0),
               test_vex(0x66, cur_byte, 0xc0, 0),
               test_vex(0xf2, cur_byte, 0xc0, 0),
               test_vex(0xf3, cur_byte, 0xc0, 0));

        printf("    VEX.L=1: %d %d %d %d\n",
               test_vex(0x00, cur_byte, 0xc0, 1),
               test_vex(0x66, cur_byte, 0xc0, 1),
               test_vex(0xf2, cur_byte, 0xc0, 1),
               test_vex(0xf3, cur_byte, 0xc0, 1));
increment:
        if (cur_byte == 0xff)
        {
            break;
        }
        cur_byte++;
    }

    return 0;
}
```
Results with your patch:
```
$ clang bruteforce_vex.c -Wall -g3 -o bruteforce_vex -static
< volatile-related warnings >
$ ./bruteforce_vex > out_i3_6100.txt
$ .../QEMU/build_dbg_nosan/qemu-x86_64 ./bruteforce_vex >
out_qemu_paolo_patch.txt
$ git diff ./out_qemu_paolo_patch.txt ./out_i3_6100.txt
diff --git a/./out_qemu_paolo_patch.txt b/./out_i3_6100.txt
index 7150fbe..b868b47 100644
--- a/./out_qemu_paolo_patch.txt
+++ b/./out_i3_6100.txt
@@ -22,10 +22,10 @@
 07: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-08: 0f:      5 5 5 5
+08: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-09: 0f:      5 5 5 5
+09: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 0a: 0f:      4 4 4 4
@@ -37,10 +37,10 @@
 0c: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-0d: 0f:      4 4 4 4
+0d: 0f:      5 5 5 5
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-0e: 0f:      5 5 5 5
+0e: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 0f: 0f:      4 4 4 4
@@ -52,8 +52,8 @@
 11: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
     VEX.L=1: 5 5 5 5
-12: 0f:      5 5 5 5
-    VEX.L=0: 5 5 5 5
+12: 0f:      5 4 5 5
+    VEX.L=0: 5 4 5 5
     VEX.L=1: 4 4 5 5
 13: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
@@ -64,9 +64,9 @@
 15: 0f:      5 5 4 4
     VEX.L=0: 5 5 4 4
     VEX.L=1: 5 5 4 4
-16: 0f:      5 5 4 5
-    VEX.L=0: 5 5 4 5
-    VEX.L=1: 4 5 4 5
+16: 0f:      5 4 4 5
+    VEX.L=0: 5 4 4 5
+    VEX.L=1: 4 4 4 5
 17: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -155,7 +155,7 @@
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 34: skipped
-35: 0f:      4 4 4 4
+35: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 36: 0f:      4 4 4 4
@@ -241,13 +241,13 @@
     VEX.L=1: 5 5 4 4
 51: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 52: 0f:      5 4 4 5
     VEX.L=0: 5 4 4 5
-    VEX.L=1: 5 4 4 4
+    VEX.L=1: 5 4 4 5
 53: 0f:      5 4 4 5
     VEX.L=0: 5 4 4 5
-    VEX.L=1: 5 4 4 4
+    VEX.L=1: 5 4 4 5
 54: 0f:      5 5 4 4
     VEX.L=0: 5 5 4 4
     VEX.L=1: 5 5 4 4
@@ -262,28 +262,28 @@
     VEX.L=1: 5 5 4 4
 58: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 59: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5a: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5b: 0f:      5 5 4 5
     VEX.L=0: 5 5 4 5
     VEX.L=1: 5 5 4 5
 5c: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5d: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5e: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5f: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 60: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
@@ -353,13 +353,13 @@
 76: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
-77: 0f:      5 5 5 5
-    VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 5 5
-78: 0f:      4 5 5 4
+77: 0f:      5 4 4 4
+    VEX.L=0: 5 4 4 4
+    VEX.L=1: 5 4 4 4
+78: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-79: 0f:      4 5 5 4
+79: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 7a: 0f:      4 4 4 4
@@ -376,7 +376,7 @@
     VEX.L=1: 4 5 5 4
 7e: 0f:      5 5 4 5
     VEX.L=0: 4 5 4 5
-    VEX.L=1: 4 5 4 4
+    VEX.L=1: 4 4 4 4
 7f: 0f:      5 5 4 5
     VEX.L=0: 4 5 4 5
     VEX.L=1: 4 5 4 5
@@ -580,7 +580,7 @@ c1: 0f:      5 5 5 5
     VEX.L=1: 4 4 4 4
 c2: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 c3: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -687,9 +687,9 @@ e5: 0f:      5 5 4 4
 e6: 0f:      4 5 5 5
     VEX.L=0: 4 5 5 5
     VEX.L=1: 4 5 5 5
-e7: 0f:      5 5 4 4
-    VEX.L=0: 4 5 4 4
-    VEX.L=1: 4 5 4 4
+e7: 0f:      4 4 4 4
+    VEX.L=0: 4 4 4 4
+    VEX.L=1: 4 4 4 4
 e8: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
@@ -735,7 +735,7 @@ f5: 0f:      5 5 4 4
 f6: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
-f7: 0f:      5 11 4 4
+f7: 0f:      11 11 4 4
     VEX.L=0: 4 11 4 4
     VEX.L=1: 4 4 4 4
 f8: 0f:      5 5 4 4
$
```
With my patch (for comparison):
```
$ git diff ./out_qemu_my_patch.txt ./out_i3_6100.txt
diff --git a/./out_qemu_my_patch.txt b/./out_i3_6100.txt
index 76d57a9..b868b47 100644
--- a/./out_qemu_my_patch.txt
+++ b/./out_i3_6100.txt
@@ -22,10 +22,10 @@
 07: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-08: 0f:      5 5 5 5
+08: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-09: 0f:      5 5 5 5
+09: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 0a: 0f:      4 4 4 4
@@ -37,10 +37,10 @@
 0c: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-0d: 0f:      4 4 4 4
+0d: 0f:      5 5 5 5
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-0e: 0f:      5 5 5 5
+0e: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 0f: 0f:      4 4 4 4
@@ -52,8 +52,8 @@
 11: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
     VEX.L=1: 5 5 5 5
-12: 0f:      5 5 5 5
-    VEX.L=0: 5 5 5 5
+12: 0f:      5 4 5 5
+    VEX.L=0: 5 4 5 5
     VEX.L=1: 4 4 5 5
 13: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
@@ -64,9 +64,9 @@
 15: 0f:      5 5 4 4
     VEX.L=0: 5 5 4 4
     VEX.L=1: 5 5 4 4
-16: 0f:      5 5 4 5
-    VEX.L=0: 5 5 4 5
-    VEX.L=1: 4 5 4 5
+16: 0f:      5 4 4 5
+    VEX.L=0: 5 4 4 5
+    VEX.L=1: 4 4 4 5
 17: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -155,7 +155,7 @@
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 34: skipped
-35: 0f:      4 4 4 4
+35: 0f:      11 11 11 11
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 36: 0f:      4 4 4 4
@@ -241,13 +241,13 @@
     VEX.L=1: 5 5 4 4
 51: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 52: 0f:      5 4 4 5
     VEX.L=0: 5 4 4 5
-    VEX.L=1: 5 4 4 4
+    VEX.L=1: 5 4 4 5
 53: 0f:      5 4 4 5
     VEX.L=0: 5 4 4 5
-    VEX.L=1: 5 4 4 4
+    VEX.L=1: 5 4 4 5
 54: 0f:      5 5 4 4
     VEX.L=0: 5 5 4 4
     VEX.L=1: 5 5 4 4
@@ -262,28 +262,28 @@
     VEX.L=1: 5 5 4 4
 58: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 59: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5a: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5b: 0f:      5 5 4 5
     VEX.L=0: 5 5 4 5
     VEX.L=1: 5 5 4 5
 5c: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5d: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5e: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 5f: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 60: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
@@ -297,14 +297,14 @@
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
 64: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 65: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 66: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 67: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
@@ -327,14 +327,14 @@
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
 6e: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 4 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 4 4 4
 6f: 0f:      5 5 4 5
-    VEX.L=0: 5 5 4 5
-    VEX.L=1: 5 5 4 5
+    VEX.L=0: 4 5 4 5
+    VEX.L=1: 4 5 4 5
 70: 0f:      5 5 5 5
-    VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 5 5
+    VEX.L=0: 4 5 5 5
+    VEX.L=1: 4 5 5 5
 71: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -345,21 +345,21 @@
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 74: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 75: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 76: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
-77: 0f:      5 5 5 5
-    VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 5 5
-78: 0f:      4 5 5 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
+77: 0f:      5 4 4 4
+    VEX.L=0: 5 4 4 4
+    VEX.L=1: 5 4 4 4
+78: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
-79: 0f:      4 5 5 4
+79: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
 7a: 0f:      4 4 4 4
@@ -375,11 +375,11 @@
     VEX.L=0: 4 5 5 4
     VEX.L=1: 4 5 5 4
 7e: 0f:      5 5 4 5
-    VEX.L=0: 5 5 4 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 5
+    VEX.L=1: 4 4 4 4
 7f: 0f:      5 5 4 5
-    VEX.L=0: 5 5 4 5
-    VEX.L=1: 5 5 4 5
+    VEX.L=0: 4 5 4 5
+    VEX.L=1: 4 5 4 5
 80: 0f:      5 5 5 5
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -580,7 +580,7 @@ c1: 0f:      5 5 5 5
     VEX.L=1: 4 4 4 4
 c2: 0f:      5 5 5 5
     VEX.L=0: 5 5 5 5
-    VEX.L=1: 5 5 4 4
+    VEX.L=1: 5 5 5 5
 c3: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -588,8 +588,8 @@ c4: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 4 4 4
 c5: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 4 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 4 4 4
 c6: 0f:      5 5 4 4
     VEX.L=0: 5 5 4 4
     VEX.L=1: 5 5 4 4
@@ -631,41 +631,41 @@ d3: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
 d4: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 d5: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 d6: 0f:      4 5 5 5
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 4 4 4
 d7: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 d8: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 d9: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 da: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 db: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 dc: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 dd: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 de: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 df: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 e0: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
@@ -687,33 +687,33 @@ e5: 0f:      5 5 4 4
 e6: 0f:      4 5 5 5
     VEX.L=0: 4 5 5 5
     VEX.L=1: 4 5 5 5
-e7: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+e7: 0f:      4 4 4 4
+    VEX.L=0: 4 4 4 4
+    VEX.L=1: 4 4 4 4
 e8: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 e9: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ea: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 eb: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ec: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ed: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ee: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ef: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 f0: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
@@ -735,30 +735,30 @@ f5: 0f:      5 5 4 4
 f6: 0f:      5 5 4 4
     VEX.L=0: 4 5 4 4
     VEX.L=1: 4 5 4 4
-f7: 0f:      5 11 4 4
-    VEX.L=0: 5 11 4 4
-    VEX.L=1: 5 4 4 4
+f7: 0f:      11 11 4 4
+    VEX.L=0: 4 11 4 4
+    VEX.L=1: 4 4 4 4
 f8: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 f9: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 fa: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 fb: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 fc: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 fd: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 fe: 0f:      5 5 4 4
-    VEX.L=0: 5 5 4 4
-    VEX.L=1: 5 5 4 4
+    VEX.L=0: 4 5 4 4
+    VEX.L=1: 4 5 4 4
 ff: 0f:      4 4 4 4
     VEX.L=0: 4 4 4 4
     VEX.L=1: 4 4 4 4
```

Thanks,
Andrey

