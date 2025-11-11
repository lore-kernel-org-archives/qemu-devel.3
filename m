Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1B3CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 23:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIxOA-0005Ae-D8; Tue, 11 Nov 2025 18:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nmosier@stanford.edu>)
 id 1vIwNb-0004X6-6s; Tue, 11 Nov 2025 16:58:23 -0500
Received: from mx0a-00000d07.pphosted.com ([67.231.149.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nmosier@stanford.edu>)
 id 1vIwNY-0006bo-Sp; Tue, 11 Nov 2025 16:58:22 -0500
Received: from pps.filterd (m0342464.ppops.net [127.0.0.1])
 by mx0a-00000d07.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABI5d50032276;
 Tue, 11 Nov 2025 13:58:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stanford.edu; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps05272020; bh=WHcEqo/EFBnmLQwi/AMt
 +0DUYs82gRLPKcS4RTKm3J8=; b=c3NvdVSgqOg2kPRxYF7PJkRJFLETWw37KIPp
 9CBxiO1pMtqiXA1sdK0INp1497PN7wc/SMxX30PaejBuXML1UPdAWaxAuUA5dJnS
 XGafsmHLjG9FeV8Us1C7eu1ipwG1jE6dlUZHP6euA2b+/9hLDTqIkyWmzkUbjueV
 Oa6PVf/6MHQa821yTBZYkTMqT6MTokL+l2g8TJiSNoBg922t4OSXCyqk5fN5qCHt
 SnMyabnyhiYAUYF5LxjDAV9NcF9/1xSzc/iWXfaUPz+IZLMWvCd1J1ciOQ/xWX6S
 PtBVqZOMl2O9cL99khPYFEuQUuqvjrISOagFVsI0uXociEtvrw==
Received: from mx0b-00000d08.pphosted.com (mx0b-00000d08.pphosted.com
 [67.231.152.67])
 by mx0a-00000d07.pphosted.com (PPS) with ESMTPS id 4aat2cdfyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 13:58:13 -0800 (PST)
Received: from pps.filterd (m0342825.ppops.net [127.0.0.1])
 by m0342825.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 5ABK6AnL018059;
 Tue, 11 Nov 2025 13:58:13 -0800
Received: from pps.reinject (localhost [127.0.0.1])
 by m0342825.ppops.net (PPS) with ESMTPS id 4ac14as7q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 13:58:12 -0800 (PST)
Received: from m0342825.ppops.net (m0342825.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABLup1N019486;
 Tue, 11 Nov 2025 13:58:12 -0800
Received: from smtp.stanford.edu (smtp4.stanford.edu [171.67.219.72])
 by m0342825.ppops.net (PPS) with ESMTPS id 4ac14as7q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 13:58:12 -0800 (PST)
Received: from cafe-cet.stanford.edu (cafe-cet.stanford.edu [172.24.69.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: nmosier@stanford.edu)
 by smtp.stanford.edu (Postfix) with ESMTPSA id 37F059810B3;
 Tue, 11 Nov 2025 13:58:11 -0800 (PST)
From: Nicholas Mosier <nmosier@stanford.edu>
Date: Tue, 11 Nov 2025 13:57:52 -0800
Subject: [PATCH] i386/tcg/svm: fix comma operator typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-i386-svm-vmexit-typo-fix-v1-1-49f0414472cd@stanford.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG7C1FfUq4kJt1Cz80JaiiHc3O
 LsZeO+BQJ4pQJs94Clx4GMXUXkG0zrsCyE7cdCFtkpALusKQ9owbXRxxHifB8584WgnUo01Tls
 DMj89Sf6vu/59P5LlMPVqAAAA
X-Change-ID: 20251111-i386-svm-vmexit-typo-fix-b5ce1954d254
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Nicholas Mosier <nmosier@stanford.edu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762898291; l=1515;
 i=nmosier@stanford.edu; s=20251111; h=from:subject:message-id;
 bh=YqhdKP8meyPzJFhYiJEWqdaXljbVXMoDtp0iAJM+Uvg=;
 b=IVi0HYNN8k2PRA0iGacyHRtY7lBrPsGL9WJeIff895jWoFVSUNWSl3O2JQf0KD/0CSkkvF7tL
 PY/rkH8kX4EC44UlMqoMU3wh3MEe8dG3rHhejTRtq4Y8A6QTUxOEq8U
X-Developer-Key: i=nmosier@stanford.edu; a=ed25519;
 pk=XjjXNIba23ZoFYPYMPd0ZwO7G1YZH4tzTWOg3crqj+Q=
X-Proofpoint-GUID: 4wwLh2X7e_5l6v7eJAKXP_IX76WPNOot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MCBTYWx0ZWRfXxxGFihXIatMW
 qGtSY868mOUPfegtwJmHoqRBOaaSUN9YOf3xIamfh80C7tMAJms8VGTy+Fw+RVuveukTD0AufbT
 MVS0g+G25tccTeFnsbMGteGnEJEp0CGrqFS40izEcUJpoDzQxBsNUtfqwRXWhMyNrEczlrvz5rD
 2fdTu9t/VbZx2gW9l+4UEEhEa/0QFc1WaUhDtl/fCCrXeEGRF8owyRVUSIqXf4muZiqeNsuURCo
 k6YD8fuXOK5nMkIJxzoHKpeOx57viZVi1bGrYJb1c+knbRNbreg21EyqxYZgxC1S+gdb0QbOaoS
 oudcfOZQRfcIAQEPb7TtS+sQQDYtvd+GfnOVOD3h4uLxXWHXQxU9c26jJUEskq6ry+qW66FVMuF
 mHFAcwbMO5v8uqtDR7tfSXGYTLGNlg==
X-Proofpoint-ORIG-GUID: Sj7cvKuiDwTqfOSyRBfuzMTeAO7NvGyz
X-Authority-Analysis: v=2.4 cv=cZjfb3DM c=1 sm=1 tr=0 ts=6913b174 cx=c_pps
 a=O10p7afQjo2e1L+5ghj5Aw==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6UpETPYAqtAy3kfSEAcA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.149.169; envelope-from=nmosier@stanford.edu;
 helo=mx0a-00000d07.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Nov 2025 18:02:53 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A comma operator inappropriately terminates an expression
in svm_helper.c. Replace it with a semicolon.

Signed-off-by: Nicholas Mosier <nmosier@stanford.edu>
---
As an apparent typo, line 742 in target/i386/tcg/system/svm_helper.c
ends with a comma operator, rather than a statement-ending semicolon.
This doesn't introduce any functionality bugs as the code is currently
written, but could easily introduce bugs in the future if a new line
of code is added following the comma operator.

This patch replaces the comma with a semicolon, as the original author
probably intended.
---
 target/i386/tcg/system/svm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 505788b0e2..c32cc7ac30 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -742,7 +742,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
              exit_code);
 
     x86_stq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
-                                             control.exit_info_1), exit_info_1),
+                                             control.exit_info_1), exit_info_1);
 
     /* remove any pending exception */
     env->old_exception = -1;

---
base-commit: 593aee5df98b4a862ff8841a57ea3dbf22131a5f
change-id: 20251111-i386-svm-vmexit-typo-fix-b5ce1954d254

Best regards,
-- 
Nicholas Mosier <nmosier@stanford.edu>


