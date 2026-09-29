Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF996CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasj-00057P-0t; Tue, 29 Sep 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasg-00056s-7P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:38 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasd-0006M3-En
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:37 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so17989395e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700034; x=1791304834; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gDqotaOATlDOXa0rNj0zFQhV79ejJvu8quNLxZWaS4=;
 b=tAsIAOu2bDJiLeI7/6aUPK8tdnkS5OdinAqryo9nY67ogLwMod1GNLP0VpZ8DivRr1
 ERYdTckmRbGsVT3oDvyRi8eqnb5KKm382ckEy2IhGFXRJOqes7V6jng5EHnaZrdpb/SM
 ErQ5tJsdHd6wJXLSObMPdcBTqCYxCldK9bGfcVRobNKkROpVPMRhtXBoa1Lx32w+RrAE
 W+nJX0E2NtKJI4dKWSrePu4dPXpx9lBx3KIjsg6MWB40CCoD3F2nrs3gf2+Cusqvw2M3
 o9mrRWCfE+lNOrVPViylfMDB10sZGsV7dHixJ427sZoQOHLnV/cyh0TNriLYXaNN7KJV
 uZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700034; x=1791304834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9gDqotaOATlDOXa0rNj0zFQhV79ejJvu8quNLxZWaS4=;
 b=pp/E7yhqzKYN0MkfW9jS+UJabc+SqRiwNVJdbhDoXGybTrK5oea0xI05/RyhRx6BUK
 WPgXFWUaLLg/qhuVb0RIcs2qB6thvooJUO94wM5KfOSfDMcLDaKAO55682GS9bBHRx09
 xCVBLem+iTzyVVD28T3jvgc6k4FBC/YkwcEn8rxv3hVBI2xQPzW/EuACb9CGzwr+st+T
 vs5AsDh+MWSC6rW5XsGlIWxudIhSZcYXN5yze/0R/KIHeLSxJyYITWwMGcuEsHSnWrSN
 7EAEJ6bc2Jd0TC9XTI0AjAgsHlknm86K7WTWLqKblGLO+o2wISQcgtHIR2NEaRi6J3wA
 hohQ==
X-Gm-Message-State: AFuF++mp0ZX+GbxIOEDStU6Nv7ZI5x4VNDNGh40OdTQyk7OpqIPa1DtU
 IN2SS+vDBe4SJM2j+9OeYM/3pNv1OVliDoH2KxxW8mv0/oZoxO2/BuTX
X-Gm-Gg: AYBFou2zpNSXPIx8Aj/TOOJM3CAPEjma22D3JAPSRIjOLrXZYkhxJHRTsmZ6FUhffRf
 yA2w1crpMIplFc1W0rXxBrmBo1wv4HUjlSC7KB7+Ya3/s2iG31GO8hfmPvo/3AnoEBdwzTLKO9N
 dlmUwylsUBTj43IcDeeBTSkmqSrA9ILkVXdYCzeLuERZwNqQiVFmTbba63f7I+0SrIGss75kZ9+
 k/2meISPgdb3gGiCJeG/AB40Vxx5hxMWV1RJe/vGT0COVg3NjTVf8KsqLFqINYpJD5gq10uAmrX
 pOrOy9wxGS1tGvdYTO5mXrQ/5fN5pWxZcAkcZt6dJIGIIge14E6O3S3RGM/AZ8R9/ohPH+NUWJ8
 mXYM8bnlb0lPa3THkYIVCT+gv0uYKm6ZgMQqSvZdKHXuZl+skWHmr04ZrXKGNB9xMfobky29Ghe
 3YlIsVqA01GyyXuHpfwz1ohJtz6+rSYWEzvtL1pZo+jTxi9UgEQa6T8osnzT1O6qMxXd9csDENQ
 kk/Vx9K1syqNZuncdS01ofy4AI=
X-Received: by 2002:a05:600c:8b31:b0:49f:fd66:5fec with SMTP id
 5b1f17b1804b1-49ffd66616bmr174290625e9.0.1790700034075; 
 Tue, 29 Sep 2026 09:40:34 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01489a5a0sm638935e9.2.2026.09.29.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:33 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:31 +0200
Subject: [PATCH v8 03/12] chardev: add qemu_chr_resize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-3-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=1613;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=1oPOGauhzyfxQQGSsUE3ivOXrylJK7I3Igkgzq+/mqo=;
 b=vdyMaDQfM96HQFacnbNyrZK2J4PvNnLZBBbKCtY6wLWPZS9lFThbqiHaZJ86A/utCW8Y1u/kh
 HHMSi++V/l/BDHNDZzo8GYdBrq/jao9ayVRPYy4siC0dbosBx9KDH/u
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Szymon Lukasz <noh4hss@gmail.com>

This function should be called whenever we learn about a new size of
the terminal connected to a chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 40d2180ce7..8c8386e5b5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -386,6 +386,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp)
     return 0;
 }
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
+{
+    if (cols != chr->cols || rows != chr->rows) {
+        chr->cols = cols;
+        chr->rows = rows;
+        if (chr->be_open) {
+            qemu_chr_be_event(chr, CHR_EVENT_RESIZE);
+        }
+    }
+}
+
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ee9f24038b..2616c19cc0 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -235,6 +235,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
+void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
+
 #define TYPE_CHARDEV "chardev"
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 

-- 
2.55.0


