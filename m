Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62B1CA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxK-0007wM-V6; Thu, 01 Oct 2026 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxH-0007vc-PR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxD-0001fp-Sr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsfiM3512258
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SRA3cM5/ZzcnFsThz4ndKb
 h+Of7ghYACvuQ/6y3egcc=; b=LUfwZchrE3t6MBfmkwINOmyv6P5VrZ6JEN6825
 8/upoPm9y7TXkZVpNTZzyW3IhjPtDAPLQhelw8sGPYkjd8jUc465fpxPeITiJqyh
 emK7Sd/gGAN9Wcvm13MBwu4B6IdP7aPVg091Jmn+IxhFLVguF4NVfpgYieATMe1m
 Dyy3ea94stqiZmwPAOCqlL9dKGiKV96Z8TH41HZTkfFMziJbksblU7gM0hawbkfG
 0u84xNn3SG57bHFSr6HoNy1uekhAicv/2v1W5O8CdoYDT5o+ahwlmnzW9VXCWgWS
 dQxwIr6pUani/SIk8CkntsYYCbc8wNm08A3dq1R7TS0e3Ccg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9dyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5099754eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877139; x=1791481939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SRA3cM5/ZzcnFsThz4ndKbh+Of7ghYACvuQ/6y3egcc=;
 b=kjQg4VbbsamOrFRNMkEVbHd+KceYAGULUAhKjpyQwufWkWgoUpPOs23DpeolZ3Tqiv
 yVRIo4Z3Z424vXZ7AGQ5fUBPcCY4mEWuserdHRyrd1/fElz6YNsNLoWROrk/ah/oVJJW
 mRWM0E9ujDk7IgV4i3tsRPuEVQ/5bh4I4jLNFbeGPIQBz2Rg/A3App5hlmbFwlsA4wLN
 fpCkYQjeg1o0DLQDG0wrcIo3mJhbZ71CSwzjdr1WSbDwQH3HXwdZj+70IMOORMls15Mm
 7gJGzlaChCuz9g31SJ9n1ixzJ9VR+zZsTqrB0rgIhXjAOU/631fNt9EuvBgFCFrmTiJ+
 4Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877139; x=1791481939;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SRA3cM5/ZzcnFsThz4ndKbh+Of7ghYACvuQ/6y3egcc=;
 b=gMftFErteHLHXhANVzTPS9LSmx8IycQIKVUAXm2UAaD8h0gzPzEYAwUrpYYgqoBcLW
 Jh5bD6SD5tFSFXg6hXcLb5g5+fcZqDronTNT++GpeoC+AEcv116H1vWopDXmPY0qc2W/
 o9/wENFC1e43gV6gbyEghx1Xuzfpmb9iJiNyliPkvaa0R3dm0ZlEZfvUfvp4ne52XdOk
 TleOzEq0ufEXQ2dUTft8tuxJMFDOjeV+cerrAlDc1SpP4P6WSTXO0BdXo/PGRmahwqCJ
 b1yV6cIdj07uiqwWdjglyPg0Xzvbf+6H/iUAAluy3K5CYpHr+b0OPrJuR4JMHCbD/AX5
 k+sg==
X-Gm-Message-State: AFuF++l0bk5reloH+fue29anlJ0Mr5HWwC5F07v2Imxagc9BjGXxGzhF
 Ar4A1wVPxM3726RHYfWXEgd5Adp4dOdkgbDFx4vhabcouvix1d6E52TBcl+Hajd4CETxW+XRxa6
 xP10VLFo6hwk37luyGovntezdpcAscAxjUxEJcgvfpICmmlDtI2nEErpxH5W6mhqsrA==
