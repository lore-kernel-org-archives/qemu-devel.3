Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21098C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnp-0002X5-5D; Thu, 17 Sep 2026 17:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnn-0002WQ-PW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnl-0007YV-M0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:55 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso5537a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681072; x=1790285872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=asfkG8UeHqQ6gF3LsmRhLgWYgoaai8cZtf+6MkQSX5g=;
 b=hZNFiKY7xJsL1vbdbrHHLs4WAP47de7htrUXZhJfetp9pwW59KtpqYOh6VgDCX1Q0+
 YeVJy0H3Q4cQqKowv4VZehmnCxEuqUHVOdmRao4fFCrH0opQTHAdVw0QpZb1a885nKGl
 UfT67dmupOo7UcPGc0sVcr30TiASWuCJ5Ipv7uherTqt7IsC9AjE6NXX2JyyrjseNHKD
 RmO0QY7D813FK9ySgSv2v9ua5xbGuh3JtvXsxniPTxUAKmpoXJf/hGq1SP04gsehskxd
 zRixQrZ9ng3BxpPZno3ibcIvyd8sdi1PpVvOn5emfqWewFjTpTVrZADYD2jm6xo/2J2C
 +U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681072; x=1790285872;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asfkG8UeHqQ6gF3LsmRhLgWYgoaai8cZtf+6MkQSX5g=;
 b=VUqNY9PVGOjRQ+4opohOPEI4f95wmQIa3+VJcgBhhs+zqQq4NXT4IhwE+OdmXoEpM7
 ADJcVT7I+LxiiZCttde4azpuDg/Lzt16Opi5+apTvQmnS0XfMqs/VGuH9k+bKfVeoWaR
 6W6/TFfPQME3tWy7/YqhuXkoxQ3OmjzK04fgD/GpxpU0c+x1nzzEAFv8NZpW0qa2isiz
 L3fvR9fhg/UcslIuCQoiBkvTkVTmkc0xMWeJut6UfDA5buprAL86ZHk9MRtomg423SBx
 CFrOa/hi5alEgojv8Lw6nvdluaU5pCXWXpwgYptZuoDmNLCAmyjWmFmDC/TmB4vb62cy
 Yywg==
X-Gm-Message-State: AFuF++nabZbcTrNHVBYjgzB39RGHHABTgT8fBfOLplqvr9n2hqQleH8K
 aN831BDrFMgu5p9OwbsQRoCAUv6sR4yEB50MC49RlZt9I7QgWljwNEq8pXTbjZ3GdXM8XWrlOjH
 DDeqQkcE=
X-Gm-Gg: AYBFou0ETp88RlA7veVT+xNLARa1zyIoIzRctgyK/Q9Q51LgYRzRB2Jbi+05taQSFkT
 JhGnFyfe43HOzmGd2PnHxhUaPmLA9DcvEvz8p0uUwRlb7Ia3+2wAEesMyMO0BaQDzLwHl///9gL
 71pMYbVfJ9EivcHIfqllrR2dbGLCL6vVLdOSAHMt6JR3f7XqGaJNCvBsV98rrWaDfNMI3k9ype7
 Qe8yjCJ738UKbx3qYlXtFl/j/a4g1pM87nDUD/dt+pWVQtOJWbT7vBHwYUjILCB8BGXLIxaVUZV
 e3xBACheULEH7aJgLEyTRlTgbkpyB8gSKINLD/vq5fxf5fj2WIHY2uuwqx+g+N5DS58DutfZ/I/
 f8np5VkSLnF8cchMYn//OD3xqld+ZhgUzxPEAmfHXm+XeL1iGjtM2DJQmnQ/7oLobbBea5FAy3f
 2JqUjcEVncM8YWxPLjHHUJRLiPIqwxDL38Xw0I0U62d1FxUb5Z2SHctZhEm0BsN64Ff9/YiLPdv
 KWIHLo=
X-Received: by 2002:a05:6a21:2986:b0:3dd:85a9:55a5 with SMTP id
 adf61e73a8af0-3dd8c5b3af6mr552857637.30.1789681071987; 
 Thu, 17 Sep 2026 14:37:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] target/s390x/tcg patch queue
Date: Thu, 17 Sep 2026 11:37:34 -1000
Message-ID: <20260917213749.36756-1-richard.henderson@linaro.org>
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

The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:

  Merge tag 'pull-loongarch-20260917' of https://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-s390x-20260917

for you to fetch changes up to 38efe3f4978b9b5e90f88c3c6d0f44b84d3e03a3:

  tests/tcg/s390x: Test LOAD and STORE REVERSED (2026-09-17 11:33:53 -1000)

----------------------------------------------------------------
target/s390x/tcg: Clean up mem ops and byte swapping

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg/s390x: Test LOAD and STORE REVERSED

Richard Henderson (14):
      target/s390x/tcg: Convert op_ld8s to op_ld
      target/s390x/tcg: Convert op_ld8u to op_ld
      target/s390x/tcg: Convert op_ld16s to op_ld
      target/s390x/tcg: Convert op_ld16u to op_ld
      target/s390x/tcg: Convert op_ld32s to op_ld
      target/s390x/tcg: Convert op_ld32u to op_ld
      target/s390x/tcg: Convert op_ld64 to op_ld
      target/s390x/tcg: Convert op_st8 to op_st
      target/s390x/tcg: Convert op_st16 to op_st
      target/s390x/tcg: Convert op_st32 to op_st
      target/s390x/tcg: Convert op_st64 to op_st
      target/s390x/tcg: Use op_ld for LOAD REVERSED
      target/s390x/tcg: Use op_st for STORE REVERSED
      target/s390x/tcg: Simplify LRVR

 target/s390x/tcg/insn-data.h.inc      | 108 +++++++++++++++++-----------------
 target/s390x/tcg/translate.c          |  89 ++--------------------------
 tests/tcg/s390x/load-store-reversed.c |  46 +++++++++++++++
 tests/tcg/s390x/meson.build           |   1 +
 4 files changed, 106 insertions(+), 138 deletions(-)
 create mode 100644 tests/tcg/s390x/load-store-reversed.c

