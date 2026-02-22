Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF8CC636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYZ-0005LQ-Uh; Sun, 22 Feb 2026 18:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYO-00050F-KG
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYM-00063P-8Q
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837584120eso26424305e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801672; x=1772406472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9lUxA4IrfT/TzvGe4MH2Ht92XFPB0EPjYVLyaO2F/Ek=;
 b=kecAu1hgFcB6bzoqCsU+zxlBKo0r9A/IN7e5NXz9k4A8YR18EC6HySgSHoRkNdo5j+
 P9XyTQsA0hbKhg3oJongSSyPFaf3qL5Rv8Wxx/k4cg+f8unA677HBZUDIoqyixNB24UH
 57kLnP9fW4F+HRetdZPZza93gMDZ62KTgwB++IskzjGr8Vr2wVsmx0XhbAQu87EApljc
 ncyaLDyjcIt+f3V0//D+hVCxU+Cg/bhEasbDqi3AOSaT5aybZ3PONG/3H3ms8tOaICfD
 YGRtxUHLYtlDWmWjxY3uZo5EBaJ2YN6B/q88BqOCCaoRBIiexobS+ZMMWsM8EMQjq38l
 Kbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801672; x=1772406472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9lUxA4IrfT/TzvGe4MH2Ht92XFPB0EPjYVLyaO2F/Ek=;
 b=bN6FXp65NkwL/HRWUDCXPXheKtH/wxGngBGeT+yXhma+3u+tLYzp5xc2Wv9JaZvJlh
 knIkwsr6I8PkkFyqgQH+yh8FKqUffv0NjhgPZ/8IAkxjijmNJDhporrZCIq9SWDwNSbt
 6PBC2vDgZaBvyBgUPz7OJvIzALtdY29R/S2FRMKUtlst32CTOxuE4OCvNVOIjeYd9HIh
 oFlflUiRiFMEyFv/QYLXhgER3HnDi6Cm4TgyDo25STP3+HnxFkz3SiHRL6UAiq65o/0k
 rvNHv0UGzoJGrWe6A+MgoH6Kvteb/sHHtvNLjl85NzqhSibvfH7b3VG1blGNrysqIqlo
 Id4A==
X-Gm-Message-State: AOJu0YyqWkUzDdG6ia2SvcbJk0Xnzn1mr0VHtI+S3Pnkqhyly4GJ3djn
 TLmNPvYdRhw9XDWN7JkvCGon4TAcxiF5O1ehcgv6ACAUaimEId6f6VZUW/Ema9L4qJzlj9tiCcV
 +mNTmOyc=
X-Gm-Gg: AZuq6aIUsDpD0mMvCzIjKB6zS9JrZyON+Cj8LjDcK9qKhZDiRdngyWNsovK1TQ0x2ce
 8zURslzyOsO45kEupPvcnmwXkUbQjuHc86cDdgONjxad97pV7pq46ktyPkO5aNjFftJpCivy+F2
 nRYjZbIRZ2ArwjYm4Myu81pQt6xEfzHNzPrt14dk22qzT9z/RQ18Isap1ZtSt5y5qwGD62N8te2
 rA0WqVFbb1Ju0lmsmZLBczWiE58T+gZUoNjs5oFSDunqR+j0pvpCDCK2dloFey+VzC0/fUAZpnN
 nxpI4Sja0pVRcoVa99/I6/eyCSyAuhlLLfdT2E0JlAEfbiLgy/GsAYGKs6YpKP7dVXFOygbVZ/r
 vXiAV0LYLmZcKFToRdZ7mlInAliBQl5CRchbkeOgnwRnzTN16av5j5/RuajEG4aEgwK5FcM8YWv
 iGeg6HPuBLdtEZZsUd3Yt3dDtBQNZx6UqDvVbewTarZI6a7AGKUUR2AW2JU1sH+7jTr7VAjLBb
X-Received: by 2002:a05:600c:8b2a:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483a96148a7mr99570085e9.34.1771801671842; 
 Sun, 22 Feb 2026 15:07:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31ff4d7sm234773865e9.15.2026.02.22.15.07.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] hw/net/rocker: Don't keep pointer to h_proto as
 uint16_t* in OfDpaFlowPktFields
