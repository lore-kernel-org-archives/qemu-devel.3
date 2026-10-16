Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBD8CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmfH-0007ei-N2; Fri, 16 Oct 2026 14:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmey-0007dC-5e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmev-0002xH-49
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG1SYk2552194
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=50Ey5QjQCO1
 h0auzcyTuMfXDBm5mPZf5g4nHQRu2Vm0=; b=SjuyLskVJFUUPqvBJXDR+vYt+VZ
 O5O/CUtFGi09sTuFdOo1XGNMNG+IRZyXC4NigwR59NZPhIMapvzzi4rpp2iedWwO
 kyZJ5afludYBGg5iF8AspR5+DIYgl+IeHUQ/2KqloO1jVBJi68cBwQuNO9Qu6Q46
 F0PrmUaIVDuBxjUjKOi9vI2ZqN29jddHF8yVy+zq0Jj0EVuaPW4DtpfB7JxaUYv1
 Bt1haIwTIyRtJ8tM0JNiijb6g2LAt4YVKB+CNxTH04qehCKK1tiidDin7hzha7Jf
 Mt6PtGFBdPFjdFgJ+LX1wFNHWHK/dEOg0+NNY3N+T2uplRxPcRYTNUdJhSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wrrjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd0e92d64a1so192639a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175279; x=1792780079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=50Ey5QjQCO1h0auzcyTuMfXDBm5mPZf5g4nHQRu2Vm0=;
 b=Iyfqj8hnUBVdbNK18sOBHsh2JbdUBdr3/tnaDlQCpNdsTRXr9eTKYMB/te3hrk2vc5
 0VvUlNMsAKh1gwbsCH52Z5PDA+bAPq6QM/LsbnGXlnqk2RWoonBnAcW0Onb5JbBCUVpi
 PiKBzwUTnnZ3OTSo0OUeRbbuytq4LyBREmfip7OS4fqQw4SghNh2lqCeTLxhgSsqtMWj
 JuOLZmpQEKDA+KNp7ZcFSDkDxJSmzofjMx2XzXRTJw9B77jQzjqzJOCRprDZe0SJbXJK
 bqQ0pFxMezavBIE7Rj/RcJY9Varn08/qaQqVOYHgPOXCJ0GD35x3hikwUSWzjFke8mWU
 7x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175279; x=1792780079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=50Ey5QjQCO1h0auzcyTuMfXDBm5mPZf5g4nHQRu2Vm0=;
 b=O4iLmRoSHZozTCgxw4me9mrbUAiPTdY7Ign2Us5DjhB8StevL9aBSqqGleJy6J7SSg
 WnYRgq7qc2Td6hgxT8CKeA5pjwqKYnuDTV5SnkjeUmdlm8KB7c5Cp27cT8bndntxHiqE
 3qNlRJrhcyVQwIyzOsIJdah04UiWRLJqbVwHem+jTSA3AdrTgZK1q4irAxVHo14Xiek4
 JnKU7sDj2wSKckw3QrjqDd3Z5iE+YGvccpk2plgrke6WvX8udzsO+wKtKJN1v2nt870W
 I1BDMFg7Q9kh5rGOws0ylRrAjNnzbZIXzfcIcGBN/sK4FxmnWv+K52JxYZErT6tKXfuo
 Ww0g==
X-Gm-Message-State: AFq9FYJSGd67W7PlGEgtMokpme4yCLqmLW1YE2yzUQisk+vtpBBo81Dc
 pohI1Yn0JvQOBHWzUtFT/7K/aYQbWWh3+ESa17fuf7/9ml/MnJInqmYW6wTmhWntp9e7/xfdqUj
 lGfR5buNVcQYp8Qtr2uJQ8oR//w9IZmKTXXMXY6r4XibJVtI91Tk2T/QClXvBP5hHmg==
X-Gm-Gg: AYBFou2Fp/LhTyGS63hmB4xKE2YsJ1l1NT6E4IFMaSN9HADS1gsQ1AdSkLbhaOyvdyZ
 zsRf9d5L5QDg4dh6cN8GohUb44k0ye3K+DBcRLqAzcZ2yHqJSinEl+gyD6kIz8XdJ3wSUFwwlKx
 tEoJnhTMWae/AJW++IUKqX86/RYhHWxxmjIZE1SaTVEzoulAA/oicd0iq5ZaiGQVu4txs6tPjTu
 kGGFmHuHqpb+X2oEgbWzpLrirBRhMIeMObwmEn0MdcJV7ImCWa9tDRA+mq5zZkCoFMZcVbVQ/3i
 CNbbtD98/1zVCL6p0hFlA0OzN42HY+Aju7HzYt+Giyfqrd19Tp9/gQUbUHHPzV2QY5/k0TtrT5F
 gHHFvHGJ7ppJifapJ+xxZvIw7e0mpVJ67utnj6rjmGbT2VyVxEbZwFcAFwAvtrMk=
X-Received: by 2002:a05:6a21:c20d:b0:3e1:ddc8:ff27 with SMTP id
 adf61e73a8af0-3e2021e725emr2156906637.41.1792175279087; 
 Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:c20d:b0:3e1:ddc8:ff27 with SMTP id
 adf61e73a8af0-3e2021e725emr2156893637.41.1792175278509; 
 Fri, 16 Oct 2026 11:27:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/6] target-info: add target_base_riscv
Date: Fri, 16 Oct 2026 11:27:49 -0700
Message-ID: <20261016182751.264704-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad26cb0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: BPw08-peCvXSBsJ6md1CbPVhg9_KWDqX
X-Proofpoint-ORIG-GUID: BPw08-peCvXSBsJ6md1CbPVhg9_KWDqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXz9+Tjd1OTpdT
 pHPYMPo2VANv9PkAWblndfED15GpCbc0B/jDvZXWAeaFRUE0IgCXpkVBFTJylZ6ynBYsqi59Owa
 iZx8RMLeLu1IQTTpP00dgPW8uiSkIofGwNi7GplGuZDwuAJHVLbd8wmUsH7seE86nwBVsXj3wEn
 WkwCnDEhieW2RgQEGm35yc8+KaMLWEzLqHZKjJaSimmlQKjgMI/L3aG1SbehXkkR4abV/uyoqlz
 ajwtmLFjRoUE85RJ2ALkaQvVWfcLxvt3m5bWZYuaknO8O1/EvtCiRucmx3mY6MWfVnwQpLV2XYR
 HUXF1OvnzIU8Ojl03muqu1o2Yj+YFlkWdQ0NpuwmcYWbFAaRhfwHVOHNGjewY/zk9niEbfz8iVC
 f+IlZZ9V3Ay2K6rLLUPCE24HxEZ1Ycw16QjXZTK4q7MJGRRPzARcj+3DQlAJNQlVzr83AzAMN5n
 PHpgtI12VpTIYB0n6lQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX26bUfg8LT2JY
 GtPxJYv0RNB0AIVnq1ueu7/PPf5DanB42RPgmnDP2PigvgbHxEaLkEQ4uw2vHkeqRGYNT6w5fdR
 gNybrUoG57BMhk0m1HQhtwD9Ewriv1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..b0f3b4cfb8b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -112,6 +112,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..e827026bd23 100644
--- a/target-info.c
+++ b/target-info.c
@@ -104,6 +104,17 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_base_riscv(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.47.3


