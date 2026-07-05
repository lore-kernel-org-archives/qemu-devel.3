Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65310C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrX-0006LM-3n; Sun, 05 Jul 2026 17:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrV-0006HB-Ay
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrT-00007i-Oo
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665IeDUn2386252
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=; b=fEfG/5W2+T989hVR
 irdD9YWA+rDMF2j/fX73lwTXMaKL23udxkEjTitwjN+nbg71gZYUHUX7WKH9ZBwE
 +mABVwOCd3iRAzWPA5IozJ5E/sWe/MyLEjWguuBgab/9UoCAfMB7Wl0BX93WO95u
 f2lo3BZoXcgWJRKexBBKNM32BScAueJg7YPnSKKI08BMBnBhi9TdUcIrJyHEp3yk
 lcRoIEZzaULIZY3TTA6N6RcRvY9inUcVyf6Z6KQye1kFJkQAFKLJkZ8RdtmwlLRL
 j8tPcMg5JrZSE2jo2L8fzSmdynpokrx4YtJNWuRO4gd2Q38iY++m+XtAL5T4olJf
 64TbSg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnktx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92da6f3cc81so292133385a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288720; x=1783893520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=;
 b=Bz0K04+0GtM+WI3LUewNHC6IXhjNWdg8Bf/RK/ossBiqknHjUi7ML03Fqme2FC6Ar1
 3mQRYTdZtkak0yK5XZR/3UhiwP7i8qVnPqBYEniEex1Mvhn/XFK+9x8v2BY+MQEoykMx
 zbQ2yrKhe9/zZikQzIb7NNZQmnJdbVKfwZGZf0pk+hZJFaBvIEnuXOJB2ZyL1IiBjVa8
 dJlWM7WoNbKVWAS+L854garZzJpXKSwXN7kIghHCyf7r0tMkbaIhJQMPEDffYXY2zSGA
 SzrTwPBotismveCPgkkEVMFrGyzkRPrUH1QJbOKNtsSJYixMYqENK3YmMhIzJ/GGwy1G
 d12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288720; x=1783893520;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2GaQV/oxXfUYvhpcWlYYZ/rgvaJkV4F63rsqq0epSeo=;
 b=kJaf1rAoL2xquOP+sAMlQdCHCtZxxN7bbzXhlhC8YVFlPoj5SrDl0RoLbHhU6kG+8Z
 G3oW8rBUTp/VMYMvh+z1TVuU8xswnJmGqQUgaJwlwJ/WRZP4kHYY3VOXzFWg4echpFUV
 SYcv+3ZNY8SVk3hAPctjYYQr1FnuAbfaG8LvO3ANaNef+nzqEluWVu0GZ88X47js71mo
 XwILGpmXOqPNpR2ADBE340msrAXsixL7Mv5Lh8RHDg47tGybWpX/MyZ7MffgwwvK43Y1
 BoxPcErMyAQqO734ZmrYXcClPkxaK65qC4YCbp5M93fpRVN59ln7YJXtp3yJN3iz860j
 tRCg==
X-Gm-Message-State: AOJu0YwHG9tirqWR8U3pZxGLd7lvh+033e0g9Y5CwbeJOYJzzadwMPH6
 gdX1E8JRQJ6jVS9IxswhCg/wDbCBPBLFvQzfK2UgrNWZX+K/14CoxVB7yZeOVAp2/2LWumLxVle
 D4bUi0O+Qd/g2P5azkHb7mIggeaij1OLDUvA5+2xXYFLoRRgOtuT6fjkkL7hMr/0hEg==
X-Gm-Gg: AfdE7cnBFkj0zZ1s/4VA9+/ekw/fZlKStySRex5eoPU9VXb7ZBb0BEaIEe0pZL7q01C
 fQpiKQ2gEyrj2QMKRVNoBzKEY5a1r6+ZnVE2o737Ek+RWhI8XFga7NZpIdP4eVDG6HLEr9mbCD2
 mMSsZ2wd3Qenl5Sc6u4dWSAkTxlkOtEHGnsEfUlWEvoRaSlENRDu0xleU/p4i9cIpFpXAx1REnj
 HU3bg8REE2VFksdBq5VUFeEyGvhYCeewq25b6tQwoaNccbJIf96fsjCH4yulfGk+XtQz+DxuVtM
 LDA0uws28Z/Tsci6K25MqmJjObrtOrCC1xw0i8N3wtKhpQlsYQZZBQAbR8UgR1+1skDxuoDZTnj
 X9R5RVZpNTVD5sTHcpFkFUzZbcCSwC3WiaIIfHk+LTHsYCDJV4vcn/A==
X-Received: by 2002:a05:620a:3189:b0:90d:c28d:9666 with SMTP id
 af79cd13be357-92e9a3d8c5amr1003639085a.30.1783288720267; 
 Sun, 05 Jul 2026 14:58:40 -0700 (PDT)
X-Received: by 2002:a05:620a:3189:b0:90d:c28d:9666 with SMTP id
 af79cd13be357-92e9a3d8c5amr1003637385a.30.1783288719844; 
 Sun, 05 Jul 2026 14:58:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm18975192f8f.15.2026.07.05.14.58.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 09/32] accel/kvm: Always define
 AccelOpsClass::supports_guest_debug
Date: Sun,  5 Jul 2026 23:57:05 +0200
Message-ID: <20260705215729.62196-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX+WTXrjTQyazt
 jFeBOz80xx6aWkBv+2YzyqAIfRaOrjQ0oO/OuVGeaa4jnJr6PEfMT80f9Sdt2IFumop43m9A8vY
 7FLhPv9aktWQy4l8k2q8EfoC3yoE+w8=
X-Proofpoint-ORIG-GUID: 8o121k7pKOkk3KCZpzDJSoo-aQAv8wuO
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4ad390 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j4hjfWolugK9Oy_fDxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX7DAyAl8TAltp
 OguC3VJZCa0j5mUOmReMDxthI4hciWrvxDR+1bMxIhWJ0qRZSTBwUnXHbhFLJXm9F2p48XDmHsa
 PmLICZLOZo+uwcFrNCbQw7PMGBSLhcbiHXqG+DNsWj/Jb7GGfUFC96zycEpNF270/7F39Oqvytk
 zkQSQ2fD73G7PuvHIowkcPUJVMH9QcHncmx5voUWMZ/MGIajA3yOggLY1GGptPMCI3UqCltWeyb
 m6sbpISdT+t5e5d2c5MCprdFLSXZ8e1uh43jU9eLRoM3Xl08z74I2J1F5MqF9QEzsu91B/8EpX4
 j4Kvkehl9sQxsEjUKLXVlr29HVYJMwjd/tVfkO3Rx2pxTfgmiVdldTu4BFQcxCQtOatjO63yXKY
 k20woSCejw3FPVQftTvEq+89a4Q6x6wi9/yXmQC+31FVeynO62DwR2pkNmsEdv6SBHLNTEq2Cpn
 TS9/aLyowip8RatuLLg==
X-Proofpoint-GUID: 8o121k7pKOkk3KCZpzDJSoo-aQAv8wuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Whether TARGET_KVM_HAVE_GUEST_DEBUG is defined or not,
kvm_supports_guest_debug() still exists and can be called.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549f..d7967bc922f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,9 +105,9 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
-- 
2.53.0


