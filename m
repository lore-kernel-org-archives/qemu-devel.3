Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZR9jHVO1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CANAU0IP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwT-0007qN-MN; Fri, 23 Oct 2026 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwH-0007L4-DT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwC-0002RO-67
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE60Rw4063556
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fx+cuwoOzYuOIKIwHmqqJHqd/hIMCN2JUJAataer1s0=; b=ZR9jHVO1rDRiQ2Cx
 x/Wj4TAxe4ePqUFoPePj5rjvse16duZOER3N4ydJ6pxWCIteEiGG1U6kD4EXDqE5
 fLu/61tDYmRQND1Vnpn9yIZRIoczGbmbu7EHywXhyWukjcyc0j+r/O2c+kCCMeAd
 f0j6qRX6uuDmleNTIZruCuvjdjv/k3v4eAdmgAbkL9y75VirZY4KGKgJjhvbWvMM
 nYZRgFaAXWaRATqFsVwUHTRMqpHNTyXXRE84Jb0Sr2xzZUDI1yUdaCxtk6Tecp+W
 l6cuyTlMQOP7/sQoO0rYtgLeQvimiKt3jCeSVhzjtDbzTl9dhcPcbnGHcBN2ZU8C
 s7NB3Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso260769785a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772170; x=1793376970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fx+cuwoOzYuOIKIwHmqqJHqd/hIMCN2JUJAataer1s0=;
 b=CANAU0IPC3b0niR6p6SZHqELpIQe7OIhqMfKrzMl8eksZoCfn08BPELH0cQ9sM31SH
 gA1GPSqtHfPOaMD9NtREj9PiDQf2QD5nkQKy9CKptzeRnNC/P5HccJnXDEaPRmhNcs+n
 7UK+nnxswuty/10WLliKglnYRhXm/mWR+12jWySy2c7yqoKAx1jgtBvZytD3baeQv+gL
 9ZOkENzP0VAFRFy47wMHDcE32zzb7d1uaMx9TqEQqu3JBnWQwDrYeS9rL1i/SOfVOnVG
 FN125PBMadOAO7E1ekvaIwWSAAI5q44UPhaqj33xDi7+mFqwaEyb6ZHn8iWWUrfVfe0n
 OXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772170; x=1793376970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fx+cuwoOzYuOIKIwHmqqJHqd/hIMCN2JUJAataer1s0=;
 b=x8xeME4lSUL6/dpPQsbUHu9ZpaRgM8xEWKtYnDUw4sQQ/zccaO06IO4W+KvV8fmk/t
 POHtCWF4vja8CK9k2WZv2Sb8s1O7s82XOO4j2x9Fhnse+oNDoUF16SouzkixteEwoJw/
 f8wYzORupR4ekp5rvOlrMpMMRuOfEKFtbMWaBpV51lW8OfWQFPes+TsOjrbdWzcss//I
 oe5IXKZKM1YzoEGKg7lfMlChCGZNOMIrZQRwHTt4CIoRbc/LzHxNSY2S5wqM7gaKqoIN
 lA/T0kJ4eD+u3mNWgomvgOTIvLirogjhAjCmtQ5qNfHCNfSzttkJ/CI4cEx0f/RW/oTV
 Zygw==
X-Gm-Message-State: AFq9FYJjsrC5XIkxAcliU5e34LWmw/ZF7TvWF75adhso0SrF9QNFJNMU
 qVlx0jLmaRkLxpDXHBJjbhT5lDjX/jr/ELTxt72N4bO95+8s3ebO7I1Tw99McAMa7gQwZeotBFY
 cx2ZizTN4P5Aj6xcJ5SFBQ3xT8iSdOEPgtnQsZzhS4MUY96SPNdSlEupaw9buBFVkBC/C
X-Gm-Gg: AYBFou37goDKOVdF7iTyRLkq9LpwYpF0cJ/zKw7pkcyamguSve8HY4W04d09370QlwW
 Mr9MELinxYDc+MyNlBNTWy3ovMCLbzkFU3Kgn/flrOn05nssSn2QpvfD2VVUPeiev8myTH31aro
 yXMQPYIUZkgACoOg1Cdsi/feOTSHtFxR3qRQrBWZTEKmVsbZuZdP8yZyPEt2Cd1l/TuSjvZ6paH
 mSU6bzcmy8Ngcw3zeZsYQoKmVPaIc9wF3jloIlIi+x1BkljURZQL5smddrC7Xs220IBA960k/hl
 F3jKbPQA/YzHKC7qTu7XyNZfPUIDJ+YM3GdVBJeBb7a/YqAeNGb/zGmKpvjff9PutdYqovqrJ57
 WIRnryZ/o/eXp0R0pTpBfAwn8w0dkc0PDoqMNZtel
X-Received: by 2002:a05:620a:1a17:b0:93f:31bb:e31 with SMTP id
 af79cd13be357-93f6f7f8b24mr523953585a.48.1792772169513; 
 Fri, 23 Oct 2026 09:16:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1a17:b0:93f:31bb:e31 with SMTP id
 af79cd13be357-93f6f7f8b24mr523947185a.48.1792772168968; 
 Fri, 23 Oct 2026 09:16:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f9f28sm746731f8f.21.2026.10.23.09.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/83] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for string
 table lookups
Date: Fri, 23 Oct 2026 18:12:29 +0200
Message-ID: <20261023161332.60153-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: om8xBYR_oT-yNpqH5tRcF7rJKG7vzmpN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXyhBFWwYpEFan
 7SmHcdm6YfDLLQ1BTyBKdmoT7/3qxCz+UV31aclRx5OYkSzzzHVI+Yfa8PJEk4EDIQUGYc6m3Bl
 +xzJzfKAluzpRcZ+AJiZ/78KCFvbNXc=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb884a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rKAhNuBlhcDN32YTup8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0R60vflh48Yl
 OAw41ELicI5A2iu8YQkdeJQ73X7BxA+NRPHrzZgGuRu2fW4kEN/loEL0WoLADknAERW6QtBOIWx
 QrMJjGAX3Jsu0Uln4u5SWmllgpmv6u/ck+I+ROcohfrgnt28Gtk9VRtwYC0FwJKVKYOIhHT71eT
 LtX3mLXQ16Y0HNvcKs1JYke8srJYEUPfStNyWXgFwxZLcbWXR/sHLdHVGdxacn56AYMGbylogjG
 svVn2tOSlp93BBVibuonwvoSMvSXf1Z2FfBhCVER2Kt6Bu4raO7TG/5vaaDSLYS8hM88lP+52L7
 rP6IIPlqyJJCvgzQFfZsnhZOsFiUdPNHk49x4qv393QIxVcJvaZsgEY7+5FKDebNc80Z2UVu6Et
 YWLeIoNgpQ1PjvtY+5lqcxgx5nj1NgbFOThY7R4j7SLU31gD2/E9x7euJUqc3iypR8DdmHlUWtn
 gMUoyurwKj8MSBrzQFA==
X-Proofpoint-ORIG-GUID: om8xBYR_oT-yNpqH5tRcF7rJKG7vzmpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-3-philmd@oss.qualcomm.com>
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


