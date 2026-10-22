Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6B606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1q3sdHK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E9oKWd0x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ix-0000xy-IT; Thu, 22 Oct 2026 17:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iu-0000rc-Vn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0it-0007cd-2i
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVBq387692
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KzD4l4Fr3IGoMNxMhkDDkUoS0uskiXzUopuBrq//ETs=; b=m1q3sdHK0Wpv18VT
 u8BTEQaDrfuryEpp3Qsyw96KijrSrr0uiNht64nztN9gh75SLNtDzuTfdUF7iVIe
 oVT9U7albZKOcgtf0zSLM6g5YuQBvWF/r+VfrXAPelJtxu39e77utA5enoJJxdC8
 jTgGp+PVPG4l2KPWBmqknWzW3BgXMJ2RQ1wnA8ptwh9QH1mkmrrtYOmbgxwLEu8L
 D7h0/ykzRp4v6aVvc7pLDPbIiRSi0PvgEnNQU/VsP0PZH5MnTfErti/RFiMqUp2W
 xNRkeoXako1WW0Q8i30m9PkOo3rBdYCjddsapQCOxtL6ZZlNoj5dgPCuLzwHrGfL
 W5vTrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4qwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so76850985a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705997; x=1793310797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KzD4l4Fr3IGoMNxMhkDDkUoS0uskiXzUopuBrq//ETs=;
 b=E9oKWd0xPm3xGwufDY2SoprK5q8fBT7NK6w0qnr+bhVgQbt8OzK7xbDSMvlOO+rqh2
 wvhZ0vEZVNd1pUGbi3BrUs+yJkYoCu6Vzi8AD4yAjWOnHFlrn+4k0Hrmc/mU2EZ50L3K
 e442AVSbNw4k85MmTKEDk7pEu4skorHl/O1a+S9tOIV4BU9pJ9u4gd/BvFLz9X/Op2JQ
 fbOspAH08H701iHKCC4xAk9DAgR/59YHpHpEdprUfqhcukzYlCaqya9C8zupZ5K93cbi
 KOloIiEgxe1eiiclzVigvqNIdDb0QFgaMIL95T0XZdJeWsnZwhdlHDCvJOOzJgv/E+RF
 I+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705997; x=1793310797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KzD4l4Fr3IGoMNxMhkDDkUoS0uskiXzUopuBrq//ETs=;
 b=2g1VEaa/zmbwp2hmWhhJAhyyfIFnmA+9vGDBVdPyqQLwtnukxmj5ga8CxYgmPun9gk
 mDEUb4sTwQh61spTCakz/omoc1nOkrLwUn5QE8B07iWRzjSn/su+vNTRfODl46SwPNSp
 Bt/bscLw1p5LQ091/JxLEUL56NldR0jyhOMZjVHdxOmml6syITdyWDgZiKEFsw46Y9u8
 28P2tqRAdlehF5+dCl4izJ3xF2tKK8Xl/Okk9OS1Ioto+WDC24LD7kki84bwbkb1c0Of
 mlf8Sq7hwk5XBdUZFRWVbb1E7KUwYXJOloL3Rn7mRwjqnVpL1V20nn30nmOhVoM8Gmqb
 8ACg==
X-Gm-Message-State: AFq9FYJcqXwLgqQQbXUD3iXGuYYTbppyl2es1sgfk8RhFD6ogHql0A5p
 LrMHmGPeem+tlR8BWjlx+d5mCY8JPqA/S/du+KiE+evU8cijBTf4c4bpzzubrd61J6CIzx+wa1j
 Hse4hsdtCvlYYc5q9f5uIXxWTSxEswKcXjAtkBYuO9Eg/HfxWvW4/9dmRz5BgXW1YdQ==
