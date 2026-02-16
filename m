Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB55E7BD8A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw4F-0001rV-L9; Mon, 16 Feb 2026 05:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw42-0001pa-6d
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw40-0000yM-SF
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MlFTFz5SURHIKJ7Chwid9xkKley/jFZjjT9ZD8VwRk=;
 b=QinecX/6vhpGVLNBGccuI7I1FqcO64eeHQzhi7ySO9U4HBbshO2KNQxLhvJ0mLKY5/Mo+Y
 hh+8dIbfI4hclpqTuJPnbnIQBk7nlJzryiXIUTqyelagchwmkZJajpX4l2hxFazpr2nGyj
 loDSG330xpj4c1Sg6El8E5duTJ4CAYQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-3ioKs_pLPH2sd_WtKMobVg-1; Mon,
 16 Feb 2026 05:42:44 -0500
X-MC-Unique: 3ioKs_pLPH2sd_WtKMobVg-1
X-Mimecast-MFC-AGG-ID: 3ioKs_pLPH2sd_WtKMobVg_1771238562
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 671661800464; Mon, 16 Feb 2026 10:42:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C5E81955F43; Mon, 16 Feb 2026 10:42:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:14 +0100
Subject: [PATCH 02/85] adlib: remove dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-2-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NB1RxHPpsDtB0Hj+b8jAY+ZHvQgT3NFrR5FzA9w1Gw4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSTmvqS5BP0n/ThbU352THCO0YBhimZQ2/FR
 qiC8170nvqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5VFNEACjRiMHzMCcroDnilJmRkk7S2qAF9NzY1kJWqTjrAkD8u1PCd5a+odF0mIZBD8eKIwnZ8m
 6qp8oaMDBWXqpd2Mvf19Up8u2L8ArGQq0o/GByFNILS7l3wBjbbhS2IUjH1592UfFiwCLOskb+c
 WYnvXQjvkXrvaYun8pjCN4+WNgMG9AHskLJyMwSEYRjYGxPdMV1i7ebRgVI/LWTsxQ/XRICbfki
 AD8OqJSKkc8wLJD/wH6c0aHLG7+JDgQmQhPSkalkrFz5xFGaQfRpRU+8nFHYmJVoVmWVmaWNlYk
 1HZaPs3e//O5jMZk0n/rHfYkCkrmlrJah8Wfe4fTozmz+Comia7V8iDx5usVGmUoKYHRa/20Ndh
 M7YHXyISe9RtomE5d6/zOkDcf5MxpHXYSqwWNCvRxmwumXNHhp5+OxJK6man9biU0eoacfq2iNf
 4gtbzVt+Nr5p8lehviOE8VhAZHzQ9cUITvyTxGprxEFYyCK+aPLB017WDYoLrxdSxsEgvsVxdrO
 efCtdjdN3mw8h+222m/GfcnmusuRAi9rERWSLFrwIrqjupQauyUZZQz4IhsLzFD/EiEGTrRZ6w1
 Rh1pzK/GCw06u98Nlq1F7fvjeDDUhe0qy2WFmhhm1z8OTNvDFw/SzL3hyPiZxPk8PxNGLK+JKYU
 8l19f4XX2Q5pbwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Previous commit drop the need for this field.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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
2.53.0


