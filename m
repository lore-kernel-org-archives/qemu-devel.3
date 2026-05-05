Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD883CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOr0-0004Xy-22; Tue, 05 May 2026 19:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqy-0004Xp-Aw
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:07:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqw-0002VV-FF
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:07:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645F2KKA4028270
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SNJpllQRnXi5ao/VW+pJCtAEA4zc/CILdZuazKOYkjI=; b=SGhcuivr3QmTfPGY
 +vVj02fik++niKo5uUfRN4dcKbZthVI8SzRqjFh5ILjBwXaWw8p/49czPl09GLNr
 ATBe3ZAAK7YtV/InTRG9zrZLwily4rdxQNyRSzmcUaAY9B5MXi3q1SiCYRScGIWd
 OyBFRJQ9rLzn/PkHWBxeepHuRPKi/CPsnVE4fJox85PRd3sHhcPnllGsUO4GST+1
 SLrJgFAyRhxazUT9HjBCS9ybmQEovTVGA3Q8b7uUen4iktWKfiIJkgHaMh1TjEya
 p/11BLFkKtXISYliJIATJ5cC+FYIeF+WQ4fcNPllN9SkeBSSWQNXQlTfWJhme32k
 w0EjvQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dydm6u5vq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:06:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2eebb099efbso11498943eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022416; x=1778627216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNJpllQRnXi5ao/VW+pJCtAEA4zc/CILdZuazKOYkjI=;
 b=MB1ue63Ya6WXhtl7iL7rapp1iPhCMiX77H4QYT0pbIVqEk7zxqYoNvWyorxyNSXkvd
 An+E3jMj1bwMa9jOqrLOuzvYeNec5IxWqGmMPN+/sRtGtYXAe5u11mX7xp0gb2KzHEKa
 rlTtpMHzQxKQZ7RqIyqinJwlfkSy2Hb5IrbSPxIABKb/g8GIcQeYEeYJTjkq4gspdQzp
 +H21OihqNU17C4aat2ctlAaJ9YNylpBSPMSr1sIDnE6lqur04AHmODIls4YCigN+HeIk
 VWPA9OOKallOACIooFtFYaOwdCvUSTQMcd/tDkcs+9XiE8NUBqzhhcea7Uca2P+p9tFF
 A64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022416; x=1778627216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SNJpllQRnXi5ao/VW+pJCtAEA4zc/CILdZuazKOYkjI=;
 b=QGH+VyJYd/p0Z95MR1j6YmrowmOomg3Tahnwvimm3vXnE1OnNgqnzDibXaW6KYFqIV
 43zlaxFH8NdBwOWciz+R33fZIe5WB9AXc59ScDzZpFTKO8UlR9AyNJDbg4V44rEbYHAj
 VnG2f5qu09dju9DaP55IoJqKQ+THa2cnWIh892GJj5ICSdVMF5CDlo/jS6qMg9gCZ6xX
 XPqlVYaIZBCnU2tWP2qK2+GT7UYNCGMAKkXOXIhGbzQXIxjyupwh3GtBygrTexq92vnp
 X3qfF8FCSv/6ZRRn2+yrResM2yViRg1Iaz8i/Sw9ARm3DrTh2cw2ZTz2lRMi2RffZ2A4
 pBcQ==
X-Gm-Message-State: AOJu0YzNZQIggSaVIa37F5aBUBqpBywEyL5JI1c/gs4cU7pLsYvLzBC2
 Jt0JcEd0oruAmS0oVo0rDAavDFp6AySFCy/vaCB+PDvq3eNaZ3qJ3ItA4zC+sxYkEHPfxy6inOB
 sDFP3pgr0wmrDyqActXDdMEK3Bcr7v+9gVEVCuNEBUDSo1Qp2vfWcuUww/5SiUxMjYNNz
