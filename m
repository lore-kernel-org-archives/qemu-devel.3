Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E1AFF885A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGPWm-0000rk-E3; Fri, 24 Apr 2026 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWQ-0000mT-H8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWO-0004YI-Cr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLqPkG1878730
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8iNkOvHAuwzmKaH2Z0zIaG
 UeO7YFIjh4iUIzMlZJd0c=; b=H/brk4tOcW0ziSL2tDgL/ZTzYgjXrsO69Xqh9p
 asJXpqDu4KzjNiX7eoTmsoa49zPWfD38tiPHwjey0uM7Fi/rKuLgRwnacC8cyTMc
 /2ABw/h+0f+HbmtHXf8ElNd1t1Ua2vh7lMV6kR3k4XtixT/GyA8cFXeuxUOnc7/a
 6QkZXyj1EKVP8ES/iJYiF1VLR0ACXbBX0GPmKNhPf25qWg3cF2O8sfyH2dPpL9bR
 0qtJcHFLDgwFn5z0DgzGE/Rge1O0oZi6SjYTRHupU+s4uOzQ/6Kc8vQgEAc2RaIU
 GxoaO4HyfmzT3yxNMBH3Cfg/lrXySlllj2OU7/MpASqRlpCA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n3gf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so9472414eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777071672; x=1777676472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8iNkOvHAuwzmKaH2Z0zIaGUeO7YFIjh4iUIzMlZJd0c=;
 b=IW3d067eAe2MYFEkI3vPg3f9tN2RwBhBz6ATi+E8HSItyRQNN0DEDlUg//u47HNUF9
 aVxJVcE2CWHJ+sH9DBpyG3Rz6NCd5rquCRX8z+WRfuKEkCRtL3ic7450c46gbAnmiw21
 nvngp1CWjUWnlPYnoxq9CwsJ5ui5r6n2wYNcLTZ3dEsW6ItPSN1daWGfR6OISfCaYmAK
 Hjt28rERXoZbpzCeLFT6/ROFVZNmWKjwtEZwovwJQX3e33FzbQcZRUmaBRHIk8WIQU/j
 V4cg/MOFwzOhm+UfAbc97r9H+193jPoP+2BIYh7WgxDu7FF/1uVwoJT0Z/YNLQq4YazK
 4NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777071672; x=1777676472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iNkOvHAuwzmKaH2Z0zIaGUeO7YFIjh4iUIzMlZJd0c=;
 b=qWbEFGUO4G7cEZmWiZidXUzM9NK7fc3qXwjWOsd2ktfcgtvBHFa7jYzUAznpGW/6eo
 FVwitL3uvmk8xhlcqJjRa2W2SPKoc2GO/YCiZl72JMpVjVtGJGIrvXamZGZgENsD4DDc
 GWCoSUAosrYkTnCqs04/SAGPbCBKhYarJtvoerepAL6naz3lh6vJ/IYuGMoWvC5PzV1x
 htLh4G55AQ14gPTCWcZiO4nltsHJJH7GgWFCnx76Y6I5/U7VTr896KEpbdWEnV2l/mHF
 ZtKfHj7u8dLytQZ98zvcVZ/UFdj0tG+NijEPI3QC6sqz+xX2mHOTErbPoGHVUwFLb4QI
 iFGg==
X-Gm-Message-State: AOJu0YyfpnV6ShMr7o3fdRZRk3jeq5vxnQpLtzVrSJQZlXCKtADu5JWl
 AgcnxrMSP8GR70ub2SAJkauqmqsaCGcgXFWEGt2ZzzMrMSnGxU34CL1UMRXH2/Jl4/ojR1ROcxH
 y8UWe22JXom8O/uDSSAq7oFboM4faIXtYxvMVuEmXtp6fRuSkJimKOH9rCemK+o7OitJ+
