Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2770D72343
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBwC-0002po-V8; Fri, 23 Jan 2026 02:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBvt-0002mF-Oj
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBvm-00025B-If
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqxK+L0V+o5zYgvAuSQoeyGZHdpOwX4lOM2Ghlu1phQ=;
 b=iH7HXGXTAL2QO00faW4i6SVlmcFTU6MfHUMDKuqybCnqU5mvEUIgCXJztOlMbAWmVHYz2d
 qkb/D5I8MqS8jhwsg+stfTnYhQoa8eO2vbBHx4Ktv9/ea2JATrRNja/zeHarWDCn0e0cqz
 X9HzA3xojQIvR0sjVY3KRhT/K2LsWJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-vIgwASTmOhCLoEvVZbSQkw-1; Fri,
 23 Jan 2026 02:50:05 -0500
X-MC-Unique: vIgwASTmOhCLoEvVZbSQkw-1
X-Mimecast-MFC-AGG-ID: vIgwASTmOhCLoEvVZbSQkw_1769154604
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F9D6180035C; Fri, 23 Jan 2026 07:50:04 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 360A6180049F; Fri, 23 Jan 2026 07:50:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 02/37] adlib: remove dead code
Date: Fri, 23 Jan 2026 11:49:05 +0400
Message-ID: <20260123074945.2563196-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Previous commit drop the need for this field.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/adlib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index efab5107a4c..f79654627f5 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -66,7 +66,6 @@ struct AdlibState {
     int64_t exp[2];
 #endif
     int16_t *mixbuf;
-    uint64_t dexp[2];
     SWVoiceOut *voice;
     int left, pos, samples;
     FM_OPL *opl;
@@ -133,7 +132,6 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
     s->exp[n] = exp;
 #endif
 
-    s->dexp[n] = interval_Sec * 1000000.0;
 }
 
 static int write_audio (AdlibState *s, int samples)
-- 
2.52.0


