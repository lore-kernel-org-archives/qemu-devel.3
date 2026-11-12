Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F79606C71D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DRlEJmlV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSBa55d7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVQc-00078J-GO; Thu, 12 Nov 2026 09:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPq-0006i8-Dl
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPo-0007VH-Lo
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:04:38 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAfTJV1954234
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=; b=DRlEJmlVJWeoAEAY
 YIXXMpeTS2nklJs9zqz1ZbfxwQ05JsisA0jptsa+lbL1ux5tv0iMLPhcBvf0G/eY
 O+e5OyYd2TYwJP4Z9pXr0KH+EJusNQGbzXlb536RlQbXKzD9xa2JdiiyyYz/SqJB
 JM4QxWo3lSsWOSGGr66VzYpHMeIh0HBFjBF2EDo0Y8HC3VqYdjAQU6WOpfEy+65E
 gcIAnKSK8iiTKQful3qfQ4cwUGioWC7C575HzX/PRyKyoa5C2leWY2K0GSM0ZuYq
 G4KmqMk035k8OtVlNg6LfkJE91sDF+kBGN7IM+f6Ea6ZDrqy9UGyy1aWJsJFqKmy
 M6VyIQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx30p15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:04:33 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c83124d530so4925264e0c.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492273; x=1795097073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=;
 b=CSBa55d7PxQI4rQX1d/94uDuFnIun1O+2O4HhFJ+mnoN3nBonrBfYolLLEdF3b+oLF
 9N7j0NbZIOlqPGCDCVYccmo5RUuQZsUTEVDAquGy1qzDnHsyK6wcBDngvsVf0Fz+QU4D
 e4zC/NMVe+CypwPTVNdYxqPYMj5t5oKVJMV/BclOiZF0SyH73YbNOl7Bzd5+v5uMz+Xd
 6FKoTqCmxB5HyZJZexI8kVL7VFEx2LXv6FDZERZ8tymIwnqMQFqvKb0Y0uDD8tHtqCjn
 ZO6fEWK8n3+dGQM8xNkUFTMXv7Jmy535xeIUPfOK0iZf+1a0nxcgGZnw09JLUbKwRuVz
 odnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492273; x=1795097073;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=;
 b=drVNoGIoxaF+TGbEMt/LJ6Y/uCTacrkfJdV4KN/8zBRxnCTsdGgZdHNyv/x09SR1L1
 kZLkgOQ1VWs/v8r//2u+EmqGQ7V3UIawlyOuuaZlRrU+aA2dk5Nx+z5p3Q2tb1TsNRdR
 ZHh4RtIai6FqetgDm/5sL2RFAVh7rpdTcTJHw093OFrZN23VZP3Kui3X3TM5KRS4lGp/
 QlZ5KGde6vkp021n9Q24WKKKKdr1IQS9kKmmGw8i+Tna70u4YA/ycRioOXIW13K2MEUV
 l8Y3HDHZ1gKW3ssr1fwSpESGkqR7qKjFtMWh/3EA78nkdM614yEA6DdDNk+JeXMXBiZz
 v5cA==
X-Gm-Message-State: APuU4Z86HqR0TuLQ8O4tr9VyuLBXJuMmg3AX+HAyK/yXXogL/1byvCCc
 CnTPgytZjhUjqNKKTRLPEQ+2iK8/ky0JqBXEffBZLy+r7DDXQBep+3GO8eEjIhsm8rgqyuMfFSr
 Jzlu2sxgEwSPJFGykIlEiIXYAQpjBt3JRH+89tNVyMzqZq1bFLc4syMUr21Q0mDMaaUEo
X-Gm-Gg: AYBFou3Ufq06u+09L/EX6MfG2GcKuXDIX3ISH/6fHSQFGYERPGzg5IitImLBQ4v/ifM
 eOZC6Whp0gR9mFwZeLLFxCave9jZy8KygeJPgUKUfGtNOv7+bJiMVZbvIzZ+7ofB8HQvDWkdBex
 bErf0CzGPskfDdCJ9xzFGFmhKMdH2bUVd8nFjBXrh4auqV/4K2hhOH4nJNEfYJ7P89oLaXK04u0
 0tFhMF8QFKwP1ZKk58eEsJZ+R3uK3yMn5l/vieKgPcq2KIaY/CQifJCePBkFIK6NX34iadVhI1O
 OXbdr0fOhd2Jkq03XuHyf50hqU3MDUe5K7FbRHCDtft2OUljkplZn5DW+g0C0I2USJ1NJeUOmkA
 d3bmeqzubak1UIqqNHsB9Cjz/L7GqaJvO9q10ocD47O+ZKGZ5pa7xaXI+0Hf5AiLSjhLZuhFnrw
 5ZV6hRCWydfiQ/nQ==
