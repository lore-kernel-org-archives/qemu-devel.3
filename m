Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l/S8f+Yw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aTv13yLJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZEZ-0000aQ-Ui; Thu, 12 Nov 2026 13:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEY-0000a6-1r
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEW-00036E-H8
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:13 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFaBL41112608
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P1uAtvxC00J36ym6pdmfYyfKIuBnQlzkKk9c0joVQOM=; b=l/S8f+Ywp87gIvO7
 bhgdFYNQvbSSKV5jWnIH0NfdLz5mRSKj+/RaXsPzjP+j+cv/IcFvquhppiat60Xj
 OCq6po8Ml8oMOSNYeqa1b6E3PA3TpYCLO882rfI7DSpULMfF2uFdPuEi9CQwQfOh
 nBlbQ5nO2EKrfqJcetvqW+SES4laQjXovuEc3fL80BC9Rp4l2pHup3HmdW0Ri4sg
 9E99pqHe6Nhg4GXP1WZBxHA+RfwFOeX01QOBJo3IedC0LAVbK7+xvYQTlAcynDsK
 SfloES2/E9GlkEM9QR0OjdaF8KAllOzLQLrNi16dh6RQxZYaqDPd9yvRfTC5or45
 Whdu8A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re2wgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:11 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso58984241.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506950; x=1795111750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P1uAtvxC00J36ym6pdmfYyfKIuBnQlzkKk9c0joVQOM=;
 b=aTv13yLJEo9FnveYOVhEUoIAb799tp+geoM9Fr06WARzDRZ4jpR/7IbQpu+joXyYP9
 qvxdZAdtw3YRrHl1OYl9D/bJhKX3bBcFBHn0OUcxCAZywmMF5yOrM7tpaneI/E8GcGxa
 Go85EjP3V4CDMJIDzB6c/cq4RDu2KHO2yMxmVTZn4jUEK7Zcvrcm+T+tlVDYSKRj8ze2
 no+bAeH1FZi+I9zTmzeHVXKREqg+fKCAySRBE7t6As/P1/+jKmTDAJYzwJ4k7mh1NnWK
 mIe4jhzzkb7y5z5kZq6r1zWEjzBfUvPVDalW1QKx0B88TG0KpH8ZxMohc9F3DZdlVEN6
 XeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506950; x=1795111750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P1uAtvxC00J36ym6pdmfYyfKIuBnQlzkKk9c0joVQOM=;
 b=A2m5ThMiOxR/P1FAMcEh3DATGF1sTQzlHCpK/NEfOZg3fG/YNLSrgdXoeCyf6C9khr
 IPjIJGBQmj8lqDatT8Ycc+57w4m58lgXQfX8++egEniEi0yEsOlpdXI7mAdqbYfpdVvH
 4xkgoPnbb9DzoPazg4htpJst7xsuaNM1r/oWmKWiMn1W22DFJ3/1jsjnjDjskdC/smCj
 BKohzEQzaL+xAvTvwTlV2swYzo+GpvRBAr1VKE7WkOKzenL81jED77qRkmfkh1VBQgBG
 ADeK9rUvg3sBS5VDF9B5FdPNl8vrHml41qyPQNYFB5mQE46fIPXbewmBDexygbMGzY+D
 auEg==
X-Gm-Message-State: APuU4Z/GTXZ0lLvGgRqeLDIrhHnYKMujLIZ+lElOlR3xhAx1vlT+eP5T
 +qBvu2DA3oDgoXI4vgoBiRWCOciWi6MnrT9dmQQ0O8SflhDnSiz4XTbUfOrdLGwl7taRKhjRQ79
 agP+MlK6bfeM557DS6jppdIr169D4nUAu4C0cYEFF4S9NSQHIgJfxQK24b8JsxA/rNqnO
X-Gm-Gg: AYBFou1h95tZP9RDKVoX6BkBgShR+mftk7olwr0Ea32dyJm/g++VD/T/vaDhV+Sk3FB
 6mSl6VeOmYAah2mHi8kGZrUG4b/ISJCPNNDhf4Wx2LxqqLRgYxKoJgGM4CGuk+gk+6ajwB2zR2X
 ndjCgbUpMexrOPVCYeaUlSvqFgCICf27N9SuoD4qr4vqomhH+uS+W6EZUDMBm8djljb8kU0YFbY
 ypAXLsVUvZq9KQB8mg2fPxJOR9UE6lVdH4DkEKXgQFbz85l/3GTF1WQru2O/LUMB0Myiz71no3T
 bv6GvS/BzwZ+LQp1pQH1nxdUJgafGqRDrlAx0VL5hLyB9lH5Upl3Kx0TfApnL5k7Mt96CGsYkrj
 cwFL74zVWzEIUDIezHgSYokb9iMbDDCsoWmW3KweBm0Ddm2qCZlEkzmKK18QQDyL6Bf2fX9Ji9l
 o+RtI0u+Szw9AM6g==
