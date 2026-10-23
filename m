Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FA606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nq+iPB/n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NmKXn3j/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxj-0003D4-2v; Fri, 23 Oct 2026 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxc-00032s-UA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxa-0002WW-Po
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xdK2109275
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oc6Gc8gHZXH8iigAQnOMEl8h3XTo1QGeE6XNfXubUfE=; b=Nq+iPB/nR7241wy7
 33fHsc3zghm0YiZvE6gJpApyzdcGcRni/fPlJgt1I7sg8HCpuWDdiSuZp6NLKSnd
 ND6z7znq9Xqv8gVEx26ZXd9I3+R93+LaVLGY2SxfbxpvH0+5VjQPRhSacJcW67zA
 Ojq6sJGSoluQKHJek/NPNk/nBnsUKlXyu5PZj9EKRrFW4migKK0COzsTRTmFiHtr
 TEuKPNhUwKINvVH7GVyAo6wrlm20LQxieKDZ/N19XYnApp/cvHv0beqXj5hbyWAi
 5yab9bHXSlZfJpALj2RLsAfWNnJehwuKQHhnGLFigX0l48fv4Ze6MCu71PcAfRci
 ffWfmQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4gke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so354856985a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772255; x=1793377055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oc6Gc8gHZXH8iigAQnOMEl8h3XTo1QGeE6XNfXubUfE=;
 b=NmKXn3j/z8JT2W7dSJY0Cl/bpOrQ4rYRGpy4ffLFJ8l7yl6+d4e4OmucJotJFaNpF8
 +swKUzCff+PiL+jcBGUhCrNraMgU16XsZPUIsL2+L0MUNP4gLEWAzNWQFxk734V17H4t
 LiCTgitviHeDXuiNlSnEkcnI2VThPlbk5Lsfnscx0VEiVkPtmYtVGwRSyiZhTHoo3zKP
 2cahBk2oKxMMSE+QzTX+zMYTfIPcs2R2AW9jHMcX1ipeJdBiJwtBL/sHxmlnTUOgNTt0
 IXLjs1aDUFIMMiRCaqIiTlkDjwuhRZMbqq1fEM8wk8Ll4LIpQNrj00bMlt/nuV2tx3Me
 d7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772255; x=1793377055;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oc6Gc8gHZXH8iigAQnOMEl8h3XTo1QGeE6XNfXubUfE=;
 b=wxP38HqJh5XTc2iTrL6PyeMQjXFRZ7ux7Vi0y7KIjwQYcKkw05IdtYxXwOCjBL+Fpw
 17pkArXkaUBcernYTqvqL+HUyDVcik1wYeErbxhrzKiXDFFN/l3W52EHA84yf3MT6nIi
 Ivl+rqxDk9Hy1wePO3k7A6DZQpzoovpoM/EzHDOotObM5jVZ1pQ7uLgy0hQTAg1/OdY8
 v3WgA1uoUluJbQtcGxh3yi0TRY3Asy/GhT1BqImJJiO9vfeEvRK/XqBWY7R9WcPZQBss
 x5UNda8YNaUIutQjKVuQtlCdwnmK8o2zYGSVRbramHyKcqRsDG993ZVlFYM52HHD+Rm6
 inoA==
X-Gm-Message-State: AFq9FYIvGjIMn6KN1zUu3o8wfTET5k666ui4GI72kIx7eVW/TersiY+K
 XvjwW8bz3kme7Vve9Htn+T/iEXShtzbFIJxWMBR78dwFhKG+WzRON3GNrZqYbDGd2EsuMq+GIX7
 XBNdH9Lm5krO7DnVuNKUQeDXqakMoc7jTIGKkWUVwt6uQZd5XGSIlvVoL1Lol43WA0FhD
