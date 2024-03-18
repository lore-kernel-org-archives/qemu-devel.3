Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A01EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeR-00075C-FB; Mon, 18 Mar 2024 12:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeG-00071Z-5u
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeE-0004WR-KR
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0DcxDO3m2vtxwdKzv4jUJfjIm4ktk+IdMc2OXd8j08=;
 b=YeY9gmcDOpkAOvfsnGZKIQJbVdagILqDUUvmIM6E03/ZSGOLmkgKLyRvhgXA4dVbuy/t8Q
 qkaP1QKI2AGMxbNAw3A9rrM3pRsmalGSG00zKs3wNgUbkAkOWhH+QzBRUmL0geHrpQAYu4
 FzDngIIp/bTtk3RUKQtHXgY2Qr4A7Ag=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-57thVi9VNRWlkUiW6QaDGQ-1; Mon, 18 Mar 2024 12:15:35 -0400
X-MC-Unique: 57thVi9VNRWlkUiW6QaDGQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513e0c5f399so1755644e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778533; x=1711383333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0DcxDO3m2vtxwdKzv4jUJfjIm4ktk+IdMc2OXd8j08=;
 b=JsCEe6IAawzAbchsQvucIGZd2O1mKJw3dlowsl2tg8tmynvmBwI6ZrCI9JZU6czwcz
 N5S0GxR4LaY1cszYsFFTJwufr+s9u0odquUAj+qHppE35Sp/HtIguAq5pPLnkQYU+a2F
 0mauuuY3hQWo+aytdzxO7C+sQFsJavpyIYlKGu+ZGTXqvs7GZdL9ltihy9Snq+c1YiBB
 2ayiD54fMSucoBLnrDcFVWeqCWvD91U16Nb1OFyc4hVAuw3OWwzBu1x/g+arNIKZj5F6
 6DoXDCUom+wEtFV0glrJk2hdBsczwEBr6kT22weY59S6UfYqx2bYLybW8mLQnrpaZ8Sm
 pq9Q==
X-Gm-Message-State: AOJu0Yw/Qb83fUZuaMROvLR2Mdrj1efyy8prdDiLSe83O5NCnH7QcPyQ
 oRPNckA5o1L/B+9V3ntGkdgnSq9WBZBs9NfetXIuaIsrC8desgCYeh9XuV7qNGVhDf+uWQULhMb
 X9SiJg64QHxyXKyI8RyWzbNiE0VYRloqGlLzSpdaE82fi9C/04bhwhOtx1lwYLcmMl4Ry2hRJl4
 LH9cwA/Ys7ZByEImWLEHDs4tvNxCav7A==
X-Received: by 2002:ac2:5487:0:b0:513:e668:cbac with SMTP id
 t7-20020ac25487000000b00513e668cbacmr3300765lfk.55.1710778533604; 
 Mon, 18 Mar 2024 09:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0lSbU5WDnfMW2kP/TJNsjAf4zDZxZfMByDk3WWlJWs8sZIzqLer+xs8729OiLF7NJnXcADQ==
X-Received: by 2002:ac2:5487:0:b0:513:e668:cbac with SMTP id
 t7-20020ac25487000000b00513e668cbacmr3300734lfk.55.1710778532981; 
 Mon, 18 Mar 2024 09:15:32 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c191100b00414612e755fsm605975wmq.8.2024.03.18.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:32 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Felix Wu <flwu@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 01/24] SMBIOS: fix long lines
Message-ID: <fdf1c98063eec7f7fb4dd019391739eaae1e165f.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Break up long lines to fit under 80/90 char limit.

Fixes: 04f143d828 ("Implement SMBIOS type 9 v2.6")
Fixes: 735eee07d1 ("Implement base of SMBIOS type 9 descriptor.")
Cc: "Felix Wu" <flwu@google.com>
Cc: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index e3d5d8f2e2..949c2d74a1 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1592,12 +1592,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             t = g_new0(struct type9_instance, 1);
             save_opt(&t->slot_designation, opts, "slot_designation");
             t->slot_type = qemu_opt_get_number(opts, "slot_type", 0);
-            t->slot_data_bus_width = qemu_opt_get_number(opts, "slot_data_bus_width", 0);
+            t->slot_data_bus_width =
+                qemu_opt_get_number(opts, "slot_data_bus_width", 0);
             t->current_usage = qemu_opt_get_number(opts, "current_usage", 0);
             t->slot_length = qemu_opt_get_number(opts, "slot_length", 0);
             t->slot_id = qemu_opt_get_number(opts, "slot_id", 0);
-            t->slot_characteristics1 = qemu_opt_get_number(opts, "slot_characteristics1", 0);
-            t->slot_characteristics2 = qemu_opt_get_number(opts, "slot_characteristics2", 0);
+            t->slot_characteristics1 =
+                qemu_opt_get_number(opts, "slot_characteristics1", 0);
+            t->slot_characteristics2 =
+                qemu_opt_get_number(opts, "slot_characteristics2", 0);
             save_opt(&t->pcidev, opts, "pcidev");
             QTAILQ_INSERT_TAIL(&type9, t, next);
             return;
-- 
MST


