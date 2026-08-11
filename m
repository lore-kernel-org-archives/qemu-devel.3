Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70823C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtolK-00046Y-5n; Tue, 11 Aug 2026 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtolC-0003uh-SJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:51:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtokI-0002xp-Dp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:51:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX3rS462323
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZbUZg/TBDW7F3x6+B7KTdUWQTRD7wzFTUQxMFnpy2VY=; b=m6ZTWngV8ldItTH6
 77FQsuOlMecSt2UXmDJhMr1Hq+GcBN5wvzCMQzncyg0h9NhGVYwOr7n4FL3Opaly
 dLFauk4CcU3CX7EikVZoziyUXkYvQhnVuz+WbjfUgnJRccJw5i6UEBU/hvRaEdCG
 Z7MGN2uRdvvj7e9gl32Wr+2BsA+HSh2aoeUjJ6UaU1HhRKQ8oA/GXdf2p3nnaiGB
 xyZ6tB+iaQhXBxMtLRZkevDInm8x7IFYI+OoRzitbuLvYxBEnspf/OwGg6YoTmjE
 ZY05Xv55T0mRnT6XS05BYGn+44N8Opr/bG3cDIe1BUngAWqC/5CLd6cyWSpM39qd
 xXWNxg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mgrm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:50:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so398931cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463428; x=1787068228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZbUZg/TBDW7F3x6+B7KTdUWQTRD7wzFTUQxMFnpy2VY=;
 b=OQ+iZj3JuDD2oOS5lM+0mZwI6b8a8uxWaG7hUpfQG7FA2pJZeJmTN3xlrUO3rmyU33
 FAcX7XtuyCQqHQY07IpxiIH5Bpd5R3uk686I8DONJWEzj+zf9XxRv+z9Ioy2wMg3oJD0
 8rcjh1DclofMvDYTUtCvmifp13Z6+EiwmITBvbaG5q6kxCyWovvt+RDLvT5wnZfwFT5f
 UBPCH5BObMo6W9VU61i1kNvzl+vLb0YSoWndMw8O7/65tjKe0vyI7Zrwmc/7ewvs7MlX
 adUzFw7mShRK1c4/Gp3r3CgtDLAv5iUj2f+JBHC5VrB04AHLP1kmc73tfBH2L4svUoFY
 tx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463428; x=1787068228;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZbUZg/TBDW7F3x6+B7KTdUWQTRD7wzFTUQxMFnpy2VY=;
 b=kcNDv/GZT195FDdC19KIh70fxlj6xmL4HxKRcHpY9xyPxjimPYgSfLUgmwWiCQnXSV
 87cF+5vaRfXuFwZ3muVn3FcnyM3kVrsqQH9WNVBbZ5HV5nQ5zkgVdke33vcN7gPIPGm/
 sbNjzX53uCDBUdoYg5ARQay9GirP/P31YMACs41zTgaSlGKcdz3U9DPL+asoZAdqmGrK
 PdSnzS5eY8CjJp64CmiZpRNXVyKUiAvVmnkq7A+50VUkrjUWo8Y4sevIntKyjL3r0oaE
 P9fial69zsLwC9hDp8SMvl5tIg/0/daPiwwwPnkMtrJOi+RIfFO0X+ACwzvJzB4JNVnw
 MOlw==
X-Gm-Message-State: AOJu0YxUhpSz2WkT9iCAdUkFBFmZeaI58GFN9b78gCSEVtHTeTC3SFCe
 VbnDIucU6WMjHHnBUpIi9Q1+F6b4IDRMiJGsBZ73w+ku+7SnDxwuv38tcpDoIyc7xuPfilkg1Be
 ZkdrFet6OkSYQg/lUEf9xrJus28Gr8B+GlFi+ecM/HyxBhwOcHeAgpKz+rRa++d1x+w==
