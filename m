Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19111FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC49-0003TQ-9c; Wed, 29 Apr 2026 17:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC46-0003TD-HH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC45-0003C9-2j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59PFEgMXfzUbVp1BVkysKDYZbBbk20cj4itZloqYX+8=;
 b=hZ4LZghERj/IqxdjTh4GekiU8WjChdBg4JwHXh/Y7cg9ZbSCwRj+zFAbvrc42wzrLmh5I1
 R51DCwI/O28hddKsBRXOaP4jy1l2YMLjueeqyj0/YNi+lb3W+/1OP2yM4FY/IFP6q05ydt
 F633j6DuM+Zd6fawmGo9qWjCbkq26MQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-nIp_h41NMvuzNubEwvxHrg-1; Wed,
 29 Apr 2026 17:03:21 -0400
X-MC-Unique: nIp_h41NMvuzNubEwvxHrg-1
X-Mimecast-MFC-AGG-ID: nIp_h41NMvuzNubEwvxHrg_1777496600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 226C61956094
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:03:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C10B319560B6; Wed, 29 Apr 2026 21:03:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:34 +0400
Subject: [PATCH v3 01/26] qemu-options.hx: document -chardev vc
 backend-specific behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-1-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TCKGeNX61zdbvMDhyprN1vYtrHLQam3/ghGCoyv8Sxs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILkRBxIeIoQ4+LsCD5F6x5RBXr0ViTmuPHS
 dnYPz6Jj1aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5SdYEACSqBybqqDslqKprC2aPEPWqWOat0Z6rlOVHfjGtALK+w6PZXX0AiHzwOTZ/xRcHGLYcoR
 G8Ffq/xBVgwmgVE1ZLnrPScPkkMNofJpm+Yoldrzf+UL0qYSMlHABVAtwH03ZkLW2GgdJlQRcRj
 XdePk7+YLabKyeave/IMVYOE/W9LAOeUHZmdDwe0P7K1sdocgO+MLH+fRIWEvM/w+9QkfvxzxAX
 ictlpZguMX4RCxkgbuTRLhPs40WKGd1yfcuiCOwq3DFah6p1tacpy3floECNJXTNEdWBcYyoP6b
 JFSSZE6RZ/FsdlXWJyLd3sOHH/wQTlm9wHurYjK/4h8b+jAAapr88jAGAnHjJc4EXCBeaGiynos
 U6xlu8bxUrZfY1AlJb9NR4BnEkiiUUpA2R4vtYsD8YrqhFyq/ORvK/dFZL+EqmJLCSJVVhlyoue
 aWTjcyfaQvW7S/qKauUbu+Ip+ypHl1414LprtIt7wNUZLspyXnDzBs92RgtSwEKO1bxfF68n8tA
 wSv/u8vYWRLPWmf6F7T3SQJZHiyrjFs8r/GaRskdq5Id+TGHRzN9/vHo8nwzKO7GoFG1p4q+HcB
 PTceyRrIyO0L61x2s/7kf8NP1D2Dhdyb4J4HvodBq+fhtcTcGPl1N3X1B6OfS9zCX32O+WudS/W
 KmgIBmtJ8J9Y6oQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The -chardev vc documentation only mentioned the built-in console with
optional size parameters, but the actual behavior depends on the display
backend. Document the GTK (libvte), D-Bus and spice-app cases.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e780bc2ac06..efffeaaf55e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4277,8 +4277,17 @@ The available backends are:
     and hub devices is not supported as well.
 
 ``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
-    Connect to a QEMU text console. ``vc`` may optionally be given a
-    specific size.
+    Connect to a QEMU text console. The implementation and supported feature
+    set depend on the selected display backend.
+
+    - The GTK backend uses libvte for the emulation and display (when available).
+
+    - The D-Bus backend exports the character device as a Chardev object.
+
+    - spice-app backend exports it as a Spice port.
+
+    In other cases, QEMU uses its own emulated VT100, and ``vc`` may optionally be
+    given a specific size.
 
     ``width`` and ``height`` specify the width and height respectively
     of the console, in pixels.

-- 
2.54.0


