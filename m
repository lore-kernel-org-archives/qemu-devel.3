Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F37C3DA4E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthH-0001lj-CX; Thu, 11 Jul 2024 09:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00016U-BJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtgp-00062i-EA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so6708565e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703905; x=1721308705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/AM2evHCBZ+zQstkZ8Yl2d6atBhqWRDl1W7bKsTVmZ8=;
 b=fLfuagobILgHgD6adpdamXR9ls9BhSOtEPAOR376kXcbyYk5CoQCWIT4k80Ree9YFM
 Rd9VuqiMySy7zy4gDGYbt2wtWC4p9vasc4jiD1KNN8eGqU+OP2D8cLE3bU4gHG3wNq9F
 6eHj4CsWgVsrcAs8xwtyBlP+tkQhYq2fE6d2GW9oRm33rOa93h6MWq1z1T4W5QNqoeRD
 cCC+z5LSsMRti1XlEAaZqWHuqKGr1W6QehoO3TzTmr3eLQQ1QHUX+w56wajDQ2uk1PS6
 wrHQmFqzHDL7bgxCseEUsFOOb04avEgGTe2XbqWPoUtnlPAmlqRSt9WaQGRIYvTTw1rw
 oP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703905; x=1721308705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AM2evHCBZ+zQstkZ8Yl2d6atBhqWRDl1W7bKsTVmZ8=;
 b=dfFfCOp4OTyxOre5xKCWv3epW2z6jFOj3ldYqaVgon9XQ4csRy1WirAkPENAql3O7d
 2Yym6isyuyD8RNmQqW1Ao8n63uHCkE3naKzfjk8JnWsblBy/xV6y+g2nUqfptqK6Z7gI
 yLOiVsmqAz76z03+PwTzFV8+j+VAbpUILMG/qq9zuV5Eq+SI9M2YrvePfIdw6R7hf0jr
 1FgHtFEYAPLqTzR+YxOfzYZirVByntAz25nHvzUS/gVTnMLH5xktkVRxtO2kIfZyL+kQ
 6DQiYVKT5ZUK+SWtAL0NtqvPyMC0dIooTizPx0t9ChV9h9d/SO/pNs7oJvUaE1IbvF8a
 8uaw==
X-Gm-Message-State: AOJu0Yx9v5QSdyp7o4G6oj+9IHSZugKYjBHJvhbCIYrZPHDumR7QMx6E
 X45DGTpbtYzmThDv14WKVlVM/0A9GSyJgHUARS9Rx3mQrRWoJfgzheKXf4yO+jC5rFdUV+MnYAq
 yeuc=
X-Google-Smtp-Source: AGHT+IG2wlNMlAjFeg1WXJ2k+awc13TiC2UcOumpGau6kEmELm6Piv6eXT4S82yFGkiKYsvP1yMGPg==
X-Received: by 2002:a05:600c:4850:b0:426:62c5:4731 with SMTP id
 5b1f17b1804b1-426707f8563mr70542125e9.29.1720703905209; 
 Thu, 11 Jul 2024 06:18:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] target/arm: Correct comments about M-profile FPSCR
Date: Thu, 11 Jul 2024 14:17:59 +0100
Message-Id: <20240711131822.3909903-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The M-profile FPSCR LTPSIZE is bits [18:16]; this is the same
field as A-profile FPSCR Len, not Stride. Correct the comment
in vfp_get_fpscr().

We also implemented M-profile FPSCR.QC, but forgot to delete
a TODO comment from vfp_set_fpscr(); remove it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-2-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 50d7042fa9e..e1686005558 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -176,8 +176,8 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
             | (env->vfp.vec_stride << 20);
 
     /*
-     * M-profile LTPSIZE overlaps A-profile Stride; whichever of the
-     * two is not applicable to this CPU will always be zero.
+     * M-profile LTPSIZE is the same bits [18:16] as A-profile Len; whichever
+     * of the two is not applicable to this CPU will always be zero.
      */
     fpscr |= env->v7m.ltpsize << 16;
 
@@ -226,7 +226,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         /*
          * The bit we set within fpscr_q is arbitrary; the register as a
          * whole being zero/non-zero is what counts.
-         * TODO: M-profile MVE also has a QC bit.
          */
         env->vfp.qc[0] = val & FPCR_QC;
         env->vfp.qc[1] = 0;
-- 
2.34.1


