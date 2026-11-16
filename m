Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7D606A336
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fVRMSDfX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DZq+NVVm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT633-0002EP-6w; Mon, 16 Nov 2026 18:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT62m-00029G-T1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT62l-0003D5-3X
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:24 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCDNg2710439
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7Y6HbsuVTt4pcNiIEGg5AxaSJbtzAiBWflk
 2JcSQMtE=; b=fVRMSDfX5+E5WvQQMJmRMjEQ01SNXtqZJ8MXNOKDHz+/a++zBnP
 c3dWRX7CkQFT/9eQS6Vs+nU7OufXQMl7oXuUTdpEF8tIIFEZHdwQW+N6cwXlRq49
 XXIYeBtElvF+1+uvI9aNeLtGvUFlF2My0WE5fT0ERgmW8S8lNAn3A+xbxucx8w9x
 atd+jiwMlDyY8Ib1aprVGUMqQtfRgO1zxrmuBTEgq1IZJfYmCAl1E2TFad6et2FL
 DBfCcJd0v57pAuoW3AncyCDC1xPkUWP6+7t32eGAjJaNY6gpL9BWXgoFcuTqWwX/
 OSsoLQHKejLdmBjP7nDleqnvO7FPZa+b39w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htgck7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2efda2c6605so1829805ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871401; x=1795476201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Y6HbsuVTt4pcNiIEGg5AxaSJbtzAiBWflk2JcSQMtE=;
 b=DZq+NVVmv/scJL2TiU+6HpXrLUXwgQdIIcFKVv0SmwIjiuiWksSxV6ug2ur7p8TIux
 H43YRskCjXKyiTI5QUWcliQ2w5pHzDAeGS2cYmUvD5YiP78p+2YSmIvIRf/uOUdazIKs
 9fHPdVsDMEyfSO1D+qxyQPqvbVMmgvMEhfGfyVLEhBelEBR4T1U8TizdpdHUP+bDuCLw
 wkNX1WlLooW9D5rjSc/qxSmZNoz18PC0LaMmYZpPU1nXYyJg0mRLLZigicV7usYcOY3h
 6Ae09PhVUOOrtKNjjHepYlf1fxv7qYJDteyEMHctswfdlH3YeDl4+XLupHWh7jrNmFM4
 7OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871401; x=1795476201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Y6HbsuVTt4pcNiIEGg5AxaSJbtzAiBWflk2JcSQMtE=;
 b=cfPHtXdSU1spmm10noIoJDMmbCEVbiO8eCmjcBkcRgIFSo0J0+Mb+PlB6bT8Lg3Z7j
 YZZlje6OA+y04AZiuOYuiIdJ8+ZBhTQsbpXuDL6TqwtRsKu4obqnVbuTRfYa5WDO+ztd
 pYXsFrxrfYPvJ7st5qNFoWtNoGZClGvmM5PklHH6J7rN4dgYdKxU9oh5JiswFEKUm6SN
 kOyIjF5Wn9774dUSAS95CPqNboEzSDuw/HDMAPIxM6VSStFlMi+zvtmUbL1G+B74+Xjt
 mSg1P2Am0zP/XOpCk0yetBxnOGsH+tsEXK+lOsSxkStlDEjvwgscES+pUQrRxd9qASoU
 h47Q==
X-Gm-Message-State: APuU4Z/RFWNCkVtG1elWM+aU4IwyFmSNqc5Uzhrvv8BKBJ9Jmf6mJL8A
 Y183ArvhwXckFBnLfMxAST2TmGG/h0xbAxQ1IrZngui4azD4H7NshLPAUQz09WDinzXil15Nxfa
 uHay/FZTUjBm29lIrv2Vl6ADJhERYCr61QTvwK2X5K+tk9ng67ok1o/mumLCu1ymWTA==
