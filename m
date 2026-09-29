Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F376CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasr-0005G2-4K; Tue, 29 Sep 2026 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBask-00058I-G4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:42 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasi-0006NH-PP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:42 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so2427428f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700038; x=1791304838; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=99vdgR8t502cGUytZGyz+LgFykzw94POK58wRnB9i0U=;
 b=c6vlNiLIu4qOIxWUSjG6ri/4NPmI9A3QzvUySsflLp4Z+xuUhvByemG6jnWvcIH6q3
 unyCtD952FnzQLJ7oXgWOSTaryLMS0/0UwlmnJdmrd/mdfIMyhrZXdi+XCXuXoEav53n
 Ne+QjCay0WVJv8zsaCFbgTQ482K/dDqYMRaXepTivopb3ECiTyJYVX9qa3HLbaUXQ71v
 fp5h/YaZSgFo3K13ICr6Z3oFK8vKTYkGAoMC4SI68VLy1t1TaorsMPmwhEY1d5/yBVoS
 mouT6lJvnRSV+CGEUEKLF568SxsT0gdx4SKxBdG/oojG8kkJ0Zk5jusTGkuWxZ/vy+O7
 AJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700038; x=1791304838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99vdgR8t502cGUytZGyz+LgFykzw94POK58wRnB9i0U=;
 b=HIRjnJa2Jx5cJHh6Qe/vzxTwGkWBtojqKVUwoOeAcE0uD3cyvxubJJ32dcs4YEP6Uk
 x9MHdJOpldSKiOiBgbKl050rrQqYm1M6q+Vg01/iqtEHNxz8mNQ0jC5bdGJ80Hce9i7n
 OKfvZs5GtZAiRZ4fFHNgXUqpFemML+E25pMtRw/Q77oa3O7Gpe3vDXytu9XBO7H6oSbh
 konSggen0tVkogXc4rKVSbK10f1vzRjLRH9GY+gxHEK2qdsEVFzgZZPX8FKPqm4ZBhYc
 ZssI0xL4iUtvBbS8pCgPAlpQds7wrS0yMMb6ycHlFOUpmioqueHImBBjHQXQ1ao8Hs36
 pMjg==
X-Gm-Message-State: AFq9FYJavyB6jArhf7CIyOnDKqcfbgS4DXLLFFb6ZRtyH9ZwgeVyg6l4
 /UDm/kHgipVrWmV+NHtcaFGaEFqO9hnvpvXUdyWeG4mns7A9tOtCfUqp
X-Gm-Gg: AYBFou29CXl5sJ+jeUfPhviXlXQwYnFqpqZ3i32Ft1PbNyPM0H5fklG53haG5K5mFJS
 McKBO+WXJk7SyoGLjJdgE9TttSNA4zl2HsVWu8MkAifPYLifeKd33SngwoodgHXg3eJEauZQmem
 3Ur1Zm7CftizEoZVEPApQ2VPoej0zkSH0uiVzEPG8xN1TZWslSOmvaEgnyicSBjto+EeMwanXbo
 HsnvpOr+AQ57TQouxMMN4fRac99nzdNwCYUWYRvsYU1LLfBoF3OSZHI1DxazTFQTrd81TCXJs2B
 vg6BtlnIgebmOMH542F4S/W26ZHXPC8ge82NdFyVIa+RYuXG9/4JyqwPO8B/OpmThHuFMRgAUDW
 PS2Rd5YAtbJ0XYHa3RubxVIgbdSa49qap4HOpj/fhBcACglcKnfk9OLXtObrzc/VxqGCalNjvEd
 ZmQNgalmtg0KW/321HDr6U/3uWoDJHR3xhHqnhpkMlcZeZjYuCi2ZqOW+16zEwdp7tjNmePZrzC
 BIjExoFIsQETIq5EBxz3CTEgBMUzmxtze62PA==
X-Received: by 2002:a5d:5d0c:0:b0:487:1f7:f506 with SMTP id
 ffacd0b85a97d-488835f2adamr25674391f8f.11.1790700038226; 
 Tue, 29 Sep 2026 09:40:38 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5058c52sm5810519f8f.19.2026.09.29.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:37 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:36 +0200
Subject: [PATCH v8 08/12] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-console-resize-v8-8-2ff9183f8750@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=1675;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=xn7FKDtlXE+h+sBLQ5L3OZH6ep6T4dMGJSai7BGx4t0=;
 b=0RUPC2TLmqvUxvcP1vgWIEde640j5XUvS6d3XHunkBa2r6Za3dvNQNoSrFaIWAsi3qnOdJgH6
 o8oY6wXuev7BSiWJo1ijDnmVaLYMPUXjv1el8RziVbeBzwgDIrVxUAX
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.55.0


