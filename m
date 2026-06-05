Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC1CD8C85
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkN-0006Yc-7B; Fri, 05 Jun 2026 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjz-0005pP-Kg
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjx-0006R8-VK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oChfGW5Tq+2XS1SV5t1cQUIYoRVR7500LonYw5rznpg=;
 b=EBgeTEilVAEQbP5TkqsM8S8/bsYmztuVTTyp8B3LoYllWdLzecKRQ0jH9+JrhbfIkbZDir
 EaqVL9gFQlyKwCLyYYlz76fZ+0XD33OjGR9hk8WcKqid+u2tb9g0iIVqVFpm4F7t2yVf6t
 hw2wfI3qx6SoSeAkboT2jqyvdDgJjZ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-nxvewf5uPqGNWqfNT2Hi7g-1; Fri,
 05 Jun 2026 11:45:43 -0400
X-MC-Unique: nxvewf5uPqGNWqfNT2Hi7g-1
X-Mimecast-MFC-AGG-ID: nxvewf5uPqGNWqfNT2Hi7g_1780674342
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CF921944D3B
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7347E180049F; Fri,  5 Jun 2026 15:45:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:34 +0400
Subject: [GIT PULL 14/23] target/i386/kvm/tdx: free strings in
 tdx_guest_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-14-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=893;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DafxdRB7/MLkueWJrLE2w1Qd3zyBZmU4Trf2EjVE458=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VxQnHWL0kb0HMM9DjapnsY/wpon/kfpDN3
 BCyWxwOCsqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5daDD/sHBhngmO7+5ST/REwMGs9R2myXdfB/2DaWtBjj316/p2OJ/cA7cCZemqJxP7AgqgYCFvU
 wcqQO2pWHsdA30Wse8C77Ga2fUnJ1829EnwV5NVVaK4hEm3xLRaA7LQARq0o7MCFmdXLUpRWLeW
 BU6+EE3KO0rpfn6jIujygHpp+HNqtsMQG1a/YBbwqnH7lkFb5OIX00c0hNjjY/jbAS5E/585r/O
 bY4tiQasp/+NlYnGAaZ0OW6Mf4ELOtM0Re0uSw7vbQDeSOTXvYquxU7zUACtErTqwnWbao50YRY
 vbjtrPGXUgEHbAtRIToIDA+gHxgJHSmi7+zMlVlALCQ9qfSBZpLgDbaBSdfARYLI7+dDogy+JHC
 KKAatAriypq2M1Z/uzynr/pX4nOPpmbzbiygqxNhCblegUYPyYe2iY38uauVqtRCLGIQ5jXMBEf
 ufC7tBr5GDVcTg+j+UPSq6UIKB8s/pNWSpmCHNRgAyStPfEp/fONGPCtyyzyeetzeG1T8A9jkKF
 3OF6lMYgbStenjs5hIeRh23DwS+n1pdLYeVDecJquMUJ8dSSpAdRxs/f36XT8G2rqRmXonZ3rXa
 RZ5JJc0friVVVJ0VqkWrp81Sfbcoz0/Ryl6R+Jrnf4oF4zUqSpShwj4qGcQj7trYZZHlZ7wmDNt
 HuZM3YoKj61lLjA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tdx_guest_finalize was empty, so mrconfigid, mrowner, and
mrownerconfig set by property setters were never freed.

Fixes: d05a0858cf87 ("i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..df46fce7693 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1585,6 +1585,11 @@ static void tdx_guest_init(Object *obj)
 
 static void tdx_guest_finalize(Object *obj)
 {
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    g_free(tdx->mrowner);
+    g_free(tdx->mrownerconfig);
 }
 
 static ResettableState *tdx_reset_state(Object *obj)

-- 
2.54.0


