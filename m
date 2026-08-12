Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A007C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGLJ-00007R-OG; Wed, 12 Aug 2026 17:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLH-0008J3-Gz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLB-0007nS-Mh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2bWG4038374
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QS1Cy5Kr9ojZJTzD0MEMOVSD2Z0r9Tx5Q6QJdnTa014=; b=Qovj8nLPF0eN8J1v
 8j4LTkw+DcDyThvOGCa21H4nkBk+aykZyPoIA3a6D7NF8NS+cCizt+v0moYOJceV
 ByRg+O48ZZ5LagfXH3RKEaSBbFBIscEEC4GoakvZ28/PCZV4typiBnAKdz5LuRIM
 KZqxCCbE38bu3tapMsn/7/NEM8ytI1rtKO9aQPHnBDqmn1J0xNZaGj9sWcSIpXVg
 MxRp/LLOr+BqjF2Ursk4zeiLPQV7pMgRnn/kXTJJ7FmAkR5Vy8hJQwB+da59qp5Q
 xvYK0I/USz1jz+Fi97WWGOlCExR2scnTcOHVJ/Fn+WoKX9nCVgGnLZlrO3GcihTO
 dzy9tQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbfns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c12e43b98so17360901cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569501; x=1787174301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QS1Cy5Kr9ojZJTzD0MEMOVSD2Z0r9Tx5Q6QJdnTa014=;
 b=GsRRWycqWQubMn7sxvC7zRTAvFiImcX7cUIxEoq4qiP9BBy15WJYyW+s1u1cVkpN8Q
 +mGBwh+S0oWhgb+7XYYrK/VEZOjKQ7gRnCLHLgOTrCP8/SQqpsrTsB2kHcsd7LUjYaZi
 6Mm3gcCNLkfZOfGGAY9VGqc1NSzo49wHYDsAlpLvZLVRS8FPmh4v7VIO4XiDocdGxBBK
 bzptpkjBWQAUTYIs2QQauKU+A1bc9LkAmm1bxLQAdXgOSno4ul/ur+tl5VgjN0aCI0Ar
 FCi8BPS8/ufYiLpL+5fzBCE4JKb3pqdj+CSsit/WMthQ9xmSwoE2B4KqR6QeMGgCgEXF
 gFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569501; x=1787174301;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QS1Cy5Kr9ojZJTzD0MEMOVSD2Z0r9Tx5Q6QJdnTa014=;
 b=SdQ83tbvuLHDJYtRSuHekAYkkbH5OEH5UXVYIk+cjkjDqMZEKabkxdiHGcwd/+4sLJ
 XrJ7+x16zFuy4YW694k65Rgf5PExvq4GnNI6R/NcXa5O4ggZvlJ+ucIwVWApanHGgSqQ
 bz1AsAbZRxh1X+cR2/13950VhEePqAw1sYEc5N8+QG4ND5yosYxJ1AeZe1fvpuO4ckNl
 U/BM8aNwelDRPt6MSO6GjLbykhfBU7GMLaMeWxvtkC4QRIQfclCT+8hfKXd2F+sy8aBS
 OpuhAfPe996tAjy8y2tGf4lCqsJ/0lOTUmxEn6iIu2nwfp1535VMCdOpssFtPNAgmtJr
 1l3w==
X-Gm-Message-State: AOJu0Yx83++7dILNLpab7kzxseyGzu/nndd6H8dCuhq07SKNy0UZu1z3
 tcsuhrEOBRLGsArLGp18M0oK4HqF83UvjbNgh0zxxEe393S30hVxtSo7CQ4jOmudpAiSryx7MrV
 A2qapICKxIxYkMXE0alFnyvw7vQQhNboNJ0CHVrfdzQscBaREow6ROi8NWJBsYnpDZg==