X-Received: by 2002:a05:6122:3c51:b0:5ea:a1ad:6376 with SMTP id
 71dfb90a1353d-5ee1c2b5e30mr2711953e0c.1.1794492273028; 
 Thu, 12 Nov 2026 06:04:33 -0800 (PST)
X-Received: by 2002:a05:6122:3c51:b0:5ea:a1ad:6376 with SMTP id
 71dfb90a1353d-5ee1c2b5e30mr2711913e0c.1.1794492272517; 
 Thu, 12 Nov 2026 06:04:32 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e258e8dsm111259285e9.4.2026.11.12.06.04.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:04:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0 6/8] linux-user: Select target byte order from the
 ELF header
Date: Thu, 12 Nov 2026 15:03:41 +0100
Message-ID: <20261112140343.61634-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af5c772 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kZLfmvQpzMa1BZTGQ20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX/u4F2K2qHAtx
 cjOeDZUOoBVQfryXvqmPEgPJCCqmcj0fcaA8DyzcQFXtIqqyUpvt7Rg7mBaaz3AVyctL90eTq5h
 g0itUpyltL+lC7Rs2sXf2j0ARZhutnDC7UT1p7PPZu7PkdsG9wotNciX52iEYuiKkUbvGngvYdi
 nr0K5ZLfn7wSENistS/SLlh49I7kr6akzkRKGZ/sqL9/wNxHaMmly7GYcgwer2tpYUTdHfFNOnG
 jZ5YQpuXwxFL2sqZRvydfzi5MmMcbdN2a+/NRMTGmcLS8h2Ji7q9FrQaqWJgY07Wrp3E8AUj7v0
 Kz8l/yYJNOEqDqG2JQXVUggg3T8mqZ9T+4m9QKwLOwrJWOsi02ZUnAuclpXO/PqT3Vq8Ux3FYjw
 CD6N/Vb3YrFDMlFx8CR7AWZlZLGYpEJ+y2zIFgG2boTP1S/mkNVtlu9hG7zBnxLPoy6/UlDYUYa
 tw0fXq47LNssArKhK8Q==
X-Proofpoint-ORIG-GUID: Fdc2IOO8-rqcC6XD9ZkTc6jZQPZSBvfy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX7FSBk7zL12ue
 ORrh/QQDhJ3xIyjpBdbqM4DTooAUTdMAMnRV/g1Js/yAS72dvXhiISGogxLdMnTmj4iVbVrpWMB
 GZjL30YF1gDxMmNpIIJmig5Gj/5dWJk=
X-Proofpoint-GUID: Fdc2IOO8-rqcC6XD9ZkTc6jZQPZSBvfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055
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

Read EI_DATA from the executable descriptor before selecting the CPU and
loading the image. This also covers binfmt open-binary execution and an
explicitly selected CPU model.

Reject invalid ELF byte-order encodings without using the invoked
emulator name to select an ABI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/main.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2f0c0a50c8a4..71718f974f6b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/accel.h"
 #include "qemu/version.h"
+#include "elf.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
@@ -769,6 +770,31 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#ifdef TARGET_RUNTIME_ENDIAN
+    {
+        unsigned char ident[EI_NIDENT];
+        ssize_t len = pread(execfd, ident, sizeof(ident), 0);
+
+        if (len < 0) {
+            error_report("Error reading %s: %s", exec_path, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+        if (len == sizeof(ident) && memcmp(ident, ELFMAG, SELFMAG) == 0) {
+            switch (ident[EI_DATA]) {
+            case ELFDATA2LSB:
+                target_set_big_endian(false);
+                break;
+            case ELFDATA2MSB:
+                target_set_big_endian(true);
+                break;
+            default:
+                error_report("%s: Invalid ELF byte order", exec_path);
+                exit(EXIT_FAILURE);
+            }
+        }
+    }
+#endif
+
     /* Resolve executable file name to full path name */
     /* Keep how we started the program in exec_path, e.g. "./my_program" */
     /* Store real path in real_exec_path, e.g. "/usr/local/bin/my_program" */
-- 
2.55.0


