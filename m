Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjReu-0000Mk-4C; Mon, 13 Jul 2026 21:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRes-0000MJ-7n
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReq-0003ib-74
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNn9hm3009337
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OZ9qUmNeRak6DWTXq8mJfd
 Pht7FBlVzj0oRk6p3N0lQ=; b=peLS9mvMsmxcr1YZZ4qyY1cW24V+5c9b/QwhhH
 UXQPFkQa57bXLXlezZg4YGhSHXK1Valkd5tQOyFkaiKyREfdwEUUKSsH00xMw++9
 H5wIdcf/iKTzlkUIE9rwAOTYfzY5ftVwXhb2LUfHaD8vPFNfuWe65aAuW5vZ3H2S
 bwHG7uIWtiyQ/d6czhjZxyXG0M004sGYY8nNVW8qUh+BaKnlmKh5EwR2BPiIchh1
 T3G3ZUvaKtMZmLBaHy5OHcEfpVoaRBZHlWm3gmL7NKY6MpcIILTwerU9/+O/673p
 ju1WOZqsBgmIGzJh8mQKYXwfMVaGOjcYeITqxP645D1sZIjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj03rf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:09:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380a638fb5bso529767a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991397; x=1784596197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OZ9qUmNeRak6DWTXq8mJfdPht7FBlVzj0oRk6p3N0lQ=;
 b=JIy9aILNI3xWSUS7XibhBSBUwKp6QOAExZbVc2yCuJ/tYrvz+IOL293FhiI1om9wUs
 0UZYr1/+QkPWDsNtPwYAkvzWZ0OrTNRmHA4FDpADRnBybWYjLEw/yns4SvHYtXSSv0Ut
 1N2O04Xbf5Id3YximJrKhhg2CIUNblzOPgzIrOxDi7vOqFuY52UQ5wPIYVLyxpGc2Uju
 byJeDfLC+Vc0/PARUH1E2LS/TJdwnRmsZKblSQmo3371Xi9ODF1eMIatgNIVPQJKwk/x
 G66U8ALTxrsRR8J4fohFMeSmHkdGiPJoX4+g/ueUiywqpOlne31huOaj8I6VYhjWYSU9
 2eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991397; x=1784596197;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZ9qUmNeRak6DWTXq8mJfdPht7FBlVzj0oRk6p3N0lQ=;
 b=HEaZ/E79cS+TlNLZ9ZfF5L95l2quUrUL8rcaRcUZh0cqmx+HIDY5TL309Bxhdg7ETB
 8pFZQw3pH/AalEMgbB9/6oAB3Orj1Pxxvjmd189OyuB7g7b1vspDqUUYwxCpbw55ngDU
 9irvpYUaYtR4cr6FEkEH5Fo+hBKQr8rdqbRnxrCJNbWRNKFrCtYHOwZINzxzRUNrSM9W
 7MFxgJa2kfd/a09R9qr+UjVio1BnF8Gtu2cWlfCirFmlVjiztZXAwhBzhevqTQpZOjiB
 Uksi3mjhbX2WDkdFUEmEhkwk/gGUJWBiMsMFRdg/0P7DqLt953E5gRvOQqssSAJqnGct
 N++A==
X-Gm-Message-State: AOJu0YxSU0tYtdxdxZSDE0XoWIV49hH6XUfGY0N3Am20qR4VZS/f2DGg
 RcsiGTOEpH7lLTfn+BQPqgQUCZEEOibpTjifXQ474+cRMCA3nYlbN++Hbl73aUxaKGNZgSvffwT
 dyv2RbeFS5iVsRhfWsj/v1FlFvqao97XuBp80VIedzEfZgNJJkfgwfhwrMhZ50JZbTQ==
X-Gm-Gg: AfdE7cnplSy5rn5EJCPlo+SAgqw/eOkuptce+pgXeA/Rz/nF6F771AFtbLAwh951gYL
 n7G8fCjciHkG1eA1HzAR3sck7baN5/8JzGt2r7Pku2aVBCx+WLLTcVYRd/liaXaRmP1muHF+iO4
 XTKciqvriVvOcza2+dAh9k1vQvtgBXV55rTVUL9KdDQLV7z/zmeMmr4kuQtPteZ5QZr60j9Dv97
 vOcXMQUKVDL0Km46dcjxNkwuDZtTqo893QuJ1Isa52dbqSwt4qb/KD9bgRi73yqEm23YiTAaVx0
 vZejM0gxLAE9bLMGVfj5a2W0AYhwaCVpTYc49kKSFUNkCbqLSbV3cr6ji/MPkdy++DLFQd6mWyD
 PWX9mXblx8XmWt1ubN+PpHLcU2fGIaD28lfv+PwD5nkCNtNS5kNeekppCnvg=
