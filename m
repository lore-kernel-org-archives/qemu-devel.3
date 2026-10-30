Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aik3RWSH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MSZM9/la
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnyb-0002KA-7B; Fri, 30 Oct 2026 10:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMny1-00024E-0s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMnxx-00068X-5p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:52:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER1o33515193
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TABjgzyVXMXxjft4Nx3Ixz
 iIXDADWY29Iye5UvVzhVU=; b=aik3RWSHiYLyrXHPMSsUQ84+wNM3+HcWAizjSC
 cmKMkqrY2tRnvUSsugpwPWkXjWv4wU8gPBOmcm7OKm2w/fuYJYeS1l/aZstTyIcg
 lvyezbHneAabrX0co7d7ac02yH5ojBUQ6tmajt5FhbJJKZPnAm4GiX6To25fQiVY
 4WzzWmECdV+61JcG6uVS44DE/DYyblxHTz4IjSehxdvnVuvJW1pX0x4SrKOhskVW
 kUqPvGnsV1RDjiFAZSfBqy7tE9eHtYR2qoLgXozG006Up4RMRJ1So2ZPt0vvxhTi
 F8A7sWSCGOfGYKDlCsYAX4ypwoE5J7Ih4+SveqxpD/Lx+50w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkmp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:52:23 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc099197b9so564385137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371942; x=1793976742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TABjgzyVXMXxjft4Nx3IxziIXDADWY29Iye5UvVzhVU=;
 b=MSZM9/lanCbQe8jLJjpy3tini/NLbq4NYeQ6DkaW+IsD7xNY72sH8bsU7Z6qfn8hWP
 NvNocSGek++vN8QitgbVi+N2vEU+bA7tW5S4/bdZuG1tIfzFIrvJsc50t3fpqdlfXJXi
 krw3LDkZQXoAfzM8wdYrEnOxjRFm2RrHF3WJ+yMXLBgRyJJze9UMWfa4AsmfH72WfQMa
 /8zh12TcUrc6uaXSaRa5wM9nl/V4z6fpKP3I3rYNfM+tU343hRjgqjs3lq1vmBaFZRTo
 xxhVZF+8lNnVZbpkP7nQLCDbeSQmmSH40kxKUoxWt7Lv4cQg5NNnexumztbG1IZ5xVi7
 jiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371942; x=1793976742;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TABjgzyVXMXxjft4Nx3IxziIXDADWY29Iye5UvVzhVU=;
 b=lJJA+iVppQ+kO1+qENjdnnMeQWvgJaTA60kofbmkv4hPCJnDpMtsIddLKrSX83Tqiz
 TRPRy7l0zz0PXGtwpTmPtoBVkJkZAOkb3TfvN9cYmv9Zsucch9ibGUWk96XtbfM/s+la
 GsBoZ1CKVyJK+d4kBqmUQdEi6QPCiAZqo4dFpFF/zk9tekc/owdDoYEr7/48Q9sCxSZ4
 taEnNHMlXF4sHDRUtgxyKDAY6Ku50wWXy6gJ1BC/ljg8mY17/vvud5gCZtFWSEy/IYJ0
 FOMqIp+XF6usR8MFIyed/oyJkhYXYhil5GcgvfCoQEHxe+5HC/LH5ZaYiJNmq62eN69t
 A17A==
X-Gm-Message-State: AFq9FYIuJC3JTpVgBfMlC7y75wY6yWdQbA9//lyLH79LA1WzzvhWkVtz
 jrh0CnsXhuVXOEJ36/PfxYrJ+BN2al/PAWp9gd8B/FJZ9oYy93VZoSLHhGjsFTxX54yhnLUgYS1
 pOy4WNEv553eceQ6WojaXPNWO3evwGO7FVTKTh9mKE7+47epympvaZrEHXjWhmuAxkgS8
