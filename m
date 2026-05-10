Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FDBCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMB3B-0008Sn-8V; Sun, 10 May 2026 16:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMB39-0008SF-OO
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMB37-0005qZ-MA
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778446011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbJLzDdk4vzkzgTEKScNF9Q3GyKWWd42qkiCT/R1zZU=;
 b=IWMalGWyhwapKKINMUV0LVI0XBBIy2W2Z7wglBkl4LEc4maB6gsyL9y2xDwz4rUeJqP2No
 L7LbQE8oH2P1NNVv6uTQ1Nvfa8PLv23SLGt5YCv+aADjlhmB92mnFj6FSd+wPkqJHyd6W8
 GkMWrOa+uvEUKieN5l33BZPXDotWa30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-6I-YoAGpM4a9s-2AXydj3Q-1; Sun,
 10 May 2026 16:46:47 -0400
X-MC-Unique: 6I-YoAGpM4a9s-2AXydj3Q-1
X-Mimecast-MFC-AGG-ID: 6I-YoAGpM4a9s-2AXydj3Q_1778446006
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD804180047F; Sun, 10 May 2026 20:46:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE75A30001BE; Sun, 10 May 2026 20:46:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PATCH] target/s390x: add gen-features.h dependency to s390x_system_ss
Date: Mon, 11 May 2026 00:46:40 +0400
Message-ID: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit 0b83acf2f05 moved gen_features_h from s390x_ss to
s390x_common_ss. However s390x_system_ss (containing ioinst.c) was left
without the dependency, causing a build race: it can be compiled before
gen-features.h is generated (via cpu.h -> cpu_models.h -> cpu_features.h
-> gen-features.h)

Add gen_features_h to s390x_system_ss to correct the build ordering.

Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/s390x/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 44f58ac2919..bc4459e8ed7 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -26,6 +26,7 @@ s390x_common_ss.add(files(
   'gdbstub.c',
 ))
 
+s390x_system_ss.add(gen_features_h)
 s390x_system_ss.add(files(
   'ioinst.c',
 ))
-- 
2.54.0


