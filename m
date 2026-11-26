Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B073606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPBwLHvm;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZKGxOKCu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkG-00024e-TO; Thu, 26 Nov 2026 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjj-0001yW-2c
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjg-0003q3-QJ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUjwwe2b8UftgtquKo9ruStc2cd0EKjmb5KrkR7l1hI=;
 b=RPBwLHvmkGYnv6rxxs3cEnHSHx8z6MzcHCiVSa4z0p9n2LqDWhgAQy2wEzJJCvNdp2VYnS
 DKE1+ExXq3Y4bYLwfGe4/z8iouO3o/uUNsV9eMWQO/wRxiqzIsnn8Q/X1s1QQOVc+fYPp2
 T+UwH8Z2D71iIMwYAt7hCXp9BS6aHDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-nUH7HbHxOHK_rGGyKTAWtw-1; Thu, 26 Nov 2026 15:50:09 +0000
X-MC-Unique: nUH7HbHxOHK_rGGyKTAWtw-1
X-Mimecast-MFC-AGG-ID: nUH7HbHxOHK_rGGyKTAWtw_1795708208
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4b9fde3044dso51345875e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708208; x=1796313008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gUjwwe2b8UftgtquKo9ruStc2cd0EKjmb5KrkR7l1hI=;
 b=ZKGxOKCuXvwJicNJonXNvrfSvBbVbw/GDCC4/GTpv6ZeBaOa5zzd6TFm4GeFH5O8ii
 7GZ6gXfHFgNGRoXurOur310Dwh5cuJLmmWuxTNet5LjLkgrnuTmlAbgmdvaJwLHEgzwy
 L7tfJNNZ+k6HagKIVyFkvw9/o5l+z1+cv0atk3p5ymsh697WWVFl3bZZMvDPHoKCsQOa
 iBhOxV7dBEKnYV95zdI/+Q787ZTFPt5yCsrRZ/8EGDVHE5l8Oe8+SExZzXz4SndQvv5c
 vt3e26W8w9LyEZc0OpSLx3FtQSpCTV9qrbmpXKs0nl9E6hyWEJMwTau/bIjGJ459NfNp
 jZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708208; x=1796313008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gUjwwe2b8UftgtquKo9ruStc2cd0EKjmb5KrkR7l1hI=;
 b=fSVt1mjuBOk6PJHaxY3UWCo/fEflf0aZUCQvcoUiCXK2TOLVxiVR3uDaYJn2CXHPuA
 koWcsge23d9cQLyzg+fvbaH9qdOB4MlsGLTi8jCq3i2Q74Jw1Rh1OfIpIMXpVybtX6lV
 xGBR3AlGnSxOTvH79GGTEWl2of4l/H9FuGPlm0MItokm7mQb94mk+ForrOL9JPUpMhbc
 H93ZsCSL/Wnhr/FaIGfD3tV88jAiQVokXf1PS4ei8IpCgG7t9wmDekYqkzfOn0zzWA4M
 XmLJZVUX61+OWeImOOqrDfYkDdn52g6z5GqWLnXqHDCwOyIiEWlGTIEQkunjtZ907W6x
 Mihg==
X-Gm-Message-State: APuU4Z8DUPsfxXI9ZON1uO+iFMqG2RohH0SRcLbqKZdJtHax115fK8T8
 fntm7GPgFyDgpwccxId+OvymHjW2Suqv+MPNO7mODEjH+uvi9XXpgnpiRV7/Ckkj5NwVHJZpqJl
 dOV33OhF6n3UpFR/T4EHpdb0iKLTpWRrs4+izzGcP4m7AHnVXBBiWiOlTblKsayE9Ovb6n3mCJM
 jc149VYOB89oab4ahkCnq5nr9Cf/0XRDbR2VjE1ExNcSfL
X-Gm-Gg: AZFdTZfXvkPbbjPfK5WA+JoXFL0hFVqDzSLWIfy8EPeQboI29ST2u5gsr8NY7OJklLX
 pJdlj84IKTc6eh5yv/DBieFEqNQYa5+M0nIGyOhsMBouGyRJVGraDf9hPCVsE3C4yAJ5Uv2X7SM
 C10TXnAW6bbtyOo/woL1kpp/fffNUgK2QLJF8mR+XDvfAH1biU5+U9Jy5EiOta4P6IvWUMUVjU4
 IcVWNRJ+r55DRDFXosbloyJh80bq74A6l/oKtMqGgQqbQiBmgHo17QR+b7Cs2riTutk1PeiKNz9
 SbQzjXYsfuTA8DCypph3cnF0irm8hUIVgVx1G+MHZfsy/c5fCAZZYlLIAztbSIsLNKT+KIYc6ey
 xm3bObdVpb6b6ZIXfbSiDylYd+sCXsyU7T8HjKaRsTNZ8PklWKkFfMvA2Ftux40ggTdE=
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id
 5b1f17b1804b1-4bb88934652mr413265255e9.27.1795708208231; 
 Thu, 26 Nov 2026 07:50:08 -0800 (PST)
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id
 5b1f17b1804b1-4bb88934652mr413264635e9.27.1795708207663; 
 Thu, 26 Nov 2026 07:50:07 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm718339785e9.11.2026.11.26.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:07 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/6] hw/usb/dev-mtp: Handle invalid characters in
 utf16_to_str()
Date: Thu, 26 Nov 2026 16:49:54 +0100
Message-ID: <20261126154959.81769-3-tcalifano@redhat.com>
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

wcstombs(NULL, wstr, 0) returns (size_t)-1 when the string contains a
character that cannot be converted. Because the return value was not
checked, dlen + 1 wrapped around to 0, causing g_malloc(0) to return
NULL and usb_mtp_write_metadata() to dereference it in strchr().

Use g_utf16_to_utf8() instead, which returns NULL on conversion failure
(allowing usb_mtp_write_metadata() to reject the filename) and properly
handles surrogate pairs.

Cc: qemu-stable@nongnu.org
Fixes: 6de02a13232a ("usb-mtp: fix utf16_to_str")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index f52de4065b..7f3799fe1d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1570,19 +1570,15 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
 
 static char *utf16_to_str(uint8_t len, uint8_t *str16)
 {
-    wchar_t *wstr = g_new0(wchar_t, len + 1);
-    int count, dlen;
+    gunichar2 *wstr = g_new0(gunichar2, len + 1);
+    int count;
     char *dest;
 
     for (count = 0; count < len; count++) {
-        /* FIXME: not working for surrogate pairs */
         wstr[count] = lduw_le_p(str16 + (count * 2));
     }
-    wstr[count] = 0;
 
-    dlen = wcstombs(NULL, wstr, 0) + 1;
-    dest = g_malloc(dlen);
-    wcstombs(dest, wstr, dlen);
+    dest = g_utf16_to_utf8(wstr, len, NULL, NULL, NULL);
     g_free(wstr);
     return dest;
 }
@@ -1747,7 +1743,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     filename = utf16_to_str(MIN(dataset->length, filename_chars),
                             dataset->filename);
 
-    if (strchr(filename, '/')) {
+    if (!filename || strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
                              0, 0, 0, 0);
         g_free(filename);
-- 
2.56.1