X-Gm-Gg: AeBDievsW8NhRfHoaXLoBuKvEvD4DIBSKSwo08zDr60IOwteE2c3NyDwiY+c+PD7aNc
 jP0+xF4Yda3vxwNgzX+TmSRmABkWQ9sOmVby/t47AYxBDK/5BEzWUVU8cidJxiqhTPp3Vbq9pFS
 7ZAMk0FuPI4kaBiDZlYZzDpgBB0wDMlQp3wYFaEZI/h/lTIXkpzL6L8Y3FZgolVXiEYs8I/+q/1
 VflEqTNhbQqqq7rX8iq1b0or7Mcb+WnMj5PwHCeKWqFZnRk10jwH2UbnC3dJCLUDUH9F2OhzN+7
 ljs8D+jmm01UMirqpCw1mPjlNRBsDeI6z7SDVcBVGsMCKilS/yPBVd9jODZ86n16I4v0qgYverm
 MpX9MzeuA4ASbDeJi+VEwhmAhhCElkC8TTv85+Onapoi1+2vlzJt6cmi2eBe16x5z5pE+WQS47j
 hbqtjpFKkghUAFR7jQ
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-2f54d15fe7amr588026eec.25.1778022415816; 
 Tue, 05 May 2026 16:06:55 -0700 (PDT)
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-2f54d15fe7amr588002eec.25.1778022415075; 
 Tue, 05 May 2026 16:06:55 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57038c644sm911290eec.29.2026.05.05.16.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 16:06:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] target/arm: define stub library
Date: Tue,  5 May 2026 16:06:44 -0700
Message-ID: <20260505230644.2710049-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNSBTYWx0ZWRfXx51Lu+0N4ee/
 5UQh2M9Ba1ra+oOmbUFJ/pBR/BgD6z9LmZD5AfOpw8u2dl0ekpnRU8J+xId05ZxwcmnbBseJbNi
 iPa9EOaur+WHvaSajkGp6ONWYbQJMIFZwAVwyUrn1mtR99Eu0fBxagd/3cZdyYrtr9SqzjceRvn
 jd03zYSCYHj7zOPBOQjQ9u0GnzoC9Lr3BoxDx3gDxaAd+/3iXoSKsk1Z3M8bO7Fe5UrTgodA+YF
 etOutVxjhueDR0gRZF6YBN1cTzLcSyEJyczBYR7tzdX4YkU17GcPCh1iqoRql4hBF74sfvTfYZP
 NoAaT07W2BFz6fwAvjxMGjbBqTygPhLjG3PYx7j10ueHkMHws6PtiBBfA341Ut/4ukbQD5osKRy
 Oebug8BINMLcFSm357jlfG4q5hVvvZEBLYB3yB8h47HIIyY8bL1Ij6hLp5U1frCG5rIoobju+UQ
 a0hM9ZDKUsu/JB1tF9Q==
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa7810 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -Qu7H_cG_NHNYgYfGouz3uVy7EmQ7OSL
X-Proofpoint-ORIG-GUID: -Qu7H_cG_NHNYgYfGouz3uVy7EmQ7OSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We use the mechanic introduced in previous commit to define a arm stubs
library. With this, we are able to eliminate symbol conflicts when
linking arm and aarch64 targets, and get one step closer to having a
single-binary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/meson.build     | 8 +++-----
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 192ac7c31ee..4723f9f170a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss = ss.source_set()
+arm_stubs_ss = ss.source_set()
 arm_user_ss = ss.source_set()
 
 arm_common_system_ss.add(files('gdbstub.c'))
@@ -23,9 +24,7 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c',
-))
+arm_stubs_ss.add(files('cpu32-stubs.c'))
 arm_user_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
@@ -39,8 +38,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
@@ -73,3 +70,4 @@ target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
 target_common_arch += {'arm': arm_common_ss}
 target_common_system_arch += {'arm': arm_common_system_ss}
+target_stubs_arch += {'arm': arm_stubs_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02774409e56..d2364aa39c4 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -28,7 +28,7 @@ translate32_d = [
 ]
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
-arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
+arm_stubs_ss.add(files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.43.0


