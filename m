Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D29CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzwg-0004R0-56; Wed, 30 Sep 2026 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOz-0000qM-AA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:37 -0400
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOv-000819-M9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:37 -0400
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so29447585e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794290; x=1791399090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1dOQKJr6jIAlX3myoLASqWM+1eX+YsM40ILKtC5LWAg=;
 b=F4njY2l+t9JuGxGsXcXU0/FZXzfKLQMErlMXZLeouN8C3ie3+Gk403m+fxlvN/gyQ0
 uy3YpE/byFh01kfHKdx7mDfXzT6UaChKY2iAPqy77dpyNIPUhf0Tvh84baLazhKgn9FQ
 7qk8YLlSugWdNPxST7kNtkFFL2Gfg+OgxxkuYKOWxgrotpOx5L1ZrAuf4FZYz2GnYXV4
 chJSbYjMDcreRyxb2g/1EEhP4SN8ccR8HsVS5wUyUHQy73SsM+QHJ9udkky2JxrfdEeR
 ntuPcyOolRZjKJPr6gK1zLgz/bgAXzXfAhE+/2dlCu+rHb9ZtKilLNoAYVuFZnKKo3EZ
 UU7g==
X-Gm-Message-State: AFuF++lDKC8QatWUM/NOafqL4eWJ4oTg3P31v9n4Es4TbxVXKDR/kyqf
 Rl/eKKdieaDQa2Aj/HAqjWF/1DWP5ZmjvZtqeU32WLB/gYRmIQI5VQWPqC8fLHcR
X-Gm-Gg: AYBFou3klthlZfH9u9yh4b9d0p6TR+quXJxRNs23Zia9lfrl94GInHBxe8CQqM0AAFg
 ocmAVOf9j4Z0Qoyw4Rz2lPdOvJjDYPo86aB0mr1zxd1d6gzWuDGOZx91C1FYK3YVGHtSUVoUu73
 kK6gGFmQIPhUM5wsKdCNg8ZQyuBzQKK1cI5wRGqCJnWxBkL28Upfs/kqXfK6N/COUdm9i7EwimS
 Wms0O7ipVFmUgA0hWDkdu5kOudt90uxzeM1bZwVvPfiasm7j6tnBILRhLGjFzAdAQBES2x7RH1g
 BHw6mVKF71dK3Mc0feUn4HLFDfzDcIlJ4xAVQIWr953Nougu4bo+ckGKU1sWdnbZoc4Vwl8+fAw
 RPNJSAKnD5jKKBnpoNDbGf2yWsh/a9TCZvNsMc4Qzo3vWHG3mpGuEWXMd2Q1RPdwvlR/JsKEetp
 6D4KtpiT/P+NSBy3jCWKbgYpBIC66fOAUDSM4MoWRsvu/NWxB0MJZgTmU=
X-Received: by 2002:a05:600c:354f:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-4a01b11a05cmr40627305e9.30.1790794290390; 
 Wed, 30 Sep 2026 11:51:30 -0700 (PDT)
Received: from tower ([185.182.52.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff96dsm1162790f8f.8.2026.09.30.11.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:51:29 -0700 (PDT)
From: Dominic P <gcc@gcc.dp11.uk>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH 3/3] tests/tcg/i386: Build test-i386-opt-shr
Date: Wed, 30 Sep 2026 19:51:24 +0100
Message-ID: <20260930185124.3036980-4-gcc@gcc.dp11.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=74.125.225.140;
 envelope-from=dominic.plunkett@gmail.com; helo=mail-wm2-f12.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 15:26:25 -0400
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

The old Makefile.target built every tests/tcg/i386/*.c.  The meson
conversion lists the tests explicitly and missed test-i386-opt-shr.c,
which 5fe51606146 had added in the meantime, so it is no longer built.

Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
Assisted-by: Claude Opus 5 (Anthropic)
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
---
 tests/tcg/i386/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 4152371a3f..26bd85c05e 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -28,6 +28,7 @@ tests += {
   'test-i386-fxtract.c': {},
   'test-i386-fyl2x.c': {},
   'test-i386-fyl2xp1.c': {},
+  'test-i386-opt-shr.c': {},
   'test-i386-opt-rol.c': {},
   'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
   'test-i386-pseudo-denormal.c': {},
-- 
2.55.0


