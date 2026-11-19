Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529B606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gn/Tn1Ps;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UqJCaJVA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB2V-0000pz-9e; Thu, 19 Nov 2026 17:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2R-0000pG-Qp
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2P-0006QT-1t
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:30 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXjt3367487
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tK/gif+N48LwjqAi8Q9jD3p60f+8JHEIB1JYsrX0M0c=; b=gn/Tn1Ps5hJk2Icz
 hv7kTg66C1TezK1s/44DU3ckjZdp9m2UEtQ5uXnkZWbxgOafeiDz4+U7OIb9BU2w
 Ft0Nhk9qqGTATFUoc8CIDQuc7GcarwD7hQCCImVeCfzm54ERkrh4M3cELhFq/tGO
 HimkxmWGY6b2OVG/M5S5awHh2kIm4ASdlxOj7mWm4c2QOT+BGUT3OXjZATwGwo5f
 tWIeueLHhZ92xCgkMzzgSpgweMKoPsgl0+RRuXdOYQ+ySyt7g5zEfEcejKFZD7Uk
 9v4h5N0vNIMvJQDH8TnRdeZk1AxoPfxNP55Qkdd2OMqc+h+Z8BejDGzZQ8DeO18o
 T9mJrg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rtwv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-949b0d322fbso51104485a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795128927; x=1795733727; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tK/gif+N48LwjqAi8Q9jD3p60f+8JHEIB1JYsrX0M0c=;
 b=UqJCaJVA39dXADGMILLEBveS1/NicpJ7o4h3rx3KanZQob3FdkVhTqjKvwa5Or7EwR
 zHZE8op2gGDF1vsCBe2mmHKUFuA3yAaxbqqsUqz1jJPdhcMEF9tBb21WebeQ7rPaHZa/
 VGFa0oK/ieCtUe1l6TCFVNB1cM5bC5vXZZfcABtZ6KnXJx931cUT4AyfzCJB7Vx9nUnk
 GyGFwECD7LoXOZ7HJpboz6gbspbwqufJpZ5ujQqtME1saz3uMkTdp0uoX+NdYPDnYCn/
 rFm8VjVF0ndlf8gXmXVRHior6hdG0XVNZlga+VUDkcPWwN58ztvn00fWsW57frUO5deH
 Lzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795128927; x=1795733727;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tK/gif+N48LwjqAi8Q9jD3p60f+8JHEIB1JYsrX0M0c=;
 b=fee2OIX1CcdyeXJO8mHNh2od4sfhVuxrw1ITx6n6vJw3h8FUIGK/gifvGHQtxpXoHh
 ce0wC8THSfCAlVCF30yrIRrPQavOyvv6QR+xRG8SXXdc015kSMyF8nsK+2LoKaoI5ktL
 j9bbGxh2OPBWLloJVQ+ivxH5+Yk7iD0xOrsXJnSsTXeIcCa5yrHu8o2JYoXlQtkKqnG3
 UonZ2Tz94Gn3SvFvaD8oaHtkO5j476xjEEiHls5jpXBxjj3Nug7LWxQyj3LPI6nCXUeP
 iBAQPtzg9FplzQZrkZDSzpY09jmahN2goEMxBv+IKhgCVMPhVSSbH8w4hyWCCYfU0Mcw
 TEmg==
X-Gm-Message-State: APuU4Z8jviduX7WOkSrUdhgkKw8lDOm4pppLq+v4A7eok83+ekvSE2mE
 zYCGCPTKb8ksUgGLwfkDFawGIfkeSMmxneHXr42OS6FjBJbU1ls3odERsH64AZNNFqaQ7+dh7gB
 vNDiazPeEqOX7TiWCoBeQu8X+8WCsJ8JhyNEHfQWxeGRrgRCmYc2LKnyWX9LpiA5CNkgx
