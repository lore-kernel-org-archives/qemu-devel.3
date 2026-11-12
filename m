Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB5606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXm11Xt8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DyafAo0l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZPW-0004qo-UJ; Thu, 12 Nov 2026 13:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZPU-0004nw-0k
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:20:32 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZPS-0002GJ-5s
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:20:31 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZCFB2593491
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FCgIjv/pWl2yYBVV36DVmP
 tLkMLR7YdVzxsgNMr28Ko=; b=ZXm11Xt8iwl3976VkBSbzudRnUFQVhOzN9I1Ni
 JsQe/2dd6aIWLzKi3cHTtm/6iL4PKVd9Wa0yz1khy7ec/dFoVTm20Z7//K6v/oXa
 LqKV8u8GcTO+baNiZ946qLdZuchkwpMd43vXIWK+OOh5/HtYYOAjTVElb//p5NPS
 YX4cLUk1gRObeF0KFonFwEAsCEt3mt7IA/00gZNSpE2ccpeSkipxCvJ0se1ZK/nT
 HjFSownseIJLdKOXRD6HZMPTUzKMVEa2zUOzHNBcVTYaDuqKhwgpO2Fz9dS//sqk
 41bCw239Abevae+xxsF7kzmfhz3bEw3cC4mzT9EXjBfshJIw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx31qx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:20:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2c7a903a1so14545137.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794507627; x=1795112427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FCgIjv/pWl2yYBVV36DVmPtLkMLR7YdVzxsgNMr28Ko=;
 b=DyafAo0lm91yZWfmgQ7HXwUS9J481z8kvmU2Fc8j9/yKvJ86Yk2VqM8cIjdkJFV08U
 jEcq4XKM/3ovoVzG9r3CBLqDFHamiA+sS9s7vE6f0nUzUi9n4/3X3VV9tRJokL9nCy1L
 48LWfe4UdI1d7jE7mQ6fzxmwGdasJDPftVtD9JbLdCIC35SzdHd3UQxoz2/PjP8FXF08
 ALPJzYkuPRjwsf1dVmHvMbKzE+zvXyHirRs4/3u5hl5rDYMSZeW+MZUtcubgy0R4UcFE
 t8BPD7NZGmtGxSIXLjGRnDil/JXPOT3r1wWls75e7qepzDqYnp9EmSVfHhE+tG5hnYFO
 mQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794507627; x=1795112427;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FCgIjv/pWl2yYBVV36DVmPtLkMLR7YdVzxsgNMr28Ko=;
 b=EfNVW5rOXbQTaGP4ansUhKl8K+hTnXO8rtFfHgrJUDX9toQWmnYgoNqdp/sXY9ofaR
 /CbJgTRHhzl5zmIREqcY0vCFJVWFAjYYe1aZH0Jc6pwhRSWQ9RuTpTycAVaWlQdtRGdV
 rjUgHSMfEKNNFBC6v/2XOat/EHS4TopXJUutGp6znNfeL9FnZB57nR9MbyCasa3tqoO+
 weVy/7pWknxqQ8nWci7Yyxi+MZG1SIceR7OYkJILEomn/OVTn9cOE/i6yy90LxSdbs20
 G9xI88ZHQpMN3DztqcduvMT38aUlWaiRfOZyswPA/r9wWMhVHm6NhLgSU1EL2VT4w59l
 Vpzg==
X-Gm-Message-State: APuU4Z930PWDW8xxVX7hSK9OYd1rd0dJ+CRlbR/Uc2j6MWTN3Jye2t9b
 wraUgPAXf3dOjm9V2tV2wAQiCBcaR0w7IH3RmjsFLb25P1GG92KEXWERUVmDxw+6LJ0riSB51wW
 fg9XzhC2Mg+duaUOnz5zmXcwRpRwbBoVnbblqMzTEos6IpVd0gJ5TGqrCgQNAzIbxEfzJ
X-Gm-Gg: AYBFou3gGtH9wUJe9xv+jNVTbx0OpjGVWg5AouwSTF2QdMiJjMh082P3NExNuc2y+qx
 gAB+fPiw4d2YDLAaUDIMaJNdkHmg0mSxDNvxK0S7U0nZA1h1NJOmrUOn2DWNbVONqTzkjfz9Dm9
 0PxUhD5ttn4QfOFZ4zXNoQJXdCzbZaIGZcxxveoF1dpBeUMeVe99SvwhhDqIZZ7uItI79CAFRMu
 yL5aJAMv2KjBDaTJoLPFGYRp1pkAiVsliMtDm3e1oNM094KsllSBydPsDySmKIFB/6RbmcDsIdO
 JrhvTkp8Sg5y23UvPiFEQOky0Yhux0514LDZzOrqXcbORdVylrimPSC+Qlla9UIsLHKceIF9BP1
 mkzJjauoSS+j/1dndq/AhsmmVNilKjAwqfQxYEzGX1Y/yoc3gHUwpkbsALTLKBdSd2Wea2Q/+87
 4BxaEeIePjBUstwg==