X-Gm-Gg: AYBFou1g6woh1kE5PsfKi+SeAQZBChpn9MDN/X9bQL345OiT/6mruruMjaEKTDGYV62
 Tu0CwWXyMUfcVzcwDtmQAcy5NZMwcSwAhNh4Gb9TDPfaFYOS4qd072jGdVpbRmkxZeaIKLGuZrW
 F3oM5ObZEshumLaKWcz/YnqLvKiuDDVVvjjavq1Igpi4kG3rXb+gx8HVPkFar1t2sz2gBSbMU33
 qpeIQuMVVzGF/ojVl+AbW9i3J3XgV2YBp/D0xTu3BOqn7q3dQy2a3krdH6wVa/X7ZoKIVAr5Ed6
 Hhi6s97LBY0Yo8+LfPuruJnHvWU6X3V+7VyvEzf9rGbZwIVItz4QZpINA9PY1kpltTdkbemrAOd
 lYfnPTvpOb9MzVVbF0e28wCWfBdlGKaRd3uSnWDT9
X-Received: by 2002:a05:620a:470f:b0:93f:3829:8492 with SMTP id
 af79cd13be357-93f6fa11031mr126732885a.78.1792705997339; 
 Thu, 22 Oct 2026 14:53:17 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:93f:3829:8492 with SMTP id
 af79cd13be357-93f6fa11031mr126730485a.78.1792705996845; 
 Thu, 22 Oct 2026 14:53:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210299910sm26512745e9.1.2026.10.22.14.53.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 16/33] target/microblaze: Implement and register
 CPUClass::exception_name()
Date: Thu, 22 Oct 2026 23:50:56 +0200
Message-ID: <20261022215115.19680-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gZPo9cr6Xl36x91Js8hVLqrB6mz5GJLA
X-Proofpoint-ORIG-GUID: gZPo9cr6Xl36x91Js8hVLqrB6mz5GJLA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3W4VmOI2nXm+
 HuVRy8JRCM27sUAwbVeLZz1wIrXeZmowm0FQQHMWldHq+CRTtHrKkT8viCjghBe5sV7mFNzEr9O
 WApUfmbx2FF2YclU69Qb723QYHlbiJY=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada85ce cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_ZqrUhsafL45AmjA-XwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXwJ3G9joMwmr+
 iAWt8DXd5iJlBA0LJZzILJfvt4Nu/EckMUQ7lxCI9IP7gWJNB6S+C8lcRSjdAdJk1JfmHpZShLZ
 EfymvxC2hcwEkQZ10bOFqGnfgyqylcOaBSE2oTiMtcWvEOZY7VLHWxlM5syTbduTPQVgBvc5D3m
 q5eK46MTAr7YhUStgd3TA3hyrDYYcTaaIluGJbjrM132PCKAUP0+7fHK09ndzbLmOuuVg/IXeXu
 MPfi5IxUSjofsV0unrnaGhRSp5aYR0PMOBnbjdpsLsWpVaJm3+dAeNIkTfiNrqucpOaY2192xkY
 eb6zHn8+xamRJVU1Q5nw8ubS5wfjDqQ6Nyx9FIqWAHCGv0QOo1m44Fl/FHfnDZr57WW01Ixanzo
 iHItD1KuxeJphVZ+Q9g325WuWjhGCrpzdpwzsGjbYDKeT7N/iuOQgc6z9lpOta0sQC2MeEbqaof
 WTGlyzvokvuQvF6JxOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Implement microblaze_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve MicroBlaze exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/cpu.h |  2 ++
 target/microblaze/cpu.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b94..fc2783693e3 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -36,6 +36,8 @@ typedef struct CPUArchState CPUMBState;
 #define EXCP_HW_BREAK   4
 #define EXCP_HW_EXCP    5
 
+const char *microblaze_exception_name(int excp);
+
 /* MicroBlaze-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..a3d92a35d33 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/module.h"
@@ -79,6 +80,19 @@ static const struct {
 /* If no specific version gets selected, default to the following.  */
 #define DEFAULT_CPU_VERSION "10.0"
 
+const char *microblaze_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_MMU]      = "mmu",
+        [EXCP_IRQ]      = "irq",
+        [EXCP_SYSCALL]  = "syscall",
+        [EXCP_HW_BREAK] = "hw break",
+        [EXCP_HW_EXCP]  = "hw excp",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -469,6 +483,7 @@ static void mb_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
+    cc->exception_name = microblaze_exception_name;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.55.0


