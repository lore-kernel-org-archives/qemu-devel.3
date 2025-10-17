Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE308CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXq-000051-LL; Fri, 17 Oct 2025 09:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXo-0008Vx-G8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXe-0007zF-So
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so18336715e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707841; x=1761312641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oSlSkkaci0cDEla6T9S3uxoHgo6il6hIdW4S6lyOEs=;
 b=yUDvqnbNPPSuJWLXKmYkBctDuyqFfzUmPei0fMXox55RsmQLW6VmYRpmkb4FhBGADY
 rl22FIAOZsinRikjQGwB3GzcTvpbhXtYyuqIAQ0qO8f2a5j6OnDdI3ur4PKtAvoKAJYU
 8uj1hatoXx6aa9hgtJ5ubxfQPPhQLe+wP6DxgirsBMlzrq5J9GRnv8gzhFxqwBmyK51I
 BFR2wjyKBEcSwDdiV27llXRw7uHaBQ32PspZmriP3HS7S13HPVxEww/a0lSdq1rqpZMc
 UTePRyh+jcdmXoqNz/1wHF5/ncIQRPc5N/oETDetn4EdNHtdWnVYLw8VGVcGs4dxmAa4
 zGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707841; x=1761312641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oSlSkkaci0cDEla6T9S3uxoHgo6il6hIdW4S6lyOEs=;
 b=cUHFrZpYAAcRR97f71S2iwbTSBzM+JENcROPp/9Vi+AIqeqbuvpDSK8HFXW1UBvyEA
 C9NsmH3BlJAAFVC0KTK9fPX5po1pFih2yfBUvfUt9K7ku3LZRDYvZ7ZRaYT32YtPRU4O
 0A6NK5L1SsvZ5CfS+cTRWvlc+6Otxzkq1KOpytJDl1SH0nxUVmSIoefHK68gf8j1PChS
 lLK7kifLIJ4ul6ZdtznTTH3LUkyP7TDH2SnFIENNSQPnjqcOkcVCvh74lYENvnrhu3qQ
 tHbdkYB9Vz3JfoaIz2koK8CJ1CX3vO6IVpnRoTo1z548KrPajdoXQ3JsrgmVyks7fBt1
 57RA==
X-Gm-Message-State: AOJu0YwI4AcptH51D87ky7G3Zxc1CMPh4ZSJFa69RPx9XDHzlvrS3MMO
 aiXP8OGYRr0T8nHxzJnxtJXjLXZ1Emjtr1nl5YKQ/8GwWOChwN6++qas7SBSNVjsL3Z6lkjk7TV
 SF76az1I=
X-Gm-Gg: ASbGncs6210psiQRcNZqsrehGpIpx7aRl/2ZNUxg01IG3thwmw52p2iO1xOuoCO1hsS
 yiDhcQHwk965cQKOhmaN21Pg/nOVZv1FecHFrP8ayu0yrcGhtXw25bMGi548phQCv6rkWy+1tPf
 6XA7EO2lD3FnekebVASZTIEtJtUYa/ay3Z4UUxF2LIBFy3d841UCzNrvJv93hMy0kot2S/1ISg4
 DBfHc6ooNl3ASQPISLOKmwZaP8OnyFovi9Bivlm/GSCP5T8zIUbAlm+vaf2NMzoeOwnELVCL6ou
 MrcC3RS0x455PvpPqZu9oA/gy1nsr3WEuKfgh4fiCr/B0e89URrk3MNN7nacT3MCyhT+F+S6Kuc
 ezqbqsLxHRJ+X6Rc768ou2k1nRqtdiF2lsmdpuJscMdK0qcCDt9PsBPpCLRuH8vYKqE0tc7pAuz
 H6Scm3MtfMGkLEYaduKPIs7Ns/SQBcKGG7jHfg0j6AuPGKG6R8aQ==
X-Google-Smtp-Source: AGHT+IEkkLvAqtHe8qtdj1P5F3GrQWdzwWaeQ3zLRK605InUEYbfo9L7OHOpz0LUXmEvR1OyUM3VHg==
X-Received: by 2002:a05:600c:8b66:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-471179120ccmr28337195e9.23.1760707841511; 
 Fri, 17 Oct 2025 06:30:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca243a3sm47748345e9.0.2025.10.17.06.30.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.1
 machine
Date: Fri, 17 Oct 2025 15:29:56 +0200
Message-ID: <20251017133002.61410-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 46dcabe6ad1..a22d1fbef36 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1076,24 +1076,6 @@ static void ccw_machine_6_2_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(6, 2);
 
-static void ccw_machine_6_1_instance_options(MachineState *machine)
-{
-    ccw_machine_6_2_instance_options(machine);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_NNPA);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_BEAR_ENH);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_RDP);
-    s390_cpudef_featoff_greater(16, 1, S390_FEAT_PAI);
-}
-
-static void ccw_machine_6_1_class_options(MachineClass *mc)
-{
-    ccw_machine_6_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
-    mc->smp_props.prefer_sockets = true;
-}
-DEFINE_CCW_MACHINE(6, 1);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


