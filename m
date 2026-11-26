Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IumMbwTW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gwy3CJ+3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkG-00024k-Sg; Thu, 26 Nov 2026 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbk2-00021P-OR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjq-0004j0-OD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9k45gfLOYX8i55V+f9QcKvELy2NTMP101TyPF2+nDA=;
 b=IumMbwTWqPMpPNaqjpAWj5q+NMjj6l+exkNpn//3vc2liVbioxy8AAFfSeAfjJpUFQjXP4
 puptj5DTPoX2Ore5RwS1RHt0//J9UmMU5YB4ISe8Fe9WKzLs7XWJvQK7mPuG7EC8xlMajh
 Jg7x1pz4atNrw1p0fAqirJCeCiTkdOQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-8UcS_k3ONbaI9HLwHibCrA-1; Thu, 26 Nov 2026 15:50:20 +0000
X-MC-Unique: 8UcS_k3ONbaI9HLwHibCrA-1
X-Mimecast-MFC-AGG-ID: 8UcS_k3ONbaI9HLwHibCrA_1795708219
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bba856092dso13680015e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708219; x=1796313019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h9k45gfLOYX8i55V+f9QcKvELy2NTMP101TyPF2+nDA=;
 b=gwy3CJ+3LGbTTKexI/CgWen7reprI+u3BElKKycehfzbXyLN3v/Zdl8+CQepr5z9cG
 oPDvtmS/wbBG8/7pK4xabvq/mhJMEawZO1OxluvLXdoLOzp7C6H8g4zDk1B5fQ3b1v33
 BfqFOWhHnycZAsxtI/uPKe1iGf2iFWUa4TmCGtcPB6vVO7soW9gLu/TLz1VfXYMUVv4Y
 fx5dzenn3bsY/0M4m+o5wOc/2IX1324Db6bZd/zo3DSXe6+Ge2Zyl2z5i6vB7tIxL0Y0
 zd7nnhnvylTby2112QygmQnKmt1KKwpU0vnSNdtahKyk1if0E9D8xvaOshPbcXB5gzAq
 o8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708219; x=1796313019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h9k45gfLOYX8i55V+f9QcKvELy2NTMP101TyPF2+nDA=;
 b=eHPvtj6o2YXjX2bhEZPNeIfC/j6QunbwRaI+SSI77kaNSPC/nH/33rIkNJht9+tPp0
 d1fb217yjGiF4Hd/kgjZGowsYzsbtuy/pSCnuF2jb1VZmHnAvsBINCnVtokMgsdhaBXg
 LBbqo/HK62rTr3BMVwhBfHlahTbYpektW01+baCE7ioigXK0z0ZYus7OP6eM4RYUqFo5
 H7ExeDHzVaYFrqB64nXbobej8RhaANNGiCdz7LvHVXnKsQzU/rWzosorEp97z7p0DX6Z
 rdDTeBG1bUR5hKxPdpUsGBS49zX795nTGEwhKcX1CzAZapxLlyoYMlSRR942VbADqcYq
 nyeg==
X-Gm-Message-State: APuU4Z/I6GpKloilCP0u7Fcxufm1H6aWxf8LxfwqYmDE1BP3qWHYZb6H
 qDgqL89b2R3AIuipIfI0sQbAmUJ9+h1urVsfa1KE0OUs2VppKdqSCS/h4p+HPEhKcbh4VjMUzrF
 iRHjhShuk1u67Z1y+1KD6mFDqRl329jYQlFtXWUSMTvAMQzGMCgD+nBj/ImBKI0RPnIDWT+MEpb
 6C4enk7/a2UzthaO3Jka3jj6PAQ6h/t67Nl9iopQtAUWqw
X-Gm-Gg: AZFdTZdnTL0b/OWlNNVmGFKosXIsTsnORryunAt1kYhdBCAo0k7e+OmWJ7fwU0mo0yp
 SNGDyFBTskQ+9RAgQgsYmu4RfgjYxwqHv6wpDlYnG5LN086VWxRQO29tsXffsYD44ORQD86H2ii
 O1L7q/VrEw9uiCMxPZ+xl9HYARg+ifBKSwJrkGEynVo1ixaaUpdXEqRNS5VHHwXVzyu03MowvGU
 MPLqZVCh2uQGkRSuoVTXLbuii9mdiV0cnkoYwXa79KEQhF4VBl1F4sgvFviR29vdNOBSEDNL4TP
 PU0yUAYjsnG3tK7Zx5ygudcBd+cukA3V94pWw+JLF7ErSQP1j/5ncc5DaZvbo9+5p83pRMKb0Bt
 u5uTkopvcYItdDFe53sSgXIObQGTomcTRfLfwh9ciqw2jEIppLzgc3wFg29V3tl/pE5w=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb8880ef6amr463293995e9.14.1795708218837; 
 Thu, 26 Nov 2026 07:50:18 -0800 (PST)
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb8880ef6amr463293255e9.14.1795708218151; 
 Thu, 26 Nov 2026 07:50:18 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm565696125e9.12.2026.11.26.07.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:17 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 5/6] hw/usb/dev-mtp: Zero-initialize command and params in
 handle_data
Date: Thu, 26 Nov 2026 16:49:57 +0100
Message-ID: <20261126154959.81769-6-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126154959.81769-1-tcalifano@redhat.com>
References: <20261126154959.81769-1-tcalifano@redhat.com>
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
index e44e2efe8e..7d4dfdf3a3 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1891,9 +1891,9 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
2.56.1


