Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55115CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGdR-0002gU-F5; Wed, 10 Jun 2026 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdP-0002f6-NK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGdO-00070t-CZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWLOxIX5XZl9vwCXNGaKm8hQOhR+iz6yVZkthJeSGF8=;
 b=XafKQHcImg/0mCMaQiwh2h8iYunaNCvdbjwEn+uIwauYAEUE3RUxLb6dpO50w0D1vgDJCT
 7kOLgn73FdyQCFWfBYkaAwzUTXXhLK7vVA8uMgWrB+o805UCpzH+aqWZcwWkaFf80rPi11
 a5SpI9XCmjIa8I1kJfkvDx2ahw1ZIps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-EDX2QUv3N0eoyqN4yqko-A-1; Wed,
 10 Jun 2026 06:58:04 -0400
X-MC-Unique: EDX2QUv3N0eoyqN4yqko-A-1
X-Mimecast-MFC-AGG-ID: EDX2QUv3N0eoyqN4yqko-A_1781089083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA733180AC71; Wed, 10 Jun 2026 10:58:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 953F01954112; Wed, 10 Jun 2026 10:58:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:50 +0400
Subject: [PATCH v2 08/22] ui/input: remove dead declaration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-8-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l6d+462ZKgCVnhnNIGhbq34EYcMeVFg4cug7qMLz0jQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUL/JJZtyzRXth9OJEimr/jjEn1rtA7ijHW5Z
 PYnkkislPKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailC/wAKCRDa6OEJdZac
 5aJsD/9ki3sf8dtw2M16tD4L9SI6GT80rCmqnQtaxtfNL/1hVnFuwenXC46UDH46bBYRCiJdi9z
 3OiNGi1OrlzZIFwzw8VbM57GrxXFR134g2hnvOyGcEpGy9ImvkC0CnWHJNSyOY3VqjHA0ZfnXf0
 F3kmIhfFWivvQPYKFXH5rydZ5mpI8v0ooyBNZEnM7rUr7Ul1IAh/fxuCXneySLGxDhMHaReZC6k
 LZi6fmUN8k1LXsdOzBK0YhgZjza6M4ueVRqvOtU7n7o7BKbf/XBtGcqfNvCow6Zc+McUGWtC8wQ
 xNd+cEs3RHYSnpiUxKlaGimltX2RuYUo5rfPiwZltHpMFZ+8s+TJetEx65N2mYH8mcf4mE3OvYq
 +AJQL0suLbO1x4lHHrYbzX6f+oZ13WMM/2jR3kmix4Bapovhfiy5kUH7/xpyE9i1iKFtQNxSzHQ
 uZ16v72yJH5q4xqxaRfEp7g10QwYB05vH8b0Uj6U+TcnIp9T/C/I5AkbXtWyhOij1sML4YtaIYN
 HvWOo5r8LXJ+K3onazTD6bIXqMbigVnW83EDiqXRIpatC3ftEFzF3H4EAiSk3iqK281XbnbLR2/
 4GvoHb03CC0SzknWeq95LiPq9VPJiGhDlJ0zVKhn+JFh4fzXxFE0ce1fmFpF+54wFw55M2YVaaX
 Q23EviDMcsz7Ffw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 0337e4123e6 ("input: Allow to choose console with  qemu_input_is_absolute")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


