Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F596C98324
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 03:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJ12-00081j-K0; Fri, 25 Sep 2026 23:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ11-00081X-9H
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:23:55 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ0z-00009q-9Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:23:55 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0FEC31D000B1;
 Fri, 25 Sep 2026 23:23:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 23:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1790393029; x=1790479429; bh=4NGcmwPTIG
 1HrkPq17sTQe91LpvyoAwgd/O4zNm5Ztc=; b=o39FYfKWd6VVDjjtcKDtaedehG
 CcdKDERhAwwydktVsCZPfC83OOclBrCzdhx+97TXZ/LG9XnSwbOE+p7Iuk8puw+i
 UiGtqaVx1+FSMelm1FSUiZ6VnBQUa3zp9ISaRMhSFsXsaSIRiCPRIY3OK3VWyI7a
 1aFcPLst1skG5m1wAyvIc/HTeIsgPaIsp6LcmrIjOEUn2QxiI5q5vApg+dYeIZ4N
 oOYpTTKmHQTnzW4F9G+0x39vQFO2gHmANDCorowUD7wYRK7Gt+qbavFCsvAXHWlD
 mRwXYFpRyqZJcHIpl6h2GMJtgUBkkkELXCyIhvZGR2yFSfEfr84sRUi6d5tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1790393029; x=1790479429; bh=4NGcmwPTIG1HrkPq17sTQe91LpvyoAwgd/O
 4zNm5Ztc=; b=Svipgstr3cnTPR6eAiCsox1zqR+FERKTfbzI7PdDQsZlDqTWS/R
 AOcExmqp+AXxTi6uvUM+K2Torg4bK0L23OQ1RRcvotGJB3WHVZ579r8i6sanucuT
 RksHzFOTVqaFCWakOZl7aOL+z3OxUQCli9+78Kp5aElhPnOs0l2Yqces/xq4ZAcU
 jCbey9WB5qhqkQOnkMCPxVbJj9vnJvRsiyL2HVarte0WlnK42IMo7ehTiiv//MC1
 mwPawcFHqpK3DhUPNNnvR6YR6UJ6ixr6SSgTffW3NLG8cxKZWjVP55uFhUXeb5Op
 apyn/kkvnCowVoeZmW7MMgnexgR0h6uGvZg==
X-ME-Sender: <xms:xTq3asxwRuW_cRnh7zbOnRuzE9L_lBASItJ5sBlb3oUH4oBxXnZlrw>
 <xme:xTq3agbQ9tZh91B6WR_EdTsXbsVYQOFZV6rV4DJgK3AgaqZ32SjPGzGPTXTnrqNpx
 pLmNv3TbsMKnZxlP5tsigIonkhMMNQnkL3nUI0dkgCNKyPfHEJtRDU>
X-ME-Received: <xmr:xTq3amQAV61vlg-IEZfZBxFz-TtjDanYoSmV-kWaGNBU3rkBUUPqmZ5ZTGACxAda6jXi7mosrE-tllFBNaGN>
X-ME-Proxy-Cause: dmFkZTF2Xo4f8fpi+ITsJP+sOv5IKkATOn3cvxf5dxfZ8seOWxM5vAwkfAqDaFKOkldwtL
 CtxDRS7yaMe6wne28c+96KNAU4ZW/tygCqOOyBLlhw9sp7UTnl31udOb+qR0IDDi3uD+Ev
 m0TuKKzoCLocVu5OupVM3Sq/kzHrn468JFpvKSRJbucUIkTKcSPNAmQyXRYev4K9ZniVwz
 S/XnIomsp3Zx6mv5kdA1FahjymiUHywgvD4VYkcF29kPhCHQlYdHJwt6TqZuFcOVvsTXsK
 b3HTc3gvOV7OvummcYHVuetcua5T+zXYPJpiji/gJE0cqD5GQg9QeqdMWY26XBxghbWdFq
 GKYjWO+OSChTVx0GybGalO79Y97yT/1zfEmy01m8IyGVahEb57unrYjrFX7eT+/Bc0uYEE
 rmDwidIr5Kjtdhwux61UHcZ3MvqQ9vWC/31t6Rj+121tWCLXf8ffyqp78XijRWsLoW5jRc
 HSGxTyj9niW1OMcxM8/UztNveTt6NGX+LrkOYFdUWSYZ6oWQm+21hSwwBAJJYPvetsXKCz
 H8h7Co1VtjMkEwuWO5N/4z6hmcrCikojftohafluxU6F0cpFkdEvrPPdZgBbtBTl38IaC+
 Pv/KxMldV7sC+1F7U3VL/6W3giLaPjQVaWq3IgyfXLzKlB9shZb8VkQ9t9lA
X-ME-Proxy: <xmx:xTq3aizDw28IjgamA_c8doRyhSwlmhALkNcKFWUmiYImTLkImo_a7A>
 <xmx:xTq3ao2vLfpfRojn4BMKQruuqfAqR0nwdeJmb6VjgogS3m7itk_76g>
 <xmx:xTq3ag57SIauP-0CvYy8ilfOBPjeCIEN9xEFEswThKXJ-6tDkFoRxQ>
 <xmx:xTq3arUulI19JS08xzoytetGj4tHkudCtyIv2gCRSP86Y-s7g30pBw>
 <xmx:xTq3av1OTd5VHe8lG7vrmS1q6MaJ6gM-wezvnS3_yM6EDe_ZmVPQEWtj>
Feedback-ID: i00314697:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:23:48 -0400 (EDT)
From: Paul Galbraith <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Paul Galbraith <paul@galbraiths.ca>
Subject: [PATCH v3 0/2] target/i386/tcg: fix EIP truncation for wrapping
 16-bit near branches
Date: Fri, 25 Sep 2026 23:23:34 -0400
Message-ID: <20260926032336.933-1-paul@galbraiths.ca>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=paul@galbraiths.ca;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Changes since v2:
- Patch 1: no change
- Patch 2: test rewritten in assembly, hopefully clearer

v2: https://lore.kernel.org/qemu-devel/20260910180517.97-1-paul@galbraiths.ca/

Paul Galbraith (2):
  target/i386/tcg: fix EIP truncation for wrapping 16-bit near branches
  tests/tcg/i386: add regression test for wrapping 16-bit near branches

 target/i386/tcg/translate.c                |  20 +++-
 tests/tcg/i386/system/meson.build          |   7 ++
 tests/tcg/i386/system/test-branch-wrap16.S | 118 +++++++++++++++++++++
 3 files changed, 141 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.S


base-commit: 8db19f3ad9cef7842b6e5025130fc30075311691
-- 
2.55.0.windows.3


