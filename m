Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F262CCF9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRx-0002N6-Tt; Tue, 28 Oct 2025 19:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRk-0002Fo-Ra
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:49 -0400
Received: from p-east1-cluster6-host10-snip4-7.eps.apple.com ([57.103.90.228]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR4-0004q3-AH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:47 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 B0B9618034F4; Tue, 28 Oct 2025 23:49:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=RQfGDhZ4RUZHZEjwdTSwWBJnMpGjZt55WjAucF76QqE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WCmLZWtI3yjAJFskWqYzcLRTymRGG1oN2rZ1G68qVQQvu5rYXKU9/6bpJgBloC2HelEH+ELAf7MfQRUx1wedWZ+BYHKXRDE0TXo/j4n1WyfV9D/DFnrrsjJN/D3dSfSkeWPznCMXcw/z5lk5KgL3u08SEMX5RjW9eXm5gRZGLKLFMHEtQgPy/VUWu9ZuTSlLHKoeuNox9qjkucqFTxmarqOlvesMJ/YKb7sjH/llFLgu+Sp/4HPyQs2jFbgav0hj4ChNefhxo3Vnoi7/0ge5vrKNjFdUtErGSzf6A3wKqVa3b4gzW57H6qaETtx9DJml1eNJ3M9oBTzmT0OhvBEYdg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 D2F3218034D6; Tue, 28 Oct 2025 23:48:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 25/27] MAINTAINERS: update maintainers for WHPX
Date: Wed, 29 Oct 2025 00:47:55 +0100
Message-ID: <20251028234757.39609-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cLNL78CJd1caDCr3FQUIrurmFTXb3Bty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX+1h2s+kVVXMg
 FlHdkqPVgo3FBpae0SGx+vs5FVdedjT3pHfsmM4ooIZNLLbb8aKegD8rXqfJn4EZ/w4bM5A/gqH
 CsM6aywqi5voAHAW04lUiTVKpofQHIHuChaTIozlvevkZm1p87gw7rXxXdf0n2W1pORNmckHl10
 qGmOhf+n8RqMtL+u1ZrxR4kRT55bXlMPI9HNCxQDCRb6lPbLbm3n1lj9HWhG/SWLOIendKl8Mmi
 PKmPQCua+9+ba2JZ5XNHY5omNGEk5VV8aKjPhJz4PYIG5hXkxTK7nslc15hxuLUwQv7grnovY=
X-Proofpoint-ORIG-GUID: cLNL78CJd1caDCr3FQUIrurmFTXb3Bty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=744 phishscore=0 clxscore=1030
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABBrEO8/fjlN6JN2YYDtOO7AbQTSDuoP+JV3Co42W3CMUIGeG4qfDX5zB77QZcBPzDP5X/hTA2kFyVgbytPmsQ+JHSos6qbPJ7VbuRfvjnbYRD+NbjZdsnghl1E+tWKY27gQm237r97+2QcSTmQPXcrIvU2jet+nS770yOYlgmhPngoCX6NeTbiO/BL26RZgutMsV3UwAhjmX3H6TSBNVR2Rcz+zleN+8JmxG5LAq4L+XySA6OsTwXYeJoTQouGC12lZn4/ZD5/o54oJLKtsEdihzsH3MhZD5+fe5tWDGJYCojQ62TlGHYk3bZciY1pZ4cQKTsTjBtDW/Z+IpcdrSJii/q6lNo/cg9bjB9cNxb86vQ3J6zsK8NaHkbSzwDfleifJ7SOlc8Aw/usJ7SoB/UTc9jYoN1v9a3gQ8xXTUuEhKVUR72u+oEkWcIZPTUc5eWu6jVvpOakN4Z9PDqOT1nVTA1Em8HIPkRHC0vlorbjeRFC6Gbf5M65DGnTisCAqAAHTYoghrMnFtDtoNqETr9lBtD2i44GMiBl5WjfRp4FJ5irzfuxtHQujg0R2UmhC/VWnuwyymM1Gt88wnGPMfVrg0dYM+bH5UjtfYA6KEUySjHKKqHunLBxk952rgOUvjk37DFo3KbU5+7aDGVbIWqLxt6jeQvC1fRLByBmhqf3lorisxLzcpUhJJGtewVm9OVJVBV3Ssl4WIj6p3q78LeeD7lBWzEXNHBCNvn
Received-SPF: pass client-ip=57.103.90.228;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

And add arm64 files.

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6b7f45459..0e7288116f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -546,11 +546,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
-WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+WHPX
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx_arm.h
+F: target/arm/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.50.1 (Apple Git-155)