X-Received: by 2002:a17:90b:4a4e:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-38dc74d04cbmr10023494a91.7.1783991397306; 
 Mon, 13 Jul 2026 18:09:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4e:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-38dc74d04cbmr10023480a91.7.1783991396835; 
 Mon, 13 Jul 2026 18:09:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:09:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 0/5] Fixes for unaligned scalar accesses
Date: Mon, 13 Jul 2026 18:09:50 -0700
Message-Id: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX4r7J2CgT7BRS
 Z0Xwf7fechF0BcGtMMOqRsxFMuixl5I+pDceEzSehcIwiIEYV3mgUYXZboMZ48Drdqbg9HuqEzV
 vXHefAsIJfVZXMC9a0iZcp4LQAbgV8U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX4vowFVFrrbeE
 v4Qn2RmEYhnZcKT1MsCjOs6Ro7IBpLu3cNKxgjrDys4tcGMObvk1MR96qo/aEJvA+EXt8UrggEC
 9DHLP4NR43MdppbOxcz4PFWzPE+14PMrUnOdsbAyYJfPko6t1ghOplux0xhF1O3QAkNqNzECGLw
 cCcZ5BZoB+t01Yb9ir06p/LPbk2jo3QPljxzuteuIv98NYaoVGfbDNMSnpfBDpA4fXjjlFI22Ls
 sSEAY9m3aqrpaxRBpqIcjvFGGhn/FvzwBZqbaHMFS7kNSi9jIaBUjiq5KVOdGAadwLJOSblg9R4
 bxykhLzrkPHSjMQTMDFvn0uwdAzvxnPK+iw/i7KQr8q0dR9k1dMIhaO9gjYthKouuVGxlI0vkNX
 Y154FyQrV2mlbnMrcMq8RrUDJTqebh17u9x15p3MOa3e0o3OsCkduCBAt+/6Nth6IdyAZ+XT4wd
 09YO8JwD7G/jJ+R7odg==
X-Proofpoint-ORIG-GUID: kpgd7uX8t8he_SZ5BdTmDPw7vz5EZosU
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a558c66 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LNw-_RXBXnopCtyx08kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: kpgd7uX8t8he_SZ5BdTmDPw7vz5EZosU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140009
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

I took some "working" programs under userspace emulation into a linux
instance running on a fork with comprehensive system mode support and
discovered a compiler bug causing unaligned accesses.  This bug had
gone undetected in userspace tests because they were not handled correctly
by QEMU.

With these patches, unaligned accesses cause an exception that generates
SIGBUS.

Changes for v2: moved linux-user cpu loop to its own commit.

v1: https://lore.kernel.org/qemu-devel/20260709233436.3075100-1-brian.cain@oss.qualcomm.com/

Brian Cain (5):
  target/hexagon: handle misaligned load/store cause codes in cpu_loop
  target/hexagon: raise SIGBUS on unaligned scalar loads
  target/hexagon: raise SIGBUS on unaligned scalar stores
  target/hexagon: raise SIGBUS on unaligned data access in sysemu
  tests/tcg/hexagon: add unaligned scalar test

 linux-user/hexagon/cpu_loop.c               |   5 +
 target/hexagon/cpu.c                        |  25 +++++
 target/hexagon/genptr.c                     |  10 +-
 target/hexagon/idef-parser/parser-helpers.c |   2 +-
 target/hexagon/macros.h                     |  26 +++--
 target/hexagon/op_helper.c                  |  13 ++-
 target/hexagon/translate.c                  |   6 +-
 tests/tcg/hexagon/Makefile.target           |   2 +
 tests/tcg/hexagon/unaligned_data.c          | 118 ++++++++++++++++++++
 9 files changed, 185 insertions(+), 22 deletions(-)
 create mode 100644 tests/tcg/hexagon/unaligned_data.c

-- 
2.34.1


