Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15361C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscUf-0007NI-Fs; Thu, 13 Mar 2025 02:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU8-0006W2-O8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:05 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscU7-00067H-29
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:04 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so1106213a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848961; x=1742453761;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BsSYiRkHTorsnB7/LyjN2/FxGb+rg2Z3myQn2vfvIco=;
 b=EDUAeTmAZ6519yBCZYWmGr1lSjSf7w8FvwYI3MdPD9op8kop+Ed3GLQ1uVdVFofqq0
 fjM2tqO7Ys0C8QQHmNXb9bWQqxPhwQmblDrHGZH2pq0JdO07HXDhhB8qKA2kjmRNiF+4
 8BpYMti9hMRhRYeapPkrTJ5P2RSwI3opzZIFwg1EHYhhrYN/NCrrFJin5ccpZr+VaioP
 gSJLi19Cg3vyG7jsZaIAIoqrk4xTmyRRyDdJ8skCwzUDMgSoLPXaDDNblr/8syYh3/Tm
 aJDSEEz/iTfuTwSfHVSJOsmi87HIhTOszyjgrjq7Nk5V1V2IQXF7OnuFdmrjLN7afqoa
 qRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848961; x=1742453761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsSYiRkHTorsnB7/LyjN2/FxGb+rg2Z3myQn2vfvIco=;
 b=iauuYcs/VOlhkvHx9pxbA9B7I9B32iZ3dIbcBhAjz6bO1UQ5kzqYjaYjZ+F5AaXvQv
 STPZRpDRGKUzlqeFy/oGbzW3UmsEDxt9vMEJpb3tXgb5XJbf1Id/UA7jy5Q5mBWPgtY4
 5LXsdjEL6vWQb2Osv931eD4w+IqHt80xh/cTYP235lQQCulACvmtGp7FsOE4h9+9WouO
 IXkLtcwpzeXAHPyCrScJFXyEVy/7HZxEyQr7teEKXQ0HxjZWIV3tkTx1WJqDTVHa7NVn
 IFP2hGaWYLF4ATF8wdf9DWv18Tjq7tDxhIdhepjCt8iuh/L+BoXfgZ0XZHqkdFQBtfk+
 uvXQ==
X-Gm-Message-State: AOJu0YwpTjkQwR80xWgIbIasd3ltHUZiyUb7IJAtA0Wp8mypAPa23eGX
 UzThSOpe6cOt7aDVbO4KW3IVr6l3laqTMEAB/lupQbqx9oWEh0Y+0tnR7jCKLng=
X-Gm-Gg: ASbGnctr87R0LNp539Pf3bdvJZpCdOcuIjYhKO28PNj/MhnaMQZnYMUcu/Zrl3np4HV
 jAnlxXzbzE6Qa6SWtcX40zwhBRzrjD52+IQFHQS8nRFfnHernAENhPBwnwDtW84/sFpu8aOW9Ya
 sVGBR6gl1tfNWihXHxPpivfeaI2lvbh/X/wd/mxDgGnSbmrVKNA5jhLJWfCdMzgEc4WCAy/qPxD
 4l2e4DA5T/UyvytDhLpIBpK/BVrWJnIU8D8ycgH4E+cJUqGpjsPWlJaXXTyDaZu+t8Tp7iHwFMN
 9H6uwuCQJoSMxBMPh1YciF81rcPc8qUw3rspl1djpZY8owPn
X-Google-Smtp-Source: AGHT+IGoiP7VIvkC9eV5s5w0a1tlykMrn1deS/Q7nwiYUu0KbQiYVFprFbLesxhYHM+usz9Rqw7K2Q==
X-Received: by 2002:a17:90b:4c51:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-300ff0ca64cmr15701269a91.14.1741848961677; 
 Wed, 12 Mar 2025 23:56:01 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30138b3b3c0sm607930a91.1.2025.03.12.23.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:31 +0900
Subject: [PATCH RFC v4 05/11] net/vhost-vdpa: Remove dummy SetSteeringEBPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-5-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0e9f4482ce7a..d35348b1e742 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -238,12 +238,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
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
@@ -457,7 +451,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
-        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1331,7 +1324,6 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
-    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*

-- 
2.48.1