X-Received: by 2002:a05:6102:f9f:b0:7cc:1192:5636 with SMTP id
 ada2fe7eead31-7d64d6c643dmr13972137.12.1794507626654; 
 Thu, 12 Nov 2026 10:20:26 -0800 (PST)
X-Received: by 2002:a05:6102:f9f:b0:7cc:1192:5636 with SMTP id
 ada2fe7eead31-7d64d6c643dmr13957137.12.1794507626088; 
 Thu, 12 Nov 2026 10:20:26 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29daa5sm93110075e9.12.2026.11.12.10.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:20:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0] linux-user/microblaze: Unify both endianness under
 qemu-microblaze
Date: Thu, 12 Nov 2026 19:20:23 +0100
Message-ID: <20261112182023.87415-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af6036b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=zCytL104nfFYwS_0angA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfX503jhS3TpVmR
 tR6aMQa6HF+jy+rxKKEhC2St8bDO9fEcxkrrb8B5ExbW58QC5R1ymNv/KPg7cNfR6RkCHQoTc5y
 7wktm2WTLSBLXGd2V6fqHw5saTg3yCjVpXTgUNnCg3AZkgcvnJ8R67d0q5jOCumaGPebC1tk4XS
 ZwM0+j9vdp45+4OOSfTSXJcc1vXgqIRWTgwLGcKP+XuFhkEg4vrEOegD69zjsf4L8iEEV9Tlrr9
 0otwT/+7x1MuQjM1NT84VOEsEBXH3QjM0VC0g2JQLvS22+5Ib7cQ4qzHMMfqMWf3HV5/fkjs8uJ
 zhmr2xhibiesR6sGzn7tULYu9zwqvugOAoieuV+NAcNVfvuUDToeYQr0Haxg/cGvjb9lUO8r5rH
 NbZxBqVP2y1/EaddVIhN2kw9SiqJ/AVJa/2W0WqaWs0Tjl8MnIHaHPX/OBYuJSs9mUwgNHdYmZG
 pZTkphMdsPPvgMyL23g==
X-Proofpoint-ORIG-GUID: dRjMafT6Z0i0rQCzIZN8ZSZ8zU7n5s1w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfX4G0cqIagKsNA
 Wx6xHT0ASwwAKUmjaDtJ/R/b4M/z5D++qjCEjGsLwPjpp5ce7SelGOqe/krBz2zcwmwXj7E4rgo
 Lski1s/F9KPC6WcYgppTHlAaIEDgLJU=
X-Proofpoint-GUID: dRjMafT6Z0i0rQCzIZN8ZSZ8zU7n5s1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120073
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

Enable runtime byte-order selection for microblaze-linux-user
and retain qemu-microblazeel as a compatibility alias, removing
the separate microblazeel-linux-user build target.

BFLT stays big-endian: the format has no endian marker.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Based-on: <20261112180859.85380-1-philmd@oss.qualcomm.com>
---
 configure                                   | 3 +++
 configs/targets/microblaze-linux-user.mak   | 2 ++
 configs/targets/microblazeel-linux-user.mak | 6 ------
 linux-user/microblaze/elfload.c             | 4 ++--
 4 files changed, 7 insertions(+), 8 deletions(-)
 delete mode 100644 configs/targets/microblazeel-linux-user.mak

diff --git a/configure b/configure
index 14b484908919..051301a62f77 100755
--- a/configure
+++ b/configure
@@ -1114,6 +1114,9 @@ else
                     armeb-linux-user)
                         error_exit "Target '$target' is no longer supported; use 'arm-linux-user' instead"
                         ;;
+                    microblazeel-linux-user)
+                        error_exit "Target '$target' is no longer supported; use 'microblaze-linux-user' instead"
+                        ;;
                     *)
                         error_exit "Unknown target name '$target'"
                         ;;
diff --git a/configs/targets/microblaze-linux-user.mak b/configs/targets/microblaze-linux-user.mak
index 31150f980c8f..f6f2703661b6 100644
--- a/configs/targets/microblaze-linux-user.mak
+++ b/configs/targets/microblaze-linux-user.mak
@@ -2,6 +2,8 @@ TARGET_ARCH=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_RUNTIME_ENDIAN=y
+TARGET_USER_ALIASES=microblazeel
 TARGET_HAS_BFLT=y
 TARGET_XML_FILES=microblaze-core.xml microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-linux-user.mak b/configs/targets/microblazeel-linux-user.mak
deleted file mode 100644
index 5dcd4b5b183e..000000000000
--- a/configs/targets/microblazeel-linux-user.mak
+++ /dev/null
@@ -1,6 +0,0 @@
-TARGET_ARCH=microblaze
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
-TARGET_HAS_BFLT=y
-TARGET_XML_FILES=microblaze-core.xml microblaze-stack-protect.xml
-TARGET_LONG_BITS=32
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index bdc0a953d593..a0ef859e1728 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -8,8 +8,8 @@
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
-    return TARGET_BIG_ENDIAN ? "any,little-endian=off"
-                             : "any,little-endian=on";
+    return target_big_endian() ? "any,little-endian=off"
+                               : "any,little-endian=on";
 }
 
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
-- 
2.55.0


