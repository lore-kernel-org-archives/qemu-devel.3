Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868F3CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gR-00073X-Vl; Wed, 14 Oct 2026 19:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gP-00072Y-D8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gL-0006Sn-18
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMaEhV905392
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kXnwqbNHGQG
 +90Ka8PQP79XPqj4xYDKanxFWuTs8058=; b=hqoKbNTEIlBlURufrjSc6UvXets
 mejLyhFgt6oOMpA5XInX1wON5ZUaPvZJe4l18vmlOxoc9G+wTWuB3KZXUXgVwBT5
 thAXLLcCGdHZmofGobLSsEA0gxtoJ+AViuee673S8XM3znG5SWQidKcTf2PLn+Kb
 wbig2HYQgWM7KuUOspLCTH4VYYq8Sr84wCV4w8ZgWUlzf+DN10s8SEzOxy2SHrty
 GI/jgN59Km8CZAttvI/mKqWDwiSIFGb081MjaECCiqNGnjA6VD+iJ3HyJdPxb5n0
 1I1hoD03Y/hX0GBCbPO1JcLuelSVanS5hIKxPZwx4aFfO59Fkn1u9x2P8kA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p40gh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so8897123eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021594; x=1792626394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kXnwqbNHGQG+90Ka8PQP79XPqj4xYDKanxFWuTs8058=;
 b=gAUOqEQOhhL7s5/mgsz5SRJpr1egRS+XHAIw4ffJHWjLiVLu8rlJj1EMF6BFpX8Ooc
 JAiHsHyJgsGqIoMwDFEjlMNFC4tRSYr8qR5HoeZMRNOBYAjKLwPz8hu2mcdFLktzQACX
 pus2hLPNgcXkbeuDd0A6/uz4slU0p767I90WFOPyXAC75vpQacXVSmEmZCBj77l9hhiC
 YQkPCPQBUPhkw0NcRxTfVV43Esyb/h6maboRQnBBlyEnYGMv3jCt0HLBet7PnASo50D9
 Amw6JokoysryFNy0lKK0B9SXtnDoOrT9TFzwMEHprhdYsZTssXaztkOiP6+UU+7rI6tL
 pUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021594; x=1792626394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kXnwqbNHGQG+90Ka8PQP79XPqj4xYDKanxFWuTs8058=;
 b=w9lhFz4VwmFhFe9eTJcAT/A71hFwuRpLENFbVB3e+E+TkVy6Hz1el5tcNQrQjJy/Gr
 aakStrm7sjbj+aO7VFnkjfiag2UwC1CApusFA25FvOFcLau5y7huZ0z38ISToruQgLNP
 2VmP9VloLlxVXJzzUuAqK4Kl52N35b2PfWr1HPCntOUgNOUQ/i6bo2mRRPA4FCVmixUA
 HzorhTPP+bjXGo+cOZZ3YM1g0O2dfsvA6nbIFnDE4k8yiewpvHjtTU3qJjEArKo2Oiyu
 hg4RUqacTNqdL/qreLJeWzXqrmKXA90pJN+cw6KwxjxEwkhT+j+e0rmU9oA8wWt/Dkrc
 +C4A==
X-Gm-Message-State: AFq9FYKmyMMN/rb/WnUTYeUU5TFobVXOEaxIaz4+hRfj0dJ2EfqY6ftF
 KtFc68iCUV1sR8qPAwYfbLjWDKeLS2vmqGlA6SBnQWLE+c7NXvQ1YM3pSl2aJWHfRjZ5/YfZPch
 0vnjPW49lkiFPxdKKcwxHSX3xP1waYGEZHUheS5Gp6ln2HJnO6MmUbrrliP10FIYmKQ==
X-Gm-Gg: AYBFou3sz7Xr6QXb5gLDAxuvmYdCBk7PaehoL9UHuEjQmWexCWgb883WHLIM3dzqPr7
 I6TeHi1FmS5+yq9x/1yEkpib5SKOea7BxmfLnNizCbt7eduOfV1nz4MinZ2QSWUK3qmduoX4QFt
 RBjsEwQB7QPwlemGUfaL7MprOele+8owdW8YUXHCgiUIIiRxHY8b8ag3EjjMcNY6suiZEMGphOh
 QG7ex5rbnRL3+UyvO3lHysSlj8xwClLVhbFusG8lr45mtDc9qR6M/N+q3jTYLWbKlyWglN5gjsj
 35bE463C7HyWWLfaKjwu6CqElh5ZUbdUubC0EyHrpS7xAdpol+PgD7AiNgOwZXZknG2wNNnl0Bf
 Rw/KCexKwWOSh9HRzCzaBLK+IDA3F0T72OOkJ0HbLue4z2RmF24wbBpnZ0iU7
X-Received: by 2002:a05:7301:4b09:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3537e088bf1mr23675799eec.37.1792021594169; 
 Wed, 14 Oct 2026 16:46:34 -0700 (PDT)
X-Received: by 2002:a05:7301:4b09:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3537e088bf1mr23675760eec.37.1792021593467; 
 Wed, 14 Oct 2026 16:46:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 14/19] target/ppc: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:46:00 +0000
Message-ID: <20261014234605.209084-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX/TCFApvD8+op
 TgWpIu2Jg1uWJ1uuSpH0fP8L1XuqHfOifZzbHOJNDnk+z1pCcL2C+qnwuRkRVwLfinqELDQ5FC2
 3WsmleDo5FTvpga85ib0teqEOutZaFc=
X-Proofpoint-ORIG-GUID: 0g6UVbgDaNY3sWgfeMqLuAo6hfawFFPU
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6ad0145b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=nUViz7GbUQwG4xkpASwA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX/BaH8KepDPNZ
 QZ3US1XZCVPMccRaWHeq0tI5ji7CWZGkXW9fzbRpUG0OdzkF/i8M5HEJksruxrHBw8G29JBdusb
 jDbikAfW+MvMyDi+wQZ1bQvDNiF+vtOXfajlBVh6xmG1HuaFJRyhGxULpSCN55ENca7Qn0yRXVs
 sAF0FBj2qGgh+abG1H4rdAuCQJKtktWOkg34dHRaY4n3Rb+/tkPEH3vvr2o9eEbPXHn+VKDKVyh
 UgsXceB+MOZEuZcJNLsnNKoWISI/r6rDI8kSt7ODOtgkp8RnHl9gYyvdh8OPVofXMo56fCK/0Em
 bup3zcKU5AkDloOmIJK5Z7/AqXD+ebGnV1hufDpSNVspiZ5/w/tuXOJ/PbYOSp+yQQOwvjvASm4
 crwayrmW9SY7Fy52xgGYwVKp2yIPadXmSJWd25A2+21LmB4Lg1Rl/N1blPi4CPMxGMJEgw/emNh
 w7GJgI3NWmPn4pbS+0g==
X-Proofpoint-GUID: 0g6UVbgDaNY3sWgfeMqLuAo6hfawFFPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
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
 target/ppc/arch_dump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 0b2e6542ecf..f15a7047691 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -253,11 +253,8 @@ static int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps ppc_dump_ops = {
-    .get_dump_info = ppc_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                                 int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
     size_t elf_note_size = 0;
@@ -273,6 +270,16 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     return (elf_note_size) * nr_cpus;
 }
 
+const DumpCPUOps ppc_dump_ops = {
+    .get_dump_info = ppc_get_dump_info,
+    .get_note_size = ppc_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
+}
+
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
-- 
2.43.0


