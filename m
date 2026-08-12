Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1903C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu817-0007xu-QH; Wed, 12 Aug 2026 08:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu812-0007h3-Di
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu810-00025n-Fo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4wVp3543539
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=; b=DRSTchMcq5tNZeFk
 qZSNWO+moVa+eyOuRAVGvPTaA21yfvoVclbC+u0eqsK804n0cwvNFUpswYW+LgMx
 b+ezJWMV6P5SiHL7iikqBL8MWCTvpOIB0jgd5YpVm+Jejj9QSxmlOAr+2TrDHSQc
 ST70EY7d0yut4uq2Po+hIH3o9BHv25BdZfkZW+nF4HLjeNRaQ7cmU0WtkquvFFLz
 bd8yngMZq6IerOiP5StMTn6H/98YEmuDGuYpsqxPGUCcQyaXVmvrhLnTeEsa33Xk
 mOfVYsMrsun+5tqhZhukHluA4Qmei6hu25c4bN3r8wp7eXmA0odZ03IKtye82LyA
 nuHMyw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1hsjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9087f2fe592so5393396d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537501; x=1787142301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=;
 b=Erf2Ggsyp9rsna33ebGr7xMq2jc/Jl/YdDEhY8o6PwRLfHM8bG71czGH7KmWytG0Ga
 9ztNRiUV642rBk5lhcAXCkNL7nHM1vHlpfzrjkU5De/GrWEqg7EOpiwIn9UUQFwlnKFl
 458ROzqYA38QeKnn67pDBegv8AgLXjcXz28OPxurrh72/uC084v0TQcpDECRPA5BKIuG
 kK3GgHD9nU/4+pEhUe2SgmVS5yfzDNZGiiBKVirHnAtd8uKfCIM3gLq82pXcKdtNga5d
 585N8xh5rVDlcjSWRZs9DQV7OdDAePkKsHcf6ZmSI6JYfEAP8GIexTM+pSqfYh325Gbx
 ZKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537501; x=1787142301;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5e4sGM+19Le7UZ5VaYP7mK0N0s/J9cqU0ktXhLcyIg=;
 b=IV1bSjMaMgLRBo88D4nI3cX5HJq5TKf4UAC3YLoOpnEGTlMhcJb19YQl5t0Hbz+lHd
 qfr8ua7dD9fDx4hwoWacoafXBQYn4e51+w11JwPBisPHj/E67VguDD7Y2XnkDmEqoFd4
 sAfN/vFdRTbj+I3ZqsaVpSZXOu6uum1FnwEFHIpHc4cLePcwN7q44ePaJaxAIXt9Sd13
 73c7ZH8Rqo6t2I2nWMl5nnr5cXBOWyo6py7390ZnSicWJQhYD/d3IfvtK3goKsAf9mC7
 Qw0YI3R1DRKUfeSyuBZoWwwTx/ftRxxDvSpgjEqqKCO6oBeyhduyLvMqoI40YMjjnipb
 OBTw==
X-Gm-Message-State: AOJu0Ywt6/S+601P6RlXwKxYWmYaG8GU8t0HOLeLfO7NLpufuVYaNNCq
 Dgya05C2L5zr0IKmmGcKifPFwMRdDaH5QipMBzpgqI8XXXZij7/U/QW79jQ3MSNdtWXP4zPvXUX
 x8v4q5TqOVkmZncR4ylSslqSMBatf5wG8D4KhGQDS1uAdYZXuMD1bltp+EQSwRVTMtQ==
X-Gm-Gg: AR+sD105kB2AhRRxbGSDJssGslT6PaIFokbLZ5t6+n52JlylF7DQJAyqT79+8PndFBo
 nDJosZLoQDtZYnZMStmqX7bo3C6X3DubfulAZkTJG6xsB6MO/zHkqRxpn0vrbWmtjXuGdarfu2j
 2kS+UOH7PjMafjS6yqeVkmXfUmgTEY1/zxPEz2gDisIQjx5UScwVXAxeqJOuOHUUMZrQSEpl2/o
 vOHYB793AHEJLtOB3L0KrwleLFo9xadkAGtxGwSxpdEfR2VkSTFac1K3YaMdOjNL8qpiPRm+oRN
 q1W8g8cUEWiXVUJ2dFLOk/2MrMEH3c2C3V5MTjjbOTyJqLUOUpR8lEQ5wyMrqzJEjRhPa9WWv+A
 RGL46u7Oc+3wN7VhLoe2egm2BTj3vXKbzLT0gqUgBkw==
X-Received: by 2002:ac8:5712:0:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52d648565aemr34828561cf.36.1786537500472; 
 Wed, 12 Aug 2026 05:25:00 -0700 (PDT)
X-Received: by 2002:ac8:5712:0:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52d648565aemr34828041cf.36.1786537499969; 
 Wed, 12 Aug 2026 05:24:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eddbsm7519518f8f.31.2026.08.12.05.24.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 12/14] system: Remove unnecessary 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 14:23:29 +0200
Message-ID: <20260812122332.72975-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kwkTcZVDUetxrXaXiwh0RHea4IrmZFhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX732sczpfrBG7
 Re0NGUeO4Lz2FmrO6ZwZpZcNrDdpQSa2brweGgI3ntpEs3IFVi4FfnETRBJw+yQ+JiXKwDN5GUZ
 O23MvL+imflCrwDPE8fxMfxbi/JeOvDEpg6l5FBriZppGos4X45EvqbDfH+QP0fEOMyee7fXcmi
 vuvbR9TvFFa0vFnjtWqvhyNi3YLE3+3ZWG954p2PNqFOE/lTCVrKIDL8GpVelH1kvDc48ms1GoY
 R3/F5zaSGwhZB4PKRAtoFrbYj+OYqyNhIsr50Se5UrrKhcK4iz0Yj6vDVxZ/hd4K0cC4AHXJhmT
 XdA+/5iMyVXCe9tON2/DyfLZmwZFBkl19rOegMVhyb8GeNscjjrpV9tPrt8ts1b/ZtEEbDhg6w/
 1cfKZrw76c153jNbKkl9Yq7KiSXT+aaSuGAUPoGmizdKIiluTwdElkJaefmjVIgq7q9YiH3P83r
 KKmWWc3WIqYg3fIsVOg==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c661d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4VRd78mhg-xsesdjslEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: kwkTcZVDUetxrXaXiwh0RHea4IrmZFhb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXxbVHtXoACykJ
 8hsBfUz7zAM3HuBrsA3sGKkFFMVs9pH87PbTDtPY4QGgxjVQm5/UVO9gg05Ks3YsNBaEoMOsFxo
 ts2QnFx5xaP60Wwvc+cE4/cWyNXLsLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120100
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


