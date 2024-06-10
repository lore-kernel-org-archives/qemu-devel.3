Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF79C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGicG-0007C0-JN; Mon, 10 Jun 2024 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGicE-000766-Dq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGicC-0001VS-O3
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgELMkc1bS7VwzQKP/T+wBa1GSPK4TqZBA1l61ePfzM=;
 b=g93ZDuDEre6C99c5VsiFnkd6RHEFC0Q2qkD5I/KY7XRSVE9uIocqoxc4MrK8iGfMVnFhNu
 wg+lrr7DSmHGJ+5hlhw/oDXDmptNgbJgLHetwOnmbHtJVDujkDveHq5VfVwI5uirI3F00P
 knbUNtvC4smE2DQEi5lTLvFNy4X/3rM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-iGu4kgfPMj6UIrMRIlvRKA-1; Mon,
 10 Jun 2024 13:15:25 -0400
X-MC-Unique: iGu4kgfPMj6UIrMRIlvRKA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BBDF1954B25; Mon, 10 Jun 2024 17:15:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 966A71956048; Mon, 10 Jun 2024 17:14:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alex Williamson <alex.williamson@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PULL 4/6] hw/usb: Remove newline character in trace events
Date: Mon, 10 Jun 2024 13:13:13 -0400
Message-ID: <20240610171315.346143-5-stefanha@redhat.com>
In-Reply-To: <20240610171315.346143-1-stefanha@redhat.com>
References: <20240610171315.346143-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Trace events aren't designed to be multi-lines.
Remove the newline characters.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240606103943.79116-4-philmd@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/usb/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index fd7b90d70c..46732717a9 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -15,7 +15,7 @@ usb_ohci_exit(const char *s) "%s"
 
 # hcd-ohci.c
 usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at 0x%x"
-usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head 0x%.8x tailp 0x%.8x\n0x%.8x 0x%.8x 0x%.8x 0x%.8x\nframe_number 0x%.8x starting_frame 0x%.8x\nframe_count  0x%.8x relative %d"
+usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head 0x%.8x tailp 0x%.8x, flags 0x%.8x bp 0x%.8x next 0x%.8x be 0x%.8x, frame_number 0x%.8x starting_frame 0x%.8x, frame_count 0x%.8x relative %d"
 usb_ohci_iso_td_head_offset(uint32_t o0, uint32_t o1, uint32_t o2, uint32_t o3, uint32_t o4, uint32_t o5, uint32_t o6, uint32_t o7) "0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x"
 usb_ohci_iso_td_relative_frame_number_neg(int rel) "ISO_TD R=%d < 0"
 usb_ohci_iso_td_relative_frame_number_big(int rel, int count) "ISO_TD R=%d > FC=%d"
@@ -23,7 +23,7 @@ usb_ohci_iso_td_bad_direction(int dir) "Bad direction %d"
 usb_ohci_iso_td_bad_bp_be(uint32_t bp, uint32_t be) "ISO_TD bp 0x%.8x be 0x%.8x"
 usb_ohci_iso_td_bad_cc_not_accessed(uint32_t start, uint32_t next) "ISO_TD cc != not accessed 0x%.8x 0x%.8x"
 usb_ohci_iso_td_bad_cc_overrun(uint32_t start, uint32_t next) "ISO_TD start_offset=0x%.8x > next_offset=0x%.8x"
-usb_ohci_iso_td_so(uint32_t so, uint32_t eo, uint32_t s, uint32_t e, const char *str, ssize_t len, int ret) "0x%.8x eo 0x%.8x\nsa 0x%.8x ea 0x%.8x\ndir %s len %zu ret %d"
+usb_ohci_iso_td_so(uint32_t so, uint32_t eo, uint32_t s, uint32_t e, const char *str, ssize_t len, int ret) "0x%.8x eo 0x%.8x sa 0x%.8x ea 0x%.8x dir %s len %zu ret %d"
 usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
@@ -55,7 +55,7 @@ usb_ohci_td_pkt_full(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_too_many_pending(int ep) "ep=%d"
 usb_ohci_td_packet_status(int status) "status=%d"
 usb_ohci_ed_read_error(uint32_t addr) "ED read error at 0x%x"
-usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u\n  head=0x%.8x tailp=0x%.8x next=0x%.8x"
+usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u head=0x%.8x tailp=0x%.8x next=0x%.8x"
 usb_ohci_ed_pkt_flags(uint32_t fa, uint32_t en, uint32_t d, int s, int k, int f, uint32_t mps) "fa=%u en=%u d=%u s=%u k=%u f=%u mps=%u"
 usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at 0x%x"
 usb_ohci_mem_read(uint32_t size, const char *name, uint32_t addr, uint32_t offs, uint32_t val) "%d %s 0x%x %d -> 0x%x"
-- 
2.45.1


