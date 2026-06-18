Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F8CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwK-0003JP-Um; Thu, 18 Jun 2026 08:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwK-0003FF-0k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwI-0001WF-7R
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs0Nj1030375
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 woqS5Ld4n4jpaDbyLAKEQyLJdPphWOZDc2wWv+58LW0=; b=j3MkVJnslW/0ET1/
 YDlgNJYeDBZ8180op7Uo8/mCjP1C4CBXm90nwkcH0HQCLfs+p/6F5lbQ14D6Qvh+
 ey4XuaitwrvW8IC3CgMfOHrh8dGH5KJHlhq03nbyvt8DVv6CZlW1NONqmBNlCxvR
 SUuFRkQpnv1v38945dU7kD+YdmcHaacxcXY2kJZa6BX4OoijRWVvK9txi2tPKRA4
 LR23HutTTI89BNldrrretjSIWBNLPMXuDDCI50/7eAJZy2h4+OvZwEEOenssAikZ
 PPvyhDOyQppjYRJooU3VBAqIjVtBL6n8w7Vsl0r0jESGnXK6ITsAnXgZO4pEDNjD
 Qq39yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3cyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158f2c4b55so178553585a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786023; x=1782390823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=woqS5Ld4n4jpaDbyLAKEQyLJdPphWOZDc2wWv+58LW0=;
 b=Ltppa2wWwBMnQy7s+Ty1wjPgi2f5432OJHQkK+Yr1YtENbdceAI74aupNVmVbTt4UQ
 AALW+ExAz6NwPATPVphsI5t9D78rR12tTGJrOJitT5c8OkwzqTxt/AlOzes53Sk1ogyQ
 +fFCQaKz4rftSKpEMd4LIs5y3cszbnWkPES2PYJHSFX4+Hl2he9aGw06+wE65SzglHWB
 U2Qw4TXALLLo6a0GJ6rK8yXKWKAz/rar3pLzfpc9S4GGswQYy94B2vCduloDhg5YZjlu
 WPY4RvtPGnRJyE3+Jm+WVsWZDSTeuSuzmVvXGuaWUNlohFs7JpXQKlWsGan9m3Jq9hpC
 CatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786023; x=1782390823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=woqS5Ld4n4jpaDbyLAKEQyLJdPphWOZDc2wWv+58LW0=;
 b=PQLAbegyaQMzU9G2uu+rWqdTb/9wE90SaTvVM0C8nJnWIV0PZ/NcPBL1Be6ELjlUkh
 s3sEirDJ0CxCU7RBXJz4QhTOMH+xfqt50whzLwaAYP03cJBnK3stLqao6ZjoVe15bl0c
 MwetSUlM5n70SNUDkRbex9F4fkTf2/5rH8ptR9PbWaotzPt725F+S0NNucIVsFC5OJEe
 N5/Y3j2LTvcMpEatxeY7GmH7QrRrl3My7uzBL0vNUsKNYcv6OU7ff/7hbeuy6L5YmPVE
 y945tx+CxD8LA6Hs6yJnVDPqdu5/bEKtfGpz0GaokzAJEPjy3N9DOA2h/UpHbCJJptWm
 d1dg==
X-Gm-Message-State: AOJu0Yz+pG40Go99Hejj6bb2Q4pj4AUVvtVjjCUD/EP+lAfDTJSePBSN
 mY2GpXMI3C9AmMSXLNUoAQs12kyKt8Z3Jd0O+r3Splh/37uqEwfzdOMmRXDozwe/VHPkQz/5cyf
 nTx54my0DImj1sSL4iEBUld8gJdELMzyxWCnAtL15VP1uL3WjNaIXIzP1MRzwnDOT1g==