X-Gm-Gg: AR+sD10RlDCHyzSEvac8eEAGWr2WGGEU4rdS7sqXpNvhUFHBv1la1OEE1ZLXwT+lNuG
 HwI4lzJezZ/Ah7Y0rx8w04lOgXHZEyYXyRuYMpOQAvPGDI58Xs44gM2Ti9+e1unSlENCwoX4H/I
 bP0bHMiu3qghWX5rueEQ2feP0KfK3/Wt2nIAAhGJe+CVjdzT4NUPBmNIbVSpOd/ZhZMfNoThxTW
 ds5piAJGXTIq+48CWhSidpCXZ43VPUdPjioJ7IHJqiQzEio6K3aWa8/gu2PJ7QKv2d/VY57hTEp
 IMfR/oDu7iImkYWyRLmrsxNUR+oXHENrh0gKrsWta/gYFElfDZu+vvu6okaupsahsA1kIGdEPn3
 ps6+Cuv32G9pJODJShFJRrUtb4+xmk/V/CODvFBdnxA==
X-Received: by 2002:a05:622a:4296:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d601ec2c4mr15047061cf.21.1786463428239; 
 Tue, 11 Aug 2026 08:50:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4296:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-52d601ec2c4mr15046401cf.21.1786463427782; 
 Tue, 11 Aug 2026 08:50:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a72a1fcsm5422065f8f.33.2026.08.11.08.50.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:50:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 7/7] hw/nmi: Raise NMI line only once
Date: Tue, 11 Aug 2026 17:49:30 +0200
Message-ID: <20260811154930.13915-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gIewaW-XosgKg06s_opzmx4kiQQS5ZNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX0RDecYrKl0PX
 I3LUzPYfI7OgNHQARU9mz5oOjdSN3zXI+fBf3m24UA2XREAPKWFWtKP7mNLpipstbgZLQJ6wmkX
 zuqt+YWU/JFa4oxcuva9/p6qLU+tgd5wGJ4kJOr33JF9wNNOrxSs2oKNV5xvQ8ddv0CgFVkCiSd
 sIdH0rB2xIMh8zjwmBfORbxED4QA51B3s25DYspF5hMw70cp7qgpLbI4dvu9QQ3PjUc+lQYwQhK
 WJzeagjPZQ1Pv8ys7Dro+g3iB+/9A7xqQcvuFWqPu+8fwHLMbXCRp9LhNyWj7fQdiTw6rEHs2W/
 osF1Y2NvNg5O3nuQzCZ+t3cA3wGO4eGYz59lulNaE+OsFxxc85SwYqRmOC6A1XdsPvzCZzzg28B
 9JuePiKWKPDIkJuuoZEdDjqR7/bMVLUpijqJ64kept+Lb7qp8xqZZf9Cv1RUFc9SXSJdGEvVB2g
 16VOkFrFCKu2X+xbYwg==
X-Proofpoint-ORIG-GUID: gIewaW-XosgKg06s_opzmx4kiQQS5ZNV
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b44c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HZQsDzxzLdBvz1sOA9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX10EwuiXuajOD
 Hg0/CmC6PtPX1GAxczzuWLJfac/e2xkMfvsElaF1z4h94RB4lkH2HUUUhhaZ3qHHFsKcq/vUnts
 7zrox3Lxxwkcy8ACY6nys+XapSaxE3o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
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

We only expect one device in the system to implement the
TYPE_NMI interface (typically the machine, but in a few cases
for e.g. m68k and ppc this is an interrupt controller or
similar device); so we don't need to keep walking the whole
QOM tree once we've found it. As no machine type creates more
than one object implementing TYPE_NMI, this is not a behaviour
change.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/nmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index c44b0cf892d..84f21665987 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,6 +31,11 @@ static int do_nmi(Object *o, void *opaque)
     if (n) {
         *handled = true;
         NMI_GET_CLASS(n)->raise_nmi(n);
+        /*
+         * We expect only one object to implement TYPE_NMI, so once
+         * we've asked it to deliver the NMI we can stop looking.
+         */
+        return 1;
     }
 
     return 0;
-- 
2.53.0