X-Gm-Gg: AeBDies45iZnTRGDHwXijItHF5V3NbnwhqBU7sb16gtg518ymJxUzcNTwqSTbtuAT3H
 LSTda58rCdUrYkyGDyepKbBKzV9/ySjWzyb9AOUFvO3Wb0bTyEXuVZznOr1b3AXrobcBsN5nSvl
 koDlIkvp4rO1lVyrI86OhI3qbrLnO6LQud8khTQcuhW6ncayHe8fOprfU4zp/K4OEVLs70N3JOh
 L9NNo6kJAZpre3kij4QVfUR6xqv6OkRiS4OznVA7NxUPzJopHu55mQYWGckPoQUrNgcR+qub4Q5
 l8DPC1dp2XcJdHBt6EU18J132uxN/5RNe4eP50YXvam3FebwMYZo3NbZTghFkaQOGZkFyiA2lSJ
 Cd9SOkL2U8ZmIIKSltEyfrlp4gdlawwJmyaczLJIPea0i8MwRe/iG828WkeQSt4K5NYWa19lIL4
 tjEITXvAKloYHDwd64
X-Received: by 2002:a05:7301:fd81:b0:2be:80c4:2c8c with SMTP id
 5a478bee46e88-2eada6d6576mr2056206eec.8.1777071672018; 
 Fri, 24 Apr 2026 16:01:12 -0700 (PDT)
X-Received: by 2002:a05:7301:fd81:b0:2be:80c4:2c8c with SMTP id
 5a478bee46e88-2eada6d6576mr2056181eec.8.1777071671285; 
 Fri, 24 Apr 2026 16:01:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b944bsm34075003eec.28.2026.04.24.16.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 16:01:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] single-binary: add stubs for target/
Date: Fri, 24 Apr 2026 16:01:01 -0700
Message-ID: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ecPst4MFnPlV6sFCNTzu6veFv52_nql1
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69ebf638 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Vgz0Oo33IDKrnIdMAkQA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: ecPst4MFnPlV6sFCNTzu6veFv52_nql1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIyNSBTYWx0ZWRfX6H+tJLWSU7rm
 aKRbkmxoxHXm5vEpBB25PdSGrUe+wkLDXOPcydD4uRjewMLpwQbJtPazLeUY3ndNeV+kso6wech
 qov+2G+R+BWblA4MsSI6fGM7zDJmWZeAuyWBVR8pjMjBcENLXzacTVK1Agr13LB1bb8/WaMiE2r
 v1qYRAysmpLxdEYJv6YMo/aFHNM0DKBhw067AzEHq+xsxYwiOhUazdGPp37Ul7RAI10aPkO2aHP
 wh4yjUXYLP7N0NmGYITszsfYpCtDH7CKquJW1Mn0MxFw+xPZ98L7Es0Z8cvq24Ar+SbvKhEgD7p
 sibGx+sS9uza2VXgbaEZEaMmHHWs4+05H+UXXKBqb4zbwPgv27JjaFQxuSmYFngsuFW4WcFu4sd
 HDmm4pB0A/HC8bdrxl0a0oK/cDL+hm3bwNTMXafQzhrFBtW0OT+jvjaddD406a4viOWP1YwBCi7
 ZkMZ4+9Ifd9LmxVftFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The existing stubs mechanism is limited to common code that is located out of
target/ folder, mostly because they are built in libqemuutil that is independent
from target code.

To keep the same semantic, able to emulate "weak" symbols thanks to static
linking, we need to provide a static stubs library per target.

This series defines the common plumbing for that, and then define stubs for
target/arm. This allows to remove conflict between stub/non-stub symbols in the
single-binary.

Pierrick Bouvier (2):
  meson.build: define stubs library per target base architecture
  target/arm: define stub library

 meson.build                | 22 +++++++++++++++++++---
 target/arm/meson.build     |  8 +++-----
 target/arm/tcg/meson.build |  2 +-
 3 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.43.0