X-Gm-Gg: Acq92OEji2PZrAAWtX/OSRG7mp8sXxC3+Qji8ILfB5j7gsKTTHSgGUs61u7b4s9Jagp
 rVkQuOtvLb5dnjqj14xdEnql0xoO/Z4ClVqL79xotJY0YZMRz9dhukfsvUMTcw3LmbzqABnj48i
 ixbviVCmRwZB/qxwsBZtLQRkUjQYSpyPbSrsgmFBYiqeJ/bH3hxFVsgsbEKxhcvVtnnTvL3Ph1d
 n6Scon9iLrgGLfBLpp67ft+3rSRWz+w/V9MBBMJzZEtwUTIySjRRkTYu0eXiWjPYvmnM0ItTQv5
 dib/GQ/h2yaNGYYumLWZwYr1FocRlE3qcLlncyT3b3KMosTbrJkjxOalnMzssBYfrir96URKuc3
 kCYhFR+uMxugdxtx39Kzkrb9ixo0kPmhQ5xoyFVxerDOQHXeBUM30neNicDZn3YJgxgYE
X-Received: by 2002:a05:620a:3952:b0:915:2aef:428b with SMTP id
 af79cd13be357-91f8e75f607mr307709485a.39.1781786023397; 
 Thu, 18 Jun 2026 05:33:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3952:b0:915:2aef:428b with SMTP id
 af79cd13be357-91f8e75f607mr307702385a.39.1781786022865; 
 Thu, 18 Jun 2026 05:33:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d6d1csm29914695e9.2.2026.06.18.05.33.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/48] accel/tcg: Move cpu_exec_step_atomic() out of
 'exec/cpu-common.h'
Date: Thu, 18 Jun 2026 14:28:20 +0200
Message-ID: <20260618122825.90331-44-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXylfmafaBvJE/
 OXbRuiasnc5a0Cb7ZPBUk8M07PkqaMiFEEZqlpK8Ou76rtpyPCsKacXv5Xc2U3CDQJyapBCCeuo
 TSqkcy7CQubVs4muVZUzfzCeVlAQsaS4zI6fgREUicYA0ysVS4nvjkZyf7D+H+z13hOajdUlU4O
 i6llfxhCcmlPMqZf4TRHSKgEKmtIRnwj9csBBTD0b0ZrXeIyf4HGHrjgBHAcpbbmk+EAALxoVmS
 57Bq/rTHWajBJu+Rf93iZ0Px1lAk03GG/mC1MPqdcjLDoCNAQFu8eLnsW3W4vV9plbPhDBLZgBa
 rGD1zpuHBDUNSYT+4apvkt8WZ3nfRwSebVypJputz/8MQxv0bUGiu8xAOWlC1qdhLARtTOAeWy1
 I1rVoXL+BUVcEJBtVqAaY4nthqQxDh1dNrqD3RZXm+S0Qmkpy79wCd1yQNAaIa+OL4fH7VmcD9s
 hr7P3X0qN/mLLKvRoMw==
X-Proofpoint-ORIG-GUID: JfCXsUCJj9QI2gdOnraQxlLt84SEZ7ZB
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e5a8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JfCXsUCJj9QI2gdOnraQxlLt84SEZ7ZB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+cQPv2lcvQfY
 7Lpjco6Ppo+iFQphdtEut1GF5cVjKDBKxDWXVfl5qKCVdJ4ZzGbCv6fokb2V6B3JSD/AOvpa93b
 FLiQNoFIyC2FmD6oP59OMNo4GzB6j8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TCG-specific cpu_exec_step_atomic() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-6-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-loop.h    | 2 ++
 include/exec/cpu-common.h       | 2 --
 accel/tcg/tcg-accel-ops-mttcg.c | 1 +
 accel/tcg/tcg-accel-ops-rr.c    | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 6a3c8ed48b2..94e91eb9a36 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -18,4 +18,6 @@
  */
 int cpu_exec(CPUState *cpu);
 
+void cpu_exec_step_atomic(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 09915dc4c44..a97bb6faf42 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -18,8 +18,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-void cpu_exec_step_atomic(CPUState *cpu);
-
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4160e2ba947..69560fdb9d8 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "hw/core/boards.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f84342e0449..5b132d3d5d8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
-- 
2.53.0


