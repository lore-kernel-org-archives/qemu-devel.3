Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E4CCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs7p-0006I5-LF; Wed, 17 Jun 2026 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7l-00060w-BC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs7j-0004De-65
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJcqLC9XeeBWHdsWf8jrmEai2wwzFgKipebFho3UbH4=;
 b=JXCkq9GTF8+V1Z1nuWeimuaR9Kxj6/0TdLmW8cErDfZaDSu5xfQ78RtX6btfaQRgUxZZlk
 L3PWy2mrxCXv1FUF10QLIq4M5r5D+Rjx8CSgTFSngBfOn27ZKKXOHvYEHtzmKzomtUxZ6p
 vD6JBm/hlbnkpLkeWth/ACWsj4dGNA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-AFS5MorlOoy_bzqnZ_L6rQ-1; Wed,
 17 Jun 2026 11:24:12 -0400
X-MC-Unique: AFS5MorlOoy_bzqnZ_L6rQ-1
X-Mimecast-MFC-AGG-ID: AFS5MorlOoy_bzqnZ_L6rQ_1781709851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EE481806C98
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C0DE19540CB; Wed, 17 Jun 2026 15:24:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:05 +0400
Subject: [GIT PULL 08/27] ui/input: remove dead declaration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-8-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fR49RwXr8AqEM3MBiLeAIjVZu/I1P4iMul4UFUfHijg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvovBJJDL672NUFVv9PizRGy97MLvBA2CycR
 zh6SRZg76aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76AAKCRDa6OEJdZac
 5a3JD/9FUs9dk0KiQDnYAFq9TbJrfqoTx5lqRcDyMgv5U5+7IVbhlj6WfH1OvfOS97fej1f6/25
 W43TWliRv8jFTdGboS461eY4mhX5OC7qt2YXC0621vH74171zA6vv9jeXyfbo33jG8KjI4Nma64
 /2jlUzsWghUL3FDNbx3HDn8E4+bEmRQe837BZ40Ix+q/U/PO2QYY8vCpxjWWIsdLR/+0FzGaOGT
 zl2kFwfcfMI64nDsaV/IZJdvbjbrzWaCXiJNg/HYuOdupkMEHyJuMeUEENiBYE1nZhjoR+R3oVz
 a0mPW/fptSKtyy2gQa5IITRmjlwimYQUvJSvvuVQh/CENNKqnnbdrydhz4Bv7GOnB83ZVqQ7X/T
 KOKyIYr5IJGac6KUAp6GyPPqym+YK6drUl01BQI2jtsBHGyYO7i+xp6R3Xri+fzyE32wmZyoR6+
 eW77v7EWqsHEJhSmoepLDAB8ly+upVhg6yNY6XvLnPfjmlgy1Nj0h3hu+2qFg4uqBmQeO7tHdHw
 UA12lUJW3dsb83k3wsaplYr67/h/KxcxNWJWDfT2hhioBwrWqysG8oQZgu7Pru27RIHKJHLDBz7
 /FyvJ4hGczNqFQYVKXChLkn8gbI795n42QJeWq5hS3xU9mFEwbnyrbXjEjqXNIb2ezL9uVBZTEl
 awrvlhkuRj/Jz3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Fixes: 0337e4123e6 ("input: Allow to choose console with  qemu_input_is_absolute")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


