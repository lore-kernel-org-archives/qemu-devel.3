Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A05606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAydWfBt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kgfq49hu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwY-0002Dc-D8; Tue, 24 Nov 2026 18:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwI-0001fN-Ju
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwH-0007xL-5r
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:42 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMbK1F641667
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eZZyNVZ6mvQ9pqco7NrGNsOyfiGbP0HVidYMKzB2CXw=; b=CAydWfBtAMwYdUp5
 ZC7qLJ9661eiIwxif15lcIv/eSz7vsClxoxX+9XpUPD2y0sLNPuovWArgRCowlZ1
 JHBjBra5pRoi3K/NLU4NcPvdoSX2dkO7Q+vBn7aMU12xc+mw2EGzhg+Z6Oxcyb8f
 cNF2HHVSn4f7Vx4iqQlc97GCl2abz9UQhPfAFD+4H/e7NngU4L+s6tHNc7SXwxIe
 pOz8s84uOYs2WlGlt/IslKQ4Yh3dqzUwinjeptNVNby7RSYDYZOSQRHzazRGMZoS
 lW7XJaPiGWUtndjef9Xtgk/3dZHgn53TjYl4ReUi2WIedJZsrBq0dqQ3LWNj79jb
 CKXXqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effsfhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so802046685a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562919; x=1796167719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZZyNVZ6mvQ9pqco7NrGNsOyfiGbP0HVidYMKzB2CXw=;
 b=Kgfq49hucUiiL5vthbKlg7XHUyysYU12nn7yAWP+bqjgYyMRJUGtMeMBm1vVioYawk
 5vtkilmepS7JEyuccCrJkfPfqQ3TSRRskl80do2D9Sou3/wqT6vy3tcK8XCMQRsFZrEd
 BvgYaOjvuOlXR4oKkpTYCC1m337bU6inif7jLubIsOMh2v6UG2OAHJyQW1tbT9VQgJIi
 64ztaR2xtnva5Hqmiw+x1/vVq63PcxFSzTcg0Q6Y7kjf40kVHwhPCPXOQ1BCjRq6P0Qc
 NbuIhy3tVghVl/dde41PYaVWcJu/GSyhuQKHMciPA+sBIOWNYfS8AFKEx+ZTlXTAn1pc
 3T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562919; x=1796167719;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZZyNVZ6mvQ9pqco7NrGNsOyfiGbP0HVidYMKzB2CXw=;
 b=eyTzZsekJ5x/RMQ3MN3HNUVVd/iuiawe8ZA4ds+0O2fTJM9NbEbWbh5aHSTHqE5INZ
 81qG/JMyMx1/bHjvzMTHoR0L2mGni93GjFcwb9oFxtWD1yBqZC5iTEsmMU94fVuvsx+z
 mvnvNBAmFJDoe+VwqpGqzov4NlcUeQz4VqCy1Kmg8NkpIMOo6u6MH/nflUdlJ38T/oyY
 jMvswwpDGSXnVbK/6peDF/wq6nqmNXnyVHAxMXCo/thkYbKURtqS2StmUzgh3mAERDv/
 NKkCruIvsAKDzkpf6YjUyMG9tW13VxGTqfa7sNIye2duJm6GoRXZtpWzrEviTFA4yW6c
 pJTQ==
X-Gm-Message-State: APuU4Z94uwN4wdcMiDcIJmY1plNnTsmVQ7zSivCspJC3XqTmDJ26S8qk
 kgOX0cBg11/MT+b4WZ8uLG26mjP5u5MyUh8dImqnLHznE+imcCuZ0kL5nH2inWJiQSDJjV6nL5q
 K/P9xUTZxLoCQT9JIQQAdryBdHR0Xt6y1bJ7A9zmct5AsOHbKMTppq2/zwk/3Vc+vPfkQ