X-Received: by 2002:a05:6102:3e90:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d5060d344bmr2043329137.30.1794506950010; 
 Thu, 12 Nov 2026 10:09:10 -0800 (PST)
X-Received: by 2002:a05:6102:3e90:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7d5060d344bmr2043313137.30.1794506949463; 
 Thu, 12 Nov 2026 10:09:09 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0953159dsm76215395e9.3.2026.11.12.10.09.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 01/12] tests/tcg/aarch64_be: Check data byte order
 in hello
Date: Thu, 12 Nov 2026 19:08:47 +0100
Message-ID: <20261112180859.85380-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6MRtF2rw7ofb7j6fdqmc1U0XcMVlhk3b
X-Proofpoint-GUID: 6MRtF2rw7ofb7j6fdqmc1U0XcMVlhk3b
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af600c7 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=apfC6Sr15dbh0XQO5jUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfXxo3Gm/y/6wBj
 ZStTJM+dfJ0G51FJf1+SeGKwlhL+Zr1H6lcLRTbatNaTcLS29u2vmfGb7Z90SjhPGoyHrO5Qzkz
 c9MxaEPy9B/RYVo+LwLxFK/4Nffosj0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX+EYd/HpadZB7
 npOPzkFfw7RMBbfPcs+4KjwO/OBUnJ6YSMTuzj3RIfNcVkPwGtPJMGnGspB1Y3+so5ZNKpqF0KH
 0bfyn872Ydsz8A2G05207YD7zfxY1BnvJ37rDMQPw6OBkqWAkZi5KvyVvo0wDEy+oiDuK7AZluM
 VZMhoBBjJT+1ez+nU3L2240bad62Om8i2uYaFd/Hi9f7B8mcqWIoKP98kcvQeTC1h2gWnUn5pJn
 LakLnc6FYRGSpouNCezSxNp4lCnfXWaHX5tbPZDacK5yIB601xAeALA2b/7WXfWfmKFJKspZhDS
 ggWuV0HaAuECSRn91ugLIFoTj5ll+3fJWcoJiwAozXTLxEsA+gBAeGafOmnz0ILpJz0Ss4QTfxQ
 fGpmMzm1KUuGw9SmUqu1uS32DqO1/Cw7l6QaHYjQPzOedw5SnfmnF6zIB6A2mu5LtX4+dNjsfLL
 k7gIvphVA1KJ+OazCDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
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

Load the write length from guest data instead of an immediate,
and fail unless the syscall writes exactly 12 bytes.
This detects incorrect CPU data byte order rather than merely
accepting the ELF header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/hello.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64_be/hello.c b/tests/tcg/aarch64_be/hello.c
index a9b2ab45de9b..18432d3257dd 100644
--- a/tests/tcg/aarch64_be/hello.c
+++ b/tests/tcg/aarch64_be/hello.c
@@ -7,16 +7,17 @@
 #define __NR_write 64
 #define __NR_exit 93
 
-int write(int fd, char *buf, int len)
+int write(int fd, const char *buf, int len)
 {
     register int x0 __asm__("x0") = fd;
-    register char *x1 __asm__("x1") = buf;
+    register const char *x1 __asm__("x1") = buf;
     register int x2 __asm__("x2") = len;
     register int x8 __asm__("x8") = __NR_write;
 
-    asm volatile("svc #0" : : "r"(x0), "r"(x1), "r"(x2), "r"(x8));
+    asm volatile("svc #0" : "+r"(x0) : "r"(x1), "r"(x2), "r"(x8)
+                 : "memory");
 
-    return len;
+    return x0;
 }
 
 void exit(int ret)
@@ -30,6 +31,9 @@ void exit(int ret)
 
 void _start(void)
 {
-    write(1, "Hello World\n", 12);
-    exit(0);
+    /* Force a data load to check CPU data byte order. */
+    static const char hello[] = "Hello World\n";
+    static volatile int len = sizeof(hello) - 1;
+
+    exit(write(1, hello, len) != len);
 }
-- 
2.55.0


