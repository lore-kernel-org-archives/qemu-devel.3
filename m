Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E6CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4w-0005FW-CU; Thu, 15 Oct 2026 17:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4a-0005D3-QB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4Z-0002SY-1i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3XP3406220
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tUtcqmP6sL/
 twqqbKOZG+sRPnxVivxbz0lnHW4PlX9E=; b=UYvFDrtjT5n56yiDGIwpXtj5Vc8
 IPTCTtWJe1yCyfj3SFpvFEyzEutmmY6fIodyxLRe4ayhaqA2Z8GjZnSm80xv24eU
 I7/gDlluPz9NIjBd3JmWj/m6Ux24LjDmJqQUgNMQDLSkzQJ+iNj8+KMUTtdhm5FY
 fEMp93mnm9fpX5a6qp637X4nauxglGy3dB193k9Lg8BDHoq/l7JkAaT2batssZUN
 YzhnNY/jI/HHWbfpTBg/9vl0vqr56QZxB8A3ylP4nobJoTBlvApdnrRM6w1y1IF8
 81yq/UfYRwlxR9HPaGZDiArpDpXZvu1aYDY+wUdmujXVE5Ad98jlKbMBdhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa0q1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso1731451a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099978; x=1792704778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tUtcqmP6sL/twqqbKOZG+sRPnxVivxbz0lnHW4PlX9E=;
 b=YXhWtGxszSC+awIB8ZRpsv9NgDWcY8I7j8eYQ1Y8qX/55kLX5wE64uY6igkek9uT2P
 S+hCnlPUYsZ8kKUx6AwqAi9pcfn0vBUAoDyN3pDxhuA8fZ4MWCM4CvQdPnX1cI9WGtUv
 AcwxdvivMNX8KR61HAa3h+xy8Fb2qY3ro7GcJSiKZ7ZP0H5Qgs6u9psu5OR3B4PvDncu
 Yybx8B0NjMpTi9KBZQC7xw8VzAMOmiPXcLtuPTabszoe0irfl80hb6WEUuztcFmebyhX
 WiPep9x4Ui4UUQPnTvUt64JqVFQAI8rNJ0QXvPWcSO7N/qj0oC2wZb+spu8kSoZBUaqF
 qOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099978; x=1792704778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tUtcqmP6sL/twqqbKOZG+sRPnxVivxbz0lnHW4PlX9E=;
 b=xGsIoJcGxgoPExqzq88dyaTUYDB0LGdMNPF9TTj817UGSrPcBVofOBF/2Iimp41XqS
 F2QDWFPRjn4Ij62adDdhfPl6S9y3/KiZL1TtWrUul+WK+E87LZiEZtlsGekYbyBYvBy1
 Vyfi0V5EK8MBI38VLiyyZpZUVW3Fy1BtZ+KJ1mY3TinDbyHywilhTyN2HnXziTU18Ff+
 Hvg6qXgOX+qjVnPMtxPusj5McNJ1jlNG5O3qDHLj8sTwLrzr/dh1lD8PxtFq1nMA32FX
 hNhN9XoTrnaPeSjS/YSt1V7KbGdAB3a3BUoC7BrxxnFVvQ3lfXYXYqWAwaAGNYeHfJ71
 Gb6g==
X-Gm-Message-State: AFq9FYLG7GVX0S3DhMhia+Hw0uSi0gEeXGQzJKPmhnhCZ+pweuugkvzE
 h6/PNMLFMo4Pv2UFaV0wO8JRBRYGgwE9Oy8yDT217Rh+g9Swh/tFu0hpPaobS9e5uR7MuAcjjR6
 l/tYsme+IsE5vIRXsrVFL5UG2qbb/9imN0awQsWGejtTYkicWaRpIitzo2/QBU6dRkg==
