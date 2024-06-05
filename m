Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B505CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsZe-0000fo-8z; Wed, 05 Jun 2024 11:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZb-0000fF-M9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZY-0007Xm-4a
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso4836541b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717601346; x=1718206146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NL/0bUuZW5NfajYFBq9RShKw+LMyCnZCbT2JXrSd7w=;
 b=E8UCBnS7SjS/0N2a7htKeJetxuBOJxIn4Kt4JN+YvaD9iiazii49tOw1+QGXITZWQL
 iHjgHpQqg/wVV2M4OgdkGVPZcr38zyQ9XCJo5vtVXqjOP+spfbpAuUmATX3EhjAtVbwM
 MBv+neYLfAKTY5qobjPd8scvg8/2+1/EgWlw04g+mENgY/Kpss0+pswX3LQ3S6gzOeXX
 kHGF+4HlxZaUi2iYicZqLcHlvY5vo7lbdvp+fqdWRE4izhR1FjU8SNpnZwF4Z3FUcp1j
 UMW1QRXTnxGOKzfzvKkD15MAZTvdiEfGcJddEHMFLW49cJU6spMWIzqeIBmJX3DV9iTJ
 cyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717601346; x=1718206146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NL/0bUuZW5NfajYFBq9RShKw+LMyCnZCbT2JXrSd7w=;
 b=pZMdE4WKwZPRzJhp6Jzajq4B3KLtUD7lmT1Fd/Gjx+r8j37qcd30+TsStHClUgnyVH
 ODS3wu07uLYqWddVEO17Jlzff9b5KKZ9vs+c18QALWz4v59+XfNnhYCSY5Qd9euuSow/
 KxyDh8Ro5U5NUzI6oRG03vAIG9W6xN2yxckd1s649qljd0Y2rG7wQPu+KOEPK0V9AsBQ
 8IwGWfMAxQMZYvJ2/zpjSmWKrEcQYEjrWoIre8Ff7D3LTpAqB3iU/oI3rHKRJlAl6/Hg
 cJO2D9D0W2KWa1qgLnIp1q8I9eLvc/bu+7MlAthECubM261dg0xgFbpdkovYewHO3Ek1
 ToPg==
X-Gm-Message-State: AOJu0YymQuG3z07t1uNhjJ1UMN3VEIROUEy0QucpFykMM4mpf0l/V/fp
 1Ac9Ch5/LF7L+2PaNkJnH5j8PLVQOrIWJH5tY1prNSj+NUQVEEY7CVmKpCX8Gyw=
X-Google-Smtp-Source: AGHT+IFPMAW8IAwSm4ZNYG+dmnq5PaDPTtEB06U9CzGhuEHffFjVEp1M85iwVLKuazg0gzBunycnsA==
X-Received: by 2002:a05:6a00:2ea9:b0:6f8:c6e4:1829 with SMTP id
 d2e1a72fcca58-703e5a1bbfdmr3336205b3a.25.1717601346222; 
 Wed, 05 Jun 2024 08:29:06 -0700 (PDT)
Received: from localhost ([103.192.227.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702688e7e3dsm5526712b3a.215.2024.06.05.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:29:05 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/3] virtio-gpu: rutabaga: Add options to enable virgl and
 venus contexts
Date: Wed,  5 Jun 2024 23:28:30 +0800
Message-ID: <20240605152832.11618-4-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

With this change, people will be able to use parameter like the one
below to add start virglrenderer backed virtio-gpu-rutabaga device:

    -device virtio-vga-rutabaga,venus=on,virgl2=on,wsi=surfaceless

Performance being suboptimal though, this would be the first step.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ecb146315a..85bc33af8c 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1203,6 +1203,10 @@ static Property virtio_gpu_rutabaga_properties[] = {
                       RUTABAGA_CAPSET_GFXSTREAM_GLES, false),
     DEFINE_PROP_BIT64("x-gfxstream-composer", VirtIOGPURutabaga, capset_mask,
                       RUTABAGA_CAPSET_GFXSTREAM_COMPOSER, false),
+    DEFINE_PROP_BIT64("venus", VirtIOGPURutabaga, capset_mask,
+                      RUTABAGA_CAPSET_VENUS, false),
+    DEFINE_PROP_BIT64("virgl2", VirtIOGPURutabaga, capset_mask,
+                      RUTABAGA_CAPSET_VIRGL2, false),
     DEFINE_PROP_STRING("wayland-socket-path", VirtIOGPURutabaga,
                        wayland_socket_path),
     DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
-- 
2.45.0


