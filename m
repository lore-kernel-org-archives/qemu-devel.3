Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE8EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8o6-0005o0-IH; Wed, 12 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lj-0003yq-Im
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lh-0006nj-9r
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4ZfY3637957
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=; b=lFObz5xEjsuqEQLO
 4nwn8r87b9YbVpHOcJUw7/QOEQZ4mgvunrWPsXdM3i8uwAKjxS5mIkDHjbn6R3Fx
 P33u2lENxX17fnYGLHt/4Kdxw1/SpHIAXv4Xcg9elWtkDG4R2LpmmTKwy4+3fbdc
 1AkwD5H3n018pdalzQQ6QgdF5EBekEbw/49+8gu6bhf545akykOZE3i5e1OO1Sal
 ECT8vPKdyqqq0f0QKcPG4EzdrHCbvdgUndjCSfYg6gyKEhhwabWO0L9+nKawqpG4
 gXcallnhuu9yWV3hqBmiu417Smvvha2XXdl0do4fpWMLXMgGFrEBA25JeYb+4ggo
 zJE3SQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrhrvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so18527201cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540396; x=1787145196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=;
 b=gD0QsUty9H60f9kawzT34PtCpTN58NiAApNy29k1yq/x9mY4iX1uk39tj1ynepLKJU
 E7t9771rd/45d/E6oWfZzc6+Vmlba5HDxZlS9yk4C4Y/IUySnO63f5JF6/2LGPHQgikZ
 LnaLhi2IWwwedyFHpB71zWSIt3Fqqr8unroP+RThwFdJBbLJj+y/FerOnfhOoaQOZOxv
 f6kFIis6N+0sQTMgYAXqN1vO1IhgSBhgbUbNmIsst8oscwqi+tCgZkHv7GLbibPc+Jfs
 2gALicf4pEosSPTBfkGg7b/f6NsVLruqhA55vu0p5tWw7lOd2TqqytsFM5kq4gz7ZT//
 ndtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540396; x=1787145196;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=;
 b=aKRghZ66ao+SoAPlni0uiZYUNNWL0tF5UCrGP9C3yOaGYrt5kGwk7RZluoVta/uvBn
 iYlFtbHQBOnvreOcbVuRv2wiZq/g2lJ9Jfo/pSfm/t5toQO3+dfq0HdiZrY3zNX1dUhA
 bAjN8t8sKx8rd7Kx0hfPmIHWBuM9USUAQWyWr9FOVZ/4uwqlqnUoPzcoblg4zsBdljAN
 /gS5D33nyRgeTh0nOg16s0RD7r9hUK16Gm1VoNNXZL14PxhD5Q8wE98l2+9VmPhyxfaR
 7QBFMfzk3CB5JFDpNUrFGhknlqjXzONs52Hy+RPFUgnzvmVvL/+Xavgzu9bjoKudP1Ta
 FFuA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1cBWfEtpNzcHDn0lFzvF1AXOTFYn7XIdw2YrwgaTw9N+FY8o0vHwTe77LFgy1SOqAa480KgoJneWK@nongnu.org
X-Gm-Message-State: AOJu0Yzll/1ScFa3dydjQrMAV+IQJDrE7i1PN+wASCJZta2DrUV3A3wV
 pyvhIWbXHIisMq3P3gxneOpX+3pv/yMIrMb7NldFwlft7IfPMNwxbvV8Y3OINHD4uvws2fxcXDR
 fBaCpeKPODSdKJkeET7JevdWxpy98mfxc3LiS+nDEp6i7E5TSl9/QaNI8nQ==
X-Gm-Gg: AR+sD13y8IogkldsJ4/1l7lJV2jOn66mleolxcITpg7eIdL4zB4YyvG3DBeDY7nZDVq
 6bJl93YbyB2N6XpvxBwmIdsUOr+NmU8WllAUYgev8Vip6oJplnqwhFYRdAzDP25Zb5Cq5CJZ2uA
 fbtfM2F69euqfuolj46tst2uhREoujESzvugFoyp2XOw/rX0l53qBYEUMswMcVrft7ia4wh8M4q
 gRmMXH2D4+UEggsXlcrc75hFnLO6TLbD/Zutbn/QTzJ5dy/H3RW69+/MygsASUog9JCHHozK4Qb
 oBbDzPtEDXE+kkBGYecL4Yj1yFhRamuZ6gRXV3Rjl7xUIQ+SLF5jD08JwOfakpiyqs3nH1KStv6
 0FkWkgowyopeE2B4hJh6miPjHrJi1AVCK5YCOw9ZtMA==
X-Received: by 2002:ac8:5fc6:0:b0:52d:2b8b:a138 with SMTP id
 d75a77b69052e-52d647ec53cmr36346861cf.26.1786540395821; 
 Wed, 12 Aug 2026 06:13:15 -0700 (PDT)
X-Received: by 2002:ac8:5fc6:0:b0:52d:2b8b:a138 with SMTP id
 d75a77b69052e-52d647ec53cmr36346191cf.26.1786540395315; 
 Wed, 12 Aug 2026 06:13:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98d205sm40973345e9.10.2026.08.12.06.13.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 12/16] system: Remove unnecessary 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 15:11:43 +0200
Message-ID: <20260812131147.83188-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxgJTGLjwse9D
 lpyMBz3HA/jczyWhx3t9kx4aMSYd5cQ30bBph9k9VuYF/xJnWOIJ5uwsTtTm6La2D99XRpfT6Q/
 YCW3tzw+HVW/iwaTaSPeRUw8r683JgElkUURmxV7Bg3N9G1bdMDBVcT33Gu0BRWHNytJhLX8Uhu
 HEKpW4DVFEKBefeKeo30QQK89PathX4TRm96tU+tzKXR1ikzUs/b4NWnt/k7eROAAAxorKXNXmN
 D1g8JmR//QLB4bzLMInAq9T9bRT4ooJojblBEbc+HnqECFsj8z9A3oj5esUXnZetpwsbLvcffAH
 Pt1eOMQbicE2DMQuj99zr1JrzQFxrF2ulYyxbQuanzfhUzYBkp8h1xyEhJEjXpkc6XRAJHl4U3g
 bbZu+a7KmIdE4RpDiwHxkWrVVuTNupKoXXzm3L67fKKE/0jwVkScufeI6ZOuOyPcQ7E2LYjZXRm
 d/IWfWlspM5BWHVgqZQ==
X-Proofpoint-ORIG-GUID: H163EutTAM6NAe1boxozKpBiiC6Nf8oF
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c716c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4VRd78mhg-xsesdjslEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: H163EutTAM6NAe1boxozKpBiiC6Nf8oF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX8BFaJI6Ybuk0
 psoNcMWCAEmnVhoIa1ZXIRKC1dONLftriMC5O1kqDkW0UPluY3yF8VjjSr8cAgfzJwNiKPG4vi8
 BieZXGgW5zYJHXoq6+g551M6Cfuf1ZE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

No code in device_tree.c or physmem.c require declarations
from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/device_tree.c | 1 -
 system/physmem.c     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/system/device_tree.c b/system/device_tree.c
index 1ea19629841..48365435ea0 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -29,7 +29,6 @@
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
-#include "monitor/hmp.h"
 
 #include <libfdt.h>
 
diff --git a/system/physmem.c b/system/physmem.c
index c21ea929153..21614e1c4d0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -84,8 +84,6 @@
 #include "qemu/mmap-alloc.h"
 #endif
 
-#include "monitor/monitor.h"
-
 #ifdef CONFIG_LIBDAXCTL
 #include <daxctl/libdaxctl.h>
 #endif
-- 
2.53.0


