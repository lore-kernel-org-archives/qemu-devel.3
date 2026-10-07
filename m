Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0146BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKd-0006TO-Le; Wed, 07 Oct 2026 05:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODR-0007dQ-Iz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODQ-0000Nc-03
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jstJ2312932
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 baM+nutwwV9s0xtQ+Y+NJkCdyd4okZSGaCtCYj0XU9E=; b=p0ZMf0yUiTV2hQLI
 4L3upmTHD5RD6IZTuBhejVHCMS/aGnhcVk4dw3IVsacG317ga9S868fUlwDgeSxH
 CSwTgmnqYdFqoRTCeRqmGqosbR5cYwLcrhg/8k/UL6gThym0rxDsOLeLawa6/h13
 cpB7NaSmjEb9VRr+1QarjVvO7kqr1DSdm+MIk5I33i15Ti2S55KD77OlJFySyDcp
 tnSApSxo8/yhD0XzmSPZXJRTcofLF60NPwl2M9fHy6jzoEKTSs4zmN1hwBJHQVqp
 kPdN2KrriHVfKkwv6/cRcEJZRbR1KeAXA84cT2dQnUC+Wpbj66XhkhSS8aCMmuae
 ++uQfw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53askteg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so632907785a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366334; x=1791971134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=baM+nutwwV9s0xtQ+Y+NJkCdyd4okZSGaCtCYj0XU9E=;
 b=L1rWjpF1lXQP6K27Aygf6bAWLbsqLDDoxL/iBJPPsYL0diLZff0B86IF1sGvlH4sm8
 S9I35TwHWT+39RASVF4anglM3OXe6wBy9X7HFoZ3bVfApOxwgce/szSkb+WgwUCX4rY1
 2TMMkijBP/s0mOROg5VaKPUht+wV3dD+c9iVnJ0ElYTomijCIFRn7NQk+lkJfD79452z
 fEe2c0bPRpnNUWKXvWtGh9GTEILk7PdMZ0GiG2t3xSdU0qt+d3X4PF0FHrFtV5oXQCti
 fsK17klDDk2asvZcP3qvTe9tcn8u4Cz8zAK6VFB/16FGOF7k/xcNaFSZtCmpLJDc4grM
 BsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366334; x=1791971134;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=baM+nutwwV9s0xtQ+Y+NJkCdyd4okZSGaCtCYj0XU9E=;
 b=KTFPEvI5K6miy6IwjSUv20lAwpOiGRC/3kmT2xbGN4aU3RLG5F+9f7/g3WCfXVN9iB
 gm7bzKpkuWSSSJqhgE8PI4HpRLUL6bRM1mCfZZutB1ddVbK5TVt9jBW1+sb0yxvUzWR/
 K8hFuVqHqZtpSf3gOClkhlikE6g4E4YRMCUe76U7d2t+NFPdyVcP1tX6OYImrwP/IKNf
 e8H3vpHs2WePcP4xmrxANhTVdHTueJUupP0cQ/e6dBiVTuh2ahR8JljrkiTlk+RQvwif
 BvMRnUsYGzRioCkXcUe/2iQf3A1msOwE7gn/orCPt7YqwaUj08BkzvFZR8WVKG7cgXc6
 G+5Q==
X-Gm-Message-State: AFuF++m6FD7mrzX3FahK/9sIBdmQHLDxz8C1muBnFSFO474Dq7/3xnFF
 Dha5aDWorcwOyx90fv1loQVRfFvTJQUAEN6eNtBs0Y5fBF9Zgh9p6RCa7MAIVd1LyTHX3dLik3l
 JMAibIfU1oXHKfgNJoJNVtG6w1LLZ0G41PPx+uZb39DFIRzWucW6EVNvslLoc8pq3he7o
