Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E30C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezIA-00069E-9Z; Tue, 27 Feb 2024 10:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezI8-00068W-SA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:22:48 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezI5-0002tx-51
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:22:48 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-512fd840142so2887343e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709047361; x=1709652161; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3r8V58Tug1KOPNSReT2NhBd9guHe8F/CbAoauzdmNZc=;
 b=MCuSmsYJOXiVRca+iAxcVkyKy9zPwh5MjOO+LE7E4930kmAmm3PKmBhApXVFSmw3Jz
 0m0RyF8NbpWzDejfwNr1qdZBaCaoGF2yHhigcQhzX3J5wG36JTrfFVdoMw5aq2X6DLkk
 SF/U1tyOO1k62LytqhEIJ3Q0e2kHbYCoKrDpXQ4/w4FdteIiiUQUl1g1EssTM5GoH9A+
 ZJ0trH4/vpYxoUjhgtgb4txj9jvGGkn7Dv7/bD+pkOoj0XHQ4E445p5XtmtHLXSi5g/0
 sViLozcrpQLLCSbUWtsQo971lSp5w5O+nA6jP7H6WOglgmQPihA5wvryTQvS8Ja+el8b
 wsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709047361; x=1709652161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3r8V58Tug1KOPNSReT2NhBd9guHe8F/CbAoauzdmNZc=;
 b=Bqo1B6PggEK1bSqeLq1ReB1A8XTJ4v5X9pg3dkL10EFyB6j/BjzwiWslG/nSFXnHoi
 auqE7vkOnro4De6s3SWEJ68HzmlDyvquiIz9TerrH+/6K8Gg8jBKsd0TXVrq+BPUGDmU
 pYJyvT5sdW1a4EteUZ5jR4fIMt/SFAZlN8bCtlgVXo3/YH5ZLIspmm+R3lDSjF8VwN7g
 lyduzXw2xH4Rmdhk37X7QIGBpxoJkGdZNZ++RROBuRNmSZCsHU/H933g3eN9rjMEROsB
 O5QQKUxeS8DA/NEcS8s27pmGDNShemkcuOUHS/xabEHKeXBlQQahmtfJhEHQaertYqUR
 LTOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCZso44iCWhNObX3Vu3NS7vSm/AwC64edeSGjKw16CHeW+RpvnLAODI4oEyLkDFZFgZl9Ad5cu0kgnkPUP0Ai4goYHGdU=
X-Gm-Message-State: AOJu0Yxz3EmeJxbjISB2HPBvPtlWLKXnJAz2zLAawCagEwVr8bp5t+lQ
 sgrdmJZtuQxzfy4buwhDONPQaojBBm+Kuz1L84iXLuBF3f1vf9zg+9aWYyTmawfnzZ65XurIxaF
 0BMcVPBCuUe9fP5BQLzLtQQkGizQwpajBNmiJgS4ALXdhMNcy
X-Google-Smtp-Source: AGHT+IGYRAcV/BJK7x0AXdict+ZcLIKuc7/wcZeGzNyV9jL5U7RoHu6zUogPNkBgg2YHYZUHsVxS/EYQI8ZFSr2gMxA=
X-Received: by 2002:ac2:488f:0:b0:512:ec79:3be5 with SMTP id
 x15-20020ac2488f000000b00512ec793be5mr5847996lfc.43.1709047361129; Tue, 27
 Feb 2024 07:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 15:22:29 +0000
Message-ID: <CAFEAcA_oSeqGAPNpemhbyVkuMYtwbr-TG2QNQ7=DSZv0s0h7XA@mail.gmail.com>
Subject: Re: [PATCH v6 00/41] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:04, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.

Hi; I had to drop the qtest patches from what I'm going to
apply upstream, because it turns out that they don't pass
if the host system is big-endian. This is because you read
out memory from the guest directly into a host struct:
that only works if the host happens to be the same endianness
(little) as the guest.

One possible way to deal with this would be the following:

+/*
+ * Read and write fields that are in little-endian order. Based on
+ * the linux-user/qemu.h __put_user_e and __get_user_e macros.
+ */
+#define put_guest_field(x, hptr)                                            \
+    do {                                                                    \
+        (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_le_p,               \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_le_p,               \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_le_p, abort))))     \
+            ((hptr), (x)), (void)0);                                        \
+    } while (0)
+
+#define get_guest_field(x, hptr)                                            \
+    do {                                                                    \
+        ((x) = (typeof(*hptr))(                                             \
+        __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_le_p,              \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_le_p,               \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_le_p, abort))))     \
+            (hptr)), (void)0);                                              \
+    } while (0)
+
 /*----------------------------------------------------------------------------*/
 #define DECLARE_TEST_CASE(testname, ...)
         \
     __attribute__((weak))
         \
@@ -59,38 +82,41 @@ FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)
         } mailbox_buffer = { 0 };
         \

         \
         QTestState *qts = qtest_init("-machine raspi4b");
         \
+        uint32_t req_resp_code, tag_id, size_stat, size, success;
         \

         \
