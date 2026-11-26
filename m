Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7E606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=afWICT2d;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+PejtP0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkR-0002Cy-NS; Thu, 26 Nov 2026 10:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbk7-00021d-5k
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjw-0004yD-U4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6O5fEohBDoQWlZ3JfeDq2VAKRPPvQdSix3+opeoQD1s=;
 b=afWICT2dYrTPmROC9SybahfXpZxd4L3KI7snBL4jCzU16wvdv39vrfePBERA8dh0HPpt/+
 PaJcJdnIZPn8Z1US5iTdnaO/MTNn3TaM4dmxBNapaLM4GziRAFb2hV6O5P2jbCTBcjqMT4
 Fm1BdOCdvBs+PmzZZfIqprFsfsIpt6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-bDhmdlO7PVKDtLQGeaXKWg-1; Thu, 26 Nov 2026 15:50:23 +0000
X-MC-Unique: bDhmdlO7PVKDtLQGeaXKWg-1
X-Mimecast-MFC-AGG-ID: bDhmdlO7PVKDtLQGeaXKWg_1795708222
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4915ba023d4so4517052f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708222; x=1796313022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6O5fEohBDoQWlZ3JfeDq2VAKRPPvQdSix3+opeoQD1s=;
 b=I+PejtP0Qm9v4Th56ISNJ4gtUAvjrlOXCWrKDmssfz0vbXuYp66oXBrc/huxFV8BLO
 vZGVEUDNSMsbaPuD2zuqDG1N/aG604CHUDGOEcKBMV0GiLbKeTanxwNixi1u2c0YBIF5
 3IhkYbpsJBORJamvENFHUjMrfVk4daQbaNNkD50xOUOd1G8wvR48neohrF6ZGQga4WxA
 cINbvmDpfcD6HBDkE94yFQwPb+dr3dwk+AqXAoqyrxaGWJVrwJ5DJIOkREkj8FqJaS74
 eGB86+dRRLoUX1UFPYjXhZTS7qmXG+AqD6symY7b1JLE/wCA/UAVztve8KpAqh6aAVcj
 BjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708222; x=1796313022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6O5fEohBDoQWlZ3JfeDq2VAKRPPvQdSix3+opeoQD1s=;
 b=pHHcSZN98ybQzvokmgUslIIoCnCRZkTFa2qBlHMkWbc0+1fpo4cVeN6CXpjMXFIyPA
 5agXloSzvoUfE8lLnXIyMrON06udas0Fz0YsYrXrIk8Izitmd9yWTIQDdO+Sg1D7FnNa
 T+paOyJRg4m/KGbLJ5scDaoOobIA/AnxlygqbUTjO34Ds67bQ+OGFIhM+/8mA4MupVU8
 L4d6tTSaZs7PFRFsPwxbc1Ht4fzvFzil/v9xT1XqDq3fNfAh19NViQpVOlgjanIOOZa0
 OmwxvrfKEhSqwx8b49yUJuMyRd4Sg5f2OnuJczjYoHQ1w8gTl5WVBY7mmiXiWsqB5+fi
 E6/w==
X-Gm-Message-State: APuU4Z/BEeLaDpzcYJjqSacom2Q6BFRKo/QCUJYC1lHJv1GtYYUN4Hyf
 /0FSMOcag2aIe8dRW7SRg6wh5T2JxosJL1JT4rgBkuh0rLDaKxDmEATFMbaZV7gCoN9s82npJmn
 EaAaaTUfQlSLjk8f9zbtY543RyMg3Gcg1hGmaWhOSOJZabQvGDPFHi1kTSzYAXMGOalZ61VaQ6n
 GvYS9cbbg3NxYx8f+121wEwGWcdSYGjuYQEy2j92s4Gpn0
X-Gm-Gg: AZFdTZcP39qcqhpPCwrGYixj9j+ZtVuG8SBFAxvt+4MvBQceVEd3gD/1l2DT7VwL7U2
 /RFPUDVNv7ajDI7pIn4fknkQxtg1Pe+O3DTDpEwN3wY5uTT9GP0ZgoUw7HjJzOcers8A3JrEJ59
 Rm1wG1jaO0DpYLnMXEBkQvIj/T/n7nQh+9lj0dS5Prf48sKW3VLM5Il1GLBl9FmkB28CW1k2wKr
 2TnaGm3QwKDU6xb7nMe5eqpkFshV1VQbaJbqa7Cde7Ls193EXwM4aj9oNnwZKn5y0yRS+6QC03r
 zet17b8AvonW8KsqE0IebffGRrFVlNGpCBDrIhE4X4oUI/+F1VP28bYcN7XKmW3dyVIFyQHGvHG
 ghktK7X4GtLP9sKzlJJ/JAMvE4sQ+J5KzSnaBkMsn/rFj4Ikn0Ws45LzjNesynMVw1II=
X-Received: by 2002:adf:e014:0:20b0:4a6:b87:d77f with SMTP id
 ffacd0b85a97d-4abb0f3b5a5mr32417349f8f.12.1795708222253; 
 Thu, 26 Nov 2026 07:50:22 -0800 (PST)
X-Received: by 2002:adf:e014:0:20b0:4a6:b87:d77f with SMTP id
 ffacd0b85a97d-4abb0f3b5a5mr32417306f8f.12.1795708221690; 
 Thu, 26 Nov 2026 07:50:21 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f1b2sm38326377f8f.25.2026.11.26.07.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:21 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 6/6] hw/usb/dev-mtp: Fix assert failures in
 usb_mtp_write_metadata()
Date: Thu, 26 Nov 2026 16:49:58 +0100
Message-ID: <20261126154959.81769-7-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126154959.81769-1-tcalifano@redhat.com>
References: <20261126154959.81769-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

usb_mtp_write_metadata() can be reached with s->write_pending set, after
two successive SendObjectInfo commands, or with a NULL parent object.
Those states hit the existing assertions and abort QEMU.

Return RES_INVALID_OBJECTINFO before the assertions.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7d4dfdf3a3..109ad9352c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1722,7 +1722,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     uint32_t next_handle = s->next_handle;
     size_t filename_chars;
 
-    if (d->length <= offsetof(ObjectInfo, filename)) {
+    if (d->length <= offsetof(ObjectInfo, filename) || s->write_pending || !p) {
         usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                              0, 0, 0, 0);
         return;
@@ -1737,9 +1737,6 @@ static void usb_mtp_write_metadata(MTPState *s)
      */
     filename_chars /= 2;
 
-    assert(!s->write_pending);
-    assert(p != NULL);
-
     filename = utf16_to_str(MIN(dataset->length, filename_chars),
                             dataset->filename);
 
-- 
2.56.1


