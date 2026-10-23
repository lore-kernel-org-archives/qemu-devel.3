Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59380606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7BgbrON;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gGUfj9BN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwk-0008Gj-5t; Fri, 23 Oct 2026 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwM-0007ol-0z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwJ-0002Rs-B3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE66143018953
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z70493/7Tms2mpDwu94jnbkikC/mFPoefTSwPdSzoPg=; b=o7BgbrONNrBF68jB
 mQnOOZ8M2hXBeslcdhV7tXFqpsdOhl5uy/+ESMK5tt5DECg1/V9kuQgXsrueLtYG
 XTiL9O1dWf90UqZ+ctfXkTkRtDLQdSdNeFCa9eL4IZDkwtVM4CfI5TfBGWPu/oS/
 j4EHFfFEhKqoBczH2VUrS0h+EDLfGOvsnSgc6fUU3SvxOMKqyoANfr2uZmCJvT81
 8OfWAl2SWjgGjIIUHG7koWtNm7a7+61RkMQWpSMtzCN1zz74MB1CVZt7lkjadVp8
 bAn/nigepAFu5qxjl8w1/dMsPmCVFbKhZSWlD5FteGRBVHhTUKvYIEqMovynoFmb
 9O14vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbxkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso181774585a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772177; x=1793376977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z70493/7Tms2mpDwu94jnbkikC/mFPoefTSwPdSzoPg=;
 b=gGUfj9BN1n5XpF+BNx/VXTMp7cP5W73XzPs8u0gCaTQjF4kxpMviOKFe6C9Fc9vKwv
 36c6+SCSMDXTugN5XSitDr8Wiji4PLm/bGT66sqhrhIvNhy0P3ifLppVaZqEZ/UesTKB
 O3lapHl5NOFGdpwKwVFij3+nXsjGdn/d7uS12UQqp8pV9gs0SA12r+X0OdlHgLpowuBB
 mSlOU93epsKu7eWuUOuD6bl78kGZ0YqJxo5r0pGXxoI0hn+BdYGcgOnN6Azwk2Uoqw7E
 2HxP4KcKK5Ytq6JjF9HAD6+gOKmIv9kE7fHa6sB2S+WJFOWYttbVffc6UNiifjmZoxdT
 +hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772177; x=1793376977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z70493/7Tms2mpDwu94jnbkikC/mFPoefTSwPdSzoPg=;
 b=2Unu0MoxWVuDLD3OLIHCbMXHH4T/DztSscsEqzR9rqAplhQNpdUmwEcKy4ad+MrpnW
 i3O4aQr+MJiybHHS9YZ0tNl00RElYO87cA2246HE4MpEdN4GNcZY/T+KPEtbqjc5xoFE
 yV3C2cL6zan4kYMw3Rhr6YL+YTWt9bR8CF5125oWh6uUQnURmf/6kYqDs3AcHX+2E9bc
 8/qxm3Bgmyv2pCqyqGxhV0aCcs6IgLbVmqvhuK8uPcLAF/03P3A72Ns3/fGq7SjqnZmG
 4Zmuxt2cvL5gxwoWOdf+FLVUC52EkNrxPaLC1n4ANp+h5ZBXuRQTCZd9NTYd7NkfYgIt
 9miQ==
X-Gm-Message-State: AFq9FYKoCdje+0KiDOgksnuRlMoHvLmsX08IVyJa+O2TZ04WtdWJFdXJ
 os+QU1tfoka9fMXUWgiB5zU1PV/8/mgo2Hoq8FuoX9lWctCb4wzAjxKxi8Gnj1mzY5LN21kQ+M6
 6YYiU1dCJk6KIqq4lvH2mcVlHVD1oNdtVtyZZSVc1rL7arDmQyyxeBvMmjEL4Acx4ui7n
X-Gm-Gg: AYBFou06WvJ8U8Y6jtXymV0S0m1ycjCEJchwBcoF6/pqHqjnq/jFD66aRR+VABAHzFz
 YeGKYBw2YVnP06/UUFe3BohgiMMjAksxZmw2NQbrHXB+J0K/50W+U5cPHKxyxFzV+fnXXy/NLoU
 iMjlouSV37Xb4P/2GZQf+tJv/uHt6vM8dy+0aKZUZMhV2MEVJHmcyRPmeEYZ4RjW4vmFYf0g07z
 kEUGS3klmCBK+kawDqo6qzImf3xySIac/uKoGvicAvl5eVftuNeOC0T9o1ybwAPRQpKQZ2udfQD
 aaiocbdXbSrV5e8UeulIU58hPrF2JgdichfQyx8Ti3wwJr8CVA9i3AxsJU2rqL3gA+ziMtBVffp
 KHSb/n8nxEP6pAFtnoFcWId6ZVYyDTFy2QtNp3VnK
