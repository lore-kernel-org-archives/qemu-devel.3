Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13457C3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVZe-0006fv-BA; Tue, 17 Sep 2024 06:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZS-0005bS-JM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZP-0007OX-1e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edXKVEhvZChLoWi6g+lYFvKdwubqOabGkU4ozwjVkug=;
 b=WjVenOQaoO66uZc/AkHH3DSQUvMy3IMMVqAfuk9/0q8FIeSfOsPVLamMNVPTjfpL3fVRLr
 tpXYXAcfMuPudsHvI4enPtLzQjdCATWSFesm32Cy0gHtb0zwvzYvfoJqM/sAQFveJsOH+Y
 NS+SnDf9lzrsA8nnrYK0tCn4MpblB14=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-R_e9VMCKNL6RVwpIVEMq4A-1; Tue,
 17 Sep 2024 06:36:27 -0400
X-MC-Unique: R_e9VMCKNL6RVwpIVEMq4A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECF321955F40; Tue, 17 Sep 2024 10:36:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79ECE19560A3; Tue, 17 Sep 2024 10:36:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Brian Cain <bcain@quicinc.com>
Subject: [PULL 15/17] docs/fuzz: fix outdated mention to enable-sanitizers
Date: Tue, 17 Sep 2024 12:35:38 +0200
Message-ID: <20240917103540.149144-16-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

This options has been removed at cb771ac1f5 (meson: Split
--enable-sanitizers to --enable-{asan, ubsan}, 2024-08-13), so let's
update its last standing mention in the docs.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Message-ID: <0ecf4e1ab26771009d74a2ce61e7c17ddc586ef7.1726226316.git.quic_mathbern@quicinc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/fuzzing.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
index dfe1973cf8..c3ac084311 100644
--- a/docs/devel/testing/fuzzing.rst
+++ b/docs/devel/testing/fuzzing.rst
@@ -21,8 +21,9 @@ Building the fuzzers
 
 To build the fuzzers, install a recent version of clang:
 Configure with (substitute the clang binaries with the version you installed).
-Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
-such as out-of-bounds accesses, use-after-frees, double-frees etc.::
+Here, enable-asan and enable-ubsan are optional but they allow us to reliably
+detect bugs such as out-of-bounds accesses, uses-after-free, double-frees
+etc.::
 
     CC=clang-8 CXX=clang++-8 /path/to/configure \
         --enable-fuzzing --enable-asan --enable-ubsan
-- 
2.46.0


