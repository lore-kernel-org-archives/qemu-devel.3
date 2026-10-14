Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F1CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gO-000729-Jj; Wed, 14 Oct 2026 19:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gL-00071X-2Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gH-0006SL-Ug
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENQWrK584763
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vtvisTG9ewL
 dXZi9ffrW9ULKotrZlRnWenqqqRY5IQQ=; b=neOq6gh5bm6xsha/xpXIYn0mgwF
 rMdbnVipc5ZMsqmzvg8Kh7+3kjYuEEQ3Pp/4jE7698Tx/dVAfpYIUQ06HmdYUVgT
 DE+FNrZPIV91gmy0nKme7AdfVvmQzEexqaP6JS2YcjXwIyqVF3TgkQWW5r9DbmQE
 PH7WdGHs8irgqWm+Njco6SkuVTTM2drDblddXbrbZI7eRwd8EA2ATk4Jd884k6R5
 zRB99zPfeJJUGKzgKuVPiK5F8/0PX8O4YFUo4GHsR3wkfYbnbc+pXKitkVIiLC3D
 rxUDLQGR+jaV4+1ghLtc5DiTEXNwvFKfD0tW5NeCWQqLpe6K6vjwFMt2AXA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1xe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso12288679eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021594; x=1792626394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vtvisTG9ewLdXZi9ffrW9ULKotrZlRnWenqqqRY5IQQ=;
 b=jrZ9mgJsem0TeCpgWMehsFiB39NfAS1Gdl6dCTNiqqY+NYJmPxynBfFb3Y3mU4Da92
 OFrNlFW99PZuodkSDBC1TC57k/ddfsyZr8OcZ3Dh7D7kRWzxr7xKumoyhCFNipLHhHbe
 5vRbkhVFYMJMczv886ePSD11S/CLkzdb2Y5Qy4tU42xXJNmda+003ZcTqFtBBCa/1DnN
 2Nqn6fkfXTk1YLEK/9sVUhgjxqSivsTLkLmfiGjJ56KoKIAblFzki2zm+9mQMobRfkPi
 WnARr+Sp46LSB6/g3uxyf4KD5F7jRDsnTosSmHNReB890xH66A02OlirZg1SSoR8UA3U
 xd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021594; x=1792626394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vtvisTG9ewLdXZi9ffrW9ULKotrZlRnWenqqqRY5IQQ=;
 b=td5wWuz4ebUxhgySNFnk67pU1QGHluYoNWW62QThlu+9vM1sYTDIctQSAYNpPjBx6A
 wm4oSiUA9AHACr2fQmI41f1jpTsLYDwoK6yQJtIRQxeO6YG+mowDzH/StHoYXVjk2RAI
 jWQ6ZqCYfsM3x32gxMoedSSJekY3FNnbDzh9uI3S5zZBktZHFvORSrWoMAsZcfEyn+Qz
 2NaV1UZsdEsa+4kUXVRrvOtsdKdBRNvVpTINIXVbQ1ho1+D4z9enEJ1uiWdUEGAtug+/
 l1bb/KY/5iBaFsUIalYbb3/WYRzIio5qeHR3sf3kZQFOLjjpMWg82ZziHglN3jt5q4OR
 hxdg==
X-Gm-Message-State: AFq9FYLq+Y82HtBKbThqskyyBkD73hSsF0UshMSOcoKUUclTLETvjEOd
 q7MR8MX6zBtJiSUvUiuTvVKQUB4FQ7H6b4ibAfLz2FETvpjhMNha/t3yzJ1vk6fMmXv1vsOn6s0
 osTuEx/xrj3iNByXfDRPu29tQpqEQFEWWkQWVvhU2WKSpDxz/F5uuz1/9iLsab7uqLw==
X-Gm-Gg: AYBFou2ULSQab8JS3uWHbsAAQnF7RRjtsVmbCJUmClou8Jl7Df9v2vk/8x559jwq6rZ
 CyBSL/KX/hoVAQmwPvqbj4hq+U+RXh2IMjS1hDW8BwI8HCjs3gMqyV95MRpwgdnmTJsB6GYunjf
 oCHOUkOoKVarqd2D4dKX634tvzxjDjp8S6IQKHcnUGs1/nT/5AKk/7oKqZHOBJqJbLpu8QF2yrf
 Sb7z3x0vuGy9ygn6d0t9SvLe13E3GTqVnCB6E8shPRRdLt8gq+c94NGOpBUp2Mj1+ibjkwR+OYw
 0AGP+NZYfk+kRwSpmc+tFmpQoRmZdvzvkxHpRySwaf635xxsudRhmfR2lNSbkjAuuKHl5xGpsGf
 2S/QH0di9FAHKooIR/pBAX5VQBwpAUxwgKFYH4Fs+JRwIljNIvSPQ+TzwPOWE
X-Received: by 2002:a05:693c:20cb:20b0:351:6f51:e019 with SMTP id
 5a478bee46e88-3537e0a265bmr23641395eec.23.1792021593844; 
 Wed, 14 Oct 2026 16:46:33 -0700 (PDT)
X-Received: by 2002:a05:693c:20cb:20b0:351:6f51:e019 with SMTP id
 5a478bee46e88-3537e0a265bmr23641339eec.23.1792021592529; 
 Wed, 14 Oct 2026 16:46:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 13/19] target/i386: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:45:59 +0000
Message-ID: <20261014234605.209084-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0145b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JTYOQ39vrXh0J5ee4iQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: VuxWimtYrSVarlJuI0MoGDfTB-ZHt1ma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXyXz8sPxr0knU
 dBgOhshqpNMBDh9itEu30UQuzrl41d0jqsuO281cSYen7ApMSLZXzVxw22SWLZUMdx2hJuNPK8W
 DsJ2vK5txsqJ8ClYj4txmWm5x+seMKqZ3gF2tWrx8bSmpzTAtzFLnpdEVJeIkXsQhFPAqYgCQXq
 znJIBYGOwDyRpxYOYnDEsOCW+K/zI1NuJTGaT64K/4brcvHpgHTRcxuL9jl7lfShrxp0uvGjnXk
 zYodZGvBJCmBNrKKGz9daFBuXFpuUOt5i/KqGfzVyCcfVwVCVVYxOZ91fQHtd0qjfXTgjeFNaF1
 Js2mY2sy/UePkwxFC/FtSKjRoKVyIpT8LEPiBmQ4LiaInVdMNMyGrMh11jV1WwcZ/33m8hxruma
 j6AxLGbo3JtEqdSbMDFBc4IlQIEdo6yLKxTV5baxibD+7Y4Eo7fgLfskEvGckMhPnuwv/J7JNZZ
 8Fii0dSsdjmstziweWQ==
X-Proofpoint-GUID: VuxWimtYrSVarlJuI0MoGDfTB-ZHt1ma
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX+Z/qbVTbDMY5
 9xhTLuS1/cgd9HruwkHhVi1nWgnW3gBmK7Bj3lmrdmQUCOHm9mdLU/kS9coACFJNgItoAeVaxZM
 xS8E/UrHQOUDt+l1HyOlkfNXkSfRI9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
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
 target/i386/arch_dump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 301f6252b7a..f2bdd3b073c 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -431,11 +431,8 @@ static int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps i386_dump_ops = {
-    .get_dump_info = x86_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                                 int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -465,3 +462,13 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+const DumpCPUOps i386_dump_ops = {
+    .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
+}
-- 
2.43.0