X-Gm-Gg: AZFdTZempizCr5cwODSidpAFiBoxv/krffQl16l56m1qZEzmQcqxkZMUqcauZXJsxQ+
 cxdDhwqaToD721cO6vo9+/mbu9XtmzcfXoUIImqf1bMzRyNlONHSQntSDy/zjtlAEih7/xXeTRU
 tnLgUeOAB2AEa754/UIn8pYxtDyNHN1B4AFELu/ywiPNueZ5+0ORtJcDNKU2L9A70PaJlDgQRyQ
 pG9yIUb0+k/3wE4ZgTrmOxSv1Djt+1N31FpsDch6J8v2fO6hHHOOgpWMGIkUsRjEMb8oR4EPTRx
 VrqqQ3k9e0kDRNJ0BprUd7EuVBUTqooSJ8e6DVxr7/dfH892JIvlPQIedV/wFSyXhpDLvRf79Qb
 Mx011lc0p7Z5HI3kNtQ/zvRIlOooLM+kqJjnSthih8qN7p6gYR79fPd7ZRRKJ8elxp0+zADE5Vw
 4Fnf6EspYyPvHDnTc2jbB+gPZFZRs7rsNTEQRk
X-Received: by 2002:a17:902:ea0a:b0:2ef:def2:605b with SMTP id
 d9443c01a7336-2efdef26582mr888255ad.10.1794871400960; 
 Mon, 16 Nov 2026 15:23:20 -0800 (PST)
X-Received: by 2002:a17:902:ea0a:b0:2ef:def2:605b with SMTP id
 d9443c01a7336-2efdef26582mr887965ad.10.1794871400428; 
 Mon, 16 Nov 2026 15:23:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a586c1sm4737915ad.43.2026.11.16.15.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:23:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH] tests/docker/dockerfiles/release: use full registry name for
 image
Date: Mon, 16 Nov 2026 16:23:11 -0700
Message-ID: <20261116232311.2761545-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX87/XpUEnKiS1
 lIf0ZNwRSY8wG9vvlbAhWXlZMCgjNix6wk7ri9Iku6M55O7PBRCl/Ki8p5NPrrSVIiiI1qsHW/N
 Yal4w61z3LUst7f/QKEK8uv/+hCGqs0=
X-Proofpoint-ORIG-GUID: 1v1cmxYFrczTfPGiuEFSyf0Eky68lQ22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxpqAQFqtW05u
 2fNLuJAhTVc+9FvLHEAPJxJ/GACX3xIaLTxCdcc9T+bftOg19i43g0ivWC0h4yeKCZmRbtpjpWo
 m+kMekDUjgXlRnxDMi7Q4ngVFMYjDb7jmafKGjHDSAhbQ/RW326r8wvirK4MpT+KFcUZpk1G5/4
 7SJqr+3dCZbFUvzvAYZ/q2V8ElyqvtLu25jypOypJlofZeKpmH7ibmJKT4FZoRabB+vDY49frBn
 HBrG+FoXQJLmnZHb3u2DWZqpjFuEosY1j03poILA2N6pR/rCfuFOlsE2NE0HLgeXy7+tXBJ6nJw
 KZVumh+xvrYENY4czI5dSvpLFwo2TVQ1L2jKVyAqvrWyL1FRTlKHYNQDC85occeaPS6Ya4BHJ4t
 dczW2JRMAW3CizVEGL6DQsxKqS+Og75PygPQBxilvaOxZ/X0FgohqEjUF/Ln+xSi4Z+ZjJ9dCOn
 /5lRv1oqob5c6CJPzow==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb9069 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2XUeuzD-yKwfGw67cR0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1v1cmxYFrczTfPGiuEFSyf0Eky68lQ22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

By default, podman does not have docker.io preconfigured as default
registry, so building fails.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
index ca6babde01e..a606eb5ee79 100644
--- a/tests/docker/dockerfiles/release.docker
+++ b/tests/docker/dockerfiles/release.docker
@@ -1,6 +1,6 @@
 ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
 
-FROM ubuntu:$UBUNTU_VERSION AS build
+FROM docker.io/ubuntu:$UBUNTU_VERSION AS build
 
 # add deb-src for apt build-dep
 RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
-- 
2.47.3


