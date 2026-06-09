Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF19ACD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYG-00029i-QE; Tue, 09 Jun 2026 10:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYF-00027j-6v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYD-0006z8-Tt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jB75nkxPFlCexEWq7TsFNXlMkTYiq+stfSkkgb8exY=;
 b=SERjcCpi/xxRRphLCGNooawPcOQcAX65tfKl2r5BhPFcqjDfNIGJtF5uwNw2CyuTPKf01l
 hnSVvq79CXSeb9g1p2maHGeE/JCxNWDSK6eWBd+VQUa2J6bWE0gGiJ77clNpnhNpVLeZiC
 k3i9MePXRXLHPa1R8DdNoSZUZk7Gx8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-zjopIL99OBOn-oPvkwKybg-1; Tue,
 09 Jun 2026 10:35:26 -0400
X-MC-Unique: zjopIL99OBOn-oPvkwKybg-1
X-Mimecast-MFC-AGG-ID: zjopIL99OBOn-oPvkwKybg_1781015725
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3F71964CF0; Tue,  9 Jun 2026 14:35:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53D9519560AB; Tue,  9 Jun 2026 14:35:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:27 +0400
Subject: [PATCH 08/17] ui/input: remove dead declaration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-8-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wvoT4L1d7wC+TPu6ppOr0c6dCY3j0fcg8rXQwzLLTRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR4lz6x2aVHNr+BNRs7BTJ+91UfW1WuZXfut
 /XCnwhXAD6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeAAKCRDa6OEJdZac
 5T/mEACl3sphr4xQuj9s8VdZ2UZasPpxhTVcfkd4/t/naKlI+DbkiUhkQLpJNbr+hbQ9yS99x3D
 o3Qmi96941A+m6OWYT+6RCJ2Tojaw2SWCgdEAbOYxl/7J9ZNhMNDv6rBKVaofwmwtIwFFymwo6W
 OxzyQnPYAymLIkCeHSA1dxMbpFBpAWl5kIdUWk1fP+hJB5aZvArsZ2xLAvoiCHCwutotP5Rr/cv
 l1CRDGheLDZj1wLsjKFzoJjMRfnIlDpSNTJh4YB/+CjI8MxBDw3gK51sGeM8HhH3pN8YrO6z2fS
 soqXPX8FhlFv7I7P2xFxsXw+9qNEq8G4hesJMETlJtaE+P/M9+iKRJNrAce4GStW7vhsl7kM3KI
 QTGEN+vhMMLcYAOT158+1KEl+TDEGj+MAFqpvYhgieRlEMqBwTGOIbvLe0oy8P8ZuSEtwU4GFwU
 ffJ/vIaRbtGx9LbNNfMyFFVBgMQvsSDLsWxqDNlW6kzKqJ+98pdi8J3COSP0YTdqgYRgq2+PUcA
 Z6wdpnJW6g7PEbf1+3ieUQJg1pVyfaQSCi7sI5Yyo9KG14ldLmOmY4yqWasPVfXuyBzvcaLv1x7
 5vWfusc9HPt6eXDLnDtIAjb8aP01fuzuno9RqEzKlsPJ3GsdChVvDGgGW4mQKnvM74o0omOJqDu
 Wv2xL1ctX3euYFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/input.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index ea2d944a7ed..6df8ae3a8a3 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -100,7 +100,6 @@ void qemu_input_touch_event(QemuConsole *con,
                             InputMultiTouchType type,
                             Error **errp);
 
-void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
 void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 

-- 
2.54.0


