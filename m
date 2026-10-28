Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE6606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OuhV02KZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GNCM08IJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Fx-0007mR-V9; Wed, 28 Oct 2026 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FZ-00074n-Hp
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FW-0003ns-DR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
 b=OuhV02KZJ8/uq62vS9RhyYAF4EYLkVqkZDQ2gwrQ3Xl8td2cZwadClt2FTd5xiDXosycGh
 JTbw1IW+ufBS6TeKYsCIrPpk4YwmSMRgb+XbCLf7qtBBHnm3hkXUdDd9nNGmvXLP0N+g/+
 C1qH58bVTRGj/Gp4XA4SGHrvYKrZKg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-OHg9gdj2MH2rZjfbXcWhAQ-1; Wed, 28 Oct 2026 13:15:40 -0400
X-MC-Unique: OHg9gdj2MH2rZjfbXcWhAQ-1
X-Mimecast-MFC-AGG-ID: OHg9gdj2MH2rZjfbXcWhAQ_1793207739
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a9d51dc486so4496905e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207739; x=1793812539; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
 b=GNCM08IJmB5jc5T/8FcOX+Yw0z7jz6v9Kn5q+YxqbQjKN/ZrA2COumMChyo0tcKMjb
 Pr0cMB5AkyuFZJvXMsBNlal/aIJFwXvFIIrLYTc/AKvviOG0EEwTjorQ4VR2iEM6FD3a
 cBw234RAIPaT5O+KXprXjFF1reqSbgx5k4gGnjVLk9rTvvNUW3ivzXE7gQXVxWLzOnnV
 3xHT7Aal1faq7Ud1ZL+1Y9sHpw56MibMqC1HXl5MMY6vwpXdbVFXlkGQlyFZiJ8UiEfh
 c0YKqlDDrsPr6cTNrjhFEaY34sj1KDrVhkklRANISzpVo5CxfSPyYQiWXbKZcVrsrdGZ
 oTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207739; x=1793812539;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hfdjEyoG61tuakbg4/yBZZhWaC5HdS0ABbWHQxKkv70=;
 b=RXjhqTylR48y2wXhV1mDtayv0KOTI+3SFpX2nYdxV3aI5tnwVIwN5n8jXcg4KkpScY
 mVT+4Nb3Rd6VYV6JVx/qIJWTi+IUKdFtgW9wsMHDXa3U9o7HCH5naYa1BdxZXIHoesqb
 IpebUDbHqT/+tU3wn8Emko9+tiL9RdjOl7W7gX9orGmDWWKjOf+CHHR5cThxaEI5bj40
 urQw7PGswxbJZeZuJXdTmbxiny8CxJkqBvrP/u44jYyOumy9tMWCpOtXunfJ3mAgr4p2
 YimvvqrN5lml+arQsRKBuJ9zoM/GUDGjkP3jFcS92H48Zqj+zkoHNnwQZnFCGzbRD0mt
 SU7A==
X-Gm-Message-State: AFq9FYJPCcPXAaUk6D6zgKbvHAyvhVQx5ualFt07EBHvYaw3tfXfXL2u
 CrQLTzSs9x05L/tBjS1K9Hfg/GNFrLwBy6Ew11lVuOtoB6kU4rBNF+8HBCeKPl7F4LyP9sjuyfW
 Nsr+GBSYXqIjImBbMP63OqoaAohKY8F/BKayWEu4Pf6mVxhKC4wuwJgCERYEipCLuuHeGJlNHJf
 S4+iaNOoOORKM1pwUTYvV9PwmJt13PcOifIg==
X-Gm-Gg: AYBFou15vUdBpyxaCN21ThQTw8/UujqXwwqWnyC7FRXLyvl8RsCNH9i2NYE5Ii88HdZ
 vXSqUAmxG2lwJjVE1TMjHJxA+p8Jlo7T9cU0PLyK4fTTvONZHjnpSVN4m7L5AHJdRVm/P0gjMrQ
 dpuJA1fdv8vmaX/+i9cMUrPB9CIBWtq/PePoU1/LM3CS8ezm1IP0dP7I8lL8c+KhN1Ppg81RJlx
 NjSSQUKrDgalwMyBjq5sOAUMDbaYL3qXOOS7ZVzJJbfbmQYgo7sRzwPmfBl9AjhlCZ6dY54eliH
 TlATv8Bg3LRqARzBJlJNsKMZ5rlqxj8wTm8A2wiGK5bcSewwPasJZ+14iPEVoqe9a70HA0Pye7j
 Wdgv0oxW7VIgo14Q6vfFjZ2zeQcGqUIJp2/6XL0rT
X-Received: by 2002:a05:600c:34ce:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4aa871e8bf8mr4457705e9.8.1793207738965; 
 Wed, 28 Oct 2026 10:15:38 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4aa871e8bf8mr4456515e9.8.1793207738373; 
 Wed, 28 Oct 2026 10:15:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f5311bdsm72122205e9.5.2026.10.28.10.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 37/78] hw/cxl: discard in-flight sanitize state on mailbox
 teardown
Message-ID: <1f5103eb7b2a24e8b5340052ff860ce17dbe59e8.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a Media Operations sanitize is
in progress when the device is reset, the background timer is cancelled
and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would be leaked.

Free it from cxl_destroy_mailbox_t3(): the timer that advances the
operation lives in the CCI torn down there, so the operation can never
complete once the mailbox is gone; preserving the heap state has no
benefit and would leak it the next time media_op_sanitize is assigned.
Routing the discard through the mailbox teardown also covers device
unrealize, where ct3_exit() previously leaked an in-flight sanitize.

The completion path in __do_sanitize() frees the same state; factor the
free into a cxl_discard_media_op_sanitize() helper used by both places,
so the whole media_op_sanitize lifecycle now stays within
cxl-mailbox-utils.c.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-6-junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc00fec9f8..cbd6ebf9fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2636,6 +2636,12 @@ static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
     return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
 }
 
+static void cxl_discard_media_op_sanitize(CXLType3Dev *ct3d)
+{
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitize(CXLType3Dev *ct3d)
 {
@@ -2653,8 +2659,7 @@ static void __do_sanitize(CXLType3Dev *ct3d)
         }
     }
 exit:
-    g_free(ct3d->media_op_sanitize);
-    ct3d->media_op_sanitize = NULL;
+    cxl_discard_media_op_sanitize(ct3d);
     return;
 }
 
@@ -4848,6 +4853,12 @@ void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
     if (ct3d->cci.initialized) {
         cxl_destroy_cci(&ct3d->cci);
     }
+    /*
+     * An in-flight Media Operations sanitize is only advanced by this CCI's
+     * background timer; with the CCI gone the operation can never complete,
+     * so its state would otherwise be leaked (CXL r4.0 Section 8.2.9.4).
+     */
+    cxl_discard_media_op_sanitize(ct3d);
 }
 
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
-- 
MST


