Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97430C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbp-0002Z3-NL; Tue, 12 Mar 2024 18:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbc-00020D-4g
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAba-0004X8-Bv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyTDZtJqprCGpfIUlVDmTHoGSmpXfrw9EDci6rQtZxA=;
 b=MEJ/q3U7lbGncX9W1wSzev+wYDKPxCy69epDAOnX8VokizfFNTYtqwKgwcjb4sTeEIpwcP
 2MGU38ZUzHwzpNrotXnSSUsvx7ixpT9D7QQz/peszosXSQM1zyStjAuYcV7qowdJ2vDfkB
 KTWBFsCgcvTfpO4Nn4luTo0jmVpa3no=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-iUMbNeYHOpSVkMigWTgExg-1; Tue, 12 Mar 2024 18:28:16 -0400
X-MC-Unique: iUMbNeYHOpSVkMigWTgExg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51321a5bfadso4755305e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282494; x=1710887294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyTDZtJqprCGpfIUlVDmTHoGSmpXfrw9EDci6rQtZxA=;
 b=lYD+HmCCukaRtLbzRy7FI9UYSe3kVW8Wz/U4MmPghDlVOWeNgijV7m4v5FeyWOFCmV
 /gLRCVdwociA/NkRJe0puL0Xmodykk8onobvF563fGwEM/Z6h7ZagzfNnWv7kq9jhUE/
 cTd5MPxqs13U+yLZr63EIjDNewMnoBygg+amAQtls8vguhv05Bf91LlrANjo5z2TlBJP
 +l608Qox6DjWrAKW33VPwQRUu1kDCUl/mHGL3NLA/up6ADILt5NBFLiePGztSDPsN3ce
 DdWGfo8aNxOn5v4E3x6IMECJDyxvCk+kshUzdC9LgLCTmv3Ih93LrXoeGSTV1CVczeRN
 i0FA==
X-Gm-Message-State: AOJu0YxN4VoTziBKtbDCLp9IDw+nL/9JVaRVXSf94ZGo5h5JeMrBWMwK
 xc0WTqP5uBPZWwQtS6BopmgtZLMEFwBlxJ8sFD/iFi40OVUan2v0NHBgFv1kChBzJogNL1vBOVq
 GCbVIEm2bwFBxJomO4iuDWlsYh+JVVjWOmGTubGapG9K86AsaTDkIbf/HkpjU4K8gt/Ozu9nicA
 Id+kg+7G8+1WTj/eyWGeBoDur2YlLIDp3I
X-Received: by 2002:a19:7716:0:b0:513:c2ad:8b05 with SMTP id
 s22-20020a197716000000b00513c2ad8b05mr1527207lfc.34.1710282494485; 
 Tue, 12 Mar 2024 15:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoT3EBjmE5J0rOuPHNW2bsAhQYWyg6iyV/T/p+/qWFcprUA9KkMDQaABu4OtI5BIzRyKsm9w==
X-Received: by 2002:a19:7716:0:b0:513:c2ad:8b05 with SMTP id
 s22-20020a197716000000b00513c2ad8b05mr1527193lfc.34.1710282494010; 
 Tue, 12 Mar 2024 15:28:14 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 hg13-20020a1709072ccd00b00a45fefe4fc5sm4177062ejc.135.2024.03.12.15.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 50/68] hw/i386/pc: Remove "rtc_state" link again
Message-ID: <6cd2b093e771ee606b4e065f615d9b2fafd76d22.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made linking
the "rtc_state" property unnecessary and removed it. Commit 84e945aad2d0 "vl,
pc: turn -no-fd-bootchk into a machine property" accidently reintroduced the
link. Remove it again since it is not needed.

Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine property"
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240303185332.1408-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 24e8879894..98bcf4d420 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -613,14 +613,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    object_property_add_link(OBJECT(pcms), "rtc_state",
-                             TYPE_ISA_DEVICE,
-                             (Object **)&x86ms->rtc,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
-                             &error_abort);
-
     set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
-- 
MST


