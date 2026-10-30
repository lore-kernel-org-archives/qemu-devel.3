Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ir+w/pt0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsVc-00061w-D0; Fri, 30 Oct 2026 15:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVZ-00061M-2H
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:25 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVW-000086-Fe
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:23 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8479f46ecd8so501429a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389401; x=1793994201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SDmC1B9f85S9cuFY2KAgb1tzj716RADTzBzBLvsqcRw=;
 b=ir+w/pt0xUqEU8bLB306/ESMh8YlJbDwF0vuFaGRPV4f6sZ7ibkHPMGsw1XPmN5EMr
 7BiNDU0vDMa9IJqD7N0pniMJ4u7cC+FN6QLVSAaaOr2kTBs7b+0yP6z36AXrEdcYzUVr
 +Iu15JbhRf4UhvYM20Mg2CdhCjBJIfwPlza6M3o83naQ0ljU4uLITSdqVY3uS4enCQaK
 32oiSz+/UsYa+BzVRaQowB0oCqYS8z3PFW6AnzKkbi0y8Jo2MjlETIZg4/7vbph6RFlE
 VOG1H6eYD53L7NbPVpIdlRd3jWiqjFPUIi8WxW32siEpZvTKfdbH8H71Wb2uLKhKIpOp
 V3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389401; x=1793994201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SDmC1B9f85S9cuFY2KAgb1tzj716RADTzBzBLvsqcRw=;
 b=KgFJpw6LND/Yu9IbkDTyw0uqkGxU0kdl6B4N6sEA7Ntoc3lwU7qgvtBA6aIA7fyAIz
 a631tABD0wHz0wDmLlPGbOxtToiwOwrYDMIDdGXoKoMALhzaNEftYRAsn36FzZ+4HXjJ
 /peO0WHu6lCY20R6DGKFsOENFDoOTGd8vDxtep2mh+esn8rN5WmnHQ66s2mU6Z+g/wBq
 1DyWWJdd1k+mQVbgIrrbqWqq1tyK+vb3RFtJBZ7RNS+EPIK0IVbwgxVOcf0/tPtvnei8
 nnfa0XrsQ11cDXzzqVZsOEzlT08jTHaneVY3KnXSI5/K2ioa7uE6us8epuE+0L6F5wvr
 Y4QQ==
X-Gm-Message-State: AFq9FYK8+1iCAXkYSbH3JeZwRhpCTufblsR1+jLFgXsBL4w3DJQ5sGfl
 Q65DcAqZ+OzJJCy4rJyWUvtNir9XCedNWnxAUoK/CmdB/690lsDyQDNKfC8O/XRB62+ebvPmcOz
 XFi81
X-Gm-Gg: AYBFou0oDVIVDscj6o2wqAf/A5ETC/KmbiRN37k3gUEVsawnpzXzPVSA4A1tYFsDjrL
 Bn7J9PiKo9nTB2oiOoy5cF6ylYq8b5BfygaqEpD6OwvI4D5p6OJjho6fNq42QxE4DvRthQaNhAs
 uOhJDw9DNIDLNqfFbWzZ4OY4/KMNtAuvG5EhZWMNh3CVwcdLuuDXBb8zMQevAeavVQoGdMEZmT3
 1kAnll57ICkoNIkMRNiiP0RNlmmd5IPmAqLPbuDviPmwKu2DXhacXcnZrHPgNxSODadAblmD/aM
 TpH0kVGwfJqNOMXVbcp6sDC0zo2Hc4pMQIkpEP5jpHP9AxTRKJVwJFEDhROPOUCUOG7jGs08w3l
 9NFIh7epJJYiWlNwpoJhJsHabfXZ3dN/D+lYU0+855Elamt+WyA+FlS1pxwpMjQmZ12fTY8KjR5
 DFrxj1xA+ax/jLEzh6kZQp2QKo2o+8m8TZ5z5IyrigDPCZ3i3x2os8/ccfVcy15ywogZqBVbanD
 OlhMNO1TCHREyENqaWc/Zw+3I4JdtiIsTkrxPTQPixCotxaejck5ilTU3XJvyu+/qAk8GQ2Lg78
 Ubbyy4of5PK9fzSkAzRBCDURhHkuBRyKMJgb+ZsXCB61J2tpoBwifyIV
X-Received: by 2002:a05:6830:2b20:b0:828:ca8c:f880 with SMTP id
 46e09a7af769-85d36610ecbmr2526472a34.27.1793389400901; 
 Fri, 30 Oct 2026 12:43:20 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/9] target/arm: Use tcg_gen_goto_jc* for aarch64
Date: Fri, 30 Oct 2026 14:43:09 -0500
Message-ID: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based-on: 20261030185551.193092-1-richard.henderson@linaro.org
("[PATCH v7 00/14] accel/tcg: cut per-block dispatch overhead (parts 4-6)")

Because btype is in tbflags, using goto_jc in aarch64 is more
complicated, and requires accurately tracking changes to tbflags.


r~


Richard Henderson (9):
  target/arm: Add tbflags to DisasContext
  target/arm: Retain btype in DisasContext.tbflags
  target/arm: Add second value to DisasCompare64
  target/arm: Split out gen_goto_tb_int
  target/arm: Split out gen_indirect_branch
  target/arm: Split out gen_cbranch_goto_tb
  target/arm: Use DISAS_TOO_MANY for simple TB breaks
  target/arm: Rework gen_goto_tb to gen_direct_branch
  target/arm: Use tcg_gen_goto_jc3_i64 for aa64 branches

 target/arm/tcg/translate.h     |  16 +-
 target/arm/tcg/translate-a64.c | 400 +++++++++++++++++----------------
 target/arm/tcg/translate.c     |  60 ++---
 3 files changed, 251 insertions(+), 225 deletions(-)

-- 
2.53.0


