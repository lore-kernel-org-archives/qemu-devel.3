Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326FCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxb-0007yz-Oj; Thu, 01 Oct 2026 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxP-0007xR-Pw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxN-0001k1-6d
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsmDS2687134
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xGcXP1q6VIZtX63dmWB0WlS+QwjMLjeQS4L70F3wJ0c=; b=jUspdaQnj1XfqLsE
 wsjMxMO5w0VNpmwdNuax4Mhsa4VoNKyCrRwMMtzHUN3PJ7JoEdAc+rmR8vctUK3W
 tlv+GJnOuMIb7f7kFRO1RUvebuPzVsTyuz/ZUFb8Iyo4+9DoNZ4+m2pBCXa7FXjS
 J8s5W3xtLVfxFII+TY6s20InXmF4deSImF34UO15gL5snMpUp+wD/mat7YBHTKye
 4K5dykENLHr6CpIarCarLlCjF1FowfYEm061wbZhJMBNV6jZ7SiHb3ffMWDYMbp3
 IJ6RvFsMbQBC7v6HM/W1ZWDSZwd/x0+Zjv3dDiuRvd6FEWP6cMnImAC+DF9wY0qt
 ImwJxg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1172932eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877150; x=1791481950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xGcXP1q6VIZtX63dmWB0WlS+QwjMLjeQS4L70F3wJ0c=;
 b=g2XeUnZ29nwiZMLQZr5GAejH5jM088Q0vYUuKueafZCAvmZ0svYHqgB+ICvXRqGvXV
 vdoltkFryakcTNhwg/87cnilnSwCIFZbuvo2Y0L20cWtwh/2Snbt1l6+a3LtM0ebl3f9
 d2yTqYlPBs2Nwk/46QormIKSUCv5KSpBF3TMJOpBKkL2iXjJ/NDMH1Y/kdMrNvwgtlyo
 lx3U2qrdAXLaJqNrsEFnzqIgb5IYKUW/LJmeZZL4KpLoHjwcKvwYo+GwLZFCXPW4RRc8
 m3f5fWbvVSGTlDsb5dc5t2L6ERmOUpyIZnqDch53oBcyaG64RMWrGTYIEaKbIJbO0lIJ
 S4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877150; x=1791481950;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xGcXP1q6VIZtX63dmWB0WlS+QwjMLjeQS4L70F3wJ0c=;
 b=u4lW2sgv8jSK6g+NMElVEwHxBzM9UmLzR9oZ0IzMgsU2vHl9buTIT2JTDzbClahVD+
 zEXhqaD2NtOS7ea7lO8KsC/YEVPOGu/xnr85fQB6S1X0Tn0OtAx8mSJKtAJZmEmO2/vF
 WWMuGzUAjE0+dOoFwc4iq2AHAGwfiAblHyQtrxcbWMl6cqAe/Qwc0PCeoLpQKkhEQ6qW
 I8UsstHj35MGemM+EdAN3FMFd8TPNCu1ongZ+2kCtYk5dQOMKYMUe957wFQC9kNMPbxf
 Ps36kaNiYWauf1TjXOfNMpdBYlGAzD2hZqKlx2npO6z2ZOh18dw5yEzI2uSQFVosh57K
 OMBg==
X-Gm-Message-State: AFuF++lJ5QogtGutcgNFxJx3U2B022uw5eePh0rgqCB2zv15kLT0tDLd
 /xR6zsvBd8QMAOzX7mvf4+G7RMTgds5dUd2e5XhpEMP8Kmn+GZJZClwDe14U/VY9mGu/E4n/uVN
 IA8YpL6GeltGOrCh26aW1gGzRhTLyK7vUumQ4BgjfdfAfjTewxa7tWRvghAfLVAXS7w==
X-Gm-Gg: AYBFou1minRnYaxv3LJCjgU8KQv0h9Gq/pUt6EUkl5eeJqLF//3VOsihZd/imtIdmS9
 Xk2iGlOM7NOkws0k7eLIKoThI+Yeo98JggxsTaypCLZbV3nQmZIxOfgMQ1FZ466WPj9mKqGZyWP
 SJNisJeK6Dv5sk1oQpJgW0TBqEO+uNiA8dHRLRk2h+oJp/ocAf1jKi1q6oH73hXHHeYMqOLmWHY
 tYnfrF+JDc2eTz+Yd/w3ibJ+rN4uQkMouclFUX0lab40cIjtQ+k0wIdAlcEXCPxtffhZUCw0Vkk
 BPkYTxP9CurZKjdo4IZV0+GGCfHhyyoC6EeJ05zaaqIS18M3VH2cFECyxOs2tRMpawIhX7COLQz
 dxaQXdLUvioLXs9k/L2wBnAarcLkfLWN0v57SbbWtT/RNbw18Nq9lOyltDz0U
