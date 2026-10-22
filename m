Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11E606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKXQ+koQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LsmGljIm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hI-0005TW-JG; Thu, 22 Oct 2026 17:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hE-0005T0-Cd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hC-0007Qm-Ea
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHJET4086740
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0zOHhVfcnk8ClPfH8JEJRN6TyBoJJQ/WQL3YEwK9vhY=; b=EKXQ+koQMQdr9xGS
 lx5fg4r0chpDh9aiZnwEJ8veP8wwocwsytCz54+kZ0Tcdh+JbfFnjM8lHiyV8gP/
 mnrD9akGUdN2bufGcbo3zroh0+bTO1tqeK3eZLqxz9F2/t3Jnj9yHCTgGiGLV6L2
 h5qIjL6duKQcxB4jKvhPztqTCj8LGMEQNEAzAyjyI4bk9DBADd774mxPPaUuJNdJ
 KXHWdgFMsTLt67TI8x9ABJUxRcjAde2T2e7s04TBoAZjUTiAoXZ1jQlOltaioOFI
 OQXhTJ47a0SX/WsI8aIzyQy4DhiJneEZNwAQ9nj7xcp5yAaFgsygjf/L51EG+ORP
 cWlYIQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrpgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso43149285a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705892; x=1793310692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0zOHhVfcnk8ClPfH8JEJRN6TyBoJJQ/WQL3YEwK9vhY=;
 b=LsmGljImQieKTP7RTdNmuOjdkxRYoGdTtUFLfEtT7VAbC4rlbg2KQuqRltUgYU4i17
 oqZFFtkhn6wp/naLe+43qdguYzmAaCCsqsCyDQptAJWIgFLUsmB9mnmwpJsgucj0jpYo
 b2vb0Iu43WLwW43PUVMYVar2jnmYhD8D3f6cctkN7ZHbvQqC9kDP4v+CKLmD57imhgUo
 rZqpSpXLfresvkRIwK6d4PuOXREQyTJPzR2kr53QZD1oKE6mwNqDpoiTVEUcihdd52Fa
 TwwRjZZ2THQb90xzR7qVFfwlOZy18FpXp7FPfddrl6xCtExXL6vFNNKasQDIm/xvv7yI
 f/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705892; x=1793310692;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zOHhVfcnk8ClPfH8JEJRN6TyBoJJQ/WQL3YEwK9vhY=;
 b=YMJu4saxOll9tcAuaADB9A0lC+0ekO24hgf7AyonRj+bgErkceprje+w6VuJoHBoQI
 axSURknpIj3NtYCiBcCCUx33gpvGCkKoKLvksYBvbKvr87CsgTHcxDLbZdHdnL1TLoyp
 kso008epZafoeB2EViPmZdt0HlKklirEbyfrK46xJHWNvpvjUZ7IaUW65hp3dO3Tlk10
 toQjFEawv2CLfB881LZki/DNSJ6ipJW4c6jT/qJHMPHe3mFCpYKHow2PiPQPKLyXc/vX
 C06AxYN/qH7t1K27PiccIgRMzJUMAEPEHLW6ES2XUtkNHZ/UxqkHV0q6q7wIXW8JqhMQ
 FXyg==
X-Gm-Message-State: AFq9FYKej6Mq56mjfB7+ZQAuEupr+VWPGJmhBkLrUjgUs8Qjm2TdFWpz
 c4YZrMkQwJCnrQRXKCwIavrSHpawntqFMlNhBTyQJ2FRrQ+2UXrBkaNUS5pZYNE5yPMX6IndU3+
 Fa8q2IsOFmdDVM3FfpT/7yP41DeC4jfUFJODbDRKl/bQpHSHVOk0pQg6U+LehgLCSTw==
X-Gm-Gg: AYBFou07dePdAxn/wrOa9hvvuZWg3tZg3BrKi5pn3jue7lHxWJUxpk67zMzkFFFdJ5W
 yDKMDb0FjtrvQ5E8f5zEMhXPpDvRN9V9o4888prhZGGRyvoFqTbV0PbXvVTn3MmPpaAqWO3r10J
 ayH6VcguE6jztrgP/9l/J1+Ka09dnQfg1o67UndZEnztR2bTAkps/Eii6NEuJ7andnwOIWZriPd
 LQiXuEZ1tAbslLaFtJ13SqjRwWani7lmks0u+/c1S68R1QIVvByl/sNKZHee7Hw3jpMcJKv7wg7
 xyHHtmmT/0778khMXHBYVmvArpVL8FRVs/fsDbUVeAKErCPtkJMArL4+Aj3GOtULDfnHDCupfZf
 15nt+slGxEWgZyxPXa+/N/DiBEpRpm1+p6ACcNVuZ
X-Received: by 2002:a05:620a:1b9b:b0:93f:47fa:b71a with SMTP id
 af79cd13be357-93f6f7840b8mr144790185a.20.1792705891651; 
 Thu, 22 Oct 2026 14:51:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9b:b0:93f:47fa:b71a with SMTP id
 af79cd13be357-93f6f7840b8mr144787685a.20.1792705891127; 
 Thu, 22 Oct 2026 14:51:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211b898d2sm10474065e9.4.2026.10.22.14.51.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for string
 table lookups
