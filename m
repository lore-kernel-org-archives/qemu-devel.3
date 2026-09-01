Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6D0C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LCZ-0003Fo-2s; Tue, 01 Sep 2026 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCU-00033w-7x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCR-0007jj-6B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179NOL1282750
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=; b=j1gbCTFs2ME0NHR1
 Si5sv9yxeLr+CCCzcdAu3+E7CiByFObb0fVykdr1nbk1tl4qDyNHF2qWGEOXnfS6
 CNi2QS1pFoA+X2dmyy2PsITZ5/0cft5MCV5XzDoSBWE2dkcB4PUv1Jk0mXASbyrA
 3XKNLcnEl6z5RXxIJ1zCV8z1xIvsLfcS198DezgOgXNJP3Ur+fRmv/lByQIzBjbd
 qGoNbH9nO1WLF4WDNp2vdXSm1ezAOhE359N2geJ7wTVNuH1DqAOPpzB5mkOcvie8
 yBcIPMs0dfx7AV57BP/g5CVZNNrF+TjiNOPlQ7wFto5pTMZ5HJ8y3rRNw8qShaQZ
 18iF9g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndx9vtp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93903982af1so1056198285a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256477; x=1788861277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=SCsZezbYHZRZ1HGeK/eIbFLy5UwIPMwEKhiGHCTUoA3HDN/krQyQL097OrnZFfcFZq
 DVW8slzfPke74zqTZBbG1r7+ufjFo6Wj+UlkHTjkhTuxSDnwcZqBCSV6eEtTxon9R7i/
 M6zCpBfJUPCj9AHL92umYdf8ey0Ibg1xiG4yepvZ8QgYlnb5jW/a4Ev0kQ5ziytuaBJp
 hHNTwZnF7gQUYPzb1lYC6HUZyfEPRKlOQ4JZZYkEkc40TtmEfB4H7NRs89ioSHPQjzKN
 24G3IhfMRSY8siffJ3rsfAObtKHSPo0TkbSiVFhg711EATEofweRpkYXRRuroKv3SzM7
 gBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256477; x=1788861277;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GkfJ0DUVwjpw7Jql39GIYw8AYSod2OF3xVsMsf7lww4=;
 b=DEvmMhrtXNfPTmWGYWcePpxgjVT+oUJJ5g9OYREHkeT7eJSX93+nJ7A+mY6tee0m1n
 rnRYmhyZQs8rwi3mFOYqvY4fq7X1/Cr7Yph/iRcmYb5v6eYoLSDKC39Ites8kg8L0vcz
 ow+mqBvkN2sV4CzqFZ8B3BrlcKtt5wqjNaI4sLm/RmpiXK+BcO7qMTmZYzJo4TJJEu/t
 VXs4hcW3Hp15cQNgYmnheuMWxFpeRxNVUyOBlTW+kQMKr8vxNASPb5hquLYXErOum/jm
 l1zmnWurSGASnCMKH1khugDA8KdpWWbz9rJQ1/tJZ0bBQTZnx6UxfWfhJNMR6HrY1ToM
 BFFw==
X-Gm-Message-State: AFuF++nKJgmk2x8/WRs3NRy0uihIJmceRUbLv6e2/SfJkOPWqLDLWyo0
 YrG+4Sa5+/YCgweRZNa8fmylWHb3gA+BAaBADfES6Wza0owaiBTCOWhxMs7g/mfTqF2izedxpiN
 2C6F1m881bbKfnuJ5Z8N4WCFyK34k/1GorfG6dAATiyvQoN30B7aiO8Noh1x3OzwnLA==
X-Gm-Gg: AR+sD12/uNUNV6m+x9UaEULBQcePPgr2/PtlKMIkDH275RasPATrtHmQU4vQcMSWv8N
 Rx//hd9yoo8YPv1aXqfXVgyXOhQE78ZsjNYq1S5mgMZBLijn+LNH/6IFuMUNAEhH4b48AkWCCdE
 mgNOVxaUbw7e+uXZB2Arm1lJek1YvgX9lTxPv5a6D+fUkxSCej9MBio6UAxnGFGS827f5P5vPMJ
 n+dQLzL3+SCgX54tWzvWj9H+HeWHhtzx4PF2gPURyDSi2TFVA3MhLjOeMKbyCCtqtIgSxZgjKIi
 GGlUiowT+/mxSbUimmOj8C2jZW6op0NGMNixfUkOyddWOgzPBR7QJnt54R4WAklHqy23o6A5EbN
 rAWgYd67/Jj/3pwmi/53xPu9qQXhox6Gk1z1BsQXp
