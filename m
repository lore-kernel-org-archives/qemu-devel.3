Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE82C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXU-0003pe-IB; Thu, 06 Jun 2024 06:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXT-0003pT-F8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:11 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXQ-0002wx-RS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:11 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52b87e8ba1eso1177859e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670406; x=1718275206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyRLulYgG/Y+WEP8f9CDh3lXVGbCyj6c/Ke7SFhRwcw=;
 b=XY+Us5aL2wYF69hKA8tP2b/p4i5heBsfwMLldPpMBj2JU2iGUso9onjDIsNMy3cy1E
 9YvnjeSBe/sxMOOzeo/qJfXE8bDvwU9lRx4H5L8fkP9tJCbdaA600JI+F1YkxRIZODDK
 CJVvFxwOIY/FPsCJDOW7wKoHXO0maSqtJIq77K+pB1NSgxgrHSHYFtrBs9Mf+NZ47S58
 cXuN1jZ065oUZZAIB7aJ21hOaBl+Babw03/86TTdp8fYlefn/+zPGYV4uya1w3eQfjyC
 Emw6NNT8EbBILQSPB3E4X1fwUX5GVpZpdShnYypZCQFj2Xf3iZ5mk3Bv48ID8009OvwQ
 +9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670406; x=1718275206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyRLulYgG/Y+WEP8f9CDh3lXVGbCyj6c/Ke7SFhRwcw=;
 b=XR2Oi03gluC3tRkGEjHMjPy8D/lSXXHvCPmNKuLmuCj63aqZXwPlFDsma3R7tnfALE
 J4MwlOzJrcH4pyzf7JvBO/zJQdyOygkuywbma5Q1LHClSuw/KjndcDdWqfW56Y+2QZvF
 /q1kuGSILxVSQZTrA+8oPzbEo0h0njiZk8jQHPTXLeVIu/ANk1Z7ItSb2eqgnB8p9uBF
 TJHklNyGx0s+LCa2O4skYAcR65w+naz0EewvsEEc5EfUWpYjQikOA3ngTR4oNmUmzy5O
 901GlDe5GKZBge9aWSlJKslh3ufQdCtJG0SAz3F/Qu6MgKVerFRU+afnjffM3JqCQNYT
 wpMQ==
X-Gm-Message-State: AOJu0YxMjvRwhD1rrcQuHHCMMf6/RMYtFA2Ks3npmw7aBEFJ/0Iq/qLz
 pvbC6n8dvQh9yvk8NbIJH4Ix/TWBB+4o8gynkYw6KXjLge3b2nHhMBTjlkPXv5viTVdtPz63kCS
 eEQY=
X-Google-Smtp-Source: AGHT+IFS2PcB11beQYWDUOTreL5puonfQILpBjeeKUW74CxZpemVCoHLbcUuHQCoty9rfz5v6U6xAg==
X-Received: by 2002:a05:651c:446:b0:2e5:3f56:2a0e with SMTP id
 38308e7fff4ca-2eac7a0d1b2mr33845401fa.24.1717670406098; 
 Thu, 06 Jun 2024 03:40:06 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c738bsm17296235e9.32.2024.06.06.03.40.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/usb: Remove newline character in trace events
Date: Thu,  6 Jun 2024 12:39:41 +0200
Message-ID: <20240606103943.79116-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
References: <20240606103943.79116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Trace events aren't designed to be multi-lines.
Remove the newline characters.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