Date: Thu, 22 Oct 2026 23:50:42 +0200
Message-ID: <20261022215115.19680-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada8564 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rKAhNuBlhcDN32YTup8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: e93LLflo12nvqmTTcFtaSxhYNe-yDiEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0ViMTok+Y5sO
 XSu+2OwBZu3+kF4P5Ig0JSJuPmlEhoDhlhPSsmE0cTTxl57jjZHZZZ/T/4R5cClTTircvJiSGOl
 XZmDW9AErhIPlUFrrAmHEj5oAWOiMSWfjM00COTzcDjHGUEq6/teX2yk1YbxzX1pVBGjwavZFUw
 ulZJWfHsoQUW60Lp3hldVq8zjk9uv+BgzyGtH7XME1fgdFJXDiDmFQTszFpLBoOPst81actOo10
 nCBWgqneOg7veROoHQfCvwfIYMdezWK2MwzMsizeXVFgmTB4X+1v1LYii1TH7prNb+hz+ISR/2b
 QeO7DsrIT0Y0DPwApel5b7yRYcE9smchBwCQm7R2Wasv9hjNHcD61k7eK7rmRkf/zp86lB4si5E
 OEtTuRxfaIMKgN/c6/Sev1tOiRuWygxcQ1xvxAYQFeKo98500hu5K+sUokLNV33ZlbdYVjwdTiV
 x97a2yROHFPpgL/GJ7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5Ks+HE0d9hj6
 EOkwx0Pygrvnf6/zHCO333bWIV0V1RW7vY3H+pcMi9AgGDJnGTad+E6l6I16k1X0nzoTcMxQQCP
 A58MVLWxx2c2FxX2umxc78hZzGZQTkU=
X-Proofpoint-ORIG-GUID: e93LLflo12nvqmTTcFtaSxhYNe-yDiEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

Many functions map an enum or exception number to a name, either
with a switch statement or by indexing a string table after an
open-coded bounds check. Add STR_ARRAY_ELEM_OR_NULL(array, index),
which returns array[index], or NULL when index is out of bounds,
so such code can use a static table and a single call.

The array is passed as 'const char *const *', so only arrays of
strings are accepted; hence the STR_ prefix rather than a generic
name.

Misuse is caught at build time:
- pointer instead of array: "negative width in bit-field" error,
  plus -Wsizeof-pointer-div (GCC);
- array of non-strings (int[], char[][N], int *[]):
  -Wincompatible-pointer-types;
- array of non-const 'char *': -Wincompatible-pointer-types (GCC),
  -Wincompatible-pointer-types-discards-qualifiers (clang);
- pointer as index: -Wint-conversion.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/cutils.h | 17 +++++++++++++++++
 include/qemu/osdep.h  |  3 +++
 util/cutils.c         |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d249f226766..ad4c778ea3a 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -19,6 +19,23 @@ const char *si_prefix(unsigned int exp10);
  */
 const char *iec_binary_prefix(unsigned int exp2);
 
+const char *str_array_elem_or_null(const char *const *array,
+                                   size_t nelem, uint64_t index);
+
+/**
+ * STR_ARRAY_ELEM_OR_NULL() - Return a string array element, or NULL if
+ *                            out of bounds
+ * @array: array of strings to index
+ * @index: index of the element to return
+ *
+ * Return @array[@index] if @index is a valid index, otherwise return
+ * NULL. @index is converted to uint64_t, so negative values of signed
+ * types are out of bounds and also yield NULL. Useful to look up entries
+ * in enum-indexed string tables without a prior bounds check.
+ */
+#define STR_ARRAY_ELEM_OR_NULL(array, index) \
+    str_array_elem_or_null(array, ARRAY_SIZE(array), index)
+
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 5d5695ade28..50c7ce33b6a 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -532,6 +532,9 @@ void QEMU_ERROR("code path is reachable")
  * ARRAY_SIZE() - Return the number of elements of an array
  * @x: the array
  *
+ * For bounds-checked lookups in arrays of strings, see
+ * STR_ARRAY_ELEM_OR_NULL() in "qemu/cutils.h".
+ *
  * Note: fails to build if @x is a pointer.
  */
 #ifndef ARRAY_SIZE
diff --git a/util/cutils.c b/util/cutils.c
index 91ddadfd15a..d8a04ead5a4 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -954,6 +954,12 @@ const char *iec_binary_prefix(unsigned int exp2)
     return prefixes[exp2 / 10];
 }
 
+const char *str_array_elem_or_null(const char *const *array,
+                                   size_t nelem, uint64_t index)
+{
+    return index >= nelem ? NULL : array[index];
+}
+
 /*
  * Return human readable string for size @val.
  * @val can be anything that uint64_t allows (no more than "16 EiB").
-- 
2.55.0