X-Received: by 2002:a05:620a:3c96:b0:937:690d:a37c with SMTP id
 af79cd13be357-939137b46a8mr2623262485a.3.1788256477564; 
 Tue, 01 Sep 2026 02:54:37 -0700 (PDT)
X-Received: by 2002:a05:620a:3c96:b0:937:690d:a37c with SMTP id
 af79cd13be357-939137b46a8mr2623260285a.3.1788256477167; 
 Tue, 01 Sep 2026 02:54:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e1ebsm56936285e9.14.2026.09.01.02.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v5 17/21] target/sparc: Constify CPUSPARCState for various
 cpu_*() getters
Date: Tue,  1 Sep 2026 11:52:23 +0200
Message-ID: <20260901095229.72018-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HRga7CGyvUkQ6h5E4ljVIk0xoSWG4k3I
X-Proofpoint-ORIG-GUID: HRga7CGyvUkQ6h5E4ljVIk0xoSWG4k3I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXwS0rlnf5pwwc
 udIAEmFQcr8Fi1Uuktl50TpfVJd3lR1iCQCB0ChpxzJfvr0FGdDjKqHRfSGUt0YZ+RrgN/tbiuK
 M0e30WZIiGAjTWRNhkU/a6fQ7HzeZQI=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96a0de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXzcTqWYjocHhN
 ycsQ6ogt28hMT8P1ZeAzcHcTmhvApJXiECztMwXUNc6975G4Y/n3swQaf0x75PiApzjnr99tSsn
 O9p+1xJnHIe6JPw8InbE3wUBTSb/13XHj39jM2XEHUpAc1v3p9CoX7r77WQOP4Za4UXXZfCte+9
 tLb2zM6NMoV9wOtZUfX8EAZFh9N/Xy2PN7p7kVSjGgvpbq7koyic1TD+zujXa3rx+baWIaL8MJw
 +kvyFk1WadCRQp4iLQMcr5tE0U1OfMOh4/H+8QiuPJeIHpWv6NnF6XjizJ2dyS3qbyNcNrSstkw
 rv6dIHlRGz34As2ql0DAtf0G5m1fjd7tKmHJQLOJIgb7epBfM4Y9g1hLggLpyTQ+kVqvVy2rVki
 iVt+iFpyzObf+DWaPt7V/63ARGjijCSKDJstgsXqKnT9t0d/UX8KCqKY01aaRMk9ewyr2cfrlGj
 26P6OdxGQsXjyMwzvAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

Add the const qualifier to CPUSPARCState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/sparc/cpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de2..31a16c2af03 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -680,28 +680,28 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 
 #if defined (TARGET_SPARC64)
-static inline int cpu_has_hypervisor(CPUSPARCState *env1)
+static inline int cpu_has_hypervisor(const CPUSPARCState *env1)
 {
     return env1->def.features & CPU_FEATURE_HYPV;
 }
 
-static inline int cpu_hypervisor_mode(CPUSPARCState *env1)
+static inline int cpu_hypervisor_mode(const CPUSPARCState *env1)
 {
     return cpu_has_hypervisor(env1) && (env1->hpstate & HS_PRIV);
 }
 
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->pstate & PS_PRIV;
 }
 #else
-static inline int cpu_supervisor_mode(CPUSPARCState *env1)
+static inline int cpu_supervisor_mode(const CPUSPARCState *env1)
 {
     return env1->psrs;
 }
 #endif
 
-static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
+static inline int cpu_interrupts_enabled(const CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
     if (env1->psret != 0)
@@ -715,7 +715,7 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     return 0;
 }
 
-static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
+static inline int cpu_pil_allowed(const CPUSPARCState *env1, int pil)
 {
 #if !defined(TARGET_SPARC64)
     /* level 15 is non-maskable on sparc v8 */
-- 
2.53.0