X-Gm-Gg: AYBFou2JDicwt8gfplLAzKErXir7OWWsjIBTAmVzeWfb3q3IFWGlfu4/l0aE4M/3W4v
 h+2W5vf1MIKozxTlytg5novRNg62l7Kq6NBgxxcCL0FVUJOlCRU3cOvUKlVu8LdnZ+cQfKCFSkI
 4s1hAbEo3bhehAD8P4E8iPN7SFtfQZxKbQoJ/LxAUzRMM0iDJQEFGOy3cQFU7szm5wAFWlvwKg0
 B2W99E9vLXbbtseZ9QXPUmh6tzCt/nsUYqm6DU7N1tgSUqcN0dJevopiLYGFVH416S3Htb5yC8l
 PoRyxL0O+IStvNCIUJKpFga4wqE9gpBdBvsz/xePmmHD18Z76s0SNo8RR/9lytto/H3q0aitw+j
 lY7nXnoOv1s6+s/QhaJj7yeKy8QZ8uwRjYo6nAGe9Bu3B7fYf4tvmvAK2ulJ77RI=
X-Received: by 2002:a17:90b:2886:b0:3ac:a7ee:6760 with SMTP id
 98e67ed59e1d1-3aca7ef2de8mr2161364a91.23.1792099978188; 
 Thu, 15 Oct 2026 14:32:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2886:b0:3ac:a7ee:6760 with SMTP id
 98e67ed59e1d1-3aca7ef2de8mr2161349a91.23.1792099977635; 
 Thu, 15 Oct 2026 14:32:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 14/19] target/ppc: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:31 +0000
Message-ID: <20261015213236.157767-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX9UcxGHUJrsSR
 K+/lx1efpuuA0ijAvBIQvB5i/DxzlPFwT0Z02+fHAiAZxseAFYd3J0t87rSnwqNBkz03l4B6ZCR
 pkRIP7XF5v7AR7sMWw240qo2982N9q0=
X-Proofpoint-ORIG-GUID: hn02Feg9s5xyjWiEc1uL2CtbDk77yeLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX/G4kEUAaa9OZ
 suLChm80IwZiFiYFCMkwvHkRHVDRw4EL/NknOCBvdnNG92QHAReD0QKTuDwIYRY3QQ49d4ZjnK+
 4Z6CgKyn8SKkiAqcq6dKO6R83ZOPl21sMZoVBxa267NvSjORQDaCzKIKpd8l3QXVneOegdmQ2U8
 T5wtJxBpwk3tV0g+J/lEVsaP3n6hTJana1TF0JjkBWzySMsaegP5gK68XoOxHmQ53BMRFXFIsfH
 SKlxFKYFarDIYFEwL+B1x43wmjSpnCl3CG3Lfv9JhTL+m+tgNS4Rptzg4p8p+cNny2jy1a35dNj
 p6knpeU7vYX9mvWvQtqZyM94f1xyXGTBCYVIUB4pu0WbeIsYcNGCrPJH94f97fn1VQ9v7O9jnsz
 aGvDXd3uMLKWThHDJnGptzyyS4VMAQou0QCbwUSoEWiWUhaJzIa+xFmHSi7Z7i3YTME7b1fp6wb
 H6nTCMUPwSUCDAYX0Ww==
X-Proofpoint-GUID: hn02Feg9s5xyjWiEc1uL2CtbDk77yeLR
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1468b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Lumvk8zKUu4O7nVSwh0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
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
 target/ppc/arch_dump.c | 8 +++++++-
 target/ppc/cpu_init.c  | 1 +
 target/ppc/internal.h  | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 46030ba684a..585306ccf7b 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -252,7 +252,8 @@ int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
     size_t elf_note_size = 0;
@@ -268,6 +269,11 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     return (elf_note_size) * nr_cpus;
 }
 
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
+}
+
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5853a92bffd..578dd9194eb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7474,6 +7474,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
     .get_dump_info = ppc_get_dump_info,
+    .get_note_size = ppc_get_note_size,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index ad01421ffb2..719fdd2f625 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -328,6 +328,8 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #ifndef CONFIG_USER_ONLY
 int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif
 
 #endif /* PPC_INTERNAL_H */
-- 
2.43.0


