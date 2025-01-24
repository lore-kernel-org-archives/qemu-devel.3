Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F556C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLuD-0004q0-R3; Fri, 24 Jan 2025 10:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLtl-0004bl-Lv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLtg-00061q-1n
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737733622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tR/Bfe6dC3ViC24psGjFCtIkiPOyvc+/X6zxMElS99I=;
 b=PSizopPbt06b8B87eTgy8A6POqVFrQ3OerQlNUrTc781fiANAMS6DImfYbVz8JRIXnwj47
 s0ICFCo/CgMJDaAhzavxrKdY5yBMt7Sly3q9vEBCzWvGlnpVlInxWY7vlOt27q3C7TtnfR
 RIp73Y0JrlHZOmEo5zM6oaoko8N/qgQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-QMGgxxLyNUuvWL-_vh4SEQ-1; Fri, 24 Jan 2025 10:45:54 -0500
X-MC-Unique: QMGgxxLyNUuvWL-_vh4SEQ-1
X-Mimecast-MFC-AGG-ID: QMGgxxLyNUuvWL-_vh4SEQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38a684a096eso1073094f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733553; x=1738338353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tR/Bfe6dC3ViC24psGjFCtIkiPOyvc+/X6zxMElS99I=;
 b=pUr9lVXRf7NG9nPn8DIHDRw3YRcikpnBIW2zN6e/b1u5dERdkC6V/9OpXhKJu4XL3M
 6MV0CGIwu4Bt4Z7pWTvdDI9GTBDqKkQ+etJ50JonfmsxAh92yJqCngTSjujqYrUzTO2x
 pWl/IPu8biKOFmcotDBhEnzaVNiRibNxBFVIHFtd3pZq3Rxla4EUjYjzfGQ4qQ9q6hXH
 mA2QbvdcZH+OmUly0XUSpHIssEhP1vaFLX/veWN68SJ+lwb5lrNcCxGpST8rzPyt2uB8
 SJN1B8vx+wRffXHxISBVVKdM1oahdECVx6doGiON7j5nHqhTEhNX6UrKyRvfW9m7uIjv
 +TFQ==
X-Gm-Message-State: AOJu0YzlXUoTsl1JzSKHQTqaG1LPQ6qHysCd6q8zlDFrmP/mNUp0aUeT
 LNzDp8cdenXjdvjUUZM9n8DxKeEop1UpMQj/u/65O6U6gnbSq3lJstNzLSOyyFzko/goRBdinnS
 URlndqpOh/oLXoDq1ARJxAjmjTlYHPom0a9mZ6svk1G06C9iLojcQ7QnPPCZYCG+GOQ5HUJBeTx
 K80ilXbLt/nR6Gaj0ua/d3COR24jhwB4vKt+0ONw==
X-Gm-Gg: ASbGnctpBmnRihgbc97ah3djQlhijtK4Zy2GWfsJans+yyoBJpoXYkdCW73bJAbnFiz
 vYEho5sZsQel504wfBy2kVzJRzCS6u2u8Xlh2KRCzWuGtQwnzYoKmTTNLg8AfD9Vy7AWwjodM5B
 ESAz/DfAtEU0u8i8KiKl4CyssBoqFf/Ng+HcFSG1hqAGZOeIAMyzDrEN5OkGUiFKCOxKCdO5ypO
 z2OcpeWYI6M8ZqJ2irPCgBjxhX7s5PbYL2My23wIBTGzzC3rqjnDnJUELvg7wNzrRhzz/A4nvmO
 UeJukpgT9YCv7Wt1ZvA5oBKeUbzB0ntfpenG3MZgrAeXy129e9+WjnE=
X-Received: by 2002:a5d:5512:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38bf57a1eb7mr21972208f8f.31.1737733553374; 
 Fri, 24 Jan 2025 07:45:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8r58mr0bMdSqwIKv17vEXdb4niYrG3/6M8NhgVtYGosxG2wLMLUfyNYiJ/XcogVbU6gS8Gg==
X-Received: by 2002:a5d:5512:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38bf57a1eb7mr21972182f8f.31.1737733552993; 
 Fri, 24 Jan 2025 07:45:52 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1baf65sm3065085f8f.64.2025.01.24.07.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v2 6/7] hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
Date: Fri, 24 Jan 2025 16:45:31 +0100
Message-ID: <20250124154533.3534250-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We don't need the MemTxAttrs, so let's simply use the simpler function
variant.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 monitor/hmp-cmds-target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 0300faa8a2..0d2e9dce69 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -301,7 +301,6 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
     target_ulong addr = qdict_get_int(qdict, "addr");
-    MemTxAttrs attrs;
     CPUState *cs = mon_get_cpu(mon);
     hwaddr gpa;
 
@@ -310,7 +309,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_page_attrs_debug(cs, addr & TARGET_PAGE_MASK, &attrs);
+    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-- 
2.47.1


