Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C2CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBv2-0006RM-UB; Thu, 18 Jun 2026 08:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuz-0006Mo-B4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBux-0001AK-5a
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArtAS1536484
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZLd8YVfy9awyQdAa594INoAeCEgmcGu7zFRRGOcoeXA=; b=WuDKpuh1neDIU+XB
 jO0L6SxrEzY2E4DNtDtaG6Gj92rgywujyKOc6bFdUbctPPrmak/tvNNamkIFWqJl
 3PVeLugW157qM9ao+5n9RNmNL5POkJV4+srOFw5D9JqHBwhIlhijukBYfa2O2woq
 tuZvq1AUReffAxBV3cTgzDs7HrLlv1kuypyOhO7cr8jblb/sZUMa/LEioTL+xbaS
 iwp69i4y+o9i+oF4d2eGnHjxgXx4ePApiYNx8GYfFDyQHVBf27ub0LSwPfwPCJ3m
 tvTt6A3dMc+IfBHmtYEAFcIrrF+8p27XEIyOdrtbJWRzVYTcsZKm8CBXQvjALNY/
 bn47bQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkd3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:22 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-48687e7f161so1882448b6e.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785941; x=1782390741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZLd8YVfy9awyQdAa594INoAeCEgmcGu7zFRRGOcoeXA=;
 b=OjGGgvDadft/qJYyk27/+z1mMGVhZooq7ZS4N98q5zBJym6+c45+r0Iz0yDvfX1SYI
 apNZhowKlJ/GBXhi2glqkfhbX/S1b9bZfiyvacIj/nsibT+HFWjyqW9GPlZcRJLJZmaS
 kOZIac0tw2byr3T8GFlHgTN4cFLfjqpn1wqG+2Taek/pNYA9nAaL6oWRSfzzVRrbJRVb
 S875ws/g/A6LKBtRw2ovdPPkXP656SLIgA1A574wCNGkN7/vl8cIZ8dCJffr0UfTJ/Hs
 PwzYQPg+cynmIx91gAftQQ8Hf1tU4iLeBCEBfqNJ9lDSeATQn830AR+voIaLQNAj/5el
 awuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785941; x=1782390741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZLd8YVfy9awyQdAa594INoAeCEgmcGu7zFRRGOcoeXA=;
 b=Ah/r62EqERm8yfGcLXidqZ+rOZ+FFo1v1EMm5eXPjR6nlfFZAct/P2nvNJ6+9v+lRK
 PujltU+99Fzaa4Ax+Yk34a+n/YEIveO9JFyiid0yj+ulaFk1b9lRe2BHsV/Hg1IC6jeF
 GYRohNfWztpvzT4+qOamjn6fqIATy2QRnMaPl9v7Pgmp1iTaiing72I5qqHoQTmT/ML9
 BANNd9IME9GSkUFhQT9G6RC/jE0WNxPQhnnRg6mVM5DQPXEIJd2JF7459MBEM6nrq0Dn
 C8pDvIUDmhP2QxqKyTamJ1m+t/Eo+hRPUAjUu4NBYLPgjn0PXNdbl7ppmxIRKAyS212K
 4lFA==
X-Gm-Message-State: AOJu0YznuJnV6U4Jg/l204Iixu+Y9gv7PmtfTVAw2kZoHYk15a1WX7ik
 kA3XC8OXBJlXQBbvKtmM2Z5afQR3aE/ol6F3MQoLd0TEgctdr59iG45zjUfhPmisitz7NGN3Uwl
 ja9JCmdeol4/4cGzUV5BMCA4l/N0708tNplKRUzBkbPdGyWNhknl/cu3UExSQ4+WIOA==
