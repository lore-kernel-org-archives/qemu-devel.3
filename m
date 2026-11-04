Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2E606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JjMHi8O5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V0WvObPS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcMq-0006Je-1d; Wed, 04 Nov 2026 09:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMl-0006I2-MR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMj-0003fk-E1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:31 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4EIWIC1503297
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dAnyPv0Lgq8cf7gE/G7eR+Fs0DmNpStWwyx7er6AIoY=; b=JjMHi8O5uzRkXLLy
 iRMhVsN7Lnq1c+vZ4V+vA/kD/f06Ed/VPKuB7HWHeZ/6OIbCVyrhlNul6CEH5u21
 vJH8hIugF6/UrUh1ul+nG3mP3UPxCl18DhztTQti0cD+IUKJ+vK0G1IbRt0Qqc+E
 BC0OAGOH+pSNI+iGQ4SgQWulxq02pmpHEuXt0hVxlhYLAwXl3RjA1cwoPXQ8sfAi
 Pm8M1VkoH7O9xnrsS8Ut+T6QIXwf1IZx9UFM7ZgbzqOicuW5yNqC+oHQZ+6Wb6Ss
 o4DM2DyMlzNUIdDPak+7IPw+JQWxGs3CnCM8Q9wyrIkf2C0NxiE6fKimYLRiXHTA
 vDysog==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6br04cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:27 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c0f07b4e81so192820137.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804007; x=1794408807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dAnyPv0Lgq8cf7gE/G7eR+Fs0DmNpStWwyx7er6AIoY=;
 b=V0WvObPS5GLvVmhPb3sFOxRxWoxX2fnU5GbtM+d5wieCJx5Gtnvw+mpZlReqgrSK2b
 x9Rvuh7qNkR/cGaFkPeywCk12+ncpXQf+JlQrjuWAOv6lq/ABXXG1FhtQZSTsPRQ/pWt
 U/w9Zylvz2hRKoQMPbyS6EwYF+mM/gele7DsVSv83Sw/EMctPw7XSuO4Mdv/zplCaW/y
 lpMleVeUH1/r3IuIxLIAgTKfrQ92BJb+185uVk6p2wCfIttaRoQnQIIo6FxWTr34FbgH
 h84UjqNFqquuyebRB1o6gau2zJUhBh78lyRg5CoMZ9h9NFzPttVt9b7gPADwojJ+wjKx
 CJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804007; x=1794408807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dAnyPv0Lgq8cf7gE/G7eR+Fs0DmNpStWwyx7er6AIoY=;
 b=tdqP0Bk1VyuquGt60++a3k28cPdHXesKRL3VYrzbCr5QH8a0cqwKS1X4QVKJK+ixVc
 QNETGj4vJ0NPQ0kVo+hxbNbcxUr3lhiI4fKKRQXj3cYH2joBE+3sdHoSWX6jX/ChW/zv
 yejte/823WcI5m+H9blMJNLS1uX8ExRyBDA+hH1xo5XiuTQpII8aUkfYE2sblijbXTuh
 y/qcII6uLbbmrHPfY8YjTFke13xp1ml0MZ6IAGcwrmKk9EeaLQBOYLQh9pAYEavJpQeW
 Cbdr5t7o5LGWlkinWSlMSjGOB/7bEXWv7jUUqIqtXyKDi3sL3U5eWhryQGyYE2BcUrOI
 xN2w==
X-Gm-Message-State: APuU4Z9pRzVLxq6RNqGcfjWmziZQWJlXK+KQ5Zh6iaqeShch7YrrZDvh
 zz4iNyfTtEgLYQFcAJo7LlMh9svggc1nAYVYmJFRIc3N5jUFw4lm0YQl0yAe551cJajMjYpTK6h
 FdRPnWByYy2ZmQ6aQuT4u82kXSvXEj8tZfUdQGySy3mj0n3xD5S7iksQZnOn2BSIwKQ==
