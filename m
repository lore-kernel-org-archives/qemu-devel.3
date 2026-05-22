Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F0BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUzv-0008WV-M6; Fri, 22 May 2026 14:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzu-0008Vr-2K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzs-0006lc-6z
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHQqWG3947382
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3L41nfmdxulaUsGh/Hd2izRgUAXYbCTVuhrD0/jLbfg=; b=knFm3HcDWY8Fq15K
 /sdrsjMxgjEtqHwIZ9jQiumQ3bDT4tN/KqMl/tYr7jp0nRcL6/AbZtIilLqi1qex
 E2IXYPxQcjLWphcN/dIVFqWNxkWatvsEZPfiR+E/MnRX7dg/kswmVIQuzIl9BeOc
 Hb3iFOxHLWxh9WCxW3Wr9OUedcmSsBwdWAKDuyspTDmlzKuN/BPzqtwF5PDCWi1M
 zXGueva5XpYekXqfrapN3EQ8OTYa2wmF4vNiLf+lDzPkY9EeY6MV+SW0+FrLQeNH
 NVSvI0k7geL6r860oSwlUMXFzDCYQDQv850SjhIr6vSLufVNsMuR1wM1Vpds3KRx
 imzyAQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2nj1x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2eebb099efbso5736869eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779476001; x=1780080801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3L41nfmdxulaUsGh/Hd2izRgUAXYbCTVuhrD0/jLbfg=;
 b=eoIwOGpbG+ErxK0MNz6GgLObXaxSzipS7cb/eBSw9kdUYa5h2h9eqAX2kzCWRekHS9
 4viZnlle2XVpMjZspPjmAzlNwkSK7C1tkNykj0zlcDEydltE2+I2Sn5Xsf1lRZLdP1fe
 gM4jjClPPHyhSYlku+dAWJsoVbxbNMDH6GMxYcI1Lub0r6AvjgkXW4oBsriJdrVw7U2X
 hn8wfjSl8whjHfZslH+8u6o4OlybF1YjAG39PMAWbrkPvreQARjQUr7IhxSrxsT3dohc
 ERAq/PL3uZLbwlLlbogMZ7nQpPrw8qAr9QwdxqJaAEd6YzqlBjoHrhNlcrqr7k0lKWYo
 aTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476001; x=1780080801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3L41nfmdxulaUsGh/Hd2izRgUAXYbCTVuhrD0/jLbfg=;
 b=SqO/dSWJ2kR9kzZUkZkwVFwSsT9YyUsmcy9mBsZGacEgyTNH/82Go/QvnfeZRfvAGM
 llJDm0JF39CLbIQ6DG41wyFgTrTputtCpkz746oGIRZBgA2D+bAlRzSSPWk8GM18Drzl
 6rUWjVzS80b6H0z4Po09u3UtB29lslNm5kI0XAQBV7M2VJ6uxm8oA7Gvo4P8xjZoR6J6
 hI/tFc0Bmlz9omiu9JKkTGKqTrYSvUFiVwDP8+4B26N/ENz74dHGptx6FCEKQkxTcTZ5
 oxYmlQDIpD8cj+qqixmUGA+Tp2tq7LB8r98I7K1GtMpawwbgYQicA2q98nzLtFxLDg84
 8a/Q==
X-Gm-Message-State: AOJu0Yx0N9vxXtysgpcoI9aASXfkd6biI+J7HBM5vBYj/daqmTctb5Hc
 5vUcXZoxO6GgOLpOboLGR1E34hDG8Gd2yyyV7Vpqx1G3aEZGUhqQFsc7Qr9IlCI6QCLzhgs5KVS
 u3LreFBAl2Ozqy0IhFvs1LcY00I8l+hclsP6ggXM/BiqN90FEcpb+8KoZR4lORQe8AM77
X-Gm-Gg: Acq92OHtC/0BRRQBUamPTxHwYHN1Q4ckzFbQKgy7D6scqTkUAUee7cInQD13wOvtXuK
 2fieGtqrWqTXf8nOB/kdMCP9YfHkdwpLgK73w9CFpHEyO1IEfhwaJkAPh8eFsRNq0obOr2qqXtB
 jBMQkzM3kDqENmAfn0zuC1ZrjdF7gbhfhPVg9lgiw16rthbvysqO9Pt5jvY2ZxGDIl72Orrk0PE
 KDrWhj6MD8gvruAP8vbdTTgYbSTo4PZdbtqTcqUIsdHC7EgjqtUycyqzi7bVrzGzFvcz/OFqIE8
 wwQjtFY2ZIS3Z+NaU0xpR+9nNayQQ/cWQBblAUW2BR1RxRFYnWdWe/O7WVXyUSs8Cjf35teDdpr
 rkuA0PmnJyx9OLkcF0A3MPbbOAf2DUr20eqoTQouBOvhdci3fXH91V5cXwMmNeemLLSRF53eJl7
 XLdB6YCw==
