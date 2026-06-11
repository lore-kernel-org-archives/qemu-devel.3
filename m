Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C166CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjkv-0003uP-KF; Thu, 11 Jun 2026 14:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjkt-0003u2-IB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjks-00077X-2P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:03:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErZPd942551
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IamlN+f3YPmjeRp4ERR0lSCRMrxkjHdMyzlbXgjcTgw=; b=pUFl0h61vhLZfIJ+
 vt2ruLZ4MDso08Swb26p0Yk83t3rDcVclkLZVYmUZCP4y/UW5cJW/i0IfWW15Hxf
 xjPVBLGPLyy1o04s5V6Dkkm03JPVunB6/nvyFaWbE5HnCxxepWLzdg6VWuOYwVOC
 jKsTGMx5hOnyr/YmFH8iF5Gza8rMBP1MsAW8Ouc5CJHHeuACiIjAMEookq/ZJOm/
 ItqilAFzluE0LN8m8ZOV0B0XIcl/Fd9UEDH/ao5YyLllmFk24TIzDGxFwBXhIDDH
 QyFIQgtuSw4PkJc0AJZsYEqE+ynZnc8flZA3PeJs4shuwFGuMQGqIRVGEFFsht1z
 CV3ffA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tmyhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:03:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30761ab3483so611268eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201028; x=1781805828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IamlN+f3YPmjeRp4ERR0lSCRMrxkjHdMyzlbXgjcTgw=;
 b=DnG6RhDvRYb6RRvcro40SF3ytPdTQ5fcthYkBXH7vXCfyQGFM2qe0nwQDaY2fvJhqi
 +SCmnW73hAzg86nN4kXDOslCReqg74XWwFk0WeVfhDJOn+luZMVnjBDYDHZTZnpXi7k+
 TTcjm8FEaMNRkN8P2Ov1PSLJz0puV6dcd89f0pPWtIqkObS/xoygYfNu83Y2zjxOJrDX
 0Vq3hSxqsJ0pQt8CH1cLNHzqP7C75EgoIu+7DKDUWDpYWbMy2kI7aBHZYhGrE2REBcg4
 RVcSoewLif9AakVTud8aQk1oeQ1EauMubvMfrrzkpnmHgaeK9rFYbakfiWmqemvL1ln2
 2sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201028; x=1781805828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IamlN+f3YPmjeRp4ERR0lSCRMrxkjHdMyzlbXgjcTgw=;
 b=rVjqVdbSsWB6gPV3TIK2wAV6YnR7s9Sy5R0jOycIy4FA3/PM6eskpv2nXwsza54g2W
 ua1I34JegvxKzeur4T42IFLVINB2hblfhXVUg9EPNgthap9RN+4DQy+jfSzajWJmqf7O
 hzbbaUR7ztbtc0ROZmbl2ieDbR5qscVaVTelU67idWhMAHOZyvcld8OHbkImHQZ8UcMM
 LLTtGwhlidREUGNS1qF5009xRe1QCq438JEv9WQpolNITDgtns/Rz7bsFvZierSjg6Ro
 o2r9hscrKFOnsROLJlSeVGJs6SoEIiJbOFfPCkMs8K/Ig/D+9z/p3ekH2M+7jbUk3X47
 WMCw==
X-Gm-Message-State: AOJu0YxX0ylgQPA8loplfK/3l5DAY16QLhWdBWieRfwCdlANqah28Q9e
 XeA6xzJU6BnUM1gN2Ek8px9D2rsqUCWB9Pr7URorfw/8SrrgHxxX/3hmmjRZ31uHNvgkpGsYzkM
 iYssPyl5FNcpFu6GmQNU6tiUIbhETazA72WZurSPDQIdK8RdFEthbI/sVLeTn6MarZ5aK