X-Gm-Gg: AYBFou0w1X0bE/wE1bui7qoSDfdaTzEpehgF6BDHSQ/qL9mXQKdP092m27UFASqsF3Y
 J17jY0kTdCHfOFlBKMGBi4qn8ZyeqLIdso4s+JLCEkj1TcFqv23s1gpJxi5UnEcnDdggfrqCtT9
 wY56Nt9CtEb8iIHCV7s2N0tj/ns2ZLC5MzeBsMqMzuG9ExcE6pLEV20dxZmPBt5jYzuSEiVjj7S
 8k0afkhLvzPqn5ShDFe9nzL1afDn7wR+vFD+pt0yiyCeGk1qRRMsXV4Ifzd7zMxAyjwd8ye4D9g
 Nj1eeH/0isZP+A/uHFWni6SCXG43zcf7tRwKw/04JsEzbpFbTRfCjtMQ+05BUiO8zlBIQbS5DK6
 TmWEfRMT/L0aYQS2lsA6didN4yLpheZDxb0b6lRBm
X-Received: by 2002:a05:620a:4590:b0:93e:9808:8d6b with SMTP id
 af79cd13be357-93e9b84ad82mr314929185a.69.1791366334196; 
 Wed, 07 Oct 2026 02:45:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4590:b0:93e:9808:8d6b with SMTP id
 af79cd13be357-93e9b84ad82mr314925885a.69.1791366333540; 
 Wed, 07 Oct 2026 02:45:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c40a28sm151589115e9.7.2026.10.07.02.45.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/27] cpus: Introduce CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:44:50 +0200
Message-ID: <20261007094516.75732-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m-Bt8EATBv55jD-njBjYLMRBVNOKAzoq
X-Proofpoint-GUID: m-Bt8EATBv55jD-njBjYLMRBVNOKAzoq
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac614be cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VFrVLvhLpLwouTeFobcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX1avIAzoM2D5q
 7nxivg65ew55QCnrAnBHC50FsxMy5PRB14RNf+YRWdplWfjmaar0yDA4C+POQhHDCKo/oBNZuyJ
 KiUuf85EIoDNLXwwzF0+fXzYLG/JiQP9kRBs7ZF8ivI+dwyk9NRnbOFLcIivDc6rKVZbpPFwbju
 BwtxkJ0pdNRpL2AuXo1DV3YH6We3SPBhMdYIBGdj07O9WQH0apiVhMHMS7o9p3YUItrm6wqNEPR
 Nf085L67PuRFYPLRKQc8aZr6VVyzjPieWof3yx/TvHe7wIVcAuhvfu7nSwhTwx9cbjWMtbUc7ZE
 QZ6mxzSsPYF47eVnjyJ1F9HZdJuba2M3f1PNT9VotMhVVM9jDrnN7JONjNqNyemardNMdiZY+sN
 VIo7onhA55J/vg2vnHbbm+sIKwK6FEXisvVnI39jqs6SbOlXmoK1FivBNcKlRNyuilUCLfx6vLq
 lefrjjHrpUXUE5RsMFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX33cJT5/VS21X
 c8qMa+FN9SbylNqVMcup/4TFDCYwa17SiJvRxYC1I9GwXgEToKJX3D+qULLPc7duvu3g3gOMIKJ
 WJZ+gZClHWl4F3CjZ6Y/YQ2dabJ6ptg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
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

Have targets register a helper to resolve their exceptions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h       | 2 ++
 accel/tcg/cpu-exec-common.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 328e30045ce..1d73cc69af8 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -105,6 +105,7 @@ struct SysemuCPUOps;
  * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
+ * @exception_name: Callback for getting architecture exception name.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -175,6 +176,7 @@ struct CPUClass {
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
+    const char *(*exception_name)(int exception);
     void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
     const char *deprecation_note;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 2ac8380d0bb..12cac8aec3c 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -117,6 +117,12 @@ static void log_raise_exception(const CPUState *cpu, int excp)
     if (excp >= EXCP_QEMU_INTERNAL) {
         qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
                                    excp, qemu_excp_name(excp));
+    } else {
+        const CPUClass *cc = cpu->cc;
+        const char *name = cc->exception_name ? cc->exception_name(excp)
+                                              : "undocumented";
+
+        qemu_log_mask(CPU_LOG_INT, "raise exception: %d (%s)\n", excp, name);
     }
 }
 
-- 
2.55.0


