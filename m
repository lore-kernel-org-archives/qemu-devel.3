Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB244C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lbL-0007RS-Eg; Thu, 10 Sep 2026 16:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFl-0000go-SH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFV-00080Z-Es
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=ffuSQsn1RNAfUZZ6Dbj6i2Xg/31Y0ultIyitT02upSdVmYclhvvecPVMhAo3eAvs2m/LrN
 ghjAi2hsPTPENlMTfXPdy/cqEdh93cdcFdl69r83b7/rQYs+uvzgx5qN5IE8lcbmDR4uKJ
 xV88j0pARTkhwBMNBzrvZDFeOGr0ctc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-eKcmbK5TOgqMmV_CaZfQ5w-1; Thu, 10 Sep 2026 16:13:40 -0400
X-MC-Unique: eKcmbK5TOgqMmV_CaZfQ5w-1
X-Mimecast-MFC-AGG-ID: eKcmbK5TOgqMmV_CaZfQ5w_1789071219
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso8584045e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071219; x=1789676019; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=AcEZSoW6PJgwNfrIAqa6XWqb3l5kwkZ1ui4QYf8jt8mdwpq2xU5hEoPJbdWaPev7Y3
 WIVYtGwk1LLwRjyGvLQBTL97e7ekbW4h6mC9vAIcs4OkNBXs/Xy9kc0RZxpEpc60efwV
 euQ95Od6+vV3/BVgbDKKzmHBqfdE0aSxObT9m9jJ4p5xJWhoUWeooOMqSYQ2eQUJuZCB
 ZrN703zEgOVi310eQe6fndlbiokat57iecDNDeu9gp18NotxvaCgxn/OS1CsuNE6EtJR
 BYkdGFbzpDxvLhCZx9/MIY40JSKDbx6yb5jQ9n0EsW6/qnJtiB/3EcvVCY4yd3ahlKh9
 cLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071219; x=1789676019;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=pcEeJdA1fP4EA8riDE/rKeW7cfchIq8v8JELJAkt6l7wEgnHGnmZDK9Z3ngEepM7ha
 Ys1qYE9fxvqSbB3i8hyYIjmJpMNv5OIPeNfXyvPOLoPH2kzjNgr5iz1yjHUsV+3A3UcB
 gyhpChPJ6Kb+JrO+VoSfRBipf2qXUBKRBPp5AKXdyXQxmHgDU+j9yhsDUBwEQdMdEmlx
 Kox9fGGFIH4pyd39FkfEPVRFH7OcPtpaJddb/BGiogFP8etNSxiL3knk/fypTR1IjOBp
 O4lik2XxA6+qBwnE67CqfTE3QPBU6wa70Mawrp9VdDwzwaB6Fb2JErjPbK/1IijiwFrH
 yBhQ==
X-Gm-Message-State: AFuF++mC9EpLTHKLW6en9Q3JNng+sbj6rdvYc4gCsapQgqJghpr1vukW
 WbaECnGi+DK3H2sQHfLtr0bHdcQ3zGwSXYBXZgM1bqQKx+nBM01njSJnmYmitoHa7nA3RKAMz5u
 m7jOa6fgKGD1zLjLHUVi5t5iXGMcJ6EpbCjr+l28GILue8evjBUWwC7i0wpceShcuQHzCrWC3Hh
 HkOesV07YqzXssKff4FvEfFtSlELNUXmMVKw==
X-Gm-Gg: AYBFou1IM1QJe80E4riqIiSyUv898jzYI23k4/Mnm2okkSgIHKUDlLNybWxUvHLMNgY
 lNVlNYQUlyuUemVpgu3yEA+VqhPGKBTbmCSz4X31d/SZU2CnI0Cl9hXHSa7f7cNmIhlClHD9m7B
 w65LJhdQq96Dt1EYvL2H6FlHLQqmfuCYtuv7XOa4kjQoyo8wmdscV55BPr3TL+j3xBLk788do23
 RyZK7fa1+MQ/ZkB9eF8BLBJUK5O/U3zoI3frR513FrjeZMHCDrlvuTE8RBqImwjDwkq9ghLP8AY
 kgg8rr2VDNoHz2mAWCOYDy2v259ASEn8dnIBn7wXsjmNRc/MhR8XYcEY8Qw9//RKUiw/KVYUFHO
 EmoUOjeCEJ1Di21rVYrqMToQ=
X-Received: by 2002:a05:600d:8444:20b0:49d:27ee:79c9 with SMTP id
 5b1f17b1804b1-49d27ee7af0mr55871665e9.8.1789071219219; 
 Thu, 10 Sep 2026 13:13:39 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:49d:27ee:79c9 with SMTP id
 5b1f17b1804b1-49d27ee7af0mr55871305e9.8.1789071218624; 
 Thu, 10 Sep 2026 13:13:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f1f7sm765644f8f.24.2026.09.10.13.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Yuri Benditovich <ybendito@redhat.com>, Sven <bestswngs@gmail.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 52/90] hw/net/virtio-net: strip trailing padding when caching
 RSC segment
Message-ID: <e242d9e64d9788fbe4b570eb4f5e675c9f1d4fea.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

When an RSC candidate packet has trailing padding bytes beyond the
declared IP payload, virtio_net_rsc_cache_buf() copies the full wire
size into the coalescing buffer and sets seg->size to that value.
The bounds check in virtio_net_rsc_coalesce_data() uses the IP
length field (o_ip_len) which does not include the padding, so the
check can pass while the subsequent memmove() overflows the buffer.

Fix this by computing the actual IP packet size from the IP header
and using it for both the memcpy and seg->size, so that seg->size
stays in sync with the IP length field. virtio_net_rsc_sanity_check4/6()
guarantees that ip_size <= size.

Fixes: CVE-2026-66900
Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: qemu-stable@nongnu.org
Cc: Yuri Benditovich <ybendito@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3879
Reported-by: Sven <bestswngs@gmail.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728082311.4179910-1-lvivier@redhat.com>
---
 hw/net/virtio-net.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f3f375e1b2..23c26aa08c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2200,13 +2200,31 @@ static void virtio_net_rsc_cache_buf(VirtioNetRscChain *chain,
 {
     uint16_t hdr_len;
     VirtioNetRscSeg *seg;
+    size_t ip_size;
 
     hdr_len = chain->n->guest_hdr_len;
+
+    /*
+     * Strip any trailing padding beyond the IP payload so that seg->size
+     * stays in sync with the IP length field used by the bounds check in
+     * virtio_net_rsc_coalesce_data(). virtio_net_rsc_sanity_check4/6()
+     * guarantees that ip_size <= size.
+     */
+    ip_size = hdr_len + sizeof(struct eth_header);
+    if (chain->proto == ETH_P_IP) {
+        struct ip_header *ip = (struct ip_header *)(buf + ip_size);
+        ip_size += htons(ip->ip_len);
+    } else {
+        struct ip6_header *ip6 = (struct ip6_header *)(buf + ip_size);
+        ip_size += sizeof(struct ip6_header)
+                   + htons(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
+    }
+
     seg = g_new(VirtioNetRscSeg, 1);
     seg->buf = g_malloc(hdr_len + sizeof(struct eth_header)
         + sizeof(struct ip6_header) + VIRTIO_NET_MAX_TCP_PAYLOAD);
-    memcpy(seg->buf, buf, size);
-    seg->size = size;
+    memcpy(seg->buf, buf, ip_size);
+    seg->size = ip_size;
     seg->packets = 1;
     seg->dup_ack = 0;
     seg->is_coalesced = 0;
-- 
MST


