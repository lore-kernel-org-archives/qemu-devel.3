Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D72AD3A66D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0z-0008Bh-4a; Tue, 29 Oct 2024 11:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o0F-0005ss-Ok
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o0E-0000Rp-0w
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tajAPxCNAmFaogn2scI69rY3YVc4yfZ9YuXGY2hOlxM=;
 b=ijpqZeZtHOnC3MC8KTeTTLvOwAhokyJSngVFT3I9ItqIcKoNARDMQ876xrPN+Knkf3/2S9
 5mW+S16SgALHES71F9dZ0i+x/PO8eeQJ4OFkemXq4uh+Z6CKe45brISmjUlzFBZUXpFLIe
 /A5yIyNfonymyxNeiwCVR98aYNbCFi8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-JoaMJjvyPz-c7CymS5LfbQ-1; Tue, 29 Oct 2024 11:19:24 -0400
X-MC-Unique: JoaMJjvyPz-c7CymS5LfbQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2fb53ef3524so36757931fa.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215162; x=1730819962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tajAPxCNAmFaogn2scI69rY3YVc4yfZ9YuXGY2hOlxM=;
 b=pHZXKC1sonii0UWX//cczSbCtYqc4YhAisnQdIV04SwJ/15bmFCgG9lEq5nViU7bkW
 TQRqRIOO/PTsSeXaouaG0Up3pfIeTV/qOE/DnG7zQXYBsVed/hPyixcAP5msL842f53s
 2c8MSyMOn7AJZZkORhcdDD3HVBnJGWTSH1TTyzymb6aeBCUTK6Zu4nG0oa0ax9gU+xZb
 DaKAupvLWURQs6TolfQ/NQ7O1XwJ0Co9zJsomsKzSqF5smNwmomUBuhxEem2XgZ3pD+E
 wQWQMeBw+W0vWeuEqn8z8Cj5Q9DDf/wVc5PVeBlE3o3yc8gyfLuEluEYc4B/mdNr6HoW
 DZ5A==
X-Gm-Message-State: AOJu0Yx8oukH2ubJtJfnRxEaWDVmWLeyo+u9SC2ohOI3TxZJ24VvvdAX
 owom7ypltMiE7nFBWttsy85iP0UgZy+YOMRLO++u/HiMo+Mhkb1ehtHNrXx/+UYuAAsoKQ7kaeT
 ElVX5sMMe0MWWbSxw5nYEygjM8yKiu7vNioutBBOOwmG/+mK+tT8Omi2hfp2wZEwDyDDSVdh1Ka
 1i2s2ap/DsIsQLF2Fa8sOBlQknehLE9XDE+Pv01g4=
X-Received: by 2002:a05:6512:3ca1:b0:539:edf4:68b4 with SMTP id
 2adb3069b0e04-53b34a320e7mr4226519e87.57.1730215161597; 
 Tue, 29 Oct 2024 08:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGyxTx3I9tkKqHA4RrmOWySUruGsAGXNqt9IZj0tKMX5ocd+H6dIJU2XAmxFp7+50/PI3Diw==
X-Received: by 2002:a05:6512:3ca1:b0:539:edf4:68b4 with SMTP id
 2adb3069b0e04-53b34a320e7mr4226501e87.57.1730215161109; 
 Tue, 29 Oct 2024 08:19:21 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bac1cfsm12820702f8f.109.2024.10.29.08.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com, zhao1.liu@intel.com, xiaoyao.li@intel.com,
 Xuelian Guo <xuelian.guo@intel.com>
Subject: [PATCH 8/8] target/i386: Introduce GraniteRapids-v2 model
Date: Tue, 29 Oct 2024 16:18:58 +0100
Message-ID: <20241029151858.550269-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

From: Tao Su <tao1.su@linux.intel.com>

Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
tsc-adjust, cldemote, movdiri, movdir64b).

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-7-tao1.su@linux.intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6799ddafa9..c39e0eb924c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4403,6 +4403,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (GraniteRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "avx10", "on" },
+                    { "avx10-128", "on" },
+                    { "avx10-256", "on" },
+                    { "avx10-512", "on" },
+                    { "avx10-version", "1" },
+                    { "stepping", "1" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.47.0


