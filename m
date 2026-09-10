Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83757C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mel-0005Fd-66; Thu, 10 Sep 2026 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lM2-00036B-JI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLl-0000SG-LF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=Xm6JJe8jZACKZildy3sfVvlAL/ANL3nu7YkoVHZkU0lHXKeyVVOWtg0EtGZUDAmi/etr8F
 VheapQ2RzOgiWPabZw6dyRlRSrUoQL6GKI+G1qcxyk3uCVOg2We31igsn2cykeD0Po94h/
 JFUykhdcxrTWomQTDjx+BzXi88RGz4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-1kID34PRPESxyiRWuhoV7w-1; Thu, 10 Sep 2026 16:15:36 -0400
X-MC-Unique: 1kID34PRPESxyiRWuhoV7w-1
X-Mimecast-MFC-AGG-ID: 1kID34PRPESxyiRWuhoV7w_1789071335
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso1750805e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071335; x=1789676135; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=oRWE6o4Bpw70KIvVcA2DSimBJz6gYOeaT1musq707vIoK/KCPjcn01mD9vs3/2OlFo
 tbkCUSv3jcBvblyMFKAapjy7UvK92rV5TglQy6JfMk4XjrpDjlSnlgLa29rjv1bRY1hG
 OIyw1r4839EhqcP+jdG6ntcNPqvzPMHe31MFwoX/8dFsC5apw9HLnfeuMWYeEMRBbk1d
 ZIVCQidJCKbhwzXNUzfGp1KghVEfI9E8d8EpBFiTFcIgK6gPKeedYVdolEypGFP8VYW9
 2pfdrcw0Z9TQFIBYZXMQPbO63gDzdKaIxprwiOM4ZLkoolQnvV0vjyFukl1vkHZu8es0
 FIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071335; x=1789676135;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=YQfA91ITSXs4Bol6il6hRSOuDD0EQLCVfjq7/zsLBBus6Szru1aK9hxnwjwodPI3I5
 Evfr9hAMyh+yxfLbiXqd7iB51Q9QHZJmNFeqzppspBaxcfhFPI6Ch3L27jp8EsgZMSzq
 +jG+cl0EnQ5u4CX3vS8jeJlZJnc1Q6I0soVos1MwH7zze/Ab2P6i8Rt2JYhmPdPZ64b1
 g21rDllQUzvLVy48cPeXhzpZ4yl3v9DrNjJvOZIROEqaFE6n8qcFU7V1pO06RM7bfngi
 q+rvOKFAKxV20WGH6Voqe8in3kp7sdG0i4hge7S78PSS/iByK2xLy8wcSYsnrzBa+O08
 Zbrg==
X-Gm-Message-State: AFuF++k7WWGbJB8BTNnIv7c0seBXjmxEvaCUgdS5QmYEDmqYWC/QMKR+
 T6j7AEopfCTTfcj9LwQIPlwb3UXc98fXvfMZDwKV8sDpJWB8mqY8n4deKlfjCHK3TufEShXz81r
 d1tH75Twga9lG0FsHf21/7RdbF5vZYcZXzFTfH63LhdVgQqRPl851HD/n1UXVGQgy7ge7oUBS7n
 n8gblIs2Gti5lM1HR9Z/8zvuDlChhthHhhBQ==
X-Gm-Gg: AYBFou10YgX/fTO5WFdpQU4fwbjRhHEyHhFOAc8Q9lKT00pk3RokHpO7nTDYKCkZF2Y
 v3yhjJUvW7maRMcur01h7ZYYLnL8VfXVjeWpJc0w6z/o85lmrP910EX4WUrw5AkPX9BBHyL6cyW
 M7mCPq68TpVuO32PRRccb7BDs18WKz+FswLnsR/KCKFHxlo/c4G+CWzaF7CN/DL2/VKMORs1Bwb
 jRwWmuk/GJ4pBGXLE+axMdZary1cavkJ3L95bOPSE1EnV6oP1xN8T/OsA59qyTO5vsRUWNRXgLg
 v12Hm1dCxRPifPwmAY1ANH3UOXQ8nvswiGrwAZkKHb6woyl2G1y7UD9U0n5hXpmdY298yLcZnPm
 D+Auy/E8S1aFynwtfeVcuC4U=
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr12235575e9.10.1789071334908; 
 Thu, 10 Sep 2026 13:15:34 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr12234815e9.10.1789071334417; 
 Thu, 10 Sep 2026 13:15:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35f3d9sm687758f8f.35.2026.09.10.13.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:33 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PULL 82/90] virtio-net: validate IHL in
 virtio_net_rsc_extract_unit4 before use
Message-ID: <58a9bdd9c75642568bcf364114b3bc704b6fbc99.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

virtio_net_rsc_extract_unit4() uses the IPv4 IHL nibble from the
wire to compute the TCP header offset, but the caller's length
check only guarantees space for a minimum 20-byte IP header. A
crafted IHL of 15 causes a read 32 bytes past a 66-byte buffer
when the frame was parked in net/queue.c's exact-size allocation.

virtio_net_rsc_sanity_check4() rejects IHL != 5 on the next line,
but runs after the OOB read already happened.

Validate IHL before using it as an offset. Since
virtio_net_rsc_sanity_check4() only accepts IHL == 5 anyway, reject
anything else early and let the caller fall through to the bypass
path.

Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4166
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 986ceff514..19f453fb7d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2104,6 +2104,14 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
     unit->ip = (void *)ip;
     ip_hdrlen = (ip->ip_ver_len & 0xF) << 2;
     unit->ip_plen = &ip->ip_len;
+
+    if (ip_hdrlen != sizeof(struct ip_header)) {
+        unit->tcp = NULL;
+        unit->tcp_hdrlen = 0;
+        unit->payload = 0;
+        return;
+    }
+
     unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
     unit->payload = read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdrlen;
-- 
MST