X-Gm-Gg: AYBFou2R4EVHnfx1q4S6f8YcXClDEe+dk0svWruE5OySwPzqJQY1zpp5Nsc8wGJ7YG5
 UnBd0uy0ApuTvMzVxZNY7CFrSgfKIyAghKTPWgThOEj8AaIV/+XEP+PgrjO2wM6SduqxdC/nZxV
 jcxeJRH6FQzc8qgWzs0eDfxXqJtfgmsboo4llPa9eXenWgr+gb6W9gLXsiBvsB05xrfjtGcBlmJ
 ObIEpVPVIcdgTxSxNrCPrYYhJMjeMLM7PmVT6fWJlUpqkNoYtjcWvvkssTlGjJ1zrwZmulUPrhB
 LifYDR2OAsZ6edwxZaVyeNH+7BKArwd6eZHELqw5BfSoDNbC0H1Cd+wETn1lRQ0M3ef4O7UPxvU
 WM78REeVKHYZqwDtm8vMKF3go2t9l6vQf0y2renuG1QfNDA/RS3YnBZa3sy6A
X-Received: by 2002:a05:7022:5f1c:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-14d3261c72dmr4719593c88.24.1790877138960; 
 Thu, 01 Oct 2026 10:52:18 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1c:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-14d3261c72dmr4719537c88.24.1790877137955; 
 Thu, 01 Oct 2026 10:52:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/27] tcg tests 20261001
Date: Thu,  1 Oct 2026 17:51:36 +0000
Message-ID: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX+fEh4JMXI3bo
 aNDLrdpPcU3xVmbSWrtWRge6DQwaPZkaAR43o33z+DYknwZ6/MFNJSt5Cke2hmGunWoGqIrLMr8
 95qmB5LEeAALLKmJP4zhAZC2TLcDGYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX9sV5FpeFk/zm
 jDpmOep1ydng2jTEr3Ng9ReoeKOKMyz1no4aAIJkl6EDQJ26Ll1xaks9rezaDUaUHDNWSA4hbeQ
 wlT+f2W22L0+1o+IuMw3N4BP/hoc8pMI7SPhs54I32Ajznkd/1J6uRMLrCJG6MGQe7MbtBg+1bC
 Trn4sJk0jdbzyAHSKldE9Ya6QhdRXfy3vIGhL/q8CjgFXSu5qzK/fRgWsBukHdit5GhzO4CxM9G
 n9lHM7Itwnp3d+RokP3ebj1/f4XC3AZak5qqdcIetankT5mODBnhYxqhFs374E0o41XyaN8xOay
 NWFpyd14T5hSnQHycAXDWpaxUPET2SnLgj3aF0fQxjs7dwA+8SFWChnCABv0sUBrDZNrV6cPsYf
 FcKTZt3Fb4DAYbCZKZh8fJZKA92QxA1j5xDlitnYis4fpx1eb+dxDDU57ZXBo0FGcQZ1bJ/LaT9
 dsoUlQ9hhymJjxWmGrQ==
X-Proofpoint-GUID: wipBhRrVyOwLgTpRDLlIhVxXQin6vx7E
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9dd4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a7pEpe7d78NTwShCFaYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: wipBhRrVyOwLgTpRDLlIhVxXQin6vx7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

The following changes since commit f7ada39edacaa5c26b30e98b94017b0b2ccbcf94:

  Merge tag 's390x-20260930' of https://gitlab.com/efarman/qemu into staging (2026-09-30 16:44:59 +0100)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261001

