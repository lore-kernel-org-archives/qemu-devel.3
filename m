Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B68CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqV-0007Wn-Kh; Mon, 05 Oct 2026 14:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqM-0007PW-NT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqI-0005ib-VP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLboZ3043961
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J/JBbZdePT6YMv/dTGMEUzBuYGvOaVysrmwgYg4HbgQ=; b=JNbu3ouFXy5hBdm5
 qLVKshxJVp976kDGy2e9ngQUMWwLNd6f089L3pajpcWAmfVv7wLX4hZa9/k/6Gih
 oSETH2L5d/PRhFuRNxkY4UfGbdumlDMSpdNcTcV7VW7/2TmMldxNS3HrG5upl46D
 ZmlM9igF4/eGyeIMLAVnoIjagTmw+QPMG5nmOb7g4qw16n172OSaVMvzQ7LQ0RDO
 qbq9QQ7EBvdo3wBlxYshLgMJBSrnwwyXvLOqDFHdjvKYT48bvuyleCgbxWsrE8/C
 EvHSJZn6axHXWLxJkNGoOuJJ+2640tgLrsH/HuG6kKWPXSZQhlYX+TdHSqn7fc2G
 zowzXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so5520086eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226517; x=1791831317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J/JBbZdePT6YMv/dTGMEUzBuYGvOaVysrmwgYg4HbgQ=;
 b=C+RJIoZVS08QlY7fBZRmZTY6JLTptHlY2jGHsc8u8RlEusfllqo0byJrgfh7q/H1+p
 TJL7xP/k51dEapk1+D4JyS25dKhDaD29tNhBj1ahRK7OG2OP70kg5jPW/SN8hvWQfyGF
 9RWo1rlKVjOL1olgG7cGuEcUiJZsG9OETWHtfRZ9HZcNDAa504b2aGJviCHku8b0LiPO
 rc+fkUju+zdGLQ5BK+aqoQYPLx5N2f6G/LnMP8xgV5auKM2chBc/a7M2mkUOp8OVmkCP
 y0goxCuIHnssdHmob9ygLY4HZAIk8+Apo9pvhuNKjOcM9tImbK87lubREZaSwIjT7mh8
 cC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226517; x=1791831317;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J/JBbZdePT6YMv/dTGMEUzBuYGvOaVysrmwgYg4HbgQ=;
 b=ZT1LadHw9/kjast8j0NEB0/cASRcEm3Ur8zaJcSR0rX5FQ+KGHNKX6oYrNt1RlQN0k
 1wPnSOBUIUDlNrGfrVHRrfLygHrRVPwtOrKGmLq5sT5GtE/VWYBILM5TkPHnNkkF/DJN
 qF9+F8pXtbkQuPYWbUWfpyWB9oh2vgGJQKsZQa2+GrpLQEV9ngGZT0dhl1gZmNo1Ztky
 YbWL1tXfj4RfDGVOEOETtD6UpJnNpJwaqOaPMdebeFgT7bQPGbeHmjT/U5z339iauJdl
 vZhPfIyTiH8qRbrng0rVdaPLHXxAOwH4qoWvms8S9vadTgH6SKoxHsCevBmqWF6AvpCs
 eYFA==
X-Gm-Message-State: AFuF++nkKEFadxA6i+nmVYcP/MVC/CUe8Kp6knDhuwPnxwPQCPeZNUR/
 5XHA6HH2PuokB9XodD/M+OdB3niZwXrhWqBgHkTn9Vac9H16n6PPYtuzJHQDZbTw1WJRj9zyNyH
 NxEITz3VlPsxTdb4ZWOANxgINRcR8YWl8F1avJvIAdX4KkzHv5H7dJBbbwqXnqozwiQ==
X-Gm-Gg: AYBFou3JgeJ+tjFPaUvbvqriQOsyX4iwec7fsPPxGwukh0Tfb8yYldAFuSyQy+wTXLV
 WJBSI4YWMGHxTcNbvqyZsNA9oIdjsxEMfVchOdKneFUIeCWiBtiicI77dFb/aFgTEHYDj09+BqX
 rGKL4LXMntmvoHYf/7ro08SEKveRE/Zl2zxPs7SAzgkgXhEd2SLbAzKEe1fLDDZzNHtI21XndCJ
 yW2d0SXDNUTPyLb3do06/Ynhcenfvozom/MpnMSqFc+XZehn8OhIq/+0hSisX+KwfciCBSNaQ1c
 g5vtTj30cOwsh3733GtnS+ntaXWS8oXHGHNsRDGH4nkpvVK9X3Zrx24juHhRdMra0b6s1f+n1g0
 J/IfW3zQ7hADI0IBz/BRX6XTLiPv21zghY1ouD8vWAqGVA/8OHYmlz3dnZAof
X-Received: by 2002:a05:701b:42d3:10b0:151:ece6:b166 with SMTP id
 a92af1059eb24-151ecf6051bmr10842127c88.8.1791226516833; 
 Mon, 05 Oct 2026 11:55:16 -0700 (PDT)
X-Received: by 2002:a05:701b:42d3:10b0:151:ece6:b166 with SMTP id
 a92af1059eb24-151ecf6051bmr10842084c88.8.1791226516236; 
 Mon, 05 Oct 2026 11:55:16 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/22] target-info: add target_m68k
Date: Mon,  5 Oct 2026 11:54:41 -0700
Message-ID: <20261005185458.405929-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f295 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=zEqewLYq2q9j3nlqUmgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 9xg5tvZl8aUPjQ4sRwefnTI0MwUXDtOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzv1AdHHklNdP
 f7Bib65KvDmX2XVJ1zMbGpkLQ5UzCtZfQpto0SC4QHOI3/yNgr2o0fEq76xOxzZFAT1om30DxGO
 y3jvD6c4aeD6aB7Zi1oCzC4+R4jF7xI+GMfRNCfUkZmN+d7FsBit2YMUwmw0ih5oPgc6XWubRlv
 dU4uzTledv+Xxq8QdA/7EymT6k0dQojkIB/TE0vYXHjiSI2Ua04jOA/speJUDZwrFHJV4HrCSfJ
 TpwKzGhDeg8Dpx4VXN/RjjFr8kOwa7ujQrB660kvVb1AScEiYRKY+QafiFuxHYg+E8/yJGEdw8K
 dLcLCey6vXH6EIU4/DJqlKvPco9Q+SlZlyX69/psPUp8nobKZz9VNXhYqaajvMTGvCZ/7Agd+AN
 PpghK2INQIfYeiXS+w2btzQWUKEAmW04GtExbtFQaLSbcuCw2u0jpRNpB0EgUOSgM6/vFDljnpk
 /BYMwhbKq8qI12eYKGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzDhtmZYAdm17
 JnIcDyHMGksKoJ24NH16lq94UPiz2ydTp941H4v7et1by4lnqmUjBcLYXSD6ZF3tETSCSpHPhSs
 5U9mCV2DXGvnmD1TAtLqHeo3NSJQFlI=
X-Proofpoint-ORIG-GUID: 9xg5tvZl8aUPjQ4sRwefnTI0MwUXDtOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..c7b3fda3b22 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -63,6 +63,13 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_m68k:
+ *
+ * Returns whether the target architecture is M68K.
+ */
+bool target_m68k(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index 012b384036d..f3d98998ebb 100644
--- a/target-info.c
+++ b/target-info.c
@@ -63,6 +63,11 @@ bool target_aarch64(void)
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
 
+bool target_m68k(void)
+{
+    return target_arch() == SYS_EMU_TARGET_M68K;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.47.3


