Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E88606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QF5Vo0nq;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MPRmfjAs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYwr-0002I7-PV; Thu, 12 Nov 2026 12:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwh-0001y6-0B
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYwf-0001rZ-IL
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpiW2UTc1JtJwgcDG5X7h4CwVDLMVqvoRhnEMP828+c=;
 b=QF5Vo0nqsdZyDfL3MU2qyjSPVrqlEnbBfFJ+nDO2PAxwLvLUkZA8j6niRW3bLF5rbr1ejn
 bnYYv4nvEwxqoxn3fUaiS5SXlm7vnwRZwIU/c2SwNJL8jz40XaqUzfHAKSHV7sNcqufxTm
 XnznoITg6QcIR/esnopLpSctq3+6zf8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-L42N48lLN7WUNrt9syESIQ-1; Thu, 12 Nov 2026 12:50:43 -0500
X-MC-Unique: L42N48lLN7WUNrt9syESIQ-1
X-Mimecast-MFC-AGG-ID: L42N48lLN7WUNrt9syESIQ_1794505842
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-89fb6a45c48so67963b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505842; x=1795110642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lpiW2UTc1JtJwgcDG5X7h4CwVDLMVqvoRhnEMP828+c=;
 b=MPRmfjAsmlD7SyjbLPolART/MkkiuNQe7TefV1/R0CR+bHMGDtR9oi+9eV+8Gw4E+C
 xQxwTPO7jJ4u2hI5WweqVhV4qRb9Fwu0UuG691YwnqBfZej8vYVw69vT6piy8IUKnAZh
 rlM1aJ2iksHbFvIFcQjUEgeFRXrztIomDMqpnBAO3tg2gAD9W+cjEoHD3d5TqNmUakPR
 xWCXF5oFzks6esScbK0+eUAwFTj5gYRHjxqpWekYd82/CWCAdnHaDVPEe5wPFTLi2Psu
 OMbrLoGnr3fkbz0flNh8M4AoMZh8PLinRmgYk05nmtbFnUTzXi3wVv+66O2sJy+RKwKy
 7gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505842; x=1795110642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lpiW2UTc1JtJwgcDG5X7h4CwVDLMVqvoRhnEMP828+c=;
 b=0Y3AvFDLUaIoObriWzdvnmARCPoTmbFqE2AehY3t8mRdg/C/gDwfAvKo13wDB5T2tf
 LWG96WMRMzx4fuMC5zLR+2zSDdNEyJfjxwuXJBksLo7/We+Nq5UHJUHJ11K7FPB+ObOA
 /c5z0/DUxGX8ZqBqXioSTxBJRJMLczxqY2RZPg4axnc+LAf9kqYmXoLS8ZOGXOp8lXsH
 O0XUKQBQHBjoaEqzeMIrkzYOaoZSeka7R37HzQDgPbpO2nZnMlGQN7AxE15k1+SkZi0X
 DYqfCxUmuZ4wYWqlBo5d58Fmp8X1kD4f2Ul7spkTPpnQzuXooQCqj//tc5Ic3VKb8eW2
 2VfA==
X-Gm-Message-State: APuU4Z+QRSl7WRZBfzOh9jtxQHPq/UNbKPkWz/lCpZ5Tm9M/N9D1nk5t
 YH+SItNpXYML3qkEZaios7U8HfmHxlZOZ5fTP4yo9zQEhVYYNdEz2kLs9XOc/bYscu+MQu2N8zg
 R43gt1xbbIF/8HFj8DD8IpJ8lJi8OJTHhkzBWBk/FsQfBXCR3eXp589RaEJ7OkICU+1mnvYSpbf
 2BFjRF2HpssQx/YU7UcHV+1nSJHLVeFtEhLj6RRqQilg==
X-Gm-Gg: AYBFou23YQM2HQyPL0vE3oEBULjcUyD6ebH+3HUqd6gZGaDOz59Dq/sU5/PCBrpyMj1
 PVPb1RjwDZw8ROCadfwk+vx9HzOm9bnRWTLv/O+Za87OEIk1q3tAnsSOc4qGyA2FAFyR2hCd8TB
 7nK3+w1Q/m7I+QCUO+3loQ8Yy0lw4iz6CACKJxy0aiGQgkAhARPJQbpY3drCLfZ/EwZNQhmoBjT
 SLhc5u8adL+pdOm1lSXy55ynl+doIA1gGtNy8kgTwxy4OcSqI9KHyg6DX2klrvQr7i/xaw0v+i2
 nZZsrH5FMOH86UCL+FX/DFM9rANPUI9Z7G80rLug6UC56RpQZ1TPH/nJRUFi4Eo8pSwVdCvmApo
 sWeBT+DQOHhN3RUzK4ztPCnqcsGDhUf75p32jdmYfstzQiw==
X-Received: by 2002:a05:6300:6684:b0:3eb:abb7:f92c with SMTP id
 adf61e73a8af0-3f2fd69cff4mr6584560637.22.1794505842211; 
 Thu, 12 Nov 2026 09:50:42 -0800 (PST)
X-Received: by 2002:a05:6300:6684:b0:3eb:abb7:f92c with SMTP id
 adf61e73a8af0-3f2fd69cff4mr6584539637.22.1794505841659; 
 Thu, 12 Nov 2026 09:50:41 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc186fc81sm88873a12.8.2026.11.12.09.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:50:40 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 7/9] hw/usb/dev-mtp: Zero-initialize command and params in
 handle_data
Date: Thu, 12 Nov 2026 18:49:04 +0100
Message-ID: <20261112174907.158825-8-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a command container carries fewer than 5 parameters,
usb_mtp_handle_data() passes the unset entries of params[] and fields of
cmd to usb_mtp_command() uninitialized.

Zero-initialize both.

Cc: qemu-stable@nongnu.org
Fixes: 840a178c94db ("usb: mtp filesharing")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 82de3ee401..f6f9bf52ed 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1890,9 +1890,9 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
 static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
 {
     MTPState *s = USB_MTP(dev);
-    MTPControl cmd;
+    MTPControl cmd = { 0 };
     mtp_container container;
-    uint32_t params[5];
+    uint32_t params[5] = { 0 };
     uint16_t container_type;
     int i, rc;
 
-- 
2.56.0