for you to fetch changes up to 2df2d063080a654d7e32ece10efe38f60b7fc900:

  tests/tcg/multiarch: add missing test_pnew_jump_loads.c test (2026-10-01 17:51:07 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v3 00/24] tcg/tests: integrate rest of mips tests (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH 0/3] tests/tcg: add missing tests after meson transition (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Dominic P (1):
      tests/tcg/i386: Build test-i386-opt-shr

Pierrick Bouvier (26):
      tests/tcg/mipsel: move dsp sources
      tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
      tests/tcg/mipsel: add dsp tests
      tests/tcg/mipsel: add float reference files
      tests/tcg/mipsel: add multiarch tests
      tests/tcg/mips64: move octeon test here
      tests/tcg/mips/user/isa/r5900: add README
      tests/tcg/mips64*/meson.build: remove unused cc_feat
      tests/tcg/mips64: move mips64r6 sources
      tests/tcg/mips64/test_mips64r6: fix include path
      tests/docker/dockerfiles/debian-all-test: add mips64r6 toolchains
      tests/tcg/mips/include/wrappers_mips64r6.h: add missing wrappers for and, nor, or, xor insn
      tests/tcg/mips/include/wrappers_mips64r6.h: use proper types for parameters
      tests/tcg/mips64/test_mips64r6: fix call to check_results_64
      tests/tcg/mips/include/test_utils_64.h: add check_binary_op_64
      tests/tcg/mips64/mips64r6: update failing tests to use check_binary_op_64
      target/mips: Sign-extend the SRAV operand
      tests/tcg/mips64/mips64r6: update references
      tests/tcg/mips64: add mips64r6(el) tests
      tests/tcg/mips: declare msa tests sources
      tests/tcg/mips64/mips64r6: add msa tests
      tests/docker/debian-all-test: add mips32r5 toolchain
      tests/tcg/mipsel/mips32r5el: add msa tests
      tests/tcg/mips/user/ase/msa: remove compilation/run scripts
      tests/tcg/multiarch: add missing vma-pthread test
      tests/tcg/multiarch: add missing test_pnew_jump_loads.c test

 meson_options.txt                                  |  16 +
 scripts/meson-buildoptions.sh                      |   8 +
 target/mips/tcg/translate.c                        |   1 +
 .../dockerfiles/debian-all-test-cross.docker       |  20 +
 tests/lcitool/refresh                              |  20 +
 tests/tcg/hexagon/meson.build                      |   1 +
 tests/tcg/i386/meson.build                         |   1 +
 tests/tcg/meson.build                              |   1 +
 tests/tcg/mips/include/test_utils_64.h             |  40 +
 tests/tcg/mips/include/wrappers_mips64r6.h         |  22 +-
 tests/tcg/mips/meson.build                         | 277 ++++++
 tests/tcg/mips/user/ase/dsp/Makefile               | 184 ----
 tests/tcg/mips/user/ase/msa/README                 |  20 -
 .../mips/user/ase/msa/test_msa_compile_32r5eb.sh   | 917 -------------------
 .../mips/user/ase/msa/test_msa_compile_32r5el.sh   | 917 -------------------
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   | 643 --------------
 .../mips/user/ase/msa/test_msa_compile_64r6el.sh   | 643 --------------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh | 371 --------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh | 371 --------
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh | 371 --------
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh | 371 --------
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile      |  40 -
 .../user/isa/mips64r6/logic/test_mips64r6_and.c    | 153 ----
 .../user/isa/mips64r6/logic/test_mips64r6_nor.c    | 153 ----
 .../user/isa/mips64r6/logic/test_mips64r6_or.c     | 153 ----
 .../user/isa/mips64r6/logic/test_mips64r6_xor.c    | 153 ----
 .../user/isa/mips64r6/shift/test_mips64r6_srav.c   | 153 ----
 tests/tcg/mips/user/isa/r5900/README               |   6 +
 tests/tcg/mips64/meson.build                       |  69 +-
 .../user/isa/octeon => mips64}/octeon-insns.c      |   0
 tests/tcg/mips64/test_mips64r6_and.c               | 118 +++
 .../bit-swap => mips64}/test_mips64r6_bitswap.c    |   9 +-
 .../bit-count => mips64}/test_mips64r6_clo.c       |   9 +-
 .../bit-count => mips64}/test_mips64r6_clz.c       |   9 +-
 .../mips64r6/crc => mips64}/test_mips64r6_crc32b.c |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cb.c         |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cd.c         |  12 +-
 .../crc => mips64}/test_mips64r6_crc32ch.c         |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cw.c         |  12 +-
 .../mips64r6/crc => mips64}/test_mips64r6_crc32d.c |  12 +-
 .../mips64r6/crc => mips64}/test_mips64r6_crc32h.c |  12 +-
 .../mips64r6/crc => mips64}/test_mips64r6_crc32w.c |  12 +-
 .../bit-swap => mips64}/test_mips64r6_dbitswap.c   |   9 +-
 .../bit-count => mips64}/test_mips64r6_dclo.c      |   9 +-
 .../bit-count => mips64}/test_mips64r6_dclz.c      |   9 +-
 .../int-multiply => mips64}/test_mips64r6_dmuh.c   |   9 +-
 .../int-multiply => mips64}/test_mips64r6_dmuhu.c  |   9 +-
 .../int-multiply => mips64}/test_mips64r6_dmul.c   |   9 +-
 .../int-multiply => mips64}/test_mips64r6_dmulu.c  |   9 +-
 .../shift => mips64}/test_mips64r6_dsllv.c         |   9 +-
 .../shift => mips64}/test_mips64r6_dsrav.c         |   9 +-
 .../shift => mips64}/test_mips64r6_dsrlv.c         |   9 +-
 .../int-multiply => mips64}/test_mips64r6_muh.c    |   9 +-
 .../int-multiply => mips64}/test_mips64r6_muhu.c   |   9 +-
 .../int-multiply => mips64}/test_mips64r6_mul.c    |   9 +-
 .../int-multiply => mips64}/test_mips64r6_mulu.c   |   9 +-
 tests/tcg/mips64/test_mips64r6_nor.c               | 118 +++
 tests/tcg/mips64/test_mips64r6_or.c                | 118 +++
 .../mips64r6/shift => mips64}/test_mips64r6_sllv.c |   9 +-
 tests/tcg/mips64/test_mips64r6_srav.c              | 118 +++
 .../mips64r6/shift => mips64}/test_mips64r6_srlv.c |   9 +-
 tests/tcg/mips64/test_mips64r6_xor.c               | 118 +++
 tests/tcg/mips64el/meson.build                     |  12 +-
 tests/tcg/mipsel/float_convd.ref                   | 988 +++++++++++++++++++++
 tests/tcg/mipsel/float_convs.ref                   | 748 ++++++++++++++++
 tests/tcg/mipsel/float_madds.ref                   | 768 ++++++++++++++++
 tests/tcg/mipsel/meson.build                       | 217 +++++
 .../ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_addsc.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_addwc.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extp.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extpv.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c    |   2 +-
 .../ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_insv.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_lbux.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_lhx.c      |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_lwx.c      |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_madd.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_maddu.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_main.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mflo.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_modsub.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_msub.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_msubu.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mthi.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c |   0
 .../dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c    |   0
 .../dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_mult.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_multu.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c  |   0
 .../dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c    |   0
 .../dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c   |   0
 .../dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c    |   0
 .../dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c |   0
 .../dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c |   0
 .../dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c    |   0
 .../dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shilo.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shilov.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_append.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_balign.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c   |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c   |   0
 .../dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c    |   0
 .../dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_prepend.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c    |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c  |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c    |   0
 tests/tcg/multiarch/meson.build                    |   1 +
 228 files changed, 3938 insertions(+), 5750 deletions(-)
 delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
 delete mode 100644 tests/tcg/mips/user/ase/msa/README
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/README
 rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_and.c
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_nor.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_or.c
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_srav.c
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_xor.c
 create mode 100644 tests/tcg/mipsel/float_convd.ref
 create mode 100644 tests/tcg/mipsel/float_convs.ref
 create mode 100644 tests/tcg/mipsel/float_madds.ref
 create mode 100644 tests/tcg/mipsel/meson.build
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c (97%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c (100%)

