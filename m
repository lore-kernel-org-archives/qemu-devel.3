Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dKFtJCRm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HWB4Cyie
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDI-0002Kv-I2; Thu, 29 Oct 2026 13:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBT-000777-VZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBA-0003eQ-Kn
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDjK4182196
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CX92vP/9XvTPJiaSH48H4U
 46buJ7402jpWPvuNIzmOk=; b=dKFtJCRmaxxfL3Sx/NH2v4nD49ec213897NjaU
 YWw8CcFv7obw/i77znnD+sjgK8ofHwhw4IHpQloTo4GjUaPOMvF4Gi4ONZX65cBw
 U3wC/n68FyrR3smV5h984JMen5Fydk7rrc3O7JZyQcqzBhz0JaZ5AZBhZ9bqknvD
 9H0RRVyBzYlyxa7o/eBeveVLeUtS5RsPBOZDw9V83bpyqpc+pccYLL4zdr3hsOjA
 vdMrzsPwaymrwNr70Xdg/8efZC3r2gsfR++LluhoubWOlkVNDNVvUCUUYTPyI12U
 WGjZsWXv1BHGtegVj4TAt2E1OO9RqtgPav8aNt/JrfaiXS6Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r5qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:37 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cb225252f4so743200137.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295877; x=1793900677; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CX92vP/9XvTPJiaSH48H4U46buJ7402jpWPvuNIzmOk=;
 b=HWB4CyieS5G/fXF51g58bI33Rbe4DOod38W6CYtxAam2CXHEjQVKEEIOvusADaN/iI
 3swDiSWTT/xFDDHDN+oT6Nm2QicDvxXwmPjm4fP08ojjUSB0ifY1E3RLArbZf/FLwYWn
 biHkGf5mjl391QQvPa9Ysa4/3dYxeEn3hTi4FnpS1H0My+ENTLI2emvxo67BT7LCF5+Z
 ag6jihugFaAXYwVNhHq9dvJSvDTi+buuxwklgkDU0EhAMFluLxNA6CiwF9gORCeXgjb0
 4E0CuaMspELf2UfhSQ04OQCXMmNgBk0mTv8HBs7nnup0L9sHfFSjv4DebQRRo9HVoboQ
 VOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295877; x=1793900677;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CX92vP/9XvTPJiaSH48H4U46buJ7402jpWPvuNIzmOk=;
 b=yHILVcK82uqaB1EKtReGop22wjXUZmkLBjVa+oww51JUaqX5JZFBJR8IwKVLrLciAj
 3zyScPVi7UX/rxtshlbGtjVLKltJtrqWav/9JVBhB1vGMBSKLbYH3Jpaz/ZX5JTOQ8nW
 /37NPx/YT5saEH1V1+Jz9gyPVDYu0d5kxmtjKm0lwo+mGPW9pjY12c6WuryzEC5Hk3hR
 7Nvs+yJ5sd3HWZCZvqOLwL0QvvhKzLWT227KDrGnZR7GH2Dd04XnuHj6Fg9DAni1CT9u
 DyCxR0pFh4vCfdRIr4kCr21S9rA/cYwPLgED+aJlVS+/g1NOXRzIpK57Go0AjOlAY+D7
 sQvA==
X-Gm-Message-State: AFq9FYIeHtX2M9zm2nkhI8czsOkCNWIYACyQBFZBob7pw7WlSa69ZqwG
 fOdv3qpWa2IWXkZrZD6vWqgf/s1IxsfkbYifYBcIoZgNCTNcaVFGDQUIPGc5DHPIyzYXRFfDu55
 9lSS9JmK6YukMQWMO6DvfY2E7YFgR5OODJrEBYtCnn3DBndvqVXFFfDSDDc8SiKwEcCvh
X-Gm-Gg: AYBFou10ZVRBnPHdwhp7jxzasvmmDvi7gEHqn11N3I8mWJRlR4WJ15F9GDzO/RjJzZo
 l0R9fxtJGqCGG5o5QfYYrZD4c+71hXrmqlNh9ozVwMTXdfaIVyznKjCnyFA/QJNkrP+v1jvi2fM
 W096EUTU8z1Uxicfq4YIZDxJYHtQkfMzgnPHneLmA8B8OZWLP8t7MHH8VmZS+cwaWlaGWSy3/8h
 4Go8/2ZTN7O7hgZ/PIJ4WRmj7xmYEAIxV183ggxPs0P9E3NsTcwmCpdO17z4k570CAi6SwyIM4I
 fFAJ+SYQgmwTdE2jhR2zcIs+xDF6AWjLdd2J/B2kjMmUI2kIM+MLZ0dsxFhA3fxSkNNqRbgdPZS
 j9op5mGldmq3SCCaHUHFG4Zj1mXQuRDKfaSgPsTtxajrnC9YNjunE6YITJhsJNBhIKoxEVEc5hh
 /P6n0VT9pWziZvLSF7z9QrcESQO9snNg==