X-Gm-Gg: Acq92OFjxU0iTSeSxqZoap2qajRBecc9gggW2KQpDDS2YQZlgM51MnEyhqWnRotgVPH
 3a83Vk9mZjIAbT7Bw7sQgnL9GvilVoQJ7inTdueFtxX9NXF7P9LXhPM6o7JQXWPMd3jL9ygBsEz
 BGQX8Xk5xHt4uGSuIbb4ElA8tPdHKS3shfToPNI+qM3onkF2CRBT5cDYF3CFKcs0phCimWOHUm0
 yfjt6ApOC4528vyGC0KzEROIbJwJPFM/Q8BfW8E7KmdahkNuEdxKsiLH1kmmYDuAll3qfIO4TfX
 wL4t2yXCxAre9Igw6AO1bQ/yEMqm0fZc4BiTH6a1DqSathA0XxINDrl2sXPyuAdqqAS/Lmks4Sl
 ONvcz5NH38sdo2vfRCaDelftsBBQ6iWN4NvyvOYub9kTeM2L/ctMziU0FuYvPfI0xip56
X-Received: by 2002:a05:6808:2007:20b0:489:5cc2:4d5f with SMTP id
 5614622812f47-4895cc24e27mr1204311b6e.26.1781785941194; 
 Thu, 18 Jun 2026 05:32:21 -0700 (PDT)
X-Received: by 2002:a05:6808:2007:20b0:489:5cc2:4d5f with SMTP id
 5614622812f47-4895cc24e27mr1204300b6e.26.1781785940691; 
 Thu, 18 Jun 2026 05:32:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm35005285f8f.6.2026.06.18.05.32.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/48] util/cutils: drop qemu_strnlen() in favor of strnlen()
Date: Thu, 18 Jun 2026 14:28:09 +0200
Message-ID: <20260618122825.90331-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9R3FO/Ij7KNs
 ZK3CfufZ1Qs6uLJEuGgCc/uEVVPrqQB4u5U0KiNdI0U4Dt77wonfv61/ujZVKnQPUFANU/6aeUM
 Ed55qN0eCLe5gJg8T4+m43mnn648ZBKDfmVw/WApHokKdLYEvpGMBo4X4RIWtxICUOFeJzSVi6i
 oi4uMQX75eDunaUOoO5NlBboQWLO/I5APSvLwNWp1zMdAKvfsSXbTHOQGaBVjjaxRacFeH9YPcZ
 gptC6cncFSGHUWc/+wY1koTNTFJb4b1FX4lQ2l0+6/PhyZfPpYpiOsWWqgeDKEgEKbllzoaDbrw
 Rlpg/YN2vh3f5TBG0zav7jllvmon7cZ6tDbZMxF+EDseGN7eXY3elXTihnYZ4f8PlEM/+9IoZLU
 CaqO0Cjgtl9Qnk9/VOPKgHx62Jwa3HgtdawNqMnZYMHfdptcBkvyR212N7RpzuAtpwONAJ0XnOX
 AD/fz4kdCh219YbYrIw==
X-Proofpoint-GUID: chjPrEAC9T6WCgXhipd6p253IgXvBw9z
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e556 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=SRrdq9N9AAAA:8 a=KKAkSRfTAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8
 a=Q5y4zV9Sly_M5p4mRAcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=cvBusfyB2V15izCimMoJ:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: chjPrEAC9T6WCgXhipd6p253IgXvBw9z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+42/Axc3WbxE
 IGsLA4LHfsgCFpOa9d9Hi0wOdAoclrwNweTfOshjKwHm1J4WFAHQ5B/e0caAUgou2PPCeOWyeaW
 ec1Osvkustl48MVF3mw41MI9EliBmgY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

From: Bin Guo <guobin@linux.alibaba.com>

There are only three call sites, and strnlen() is available on all
supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).  Remove
the hand-rolled wrapper and use the standard function directly.

While here, align bsd-user/uaccess.c to use size_t for max_len/len,
matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.

