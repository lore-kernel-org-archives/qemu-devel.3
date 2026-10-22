Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB9606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gdtd29Qt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bbUguG3D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzER-0004WC-8D; Thu, 22 Oct 2026 16:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEP-0004Vr-IA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEN-0006Zy-Rq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIJMkZ1498757
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iAnJHbAj+7G
 rhGqt/YgmkPVVsy9mY2bq1PLttW1rYcE=; b=Gdtd29QteZJPkMOAE0Uyj6apyQx
 pcdA58ns0d19IuzS7GsAFgob3TR6Jg8Y1PZjB8YL+scEbhdV0g2OQJ3A+bTK8ATx
 NoMSEZZYmfH4HJ/K2ToExUPQzJFMBN7XTj/fUE5z3IXel2BlwpY0jPPFe+gzhxdt
 PdFmD0F0wSKU7lwfAUnXJgAofLHYCzaC54RvVOPbZ9xN5dpn6fjMovXZ0aXz78Ha
 rnaDaVvrZOHgwxku+oCrYAwXnbbZc8/kmL/cDpl2CHXVGIM/kEiMM368g66WgNvo
 wwuL7X8obxZUXmyFklrPRBVKcNQBMAZ3yhUFZ8rtkMguiH+eyNmZ8zhqJQQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8dg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd68bf391e1so109658a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700262; x=1793305062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAnJHbAj+7GrhGqt/YgmkPVVsy9mY2bq1PLttW1rYcE=;
 b=bbUguG3DGFB0onrWu2vV09u7qGRxQeGVWIYMDr7q2m3Kt+UOcCN4NGN2sR3mRsg7ss
 3wm1aJ+LZ6TdDBDFh/XU/eVEhsLBZnYPCKITG0nupVGPBM/22bIpD16i2D96QviGkUlE
 0knxMO9E74BMJqv9Jw256n/sC1+l1r/H7RCSgTeP8VieHz7CVp/6CQNCdeZ6IlZ+BbZl
 6OXnHwMlnvXLh9FpEybjYy9K/7gXdfD//XVShdsAQefjfYTzmzdw3b3ugHt2QhSB8NIJ
 X4nh6yoXw5FCgnxCgC5L7WJJlwpDSyAuYhVo9ojKSBMEKHiXt4Y1N/wHoAH6xE4GBEhG
 c7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700262; x=1793305062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iAnJHbAj+7GrhGqt/YgmkPVVsy9mY2bq1PLttW1rYcE=;
 b=kj8hbIoi+75jncHwamWGE8c59kXxKgMs11vvOn98rElSDC4GGWwICkvloetnri8Lu4
 rAMjWZyFdy9/95v4CG22TsajaWMCtM/NBPVt3eT2Zjd7a/802Trws2i4vD3mWjr1mqix
 RBjdnzwZEVP2R7ek+z0RWuXn+9kX4UXlN1v4u7xDsvMEoWzqDRMFbAWE3b8T1K612Jdb
 0wlMSfy/B8K33R49GLK4M7HRpPKE9GfJARE2DVH8lbdUU3TfmLUfvOlXEtvgdQ5MHU6v
 TQ8mZC7BRr0vvv+6+8OE4IpyimaUwlev7iJgxaENePBPnplKlPZtF29rphI3h9gyV7bf
 mU7Q==
X-Gm-Message-State: AFq9FYLUGqC7CNb2O5lQji9HGJCYnNXEkI4rN5YdeA9p3b9oZWXWKFXt
 +dDPUQXDmYMRcUhA2nn5sl5MTnF8/C9meY6kPA5FLtwJ4jzjIjuNVKu4EJ7rvAAmybvI7jSDgPM
 A+2yuFMbGTwKvUCvxTG9sPCrhe5OJvTKeHcTCy/N5yDLLYXSqWQjGBp2v+XYjpS71jA==