X-Received: by 2002:a05:6102:d90:b0:7ce:78f9:ae13 with SMTP id
 ada2fe7eead31-7d05418318bmr1043887137.10.1793295876856; 
 Thu, 29 Oct 2026 10:44:36 -0700 (PDT)
X-Received: by 2002:a05:6102:d90:b0:7ce:78f9:ae13 with SMTP id
 ada2fe7eead31-7d05418318bmr1043871137.10.1793295876345; 
 Thu, 29 Oct 2026 10:44:36 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfba77csm432817f8f.53.2026.10.29.10.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:44:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/12] tests/tcg: Add MIPS32 Release 6 tests
Date: Thu, 29 Oct 2026 18:44:21 +0100
Message-ID: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LbBxJ448E98af_XMXyvmPF3nx094SzmB
X-Proofpoint-GUID: LbBxJ448E98af_XMXyvmPF3nx094SzmB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX47kD2pPhNT6Z
 Eqv/ajrGRYMx54onUl6QhUWAYUbechto2KUMxx20sfTapwvh7gNQgeYaeLT/2oyF4RJ42ZxWWzt
 Mr97YwbLLCfkSr4ozq86J3ilgsQgoLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8aXYPRM4DzBa
 Uwk7nsIntlu7N89CTu4f/wgTvFdl0Bo03z7gZsViNEB/wrU3FIrN0krrTuaLUqoaJ3syTkFl9J0
 xIMOoucAvzjB1sXwIgVFclrr89oxUvq0xaBJl8ovW2bCU+q7QUMoDqVf1nRQRuo7sCgmffMtiVc
 A5AauaUZN6dnxFejia2ERQq8wHQL3zQZb0hy/2xibjSEzr7mt97JZZ4kmouAnNyboXmZo0ZjJnT
 q/DNEDocgonvdHJLgzaJud28Q9qZa+YaFruQanzOjNCzRKdJsiW+ycvjXz85XgYU9pINBUmMrkB
 ccmicqCt3exoB5cbjrjqJEw0FKe1Ru53YaYE5uVIwfwEBAQMMi/1J5FKJOkZvI0KP3hGea6XSy2
 6aEly082KjDHCU8JrwHa18w+M++CW+ygwvrUFuUWHJ+c+mO8uSt1HT5NM6683u4SR5t5f7qVrho
 X3PEfKpK9UHnYU24fsA==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae38605 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iiaRKsXjzHr8uzqHWY4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

- Include Bootlin mips32r6el toolchain in debian-all-test container
- Wire it to meson
- Cover all the 32-bit opcodes tested in MIPS64 Rel6 (using TAP)

Based-on: <20261029172319.25766-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (12):
  tests/docker: Add the mips32r6el toolchain
  meson: Add the tcg_tests_cross_cc/cflags options for mips32r6el
  tests/tcg/mipsel: Add MIPS32R6 logic tests
  tests/tcg/mipsel: Add MIPS32R6 shift tests
  tests/tcg/mipsel: Add MIPS32R6 bit operation tests
  tests/tcg/mipsel: Add MIPS32R6 multiply tests
  tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
  tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
  tests/tcg/mipsel: Test MIPS32R6 DIV, MOD, DIVU and MODU
  tests/tcg/mipsel: Test MIPS32R6 LSA
  tests/tcg/mipsel: Test MIPS32R6 BALC
  tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC

 tests/tcg/mips/include/wrappers_mips32r6.h    |  91 +++++++++++++
 tests/tcg/mipsel/test_mips32r6_bitops.c       |  82 +++++++++++
 tests/tcg/mipsel/test_mips32r6_branch.c       | 128 ++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_logic.c        |  68 ++++++++++
 tests/tcg/mipsel/test_mips32r6_multiply.c     | 108 +++++++++++++++
 tests/tcg/mipsel/test_mips32r6_pcrel.c        |  95 +++++++++++++
 tests/tcg/mipsel/test_mips32r6_shift.c        |  84 ++++++++++++
 .../dockerfiles/debian-all-test-cross.docker  |  13 ++
 meson_options.txt                             |   4 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/tcg/mipsel/meson.build                  |  34 +++++
 11 files changed, 709 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
 create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c
 create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c

-- 
2.55.0


