Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC168CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhV-00015c-6f; Mon, 11 May 2026 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhN-00011y-8j
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhL-0007aH-6a
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD9Wsp452799
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E1EZJ7M6Dhp
 i8c8GfEz6Ze5ni1dBRlkcN4N6yqUFSgw=; b=VZP9QxqH1+7KDem9nufxj57ErMD
 1AFDoWncRAGyHHQae5e4zvfncaehCQ5so1ctxI1mnk0mei16DDCu6uPtrcZUZaV8
 6i168DEnycPKGZwsv1rGd2gZLoucMwEZKHYG0JG0lhisNvLtuz0Sr3uziDjLDnrh
 F7wNU+0lcXrO8Ht/NvhRkL1kgcZ90rvqZfe1PoLhxDabm4nabb8QYje9/QfXuA7H
 XZAEKGwKNqU1jr6FotKQqrxWW1dZ3KsbCot2WxJb3gceFDPNnbDU0jWuZC+ejnzd
 x1lGE1XCNP+KaHuWE695zxveYhzpbtJr7lzB3qHcK4eTUvBJb3Flq9jhrIg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h9m0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b55b5aa8c7so91639046d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506165; x=1779110965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1EZJ7M6Dhpi8c8GfEz6Ze5ni1dBRlkcN4N6yqUFSgw=;
 b=WJI72JTMxwq0Qlcd9tIhY4Xv2+MNjjtKl8yXiJzFROZPoX+lQP4OEOp+QoCNPzhH9/
 faEoG4lPAQ7rCTMtEeErRUZzVc45U2arB7uFO6cCc+uyuqzN+LJxM8Cy1yljIF3Sa7rd
 LppL3zE3fHDz2vxdPPKo2YLxDN2bysEkDzQaI2QlyVzaymo5Gn4za0zrdKt/j1+VgU/w
 ZLH2TQs+imLjLFe1A5Pbl2pTcyv5qWKPOw6A0mlhbACJrQTP2cOvxSlO9lCB/zgWikPx
 PchBRNZ8nMY3IcwSNmq46DdG8Xbi6BGeyaEaFUpFme7Id11/PxrBGWGhnlto9R0psCTE
 wdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506165; x=1779110965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1EZJ7M6Dhpi8c8GfEz6Ze5ni1dBRlkcN4N6yqUFSgw=;
 b=ACSSRqeyHQGEvRyEs8fiJEqPsAnCH1u5FVVe/PIp9u8Xhok7xJdi2Tg7b+ZbjU3XXG
 XnmUfQnRneIeAiNUTePZ+qDZytVGP/ibblcuroDKszXiCHe1ESFsHsk9JRIDF5Ex5/Jm
 pC977d9VzIXBdMxdJlFtP0OZO4oXQ6oV273f8me5HpA9d2QK80VCn9V+68t1/2kKNoW+
 Dftlyo6UCthg+7BQ8oJ2uWSbNSJJhMIC1qVq87TXFFTV9s+aYLZbABhNsV4v/wXg/DrE
 1R0bNdE6W9qFGwKtQbGtewhu/d1MeUeEBWJIsjKee1MvslgTrv/teZnSEuDI1zCq1ogx
 tW2A==
X-Gm-Message-State: AOJu0Yz81tkF+3/toY7nHZLdahC1/ucrU+TvqTePNOPIbasZg48kje42
 LpbSjpXs7LjHsuMOM2NfAx1BXtz5AFYGVk6Gixz6ihhzzGo6z+oVmuZa0nFGuc9VD40AH/J65DP
 MsCNuRUMBJzLi6FFCIpYeOJwQ34OzOVL3O4e5074YpagH8xRjn5zjOQ1b1hFGRR+hdg==
X-Gm-Gg: Acq92OECXqsl/vvGn6qYqWn7U/94ndqoF0xfe2B3jEzD4Js7pHHt9ApQSOIXeth1ceu
 pcmBuIy9lcG95WUeGAd9A9VDakwTjNPY7NOlV6i3Yt3axssnMFCq5eCRu7s4wJGpUQsUZ2tOaGf
 ZJ/F3MjTS837hljZ0ftrZFrFGUbTxc3XOu3zTMtj++5CkLbh29qs2iN8j+PMnxOi3x1AVT3Rd0L
 E0HEpj9yqh8ML0vTHQ9MgseNRNAdZwDBVuK71a5H1H84D83zgOyoyX02nW6Y3KNjlb2iIkb/5sB
 JZKNTxsi5kqi6XQNdRI1Dz1nIeXkok8mMl0itvUUVGb07q2mhcs61rGDQEH5XxJEG+jZ6ovAREv
 LsD1sGUfJnb6Vl8Qfxl60tAasKBH0+a9QD4oQf6vCpC8/gRqAcMfqOrlI3oQO
