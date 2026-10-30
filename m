Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E8606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eeXEnt8n;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CAIS+Ao5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpwh-00055N-G5; Fri, 30 Oct 2026 12:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpw4-00050h-80
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xMpw2-0002i4-Bk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793379511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1o+PRN4DVqEIfpLV3TncXaeckRaX+lXbN/raetLtEg=;
 b=eeXEnt8n65RmjxGvn/zztPXzZsGbdPTbUttInb4iO+7cXy0Vr+1OJP20OSuaHqlIeCgAyk
 HIHD3N4D/wZfZeBIt0uvmLSZAjS4jebhxK2vwDZ7bIOyZeGs/efk+XQlcuaTM65hquV6BT
 XNgJxSmUfP4IsNs+4YKY5eeA4Y1/+BE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-6eLlmCR6PfWhHMS7g3pGjg-1; Fri, 30 Oct 2026 12:58:28 -0400
X-MC-Unique: 6eLlmCR6PfWhHMS7g3pGjg-1
X-Mimecast-MFC-AGG-ID: 6eLlmCR6PfWhHMS7g3pGjg_1793379508
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so542246f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793379508; x=1793984308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J1o+PRN4DVqEIfpLV3TncXaeckRaX+lXbN/raetLtEg=;
 b=CAIS+Ao5OZtkAL4WxPE9uWNNfyyv0UMl+2rVyc5jsHBEEVkyE1eRK/CgxsrR+RcLJ3
 DTUYn4FlCgfT7DmV49Kgtb5wSq3+Xor2n9r/0opTWU6WfnAOtENFokB70ruTCp5JQ+y+
 K6O4Iu8AwGXofIQJSBdTyTJh9kc+9BCIl8lmAG8shSLQfUpDPaVwyy08OEYEGoOvDAjl
 s/9IBSYDWWI0ZWDu663iq8mgSjF8gxUrol2/sE4XaucTh2d+o4E/s84YZIlHHOS9oYxL
 Glz5QfcB58WIMW2sn6h5ZuR8wojhzkRSg2QV+Kyf4QIxcpUjoCDDM50r0m4IyPfiS2XY
 hOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379508; x=1793984308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J1o+PRN4DVqEIfpLV3TncXaeckRaX+lXbN/raetLtEg=;
 b=xXwWn1Z722VCbYd+8rE6hLA4wWnHDnaPtFrgmyuWfFjmtmCe8/E50bn0/utq/jaK2s
 8iyPDM1NDjixzxytZQECSgOqytsgBSAQPjKvp5FcNuzvjPowFnAOr4W9KrUZGx++DYQ5
 yXJMMtTs5nBcozgwfGN8jeDh4hEDHWpbUV6Qsjqrt+dwgf91+Hy4ZQDPpgDPw1uppYqK
 cIaRgsR8ZnAwCLuP/8Gj/An4SjWZ4Oj4jQ0HpmvDgv20gaF1gntQpkEF9x+tZIF3z+QX
 OXNmFioWxJ76viQn5k0LgORu95+16Mev3f6xtNUNsIy4rjjV8kPoZPRzVOGCbfKovvGM
 NWzw==
X-Gm-Message-State: AFq9FYIqvZpeMQphmcbGRAtfksIqE+4QSCj5XAXHGNiPww6ioA0vYErM
 kGBx4Vo3ko1Kjeq+rGTNV0oVyk88kly8lX5lj2cLZ2A+cJdFxg6yw/OmNNMXNfofauKtBw8wQXM
 6430xpsIkcg8+d0tvePU1wzFovJxg8cuRyhx6iNM1DQqc9xKCvPVj7LExuyYvOz31qhc+qzYI2E
 JdWuIE7RIR64sWpT5MmgvkIYTbiHXtJMF5cuSCz33Acg==
X-Gm-Gg: AYBFou1dAH29Sdhcew/UZwP6epPqpgoHKGkfJHMJuVxlSGebt+VimFFANIoaay1qQhL
 +Qs6A0Reb8r6fFtSXMdFwNL0EPQLV3IY7vskzB7fWEpmBa/VeCXnVazj3bvqDzh2PTIlrPElNhg
 XIgqnM1PV67TEm9S2MgEheB7MlCbvlQJomaojVWUERxB9ezcAwVb6Iq7HWIQTssNweqkl6NiZtW
 2Ph/Nzo6v1MmAVdePxsJJeZjDbxUEymOkhdb85fKJT6ScwpmxBwdFk5XXU5CKObxtiYiorPff67
 vU3tGwtLdsZT/JnAHFr1GcB+8oJD+93qnF/YIJgBEid3zQN3l8yhmY8P+wbg812FMihxYjJSR09
 yGWrFk0UkX9579l1nYfLvmGPZ1WE4Fggcj24sn/32xl12xw==
X-Received: by 2002:a05:6000:2486:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-48e6e4f44f2mr6996338f8f.41.1793379507696; 
 Fri, 30 Oct 2026 09:58:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-48e6e4f44f2mr6996281f8f.41.1793379507124; 
 Fri, 30 Oct 2026 09:58:27 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm4023311f8f.13.2026.10.30.09.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:26 -0700 (PDT)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH 2/2] tests/qtest/usb-hcd-xhci: test a CSW TD queued behind the
 data TD
