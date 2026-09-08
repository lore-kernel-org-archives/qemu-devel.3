Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B0C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xPv-0003rP-GG; Tue, 08 Sep 2026 11:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPs-0003r2-A9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPr-0007Xh-14
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAFNoyvj+YXGqN0JpON0sM385oGtzFD4MoEk+w0Iq28=;
 b=JvONJ42uyTdUnGvGuDy5abgAb50excxgOIPQ0Ty9wOS8rENiKWocadgmIrDNNgql3ZC9so
 UQlxw46exWl4UYsFe+scT5Q6BI2F6heYgvc31Gl/M8xGO6gXZ2bowAkiuca3XGZDT9opPL
 GAEKVB72P8Hm2mAaOM0QM/lnnAS+e+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-LporrnnBPsG64bo0ToQ47A-1; Tue,
 08 Sep 2026 11:07:14 -0400
X-MC-Unique: LporrnnBPsG64bo0ToQ47A-1
X-Mimecast-MFC-AGG-ID: LporrnnBPsG64bo0ToQ47A_1788880033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66AA0195DE62; Tue,  8 Sep 2026 15:07:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8420A1800641; Tue,  8 Sep 2026 15:07:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:47 +0400
Subject: [GIT PULL 04/15] accel/tcg: fix "tb-size" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-4-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MfnRvRly2UY5P5uzJJrkX8tLTLJ7e9JP810t3Z45rWc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPzxdP4Q9P21BnFOoW5XEidJvKb9X6zSeLj
 9hlDIVhab2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5ffFEACWwRfY98FfR49U4OkUtmp4uG4NZThD3C7DxGKC5ftmOJf0XWroVBhVyN3SVOp/vwEl53w
 BkrG7IkexD+b8UGdAlenm3+dITHdwUl8rk9vV4Kf5hxpSvQYOTIg9iGRqifm66Cmx0TjVX+fl6F
 7fAz9S5jPN8P2WTJ9Xi4r85a17sbqZpr6LW+7ZuboEsswf/ho0huNDd2oTeLf0TA+BX8uns2BJ2
 eGwkmExsYsQf7BNXCPQqisEmKga+Ckfwv4H+msxiLjLSwzNLee/LgkeVxmaQQZCCS5c4IwdrM5b
 wHdrUbj+Qvl7E5CyBirC9jgnYzwEKxq+V8LE88EHRClNdFNp28vmy+jAKM/57/yvkf87jpt/g/x
 xG5OO6qdKcgWbriVnorpne4AA4kDBtnFSaJdCI+aqfkTqZ/TiNpbQRuvV3KcgPAvoXzDijJgJPl
 Ri9GPqo2KG7WLkaeD0udvzrYV/4FIPHn+9pS/K9m6ytoBDOZh0swC80N/g9ynXRDkZsXEFeccnE
 zz6Bd6JtVFMfbGa0coYLrhKaj4CJIrPItR1mwaIB6/C2T+iy8TpPsSqbnJeFNn547OwiGvXH8qZ
 IHI5O82b/ZGRtE2r+ltg+18eE8lD4NN7tKox9+CG433JGcKG1OQG7PO4xSB2F+uA6g8GWbmhkgb
 rugZU9BQmbbLHbg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The getter and setter use visit_type_uint32, not visit_type_int.

Fixes: fe174132478b ("tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7186c10cf022..767e8805552f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -270,7 +270,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "int",
+    object_class_property_add(oc, "tb-size", "uint32",
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL);
     object_class_property_set_description(oc, "tb-size",

-- 
2.55.0.543.g5ebe2ebe4ea8