X-Received: by 2002:a05:6214:627:b0:8ac:a689:34ce with SMTP id
 6a1803df08f44-8bc4600fe8bmr375217516d6.45.1778506164461; 
 Mon, 11 May 2026 06:29:24 -0700 (PDT)
X-Received: by 2002:a05:6214:627:b0:8ac:a689:34ce with SMTP id
 6a1803df08f44-8bc4600fe8bmr375216906d6.45.1778506163800; 
 Mon, 11 May 2026 06:29:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:23 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 04/13] target/riscv/tcg: treat all exts equally in
 cpu_disable_priv_spec_isa_exts
Date: Mon, 11 May 2026 10:29:01 -0300
Message-ID: <20260511132910.1738069-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d9b5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=y3KnQKAffZ0f_Lxsw64A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX7onf5Z5N1Ezy
 oHmfea+D/xBAMhyBcvgbdKOgSEa42utZYoCgX/DeuCiGFZTn13O98b2s9u7Shu4ZA2l0ACMsdKs
 p/AcMPuqzlK6Q+eObYmBjMbEJInzVSjFsUe4BBYGTHugKj3E8mMVHBxXjQclnpntwlnCz886tLK
 Xfkzxhaopjnh6vLE/mZN9QkdvWKUl55ovMNgvDymPmDlbdf/wzkxpRrzpPtIdQVJmtWkCkOZl5I
 /Syej4x29pBeDzdPHBxh9GKYsaPJg95LbqD8eyvUFVNfJSc4HEN4Q/9VWkuZJSnqgngNaV8hlkn
 1Nm9FYpDxVL9dOENHLSrJuT1kUqzlXj3KVSt6h3LiTBFBbU60RnXZhXvax1D/u7QD6xrHjXkz//
 kw7QhCv60EWS4DSxN+ODaT+O3YFeqWjvpCs8ukiTtGkcKfXXDr5jUMOGMHMCDlnb/6nq22ZzalE
 +McwTGMzGlK78wowahg==
X-Proofpoint-GUID: -LDdX1K24QYFScIe3Jbg4l9yd5sTgbl7
X-Proofpoint-ORIG-GUID: -LDdX1K24QYFScIe3Jbg4l9yd5sTgbl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Commit 7e4f75cadf ("target/riscv/tcg: hide warn for named feats when
disabling via priv_ver") changed the design of
disable_priv_spec_isa_exts to not warn when disabling what we were
calling "named features" at that time.

Back in that time we were adding RVA22 profile support and we were dealing
with a RVI innovation: named features.  These can be define as cute
names for pre-existing behavior/parameters, e.g. 'zic64b' means all
cache blocks must have 64 bytes.  They do get inserted in the riscv,isa
but they are not "real" extensions because users shouldn't be setting
them in the command line, or so we thought back then, and we attempted
to model that by calling it "named features".

This didn't age that well: ziccrse is a so called named feature as far as
TCG goes, but then KVM had to treat it as a regular extension that can be
user set and we made an exception: ziccrse is a named feature that is
user set by KVM.

"Named features" are regular extensions that might or might not be user
set, and might or might not warrant special handling during realize()
by setting other parameters.  And we'll being treating them as such,
which will culminate in the end of riscv_cpu_named_features[] array in
the end.

This reverts commit 7e4f75cadf44ee67809c7ca82645a289a5268966.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 02c98cc2db..492dde9f8a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -484,15 +484,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-
-            /*
-             * Do not show user warnings for named features that users
-             * can't enable/disable in the command line. See commit
-             * 68c9e54bea for more info.
-             */
-            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
-                continue;
-            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x%" PRIx64
                         " because privilege spec version does not match",
@@ -520,9 +511,11 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
+    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64;
+                          cpu->cfg.cboz_blocksize == 64 &&
+                          cpu->cfg.has_priv_1_12;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
 
-- 
2.43.0


