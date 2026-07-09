Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyGT-0004su-Pc; Thu, 09 Jul 2026 19:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGR-0004s5-PY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGQ-0007RE-35
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXmOF2475783
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=R6+EiX254E/FAKbQFbjI/7
 n5UTHXfIEs7/ZSCmz7YfE=; b=I/9aRHul8oeV01jm0qFsvqVvRWetNVnfNpMfyc
 KA96cpJC2xSnd8oykbfqtJZj9r9tW5Hcb2HoUh6Fgvae7opuxb2QeH62DI7H2wYL
 ir3XwBslRCRZLg2RKsMKJVxmlbYC3BGoIzjZoh77HZSRMqPNmfXC2qPMKbpRdN6c
 kwxB4O8Wc+TRYNR7TQaYHavxcdN6uKk9KCav0bpzYusokY7QFlah3i/y3OWY4XsS
 KczbJn2zoSUUp20vqK/IWymFGl0QRRCSEbncV2VDWrrHq1zZwt6O5+xmHcNboiv+
 ySWr/e00wsnJITaEujW36ju+hMiPSxCdry+jzyMkChgahcWQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mskfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:34:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so544022a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783640079; x=1784244879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R6+EiX254E/FAKbQFbjI/7n5UTHXfIEs7/ZSCmz7YfE=;
 b=D+WEn7ktncEmFS0GSWHEtWdaNrYhTAK67JAS19IzRRn9eSdgfDBFSAfosKHqWgx3rk
 B83hNU3r2O0zYabzuIv7csDvCMTicOOht2iX5MCPGoqqgQXRlTCjElRUKv5+RMBASp3e
 297+KTpr2C+TX6AgpcIMLiO+D5xU+hJfBtvZNjos3XjSXqomUfKGr1uKnlMFbfRqILhw
 GdLVN3cu3m3zAVjTVLDhJMgyy77j6t87kU2cyIRcK1LAdCwsCOXU6KOFsu2BA+fKAZr/
 VVd0Fp/XiVUhWXLJcDOyUzMMwvm8fOVO7qJIt3qjHuLtPqncWlxeZk7qqpIMqbl/j9gX
 Sq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640079; x=1784244879;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R6+EiX254E/FAKbQFbjI/7n5UTHXfIEs7/ZSCmz7YfE=;
 b=iLod8vvztWhcdJQv5c6j0aLSswW4vQi8PBwvvJFcNfLZInIo3pOWsHt1jJaazc2pIp
 LRNi+bT+zABB8xKNXaW5X9OKEdBEw0XPj/bvSsnHCbJywE/ngMKGU4vZDSTvIID/yBc4
 1X5Mj8olCCVOQLeLrFUpAc8KhON7Bd7uFZ8J/qFqGy/0ksuGDREB87wNgE7KRBLxjqU0
 P5eRhra4ESHtdml8stWONLUsJV0vwWY2C71HzbOcWDDOAhgZiRXAeQOpLhefthUOlrv7
 dVddOzrj44cpbRiuJAhUese/XvGXE5By4bnuY6Q/r1v1A7qK3AzOuve2kFO3A5PRUj+d
 SvoA==
X-Gm-Message-State: AOJu0YyIWDWaBiiKvveNn65lLCn+CT9SUvruSBO29dvajzYPKow9ky7d
 EXqorcbJI4408Yn+namCU1FLPCAFDoTGhmT42HRsGjmUAset/7GM8W7MGQTJMlGO0/FnvW9gl1Q
 Ssejr/rvehuWTCsQBh9sFjgcbl5K1XkwDPgzr7V0NM3i399lEwSUZiJaizqGzQ20Zig==
X-Gm-Gg: AfdE7cmIH33cobFG2Ej8UHkZwQf+DdbGFXHFldLsuXsRiPkFpVTHorCn+XWtRet7vk3
 fSXnfyzdyqCGfSZEw35DKupQfawjlYj6JrcgSEm9hfBp7qpN26/hfjMPxFvdji0pHTsJz2TW7ST
 GUQnqXFA09dFI9VY5EblLSTxvx5xDN6C6DgDZVpP3+TqXOy0A2UQou+Pfsyepfw8mkGBeRSoWmR
 qsz/nXl0CdisLbfMEVnYBgHX406oEjHIjJjxI3V+xfxpTe25O/veoyV0K5HXXwj4DA9KTF10aXV
 rQ9CzdSjBwAPLX2COkdgHMTx8budEuzr/D2KzKUY/d9NEVJRc6tNsBvycGHlhm/2X5PlMcrn/xy
 VpYj64P+8jxDesig9FAe9rDfDFya7ilP5URmNMszvttlW8rXaOjZT5LDu07k=
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c0bcbc5172mr10907361637.47.1783640078753; 
 Thu, 09 Jul 2026 16:34:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c0bcbc5172mr10907323637.47.1783640078280; 
 Thu, 09 Jul 2026 16:34:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm25447189eec.20.2026.07.09.16.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:34:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>
Subject: [PATCH 0/4] Fixes for unaligned scalar accesses
Date: Thu,  9 Jul 2026 16:34:32 -0700
Message-Id: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gHweDXDvGuVraRlx1Bvhb2sDjAGFUqYd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX73Eklqt/kR5j
 EX4awFZO5YL9qSPJSaVH7w7NJZD3AGH5kQillCG4/w8n7tZ1WEzZqNHKbrcKxMJQgl8mAAepPD7
 r2d3pJtEGTZD33d4fAKJWRzkwgXQiQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfXwz8niM+NhkC+
 r4q2drYoN+I6a5WXBkiBXLxIcTnuKMj8z2dEumauxnEfEJqV8SxaFTUdErGGroKY2NmI7ncnpsY
 ju8YM7SpSnX2F62laQsxvNvfibcOpZkyu9hKkfDtb+6BHIxlng2XssdsqMV7pGMEAH/p4dbjjYn
 Acf1kNHSkuE6BGpF1+4c/m2E1iOBxziLdexKO5PtjqsrtVOv3irDjLXy8luDuknHYS3T+0YibqG
 m9nxvMUr1a28OkqxyAMUFvXCQLyDzQrZM1dXgrQQZSgnvUAp2zg6t9pXSed0YZaTBU6FMJz5H8z
 Qpwue9LHDWKOh6BkNjM/WYmNJzdX0aWSvazEo+f56gfxz1uX6tmAjCXoHJM8ixQCZ4zt18kPUPU
 MVqKeY2CzBsM/c4lWsh3+U8x4hMrAZvjz0q+owCS+TvY+NsWkoTvkHRdpNCECcM6H1GgkrzZ8Df
 8kIMeqxxF75/u+I7ysQ==
X-Proofpoint-GUID: gHweDXDvGuVraRlx1Bvhb2sDjAGFUqYd
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a50300f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=LNw-_RXBXnopCtyx08kA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090235
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

Brian Cain (4):
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


