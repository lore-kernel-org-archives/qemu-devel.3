Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7859DC369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WdN-0000n0-MZ; Wed, 23 Apr 2025 05:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcY-00067s-HS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcW-0008Qr-Q5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmobFSwgBsGTF71H6VlgeIk1EPRrAOPWyCD0xOhpIfE=;
 b=Gmgx+nGcK7otAE3EUn7S4yIDGKFEA51sKjo0084yIrdB8NcGWCXfIfc751hpG+Trnal3Kx
 1+qXcT6Ph4eOBvKLyjJBpf+Ww5/OxlvV9PAkcq628H0cyKOVaNIZF56g0/m01lN/Wat0sF
 H7tUG+vCk3xdwqkca59YzaPuNuwP8+A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-6_8n8tX5PpqTX2krPgYPDw-1; Wed, 23 Apr 2025 05:42:17 -0400
X-MC-Unique: 6_8n8tX5PpqTX2krPgYPDw-1
X-Mimecast-MFC-AGG-ID: 6_8n8tX5PpqTX2krPgYPDw_1745401337
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac2db121f95so459081666b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401336; x=1746006136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmobFSwgBsGTF71H6VlgeIk1EPRrAOPWyCD0xOhpIfE=;
 b=r0arO/JN06Wx5U2lNM3xdzCIDB9DRSfHRvzfyp4E5tf8teQYJMy2cBwWv6AvevA/H8
 oHiScm+B8NZpyhp3CJGHZlbAArHV54hr+dS6Dw4t8FIS10db6itVSrv74PQyf8qhkRJ9
 u1oiLu4EmkLyNDvNxAOLbTew0c7Xn3OJPm5dynuJ0tNQe6LlhBcjY47Bap8wmEs3fr1d
 Dq7DsqgE24gdeLsxUDPZ5PfoQJe8IJak+BAzStjSYp7GpLkqGlFzcu5x246EQWtJB73m
 z+AUY2zNLY/pTERRHi7r68FUlUord7DV62Tb37SKaZfQLpByQYjSSDISqZlIIq1170mb
 3xJQ==
X-Gm-Message-State: AOJu0YzFWWdXuDwCv/NcXCYJhnzOlD49G1APBpuq408LvB2/W6z5LCYM
 tB6DKrw/pgQ8C7L7istLijp0YYaAneNsL3Vrs4s/eE/606XlS2UJZgBsHu4REaSKnE3nH41yim2
 1IxellY0D/SswoTvh4lr1A0/KyhcEwf+bNwl/KmggKLsO3XCMF8H1gG1G2RmNLMlf6ID1ttiCpw
 dRxqEcmpgkgFlOraPut8mEm4P/Kt6GTAorcabQ
X-Gm-Gg: ASbGncs7435RKD3nIZVMcV3uG9M1iMmmWtYgzqupILE3P0xbczeEgW+/IJuuSFuZk6I
 YzaTr1BZY3R4lYuT77YFyvbGsGBpktT239Qsm73rxb+xpddbw27SSF7HMSfy5Qk9D4uk9vNKu59
 QpNK5mzmfirDXp4VHBNsU74JvzVr6NQ6+pMjA05ReDNYXBFOdY3sQJXbXHGaXJokcZCqvvwVGkI
 gLgwrHZe6MYlUb731D8KhDyXrbPF+97eQT3xG1EnJFbqgFEg4C/8ykXM/CCppXerI3xCom3W2o/
 8bgFXhRjSCS2WMz+
X-Received: by 2002:a17:907:7e92:b0:ac8:1efc:b993 with SMTP id
 a640c23a62f3a-acb74db4170mr1505411066b.44.1745401336351; 
 Wed, 23 Apr 2025 02:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERnN2MnBtMyISDHPQVZMUYVZtjUh2vVCC9+ZpcxDr3CoPLqu3+Bra5KmyEI3y9FLeQb4h5MQ==
X-Received: by 2002:a17:907:7e92:b0:ac8:1efc:b993 with SMTP id
 a640c23a62f3a-acb74db4170mr1505409466b.44.1745401335971; 
 Wed, 23 Apr 2025 02:42:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefcf4fsm786678166b.109.2025.04.23.02.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/34] rust/hpet: Fix a clippy error
Date: Wed, 23 Apr 2025 11:41:01 +0200
Message-ID: <20250423094105.40692-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Carge clippy complained about:

error: casts from `u8` to `u32` can be expressed infallibly using `From`

So use `From` to convert `u8` to `u32`.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index dc8a23f29d9..cbd2ed4f6bf 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -353,7 +353,7 @@ fn update_irq(&mut self, set: bool) {
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
         self.get_state()
-            .update_int_status(self.index as u32, set && self.is_int_level_triggered());
+            .update_int_status(self.index.into(), set && self.is_int_level_triggered());
         self.set_irq(set);
     }
 
-- 
2.49.0


