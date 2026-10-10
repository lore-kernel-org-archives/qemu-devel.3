Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9859CA9ECA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFgJS-0001EU-EH; Sat, 10 Oct 2026 19:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJJ-0001DW-PA
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJH-0003qi-PO
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMBSOn1608947
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Sitl/4dVQNnYjNIuPtW0h1
 UL87WGJEF4jOclucZi1qw=; b=SHlzibFWMtdcVw6O+lJWxy4iYrbnhOElVEezIq
 tRz3XoBMl0hLfhk739QPtnQ1oq9BOcj4RdY7V0h9M4IAq5Hz0TOsgR/lAwMSRTv/
 X/go3IcE7RzQCMR8B5dqT6WNiR/i8KG5FmmnhKnv2ccyc5kq03PsPjc8pCp0Lui1
 B2KJWgMPXNFS+iMFIJBl/x95Mp7W9Dix/w7IEU9zuxjzYkY8bdNK1HcK0ep0WTRs
 9lnQtlHxYraz5Pv1mij9TokJw4xFAMIl6MMyWf1UPsOvul+VCxi7tyrN1y7OA1La
 bZrZURy8LYhXkOqTRpXf1XW75PGkXuwb/vUl8NLtRqydXp9w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqmtbws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34e676375d9so1068094eec.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791674216; x=1792279016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sitl/4dVQNnYjNIuPtW0h1UL87WGJEF4jOclucZi1qw=;
 b=J9bItswwRLwOipDLQR9DyclM+FG98c6jtksGwwsFXZt1RCc2oqIe3NeGPRmo6HyGgv
 YF0kX+Z4fHb0kuhvSKRwIFcY/7QexnpKkJWP4juMnBOTblsqUjXh93UyZAJM012x0k/y
 S2qfrazwQb4c3skEqKXDwRBj3BKUdoZHN9YvkBKEinPrpL7VRFm+Mv/Uw8Lufo1Ay2xB
 ihYOQ51nCOXhSJ6bslPpx8P9A4wLe8YFYHshHVvTWBQtsgTY0+91Yye7ci9jIgA63VN/
 KvObUId0mNgR64VX8+Z56pel17XyJCoPgK8uscqGxSvGVasBGk8/Zz5mnl01a5f9Hy6M
 LA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791674216; x=1792279016;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sitl/4dVQNnYjNIuPtW0h1UL87WGJEF4jOclucZi1qw=;
 b=NktrdjgefWXX9KKhfq94sxjaF8bN4fuOlJLAVpjn6SX2tbimJK5r1IF/38vpCinXaZ
 5TPpQC64S6pcZWG6A2kcCiFXbZVVGSXfK3VtYwZkstTmJVObhDA1tLYS7kavtR8+z31A
 PmDGAYkmPFOJvyLhAVnvxZ7PabYPmb9ifW6ealbOZlQQ+g5bjT/VILktcaeVtKErA6o/
 KzMlajLgNyQmXqfV3uebV9SC8UgOhqUyQdcCBNj81mM7sUzijkCZBwHBuIAnDPFjfm3h
 DPoWj/Q93GXkj6QO0FEHmAN7H5SvEUviDCVb8aByMWY4FeNO0kZcSbVgXT/i1AAIEUKz
 mdsA==
X-Gm-Message-State: AFq9FYIosDJ5Orel+/xi4XBtpeTGkZSJ55lmyMbHWXTRt2OMqxaA/Ln6
 yeAavfylqqdZm9CtorSMg+ea91Ei9FhYCSDEkqw6HB71q/2/yncbjijvi0fk6TPtiNZa3IekGUv
 RAqE8baH1avPatxp+5Q3kb8T2IIpkoNOb7gjEAZAB+9+E7tKhriu7SEts+TB19xl3aA==
X-Gm-Gg: AYBFou2Gm5TGVPDPzKfcYiasEXwDU+8v409gp7+t1qDVznlv772KQmc9QdsLLLSAF+L
 9Igp/uVH53/0QwJkVGB0xiCZD/eVbuLnf3/jX5Klp18r+tqllv8/kg6K/dPnNrB3ashb+Fy0tMv
 q7hqCA5zus4pFgWnH+Rx4LSFNE+LOOkUV+FETaPAxn9IKKZrhngqbJs2TjHRlYXj+gwief1j/Jl
 blRJ4GK/0Wdx4UUNXlvHZB6UQA+ObspsOw+1JiZfS54klSUIdn7SD5O7JVr3ujsoqyyyhXKy3Lg
 OMs2sZuEEqETcepBQqudMmcQ0nYmHf14oc0QwASWpdRnIj+YPT03FWJDof4EwyB2ymGMhW6yR5Y
 EAzoihaDYhC9RUPDyYhaWYOMBnuqv2M+BzxBLtU1hltX0N0qZyM63UX9fmgpG
