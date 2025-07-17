Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B5C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTm2-0004za-UE; Thu, 17 Jul 2025 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8q-0002vf-I5
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8m-0002H0-0h
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WlmBVN2Qucvf1vEE6nWUJB/kVdkIb8dEtL75AIz63Q=;
 b=b9txktO4eqxMC+n/D2BEqsVDuALNgdU+/NlvsfA2S22Pz1ti+rAv2GsM+IibCa4N/c2OJi
 /B1vHwR3hjlDef+EsPqwSqnvtYqdMaxlzTMcUTpocJw5uXrCo8G9mJiFqDuWOvxNVvzY72
 3dRK3XI0N6vyOg432pk8HEjNEYLF3gg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Guis2k6PNiOkOHCqnV-xXw-1; Thu, 17 Jul 2025 12:07:15 -0400
X-MC-Unique: Guis2k6PNiOkOHCqnV-xXw-1
X-Mimecast-MFC-AGG-ID: Guis2k6PNiOkOHCqnV-xXw_1752768434
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so746676f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768433; x=1753373233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WlmBVN2Qucvf1vEE6nWUJB/kVdkIb8dEtL75AIz63Q=;
 b=ONmee9AnXPgxNi4zDPCzUyHx+6rFZIWExLsA4VvWulyhZBmogt8nOHZCiijYeytlD8
 lLpCblW1GtunjfjGED4IaqKmyR53lCoi2zlunWBSyrc5X6+PG1oR3tWNU8pjr3TZr11m
 GqBKuTyPQZAregUCbf4UdRVZJWrtP6Za2Vpgs5XGWe12s1Viu2lTR9IgbSWPzQVP11Vl
 wgdiBXcqFubZXRGFckl4sJQT+O2sekSnHSM1qkd1GHC9Ws7p4gjZsGADV/HMd8hREN5/
 KPENucsbgNnfjQ5JWmiQhHWSvF5lJAwYMP0ersxQwtJdgV0FQzvHvvwsY6q6qv0Sfnfm
 Dllw==
X-Gm-Message-State: AOJu0Yx7MQGnHPRYRF5cEDl74so/vaeL6vPl708TRbzA1hPWvsITdz6L
 uzhLLsyBuRC5LeRpL1bKLtA2RcoJszpfikfEniTq8wi0j6swtLYExzUDM8UcKk1qV6YgTOIwbx1
 lyL4eirIqqlnwXID1kOjezvJpFAiELBO6N5Qey91hwSMczmfN5LZrn59hEnXTjdOBKtvrf2RxAu
 plLDR8OaB7uN53tRMO9evFQFatR+coryEdkMv36aRK
X-Gm-Gg: ASbGncu1SaTh57OaqUUh+hXJBgoAuD1i48LrfbB0kbmVJz1/b0NTggeiMAWSvOxxOgx
 3QvteypHMjIvShIA20hPGPf+y05egCrDpcjgLrDt8i1kT88x8l3hzFISj3G9fA5oIjLwmbl3VGZ
 MZD6ndC7Y3iZBnoJsy/y2UwFBQt4gwKXNQpTm46TtZqqNdv0lt4NYEhpidTguXzNmNhXPvuHcu0
 egmBBZb2kV3UM4zSbGxXOw62Ru/oGSc37b+6jDln3QPrRHGBRGPPEDvQKBOGV1gAgfSHQPWgeNz
 HG92AlYwswsPGGUT3wt6t0FsMhR7416uTlkdnIy4C4s=
X-Received: by 2002:a05:6000:3cf:b0:3a6:d95c:5db with SMTP id
 ffacd0b85a97d-3b60e4cb61emr5917227f8f.26.1752768433401; 
 Thu, 17 Jul 2025 09:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBxF7NwvzEYIrMWoobfi+hBkxyhSRo1CYY1NScwW7whzUJBhehuib06kZ4TbSr/Rt6p3o7zQ==
X-Received: by 2002:a05:6000:3cf:b0:3a6:d95c:5db with SMTP id
 ffacd0b85a97d-3b60e4cb61emr5917178f8f.26.1752768432823; 
 Thu, 17 Jul 2025 09:07:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc22a8sm21537275f8f.34.2025.07.17.09.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 5/6] i386/cpu: Cleanup host_cpu_max_instance_init()
Date: Thu, 17 Jul 2025 18:06:59 +0200
Message-ID: <20250717160700.357384-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The implementation of host_cpu_max_instance_init() was merged into
host_cpu_instance_init() by commit 29f1ba338baf ("target/i386: merge
host_cpu_instance_init() and host_cpu_max_instance_init()"), while the
declaration of it remains in host-cpu.h.

Clean it up.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250716063117.602050-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 10df4b3a3a7..ee653242254 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -12,7 +12,6 @@
 
 uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
-void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
 void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
-- 
2.50.1


