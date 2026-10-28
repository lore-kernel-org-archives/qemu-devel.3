Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A823606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FsN3XutE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bLyGtCVL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hk-0004Rb-6C; Wed, 28 Oct 2026 13:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G9-0000VW-6f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G7-0003sS-GO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8zxRANqUP6bPzrOrYEanSEo5hHFO8eTLenk+d5cs5Q=;
 b=FsN3XutESQbyt3obdAHVkfIZRZAF4c8CcIh939l4ckTMAHc/ky0+RaXg7U5pvBbJGM8NYH
 yAdZTSD5pWKmqN8yfOhkGD21PhVURgvcDsU4tr4OGkUA8wIfdqrgWgLHflgCZOpSzW945s
 XoRiRg4lWXMK9I+L4lmpmopXQ86tqk8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-s58tUbOxM_mgQs1bm96DSw-1; Wed, 28 Oct 2026 13:16:17 -0400
X-MC-Unique: s58tUbOxM_mgQs1bm96DSw-1
X-Mimecast-MFC-AGG-ID: s58tUbOxM_mgQs1bm96DSw_1793207776
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso798758f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207776; x=1793812576; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8zxRANqUP6bPzrOrYEanSEo5hHFO8eTLenk+d5cs5Q=;
 b=bLyGtCVLF73iDIdun2ZXW8K2/Yc1H5EJFS3447Z0qEyrzTj2209bnO+yCWSM8gt6SS
 UV+udAjLM5wKkLnX5NcXE9S4PBCKb0NYCahCYKuKwWp3ZsMMNFLgeJf4s8xXqHFa8p8l
 wuXYKxRWkOdN36FlHu2q7nRm7rr0eoOHxNRwBKJHKJWdRdwKnIDSyKFwi3hgckVDDvN+
 pb1eMqgQDgzFsDU0izKXxQUxX3U66dSrCOSj0SE5LiSpcCQ5303q9TK1u0zhQK4zBn/j
 D+MHX8VEefMn0G0GU4Ym9T+U9jb+LpngyTN8HTqZ45nPqXRPTUhsAOhHKjvaE+vAfh6c
 hElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207776; x=1793812576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8zxRANqUP6bPzrOrYEanSEo5hHFO8eTLenk+d5cs5Q=;
 b=lHE2cU/qob2vZUumbeT1GR/XC332Y/Q/DzFHfxlKcnYC9xcLss/jgMTF4s0y+Yclew
 dz5NJE3CWlDiPGClgw2daLOfp2RrSNBGpij46Z35QdMtBaU5dCtOOK5DvBMHTOsgUiuP
 YAC/yvZ4mgGC+lgnzQJvArxkUy3i0NCVkEEI81RlkLfDkRrSokYPXrgUkJ2BJ4CHb2VQ
 MzwQ48M5dDKVtM7kzZhvPWFN9Nag9fhw2dRtY1DeOhHt7usQM5GcHqybDHY0Hp1z+V4C
 3Cq5eBSZRiDWn2awfe8+xj1i72xnR0JnmU0KveqO958smGRhm0o7sxTGAPdMSMZdwHwt
 qOLw==
X-Gm-Message-State: AFq9FYLVULwZYO5IhcEXiS/b8zWm9bI4eGKlli7sYzSUoCntrIv/u5Gi
 SRAPBpdaA8smzucoiyBwi6yq7oMQxWDaZNgs5BkhcYcq04ywda53noZHL8pa+Utj5deyzbxBRgm
 U1696MFmcrl6cGfKyQ7K3YoNNT5xoHBrUfsIA3xHXuT366kI4g1xn9KEhtyO288IcTiCQ4XX7AO
 DoUdf9dsNfLMiko3vyDAWb8T9Vw1QHxLyTVg==
X-Gm-Gg: AYBFou0EDQvpHGjkW8L9SmVh3ZmvIt/FsZdnXtXUZziX9SDsrd+m8XOuxm/nX3soE7Y
 rK9dtq2ACAPrsHCLuXGNd4/UCEyl1CODbiKhjUZk/TMYJTcbHK5qSuFvSh35ZM7SZEeGANl6UEu
 QvE0UJOJ+75uXBEgLcgEAMLPL/XlmmR8WidujqpjfjX5m+ahSUN3W4b7ZngMQ9IqyIT8hxjK9ZD
 DtLXQlDdeckDqgyfkWd9RuOM2oTd7HmbsO9sZTZaat7ZCdvh7Mgmd/nEhTPW/+HfsL0ACqMUvDu
 7kCtnODP9HExzWvOdyqhOMYbK27J6iu9Buip5BFS4UNZRgTydeg0aoaPGB63D0AccceYgOIdnOL
 91zt7YXDSmIYhFl6URuNo/1Pd2eJ1+QZjusxdpJ7l
X-Received: by 2002:a5d:5e92:0:b0:48e:412:37f4 with SMTP id
 ffacd0b85a97d-48e5d455071mr7195306f8f.1.1793207776083; 
 Wed, 28 Oct 2026 10:16:16 -0700 (PDT)
X-Received: by 2002:a5d:5e92:0:b0:48e:412:37f4 with SMTP id
 ffacd0b85a97d-48e5d455071mr7195226f8f.1.1793207775513; 
 Wed, 28 Oct 2026 10:16:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4d8dsm30983799f8f.36.2026.10.28.10.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:14 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 52/78] tests/functional/x86_64/test_vhost_user_bridge:
 Eliminate stdbuf usage
Message-ID: <fe9cf95d2434342b6ded5e3a12569ec221b71c21.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Usage of stdbuf triggers a runtime error when vhost-user-bridge
is built with ASAN. Now that vhost-user-bridge writes debug
output to stderr, stdbuf is obviated; remove its invocation.

Message ID of relevant thread:
<20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914165250.88382-3-yodel.eldar@yodel.dev>
---
 tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
index c36c625420..5e1db48884 100755
--- a/tests/functional/x86_64/test_vhost_user_bridge.py
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -76,12 +76,6 @@ def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
     def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
         vubr_args = []
 
-        if (stdbuf_path := which("stdbuf")) is None:
-            self.log.info("Could not find stdbuf: vhost-user-bridge "
-                          "log lines may appear out of order")
-        else:
-            vubr_args += [stdbuf_path, "-o0", "-e0"]
-
         vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
                       "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
 
-- 
MST


