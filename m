Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538ADC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHsp-0000Ui-T1; Tue, 18 Aug 2026 07:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHso-0000U1-SB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsn-0006ta-Di
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZA3KPMz1QXwmqifrxmnrE29bxYgKf9Omr/fvy5gJgs=;
 b=OyyZvYTl7H85mBdJw7JEqjzO9GV9ZG1OU7b+e/zuC63o6ZD3d+JRKjp9zPF77wY7oLtNxT
 Lp+JTdcSnen5V8xG8tgeu3yX4mIDehNwPjRzNhUWUsCBLZZCWpJoMe6LoMWOcHggakSdg2
 MCED8+2wvo52bg6QrI/hT84js0eY4YU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-tyrdwvFyNVyg5QJlIbTYUw-1; Tue,
 18 Aug 2026 07:21:13 -0400
X-MC-Unique: tyrdwvFyNVyg5QJlIbTYUw-1
X-Mimecast-MFC-AGG-ID: tyrdwvFyNVyg5QJlIbTYUw_1787052072
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CAC1956045; Tue, 18 Aug 2026 11:21:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9458F3000239; Tue, 18 Aug 2026 11:21:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:02 +0400
Subject: [PATCH v3 35/74] event-loop-base: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-35-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RblZf+pyuoem1W7YPJoezx9g55FQPa9o/5iSTsZYsn0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26e1wvNfwalMPuqlHXHVDXDby5vp74X4ff+
 lv2t0o+lfOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5frUEAC2x6ELzJKIJS6poWM7SsB9KlI4+pHfJ7FOaXJFJxyE7eS/5wUyQZVYShXOE8PwLQIopDP
 fKL2Ljk/Y6kvxO3HokBsmh+X5nJztvfjod8l8MhvU6QZp/lK56UoeNpESG0vziuffbyaAzOAIyE
 aqKFhib5dMW5DHtcorcH74nlgepSzU519QRnx2NIVVbr2u/mQYw9kmkHttJ5kxDuQZIBZ1YHcYA
 9ODl//VyitcQ8pV9yE7SAwgFF/1bWxQd4Hbooe3KdsZVZkhjedaSsSuHyhmxEZYhMTj/QRrc8OP
 5u6SJ7+epwrz/5jZSLJLPt9HTQKchPged+FjA0/eSjqeRePELAHmhsf6h0Fe7mvkqx7A36ebRUc
 /O6DhPbMkm98EKtIGYmw99+V4o7h1AJUbk6VSYp1Ko4yRgHyHWYO+g+fWiGRcW1kmfV3niivxBu
 4XMrHqgqglLz1JmVcat7T6zYetL2IDTNDrt1gtBv1bGiRVWKR25ydSxWSf504KyJ3zZeUtsVa+0
 fRtO/fnqleZCfGoAE9JTQkt3R5ww6Vr5kwkdKl20AI0C9gG7F10zytgUyq7i/KsnwuzCZzpOVIM
 onm/4Q9bDIAfgqcjYZHTPZlscLFukB0zpBYh2rlh5LkinN/qodA952pqqcaE5eie0c8TzSzvQ4E
 16kWbGLg01yW+Iw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 7d5983e3c8c4 ("Introduce event-loop-base abstract class")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 event-loop-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/event-loop-base.c b/event-loop-base.c
index ee5987ddbf64..23f554d92ce8 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -104,15 +104,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
     ucc->complete = event_loop_base_complete;
     ucc->prepare_delete = event_loop_base_prepare_delete;
 
-    object_class_property_add(klass, "aio-max-batch", "int",
+    object_class_property_add(klass, "aio-max-batch", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &aio_max_batch_info);
-    object_class_property_add(klass, "thread-pool-min", "int",
+    object_class_property_add(klass, "thread-pool-min", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_min_info);
-    object_class_property_add(klass, "thread-pool-max", "int",
+    object_class_property_add(klass, "thread-pool-max", "int64",
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_max_info);

-- 
2.55.0.543.g5ebe2ebe4ea8


