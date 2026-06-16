Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A36CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJEh-0001UN-5J; Mon, 15 Jun 2026 22:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEf-0001Rl-Dh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJEd-0000xb-TK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:09:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xtg52122142
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qxk8ZzgRES9H1XsrKYAF1amL1Am29zKlR+7mPYy2TJU=; b=hKVaH/04Rk8+VBb6
 wB6MQOxEWcRuko82Cwxm1+zNa6QSIB2J7I8YeDv2Q5Xo3qsIAsGz3FyrTfgXFXlL
 BrPUvfia+TKYop+fACZ9XTLyAkhsWSvwff7jdqlUUOdzIUN+nYKZmeg4rejufwlT
 TdLQ6VAppBvq8Jg1dkePDXCOkPJhc8djug/upH/FKIT6Q7gucoF8fSEbNwKyYG+d
 oiXkC6Q5PQKS2lWvKnw4lgdJt8JJEXHdUgaawYvku2jMnvcRi6Rv65R5Dv/11TZE
 /o/uyn+JkUgu5eluVtG65JpdHTK5eNcJzUAav0Xn1QmQnm5AV53EtJ0Fv7PdMmgQ
 NmgeWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx43py-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:09:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9156cb14b1cso388926485a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575742; x=1782180542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxk8ZzgRES9H1XsrKYAF1amL1Am29zKlR+7mPYy2TJU=;
 b=dmL2IU51WmPFQ/AJcAOdVwFcfJaMEF4PbM+gH8JjYFXahIZJ/3Pt9ZdOht+IYb9Tb+
 isxLIKcWPZsrjUBq8/wEB9S00URrw169Pi8b8tWF5qNMlIbnq155cvLtW+zWXRqQb8Ws
 mNj2ZbZNvOhmEXwvyRBPj5ziiRmXof+ismivVqEzd8RzNprxZdXQTMb4FqQx65PvlLr+
 eZsIhtmhcb6DntFGWT2ygcUyyZ5wNh+XHpSXDEOECioou3eL93Q4c+OWRLCCtfnofqMK
 w6mAc65qqel93q+37PW4WWT9PrKLL17BwCo6ywcEJHayKWFwDQMIdKckRqzyc9WL1Wfp
 4e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575742; x=1782180542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qxk8ZzgRES9H1XsrKYAF1amL1Am29zKlR+7mPYy2TJU=;
 b=f2RCFfX5U9f6gP/PDlf5UbZlu1I+ofD1GHQ2QF2B5bIz8liCa/iBJf+Uu+jenY38Y9
 ovUlyNdExTe2ZAAwWCeqzyl5vobCCGj2EqZ3Vd3VTngoiwSjIGmnRAiNy90J+g/DM1SX
 N219vWoSC0cnhFVEGHnLnJlK/EV3laPONwBqb7L95c/1BjLzlYU/nQ0fBahrlRfxsOlc
 Unq/pffGSlT33wRJ4bLoWbO6gc9uirEdb5lNI3rJaJY4byI/TE+l/QSuswk5sVIL40Gd
 g5uD2phS9ISw0Msi/eqrHWI1KTgMp1lMlCvBG5VUOo6CZmzOzQYti9dngwgnsteZSTBR
 3vDQ==
X-Gm-Message-State: AOJu0YyvGJt/c9iRQa5SHH2QJHl7WXG4V6+1bMtWssZKT1UQim+mLDCG
 Tax01Me1XegSF9z8ADrrj8tbSjL906zD0vkTKZ8GjMejFZ1R8TtnnZu3A8H9v77DlUxWQquk6O3
 gn4ayPK5rRCu1uMVQpmX1djZEybNn/3CqbR96sQJeSEzyYwA8sTqU+LJZqbtg2SOlEg==
X-Gm-Gg: Acq92OELT2bqogW5mAMnZPKpj5JgjRszFsAOoPCjsP7URrcXu8jZmat7MT9aE7lU7jD
 GSkb/ynKJGROGUbhDUsNvsp+cg4cvRrSILlYgmCuhdWedso4yFR6zAv4cVyztjJeXFVmDFin7FC
 UsBFI9Ns/GmhUFtxFbRjJC6XDbYXTLkGYBDGNa0WkmgOEl/C+eSlt+y9tgaqVq7S3c0UExVIo2y
 McEJqBsOlsXwB+HZdwjVCyV76i+W/qcWLMPvYDpyqDHK73aQc7ZvEAl9NBYaNI+i3Q0z9lzBJ8z
 Gxq6Anjl7mlJ0nDyS0Ra7RFglxFbQupadTLonSFq1IRpM/NVlZJ+7KD2vUThp4OQJEvRaBdaPor
 vo07Qj1bo0K4hmRRx7PeseTaxZWq5RE4hLwPi1CS8p5yxSfiYWMMPXCo+P11hoacnyU8pjMRl9v
 i92pI=
X-Received: by 2002:a05:620a:414a:b0:915:6e30:5bd8 with SMTP id
 af79cd13be357-917ee4d8cf8mr2117956585a.11.1781575742450; 
 Mon, 15 Jun 2026 19:09:02 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:915:6e30:5bd8 with SMTP id
 af79cd13be357-917ee4d8cf8mr2117953685a.11.1781575742032; 
 Mon, 15 Jun 2026 19:09:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm241117805e9.0.2026.06.15.19.09.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:09:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/6] gdbstub/system: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Tue, 16 Jun 2026 04:08:36 +0200
Message-ID: <20260616020839.19104-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rsP_R4M0xwwD59qRT5nynUAz7aSRvy93
X-Proofpoint-GUID: rsP_R4M0xwwD59qRT5nynUAz7aSRvy93
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a30b03e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX34EZMBQmoKdn
 nIuIjon2fl+jrZUszVZA+U5cC9O3eZdS5+3A/VuHSmMpaqPjYJ6enpbt68/UR9bUO43QeYiGBso
 FogNbxcE+hdAVgM06FTwp9sgnK8ir2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxOCBTYWx0ZWRfX+fZHFDO9sak4
 vNALNMhPX3ZF1zIplvQGsa14VmekZxXTymZlAO6H5NLi5F4lf6aOCkuUZ9CN8T76iNC0jUeuoU+
 NIp3dxLPXfJ6/9EADqBgStGVi40NKvMkRzN3lR5GkgIFHZtToXlbFIqYk6WWybakg0OAZ4nKE6Y
 mvMx0GcCmNf/Z92brrEYqQyIe7+Twzm37udqbvMPNWF7OqDerZsxP/nXBiPcTM3BN6UGZ7i/7Ol
 ijkNW4sXQP86yEGvFU/6T9m7s3zCzXZOx0L6zUR+TaoXEfuAPk2Fxj6q7dhsUvzQMspiaugaivV
 cboPlGtcaOb2AFn13HzVmPZ+4N4yxH92g0nK5ltrs2tuctr9tUaR8wmjbDrneWtG7SyP3HBxl+A
 1AuA0nd3OEJ/xn7RphBhGibC5on6TZwjZ0YNzg2Tcq/ZYVDqpgSn0lkzD98OLNm90yYXbMVUZeH
 u8ey7shpTmKlnW4MTsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160018
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace the two calls by a single
one to address_space_rw(). So far there is no logical change, but
stop ignoring these functions returned value and propagate it,
respecting the *memory_rw_debug() family error path. Thus this is
effectively a logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


