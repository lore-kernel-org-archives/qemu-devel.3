Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4ECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJo-0004o9-RS; Wed, 07 Oct 2026 05:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODn-0007hH-LX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODl-0000Qb-Sk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jZM13810946
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 36JGQDrby8E+uVmJtMoidepbj4Otry+KM/gA3LKRk8U=; b=h5rF/TQBNVBCwH4B
 Gr7ipCSRfBZchaERe72/XaBFae2WoBiNs9dssBXk7OXxo2mbKvSXyWcJr6ONRhZK
 AiD3ovW5oVGFSXH5pZG0pxd5jc/EiP7ui2z9Bih+rBMWW3XpZWoWewetXPoM/Xcj
 KDww/ZYObEUA83pWrYHq+13FQWwUtzOV/FJAdC+QL66/mirm4EFMmLxAHE042KJ6
 rS88FShqCzZXZ6e8s/lg0lGvBL26V3N2zFYmwOoo18UXENrjWAMXIwaG1VPAYv49
 SBveMLEqTiNpasYQQ1Efzw2ZOCEMiQGOj6EcJWIHymo3S0jVse/SGP3nwvV86tZh
 MLXjLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrrn7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso672689685a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366356; x=1791971156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=36JGQDrby8E+uVmJtMoidepbj4Otry+KM/gA3LKRk8U=;
 b=hL2wHKHxQaI3Vh6203LwwX4/myLEfObEW1T26/H3SmP7g/niF3IQFSF44sCOmCUJwA
 VLKvTMa4jiAQ7eLmxoOJqag7b+P3A5VlY0EHeNBPfBfXbk9/7BiOIrXwD1xTddpIHRMj
 BtAMkBxa1zfvmvWBWtjsA+ffY6wj8ytHXxmJXgPbttLk3BxT+JA+5yoV/4g4+jtemdHo
 OG/XJEV44KnuZZSdsqSLQmcWloUyxGEQPkhZVFwKtXWL5f7UTxxc/SpK2isRMnEpDcOQ
 4LDfzQ5xAceU8VqdLNLV4lpfdu+oA3lHz2MWV3KXlUrE3SUl00HWi9/Wfv4J0c6Wetb1
 ClSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366356; x=1791971156;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=36JGQDrby8E+uVmJtMoidepbj4Otry+KM/gA3LKRk8U=;
 b=pGRKheDD+lnuELUf1V4NfQ5cMkXt6rcD7YLIne/Gi5jlh5yGyC/Zh2GbVNp+E4+4zX
 ulOLUrrP3kUUdmkiCRjnw3ZBOfJudXVC6DTIzaEfWtykZFh8dOs33bCvMQk/kG8b3777
 n8oFEEk5NxiLHZAuTY3QHxQonxo8wYAAOdCVsOW8i0RC2VuCA3ho2Dmn2TG0gweoCFvu
 mnL14c+hyCzKvHjLDBPyCcT8ovHyqfOvoDHzbjO8pNF/5CE6F/c6rmwfFjBW9S/0CAOd
 bdryAVOOlfmRwX1hhKoTZ1P89Ai99CMIIBRjuAOOpFAX6EewSL1s2PTHhwPdx5xD+kpg
 GtiA==
X-Gm-Message-State: AFuF++mOMsteQNercMrH8D7qkyRGoIe5XVD3d3FHOioiD+gjddJVfIqB
 22qxvEXb4J++dCCp32ERITfZcM8aMqNp4aYfI0yx3aIA96NrGVkIi2Veo9srwDKlFNmA68nrJ8s
 Zd0ujZzRggz9Gih5eQODRmO/AyWETTommTGdv3Ja75HIA8DpzmZaM0+QAKDklci13Nltc