X-Gm-Gg: AYBFou1IXjfevMCVqv3d7r/eJD/rthzWF3fz9U8PGkp1sVDKXEIgdkLfr5kBk/P6t5f
 fFzh1QFsaRMBDDaHuKIDpj9vfMIkFXTz8f0NkjOhKYZDZIrLx1hUiI+5LMkdcqyQCgZ+q8l58pn
 FqMtKVcBEH2GHFkYGc13wkDvSzRDklThSCCXw/IsE0VPztAZuxKS+8mZQ0dV0qxvrVmnHJLMhrV
 wLCB8P0VkBJlR1MhdbOraWPNBob92PDpDnAiGOp6t2ojtqhhRS2+11yiMpuEKfUJCVecBxwS/PO
 AGd13czh/wNlZ/a3Uykb5C5BG3TflpFD+ZzhgtbqzvUHendr+6I2nnuklC0HiWRNEfQb6Ikau4n
 i6mKq3W0DYXEJjZJyXacef1zWvpFF1BamTqeH0cZBFSuOEWjGdFL6G+sCbQqLaOhPKHmAREhvCg
 L9Wjq3l4kAlQ7IfZAFIPonh756w6wekg==
X-Received: by 2002:a05:6102:3590:b0:7ba:9a61:23eb with SMTP id
 ada2fe7eead31-7d072dbb209mr1194419137.37.1793371941283; 
 Fri, 30 Oct 2026 07:52:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3590:b0:7ba:9a61:23eb with SMTP id
 ada2fe7eead31-7d072dbb209mr1194402137.37.1793371940827; 
 Fri, 30 Oct 2026 07:52:20 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d5dfsm4101525f8f.3.2026.10.30.07.52.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 07:52:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v2 0/4] tests/tcg/mips64: Test Octeon POP instruction and
 report with TAP
Date: Fri, 30 Oct 2026 15:52:14 +0100
Message-ID: <20261030145218.58385-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d8LdzP2QBeNZH2GEArswtgHa-mtPHuGo
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4af27 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=r8K6MaFVEC7R7WzeThEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXxA5tC6WXsLgS
 bTY1A+hanNA6Io9hsfgtamNmptG+g6JfpoqkDDw/FIj3NguR6v9TRqBLR/vPCtOyG/GfClbw+Sw
 GTG9aQbF9EZ3yp1NUtFQjvUyDekCQELZPHu5ItjlQsYzzf+qwiSk8uV49kAZ2YeEiwb7PpJUApl
 mjx1egv05qtkgmIPNDT693i6aPWUiheMwowfBamsf65LbcUdcPowMmWgGW6giyHZFh2Bf5KY7Jc
 pPTEd1ptxFuiXxYbaKBYzsaCnrS6DJP0tvMtrdfhf/+yaGvc2POtmc8hhLvkQWG9L/HaEZg0pek
 83V6GUYqxOrkFR+Pf+QjbnAyaMxcr5fgiFyYOWt0hdbiEkFSgsa4bo8bICn7A4IemQLQisBPzXS
 qphppdVgB6uZNjN3fUS0XcTXszUTv73lFWU+2OI91oVeATrNRnGSy3NjeSKfFn/To3gicwV2VdP
 Kwj9QxnQJOEzk5hxnyQ==
X-Proofpoint-ORIG-GUID: d8LdzP2QBeNZH2GEArswtgHa-mtPHuGo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX2i2O6556anxd
 cVUsATHhVccu5zQtBed3mvt8b1UucrZCRldGt1HE21WLWT4/WXyrEATex1b3RXhoLT0l5zW+0i7
 NMf5p12hegm3L6WXbagtFh7CROt2LAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Missing review: 1 and 3

v2:
- add generic tests/tcg/include/tap.h for reuse (rth)
- cover it in MAINTAINERS

Leverage support of TAP protocol by meson in the Octeon
tests, simply replacing assert() by a handy CHECK() macro.
We were only testing the 64-bit DPOP, add the 32-bit variant.

Based-on: <20261029151317.19170-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (4):
  tests/tcg: Add minimal TAP helper header
  tests/tcg: Allow tests to report results with TAP
  tests/tcg/mips64: Report Octeon test results with TAP
  tests/tcg/mips64: Test the Octeon POP instruction

 MAINTAINERS                     |  1 +
 tests/tcg/include/tap.h         | 60 ++++++++++++++++++++++++
 tests/tcg/mips64/octeon-insns.c | 83 ++++++++++++++++++++-------------
 tests/tcg/meson.build           |  9 +++-
 tests/tcg/mips64/meson.build    |  1 +
 5 files changed, 120 insertions(+), 34 deletions(-)
 create mode 100644 tests/tcg/include/tap.h

-- 
2.55.0