X-Gm-Gg: Acq92OHzeELiDapFCh0m5ddlmnpzpshYSPgb0Qk5eRttfOCWxqBNWX9KKbvxhhaqqFR
 fcAhfi02oh73WdY1K1TXlrI0Rl2ICUmMUTo/Cwyjjk82rNm23b4+pZqEcW18ZYy9whBTFPRKZyy
 iJimaygMv71wduuhi+dQ9ASrfG/evq6vW/qBILtq4AzdoT68iWkTMuVCkUdr8YDtajXVf+y6ppu
 ErOc4qs+B7RiVE+coiI7eQPmRfONIoOnlgcLCx/Ec6dNBv/Ok6bPfFFjW8jjg0ZxgefFeO/YmKD
 YlOQkzCIztzDKn+d2OmuRCVF0WnbhQ6rTmqoDYJj/OADR1ZnuM47RF/oicLZNOkAva3r3lZmg0u
 QF/+qzgxosmaWdgz18R3z1YQTbLfDL2UCATi3wVdX6uvL4h+SQXLsR3y/8iHMThohphy0bQbpWd
 FU2LbHXdh3
X-Received: by 2002:a05:7300:4352:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30804b8a64emr3143577eec.18.1781201027849; 
 Thu, 11 Jun 2026 11:03:47 -0700 (PDT)
X-Received: by 2002:a05:7300:4352:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-30804b8a64emr3143532eec.18.1781201027272; 
 Thu, 11 Jun 2026 11:03:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c10414csm556171f8f.36.2026.06.11.11.03.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/6] gdbstub/system: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu, 11 Jun 2026 20:03:17 +0200
Message-ID: <20260611180320.30320-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX3C/u7xZiJBZe
 mhTw1EK2CvOnUlXAzTmI6qoYhscboqxNg47/kkMT6pIHxd2La8DWLfMtIsrdCXU8TpKOBlMKpEs
 3FwKzsRZYVyqxd9ZfCSdmaMrGfBZ3Ut+c54s2wTRyuXgOPmFmUsM2uiANjskan/9UfSx/MPIGjJ
 gVasG437IjW0budMB9Ul1ourem2OyrRoKDyK+8O4BwhaEe3eiEixi73pEBxg2fp5RVzPwdpgHHP
 iu7iGWH+SrGCaIXnCYx60Xpa6FRFHNW+o9ubSpXby85oHuccDPQeYRO9UYQq1md2/pYrEq11o/+
 UuqbYey4Q4Yns7DC863oSB/QUDWdwOwGwWYJxBsmWLcYgxHgfSZ6RPLlsll1jTLlsy1kzzxsHrL
 HIs0/f/3H69g+9yBqd9raLqljvx3DRcsEUIJwCA3pqq02MV/cKIrFdyJ9xujMPSsR7+xvyh3M73
 NQ+WJRiu0xba1ETZPZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfXyZ814jL2LK4n
 asZicfBui4nIVkUm4y+jxWr0H/DUvYAGRtxRFR0ZzwD5UsgV+fTkNvDjEJlxXw2QYoxeVrRzCq/
 rhg/xYNT/UGzbdp4uU7BvofJLZmLFzM=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2af884 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xNtUyv5i_auiJddU4oEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cpPDPmShXraUMedKRNG1WR_qwjUrdbGZ
X-Proofpoint-GUID: cpPDPmShXraUMedKRNG1WR_qwjUrdbGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace the two calls by a single
one to address_space_rw(). So far there is no logical change, but
stop ignoring these functions returned value and propagate it,
respecting the *memory_rw_debug() family error path. Thus this is
effectively a logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Cc: "Alex Bennée" <alex.bennee@linaro.org>
---
 gdbstub/system.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index e86c5870abc..2063b63b2f8 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -20,6 +20,7 @@
 #include "exec/hwaddr.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
+#include "system/address-spaces.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
@@ -453,12 +454,10 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
-        return 0;
+        MemTxResult res = address_space_rw(&address_space_memory, addr,
+                                           MEMTXATTRS_UNSPECIFIED, buf, len,
+                                           is_write);
+        return res == MEMTX_OK ? 0 : -1;
     }
 
     if (cpu->cc->memory_rw_debug) {
-- 
2.53.0


