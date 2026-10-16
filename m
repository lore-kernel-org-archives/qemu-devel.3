Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DDCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmUQ-0001Vr-Ka; Fri, 16 Oct 2026 14:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmSB-0007BV-Qd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS7-0000a4-1o
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI4orY4023371
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j2oMDFOXM9D
 /fH67iiMX5F7p/cF5pL1GqIyTBdna2B8=; b=VoW+b1+Zt66rsSJcCbZpF84zOTz
 g6gLdNDVNAjxpdvXA2Tg0VAW0t5RgXLzwhtqb7B4gXihUZo/y1ZCQW1iS7kjBc9P
 lek4/pgRqaLeRjSZM47RyOD+c7ywE7vGytyezOtOxgSMSbi9QrVTOZfeTr7Wm0z1
 jXhGBqY4m11Wngv6e9chZOGEsSHD+Rql21886+R0X/vlW8JeI4gKoSUN/3pkL+a9
 TzzHImzMfD4Tza/dZuF7ISHmIj9nT3AVQl1fAQBy7x5GbHaLxyy4POWKen5xzzm1
 sqXl0+elqVXxDMUlOOMQija/zMkCPz+gvbCRjHUKFxDwGRr2E2bTQYWKilg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrvwg179-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so411990a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174485; x=1792779285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2oMDFOXM9D/fH67iiMX5F7p/cF5pL1GqIyTBdna2B8=;
 b=PIlOSeV9C1B/RPZCB36LzJprztToyc+9ahe4IbFHK56cwRdZD9/p/2vNfE4LeZ2iVo
 3TKps9GhA/uATBV466gIyJDthW4fRzy163cDgolqCj/0+S13ADj25pRhUW5q5O6f+St2
 fxxlxznvpVVhZktIQdawXPtMztnIhegZ0YFiq8V4pp+PmlnDi5O8/kszlT7fld7aQanx
 nqnqDg6FIymUhpGR2lUmY/ZDBlxO3udSxvloJZ0dA6X0aMI9nBQCDDURoNgpaqMKem8G
 Svb8gJ3Y6wCo21wB8lpHdDZ1woC1UKxTqRRtQFS8XZkNlok4ETw9fZOl0gmkC/2GSlE6
 vBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174485; x=1792779285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2oMDFOXM9D/fH67iiMX5F7p/cF5pL1GqIyTBdna2B8=;
 b=f6qoRXU4NNHsIawacMU6W4sscnn1Qxt5QC236tvtOEyOerN/WVn0B7xzrW8XyTvur9
 kkHVZ9UwW36M2l0NY9eSNFgIKW3iFvjn8kHQg5MdXjoIvxkiR+ZgNPY2RWScPBeGvIqv
 z0jVrXknWSKudIlTWafyQha2OfdXffeSQoKCsT7AcWnRFEn0VQjETjeZn9mj3CzIKiqf
 FqSwoDaNQAVQfxAsJ0K9SSJhoQ9OrogqsNcd01Z9Yp++KPZdE8L7W8Fnm9Ik3W7BPKO7
 gnGyekAT6MvBRSj2ZOM1Jyc7zNXWsVm1quO3RaWWEzoDfNpyguyiGKrRHhaHU/rTfXGa
 WSTw==
X-Gm-Message-State: AFq9FYJIM6ecXCQua7HQqXSaJ+FxnuznedpWqHhVkmmc2MDf9URW2mRh
 haXU5S3a0oD5nQMTOpNgydPbruyTWLJg0I9O3uuxikGToJrUADDrYp/zQ6mMiCWK+6bXPp19xC+
 19hnmSvkZ7jMm9Tqw46VrbTpSlwjr7Mz4SBMqD8FMo1S2VRtiw4wx95ynCljVQk9V/g==
X-Gm-Gg: AYBFou0mpO+6VRO0Ri+/ErW7KIRPtNoP4GazpK0YxNALOmzJRi9J4an4m30WWVGCYra
 bWFQ4eyR6K3+AxToWhDZb4TSde5fZTGWgWrlAzPq5UTaTNTl0Hfg/8Ui8xXtnCRihtKjEEWwkpe
 v7BWHSikEdjJ7og4o2wyUIFvkAngYGOYsG8fR40FIamxpJIzYkPeJ1efW1KcEsR3xAuO83Os+dg
 Z7Yr2/rKEIDpI1V/xWdlmTm0YnVJ4vaB2/NpNL8oGAPOeQFZLfvaRBcbGiNGqdQI4V+IaX+Te4T
 D++MjFV+xyHkOqVzTVKxoL2UWgqHD/9sGL+g40jbBOUyV4kNEldsUNZOjRHnUHq3Q6Tj9qEZwKk
 gmn0amg/1ax6UgtmF2FjyvYAfKUBDCGVhaTBQ49NJ4AhNEnj9u+BIu+ixqDwaFac=
X-Received: by 2002:a17:90b:3892:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3acef3aa12bmr624292a91.52.1792174484838; 
 Fri, 16 Oct 2026 11:14:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3892:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3acef3aa12bmr624268a91.52.1792174484404; 
 Fri, 16 Oct 2026 11:14:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 20/23] target/s390x: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:07 -0700
Message-ID: <20261016181410.191743-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vhWkqo7ZWpoEBKCcCz3h5L7YU-zDid8M
X-Authority-Analysis: v=2.4 cv=COa/zhrD c=1 sm=1 tr=0 ts=6ad26995 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EDlH-CkopuZvdY7HuOYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: vhWkqo7ZWpoEBKCcCz3h5L7YU-zDid8M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfXymWTA8KzhyFV
 wz/Mw4tcVwXoVpIE2B977j+1GVqJQNSzAlliWxMu9BdjNZHlz7XY84tHXLv3fvCgLGHMn2+Uak+
 UbJ3zdzcRffns1OAyI53DFVoPAE+xPL1jGZ6qoiw0P2ZFr3If3DW4MFKpTIk/fVc64G/PYTIgHB
 zjASuFAlZzv9/ZK5BwqT6aT0n7qakattxBGAO9Vue32ZiKsP5Ha+Y0n7vZUPLpA9D3lUWJVCZAK
 gi/yRfn5DvIpllpPiklzNCR6VHYOOQtEVmp2JxqhpYx328OJCy5S2zi48g85gtYWel5oMZdOGxx
 pj/tFxxvqv+Cpl4JLIDG2PxW+lYDcqOBCz/ALRsBbF6NQM2twK3+oh/UmTzPGYl/Al/scYgxNYM
 6P5uwLlytb/5Ieen8v77Or46iDcwib5BAgFdxQOhisTMqMJztlhrN/nE8Bp/wiEzQX12U2iLFv/
 E5dMT1oaHKA+W/X5ipQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX3gdUPdyV+dWK
 NtoZMfWlM0jZFiyHLEznNMG5GUkyYcHAdfvqFNJRXIR82ppgEHS7IIKxNhu+a01afd3rZBoDK49
 T3VZoAnfnyluP8+hltGcktgX2Eg7O6s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
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
index a1f78799159..4ffb647bc71 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -252,6 +252,8 @@ bool s390_cpu_has_work(CPUState *cs);
 
 int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const GuestPhysBlockList *guest_phys_blocks);
+ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.47.3


