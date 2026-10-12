Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4005DCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGei-0000Ie-9s; Mon, 12 Oct 2026 10:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGee-0000GA-NR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGed-00069B-1i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49e73611928so24888295e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813925; x=1792418725; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HSrF1Uf2SYNIft95MB9XFCC5nKQU5xHB3kHJUqzeVuY=;
 b=S4EggUzQeRzvPNNshkD2qo7HZ3vcMhzeeKhpfJYxmOcaTSxXQb/AOsK86LbKm0UqfT
 KLUbtNaC1lVGwwjFfbGkkbKMApUY9WUuZ47ZyelzZIUx0a/4pGWMU7j7eHJiK01Bw0uE
 s91hfnk0uMlbMiPFhsQcFVEGTvfOYYnfEfsTrkWJ3arj1PCn4ZfOH0Xo9304tLnDUhFV
 M1zwOu8GvmgUspavoKWRauk+aNSaeup3OTPbACH7APpj9miR8Wk9fVtGDdM4pIgSAYFt
 7RvSQ77LL+wXKKILOkCIeHa3LEXs/rKX8yiVX5a2HhSoE14mStV0EhsOZNeqbWvfgaJz
 y/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813925; x=1792418725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HSrF1Uf2SYNIft95MB9XFCC5nKQU5xHB3kHJUqzeVuY=;
 b=LWK9N6qRTsudxOC4xtHMQnwim8AvKSaF+yYNoseo43gEYdOmVUnop2dA0oWwLOvKnp
 RIYhTSsbn9j6FVxWwmCTGNe7+8G90OP9ragETL6LzUTmy+xjetHEye5Nxa8ZyGwSx1cz
 a5OuIp0NVJyk3qdG+b4CmUAebQG/7vfWGMYBSafrHJSJ4PjamzpYr0WgRyHRclrkv+f5
 8F6N2BlkLxcs0nypJK01MnuHmVnEUzC7BSF64S0saHiPb5Cezm4WTJn5n5mtW3giFuKK
 qLV6R/YY3RjhMYUceey5HosOI0t3Ve4sM4WWPVbw4QxbKgrhF52SbDzkLMvO8IcdiK8w
 62ZQ==
X-Gm-Message-State: AFq9FYKOlPlwMPnPvJpsLBRMr4ushapyZCK/qSnN7hNNe6cjSYoZpMBf
 aiw1dkUyoETphgA5Pj3B/ejp2aOX85Zp52dJGFHI6qufpfhzZpqAlKpU
X-Gm-Gg: AYBFou2+ofNNohcXUZ7KpJzoxjBOdE5Yipb+RzZD+2FD4F/dk5RYO4ClcXbGZALIytD
 KPA84BeRbPraSGqC78N19EH81HxPLZrrh2xlBpOBYX/+Ed3Nna3tE9RRMVV0OIre12n7ZkOJYlU
 Vw8ytyhFEKMrDkcEOtVHnG3iGaWLtctQS0DCkw+e9s+xBKYY5pGiu9BKka4Sm5VeKXnMy5DdzFY
 y2qhxSZhMxD5LO2dw+5j2ZOTX938R1ZnZ0R+yFmpbTCbaebcL/m9wbqijWOTmcA7ji/Q71HdTEK
 wxf+lMddppgAeKYoCLmaxY4rfLGdvOFwUvronLnx1NHP1MwM/lLxXTA6MRF9cf+9wta2vBKRb1N
 +9jijkt5d+xoM2N1/K/rfFftnxC+bNuEwUll5F50OJWfTUD2iTDjLsONySKq/ofCCWt0utRDyid
 D1kqjRHFa86LWPvACMIaydXmlDoTstN/PQFOzPJSGvskczkz3Q7X7cDWeA4mCTKkr1T4nRAemCV
 GbV1vcSYpj+IZMGItIG6y6guQ==
X-Received: by 2002:a05:600c:3b0a:b0:4a1:8963:b865 with SMTP id
 5b1f17b1804b1-4a18e447e9emr190837805e9.1.1791813925111; 
 Mon, 12 Oct 2026 07:05:25 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm290960965e9.15.2026.10.12.07.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:24 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:07 +0200
Subject: [PATCH v10 08/12] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v10-8-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
In-Reply-To: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=1675;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=+THDUz5FDYTrq+3UbYN01djura7EAPA8bWNZTUjGcf0=;
 b=8rfMawnH5kKVABlU54oiv3ChzlhUVUHXqPY7VqLobpLq+CGSmmENDZ+k+PtM6ace7RpriSyOU
 5oE5age8xDcBzKLu5C0MoV3/Lw4Qf7JWLM8obXPjBcneZPgw7f01HkC
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x329.google.com
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

Update the vc chardev size when initializing the console and after
changing the surface image.

NOTE: There seems to be a bug in the code where the dpy_text_resize
      callback is not called when the size changes due to changing the
      surface image. (Though it doesn't cause any problem in practice
      because the callback is only used by ui/ncurses for fixed
      consoles, whose size never changes.)

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/console-vc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53d9e9d39b..99cc8f09c8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -115,12 +115,19 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return vt100_input(&s->vt, buf, len);
 }
 
+static void text_console_chr_resize(QemuTextConsole *s)
+{
+    qemu_chr_resize(s->chr, s->vt.width, s->vt.height);
+}
+
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+        text_console_chr_resize(s);
+        /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
     }
     vt100_refresh(&s->vt);
 }
@@ -254,6 +261,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
+    text_console_chr_resize(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     qemu_console_notify(QEMU_CONSOLE_ADDED, QEMU_CONSOLE(s));
     return true;

-- 
2.56.0


