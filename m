Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A6CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT58-0005K6-Fy; Thu, 15 Oct 2026 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4f-0005Dd-QN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4c-0002Sg-4b
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKDTmR3462814
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rugzwJl0gQc
 FNLEQfZTbze/QkSoVCJ85QVb1/nLSXEs=; b=P6TW6LAtNUOxsc0wv234VoUZtno
 ZiQOq8gL+tMTvodG3HcyLZPBAVmMHfAsMSjhdH2L5ru6P6yVR4zGv0B2WuHGONuU
 C1fvBlQdvb+/uscdUJwqt0vRznnWEamC6WnjJNuPkekM7cqF6j17b8VYOUgmk0gY
 4lEXgwAvFYgLfzfrYTWq7A6825GskJFvBf3rJ5QDglqKKJhN+1Rp2qxUo5x+lq32
 +/v312I3W5oQHIYQUYDITQGCHbtDpB1GadCk4Q2PVts2m5lJ6xx2Mly95aPKgi78
 ufiU0xRDuWtq5YRUHPFK1gYOiDq8EO7Ffo8dTqu/F/49ik/7hcLw08BUrGQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso2743720a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099981; x=1792704781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rugzwJl0gQcFNLEQfZTbze/QkSoVCJ85QVb1/nLSXEs=;
 b=Bmk72UeYK//kT0Z4sGvKK/2n8lBJPxl/Lmksm7kdMuwBXhOJYZWAxG9TCkBNLa1CUJ
 t/xbMmD2+ZK674rKdlTZ4Pb70B0nVLR5lC+zgaZ4101v2L2T6WImjsh2UK8N4Ux++Re3
 nGHIS6pW6mBLk961X3EbKeZ6Etnf6YwxzVevMRhzIUA8iE4M4UwNnRtRuHCxGGApl6A4
 Lyf7S2RjMUX3HLnJaV3Y8uyjCFL7OconwlNHUGAp9qjAXqBWfAuoFvNXjQjvNGfIMYXH
 FxXDblTc+VmR6AzQagfzeLJd9DzqjLG90pucwtg/KgR6pE65bU4ihsPLX7VlU7uFVnsm
 SrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099981; x=1792704781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rugzwJl0gQcFNLEQfZTbze/QkSoVCJ85QVb1/nLSXEs=;
 b=d+o6vLwWVjTHY7HfFtJeb/UXyaSHQq+Pjtk1RTHcU+ePM33rQ0Wc742dUeT6TgUOxj
 O9I3Xg/+VtY3Y2P6L6J+hV54qnBs8jgHzsKjSgeho7ek+FNesnPn6UKJB6pxXQwI37dq
 AW2AmlGBllZJxslHFJB/U2zYkrF+9KpEuJjD1qR++PbNIiJ9tVegl572QYkb9CvmzsLP
 9Zge3NpagrtIufnF5H2Sxqbcp+9Q9WcihjFQh0vDUI+J+SY0r7JQCg6iKPN8VzTVKqPg
 UCpWuW5rpSp4RxqXF+8WhNLnZAVTNmVve14NnybEg7bAhc7nds7BiqgO+ghQdPHR9PDl
 tWUw==
X-Gm-Message-State: AFq9FYKen6QhfBaa1xIKAIqElHni8m9qW4CuZhWxewcAuF2FlI4ooUfs
 TEd4+8eXSLJd1sgkn+f+8DmkLceZZd6SNr/5RhHB0JWC+HtOXx8caa793xEeD/lV7Hx2kiYz/t/
 UcDDbSOYdqB/RikLCW1gif/Bdg5mP86b64bYRTUOkHvTeUhTFhHhwBlSyapZD0QFDBA==
X-Gm-Gg: AYBFou3ZD6bBhFx7LU9Uz+4z/wDUHvLJhhrXI298aLzcLK720U8HpBgduJF+SCIzWhk
 IoWnvKCDS/ms07NOAa+j/tNmbzNsbNy+jT8HBSCcuqrvClTeo1alFejpPiQjFeCa5sAHubs4/hk
 yE4Dy6mEnJeWcQYXUsC3L8oruBFugmO51gRvibrS89KMBZZ3kC75xHeU8E93ipkDRnJTibUvNc0
 RiwNAV6UKZMBGsDmXgoIVZLZOoXJ47ON84b2Ysd545p26CDK87SEGxJ3ibv0FhmJVuEdBC8zhN7
 SlL+Q3wZP7Wsu1nweYl7lsKtFXmDArJ5B2pumW4S1m1IEBgm2Pw3rb708PhXUk0/he9VKLoOnN5
 5qG0VKlXEmvZbtZF3GMCFZvmWMpxfASpYRxnFLdKzh9b5fpPdUS6MtBNrtgcvvys=
X-Received: by 2002:a17:90a:ec87:b0:3a8:c0cd:57fb with SMTP id
 98e67ed59e1d1-3ab3ac9a1b0mr17041217a91.42.1792099980622; 
 Thu, 15 Oct 2026 14:33:00 -0700 (PDT)
X-Received: by 2002:a17:90a:ec87:b0:3a8:c0cd:57fb with SMTP id
 98e67ed59e1d1-3ab3ac9a1b0mr17041150a91.42.1792099978897; 
 Thu, 15 Oct 2026 14:32:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 16/19] target/s390x: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:33 +0000
Message-ID: <20261015213236.157767-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CsgGuYxuYmJ6wmEZUJhxS10sDvY2ablQ
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad1468d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=EDlH-CkopuZvdY7HuOYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: CsgGuYxuYmJ6wmEZUJhxS10sDvY2ablQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX8imo8nx+15ZY
 EyZTXyK3RPenx4Y2byA27m3KvSKp11VYS7/0RzS9mfLHSaShTF7e8AwOQHiEJzxvMJ1U90crgla
 a3g/61O69hKRuVYzPpuT9gZQ2F5I5Blq0KzV2X2ioG3UI4KBIP8h+rs+/dg4OnmTaz8Z5Mk7Q+Q
 BFo7RnsE3tFXRYYiRQm+fpsVomIMWpOUu4RnpU2Zyt/LzoSxj833x38+14ZufiOvgUJtptIqYPL
 wMCTxnDV4BnH150gqoXwBkTovCesq/ZuoEZd4H04nDVWynAueNCi7+tSCklOecH6mChfsztLgsM
 Fj7mowVZjeA8ovwHj6ZWimDenXXk2/+PcKOL/ciGatkBJsb4odcCgpMz8sHNle4WLCBLNXYsWiP
 FlWGkLIoOip75mCGsKWY/t+ebpi4IhYTfZB6AhmqwEbsX1tdzi6JVOT0dUujp0t9jLF09euHymS
 T1vhDmxoyKKdS+Eh1lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX0pT/vi7cXLEx
 U6lyETjSGKUWgQyP4b30tRls1SqAv7WVohL+mYDius9Xruf0GRKRVk7cI8QwTX2x0BKF5wqhqzn
 Z3TU3xRhcvJLYrEYJWgAr+nbEOucBSk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c      | 8 +++++++-
 target/s390x/cpu-system.c     | 1 +
 target/s390x/s390x-internal.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 4301cf400e4..3ca85e6b64b 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -469,7 +469,8 @@ int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
     size_t elf_note_size = 0;
@@ -495,3 +496,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 965f5cf29ae..784bf4e90b9 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -187,6 +187,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
     .get_dump_info = s390_get_dump_info,
+    .get_note_size = s390_get_note_size,
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a70bab270c9..b02d976fd81 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -253,6 +253,8 @@ bool s390_cpu_has_work(CPUState *cs);
 
 int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.43.0