X-Received: by 2002:a05:7301:6446:b0:2f2:8857:1804 with SMTP id
 5a478bee46e88-3044905b3ecmr2624610eec.9.1779476001343; 
 Fri, 22 May 2026 11:53:21 -0700 (PDT)
X-Received: by 2002:a05:7301:6446:b0:2f2:8857:1804 with SMTP id
 5a478bee46e88-3044905b3ecmr2624585eec.9.1779476000830; 
 Fri, 22 May 2026 11:53:20 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm2470502eec.25.2026.05.22.11.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:53:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] docs/code-provenance: Fix formatting of *-by tags
Date: Fri, 22 May 2026 11:53:04 -0700
Message-ID: <20260522185306.4105344-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a10a622 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=hgBJMz_LmLdNJunF3I4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-GUID: c1Io6eFLdLBO93o5p-nxL-6XVkZtTNpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4OCBTYWx0ZWRfX+uegdYsdANrh
 gvmzHMTP28I+AUu8LvE18QaOVvM9kwfbImlMNRxxZh+tPMg4xA/mqYiw+f5o0BR3psNKcC46dgn
 V6M6ImqB/zVBEIokITKPXV+7yrVzOjNVPQttjsjyWKNitgXm0RQX5vSE8EagjLiqxVw/3fC0jCV
 jS/+20sdnTY+K7EF5Yk+ovb2+wo8mG5aIBUHMpxIHlLLT8l9aTouUb9MjOQ9Upr3elSSUz05tME
 ZIJVcJp+O3oOs/2ijACu7ZQkK0BZS+6F5xmebPILi7qYOY4GwMYRn6Lz/Iohv/chzLnTzKZkxOK
 MTi9NwvcMPm6dhA24xKWoNdIkGE5LXKeLw/wKANnvQiSFkFoIl7YYY0My6PXW7qYSO2gxWp796v
 ZhiXewWJYU35P8ykusqx9W8vdlzhtggRgCJbXyUh2Xk/2UsJ1IaduXx1wF7Pz8nCCOSvcn/gPUn
 9bkZrMibBdDwQ8aAxSQ==
X-Proofpoint-ORIG-GUID: c1Io6eFLdLBO93o5p-nxL-6XVkZtTNpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

From: J. Neuschäfer <j.neuschaefer@9elements.com>

Applying both ``code`` and **bold** formatting doesn't have the intended
outcome, instead Sphinx emits the backticks into the HTML.

Use only **bold** formatting to fix the HTML output.

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260520-prov-v1-1-7a58af334b9c@9elements.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/code-provenance.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 4e6a9afe0d6..65b8f232a08 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -99,13 +99,13 @@ Other commit tags
 While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
 that are commonly used during QEMU development:
 
- * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
+ * **Reviewed-by**: when a QEMU community member reviews a patch on the
    mailing list, if they consider the patch acceptable, they should send an
    email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
    review a patch should add this even if they are also adding their
    ``Signed-off-by`` to the same commit.
 
- * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
+ * **Acked-by**: when a QEMU subsystem maintainer approves a patch that
    touches their subsystem, but intends to allow a different maintainer to
    queue it and send a pull request, they would send a mail containing a
    ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
@@ -113,18 +113,18 @@ that are commonly used during QEMU development:
    maintainer wants to indicate they have done a full review they should use
    a ``Reviewed-by`` tag.
 
- * **``Tested-by``**: when a QEMU community member has functionally tested the
+ * **Tested-by**: when a QEMU community member has functionally tested the
    behaviour of the patch in some manner, they should send an email reply
    containing a ``Tested-by`` tag.
 
- * **``Reported-by``**: when a QEMU community member reports a problem via the
+ * **Reported-by**: when a QEMU community member reports a problem via the
    mailing list, or some other informal channel that is not the issue tracker,
    it is good practice to credit them by including a ``Reported-by`` tag on
    any patch fixing the issue. When the problem is reported via the GitLab
    issue tracker, however, it is sufficient to just include a link to the
    issue.
 
- * **``Suggested-by``**: when a reviewer or other 3rd party makes non-trivial
+ * **Suggested-by**: when a reviewer or other 3rd party makes non-trivial
    suggestions for how to change a patch, it is good practice to credit them
    by including a ``Suggested-by`` tag.
 
-- 
2.43.0