X-Received: by 2002:a05:701b:2816:b0:14a:6a66:f6e3 with SMTP id
 a92af1059eb24-14dd1969ba7mr3023190c88.20.1790877150080; 
 Thu, 01 Oct 2026 10:52:30 -0700 (PDT)
X-Received: by 2002:a05:701b:2816:b0:14a:6a66:f6e3 with SMTP id
 a92af1059eb24-14dd1969ba7mr3023148c88.20.1790877149313; 
 Thu, 01 Oct 2026 10:52:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/27] tests/tcg/mips64: move mips64r6 sources
Date: Thu,  1 Oct 2026 17:51:45 +0000
Message-ID: <20261001175203.8673-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXwVRaG8Dxobcb
 rshbkg19xqysJBaIzYotPDDtW8rEL6nnwo4FdGsnUcSW4GAV6tTU87k+sXodorlAUZPgfkFgN4V
 w17UoDyeBNEI9c2SqzzlmdQe2E7niw0=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9ddf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ALku5c8DAAAA:8 a=xz38mcJZfOssY3GY9MsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=Skunnq644UPbuD6fT1yj:22
X-Proofpoint-ORIG-GUID: GJY9i38A51Z6OepbFYAFxu6HB5RDd-4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX846CavkUMlaB
 LodFS2E5vafvks1IRQ79JXy9UblvVMr3GuyQf06yHQaCqMP7IwmRVJHGyF5pEwZ4VvZCF04iVoQ
 vXOh5P8L0boFU0a1WfKuZtP+w4aZd5+zuxJKajzlxQj9l6h6OtopBWz0e/8uu5UKfFFFjPoJpBM
 u4eLg4gYpl/fs6E9ehQLWgusca8DfL4IgIsSfvVfxhV8K8yB4dljmGgb+d6XrJXeiZyMiuvQzeW
 dLqk35SjpN8R5vRHu+yP98yJcQRiDBDKdFAHvhcMUR2LC3WPeUey17ufALV8yD9FcKJAuy9agOn
 CbovpVvwTVmaJyqlOnxUEwbBQzp46dRwok/bKrht6YxvoZ9G/zST0QXxwhAn1zJFXtHC+Z5DL7n
 pV8bROSbmVWMkVem/h/1J7bkOhvDHpZZey1thsNsnotkOOJNmu0DqvZCaQn6jH/I2nCZLxhOyOG
 S5GLJUP3q2WwOHWXC/g==
X-Proofpoint-GUID: GJY9i38A51Z6OepbFYAFxu6HB5RDd-4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-10-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile | 40 -------------------
 .../logic => mips64}/test_mips64r6_and.c      |  0
 .../test_mips64r6_bitswap.c                   |  0
 .../bit-count => mips64}/test_mips64r6_clo.c  |  0
 .../bit-count => mips64}/test_mips64r6_clz.c  |  0
 .../crc => mips64}/test_mips64r6_crc32b.c     |  0
 .../crc => mips64}/test_mips64r6_crc32cb.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cd.c    |  0
 .../crc => mips64}/test_mips64r6_crc32ch.c    |  0
 .../crc => mips64}/test_mips64r6_crc32cw.c    |  0
 .../crc => mips64}/test_mips64r6_crc32d.c     |  0
 .../crc => mips64}/test_mips64r6_crc32h.c     |  0
 .../crc => mips64}/test_mips64r6_crc32w.c     |  0
 .../test_mips64r6_dbitswap.c                  |  0
 .../bit-count => mips64}/test_mips64r6_dclo.c |  0
 .../bit-count => mips64}/test_mips64r6_dclz.c |  0
 .../test_mips64r6_dmuh.c                      |  0
 .../test_mips64r6_dmuhu.c                     |  0
 .../test_mips64r6_dmul.c                      |  0
 .../test_mips64r6_dmulu.c                     |  0
 .../shift => mips64}/test_mips64r6_dsllv.c    |  0
 .../shift => mips64}/test_mips64r6_dsrav.c    |  0
 .../shift => mips64}/test_mips64r6_dsrlv.c    |  0
 .../test_mips64r6_muh.c                       |  0
 .../test_mips64r6_muhu.c                      |  0
 .../test_mips64r6_mul.c                       |  0
 .../test_mips64r6_mulu.c                      |  0
 .../logic => mips64}/test_mips64r6_nor.c      |  0
 .../logic => mips64}/test_mips64r6_or.c       |  0
 .../shift => mips64}/test_mips64r6_sllv.c     |  0
 .../shift => mips64}/test_mips64r6_srav.c     |  0
 .../shift => mips64}/test_mips64r6_srlv.c     |  0
 .../logic => mips64}/test_mips64r6_xor.c      |  0
 33 files changed, 40 deletions(-)
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_and.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_nor.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_or.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srav.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (100%)
 rename tests/tcg/{mips/user/isa/mips64r6/logic => mips64}/test_mips64r6_xor.c (100%)

diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
deleted file mode 100644
index b7f5811a5e9..00000000000
--- a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-#
-#  Test program for MIPS64R6 CRC32 instructions
-#
-#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
-#
-#  SPDX-License-Identifier: GPL-2.0-or-later
-#
-
-ifndef PREFIX
-  $(error "PREFIX not set, please export GNU Toolchain install directory.")
-endif
-
-ifndef SYSROOT
-  $(error "SYSROOT not set, please export GNU Toolchain system root directory.")
-endif
-
-SIM = ../../../../../../../build/qemu-mips64
-SIM_FLAGS = -L $(SYSROOT)
-
-CC      =  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
-
-TESTCASES  = test_mips64r6_crc32b.tst
-TESTCASES += test_mips64r6_crc32h.tst
-TESTCASES += test_mips64r6_crc32w.tst
-TESTCASES += test_mips64r6_crc32d.tst
-TESTCASES += test_mips64r6_crc32cb.tst
-TESTCASES += test_mips64r6_crc32ch.tst
-TESTCASES += test_mips64r6_crc32cw.tst
-TESTCASES += test_mips64r6_crc32cd.tst
-
-all: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-            echo $(SIM) $(SIM_FLAGS) ./$$case; \
-            $(SIM) $(SIM_FLAGS) ./$$case; \
-            echo $(RM) -rf ./$$case; \
-            $(RM) -rf ./$$case; \
-	done
-
-%.tst: %.c
-	$(CC) $< -o $@
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
rename to tests/tcg/mips64/test_mips64r6_and.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
rename to tests/tcg/mips64/test_mips64r6_bitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
rename to tests/tcg/mips64/test_mips64r6_clo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
rename to tests/tcg/mips64/test_mips64r6_clz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
rename to tests/tcg/mips64/test_mips64r6_crc32b.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
rename to tests/tcg/mips64/test_mips64r6_crc32cb.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
rename to tests/tcg/mips64/test_mips64r6_crc32cd.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
rename to tests/tcg/mips64/test_mips64r6_crc32ch.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
rename to tests/tcg/mips64/test_mips64r6_crc32cw.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
rename to tests/tcg/mips64/test_mips64r6_crc32d.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
rename to tests/tcg/mips64/test_mips64r6_crc32h.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
rename to tests/tcg/mips64/test_mips64r6_crc32w.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
rename to tests/tcg/mips64/test_mips64r6_dbitswap.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
rename to tests/tcg/mips64/test_mips64r6_dclo.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
rename to tests/tcg/mips64/test_mips64r6_dclz.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
rename to tests/tcg/mips64/test_mips64r6_dmuh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
rename to tests/tcg/mips64/test_mips64r6_dmuhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
rename to tests/tcg/mips64/test_mips64r6_dmul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
rename to tests/tcg/mips64/test_mips64r6_dmulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
rename to tests/tcg/mips64/test_mips64r6_dsllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
rename to tests/tcg/mips64/test_mips64r6_dsrav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
rename to tests/tcg/mips64/test_mips64r6_dsrlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
rename to tests/tcg/mips64/test_mips64r6_muh.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
rename to tests/tcg/mips64/test_mips64r6_muhu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
rename to tests/tcg/mips64/test_mips64r6_mul.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
rename to tests/tcg/mips64/test_mips64r6_mulu.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
rename to tests/tcg/mips64/test_mips64r6_nor.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
rename to tests/tcg/mips64/test_mips64r6_or.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
rename to tests/tcg/mips64/test_mips64r6_sllv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
rename to tests/tcg/mips64/test_mips64r6_srav.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
rename to tests/tcg/mips64/test_mips64r6_srlv.c
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
similarity index 100%
rename from tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
rename to tests/tcg/mips64/test_mips64r6_xor.c
-- 
2.43.0


