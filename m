Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171FC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PH-0007M5-JJ; Sun, 26 Jul 2026 17:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PG-0007LU-9U
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PE-0004D0-Jp
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gW9s1lR17IVFUJV1LaaI+57WsD9Xozg6230WVloM/ho=;
 b=ifnqz4qn+G7Q4Xzc5kXcgqZXnX0BcJhr9zLP5NqIZf+8PTwSQQELg5tLYmtet1/GekfZIn
 HJuBzfBVUo1nvasWqQmtp82cJJkyGdUeoMUozA2oNR9jjYJvGhvI4ECxYRNv9A7zM3BxDp
 k0sWWsmEQwN+nB+yhhmaDAsqY/Vl7EM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-a1WKhg2_Pm6Gn9GQ4E2hOg-1; Sun, 26 Jul 2026 17:29:06 -0400
X-MC-Unique: a1WKhg2_Pm6Gn9GQ4E2hOg-1
X-Mimecast-MFC-AGG-ID: a1WKhg2_Pm6Gn9GQ4E2hOg_1785101345
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so1064463f8f.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101345; x=1785706145; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gW9s1lR17IVFUJV1LaaI+57WsD9Xozg6230WVloM/ho=;
 b=h14BSZMfaLifl6OSiRhWUYE0D0H+HwSZhsvuRDMPP2wmwRG9U6NYTMt7mNTT8SLSJZ
 g+zWLAXafwEqVMIcbY3MtcnoLnV/jQOdXMWbgk3REszhJlGAJKPLwrS6Ndpyb3XkiTFN
 vaYbqy2TfqNOyHAp00LCjHCsY5eayU5pX16lbvN1xZctlGb/BVABVbsR2jCfNqvuf+5r
 QwcMckziVJMUowwPqeYXPi96Y2xyf121QsTxYBZWVrkrVpbGsLxqj52XWKGZkfQdk3YR
 jLypuo1GKg85Qp854LLy87CQaWTzoB2Opq75LTmEOweTZlGRuL9yD3B9l4H232Fz8u8E
 EZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101345; x=1785706145;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gW9s1lR17IVFUJV1LaaI+57WsD9Xozg6230WVloM/ho=;
 b=lCluFaAz5wW0s4Kj2N/49L6AO4NFNKODoCnkMoenSJYOMWbLutwl7zPWp/Evl/AG1I
 n4KBkT1tb6wAu28hg9bRN/tEyZj37grdxUZdLhAmGplToquaMz+6QDJac+A7QkQ8Z8p3
 dL4XxSge2FHkIW3PAnxFWRHAwfLdVkz1N58rl6YwupZoIRqTe/xdVuoeJEnFaq6G43Ef
 rYwQnxuRGDYJ6rtHWx60ZnKroKWj8xjx6Ngu2qrz469nllNkvWYs2T4BwFF9HoTwHjMd
 6H/xm12NNQRrfhY6zPMZMEIC7fuF3F+gVe7NsPtMuUWVi+gsxzJ8k5vj4LAJJwZYXye9
 jOlQ==
X-Gm-Message-State: AOJu0YwYLYRARUqmoIWA9cS9r1MK5tNtX6F85N4Dmk32J8/8W8KfJm+y
 zBB+Myvd/4gzhMac8nPXZwo+JgSA/OcEOUOGapXAyQYbJZOPuRDm2g5NjIeM9kGGzwZ4C06cUd9
 ocwMkWhP6rTMWO0nTWCCvo0/5As20cJt3ovq8s6d4ibso6X39y+hOT0imxCmnkAagbSruWWIb9m
 JWOsX5bLrLcbFgOIAhN277iC+niZgN5W8rWA==
X-Gm-Gg: AR+sD107lD0JzsqM3hKsqgEnlvDVsBhEudioTxHi/Ct6IA1+L0MEogxyf8aXbaZCPhq
 h7LtFgzlGfubbi3/4rFZLBIYrJ/n6QlmOYqJknoQG/1bPfHK9+Fy4zlEgy/aIxLJVsBdDItizgw
 0lqjR0vfGpJfO0GYwbpsj0q1vvG21bNYS1MpgZIYivXfKUoylq+yA0DgsdV8Twif+R2pgNz/msw
 SOL+sNcQG9UENba3VZlrmFG7FMUfb7Jmh9a1Ii6q+ksdDeUFX7ymLs7d/0s9zHFajSq1QhXlItF
 J0+lQDvjVzNAj/lULArpG8X5PSFwhtsEgUHqfveZhK3vFQAHet4UIU2IwUFDrpBd9iCfJQeTC2o
 Y/TgoFeXIKEv1pC6IHPTEjA==
X-Received: by 2002:a05:6000:1ac5:b0:47f:8fc8:a8b1 with SMTP id
 ffacd0b85a97d-47f9fc901afmr8541738f8f.14.1785101345049; 
 Sun, 26 Jul 2026 14:29:05 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:47f:8fc8:a8b1 with SMTP id
 ffacd0b85a97d-47f9fc901afmr8541721f8f.14.1785101344560; 
 Sun, 26 Jul 2026 14:29:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm46992658f8f.7.2026.07.26.14.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:03 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [PULL 01/30] virtio: use masked features with set_features_ex
Message-ID: <f847a46051e614dd8843d38a9fde6174037ac15f.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_set_features_nocheck() calls set_features_ex
with guest-supplied feature bits, without masking the value
with host features (unlike set_features which gets the
correct val & host_features).

This does not matter if the driver matches spec, but drivers
can be malicious or buggy and set bit outside the host mask.

Devices don't expect this, so unsupported guest feature bits getting set
can break the host. In virtio-net, this can enable RSC without vnet
header support and cause out-of-bounds reads from short packets.

Pass the masked features to set_features_ex, consistent with set_features.

Fixes: CVE-2026-63321
Fixes: 64a6a336f4 ("virtio: add support for negotiating extended features")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..7c19080db5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3320,7 +3320,7 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
     if (k->set_features_ex) {
-        k->set_features_ex(vdev, val);
+        k->set_features_ex(vdev, tmp);
     } else if (k->set_features) {
         bad = bad || virtio_features_use_ex(tmp);
         k->set_features(vdev, tmp[0]);
-- 
MST


