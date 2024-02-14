Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1661EC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDm-00013W-LB; Wed, 14 Feb 2024 06:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDl-0000tz-11
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDi-0006r5-Ug
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFQEyso13LWrBynJ1cCVjL6Hf/e/37ToPaPEgRO7pkw=;
 b=Pkr/mu42Q5Cx3gsJNIWpSujZOv9aWJ5IIiZskHZ5TC8MaW21bgZMOREeygxm9I5LU8bdaA
 //MW9z8zt0BNKKc2kUSYBWVhOm24MXgOq6aRy9o4V02XjHqEa8RUN4Xu9TnYUlEaX5iudZ
 QUMqZqhG1+27cWYhQcX98vsSu91AqV0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-w1ovtsMUOm6X3L-NoVDC0g-1; Wed, 14 Feb 2024 06:14:26 -0500
X-MC-Unique: w1ovtsMUOm6X3L-NoVDC0g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so4618082a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909264; x=1708514064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFQEyso13LWrBynJ1cCVjL6Hf/e/37ToPaPEgRO7pkw=;
 b=CG6F5bd8Wr4gc1Xxe9fT+n+ur9F2TBPNvkMP6RmfiVHZ8Bzw/ThrgRUmOF/pYey6KR
 t+xPDpHCAKnrTAoE1IdQfveMfSU+TrxRqpXY7GpjpKXxB9Ef1N4J5SQyaqBCcz6RbVdL
 32+Uaqa/WSWESzcz8tOEfIuCo6LCYd+CETpd0T+b9xe2YUQ+8lPY/YCVlVV9q+MB4ITG
 5sHWMSe3cPu8fLQCvn62A2JtEi3mCxa/TNXyOY2cKDGgLSWi3yrpqaga3atcVIm+dgD0
 N+rvdh4PLmOJg7urSPd117HdLDeN3Rt3Gbtt6YGKRAbDq4Jj+pEOMXYsjK9L8rsnIAY4
 Eu4g==
X-Gm-Message-State: AOJu0Yw0nRuWCrI6pTt5sgmvkqXJ0uv8mtneidwg/hwI3sevwl9eU726
 wul3Ir/MGhApHTSkvRoHqImtLtypRDJZ5Bz3bVJFCmr+QHW8qRqLwBQZGaoFuVXBUYXRKor0M+y
 Er6W8XN1/R+q5j4sIot5B5Ikt6eWpJCSnA+roWX6IBsn+n3CvM63FpjDkXbG0PITkGTRcIsD1Lh
 SInkm2NWMRPdMRsXkxjIfs/p3SpkuJmw==
X-Received: by 2002:a05:6402:2033:b0:561:f210:d554 with SMTP id
 ay19-20020a056402203300b00561f210d554mr1746402edb.13.1707909264741; 
 Wed, 14 Feb 2024 03:14:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQASElPsopC+mWIEzciTQXR11ucVCBFKDWvpt8wwlfJzAKPSZyr7nKOeSTaRtYkqGm9Ur96A==
X-Received: by 2002:a05:6402:2033:b0:561:f210:d554 with SMTP id
 ay19-20020a056402203300b00561f210d554mr1746385edb.13.1707909264451; 
 Wed, 14 Feb 2024 03:14:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUDisr4sOr/iP5asScZ8RxIFXIXVv2oX4Vd3d6hLiO9sinqRdb0HR+cITYXIqxbUDm13lw+M588wuPtDtkg+/Jt6RGQsshfpvQTWQTXE9HNwO2HcDYLoLEg2CE0Yy0mkZ4UAaVV3qwZdiaNqPksBw==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 dc11-20020a056402310b00b005613cbbdb81sm4592125edb.80.2024.02.14.03.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:23 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 21/60] target/i386/cpu: Fix typo in comment
Message-ID: <f70c1c068dbe5bb17f34c8b9c2195cd7f707f07e.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240106132546.21248-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2126b0e589..0cd32a6fce 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2179,7 +2179,7 @@ static const CPUCaches epyc_genoa_cache_info = {
  *  Conceal VM entries from PT
  *  Enable ENCLS exiting
  *  Mode-based execute control (XS/XU)
- s  TSC scaling (Skylake Server and newer)
+ *  TSC scaling (Skylake Server and newer)
  *  GPA translation for PT (IceLake and newer)
  *  User wait and pause
  *  ENCLV exiting
-- 
MST