X-Gm-Gg: AYBFou23F4sw69gkFbwG/B4MJ9inZEHK7tWqiqKiagBaa9QY7ulqqSUbyEqOY3yOL80
 XlkvRy55/sR9Cm5PmyBKaPTyZ8anrhxQItoDTMShaRQrZoJByEomRIBSQ3tz/9kKR3d/FJ9FBit
 TCEo0CkfqqpoIsxa9GmNC9MLXBceo2oLiB46sxERE41l72qTWXXZ7Ii4FkBC+Z8AM3OTZkqLDM3
 zSUnKmzk6zkrzQkJ5RW15GP0rZKDNLVQa9xnD0CZR8aGo3R1wq/7WmTpPgq59wUIzQ6XSB8tgQY
 mp9NbOI3aP7mPCQCpHq2ZbpUj/+WOP+sgmaGHEz+PvP4P3BzY/jJJPsnt2HrciqNmuUi5dv5JS9
 GqJPFo3oxeXw/5fO1xJ3wCEJ7W5meueYoe28s/vBCvXWUn63YOdoiaYG5kjEnfn4=
X-Received: by 2002:a05:6a21:7812:b0:3e2:70b3:957 with SMTP id
 adf61e73a8af0-3e3692062eemr49532637.30.1792700261689; 
 Thu, 22 Oct 2026 13:17:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:7812:b0:3e2:70b3:957 with SMTP id
 adf61e73a8af0-3e3692062eemr49520637.30.1792700261206; 
 Thu, 22 Oct 2026 13:17:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c89d8138sm55163b3a.18.2026.10.22.13.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:17:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/3] tests/tcg/loongarch64/system: reenable gdb-memory test on
 aarch64 hosts
Date: Thu, 22 Oct 2026 13:17:32 -0700
Message-ID: <20261022201733.1941651-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qILGiX4y1VyXvSfmcdGVQ3ZQ6VAHE-zg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX524lsP/0QGR4
 dON3ji+zHXuftwWrcs+GK5k0Ltytsp4r6pkIxwdiLC+iGxXuxsPaDmkm2ulfiMyC4mQbjP/FsTa
 jbGTQABzZZPrwNiSvevjdxFSLaKiH4k=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada6f66 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=-f14e7MdJ4CnexN5ccYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfXylXNgZ9dpe4a
 vZt7GgRRRNeI9qAXeExFhkqz2dKMcgbWcQUwpxwLtk5JLMZ3dSuc2DcNE9EXtUpePQmHmr/Lj2z
 hS5p0tzRD31Qd4tuPfk4zPHu4yPqsoYL0jyHRFCGf55cWU6OAw4LstyBZYS/sqQ7deJJYgEu7y0
 XCbY1f8MtAlULCv8G5nRiePNSBqI2DxnqPl7zixCiCDZXYt2qyATdqBoscsfuVk/c4F8rSuLPQB
 CTqw/frUCl51SsULuj4iy3fwkGb8LA8Fp8qHFRKiVjbqL1kAij+vq3/SY3i3tgUKSWWUCLtNaBE
 8F9iiGx9JS/iRWS0PVwhvJtu/knvqYeSPoKz8vCv0UOxxzQ2zVqCv4F6aIovckWhhU4X1hwqakt
 LQXoOZIC121pL8VRt+Lpe2A4ncewSEggE4nqIaVcyXhrieZC7OGXsUepkf1R0rqp5ph+zEg4rw0
 D+QII2i5Pw8Cb9eIY6A==
X-Proofpoint-ORIG-GUID: qILGiX4y1VyXvSfmcdGVQ3ZQ6VAHE-zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220080
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks to check introduced in previous commit, we can get rid of this.

At the time, my aarch64 host had gdb 15.1 installed, while my x64 host
had gdb 16.3. This already exposed the problem fixed in previous commit.
Unfortunately, I didn't investigate enough to notice it was related to
this, being busy upstreaming tcg tests series, and instead assumed we
had a bug somewhere in our gdbstub.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4567
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/system/meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 0f81ef9cfe3..93e76b696ed 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -24,11 +24,6 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
     new_cflags = cflags
     if fs.stem(src) == 'memory'
       new_cflags += '-DCHECK_UNALIGNED=0'
-      # TODO: memory test hangs on aarch64 host
-      # https://gitlab.com/qemu-project/qemu/-/work_items/4567
-      if host_machine.cpu_family() == 'aarch64' and 'gdb_test' in setup
-        continue
-      endif
     endif
     if 'gdb_test' in setup
       setup += {'gdb_feat': 'loongarch64'}
-- 
2.47.3


