Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE66C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrdz8-0004tE-BO; Tue, 02 Apr 2024 09:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rraaR-0002JA-11
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:37:47 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rraaK-0001gM-KP
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:37:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 151CD11400AC;
 Tue,  2 Apr 2024 05:37:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 02 Apr 2024 05:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1712050654; x=1712137054; bh=YsKv+bFAZ2EQPJnFPmYAy
 +P5/ddlPIJeOzyys1yYUfc=; b=o+uqr12YSnPHY7QUP3el05SCBZ/qMYyPvRgVx
 bMK7iAk0jlbX1R7KFDcsKpmpK+KyhpTyYNa60gNhrxGt/jHVSIEKyp/8JbMHorKc
 l1AK1j03s5bC1/pRGqb36W39P1rBSoBOlk+FhLWxhG4PYqoujGPyCgUCMbsp+sbA
 pv4IUNKo/cF+0XznOKtncUpsjn11nm5GLG4avH3r9UioR5F4t3j1Uuw3x96iF8Rn
 XIKvbvhi5CtKUKLZVDq36LBpwIL+KV+XLk+B+qsVHNGF3eSUyLpbt605nb5Fa2/w
 LCz88a343oUgKbWfc30vTGwcsh9JrcDgqKkqpWG6UwIQ9oQbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712050654; x=1712137054; bh=YsKv+bFAZ2EQPJnFPmYAy+P5/ddl
 PIJeOzyys1yYUfc=; b=U2y2tu5SP5aKX4Yry59QFnm6ToKbS/5z+hQKtIKSRpjo
 +bvFBPZlgW6S0WY4ClYlTSFaOXCSm1oxgbdTG0nmbrLx0YTOtyLkKcaCJbys1xka
 HowzzRWYE5dBO3290e+fjTbfxWjtHPKCuddZ7MLFMs67tYHmEb3YNwv2sykCFJSE
 aW9jUt7waIC4gq94cm2bw2/3JQeX2LdTD3oQ6o/JdqS/zhjdnw5tq7B6G1DrIgwl
 nKzaudZDEQf48EvvLfSQNgHHZX6NJtwHQ6bZzajTUrlyfqV/OBDqpc38ZGxQ1Y1l
 MI+lHlGpp6gDHOcDDbfcOjYI6U+H5zZYmxCGMP7qqw==
X-ME-Sender: <xms:3dELZkBP7Wl3AD7ItDgdHH428JSlzUeEXudOKkPZkFb38bgv8Cb9bA>
 <xme:3dELZmhaNCY9yA5yy80_eFAp0-wPWaVJkcZN95EQVI9N5m28oWZ9qXnSwkXSOY9Su
 IsqKSYrnTA8cgav9X8>
X-ME-Received: <xmr:3dELZnlGxMy28x7_UJQ3_Qy8FtkZLK7Ga2dNDIRBt6REjDlrziv-YlUHwCOl-QWjOsvpT77hHYI5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpegkrggtkhcuuehuhhhmrghnuceoiigrtghksegsuhhhmhgrnhdr
 ohhrgheqnecuggftrfgrthhtvghrnhepudetueelleefudffjeellefgffeihfeuheeutd
 efieefueeghfeltddvheduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepiigrtghksegsuhhhmhgrnhdrohhrgh
X-ME-Proxy: <xmx:3dELZqwjUrE0sYDGiSeh2trgizRabKdFS6KMIbtlNZrHVlPFtmCbdw>
 <xmx:3dELZpR82ZIh71KRUPKAXLTXK10da6xeJRUh3Az_1EXqPRYT1O7ohQ>
 <xmx:3dELZlaf3Z0fE066KFVkQ-3BBBjYHZfoG3C3VbN1KtCdmRjO0HgSGA>
 <xmx:3dELZiStaT6cjqRH9XQ-RGcGirl8-CSY-WPh879FKxjHSz6I6Oy5zw>
 <xmx:3tELZrdZnlZC3F5pg_u0i6pO3xTJ2b73cSwrLqbbQ1aU8h6sqtkPF-IG>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 05:37:32 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>
Subject: [PATCH] sh4: mac.w: memory accesses are 16-bit words
Date: Tue,  2 Apr 2024 17:37:49 +0800
Message-ID: <20240402093756.27466-1-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.154; envelope-from=zack@buhman.org;
 helo=fhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Apr 2024 09:15:23 -0400
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

Before this change, executing a code sequence such as:

           mova   tblm,r0
           mov    r0,r1
           mova   tbln,r0
           clrs
           clrmac
           mac.w  @r0+,@r1+
           mac.w  @r0+,@r1+

           .align 4
  tblm:    .word  0x1234
           .word  0x5678
  tbln:    .word  0x9abc
           .word  0xdefg

Does not result in correct behavior:

Expected behavior:
  first macw : macl = 0x1234 * 0x9abc + 0x0
               mach = 0x0

  second macw: macl = 0x5678 * 0xdefg + 0xb00a630
               mach = 0x0

Observed behavior (qemu-sh4eb, prior to this commit):

  first macw : macl = 0x5678 * 0xdefg + 0x0
               mach = 0x0

  second macw: (unaligned longword memory access, SIGBUS)

Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
access, not a 32-bit longword memory access.

Signed-off-by: Zack Buhman <zack@buhman.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a9b1bc7524..6643c14dde 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -816,10 +816,10 @@ static void _decode_opc(DisasContext * ctx)
             TCGv arg0, arg1;
             arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             gen_helper_macw(tcg_env, arg0, arg1);
             tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
             tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-- 
2.41.0