X-Gm-Gg: AYBFou09lJTG9clocQLg7irge64M7eDqWosJNVHllIY2J+34AgVr95vlJYuCVxyB2RU
 RxOCm5oBINDkOS/Q5JGnA58bQWsADW89LelJaB4AyNSeGhr0xT+h/VB9dB3SyO199EFprBUTuKd
 sPRHKOxdnQhMFDQjNOx2zuFrtDcxJLXTdtMT5n17KEskddRuy/kcQm2b+rKFXoZxAETkD4n7X/u
 aFP4rUg3R2G5QfrRCb/xzPPRWWv4KoL5zX8qipSSnqAF4rcjju745TJ6JZD8F0FehYfSGT+DDio
 QTNk7ag1HmnuhQrdO7h0ePyaWkH5JsJYTakjUpo5UrEvR0BnED2dGQC7GNSS9OC8e23K1UB95B8
 mTM45dD5qqB36tn2ovFVvGKfCOT/G9LZ/vVg22bjUyDFWfhLamXvcY5hSTBNH7Psc9PFAAlqC5z
 vH6B3X5fPox3pMkQ==
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id
 ada2fe7eead31-7d0725ceb28mr5287382137.12.1793804006593; 
 Wed, 04 Nov 2026 06:53:26 -0800 (PST)
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id
 ada2fe7eead31-7d0725ceb28mr5287371137.12.1793804005717; 
 Wed, 04 Nov 2026 06:53:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm164016535e9.5.2026.11.04.06.53.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] tests/qtest: Use qemu_hexdump_to_buffer() in
 qtest_memwrite()
Date: Wed,  4 Nov 2026 15:53:12 +0100
Message-ID: <20261104145316.18841-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104145316.18841-1-philmd@oss.qualcomm.com>
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfXwaAMtb0iRZEH
 67TPJPgXlX1oJikaObrQqrcIKe2DeqxN+Da3UZapsZN+V+V95cuEqcScdIWxDpzMbv7bZle00iI
 qUM7faV9eyByKQBEiMzdTIeSHikLqSPTpSmemc16ZV7NVrBy0w1EudPOSqceDwvub/9dcTkrUrz
 BTQWx3P+OqSuEsBolzj7ZufxD7VVkBg+q7hzPhlAfUgNXOmrzcm/G2kQ4RPplAyqEAcznIvByaH
 SITjckIe7vN3a5DsneqQ4VziSEKfBnm9T1CAjAfyYZq+HZ0hDv9JEN1kkxxU29GjtKfGJ7ei+01
 +hvGZqYeNhVIVG9Bp9ZioWvX/NiaLOyUN0VdcRD6xfG3UXP9Q92SoeOj3QM6PizD3cFUkHzkNCt
 zAQMxZveKVnKAv4oqg3ODk8hcvBVb0KhosltEHc/X7kGMsSPHbqDdB0cIe1NAvdSI00aIR6xYpP
 UEODCNpggFz2z6FWsRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX3CYDlc4Equ24
 M1MkuTdxXl+BOKVVxJMJFKyuMjxI5liZfMl7rczstRSm4bXd1Q7S3I6OqS4WZNNZEMU3RbfDuuK
 aJqc0wyTWrn5mKiICLQp9RJZsLI7GXE=
X-Proofpoint-GUID: 2pwhq4TzA5ni7-Pkd2E6Pxkr633d5yKn
X-Proofpoint-ORIG-GUID: 2pwhq4TzA5ni7-Pkd2E6Pxkr633d5yKn
X-Authority-Analysis: v=2.4 cv=futJ914f c=1 sm=1 tr=0 ts=6aeb46e7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=k_a3swXMNwr4Ts-8P3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace sprintf("%02x) by equivalent qemu_hexdump_to_buffer()
helper and silent when using Apple clang 17.0.0:

  ../tests/qtest/libqtest.c:1522:9: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/libqtest.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3b6..b6b9f8fe161d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1509,7 +1509,6 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
 void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
 {
     const uint8_t *ptr = data;
-    size_t i;
     char *enc;
 
     if (!size) {
@@ -1517,10 +1516,7 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
     }
 
     enc = g_malloc(2 * size + 1);
-
-    for (i = 0; i < size; i++) {
-        sprintf(&enc[i * 2], "%02x", ptr[i]);
-    }
+    qemu_hexdump_to_buffer(enc, 2 * size + 1, ptr, size);
 
     qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
     qtest_rsp(s);
-- 
2.55.0