X-Received: by 2002:a05:693c:8818:b0:353:7d3a:1959 with SMTP id
 5a478bee46e88-3537d3a1aa5mr8357942eec.26.1791674215654; 
 Sat, 10 Oct 2026 16:16:55 -0700 (PDT)
X-Received: by 2002:a05:693c:8818:b0:353:7d3a:1959 with SMTP id
 5a478bee46e88-3537d3a1aa5mr8357914eec.26.1791674214823; 
 Sat, 10 Oct 2026 16:16:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca67b21sm18285396eec.11.2026.10.10.16.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 16:16:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, mjt@tls.msk.ru,
 peterx@redhat.com
Subject: [PATCH 0/3] releases: build and run any QEMU release easily!
Date: Sat, 10 Oct 2026 23:16:45 +0000
Message-ID: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX2if9CGCa06WT
 a1nZtQSGtPjy2M/legZcXpv8Hn/NvFV1nHZw9igrctq2J287KPv9j9epgI1tvBOHAmUpIwSeCuZ
 a1sovAu7tk2S0eY7v8bqhZoV7hVrOQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX6aqasURkMMNf
 nVYE3aut+KvHgvWzPn4Ru4FZW+e0IXqX4d5Ib7L+8Ey7v/V19+WgCiPLH6B4AKLO85gpAVB0E3Z
 MIfh5pupPTgN7iHAySY0vqkY2QoIn2bgmiXYNQUx19VfEO/Kj6UcXSjjwqJtCKwbtIScEPPWF93
 RKiQ5Bjrt/cM06s5SttLs1L1NPbUMRCvt/zD22M+oNRgnu+bpEzkn5nw5rOvlRX+RLjHcbdYZfX
 kzgP+hufZUGgzv64XA/avm0mnPE8Mkk+P2Pq4um8tnPQjkNc6Cl2HcUouT7WcOgdgV93KQIzMWD
 QxgvWs42gi9T6SSUVCZE3/a0/MoqhiuEc3yjh4CuYGtvCu9uTqkLsCqRcpi9sBeI5wjP/AenRD4
 sgUgKrYnwMj+KnvcawV2WiHlh7o7eD3UWeg+dw06VDF7PTZ4PH4BXOcyinMFAIklquorcZFo3RM
 itkrdBd3hg55NspEKWg==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6acac769 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: sJFzapVLceM-7_7IzkzZIBGHbpJxKPb_
X-Proofpoint-GUID: sJFzapVLceM-7_7IzkzZIBGHbpJxKPb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This series was inspired by a recent post from Fabiano to provide container
images for migration tests:
https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c

The idea to be able to build and run any QEMU (past) release with containers was
in my mind for some time, so I gave it a shot. Finally, it was easier than
expected to obtain a single dockerfile (with a few hacks) that works over all
our releases.

The oldest functional distro we can find nowadays is ubuntu 14.04. Because of
this, the oldest QEMU release we can build is v1.6.1. Previous ones require an
environment we can't get easily today.

Images have the absolute minimal content possible. It's only qemu binaries,
artifacts (roms, keymap, ...), and libraries. There is no shell or any other
tool included. As a result, images have a size from 240MB (v1.6.1) to ~1GB
(v11.0.0).

This series adds 3 pieces:
- a unique dockerfile to build any QEMU release. User has to provide an explicit
  Ubuntu version when building a given QEMU version.
- A script build_release_container.sh which automatically detects which ubuntu
  version a given release should be buildable on (based on date). It works
  great, and the heuristic works for all our versions.
- a script generate_release_links.sh which creates wrapper scripts automatically
  using prebuilt images (hosted on my dockerhub).

TLDR:
$ ./scripts/build_release_container.sh v1.6.1
$ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version

$ ./script/generate_release_links.sh qemu-time-machine
$ ./qemu-time-machine/v1.6.1/qemu-system-arm --version
QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
$ ./qemu-time-machine/v11.0.0/qemu-system-arm --version
QEMU emulator version 11.0.0 (v11.0.0)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

Pierrick Bouvier (3):
  tests/docker/dockerfiles: add release.docker
  scripts: add build_release_container.sh
  scripts: add generate_release_links.sh

 scripts/build_release_container.sh      | 59 ++++++++++++++++++++++
 scripts/generate_release_links.sh       | 66 ++++++++++++++++++++++++
 tests/docker/dockerfiles/release.docker | 67 +++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100755 scripts/build_release_container.sh
 create mode 100755 scripts/generate_release_links.sh
 create mode 100644 tests/docker/dockerfiles/release.docker

-- 
2.43.0