Date: Fri, 30 Oct 2026 17:58:06 +0100
Message-ID: <20261030165807.79423-3-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030165807.79423-1-tcalifano@redhat.com>
References: <20261030165807.79423-1-tcalifano@redhat.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

Issue a READ(10) to usb-storage with the data TD and the CSW TD on the
bulk IN ring and a single doorbell while the read is still in flight,
and expect the CSW once the data has arrived. Without the usb-storage
fix the CSW transfer stays pending forever.

The TEST UNIT READY in front clears the reset unit attention; without
it the read fails synchronously and never parks a packet. A blkdebug
breakpoint holds the read until both TDs are on the ring, as they are
when a host controller runs a prepared schedule.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 tests/qtest/usb-hcd-xhci-test.c | 89 +++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index add2290bff..2949e5f078 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -58,8 +58,10 @@
 #define CC_SUCCESS              1
 
 #define EP_TYPE_ISOCH_OUT       1
+#define EP_TYPE_BULK_OUT        2
 #define EP_TYPE_CONTROL         4
 #define EP_TYPE_ISOCH_IN        5
+#define EP_TYPE_BULK_IN         6
 #define EP_TYPE_INTR_IN         7
 
 #define XHCI_RING_TRBS          64
@@ -467,6 +469,91 @@ static void test_xhci_isoch_ep_type_mismatch(void)
     xhci_test_end(&x);
 }
 
+/*
+ * usb-storage parks the CSW packet while the SCSI request is in flight and
+ * sends it when the request completes. With the data TD and the CSW TD of
+ * one command on the bulk IN ring and a single doorbell, the CSW packet is
+ * queued behind the async data packet.
+ */
+static void test_xhci_msd_chained_csw(void)
+{
+    /* TEST UNIT READY: clears the reset unit attention */
+    static const uint8_t tur[31] = {
+        'U', 'S', 'B', 'C', 1, 0, 0, 0, 0, 0, 0, 0, 0x00, 0, 6,
+    };
+    /* READ(10), LBA 0, 1 block: 512 bytes IN */
+    static const uint8_t read10[31] = {
+        'U', 'S', 'B', 'C', 2, 0, 0, 0, 0x00, 0x02, 0, 0, 0x80, 0, 10,
+        0x28, 0, 0, 0, 0, 0, 0, 0, 1, 0,
+    };
+    static const uint8_t zeroes[512];
+    uint8_t data[512], csw[13];
+    uint32_t status, control;
+    uint64_t ring_in, ring_out, buf;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-storage")) {
+        return;
+    }
+
+    /*
+     * A blkdebug breakpoint holds the read until both TDs are on the
+     * ring, as they are when a host controller runs a prepared schedule.
+     */
+    xhci_test_start(&x, "-drive if=none,id=stick,format=raw,"
+                        "file.driver=blkdebug,file.image.driver=null-co,"
+                        "file.image.read-zeroes=on "
+                        "-device usb-storage,drive=stick");
+    qtest_qemu_io(x.qts, "stick", "break read_aio A");
+    ring_in = xhci_configure_ep(&x, 3, EP_TYPE_BULK_IN, 0, 512);
+    ring_out = xhci_configure_ep(&x, 4, EP_TYPE_BULK_OUT, 0, 512);
+    buf = xhci_alloc_page(&x);
+
+    qtest_memwrite(x.qts, buf, tur, sizeof(tur));
+    xhci_write_trb(&x, ring_out, buf, sizeof(tur),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 4);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    xhci_write_trb(&x, ring_in, buf + 0x800, sizeof(csw),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+
+    qtest_memwrite(x.qts, buf + 0x40, read10, sizeof(read10));
+    xhci_write_trb(&x, ring_out + 16, buf + 0x40, sizeof(read10),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 4);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+
+    /* data TD and CSW TD, one doorbell, the read still held */
+    xhci_write_trb(&x, ring_in + 16, buf + 0x200, sizeof(data),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_write_trb(&x, ring_in + 32, buf + 0x800, sizeof(csw),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+
+    qtest_qemu_io(x.qts, "stick", "resume A");
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    qtest_memread(x.qts, buf + 0x200, data, sizeof(data));
+    g_assert_cmpmem(data, sizeof(data), zeroes, sizeof(zeroes));
+    qtest_memread(x.qts, buf + 0x800, csw, sizeof(csw));
+    g_assert_cmpmem(csw, 4, "USBS", 4);
+    g_assert_cmpmem(csw + 4, 4, read10 + 4, 4);
+    g_assert_cmpmem(csw + 8, 4, zeroes, 4);
+    g_assert_cmpuint(csw[12], ==, 0);
+
+    xhci_test_end(&x);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -487,6 +574,8 @@ int main(int argc, char **argv)
                    test_xhci_intr_mfindex_32bit);
     qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
                    test_xhci_isoch_ep_type_mismatch);
+    qtest_add_func("/xhci/pci/bulk/msd-chained-csw",
+                   test_xhci_msd_chained_csw);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.56.0