-        mailbox_buffer.header.size = sizeof(mailbox_buffer);
         \
-        mailbox_buffer.header.req_resp_code = MBOX_PROCESS_REQUEST;
         \
+        put_guest_field(sizeof(mailbox_buffer),
&mailbox_buffer.header.size);  \
+        put_guest_field(MBOX_PROCESS_REQUEST,
         \
+                        &mailbox_buffer.header.req_resp_code);
         \

         \
-        mailbox_buffer.tag.id = TEST_TAG(testname);
         \
-        mailbox_buffer.tag.value_buffer_size = MAX(
         \
+        put_guest_field(TEST_TAG(testname), &mailbox_buffer.tag.id);
         \
+        put_guest_field(MAX(
         \
             sizeof(mailbox_buffer.tag.request.value),
         \
-            sizeof(mailbox_buffer.tag.response.value));
         \
-        mailbox_buffer.tag.request.zero = 0;
         \
+            sizeof(mailbox_buffer.tag.response.value)),
         \
+                        &mailbox_buffer.tag.value_buffer_size);
         \
+        put_guest_field(0, &mailbox_buffer.tag.request.zero);
         \

         \
-        mailbox_buffer.end_tag = RPI_FWREQ_PROPERTY_END;
         \
+        put_guest_field(RPI_FWREQ_PROPERTY_END,
&mailbox_buffer.end_tag);      \

         \
         if (SETUP_FN_NAME(testname, __VA_ARGS__)) {
         \
             SETUP_FN_NAME(testname,
__VA_ARGS__)(&mailbox_buffer.tag);         \
         }
         \

         \
         qtest_memwrite(qts, MBOX_TEST_MESSAGE_ADDRESS,
         \
-                    &mailbox_buffer, sizeof(mailbox_buffer));
         \
+                       &mailbox_buffer, sizeof(mailbox_buffer));
         \
         qtest_mbox1_write_message(qts, MBOX_CHANNEL_ID_PROPERTY,
         \
-                            MBOX_TEST_MESSAGE_ADDRESS);
         \
+                                  MBOX_TEST_MESSAGE_ADDRESS);
         \

         \
         qtest_mbox0_read_message(qts, MBOX_CHANNEL_ID_PROPERTY,
         \
-                            &mailbox_buffer, sizeof(mailbox_buffer));
         \
+                                 &mailbox_buffer,
sizeof(mailbox_buffer));     \

         \
-        g_assert_cmphex(mailbox_buffer.header.req_resp_code, ==,
MBOX_SUCCESS);\
+        get_guest_field(req_resp_code,
&mailbox_buffer.header.req_resp_code);  \
+        g_assert_cmphex(req_resp_code, ==, MBOX_SUCCESS);
         \
+        get_guest_field(tag_id, &mailbox_buffer.tag.id);
         \
+        g_assert_cmphex(tag_id, ==, TEST_TAG(testname));
         \

         \
-        g_assert_cmphex(mailbox_buffer.tag.id, ==,
TEST_TAG(testname));        \
-
         \
-        uint32_t size =
FIELD_EX32(mailbox_buffer.tag.response.size_stat,      \
-                                   MBOX_SIZE_STAT, SIZE);
         \
-        uint32_t success =
FIELD_EX32(mailbox_buffer.tag.response.size_stat,   \
-                                      MBOX_SIZE_STAT, SUCCESS);
         \
+        get_guest_field(size_stat,
&mailbox_buffer.tag.response.size_stat);    \
+        size = FIELD_EX32(size_stat, MBOX_SIZE_STAT, SIZE);
         \
+        success = FIELD_EX32(size_stat, MBOX_SIZE_STAT, SUCCESS);
         \
         g_assert_cmpint(size, ==,
sizeof(mailbox_buffer.tag.response.value));  \
         g_assert_cmpint(success, ==, 1);
         \

         \
@@ -110,7 +136,9 @@ FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)

 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_FIRMWARE_REVISION) {
-    g_assert_cmpint(tag->response.value.revision, ==, FIRMWARE_REVISION);
+    uint32_t rev;
+    get_guest_field(rev, &tag->response.value.revision);
+    g_assert_cmpint(rev, ==, FIRMWARE_REVISION);
 }

which I have tested works for the one test case that I updated here.
(The field comparison part could probably be made less clunky.)
Or you could do something else.

The test also failed to link on Macos:
https://gitlab.com/qemu-project/qemu/-/jobs/6267744541

Undefined symbols for architecture arm64:
"_FRAMEBUFFER_GET_ALPHA_MODE__setup", referenced from:
_FRAMEBUFFER_GET_ALPHA_MODE__test in bcm2838-mbox-property-test.c.o
"_FRAMEBUFFER_GET_DEPTH__setup", referenced from:
_FRAMEBUFFER_GET_DEPTH__test in bcm2838-mbox-property-test.c.o
(etc)

I'm not sure why that is, but I would be suspicious that your
use of the __attribute__((weak)) for the setup functions is not
portable.

thanks
-- PMM

