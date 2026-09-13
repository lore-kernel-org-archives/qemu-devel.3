Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD5C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hfy-0005dd-2E; Sun, 13 Sep 2026 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfw-0005dP-Mh
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfv-0008BK-3h
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcKSBi+jmRqE5htd8Se064SEu8m4A1/y0EMDWs4R1ko=;
 b=CqPCkwAkvR4XOMVJLf5Ynbj0wIItbtQQgIOZkaO1M30qUHyuE94GLEpvtsESXle6jAvJRW
 JOGk2zjYmHaq9OA7Xr+rSHBlyR1BxZRSS5It9Dqhitk2DHyPMavNpMJ1TFtd59BKFP7/pj
 4S4NmyHhVOj/t0dZaGAq3HhEWy7hims=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-8u5uq3iPPVaFSbwCVzVqxg-1; Sun,
 13 Sep 2026 06:43:02 -0400
X-MC-Unique: 8u5uq3iPPVaFSbwCVzVqxg-1
X-Mimecast-MFC-AGG-ID: 8u5uq3iPPVaFSbwCVzVqxg_1789296181
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA32A1944F2C; Sun, 13 Sep 2026 10:43:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F49241B; Sun, 13 Sep 2026 10:42:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:22 +0400
Subject: [GIT PULL 04/14] docs/sphinx/dbus: register build dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-4-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0LnpK7lfop2gthbFTJXP4k9HCAgVrxc3YmPiFW8QRHU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4ixP/TGPSh4xOaLTSdz0+v36n0W1gdw4LSd
 b+wc3bPTYOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5SUnD/9jW81onn460MM1Nh8sJ4RKVmZxZqgiIM3lOiQSbSDgN/XLfcgSjd57+cE5kPTQynQrFuO
 bposV9BLjkCjxtChEscQ0H4LgpXTs1Dzo03eIV2ScPM19iALY8BtWnTnQh7j8OVH/9l8U6iuRgd
 EndJPZMx3Z0UWiv6DhrFA+iCyZIQJ9DXz/tIt0/Lf7Pvpxr3dv9HejB3ciyKslprjqaDlcQL+8w
 daBzC1EK4SVcd8C4FEroAvw5RxeZ2H/ujr+ddsUyxnatDbcUpYb+VAwNDUf/PXKKaDI35R789sk
 pj6xxb6I4mJRvDjXJJONUi7R05oYHFIps0aUx8zt8QlqBvHQB6gm2z1/OAi/jJnFqnYcxvdxEzg
 TyylrtbJJ4drxptQjsicnBg2RhBNbId5G1Va8MnNvsHiUSJRIPEXUUZshZMpPzoDOVHDNK7v6Bi
 mZfTLcKgCwj7Mww8HyLeY1hKv0EPWAY7C8LyULqm+Sn/gGZ5dMbDLXo3mDzLIMv6pwXkoLqS+ym
 +3GEGA3UgRYpbPlZg6ycw2syGWtBU6yNUIVnulPy5LrJW8uQJfmUfbhvJStPKCoPVfwMJhal/pz
 tOPBQKKaGzq4+0AtUjzq0+uT0UcPY1W0OxdLD3qqHZoGydgzZe2JJUa2c3LcZU3+gMOyyGkrs8+
 4XQYwFzkTyCjjxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Touching dbus xml file wasn't enough to trigger a new build because
the file wasn't registered to the dependency system.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/sphinx/dbusdoc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/sphinx/dbusdoc.py b/docs/sphinx/dbusdoc.py
index be284ed08fd7..2b086e2f583c 100644
--- a/docs/sphinx/dbusdoc.py
+++ b/docs/sphinx/dbusdoc.py
@@ -146,6 +146,7 @@ def run(self):
 
         env = self.state.document.settings.env
         dbusfile = env.config.qapidoc_srctree + "/" + self.arguments[0]
+        env.note_dependency(os.path.abspath(dbusfile))
         with open(dbusfile, "rb") as f:
             xml_data = f.read()
         xml = parse_dbus_xml(xml_data)

-- 
2.55.0.543.g5ebe2ebe4ea8


