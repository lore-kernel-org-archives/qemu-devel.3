Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC106C88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FnV-00036q-VJ; Mon, 14 Sep 2026 19:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnQ-00035s-1D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:09 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnO-0007EG-4i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:07 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebad4afso2552104a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427344; x=1790032144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bU4hxpiqZAXlf78JXX5IIfB6mQhq4utJHjuqGLhYvZY=;
 b=L2GwZotMu0EYOhdXQHUDmFrIMv7WlFRes+zuQ8e0zNpjkf7TY2yQnloiSFsP/+SeEm
 CPuepgmQGKEeHypWx7m+3LYOmUyICocn1ryAxfgWzTcH4QuzPMlzmIAep3BN5/b+5JFY
 gcls4SrPleYpt+Qy3dI0r/Lpr3ZA0/hk4ZRp5sH+e4ISJsxaGXJJOYp3p/kT0rPc+YTR
 d5rj1ln88g+BIL/zmKEnEO3X7PqPqw8gpAOTgI8i910cA+GHuiemF2Mb3qTTr4s1vCIo
 5yDtJ8BaAo7sqWou0T7FYmP6h+ChdwQrWZ6k4MHuqk2S/4fEKn6629R61J7c+LuQ/Ptr
 wxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427344; x=1790032144;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bU4hxpiqZAXlf78JXX5IIfB6mQhq4utJHjuqGLhYvZY=;
 b=11ZfHfMRTt8KhAaikxzqpdef7gI/+gST937u05Zg2hL7RQhaUpoEnwrqcbH1RTUd+s
 2D1gk2ql68kc3ITWSCwwi5YrA/oURQ+J20VvQvLNaY4dK7iQXJod4VmL4UgBMJzeGZH8
 N5v9yuR9jilAnd8KfIZrKoBrG34sUhlV4/8KwVaU4/Gwm5DbranTRXxSvbFj2ZZXRpiF
 nGF5q/K6hijBbM3Q7hay4Frv119ZI3WCd4RhRsgmH6kcL3Rcgx/Jq84KmOFmmxi9bkS+
 MLQKRjMkxgLgt429TyixdewLTepuqWZFQw3SdlYJxQTyKGtehyf9BeiGXlHVRjPM4PID
 Omyg==
X-Gm-Message-State: AFuF++kXYn+g5PgWbtpslI2CL96qVxEYfIFaoJywFfKzYIVN7DY2DFm2
 V1o9qdpYJptdtY8xDxQu7PStYaMqqaA6zAeQBSY6Z33EFSxVezmpA66C3ygIJRgNN8CShJ0oPNA
 7E9ES3hg=
X-Gm-Gg: AYBFou09HpFhauGXN3/f+PGjV0mEjRE4LmOd0p3UomnpL8ZpO1oduWPBEuTOmdLhJP+
 3PiDqMNMJ6ltKJki4l04Vo+HuGBDM6YGEcigX8OXOtcuoyKR5YqvIVa8oobAkh/OpgI/NAicNbp
 0ovgNS+z4kjLpkP/tpVO4bav0RyjVvtWPATBbFY7TBji+HCop1N9NyOG4A1WsKDrTXEFBbeFkHV
 sUWepj9hPvMyx2C0Zh3/8z2x3NHnQ8+rMJv2ylvtCYKGPSWiOAZK7jfmBAa8SbXI74liuxfsN0n
 dMPcIYnmOKxFK/9+KieSwwTzCCWLG9x9enyxqM8mO57V2YfcLa60k6TCPcFs+7+jN8zwN7/1Cpv
 aGEU9LqviwsprDGOryMBjQNt7xwzXzLYfix2/wvVtBvrgdzyUTfRK1XCu+tAT+l83MSvZpwHvw1
 DlE9g/fqy1mFK2UkrKdXN2UPLyfrHrX5u8+X4MJRyDsqWyoc6g7W4LramWOLKRn16RK5ba95nOM
 RQ1d/Gwr3mn+VC+XA==