Also remove the stale qemu_strnlen() entry from docs/devel/style.rst.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-ID: <20260530062816.59206-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/devel/style.rst  |  1 -
 include/qemu/cutils.h | 17 +----------------
 bsd-user/uaccess.c    |  4 ++--
 linux-user/uaccess.c  |  2 +-
 util/cutils.c         | 15 +--------------
 5 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index f4da16a0e83..6c5f94cc509 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -519,7 +519,6 @@ QEMU provides other useful string functions:
 
     int strstart(const char *str, const char *val, const char **ptr)
     int stristart(const char *str, const char *val, const char **ptr)
-    int qemu_strnlen(const char *s, int max_len)
 
 There are also replacement character processing macros for isxyz and toxyz,
 so instead of e.g. isalnum you should use qemu_isalnum.
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 36c68ce86c5..d249f226766 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -101,22 +101,7 @@ int strstart(const char *str, const char *val, const char **ptr);
  *          false otherwise.
  */
 int stristart(const char *str, const char *val, const char **ptr);
-/**
- * qemu_strnlen:
- * @s: string
- * @max_len: maximum number of bytes in @s to scan
- *
- * Return the length of the string @s, like strlen(), but do not
- * examine more than @max_len bytes of the memory pointed to by @s.
- * If no NUL terminator is found within @max_len bytes, then return
- * @max_len instead.
- *
- * This function has the same behaviour as the POSIX strnlen()
- * function.
- *
- * Returns: length of @s in bytes, or @max_len, whichever is smaller.
- */
-int qemu_strnlen(const char *s, int max_len);
+
 /**
  * qemu_strsep:
  * @input: pointer to string to parse
diff --git a/bsd-user/uaccess.c b/bsd-user/uaccess.c
index 89163257f4a..7ad4b580f44 100644
--- a/bsd-user/uaccess.c
+++ b/bsd-user/uaccess.c
@@ -43,7 +43,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
 {
     uint8_t *ptr;
     abi_ulong guest_addr;
-    int max_len, len;
+    size_t max_len, len;
 
     guest_addr = guest_addr1;
     for (;;) {
@@ -51,7 +51,7 @@ abi_long target_strlen(abi_ulong guest_addr1)
         ptr = lock_user(VERIFY_READ, guest_addr, max_len, 1);
         if (!ptr)
             return -TARGET_EFAULT;
-        len = qemu_strnlen((const char *)ptr, max_len);
+        len = strnlen((const char *)ptr, max_len);
         unlock_user(ptr, guest_addr, 0);
         guest_addr += len;
         /* we don't allow wrapping or integer overflow */
diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c
index 27e841e6510..f9bd713edd7 100644
--- a/linux-user/uaccess.c
+++ b/linux-user/uaccess.c
@@ -99,7 +99,7 @@ ssize_t target_strlen(abi_ulong guest_addr1)
         ptr = lock_user(VERIFY_READ, guest_addr, max_len, 1);
         if (!ptr)
             return -TARGET_EFAULT;
-        len = qemu_strnlen((const char *)ptr, max_len);
+        len = strnlen((const char *)ptr, max_len);
         unlock_user(ptr, guest_addr, 0);
         guest_addr += len;
         /* we don't allow wrapping or integer overflow */
diff --git a/util/cutils.c b/util/cutils.c
index 76a94420859..96c80d4d429 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -54,7 +54,7 @@
 
 void strpadcpy(char *buf, int buf_size, const char *str, char pad)
 {
-    int len = qemu_strnlen(str, buf_size);
+    size_t len = strnlen(str, buf_size);
     memcpy(buf, str, len);
     memset(buf + len, pad, buf_size - len);
 }
@@ -118,19 +118,6 @@ int stristart(const char *str, const char *val, const char **ptr)
     return 1;
 }
 
-/* XXX: use host strnlen if available ? */
-int qemu_strnlen(const char *s, int max_len)
-{
-    int i;
-
-    for(i = 0; i < max_len; i++) {
-        if (s[i] == '\0') {
-            break;
-        }
-    }
-    return i;
-}
-
 char *qemu_strsep(char **input, const char *delim)
 {
     char *result = *input;
-- 
2.53.0