X-Gm-Gg: AZFdTZeEHOJjTElK20J1A32TXiZAOLvkxmFRDk8ewiS9/g3wwr+UJtXCOd5kP4NEVh7
 hgPUexb+9JRP8Ak8mOMHnhxBWhzxrnhElzWpTHWavkoE0AMTyjczUhf/3P7H02xyXFSvJow/p/T
 EPQWR4lRmID3a7IhhsLFoiqPhrdBBdmozH4SBe1wXRb/v5Voxi9iWakrwfJq/qB7MI7qZ+GtGlT
 h2Hf8+6iiFne69uIRmcnf4sEbZnRrJrAYSzaKPVJhhfBtXqrH8D6er8kmYVXGrmn5g8XzWuKYAI
 974APg199XMBwaJDmxro6WRYIUp1ZZXQZL989votGc8LZwvyuahwe3VxsTqCqY5iAn5TbSMqi7w
 7o9v8z0i60KNPRNngUr3zgNp/PPyurEPjfyhID+gJ/F4775STEDl5/TmWxkKxD6W+dbnxyDIMVv
 Dvn73bc+9WdlW5WQ==
X-Received: by 2002:a05:620a:4008:b0:949:74d8:4710 with SMTP id
 af79cd13be357-949baa12788mr2868742985a.67.1795562919518; 
 Tue, 24 Nov 2026 15:28:39 -0800 (PST)
X-Received: by 2002:a05:620a:4008:b0:949:74d8:4710 with SMTP id
 af79cd13be357-949baa12788mr2868739285a.67.1795562919005; 
 Tue, 24 Nov 2026 15:28:39 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm565772295e9.6.2026.11.24.15.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] target/mips: Fix reset into microMIPS mode when
 Config3.ISA is 3
Date: Wed, 25 Nov 2026 00:27:14 +0100
Message-ID: <20261124232722.90234-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b061da8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OzHiCVVnrDrB4rO0jAQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX2i3JYOLEnugj
 cuw76fq64ngWCtmwG8myMUbUclTftoPON2gmZb2B+A4CggYfNwYqipHmqlWTaS68snD+raN2WFa
 BopUtoS7hQvYP2g+iwE+WHoQLEbIFO0bFhj7cieaV8ZAhySmaVK5kj02NbujbdUI3n8LjqW0YPE
 iKcpworF+VQBJVSH0nQjNZMiGkHKajtyM2Qh8+kIiJlwyj1seOfDpDCNZKsC6ZsHwkO2wBE2kDl
 SyypCrXGuF4NLpVAcoyJ/sB3pSKRsIqyUzDrMp4SHpIA0bAeDqVdV4FXR3UR9ZZV1uhuk7DIwGw
 GzoIyK3i2h8yPHFPkEhpmF91+3mf69A1G5jMn1QgYIivOyMzHDNujqBECUGa3sWIJSivoBCcE3d
 L9n+j84yf3YvnTPfG96t7rgwp8VJqf2v5wx1M9MSpDhlL9BDJPOyWAfsRTrLPH9hjxSKSOZZkZW
 X5fJznPMkGRy6y+deQQ==
X-Proofpoint-GUID: peE8gcf346zulHwfjH6DpuAs0XkU0LNO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXw4n6ubiyQEro
 Wictg8gJonSFP0bIuIcAhbmlFeiiegdVpc3d87Cn1dqzYFfQ8RQ94qqOfyBuE1AYvrndtjxTBUK
 iLnhlWKRinJkdD0yNgfiysox3bTkc4E=
X-Proofpoint-ORIG-GUID: peE8gcf346zulHwfjH6DpuAs0XkU0LNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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

The Config3.ISA == 3 test ANDs bit 14 and bit 15 as two separate
constants, so it is always false and no CPU resets into microMIPS
mode.  Test the 2-bit field instead.

Config3.ISA == 3: both MIPS32 and microMIPS32 are implemented, with
microMIPS32 used out of reset (MD00090 rev 6.02, Table 9.67, p. 248).

Fixes: 0bbc0396809f ("target/mips: Prevent switching mode Config3 ISA bit nanoMIPS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-7-philmd@oss.qualcomm.com>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8ad5e49ade41..324e5989cca1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -459,7 +459,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         env->CP0_PWField = 0x02;
     }
 
-    if (env->CP0_Config3 & (1 << CP0C3_ISA) & (1 << (CP0C3_ISA + 1))) {
+    if (extract32(env->CP0_Config3, CP0C3_ISA, 2) == 3) {
         /*  microMIPS on reset when Config3.ISA is 3 */
         env->hflags |= MIPS_HFLAG_M16;
     }
-- 
2.55.0


