Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9050CC35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0Y-0003M1-TQ; Sat, 14 Sep 2024 21:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0X-0003Fn-BQ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:57 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0V-0005Rq-PX
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d8a4bad409so2376076a91.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363494; x=1726968294;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=89JxFPnOlJQtCZTBwZsp0a/32JLBYWXWTM7l+f2b6vE=;
 b=OvBDH9AnfcnF8xhUzAxJOQvso9ElHANY6uB4TVJlSE3Vc6oHg4pKS8+LHXvy2Y++5Y
 kJF41Bt0HDC88iNvVpcDnb/0C6miFXVHYWJDYD2uF67IvWvhSl78Z8VGQDdB9FcekrnN
 UuWvt7IG2g1Hl1+SS4c1apkxSOBQJWx4Zx5rT53Ea8IKxc82Cn5R6HYQQOsKdfSrXIWQ
 br2xAklqD8NuyX+uBqh9smuMmUQsolJpFR17fUICcChH78d0J7/ur2VTWaN4vCp2pHt4
 SGDYB/9LyHVJrHgW80kVTA5M5rFp7TpC1gns/GNw25fcJtCR3IIz54uAulS3UTQnUkVe
 QCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363494; x=1726968294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89JxFPnOlJQtCZTBwZsp0a/32JLBYWXWTM7l+f2b6vE=;
 b=dq4jkuC0KDHkhEK3eo4NNy2INUWwHmEEQ5sP4WjtJXa4GNI3iPo65Qd1Zx6msCjbmO
 PXAJ3/WJDUHdNRGTRq7UNJgQA69+0+7GzCejx2/I2sYblrz918FNYk5hkjqjkCBVs7Y3
 g9JEQ6a1WZ6GKVQh1+V0LBUq41EM+5VnHGKy7uMn96ngdS8JDxfy98CAQEEhomVZdTED
 KyIjzH6R0jwDjoi2+3t6hI6cbBrP90wsNKxAK0U5ilfjbdHGCIB9VlTJCkQtE+HNBm/s
 FtTAyGI9/ViGnLt/O7OyI4tfr28u6WxkDuSXp7opZkqkGEBuAYj4d52wrsM8dNpMNV2s
 j7dg==
X-Gm-Message-State: AOJu0YyS2q51/NVAkZJ5UPA1FWYyKrLVr2PyUp4k0jdl27fuiOs5ag1E
 4oMfWHA8j77OW8dlGCKdzspTsRvSj5OSMCKx8oRCvCatqcjTB0m5cNi+TvqzH0KrFm7jRuG8SnA
 ne3Y=
X-Google-Smtp-Source: AGHT+IHQOjqkQ73VSwh5AmmupKudhjM3XR375wMvRoHTaFqjQmUeFKHdUScbgvHsRqNzzzwPvfSmlw==
X-Received: by 2002:a17:90a:d903:b0:2d6:1c0f:fea6 with SMTP id
 98e67ed59e1d1-2db9ffc385dmr12841462a91.11.1726363494164; 
 Sat, 14 Sep 2024 18:24:54 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2079472fc26sm14812295ad.255.2024.09.14.18.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:46 +0900
Subject: [PATCH RFC v3 05/11] net/vhost-vdpa: Remove dummy SetSteeringEBPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-5-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/vhost-vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4af87ea226b4..5d846db5e71f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -245,12 +245,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     g_free(s->vhost_vdpa.shared);
 }
 
-/** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
-static bool vhost_vdpa_set_steering_ebpf(NetClientState *nc, int prog_fd)
-{
-    return true;
-}
-
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -465,7 +459,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
-        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1333,7 +1326,6 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
-    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*

-- 
2.46.0


