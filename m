Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8528CD6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7l-0001zE-Mf; Wed, 20 Nov 2024 02:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7k-0001yr-If
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7i-00080s-UV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QhVwK8/JBtJbmVWE6jCktqNly/2uKTJAV30daTqWZY=;
 b=LMhAn6S1gjQqSJJs/SYFWQot926M4GJsIM53goZzaeHr64DRpKVE5q2TitaLVXfvbherUl
 Je+1KpKzRpIyqB1i/SUm17q/IcNJP7uJ/E2w8tT08qBr3Wc3TRrYZhqDbZS6/oIyWLAY1+
 OuR4ZDyQTFcJmq3o+3TXyulD8zvUcmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-VdPXurZlMkWHAbva8vSVeQ-1; Wed, 20 Nov 2024 02:27:34 -0500
X-MC-Unique: VdPXurZlMkWHAbva8vSVeQ-1
X-Mimecast-MFC-AGG-ID: VdPXurZlMkWHAbva8vSVeQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso38319965e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087653; x=1732692453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QhVwK8/JBtJbmVWE6jCktqNly/2uKTJAV30daTqWZY=;
 b=lN9QQqn3H5IWrRCcoXh7BWt+WxVXzyKvpLxvYU5Du9bvFvE2kCZZHYzR8r+Eyy+DAS
 HAEbH1F8BUo9TYFLPzWLi/v4ouPQvGjZPvFymiwXyPn217TNllNUe5AWdjZLyVJJ3NcL
 uOxkaKInQDfsQQvYeKVa5KOaLMYL7W6TYs86pTnDgOXVgSZ3HDlwqaTQe+jqkbKSibag
 hDwq/3keRjXC+Z8pA/nSnu0xqmigbL/515LMosjwRKxfp/fz8nklVEesIo51XSNkyjn5
 C/hW8Lu2usKdR/F+FNqVuRS4WLoXa7xLv3+uhbh2LI6rTzpSTk5ZFxvRxAnb2tnmyiYp
 obSg==
X-Gm-Message-State: AOJu0YzJssqtRLGXKxSRMsizDurpcXVi5GnPUSpmIz4SMw4Zxf3gU4Mf
 wczrU+e0/5qah2FE0bo+lOdXJuFyp8mExaYlehnspWT1SXgy+jLUwkSLAlOx5rgt890gddK9t+h
 ssDaxT46ht9q0iPstLxTkIxkCX4TZEommS8uaWh7hfaY/toDUKE2Z1Ua0xi3c/KE4ah2upLioyc
 zjwEX5g5BlwA5Z7j+8jvlI0PCDe8+sqxM+0Nzz
X-Received: by 2002:a05:600c:3b12:b0:431:4b88:d407 with SMTP id
 5b1f17b1804b1-433489819c0mr15946545e9.5.1732087652784; 
 Tue, 19 Nov 2024 23:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4giHHmLrdNjug2Oj7rqWbaNUbzwk1D+IJsuCrjfhCkw+AxKYpWsbP0ddsAWwwEPB5YUuvcA==
X-Received: by 2002:a05:600c:3b12:b0:431:4b88:d407 with SMTP id
 5b1f17b1804b1-433489819c0mr15946385e9.5.1732087652368; 
 Tue, 19 Nov 2024 23:27:32 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46021e6sm9029675e9.17.2024.11.19.23.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] hw/core/machine-smp: Initialize caches_bitmap before
 reading
Date: Wed, 20 Nov 2024 08:27:21 +0100
Message-ID: <20241120072723.103477-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
References: <20241120072723.103477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The caches_bitmap is defined in machine_parse_smp_cache(), but it was
not initialized.

Initialize caches_bitmap by clearing all its bits to zero.

Resolves: Coverity CID 1565389
Fixes: 4e88e7e3403d ("qapi/qom: Define cache enumeration and properties for machine")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20241110150901.130647-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine-smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 640b2114b42..b87637c78f6 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -290,6 +290,7 @@ bool machine_parse_smp_cache(MachineState *ms,
     const SmpCachePropertiesList *node;
     DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
 
+    bitmap_zero(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
     for (node = caches; node; node = node->next) {
         /* Prohibit users from repeating settings. */
         if (test_bit(node->value->cache, caches_bitmap)) {
-- 
2.47.0