Date: Mon, 23 Feb 2026 00:05:57 +0100
Message-ID: <20260222230602.5756-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In rocker_of_dpa.c we assume that the h_proto field in an eth_header
struct is aligned, and we copy its address into a uint16_t* in the
OfDpaFlowPktFields struct which we then dereference later.  This
isn't a safe assumption; it will also result in compilation failures
with gcc if we mark the eth_header struct as QEMU_PACKED because gcc
will not let you take the address of an unaligned struct field.

Make the h_proto field in OfDpaFlowPktFields a void*, and make all
the places where we previously read through that pointer instead use
a new accessor function which allows for the possible lack of
alignment.

(Compare commit 5814c084679
"hw/net/virtio-net.c: Don't assume IP length field is aligned"
which fixed a similar problem elsewhere for an ip_header field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260212140917.1443253-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 16b9bc7a4b8..814f19afc58 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -143,7 +143,7 @@ typedef struct of_dpa_flow {
 typedef struct of_dpa_flow_pkt_fields {
     uint32_t tunnel_id;
     struct eth_header *ethhdr;
-    uint16_t *h_proto;
+    void *h_proto; /* pointer to unaligned uint16_t data */
     struct vlan_header *vlanhdr;
     struct ip_header *ipv4hdr;
     struct ip6_header *ipv6hdr;
@@ -196,6 +196,11 @@ typedef struct of_dpa_group {
     };
 } OfDpaGroup;
 
+static uint16_t of_dpa_flow_pkt_h_proto(const OfDpaFlowPktFields *fields)
+{
+    return lduw_he_p(fields->h_proto);
+}
+
 static int of_dpa_mask2prefix(uint32_t mask)
 {
     return 32 - ctz32(ntohl(mask));
@@ -395,7 +400,7 @@ static void of_dpa_flow_pkt_parse(OfDpaFlowContext *fc,
     fields->ethhdr = iov->iov_base;
     fields->h_proto = &fields->ethhdr->h_proto;
 
-    if (ntohs(*fields->h_proto) == ETH_P_VLAN) {
+    if (ntohs(of_dpa_flow_pkt_h_proto(fields) == ETH_P_VLAN)) {
         sofar += sizeof(struct vlan_header);
         if (iov->iov_len < sofar) {
             DPRINTF("flow_pkt_parse underrun on vlan_header\n");
@@ -405,7 +410,7 @@ static void of_dpa_flow_pkt_parse(OfDpaFlowContext *fc,
         fields->h_proto = &fields->vlanhdr->h_proto;
     }
 
-    switch (ntohs(*fields->h_proto)) {
+    switch (ntohs(of_dpa_flow_pkt_h_proto(fields))) {
     case ETH_P_IP:
         sofar += sizeof(struct ip_header);
         if (iov->iov_len < sofar) {
@@ -547,7 +552,7 @@ static void of_dpa_term_mac_build_match(OfDpaFlowContext *fc,
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_TERMINATION_MAC;
     match->value.in_pport = fc->in_pport;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     memcpy(match->value.eth.dst.a, fc->fields.ethhdr->h_dest,
            sizeof(match->value.eth.dst.a));
@@ -643,7 +648,7 @@ static void of_dpa_unicast_routing_build_match(OfDpaFlowContext *fc,
                                                OfDpaFlowMatch *match)
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_UNICAST_ROUTING;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     if (fc->fields.ipv4hdr) {
         match->value.ipv4.addr.dst = fc->fields.ipv4hdr->ip_dst;
     }
@@ -672,7 +677,7 @@ of_dpa_multicast_routing_build_match(OfDpaFlowContext *fc,
                                      OfDpaFlowMatch *match)
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_MULTICAST_ROUTING;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     if (fc->fields.ipv4hdr) {
         match->value.ipv4.addr.src = fc->fields.ipv4hdr->ip_src;
@@ -713,7 +718,7 @@ static void of_dpa_acl_build_match(OfDpaFlowContext *fc,
            sizeof(match->value.eth.src.a));
     memcpy(match->value.eth.dst.a, fc->fields.ethhdr->h_dest,
            sizeof(match->value.eth.dst.a));
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     match->value.width = FLOW_KEY_WIDTH(eth.type);
     if (fc->fields.ipv4hdr) {
-- 
2.52.0