X-Gm-Gg: AR+sD13ztpsWH3GzLtNORbnsUAs5oQVimc1bAWkZxyitB5S9VFSuBNR8tSqLKzfXiXL
 jZ8c+mbWRWLjGCRF0brQ7Hl434gYuR7LoyNI2wUFKNkWepFa5KSY2NPCqwT+UO1HNyElkr87Avy
 +E0It/CTF78aRb/ZpxOemsmlcZayKhoMZnkZtgLAJp3g6ozsbDQ5TfNBkM4LuMfMtrdhX4UTrIL
 1liCeIcPkXByuyLXsObk5d0jHPB9hFcsTT1ehuzQBianXTOOLrLXMUHHzfEwE6yYTCzCoDSK+ln
 R17WUilEN32T4lsOwXcTAqEn/NIRn20ye9+ZxmkwEDd5E+0VzwuyN7mKsJsUipTy/ZP+YNWIF70
 J9EFcEzIxYdyRiFdCvls9bspEQkb5hSMQDdvmVGcq/g==
X-Received: by 2002:a05:622a:3c8:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-52d73c37b4dmr11151101cf.9.1786569500760; 
 Wed, 12 Aug 2026 14:18:20 -0700 (PDT)
X-Received: by 2002:a05:622a:3c8:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-52d73c37b4dmr11150431cf.9.1786569500202; 
 Wed, 12 Aug 2026 14:18:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e4435bsm5420205e9.3.2026.08.12.14.18.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 09/23] monitor: Include missing 'qemu/coroutine-core.h'
 header
Date: Wed, 12 Aug 2026 23:16:53 +0200
Message-ID: <20260812211708.92824-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX0b7xGU4s2jIt
 marTH5PmMezau3bfuBXBP0B8mp1zpfxDsYAPYEmEY6rp6AI3ucthNGvSis1rr+O7NSDZggaWlOs
 xadQSeu7FEW8R+Euy90gTzoWSyBmxdA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX7MWHOQLa9lGV
 KUYGMmLn5VzlnmYXaNiYblW4cv7yP4V/7OjA3TlZH3f5H24uOoohfyd1EbhGod9nLE9Wpjcdjfv
 dblU5W1AHvWddWtUJj6LRGZs+WRGuAby+zfFJ+tSAkY/Q2Ba24kGQ1ZnVSNig4Ruv821ODCjw6h
 ugz/uJbYx8erWXmRx/Yd72BprYvzzSLZei9DQfgwCZyrSrWZCZST6FHinTDtAXI7XirrWTrLRqw
 z61uBI5vQ4g5vd1wamGz9Jgq5PwqGyRreF7cejyM7DtGMvXBTFyrDYDGNc9CMQYIi2JXL+wt+8Z
 VATqq4rZw4TbJGJEQhF3OF3EcnPF/n1bwZ1n9qRmRJlsL0hAoM5S/Yv1zOuGCGms5nQo2IIgn0A
 Qp3ibXG32X6MAT+sQV6DIahuDOxhGX4WbFeMHNjx0jWMjkVA+MUDH9IjDclKDChh87/Yhbw/Ab9
 SPg91+BKtfd0sjX3aDg==
X-Proofpoint-GUID: LrJKsydu3GQDaioie8ufAIo_JW-M4I7Q
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce31d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: LrJKsydu3GQDaioie8ufAIo_JW-M4I7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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

"monitor/monitor.h" declares monitor_set_cur() which use the
'Coroutine' type, itself declared in "qemu/coroutine-core.h".
Include the latter to avoid when refactoring unrelated headers:

  In file included from ../../target/sh4/monitor.c:26:
  qemu/include/monitor/monitor.h:32:26: error: unknown type name 'Coroutine'
     32 | Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
        |                          ^

Fixes: e69ee454b5f ("monitor: Make current monitor a per-coroutine property")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 890497b0d22..efdd2165aa9 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -4,6 +4,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-emit-events.h"
+#include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
 #include "qom/object.h"
-- 
2.53.0


