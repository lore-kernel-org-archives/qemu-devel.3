Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2B2C25B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfl-0003ZL-96; Sat, 25 May 2024 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfk-0003Z0-Ca
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfi-0004CA-V7
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrQKXlw5u4HCxCSjJA+nYUSNZLIT05jc7Oc0v9l+ebg=;
 b=Re8dPe8RA0wY5z1hiRHWPj2keh5FjxFwIhU1un1NKsiYnoKnklytnQFXraeCF3Vt5fQUHi
 bhAM2ixeFGSVDILMeROVeFEiKNKr7uvD2G1cmSUZ3bcIJCJJnnMTLFZ58XiA+/6vtHVv8p
 7lcVStUHswBIGtfqEygPvZLGJcAj+nE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-niL656yVNuGzITaF6kIOYg-1; Sat, 25 May 2024 07:34:44 -0400
X-MC-Unique: niL656yVNuGzITaF6kIOYg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-522362e8317so3074104e87.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636882; x=1717241682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrQKXlw5u4HCxCSjJA+nYUSNZLIT05jc7Oc0v9l+ebg=;
 b=Cnbz0XtkbGd7pI0FtaEm+z0RWsxpgTojZSnPUHRLa/kXVYQt8WuuAziY2Qjr1CLGQ+
 dGUTjX36RH9gqVRwG03g7ctrJwwslmbo8Kqc1RgQuCEjA3Tdbl/02Zw3kHYa1BmPz/WV
 BkidXgmJnOaqvC8LPnDGVwSau3d48r0PgQ1Sk+EOXTAwnreZNV+N8kg1cQPtN7BXZ/1U
 EbXZQOi0ZNHAwUvpNa90jAHLv35IhaSEVe7ExhluBYawlvBqACkPcLCySUvOFt8mUL3L
 /XzXovShSVCJsGwOwO8POyDmq2KY/fY7wtfDCPGM44gcdeYTevU7MCfPmCzylawWSF6W
 Q3cA==
X-Gm-Message-State: AOJu0YxTue00gRGglnAayg3ZlEOuyWXv9wFHT+0ca5QxEFnkOmskkNg2
 Imo8CiTabw0psdxX0EM65F7X1T3KB62uNwR2xNYFsr0NDzkh5oqe6vP+90TTXbC7ZK4hNvQbX6C
 ddxxjezBAsd13g27PtboW9dVwplc+47BpzkLusIsKlyB3YuN7zl6YKPuivh6n8JmEK93lBTHN6A
 JZVugkxBlngEfDbekL1mh+2JuA6PE9xFlF2q+H
X-Received: by 2002:a05:6512:1390:b0:522:2ada:c02e with SMTP id
 2adb3069b0e04-5296736b884mr5069551e87.53.1716636882676; 
 Sat, 25 May 2024 04:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt4EP4TIrcWGlxlNqFMLceZHzi8A367GmNNHNUXj7kavbelGzdwa1AxqauY98FxX/9OgA6og==
X-Received: by 2002:a05:6512:1390:b0:522:2ada:c02e with SMTP id
 2adb3069b0e04-5296736b884mr5069539e87.53.1716636882226; 
 Sat, 25 May 2024 04:34:42 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c97a1fbsm243946266b.92.2024.05.25.04.34.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] meson: do not query modules before they are processed
Date: Sat, 25 May 2024 13:33:31 +0200
Message-ID: <20240525113332.1404158-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/meson.build b/block/meson.build
index 8993055c75e..158dc3b89db 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -119,7 +119,7 @@ foreach m : [
     module_ss = ss.source_set()
     module_ss.add(when: m[0], if_true: m[2])
     if enable_modules
-      modsrc += module_ss.all_sources()
+      modsrc += m[2]
     endif
     block_modules += {m[1] : module_ss}
   endif
-- 
2.45.1