X-Gm-Gg: AYBFou1dY7VuPkCe75CJu76sVSDxLkpwH9zQG4aJkpCs4fVgAkByVh5pnMhpO9KalWr
 otvKFcuVp/h0NbpujU4auBbV69K80F0oskftskd6On1p1tQWzLwlMH3Ne49jB0bhockWR3aB9kI
 sCF6PT4S5ySDajZs5GeJ8KCFk+uFYp4AB9uGEQ8ZdQSGraNdzK+mrM7GPjZMDnfirY6sQTQygpK
 pj+LEUznZa+cU0FIHiFHvaRp5r5yAjSULRwyZs5Ye4w9HgSgRb0CecIoVJXyo7c+UO70XBPvFOq
 tbCyoXRaNfahpVkdhoYSKgr62xMtNbs63TJ6v+XRuLqqkihB9zVbbIRaUhYIz2v1cM6r09C6lJq
 fuk0Ts5+JPTMQjV+LvuuoNEy1gE8BhH/1e61NMeOe
X-Received: by 2002:a05:620a:6009:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93f6f79df64mr466317885a.8.1792772255168; 
 Fri, 23 Oct 2026 09:17:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6009:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93f6f79df64mr466312985a.8.1792772254540; 
 Fri, 23 Oct 2026 09:17:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3fa012sm774095f8f.23.2026.10.23.09.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/83] target/m68k: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:41 +0200
Message-ID: <20261023161332.60153-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXz0XnTaGlxfPW
 pHJ77iAVqnBG2me4r9fcFtFVQ8+bi2DBBMuWmls0qZOyQPYgFsDtfEqd8dcUXDxhM2YD63EDMT+
 F8L3nx5sUok25S+KUkyaSavGKnS8b46uQQpgqnfhKRN+dQseOvUaSvI13iWBHtiY++LwSpzILmC
 3l0j1CNDpxurRr8hkJoYQrFnWX7kqscL0dIvto4zRlvwOCD7yEFg20zOLOhzx5oeWNMH186GAUP
 zj+v0edixtRh35JolJA3//SO2LgnWlSj+51f/dfDULp5rG+ark6R9ew6kucb2BWHCFqSNiYaI52
 LIMnltMHAMd95+hWzUlGwfqFLuiCn9+kvCRY29VHFZRvEAN6gk9mO7RNwi2ObzyYzsBfZXSAOVD
 NYBLRVpJLsOsoywjUxYSqNWnAkF2A30T+SrJFRosmkEV53An2WFLe3cfS9KPsrNCqjGUggrKCSQ
 jzdpaGTEOTsniVEy9oA==
X-Proofpoint-GUID: TpzAezFiYEJ_8cVz9tqQa0WmGVi2VIO7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX67GUYiey/AaQ
 jU0YQbgsqHQVgiH7cjaMye0s9ot/t9kvbpn6iM7P9GjOw5f0YdHiLSbgXBvlx+gPQh3UwS+sNak
 jYOSt9GKt2tHaBZk1BUo85UaMywuCrc=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb88a0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KgwFk9o9-AijF0zHnMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TpzAezFiYEJ_8cVz9tqQa0WmGVi2VIO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Expose m68k_exception_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve M68k exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-15-philmd@oss.qualcomm.com>
---
 target/m68k/cpu.h       | 2 ++
 target/m68k/cpu.c       | 1 +
 target/m68k/op_helper.c | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..44b4afc41c6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -69,6 +69,8 @@
 #define EXCP_RTE            0x100
 #define EXCP_SEMIHOSTING    0x101
 
+const char *m68k_exception_name(int excp);
+
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
 #define M68K_ITTR0   2
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c7771cbf643..01c6b6afb1f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -729,6 +729,7 @@ static void m68k_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
+    cc->exception_name = m68k_exception_name;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a689814..c600f83ddbf 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -80,9 +80,11 @@ throwaway:
     cpu_m68k_set_sr(env, sr);
 }
 
-static const char *m68k_exception_name(int index)
+#endif /* !CONFIG_USER_ONLY */
+
+const char *m68k_exception_name(int excp)
 {
-    switch (index) {
+    switch (excp) {
     case EXCP_ACCESS:
         return "Access Fault";
     case EXCP_ADDRESS:
@@ -185,6 +187,8 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
 {
     switch (cs->exception_index) {
-- 
2.55.0