X-Gm-Gg: AYBFou0ymk+G5ySmAPOHtS4YlkbsQTb5fTIyxDpeUngmdiF7kUor20bug1yT0yCOmRC
 XHP+NeSIqcriXNnz4i24sIeCnqdI4/GeWMPWaoYQAY6nPGChSmA30sPgdIxA6v72vC3vkN2kzLx
 r9H4wN4FiHcIKt3hioNAeTJgfTeHglnmmYjsawwJd9ZWnurN4g706mKkw8bUn4sx58oyVxXCkY7
 JUAcl9nK7JXNryz6c+/kVkajZB3CbNGoCQ/e97svgyFnpZiDvbwSkMm+uwbt04s+UGd8x9PN5nj
 seEOIkwVpRBq/s/J7gyauhD2htyWN3dxrK5FYgroacRcEO2aEMz9RDxIoDn0xKM4CZBQ1GsxXCN
 tBRidUHHtb6D9X6M7U8ckp42fMsHSrvteJ2HQWuBm
X-Received: by 2002:a05:620a:1991:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-93e9b80d1bamr321333185a.46.1791366355723; 
 Wed, 07 Oct 2026 02:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-93e9b80d1bamr321330685a.46.1791366355290; 
 Wed, 07 Oct 2026 02:45:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c75b56537sm2202055f8f.59.2026.10.07.02.45.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 05/27] target/avr: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:44:53 +0200
Message-ID: <20261007094516.75732-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac614d4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=52sdbkR6oSSg4JP1pMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ds711YcQZ_uY2NWJNiSsvo4Uk-nGC-MD
X-Proofpoint-GUID: ds711YcQZ_uY2NWJNiSsvo4Uk-nGC-MD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXx8dGTelq/pGf
 WQECrE/34IX1iBUaqr6n9xUhZ41wfGuTxW62F3hPzYS+G6RmKGU0rQUqGSU1R0n/sWq7vQo8oiN
 seTpuLZ17C+6H7SNRe5oV7fE+gnJ8x52UvVDisDeuSxXikxxH959DQ82YWSwJLWvOHNG5faYTct
 2k9g0Jj9ludMojaXK3z55ksXTUo1B1MfC2//R799UzcaX/NUpBliDu3GMZ+A7QMvt3iHNqIIevL
 jbOGWCDKeth9Ddfevsyup1Blm+ytr/jPIFReWnu43q01+x73fPA8bzoZVmpcCSmHcXUC+NHOpqm
 XB/+Q+W23H4QSpM7/FBF+OQHjY3RAsjPJtTTcTapasR44CWOuWjFtMPQawi8E4EbrqSlh+jx09Q
 A8BS7JCVX7AZegAY3AlZ6IYo+KYGzJ8KeYTERNHq/FsizbgPX3M8XYE98osXIACjuVnyCbJPZD+
 REpVem02a3XhIl5ByQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX9Rr95Qs8Is1X
 ho3FN3UWeH7GPnCil1bTuzsjAgvbIPY9yGuKnLBZiZBVcM9bkx9dxFz34cLmUH1L+is3piHNgZA
 FX8fRRU8FdXLhTworkBBqcoQLhSK+o0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement avr_exception_name() and register it as
the CPUClass::exception_name() handler, so the common
exception logging can resolve AVR exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/avr/cpu.h |  2 ++
 target/avr/cpu.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 1e4e839bd83..b1b5b637617 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -44,6 +44,8 @@
 #define EXCP_RESET 1
 #define EXCP_INT(n) (EXCP_RESET + (n) + 1)
 
+const char *avr_exception_name(int excp);
+
 /* Number of CPU registers */
 #define NUMBER_OF_CPU_REGISTERS 32
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..6cfd19dfa81 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -258,6 +258,24 @@ static const TCGCPUOps avr_tcg_ops = {
     .pointer_wrap = cpu_pointer_wrap_uint32,
 };
 
+const char *avr_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_RESET]    = "RESET",
+        [EXCP_INT(0)]   = "INT#0",
+        [EXCP_INT(1)]   = "INT#1",
+        [EXCP_INT(2)]   = "INT#2",
+        [EXCP_INT(3)]   = "INT#3",
+        [EXCP_INT(4)]   = "INT#4",
+        [EXCP_INT(5)]   = "INT#5",
+    };
+
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 static void avr_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -273,6 +291,7 @@ static void avr_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = avr_cpu_class_by_name;
+    cc->exception_name = avr_exception_name;
 
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.55.0


