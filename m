Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07D4C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ykl-0000ns-6W; Thu, 02 May 2024 11:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykg-0000lE-Qi
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykf-0002KE-1l
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JVdQU2On7eQIfBAxvT9sPTYf2xDe1Uz1VwgTnnR8yk=;
 b=GCtc8heakuG4g2pQyF2sfYh109p7AwIhB89Iw83EUf4rib9SR60sGs9ueDcOUX9IYSU1+h
 W83g9gKfdYRct61fAz9DfCpdd+gQwrSAnepCpzca3y5is6tYhVX7MouTOHpLTw91WxOkJD
 SlZS/ppwX6UDJecSag+rN1cpnb7Zyhg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-hh_5UNoVMRy-Pzd5RTdNjQ-1; Thu, 02 May 2024 11:53:38 -0400
X-MC-Unique: hh_5UNoVMRy-Pzd5RTdNjQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2dfc1e7ac17so53390431fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665216; x=1715270016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JVdQU2On7eQIfBAxvT9sPTYf2xDe1Uz1VwgTnnR8yk=;
 b=XkQTRF+7KMgvoRvoa+tFy/VuPT+yDh9EosZDYpxYk7fU7gOAbCP4Igrd4nXx1btvR3
 bonX4aV3A3dTjOcZj13FA1H/ypeFfFT/Wzk12DEltfytxhls6XQ16A9XtCLmqxOEHcCB
 uYfhHpLhX+5fR5uI3ETGUIewOvCyV2nvOSxjLxnNTGd9zwgcpjhHIsnYcoYFT0X01wpy
 Bjed0u6InhJC5ao6GRKhPQtQA5C6xzLV/LNoFB/7EMpIq10N90VUE5KnT/TDgLWZob5m
 ud6vqq/gktlrRkOZqS2SDFPNgPMw4DWVIL93ouCP0yFFrUd04yZBSRkHKNxJhHcMw1x8
 72pA==
X-Gm-Message-State: AOJu0YydGAblioxX2HUX8WeHwhXA/ls94FAd2Y7lZp4rupjKtNsmrVlU
 zPHQQZEaA/hghizJ8OKa2H0jC6g0Irv7t8vrTc+vspZK/euC2IxsVbWd+xH025pYgD2KgVM+0GY
 6AzlprbzPjEa4t04UdaHuuo7tF042jRBhcdr3B/6i6mbQNuXRaO36+sTfFoHNxEchS4O1wvbvt4
 BDlEqVSl4bOlX310TeYyRJvoa0EARHI3vnfuP3
X-Received: by 2002:a2e:96c3:0:b0:2d6:c749:17bc with SMTP id
 d3-20020a2e96c3000000b002d6c74917bcmr133634ljj.31.1714665216557; 
 Thu, 02 May 2024 08:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAf/iclQ/L9YLGfbuEt42OL8kUv1omuj4y/Kk3M9JZdxIlifavoKYPGhcfdstO7xgos294lQ==
X-Received: by 2002:a2e:96c3:0:b0:2d6:c749:17bc with SMTP id
 d3-20020a2e96c3000000b002d6c74917bcmr133601ljj.31.1714665215982; 
 Thu, 02 May 2024 08:53:35 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 lc2-20020a170906dfe200b00a4e253c8735sm699808ejc.52.2024.05.02.08.53.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] fw_cfg: remove useless declarations from typedefs.h
Date: Thu,  2 May 2024 17:53:19 +0200
Message-ID: <20240502155331.109297-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only FWCfgState is used as part of APIs such as acpi_ghes_add_fw_cfg.
Everything else need not be in typedefs.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nvram/fw_cfg.h | 2 ++
 include/qemu/typedefs.h   | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index c1f81a5f13a..d173998803c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -59,6 +59,8 @@ typedef struct fw_cfg_dma_access FWCfgDmaAccess;
 typedef void (*FWCfgCallback)(void *opaque);
 typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t len);
 
+typedef struct FWCfgEntry FWCfgEntry;
+
 struct FWCfgState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 50c277cf0b4..949d3e1daf9 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -56,9 +56,6 @@ typedef struct DumpState DumpState;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
-typedef struct FWCfgEntry FWCfgEntry;
-typedef struct FWCfgIoState FWCfgIoState;
-typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
 typedef struct GraphicHwOps GraphicHwOps;
 typedef struct HostMemoryBackend HostMemoryBackend;
-- 
2.44.0


