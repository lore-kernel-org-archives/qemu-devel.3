Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EB606A334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H3OPdBXf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FBLp7Hvo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxK3-0000CD-NC; Thu, 05 Nov 2026 08:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxJz-0000C4-Tq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOxJy-0001Hu-1j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:16:03 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tQaN406602
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 13:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Wnp7QvpKgD9iuzbx0aWhMi
 2EcrWrbcMgi7MV3Q0sZkU=; b=H3OPdBXf68sfHbgLI2mZfaWaTvUXlucmSi5Mnd
 LlKl93vKnSiJuB0VRZjYzFvAFs0XSqMTMn8xAE7n0XIjQW+D+V/L7Xbr7hLSMJeJ
 jrVSa7dUTAwU8itxLzDgmUsEv/RfYzzfGR8oryRNmxBO5Tp1spGU7i0MZf/Rzc/O
 BTEIsacaRWFjThKgcLPq9FWdpaw8uOdFq05af5urRQjB0qXDr519AP5qoZy8QCqJ
 8OrGMtO1UZ5PsbYZTcGDQeWtUZ0aDaYz6d4m/N96NfEgQnA/3td94Q+BRMYcLAkv
 z3eyqBdcjkOUaWljTj8CueQJnhXryEcT1qytDlN4hsoxUyGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v1qq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:15:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2c0e6653so359881885a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793884558; x=1794489358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wnp7QvpKgD9iuzbx0aWhMi2EcrWrbcMgi7MV3Q0sZkU=;
 b=FBLp7HvoC9B/2xvRBL2rPHBeC4BqO9QHRF0EPra7Eh49wMmqGp/WO5VCboGbE++jgg
 T5Q+mJ+NqWCJ0OAhO2R60d4S0J0Z9QwUeJuW5Kkb54V7SO8j+qgHKRWK8ONgeyBAnXEe
 V2mHzkhnFRwRAItsStyjRZ6mmnJq72Sp5+U7TfHVI+Qpi0pyy96wB990aFH+RCwtX32m
 jlRhGYKtEEQuj+clw19ACNKNo+jt4CHzun4ayY9f2GZv3AZ1SUBfYyhD1Wvw0A4QfEQD
 mdWbgGmyLluQ9x76lENL1oMMO1eH5+hRfchfF0IuxxfiyMxjf//h2huq6xCnNo7UP6dV
 d2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884558; x=1794489358;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wnp7QvpKgD9iuzbx0aWhMi2EcrWrbcMgi7MV3Q0sZkU=;
 b=n6eU2lMO4bb4VkkUwb2eU8rrr6ADAa6XqYewyfzzyK9iLPG2qFQh/DtnzIfVyS1DfF
 UTOE/spo3fOav05vk/ToCa6TfLQHtLEycv0CwATTI+XelaGVaU7h4jxn9cUYqf7jJdjR
 gbuS3VtyxX3/1NnwFa7l5ImI8K+jezahKmz0xFzrwBU9m22t3LG7gIhGAjYHYEED57uK
 p1D7h6loQNdGgIaAh4MXnm38xwdxmDjq5tqLDmJ/W7j5aEJV7kECPc7PaMopwnZm/7t1
 qtlS9q0Tz98R6Sc5No13NTBQEJt07nMRWwXnvjM/dfzj4c7pa08e3GWn9fXVjuEYTjCw
 iYog==
X-Gm-Message-State: APuU4Z8YDwSCD2T2fI6f5SPtcePh2sopQKDJZSw2KapesJ2HFzo4M1ML
 k+kj7zmVYJOZFF5sCJgkABvHJz25GoMB5ILcZARsCS7LBAIFQc3ZazUWBWwP3tZQT89rNjNUWnM
 nLChc1JRXlGnLAP9n/wwwfWFOAJWZYEinb9FsNJSdV6Ciceu5RbrEXWQupp1LVdHwTg==