X-Gm-Gg: AYBFou376+iXq1w4Ub5v8O47cPIkV2DHj8jygNmHNRfevxePEWVMbOiZ4VGaO/tPrCf
 oCxB2+ZBNhabMDfNZKa2+bKHwypM2PiAQK64jGp7qlGgEtSYASQIPAoRps28aiuqg7FRPCDcQ0P
 0RoLX8pKhkDnkpkDO3ZlriNTxAfVJFzMh4IuW4N1TXwTVSW+PQSPnwommPqmQMV5nOwozQmWL8x
 0FsP+HQvSfyhLdZxlfpWYj8hvKxFRuuY+3YHy8dEjeMeQMNWV4QucX2UXjW5egmZpxUhGPVvePi
 XF1NEh1pWgO2kzwHG/AJ9u6Ooti9lqVwwwuytdPfpH6xHXZnAJsyJe/UJ4y0htqZLtIbohyp3Oy
 iFD7IJVLLbYPV+9u3gcidA/bWOkkoHea92/A9zBUpekzx5sCh33ww5pBjgH+2gm1nJrEFfEYSjM
 Yb4QcNAOSbawBJbw==
X-Received: by 2002:a05:620a:44c2:b0:93e:920c:c00e with SMTP id
 af79cd13be357-949ba95e5b6mr212096185a.21.1795128926673; 
 Thu, 19 Nov 2026 14:55:26 -0800 (PST)
X-Received: by 2002:a05:620a:44c2:b0:93e:920c:c00e with SMTP id
 af79cd13be357-949ba95e5b6mr212092985a.21.1795128926243; 
 Thu, 19 Nov 2026 14:55:26 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm2067902f8f.33.2026.11.19.14.55.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:55:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ashish Anand <ashish.a6@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/4] accel/tcg: Yield round-robin execution when another
 vCPU wakes
Date: Thu, 19 Nov 2026 23:55:11 +0100
Message-ID: <20261119225514.4080-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119225514.4080-1-philmd@oss.qualcomm.com>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX27p3yyTrDpuA
 wXfOcUZaWTQvCBI16KGAJsrEI55mgWTr+rIWFP4sU1EWkzZilgm1BwdJLMWldBaKtRkQ/NZqFaL
 CHUTT3BFuk3Dnk3jaYKOMsLqqs/y+9Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX65x1W4vBmFuI
 X+7xBZWquJWeoH+lGUlT3+dmbDvJ41c7lq2OuSuhpne1iledz0yw8yt/fp0g5Ece36whr6CzIv3
 u4e1ANuZFJXVnZC9ajgrS46rhwhsHlU3uf+8Gex8kOqlOCwJQpl2tOuzdSz+bhPrms2Yskoj/cW
 u4XYT+uMcBVhq6h8Oprtt1leDEp1or581s6vrkRoRuc7IfPQi7UUM5c1eMHfIi/hnZjkrSgvLyo
 1wn660+aliG5gq+akSTZcUZ9Egd22YX4oZ9bB65CkpdLD9Dk7SKqMkv3jHelM6mMBxh17uXseQq
 5+rIgkE+2hb3Ls1GaL2FC0zlwC9XEcHwzg4Z1QfjJHICCPYIcDTgIzrA2aIHejSmpAagNaDeFsl
 iw3ErhjhIcAqEoKsiMPHOsmuZOFJQEjeGKwMElBGXNQRSjTRA8OX2GAgCD5rihnz7XENI70ZDjC
 miqfb8FRnyksrs29foA==
X-Proofpoint-GUID: lSL_NfVsZ_12_NGPkTo3uFMOiTQx8ofN
X-Proofpoint-ORIG-GUID: lSL_NfVsZ_12_NGPkTo3uFMOiTQx8ofN
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff7e5f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=woEEAJ7i8uS9EEgvVbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190092
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An interrupt or inline run_on_cpu callback can wake another CPU
that shares the sender's host thread. End the current slice in
both paths so the target can run promptly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops.c | 3 +++
 cpu-common.c              | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 61e0051b53be..ec4e3577ead1 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -107,6 +107,9 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+        if (current_cpu && current_cpu != cpu) {
+            cpu_exit(current_cpu);
+        }
     }
 }
 
diff --git a/cpu-common.c b/cpu-common.c
index adb76b3a786c..d518d1f40e81 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -148,6 +148,9 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
 
     if (qemu_cpu_is_self(cpu)) {
         func(cpu, data);
+        if (current_cpu && current_cpu != cpu) {
+            cpu_exit(current_cpu);
+        }
         return;
     }
 
-- 
2.55.0


