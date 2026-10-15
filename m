Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DDFCC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHN5z-0005ft-CO; Thu, 15 Oct 2026 11:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5l-0005Um-Ho
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:03 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHN5i-0001PN-2g
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:10:00 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso39763765e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792076996; x=1792681796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=74etoE1H4Vt/KU4xZOoXzZ54Zty9qqrQvEaIpDfvh7E=;
 b=N3BmnQr0NhSX6brgfoPtxEC2RnsrGId9pXzZBAdAeGC3WZVXGXVXYV3+6tJp1xNx/U
 1vfjgJ5uSYDmyfUyL7Aqb4O7F9WtCUHyJ+iadh6rC70C3U7aXVNIbi5bS2HXMW3gVfh4
 4mx70xEVrQIc0Hxi5Um17c5bS6YT5E+55iZOBTRlOt1Es0RDnMQp6JqjGVsrJiEBANfH
 xX3uAF6bxqL6QtdtmANaFVdKnlMvaSK2fdWUkTEGxXva59PZxdShaIifkzUav6STA0gv
 9+I3xRX06A2AMqN+UIrG3IsF/lOo9WjIybqCr3LMvUaG4u3jqD/OcGWCJNE6lZrYrl+D
 9Gqw==
X-Gm-Message-State: AFq9FYI8grAzWhyyqby9giSzAEgy+GfBCeZLCTXGzEvUur76O+E9ti3c
 wGdxd/PnzI1YMzq7+3fgBnmcMbCWBGknM9Xyik7O/FGUPJtB2GdMTztA/oLteg==
X-Gm-Gg: AYBFou1KBb2+YJN/QlD+yMKfpe0gBJkjjBdGl22hoAP2flJGDrATAVzJMGiQNNYBt1Y
 rc6pS4+6PK/FXBLhNfBpBXjgWEEF3pZ1JwVhgXcboRx6juZIyN6W4plzFzp1V0k9TaVmxNJRwK6
 d4uqV4m1KPpas7w29HuHsi8Dm/SuAAh7XDkP8icqw59Saj7n2QFMORjrEbjIZ26B7RmIEGDyFOy
 vSkHlhCuHz9xvPYmARX/qn0c8dCz+sQ2C/6+fJQWhO/YxDo1oNiz0OwQ8ebLTX7Bi4cWH819zJ2
 LuB8dnIWUYUlrXK4GqKoKx4a1o9BHc5cqd1T8RgsEVucw4Pubj7DZLxMcUbL4oHpQzotUjHj9RQ
 Zl8qT89JCSwsYh0FYCMHzLRdXvM0G+CxY4tU+DrBMIWFKc4tV6d9xvuusA995qjLoIc0O7kup5i
 PG3Bf1A8jjMMCNpvznP4Xr0a6+tjJrKsFPIYE52vbZrZSJsFLtYgKbEH81yzOYqNP1MgGzBpowy
 4QR8M8WpwL9Igmm7vvYWx8G8TQOCxa7Gp07iRm8+fj7sw==
X-Received: by 2002:a05:600d:82e4:b0:4a1:a45a:88f with SMTP id
 5b1f17b1804b1-4a1a45a08f7mr248945935e9.20.1792076995953; 
 Thu, 15 Oct 2026 08:09:55 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c50689e6sm21829695e9.5.2026.10.15.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:09:54 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:57:39 +0200
Subject: [PATCH 01/22] hw/sensor: tmp421: do not report a stale errno on a
 parse failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-clemente-v1-1-bf591886b5b6@free.fr>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792065464; l=1336;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=XVWhDGukLr6PXwfmY7rmr+tRBguotXtnONw9Q1wdDtg=;
 b=WmgsaWFpkmIFw+F3nWjd/O7l2l0iYLNlbzlXG4rsJ9GkxrZ0G9HrP2bFGhYNFKh9dkwshkYry
 1NBe7mpQ9NqDSbPJ82IP+/UD+Ts0qtl+iRTfBZYTh9VYxKTnHqa0Fny
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The temperature property accessors decode the channel index out of the
property name and report a failure with error_setg_errno(). sscanf()
does not set errno when it matches fewer items than expected, so the
message is suffixed with whatever unrelated error was left behind by an
earlier call. The bounds check right below already uses plain
error_setg() for the same condition.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 127edd0ba5..fde41b2323 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -117,7 +117,7 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
     int tempid;
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg_errno(errp, errno, "error reading %s", name);
+        error_setg(errp, "error reading %s", name);
         return;
     }
 
@@ -154,7 +154,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg_errno(errp, errno, "error reading %s", name);
+        error_setg(errp, "error reading %s", name);
         return;
     }
 

-- 
2.53.0-Meta