X-Gm-Gg: AYBFou1Th0SI+5DMEJedhaxHvwUEybnOtVFHozxhk0IiJgh7Y5dcnD4cy8U8jwmB1lb
 90RP0+jth7/cXFEhYZxLB9ZZJYCz1UTggN8hjUmrJKxF4CqB+Ud3yigAKOKxtxxroXWrMPrA8dZ
 WTRgRO+peNZOOSl/x7SZOL+pR+A6b91+rAugX5KxjOu+IndBRqscG1TPl/9imd+zCHL4R94H4+Y
 /QZxrceT76WasiUt+LgQVSnFbeGnK7QBVTANqt1NfLf16D+cMgUrCs2ZWMA5mSYZ9o2pDuhsZrk
 ROjGo0SxiW2mOym4tougIqhEnqxWPKfLDTzk1SNC3WFEJlM9a2kDEVB9f1ywyQszyI/wYWYShTW
 ifsrnatqAyx+2RpmN5UhKEASaPVATf7uh24RG6WehbEXPyiuoY+qdgBRgPGyQD4MKuwqR3/P4Nb
 WmXMuD/hET10SqNR875TCWnVqs
X-Received: by 2002:a05:620a:4385:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-944217c1057mr3053849785a.62.1793884557913; 
 Thu, 05 Nov 2026 05:15:57 -0800 (PST)
X-Received: by 2002:a05:620a:4385:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-944217c1057mr3053845485a.62.1793884557415; 
 Thu, 05 Nov 2026 05:15:57 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b5853e0536sm409189a12.31.2026.11.05.05.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 05:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] accel/tcg: Fix some CLI uses of icount / replay
Date: Thu,  5 Nov 2026 14:15:47 +0100
Message-ID: <20261105131549.42175-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX0ue3gUFq2lru
 dKwitNcsQu0B9ePUUWQsmgwE5tn8f9hGamzcKNOsZgEKybuSLiDq9uIuJBqb60O2CC4WiLwdnTh
 wIkcKw+9Cwd70HCEc6i1jmM7GHgqips=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec818e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=mnQZ5UYXiK-B9ul4oBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX6E9vSZvmpv2v
 KsGry66LbLvt3izwDeqTCcqJMmDpmBI8imNP+ngjbNvz3lO+QbxOlpL+04REN0zbIX/I93Q1wux
 Fd8lfIM24B+Ww04s2KAMjl/DQG5JLzD7L4a2d3z6IuUcKG+mVswZTv6b4lqtihig5J4BJIQZ6NG
 UhJPHcQRuZaehckyKuoQNlKnUB0eie80iSxJHhUIyREJCnC/IAuMFeja7FdHnMXZ1l8fGx1yD3D
 c217jpH88rA03Q0iARj/X+r6HnPPbcFkMXkX1DAT70VpDbykzJMMFIQ6mJmu4/oED6WuN0ZFF4c
 G3AoHS4XdA1a5rtrvyJnQQqJYAH5MVkw0dlcrWcRvWJngSKuL3usttAXdNlYSZDA4mt0rzPLamF
 E96kMiQn0/I/Yotaz5XIsv+s776XQp3byUtUnGcouM/WSR0/40Q2Xd3Rvt4Z3SW9cl11dLZjzgm
 WAROivQeE1crgac1T7Q==
X-Proofpoint-GUID: dHoTyUcU2F2mkHHOYJAZqluvVS6F6OL4
X-Proofpoint-ORIG-GUID: dHoTyUcU2F2mkHHOYJAZqluvVS6F6OL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050052
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I got confused why trying replay and icount edge
cases; clarify in case others do the same mis-uses.

Philippe Mathieu-Daudé (2):
  replay: Explicitly require round-robin TCG
  accel/tcg/icount: Fix shift=auto incompatibility checks

 accel/tcg/icount-common.c |  4 ++--
 accel/tcg/tcg-all.c       | 13 +++++++++++--
 replay/replay.c           |  6 ++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.55.0


