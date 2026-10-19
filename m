Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AABA606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lfjZYBXp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Arm6lMfE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuv6-00047F-0G; Mon, 19 Oct 2026 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutZ-0002uu-IA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutU-0006Kn-Rp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJsTF3103234
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uxxIm2uTpZRPBkg6RZhKHxAsSyqcMCVqjWx+fWbNfzw=; b=lfjZYBXpFb70i6dZ
 V6zxUH9yAwuo12zvpw1GfyLteIqETu2Bcw4cOuH6/TP/MnxwXHgdgwpZy2+7ZHMn
 stZoCNtL8UOyiTbSAOut3CoZS7Ri06QXN6mtpuNmFFpB7YYqlDP9HxyF5fEZmnJd
 DOayHr1wxeyI2Wu6ba2vC6YknJVwWfipZsRqO6tmeBjanxClE0E6QToX/VxXKzpU
 VTAHQ9xRrvMScKjWXjVSWOBZRrYtAaKxGhN4y039z5IGXJACnyboSj8EapCh+aq+
 5GJUE/ivkTOrmMWlmHvuESmeKpTgP0L9pIxFLwwclIRAax1DWtv0IiBNMvrq4Ug3
 XdsypA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0pcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so1507985a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445244; x=1793050044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uxxIm2uTpZRPBkg6RZhKHxAsSyqcMCVqjWx+fWbNfzw=;
 b=Arm6lMfEG75uFvbf+bh+ZSzsgldGto890Cf0qxfWRfFEO8w4WkGuX2s7cWLN1Z6WKN
 mP7Ak5DHbkveJS0qJPcvbGQQTwyNPWAx56LLQ9V3MoBWlHo1K62/xeBR3ziI6D0SDNuK
 UnZ5s5jzw85R/WEduPMq+BgAZAMMQcvRI8jUEf2crHy0tzP7+jatyUzVaFK+vn/Qlafv
 /ozH3CLCb+yqZ5KjMDJah6p1pzqtodlFIVhvZnCGbEfb45eaTPG3HE8RUJJnOAum+qkx
 lzSG+c+LT+shtCXeYrYosbV+X/nGxIwvDRoclN2YI4Gg8LfrYyIpZrC3dkp0IE8Ucm/d
 jUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445244; x=1793050044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uxxIm2uTpZRPBkg6RZhKHxAsSyqcMCVqjWx+fWbNfzw=;
 b=lcygptmWW/eDGNakmOsKwwxUPagpC8RhM90Gejux54f1z2IoLhXqi6GIEaQvz4MJXV
 4lCmNourxYNjzqUsosiPX5n2la0O/obinmGV04BnpsBLOhWPX/vDrfHPcow6Q8j0LafG
 +yOUDzvmma8xcoAnfAcpoXzHrJKuQr+VjyaJzL7vOt3bKT+FfBIwYhX/fmE75XrHb4LO
 Vk8xLu+FbgLLyhISdGUumVcmN2yThG03kVYQv3YcLmoIesa0qV0EO1U4KzFcB1tcK8VC
 t/Ue5YjFu+ZKL7U0+SX6eyATR5h9my7BU9nAgux+7FU16K5a1ohqhPXO1Bc2cqrlseCg
 FSvQ==
X-Gm-Message-State: AFq9FYLAut2fu1fW3fkRhH9CP/cXUMJs6VsN4xwBBYyknUuh0lEEY19c
 OeeVVM6jfFC/5B/QmOBb8aAcdSifWV4zA/bQSMOtn6Ddq3w6rwGZYw9sCj9/H0+u0gPjnVLrbWi
 LuWstd3r14BPLTfh9xWQcGwgYEQy+Oxq9Tga1TaCYo953O1ne013Ujm7zWkrfiRo24A==
X-Gm-Gg: AYBFou0vk7DO5r9NkPUoc4T5AMEuJKWAqzfnvnrAyCopUm4eVSeVghJsHr2v9oIMxDR
 p84bYNrKJICNujqQvR4K+oX2NFeIbqW65WQlo1LUgFYhFSevIZ9zxxuLe94V9P5mJKdgQuLpek8
 wDCpLCQ42A35s1j6RRkJh7gU1PPS9JqjPNGst7lYCWlXiEBrUZElUI6i8TGMN0N7weWIJPwGWE4
 ucZg5UFJenLnQ7VqwOupLSoLr0IGAZdeparqC9By+kdPNFvxZA/4M84mFhff1E5KymmPX7Hy1mO
 8JLl2pI7OzRTQ54k6ZcDceXbCt/Z8Np29yGsMoJDoMkAsbbe2eh4gpTYWtqN7Vk6BqtDTmBbRCv
 rIS5oTtm4SJnxZ13AULCQotPpkVRa8cZY/g6uJcjyJOeukVcBVFPh5MfvaAQslL8=
X-Received: by 2002:a17:90b:524b:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3acef14fb1emr7605939a91.32.1792445243733; 
 Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
X-Received: by 2002:a17:90b:524b:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3acef14fb1emr7605919a91.32.1792445243279; 
 Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 19/21] target/s390x: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:46 +0000
Message-ID: <20261019212648.154493-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Nejx03IOa3be5kOj5Lr3eS1e-Poo6x0h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX90akCAubTH/6
 gXwrA2WH2r7NU0OiogWNUpERYfQx3VykOjZSFYAH2SiGfQp26VTPQ8d4acD+IRCQ026qSkHYr+f
 jz7YhjcJ1xwtbse8au466xyzQqq2XJQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0HDbU7c2aU8Y
 jfuX71ImK/3NpHKyV5yN1XpMmpZTsrjr+RvStBx4rvhq4dQfotLpCt4uWSzV6sf7g+5P8jflfMs
 H1N+0h8WIr5w1137HJY/GyvYGENge/S0Q9XY6e7Eb3ud3RPDh8X/Z7BJfc4BCVaCzO2fNt/Mul3
 VyxuihPB+5kyKua+1Dgxf+W1NT1NT5zGJ8LuZusKtR4XtPnNTUQ92hMEQCOh7PXiEfNeQwngbmZ
 qzhpMsIFliJY62EXI2N3XPH1WgO5RtSJipkoX1TDEvilB5+cA2pVuRnYCGUfm/Pkla5T7ruP7L7
 ggGli6pTi4ox3ib/O2gX6WOQkJEc+aM6i4vyfpa3DbnP3ElJE8qgchLR3C6PTT7yQHlBsY+LZn7
 ur36e7xv2n1f7C1ZOSi5bsg1GUvtkBFpPPg8SfCet6+ZcnPxfLiV4odV3/OmnIrug9lMh+KKiDq
 5NCSi45PCcRpbBs28xQ==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68b3c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EDlH-CkopuZvdY7HuOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Nejx03IOa3be5kOj5Lr3eS1e-Poo6x0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.43.0


