Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21834CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgWA-0000xU-A5; Tue, 12 May 2026 02:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgW5-0000uL-1P
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgW3-0004dR-5F
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso17230515e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566968; x=1779171768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QJ4OaOCleUomCfnEQePhfE9b7I0kuoQqmAJfKtFe8LA=;
 b=v5Hgcv/TcuklyuANxPEOfncWi9GQeLP8WRb4+Lyne04Rnt7A3mpFhvbAcH5z/JFI/e
 sJFSn4hgAn2uoA1IXYOFGOVxrcBM1urFLY5J1TbEnF55kQviTyvdrm1XFI+f9ggYGg0e
 IasISirGZrn6PcKzseEAOx7+E5UgoaVADBsfTCwAEqkinr6l2gTclC+r792FrZh5RDOj
 9WQXICGaCvXkgYC9b4k0htTCoWF59eYN1BhjW1eVkEo5sywB6Q3eayIClroMCJgnyJb+
 ErUvAdJhVKJA1tNfg39WMd4WNFuB5mekerkEN67eiYGGBw7wmjJ0brjgvx9Sn59zNPS0
 9nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566968; x=1779171768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QJ4OaOCleUomCfnEQePhfE9b7I0kuoQqmAJfKtFe8LA=;
 b=MqX8kI7dSCVdqicom/K7R7Q8wdDxbsic5/h+holgHJe2XOxYX/2tUz4VC3et1Tldk/
 dpzx7LyQERPxcpoHUo0cAyg5cwk9kOWjurzfYnMDUXNjLv4Ckjrta3CgYaX1WgA6gwkf
 jGmC2bWttrT0USrw5FnuintfGRRIZ3SlzX6PO+dEZ2J64JSHTusEtfbpSn7W3wEstwlK
 VyJ8Nt/sITfFYs3R+wSNE5OjdTNkdS0CabHi108C9MRCxoz4I0OayNhH2WIAF5ob/T+h
 A19+4dEMpmgyejGyYV51i59rvdMj4IAtxr3h8GpjtNbh8t3hyiv7rAtvHcx6GDosTbKb
 8pGg==
X-Gm-Message-State: AOJu0Yw3l1He54Ww9fDOBmNruEUdtfbMtJbD8aL1XeS4CAgvbJZX4QmX
 1Dgkjj0i+OL2Q5A5ngw/i6u+g+f87t4y+7Z3g/mDps081GLvzvfX2JgxNPEXsIdaEBHUj2XQLCY
 nagz8afQ=
X-Gm-Gg: Acq92OFpIq5gdKUJ+i+O/M7MJTkSGGpF9dWh3Ghh+GsDzZrmQynLZOzc+Kin7qq8cjG
 /l9GME33512LiTdzAbrUyEhcccnh5ajnh5m4Q7L5EFxD+66E7PTImXLCOFuuXNpzxVkhjrACahx
 W7I0dF4RN4dhv+/XdLZRyXVP1QXYuWkM1F9jRqxBpG23uNysB6dhuvb3pGysabjjKXDmTi0hOOr
 aq+C8IzOO+EMht7HPsf22eCfU0rnQgVlCdODvSB3et79ekJTLD2KZyTxWJAuFLS6U7Zp82AIJjM
 hqVnlXgMLEYiYpZnRzI7m+xM9WxzEx/NJjUhPpw6RRDJpv9WuQLUTCm4/XJ3ptN3cX9ZjnBvoYE
 txSn9E6ZbmUXgdW1bzjSdcN/v68HnUPUCn31511WshD3v1gThQUXuDmf7y1Ik8Jpve5FDNvZ0bl
 nR5jP+2ZsBJtiJTk26TFCT/rD0+32vbW06g6RLMqHg+4xgcnouV0vdRdcnwBLHOKW80wRk9EtR
X-Received: by 2002:a05:600c:3111:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-48e8fe509f1mr20910895e9.7.1778566968195; 
 Mon, 11 May 2026 23:22:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f540aecsm10188135e9.33.2026.05.11.23.22.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] vdpa: Allow VDPA to work on big-endian machine
Date: Tue, 12 May 2026 08:21:10 +0200
Message-ID: <20260512062142.67998-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
when they saw "VLAN IDs" greater than 4095, and QEMU then said:
"unable to start vhost net: 5: falling back on userspace virtio", and
VDPA became disabled.

Convert the VLAN ID to LE before putting it into virtio queue.

Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260427144746.1498-1-kshk@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vhost-vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3df6091274e..f1523697e20 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1200,9 +1200,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
                                            struct iovec *in_cursor,
                                            uint16_t vid)
 {
+    uint16_t vid_le = cpu_to_le16(vid);
     const struct iovec data = {
-        .iov_base = &vid,
-        .iov_len = sizeof(vid),
+        .iov_base = &vid_le,
+        .iov_len = sizeof(vid_le),
     };
     ssize_t r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
                                         VIRTIO_NET_CTRL_VLAN,
-- 
2.53.0