X-Received: by 2002:a05:620a:4505:b0:93b:e5e9:23d9 with SMTP id
 af79cd13be357-93f6f78710emr517183785a.23.1792772176632; 
 Fri, 23 Oct 2026 09:16:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:93b:e5e9:23d9 with SMTP id
 af79cd13be357-93f6f78710emr517177685a.23.1792772176076; 
 Fri, 23 Oct 2026 09:16:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4048c1sm693232f8f.29.2026.10.23.09.16.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/83] cpus: Add helper to log raised exceptions with '-d int'
Date: Fri, 23 Oct 2026 18:12:30 +0200
Message-ID: <20261023161332.60153-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX11LBWabFFLyn
 0t3kRbqiig0rktpW9lJYcBP3blx74D4APbXU83NRiT/pxoB2B6dlz+SMdGmDZVwUVJoWTWJ2TmN
 FSnc1hkW6dK8uLCSA/MqjxOatGLLq/q44Jm6s/iXN+CINXdEk565V77szxJco8ddlqa4Pyc5okD
 6F7OtsnmwFnsxhuCfzBMWKMkIEtpjr7oD7HJuxN2v97zV4+MoOnxSJsoFPMXDUuMi6Ww2udxoB7
 fWFxL9n6z3HA0poLPKIsEDlFzJjC5M3xUrxNg9x8Qu6vRNNQ+iiia1+teROrLbzNUhF2X5HdBGs
 +Ry7WfDDUuidUxWyfcHrS0pO4vmtaK2F7Lz9BjUEGyPZxMrTdfkSrxfLwf68n0EOyufZM84GUed
 71gxvpwzQ1qOSq3d94/mqQYcZ3bJqKc33BlvV+WB5nv31uDtFWCjziSe4+mcijXEN81wUT/idWS
 VFK0Tg/gCXC1B+Eb3xA==
X-Proofpoint-ORIG-GUID: KFCaLqKHbsTkTil-qwJPd4Gwgxz__gtf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4I8vN09nW0Lm
 pRCRvKbBK8Vjaf3i10xoiADR6pWioR/Pv/1963KSMPLUVKhQy4I9FMJDsgmQPqdBIIwWxVJubcP
 PtF6n1Ir8oE8K6c4f+co2yq8YzGO/cI=
X-Proofpoint-GUID: KFCaLqKHbsTkTil-qwJPd4Gwgxz__gtf
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb8851 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0xCBr3yVtZFRf-pbA1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Add log_raise_exception(), a common helper cpu_loop_*() can
call to log a raised exception when '-d int' is used, and
qemu_excp_name() to resolve QEMU-internal exceptions to names.

Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-4-philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec-common.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 68077c8fd9d..bd2cb9d6311 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "exec/log.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
@@ -89,6 +90,34 @@ void tcg_update_all_cflags(void)
     }
 }
 
+#define EXCP_QEMU_INTERNAL 0x10000
+
+static const char *qemu_excp_name(int excp)
+{
+    static const char *excp_name[] = {
+        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] = "async interruption",
+        [EXCP_HLT       - EXCP_QEMU_INTERNAL] = "hlt instruction",
+        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] = "debug",
+        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] = "halted",
+        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] = "yield",
+        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] = "emulate atomic",
+    };
+    assert(excp >= EXCP_QEMU_INTERNAL);
+    excp -= EXCP_QEMU_INTERNAL;
+    return STR_ARRAY_ELEM_OR_NULL(excp_name, excp) ?: "unknown";
+}
+
+static void log_raise_exception(const CPUState *cpu, int excp)
+{
+    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
+        return;
+    }
+    if (excp >= EXCP_QEMU_INTERNAL) {
+        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
+                                   excp, qemu_excp_name(excp));
+    }
+}
+
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
@@ -118,5 +147,6 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     /* Prevent looping if already executing in a serial context. */
     g_assert(!cpu_in_serial_context(cpu));
     cpu->exception_index = EXCP_ATOMIC;
+    log_raise_exception(cpu, EXCP_ATOMIC);
     cpu_loop_exit_restore(cpu, pc);
 }
-- 
2.55.0


