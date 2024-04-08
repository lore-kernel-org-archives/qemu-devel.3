Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A181FCD1299
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJm-0001Dp-4o; Mon, 08 Apr 2024 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJd-0001BU-AT
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJb-0001mW-C9
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTNCByh+icoanj+/ty2qD1fER7UWLq9kG/8oHf0fqoU=;
 b=C0mV+/DMW9P0L8OhDAOv8zUvF+I4ongeybEDM3/w1RqO0++aJ5HeI9om8GAgBRmlkWJb0K
 Jl2Da63PWgfglasL/d67tN/8GeszoYodJ467YRLRGfa9bsS/1+Q1XaXawpkCQVtQxHDi6/
 cop6EmJTwEvIVHNb2K8m1mSSHZMjvKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-eFI6fQAyM6-WAiDWF3GDXw-1; Mon, 08 Apr 2024 11:53:45 -0400
X-MC-Unique: eFI6fQAyM6-WAiDWF3GDXw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343e74dcf0bso1521176f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591623; x=1713196423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTNCByh+icoanj+/ty2qD1fER7UWLq9kG/8oHf0fqoU=;
 b=jQs083wfqF3GDWhEdqc/5mEFhGiF4gflYLQPbVpVCXtN2RFEJziBavR2aQxxs9Po3c
 Gjm2W4d9RtV92Jx6NCegtpshbbDSRPOP/OsaO0Cn/0SxdfHSqJMV1R/QF4WcxyAGcczz
 Tz0VAxhKzNXCEwMg8oz1uBhAWi7y5uFkvKeY4NmrR6VzS6fZv3paAJElGbKWdEc2p3Oh
 a+uz+8NDY7FXSbx+v3cOzdywZHBFmZdBtoCfpMW/VnUull5rAMwRdzW5fKFhgc1qnhMv
 J0oGMErkDLOisheJ257/WYERaapyEPS6wBViKLe8sh9PDLxqtLAVyZDoyT6gfQWDBxuq
 p4+w==
X-Gm-Message-State: AOJu0YyM/kUL7z9ZBk7QUiPoEv1LYa27txGI67gEGBVz1KZ2LY0gdYri
 dJxr3yuOctqg2MsTU9UmYRX4OudRjSaxnNt783cDaXe/CeY9/S4p+v1wIlv823lX5LsdVIWd6u4
 fXK3hxkZeUxvU6CvPY4LwQgflBToPqykeGpFvlMGZMblp/W+OZigRTDsp/DbikYCjpa9sPNpYqa
 L/jlekacoTssM+rRDs9IBtU/0UOqRNqegH5kU1
X-Received: by 2002:a5d:4d85:0:b0:343:9308:3af8 with SMTP id
 b5-20020a5d4d85000000b0034393083af8mr5502123wru.23.1712591622813; 
 Mon, 08 Apr 2024 08:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqtoNzjTwyLvP2eD4xLvN5YeRpK3Zisnx1xNn7yJnwIBDyveuK8I7fcNFRVCz/jL+AAoMlEQ==
X-Received: by 2002:a5d:4d85:0:b0:343:9308:3af8 with SMTP id
 b5-20020a5d4d85000000b0034393083af8mr5502111wru.23.1712591622420; 
 Mon, 08 Apr 2024 08:53:42 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 c11-20020adffb4b000000b00345bcb4fdb9sm2606101wrs.16.2024.04.08.08.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 03/18] ebpf: Restrict to system emulation
Date: Mon,  8 Apr 2024 17:53:15 +0200
Message-ID: <20240408155330.522792-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

eBPF is not used in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240404194757.9343-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ebpf/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/meson.build b/ebpf/meson.build
index c5bf9295a20..bff6156f518 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+system_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
-- 
2.44.0


