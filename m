Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D0AEE6B6B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAp-00069h-GC; Fri, 06 Feb 2026 17:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAf-00066J-Sx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAe-0007Em-8n
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29f102b013fso12161625ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416363; x=1771021163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PhMuVFYdPnBkd5n0hx4mNEJNR/NbmY6F8F2L8WVLKE=;
 b=gwkGALvSyD4B95gT0P518JMFz83L9S2SJegMnsRu/z/sDhLsgqjRZYNGzfia8DSVLI
 EnbRKK+vq1u2gqBX1G2QM2EN+smaTkfOOQXXrnDhYyMRCwOvzoLkn+nwmv29uLch80o7
 bJ023RcKdKVCpCf2Quzt0mjjjxBCneBgbi5TIDVCKm2cEPMw/6aupYkHNug7JqcxdVAy
 Zyq+/GC8P9Cq0mP8Ps4hPzT9dyu9kciP7KJDafeP9129DNK7skdIcDSvR2ROmtHhq15E
 ZhDPVX9g5M8iK/wJeBHWN8jqhBisrx7v9pdr/vUGMM2FJEm6bhrX4SgT4AvACusBiZtc
 F6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416363; x=1771021163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3PhMuVFYdPnBkd5n0hx4mNEJNR/NbmY6F8F2L8WVLKE=;
 b=vyjTEx1b3uBML9TY9i8qzkZynQVIWRGdR1usmdGTduQzYBd6llq6J1zVkMsPS9g5dW
 K2vPN2UlpK38hkL/sHVHr4LdEIALYh+E7d2WHJe8kWvsd4XvBw+vziWsa9jwfZ+Ql5dg
 ryEIbi9uLZUWHVvXpaAKjBuDKaMoOQZYSrdK3GPFCVf275sdaR374pRNcfevPu4BymY/
 Ml/niDxZbwcOPfhIlyxfSL1bskBc8ye7q7rm9eOxZjSqjBEmA2aiqnzUVD7RfqU8L8D6
 6w/J/WNzA4XS2zbHDjG3mkkTYshxgmgAxp89pLa8Qo64bAPWBbJ0dTRuZGI7xfRZV8Bi
 i82A==
X-Gm-Message-State: AOJu0YzTacYBxm1N5BuVWlo2PH0fu/M3kEEodECzK+1EM5upzmcWJq8H
 kbx+CBnqzaJqFkbwG0lrkDWVGGQO0Pek+POO+k571hNxK0VdcVqcxX/drlG06iucZrYlTwF+Zli
 BxX1d
X-Gm-Gg: AZuq6aIUEQhqviNlA/bGsp/ZrHLvDdpodiTYrWk7n24G4rG8Xj3p+P+jDYV6ImlDCZb
 3SP7RchAfhALgndDD1xWOVjs3g3j1hOfOuU7oEY8cfKXyuNFOci/G36ueXizQ9Jmg6Re1EiHtoN
 rds2MV94y5HWU28BqT7EER/p1efMZ203NQ8GWjPk2cfdn42dGEZudgccbQ9bVoAnknIbnkjuUJA
 fKoPj+aOdJ92EgdLdWeLn0IH7r+P5cJlBiB850lMWuNg/01JubVTZuJtLz4WIf2HCOUVSORzQRW
 zHzg+uGf5ZnxtujdmHbRcfLibDFjy6HJKkz/GpOvjRaOJu5aEyLBQ+g157xyvh7jns8rrnFx/BD
 +sMf/B23SBfY1wqdBqe/o5Ag45HtQdk9j4JccefnVbg9Py/F2PAZKKJ7BKQcv1UiOj5mrrBke1R
 pZnu751smFny6HkbX7i6R7dM81YbyUORQTV0KawxY4xnMbSMhmYPwcuHEQJvEEm7U2
X-Received: by 2002:a17:902:fc4e:b0:2a9:4c2:e47 with SMTP id
 d9443c01a7336-2a9519b5dadmr39036905ad.56.1770416362740; 
 Fri, 06 Feb 2026 14:19:22 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 9/9] hw/virtio/: make all compilation units common
Date: Fri,  6 Feb 2026 14:19:08 -0800
Message-ID: <20260206221908.1451528-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 20356fba812..821366f5e90 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
-specific_virtio_ss = ss.source_set()
-specific_virtio_ss.add(files('virtio.c'))
+system_virtio_ss.add(files('virtio.c'))
 system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
@@ -55,10 +54,10 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
@@ -100,5 +99,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.47.3


