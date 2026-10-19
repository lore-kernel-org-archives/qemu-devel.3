Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE8606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LXqPuCRX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E0D00bzn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvD-0004YY-Q0; Mon, 19 Oct 2026 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutL-0002oH-3s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutH-0006KY-21
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK4Tm2157810
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iNSFj3QSeKL8NpITyuFecTX345cdvKtQZ6tCG+ndZpc=; b=LXqPuCRX+9XePQ7O
 ACaRywEKakwvHj3xSdYP9DZTSzjwpKbjiTyrPxKxh3DVGx78FYopoA1r04fMfZf2
 qYJFQo2MSTLlu4PxF45iadG5GMo+2DVeFHHab+uvksVz2TaPcWhL9FNOuenYTKQt
 qZKYETGTFgExrI9rXP/L9JPB9G7Sj1C9ZDyr2qGCys2iPFAgPvDnMSh7Gr+LDchV
 4qXiu8x7nc1Tj4mBZ2ZPUNdqcggXMf+HhRL2zfF+KeFVrlWNDZ8BV1fOHTW0uORx
 YxjFni0WwTMI5eDaSTSKXWq2GqnhJ9Mqbp6D10AqicBKD6k/1lGQy5Ez0OiD1KD8
 +rN9dw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kb5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac6795617aso2442128a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445241; x=1793050041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iNSFj3QSeKL8NpITyuFecTX345cdvKtQZ6tCG+ndZpc=;
 b=E0D00bznyvkiMCDavbyNMIDzNp/g8iVimZf1eQhAhtxboYJW/57yUnxDBy5odZYuL3
 eDtHIKf0l6hNbJDJCVRowNdwIJYnL6vxEGNVUZQT4DM4OYS2OHcuhMt8RYEjzGUSNnuP
 Di6SwdbXoT4EzQSKuKH1uD9B76Lj3pVPrUud2uQ5uw0XT0BoApVxis5hOEhNFdqxK0ax
 1W1u42Be7t4Idom8IZOIb/pLseAizIu9PRZQ6aZzezdRdWpTHzwgK8H0ZWPKUsiTm1Pl
 SD8qJcOKncx+CJq1HOEp8ZYE0BBA8tq298nmZS1ki4A8I+nx3kR1L3muMrW4bPx2lxar
 fLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445241; x=1793050041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iNSFj3QSeKL8NpITyuFecTX345cdvKtQZ6tCG+ndZpc=;
 b=WpC8Zs2rWa5YNyl8gQLmRrH9C+Y5VXoeDiwTfCQfjJQHlTV/boSWj8CWMQoDHJja7B
 5qBELgAB/svOkSbL9QG4RMm2dBaILM1ZgH/bcwFrF+9U5icWsdy0vbf3UAtpIPfQIwrJ
 H02aL7HeYXYzgnQPRmjfkVUB8o4+76aremxj1RMur+42YMJ0yo4Esi8Uq8tuoU3uOiQ/
 8krGIuKuqUlZvga4gmSRmy5j6acsqTUo3vYUAOgzq2WpULK7iUj5KECgU41TtMAvfiz0
 jfOynDz9qwA5tI5ytOQROCZ7rKkC7coVdHhT00+l0a8k/XH1hUKpKOi561c08k2LAz9o
 EF2A==
X-Gm-Message-State: AFq9FYLomOyCbs81TM0erxv4DUaTLYHW+C43JyvKG7YDfCgVr3fAKNTP
 rywVqI1PQ/izrzGXN6g0JJGYfoRmUMhSPpauSKG4qjFt3uhH6IZ9ZYfrFFuXzFd+snarT1hwcZn
 xMIgHphfURovlnynuzHhksZaSQFlMCSMdAi1NSAVassv3RiizWHjXHwsAMib8S0apMg==
X-Gm-Gg: AYBFou2RjfUmPS5DnTJn45D2sb+Pnh68T45tFazLCbECm3K6Ycs6ci3+VY5mAqr2TRS
 ze9EJlvXhHExrSE3MNKUCzt6ifikOHipX9RhXn2ImZCYgnxGykevFVEcSs7Tce0Wxmz0t4qBPQz
 H5vjz0xIYhN2zbL6MydDs+lDqJm13wBY5sQUvQ8TAXQ9uTYr22pSWM8heqIRUbhdss02Ci+DE+f
 djOYimprHCtTPJZUFI/2ijK3qlRDeeq0zoup+sp0csChSDJVc9gPsz/cisYiIslBMKqc3qYFSlu
 CT88gqf/0y5lx0BUySHQSe5Mvduo7LaErUk78588W8WQMRhxRXzVlxvjEPbP509WWVDfsAnY6JI
 1OoY1Amza51D+Euc6l+fDM91ms0jTBq+20Jl5C4bXPX4ebD9ckh1gdb8wmXMIxV8=
X-Received: by 2002:a17:90b:5487:b0:3a0:8050:2ec9 with SMTP id
 98e67ed59e1d1-3aceefbdda2mr7857773a91.16.1792445241046; 
 Mon, 19 Oct 2026 14:27:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5487:b0:3a0:8050:2ec9 with SMTP id
 98e67ed59e1d1-3aceefbdda2mr7857762a91.16.1792445240568; 
 Mon, 19 Oct 2026 14:27:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 16/21] target/i386: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:43 +0000
Message-ID: <20261019212648.154493-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6DghX6Zyz8M5
 rr4qtKpIO0249Mx/sVTAdBscccWn7ldx8HZbeLKFoqA9U9QRyEcqz1ZxPO0pE7/yqcdQ9915XOx
 mVF+fyin8Ue++TVAmBwi7YKn6DrGAsU=
X-Proofpoint-ORIG-GUID: yMrmbogloZRR2Ce7WiX8snVlOnwT-UhP
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad68b39 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VkRzHO9NBAn2Hx42XgYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXyyKIxHK69OpG
 Z3TG9vkK/piAAVjtALsfWw+MWs1bN/x4qLdmw17rAKZPSZg9RKEaixepGWeI00t9MyRa8deGqdY
 4wMeBKHDzyiyVZwPF0AqU4/a02wBG8Z3oEeV2U6ZDMZ1XfjK3Ug2Isu5n72ArTSqXwKHP08EYXV
 nOILKedYdAAXQzKXFI8zAJhMMESu/EKAHSJc7Ne1Yhl0qWK3uFGM3LHvpUzXdQ3hpq8XrssRJaD
 6Qpgq8hAKMjNeDB672TEtVYLOtwJly87yV5mlAjH+s6YMftWJK+9cez7B/ce7Ejr+cs5cnGjSA+
 TZpPO1IQApCs9WscFZc747d3q9bkuia727yXOwuOkzPc8UoZp0dlAOVVlHcc7+5jyRxKXr5Mi9S
 pR/pYbRZqp2BtFVO1nUa2qOPe0+1KpBjUHKYAd5mDlhFZsRtLfKxMpDU8ngp/KmuowqqabVccXK
 K9oFZAIdEAcWJd2leJA==
X-Proofpoint-GUID: yMrmbogloZRR2Ce7WiX8snVlOnwT-UhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
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
 target/i386/arch_dump.c    | 8 +++++++-
 target/i386/cpu-internal.h | 2 ++
 target/i386/cpu.c          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 004a639030e..4d8e9374cd1 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -430,7 +430,8 @@ int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -460,3 +461,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9bd2a37c447..7fb1b262938 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -68,6 +68,8 @@ void x86_cpu_machine_reset_cb(void *opaque);
 
 int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
+ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49f453bb011..dd9cd7c5625 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10921,6 +10921,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.43.0