X-Received: by 2002:a05:6a21:3384:b0:3d3:adad:f171 with SMTP id
 adf61e73a8af0-3db406a9225mr12592074637.19.1789427343554; 
 Mon, 14 Sep 2026 16:09:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 0/6] target/mips/tcg: MXU fixes and cleanups
Date: Mon, 14 Sep 2026 13:08:52 -1000
Message-ID: <20260914230901.1781309-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Forthcoming tcg improvements will diagnose the passed null pointers,
with or without --enable-ubsan:

../src/target/mips/tcg/mxu_translate.c: In function ‘gen_mxu_S32MAX_S32MIN’:
../src/target/mips/tcg/mxu_translate.c:2149:13: error: argument 3 null where non-null expected [-Werror=nonnull]
 2149 |             tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
      |             ^~~~~~~~~~~~~~~~
In file included from /home/rth/qemu/src/include/tcg/tcg-op.h:11,
                 from ../src/target/mips/tcg/translate.h:12,
                 from ../src/target/mips/tcg/mxu_translate.c:19:
/home/rth/qemu/src/include/tcg/tcg-op-common.h:166:23: note: in a call to function ‘tcg_gen_smax_i32’ declared ‘nonnull’
  166 | QEMU_ARG_NONNULL void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
      |                       ^~~~~~~~~~~~~~~~
../src/target/mips/tcg/mxu_translate.c:2151:13: error: argument 3 null where non-null expected [-Werror=nonnull]
 2151 |             tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
      |             ^~~~~~~~~~~~~~~~
/home/rth/qemu/src/include/tcg/tcg-op-common.h:165:23: note: in a call to function ‘tcg_gen_smin_i32’ declared ‘nonnull’
  165 | QEMU_ARG_NONNULL void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
      |                       ^~~~~~~~~~~~~~~~
../src/target/mips/tcg/mxu_translate.c: In function ‘gen_mxu_d8sum’:
../src/target/mips/tcg/mxu_translate.c:3112:13: error: argument 2 null where non-null expected [-Werror=nonnull]
 3112 |             tcg_gen_mov_i32(t4, 0);
      |             ^~~~~~~~~~~~~~~
/home/rth/qemu/src/include/tcg/tcg-op-common.h:178:23: note: in a call to function ‘tcg_gen_mov_i32’ declared ‘nonnull’
  178 | QEMU_ARG_NONNULL void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
      |                       ^~~~~~~~~~~~~~~
../src/target/mips/tcg/mxu_translate.c:3123:13: error: argument 2 null where non-null expected [-Werror=nonnull]
 3123 |             tcg_gen_mov_i32(t5, 0);
      |             ^~~~~~~~~~~~~~~
/home/rth/qemu/src/include/tcg/tcg-op-common.h:178:23: note: in a call to function ‘tcg_gen_mov_i32’ declared ‘nonnull’
  178 | QEMU_ARG_NONNULL void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
      |                       ^~~~~~~~~~~~~~~

Mostly we need to drop all of the premature optimization vs
the zero register.  In the extremely unlikely event that zero
is passed, the optimizer will clean things up.

Split out a helper for 32-bit 3-operand insns, which fixes
the smin/smax failures above.

Quite a bit more work wants doing to clean up the 16- and 8-bit
3-operand insns, but except for the one instance in d8sum, those
aren't currently causing problems.


r~


Richard Henderson (6):
  target/mips/tcg: Fix zero in gen_mxu_d8sum
  target/mips/tcg: Drop zero optimization in gen_mxu_s32mul
  target/mips/tcg: Split out gen_mxu_logic
  target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32MAX_S32MIN
  target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32SLT
  target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32CPS

 target/mips/tcg/mxu_translate.c | 265 +++++++-------------------------
 1 file changed, 59 insertions(+), 206 deletions(-)

-- 
2.53.0


