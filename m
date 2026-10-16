Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA19ACCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGn-0002u3-8e; Fri, 16 Oct 2026 19:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGk-0002so-5X
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGi-0001Ry-7L
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNF68k2164588
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vkhIYyllJe4
 IgoATCTRxOXy8TRvNQr72Y0KFcr4Bq2M=; b=glX76pqQhz/53lkjj8pDDr4RtzO
 n5KHMwO4zUbU+HfeP0Vwa6E7i74tDv8JyAOY8P/wzgt3aFuM8O9qER/RsxKVqghg
 kKx9KZYhWvr3jdrbk3R4rdTzeD0vWyWQSkDRvJDei4eDl/Te1dbzh4iXfJYLzWi4
 svQzJFJss0zRfu0hCcL36H8b9gjConHq4mrfF5EmzZH9uouJldzzzZi+ZwwPO13i
 jtcyKRv85lRd7vCv2V+SDmowUO2VcQ2xbMMIun+tlOx/mCuFDfnTmECwFXcPIOPD
 iRlYBcFR1akloFHkAbAgmY6PjvAGExFfwSYC7fVf7ZZ/ZAN2GyDpXMeAWIg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjtc3gh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so407722a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192998; x=1792797798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkhIYyllJe4IgoATCTRxOXy8TRvNQr72Y0KFcr4Bq2M=;
 b=YKiCqo53DohN1pZ7R27EuH339e6pACiHck1PHr57DaoqQHM9qdHWs0ou7N4noyuwI3
 5G8Y8hYOEUaLX1U5JcxsdVK343pWmtSaZDX5Dp+zPHY3WtJszF94ZGOYOxIJQWNBZd53
 i5xPCKPzjWpdsNy69hrczhOMWX/KKzQ35U2GETEqVxcgSLtLxWKc01KAul451irjSvE9
 FIfvIZF/IxZYb5/YXaHD0sHPgyhsBKw6cKl+w0xg+4/LO+z/U7a7q/sCTJoR6dkxPvan
 YDnqRZblxiS4IRv8TxTR88aWCQ80ZDHZUGxeAMutwIg/sKDOG4dlSlbstIlYBN12H2Ep
 NmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192998; x=1792797798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vkhIYyllJe4IgoATCTRxOXy8TRvNQr72Y0KFcr4Bq2M=;
 b=cHpy5WhlFQ+Xp0aBPL1uclWy9EShHoOX7X0XSowsfRq2J6jB0v3dgRG0TElHqq4im5
 6+H0KR9tDOohIp2klbo21OlMaGpqIKFAuk8cG8XUOBtA8klOCiUy6ENTZktIY3uQJbrh
 7NL/kq817Kq5LZxqGfcYsrjvrV2rU6VmS/yYaEUcMYbTf6ccVRihMokA2a0iC70EpnZL
 uW4+Z8M8PaJrmKOpBdEY34doajrrwVX3vZp3IheAX6qDX4FnCQyk9LLoOKpgCuZR5kO7
 gfRkHOYVlWSk9GJUgmZaHKSZKTmTwqqmuuQM6f2P62wtHUaHUpbbUkTKUjVifihbdY2b
 3jNA==
X-Gm-Message-State: AFq9FYLsXnwFOVW18rqDOl+KSsSzG59ksVIf7tqCaW+TyZu885kAy7Bf
 KOwvvK3viov7a6ow3Qi6IWmrE/CBc5G4du+x6tMG+5zu4z5oPYGs76w1hsYw71I4HQ8ubz0TQLy
 LkGr0xbqce+iZO23xZEHqIprNfjqGrC++ppwHkA+sdUgPPJ698UdFjJuOZ5rGc9uYwA==
X-Gm-Gg: AYBFou3XA8yOnGWX0Z+nimZgKaJ7oLd4ULbRQgpDuRzqxXeWDcyv0/mKEnfM2sKArmm
 OVGEjniWY6W5zbdtOTcRh5gPwFRDcrQBSFfg8ofdop0JcjD2q4+66sFK8i1IKK6SW1nPxzyshyy
 9O1HqBuh3BoVaezM6iR3/n9/MDnSMOmbNECZOxVegKCa8blF8ih3EZqi1wbgKYtEn1gLndbMaLd
 QlcrdiHwwJ1mrfrC3WNRU3E0y7OJiBmFjQszmYRSC/Gee4DomzRMPhj9enR7rwmkd2cU+hqusX2
 XsFouRmgFt53t2yoQ1A1HV4yiQ9m6U18MRJEV8dy0Z8j2jhzyi6bPRnVzxwq52nxYqqPSUJCQFJ
 Zzg/HpwZ2KHmnDr4wnNrsO0O+mxfGqcDPf908e1485TM8wzJb2O6kjqbKr8JlCR4=
X-Received: by 2002:a17:90b:5743:b0:3ab:1b1c:8a70 with SMTP id
 98e67ed59e1d1-3acef29e7c2mr1096794a91.38.1792192998075; 
 Fri, 16 Oct 2026 16:23:18 -0700 (PDT)
X-Received: by 2002:a17:90b:5743:b0:3ab:1b1c:8a70 with SMTP id
 98e67ed59e1d1-3acef29e7c2mr1096782a91.38.1792192997560; 
 Fri, 16 Oct 2026 16:23:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 5/9] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Date: Fri, 16 Oct 2026 16:23:00 -0700
Message-ID: <20261016232304.1215119-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX5PHWDFm1OyWl
 7da8QiOJ0tR8balX4nDJX8Aba0gpNMxDbndOWXlTeZ3oqBcjzwyEYvvrlAwNNKBNbv5sU8JDI/8
 Ih4hSIuXmAoxkut43B1etr7rPK3YllDVeMBRL7Z8nV1oTFLCMjAcOnftEE5foxrpXZo5ATyuQ8N
 KwUXzetglkw8FoYEDWTydGUFrAwrJ3prAD7TMch+laH9fgEHT7kwhtyruRlDztrWBv2pisVVU7u
 5AkFTQZMcgW7l8w9k6d9I1O1VbXOP0E17iZKEEbyLWe55AgziM92xe2TOKlzZdOLDrdgWF5TCQJ
 GRDHB6MrxJCwyeC7lJuLHG561nHiXrgSjp+//Qr6bPyaYZ/NQ0fGhJKdAyaq7JAx+DODWCy09F2
 Iq38w/UvTQPAHfRq32psY40S1lbmXORUw6coXnU8ok4AKINR+nw2O3gsD+xixkzKcstScdrCFHy
 2RlS8PqnuyeA4Bc1C6A==
X-Proofpoint-ORIG-GUID: OoG0GlL9CbZbCjS_8wadrbE-blDwBbL5
X-Proofpoint-GUID: OoG0GlL9CbZbCjS_8wadrbE-blDwBbL5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX3hwmLJIYKde/
 Pns9ytLW4B0hSQGMujW1lx1XVOcVbLUWtW0+7p5Z8qWMGrt6z0uPwOK8uKi6Iq6RTiRUXW8EEc8
 oFA7vPN1GY/CpLYdvKEfKvxmMK8PXWU=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad2b1e6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=SGFeOqO_WrL6xg95NhMA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160093
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

This removes conflict with same function from target/arm.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/virt.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0475dcb5c60..4565359e908 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2c6f983f83f..de1c92463ad 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -712,7 +712,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(s);
 
     if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+        riscv_virt_acpi_setup(s);
     }
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 16d86edfcfc..6e4fbf4b647 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -122,7 +122,7 @@ enum {
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.47.3


