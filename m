Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF2CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkZI-0003mv-9N; Mon, 05 Oct 2026 11:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkZA-0003e6-AR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:25:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkZ4-0000pz-SC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:25:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP4Gi2214845
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 15:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OTTAhzf0vtGFRjwyF/plDhJ66o3EVaYBKJH/zYoSKfs=; b=FgcXETRJanBgJaki
 F239DOlnlFo3DEepp0LWqMmpSo+v971wndLnZuJ9DollBIqICGOce4vjfFi4A4++
 Azc36LTR0vgXK+/3x5psLtSjFz4O5Zj5YJp0HWktHXCyjxUL1ZH8SelyX72VscKP
 AiBDrG+gnGaw7uUUs1ag3VXSiWAlSshzNELZbGWSzjjvCMGfQtAbFKveLV3wz7dr
 pgBZ6yt++4CUVzur42Eu5FWpPISpt1T7u9em4Ys6YDZoUQ5a0OdMzK97FdBtGCrn
 VFhPy9/qYeAD7q00mRawmi+s7W5gUeBZRWg/p3cXTBUCdHjkT7qv3JDW9XDaYsTS
 a/CVJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgytu7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 15:25:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so4453682eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791213915; x=1791818715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OTTAhzf0vtGFRjwyF/plDhJ66o3EVaYBKJH/zYoSKfs=;
 b=eSSVyFrhM5d4wg02tXdn+mMBe7qMvkKWzO1laUBAICQenvy9bG3zHJY3ue9Ygo1iCm
 v2P/8YmiU63GYfTqp4dkx6p3NHZGAqHY6XMG79NLLoIKqyDguEgDlxvvTAOxJXPDVatR
 W2JbMhjc/tlSQpC5d4D8OKdhDHt9SdZ4IeXtE4zW/QmD5ivMSRfT7ZMXMLvQYFblhaK7
 oD8jx1IeSMj/jjUO1AtIoGlxjh8zg7bq+wVy/6j3PhIDJNxAcmOD5BXZpxNzRlmJwAF8
 K8YKpp4kOBj4N3TiHsU7vUR1IR1go2RHgF8j6NubDw11zFoqYVU7RyQZd+3VPj572KGw
 TfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213915; x=1791818715;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OTTAhzf0vtGFRjwyF/plDhJ66o3EVaYBKJH/zYoSKfs=;
 b=T47BBopxwBjzixAYaB1CzXX+gZaV0myoOjzSL4ogsEdJwkCQ3bUh3V2OBgPktg1WjI
 MYCS1vkqVxkmKMpk1/41guYunhzcWz/iLzpI7qeVYyEv17pNeWebXIgVyGB5pmjW9Xez
 8V9ahQFnKVjbAsXhvdWDPciqEgYo2poo1rUuYE7F7JEcCn4/flzaPZZyDlQxspEEuefS
 ejcQrmNjEuXY2uFDqN1hAqSJEYw8uhcqdzUt1D5cNNefbVH3PJdyHOi9aW/oVDDBlfrs
 Q2WYM9P3lm9X5dJYBfRv8C0+MKbKBbF71rEUgRzWtUO2X+RLPJ2W6ZZdHbJ5K+clGqbq
 x1FA==
X-Gm-Message-State: AFuF++ksfBoRbHrAfAli09EpDLVyz1cuh2CJwNdzXwR0g+P8wf+snLUA
 E4Wnp1biQxXsF2iEXf/Q2DoRxrQW8gaBECCd29AeiAun9s1GZAPsUWQlpLojK9Z7/hlYgvGtBTe
 syp+Y7okDIgkQiQsnx5da3mbosoW+uMkChhfF+UBiWgFVI26YJC8rjtT3Adcn3ler/w==
X-Gm-Gg: AYBFou0eYKHFfjngiEMTP6UnLS2PyRp70Bhm0kFcanIHIHQIZNPPDSVDX+GufiuyVJc
 mlrhmN/PYlB9b8bBKNhlp1muspYgHAKh1STbpHEvl5cj22EYsBOyHmn+OwHU3a3IqoNSSwWmJg0
 trFYF/d2EQb0eoIhS2FhB0MB03El3ZzoBw/F8sSc4/pGSnH6DD1/sftE0tJ+YVpqU9Fg1z1Nj/j
 683SsSa4ToMd2ESid6axy+75Gqu67lo+txu8BsuW/kBlXGmFhuItKSVu00CnJyYiq4MJGMlJiDB
 mqwyPHKB8jWZxbZgYqSMC8XswS/saQWfZcTHmT+in/i/8dthJow4v90q3w4qZC9RhBmT4cJ4iA+
 XAHPirw2TgtIfXCkJ6nohjPjC2U3U38lsA2b77QxY0zTK/3gDfz94mHpxA3IZ6J50ELY40g==
X-Received: by 2002:a05:7300:8284:b0:328:3cce:4b3b with SMTP id
 5a478bee46e88-34f14f18c81mr12537757eec.4.1791213914351; 
 Mon, 05 Oct 2026 08:25:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8284:b0:328:3cce:4b3b with SMTP id
 5a478bee46e88-34f14f18c81mr12537720eec.4.1791213913482; 
 Mon, 05 Oct 2026 08:25:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351272a9360sm14982488eec.23.2026.10.05.08.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:25:12 -0700 (PDT)
Message-ID: <832c7b40-fba7-400b-b497-0fa40c4a3454@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:25:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/24] tcg/tests: integrate rest of mips tests
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rUG2Ck008lyQHTJZSkD47vkIQPBh_fAU
X-Proofpoint-ORIG-GUID: rUG2Ck008lyQHTJZSkD47vkIQPBh_fAU
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3c15b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=YYKCC2RymheuDCCGJwEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX6qOfhFEaU5Ls
 kHJNP+botKiIThENLsCPDIaHyi6iqoC4MA4PqjjLE2O2ny80Qv3/ELAEPOGZ8+2XO72ZtbxK/70
 dUobqixyhRiy3cBlrHino/N2FkqHtqeEi1hEUjQ86V88S5Yt/zF08xJNj+4zMNQgzwI6lhlMFKH
 dHXyFi0BHuKo5REqf6u5bVOMAYxKqjL3iBvq3wLtJLG5Y7b631JvaLwHLAhB5/66ESSDx8MVSBq
 AgyirJsELG6iLdDnIPZXLef/u+Hv0moUm2fNlbDhGGS5cDQXcUZ+C69vVSJyCmCoIpGJHIpuyA6
 dEq27QyNNSuPHWHqkm49F1shLO9D+bRvB6PUU27S3GIN5fDhT9ovm+FGifWrii4djOyUpmxhORs
 7hfRCFRUArd70Ttks079YI1rNnktOEsgIV//S/lQYoas6+AR67HPANkNj2kMNY8CK/PTZtGz8v7
 ZLC4tIRihaUI0jshWqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfXx38AjlapfXLD
 S5X0hczak1mwCn+SDskZedyBhlAEzHGIoShZYr/BsvTHmaK7jptPm91MLLdS2K1NysgEAjMmagJ
 khkX1tpvKbc3pxPpE2xxBbmmScIJ/i0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060
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

On 9/29/2026 2:24 PM, Pierrick Bouvier wrote:
> This series integrates tests from tests/tcg/mips/user/, and also adds
> multiarch tests for mipsel target.
> 
> v3
> --
> - add the remaining msa tests
>   - add toolchain for mips32r5el
> This now covers all the tests that were left.
> 
> v2
> --
> - add all tests from tests/tcg/mips/user/isa
> - move octeon test to mips64 folder
> - add mips64r6 tests (and fix them)
> - add README for r5900 tests that we can't run
> 
> v1
> --
> - add tests from tests/tcg/mips/user/ase/dsp
> 
> Pierrick Bouvier (24):
>   tests/tcg/mipsel: move dsp sources
>   tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
>   tests/tcg/mipsel: add dsp tests
>   tests/tcg/mipsel: add float reference files
>   tests/tcg/mipsel: add multiarch tests
>   tests/tcg/mips64: move octeon test here
>   tests/tcg/mips/user/isa/r5900: add README
>   tests/tcg/mips64*/meson.build: remove unused cc_feat
>   tests/tcg/mips64: move mips64r6 sources
>   tests/tcg/mips64/test_mips64r6: fix include path
>   tests/docker/dockerfiles/debian-all-test: add mips64r6 toolchains
>   tests/tcg/mips/include/wrappers_mips64r6.h: add missing wrappers for
>     and, nor, or, xor insn
>   tests/tcg/mips/include/wrappers_mips64r6.h: use proper types for
>     parameters
>   tests/tcg/mips64/test_mips64r6: fix call to check_results_64
>   tests/tcg/mips/include/test_utils_64.h: add check_binary_op_64
>   tests/tcg/mips64/mips64r6: update failing tests to use
>     check_binary_op_64
>   target/mips: Sign-extend the SRAV operand
>   tests/tcg/mips64/mips64r6: update references
>   tests/tcg/mips64: add mips64r6(el) tests
>   tests/tcg/mips: declare msa tests sources
>   tests/tcg/mips64/mips64r6: add msa tests
>   tests/docker/debian-all-test: add mips32r5 toolchain
>   tests/tcg/mipsel/mips32r5el: add msa tests
>   tests/tcg/mips/user/ase/msa: remove compilation/run scripts
> 
>  meson_options.txt                             |  16 +
>  scripts/meson-buildoptions.sh                 |   8 +
>  target/mips/tcg/translate.c                   |   1 +
>  .../dockerfiles/debian-all-test-cross.docker  |  20 +
>  tests/lcitool/refresh                         |  20 +
>  tests/tcg/meson.build                         |   1 +
>  tests/tcg/mips/include/test_utils_64.h        |  40 +
>  tests/tcg/mips/include/wrappers_mips64r6.h    |  22 +-
>  tests/tcg/mips/meson.build                    | 277 +++++
>  tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>  tests/tcg/mips/user/ase/msa/README            |  20 -
>  .../user/ase/msa/test_msa_compile_32r5eb.sh   | 917 ----------------
>  .../user/ase/msa/test_msa_compile_32r5el.sh   | 917 ----------------
>  .../user/ase/msa/test_msa_compile_64r6eb.sh   | 643 ------------
>  .../user/ase/msa/test_msa_compile_64r6el.sh   | 643 ------------
>  .../mips/user/ase/msa/test_msa_run_32r5eb.sh  | 371 -------
>  .../mips/user/ase/msa/test_msa_run_32r5el.sh  | 371 -------
>  .../mips/user/ase/msa/test_msa_run_64r6eb.sh  | 371 -------
>  .../mips/user/ase/msa/test_msa_run_64r6el.sh  | 371 -------
>  tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>  .../isa/mips64r6/logic/test_mips64r6_and.c    | 153 ---
>  .../isa/mips64r6/logic/test_mips64r6_nor.c    | 153 ---
>  .../isa/mips64r6/logic/test_mips64r6_or.c     | 153 ---
>  .../isa/mips64r6/logic/test_mips64r6_xor.c    | 153 ---
>  .../isa/mips64r6/shift/test_mips64r6_srav.c   | 153 ---
>  tests/tcg/mips/user/isa/r5900/README          |   6 +
>  tests/tcg/mips64/meson.build                  |  69 +-
>  .../user/isa/octeon => mips64}/octeon-insns.c |   0
>  tests/tcg/mips64/test_mips64r6_and.c          | 118 +++
>  .../test_mips64r6_bitswap.c                   |   9 +-
>  .../bit-count => mips64}/test_mips64r6_clo.c  |   9 +-
>  .../bit-count => mips64}/test_mips64r6_clz.c  |   9 +-
>  .../crc => mips64}/test_mips64r6_crc32b.c     |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32cb.c    |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32cd.c    |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32ch.c    |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32cw.c    |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32d.c     |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32h.c     |  12 +-
>  .../crc => mips64}/test_mips64r6_crc32w.c     |  12 +-
>  .../test_mips64r6_dbitswap.c                  |   9 +-
>  .../bit-count => mips64}/test_mips64r6_dclo.c |   9 +-
>  .../bit-count => mips64}/test_mips64r6_dclz.c |   9 +-
>  .../test_mips64r6_dmuh.c                      |   9 +-
>  .../test_mips64r6_dmuhu.c                     |   9 +-
>  .../test_mips64r6_dmul.c                      |   9 +-
>  .../test_mips64r6_dmulu.c                     |   9 +-
>  .../shift => mips64}/test_mips64r6_dsllv.c    |   9 +-
>  .../shift => mips64}/test_mips64r6_dsrav.c    |   9 +-
>  .../shift => mips64}/test_mips64r6_dsrlv.c    |   9 +-
>  .../test_mips64r6_muh.c                       |   9 +-
>  .../test_mips64r6_muhu.c                      |   9 +-
>  .../test_mips64r6_mul.c                       |   9 +-
>  .../test_mips64r6_mulu.c                      |   9 +-
>  tests/tcg/mips64/test_mips64r6_nor.c          | 118 +++
>  tests/tcg/mips64/test_mips64r6_or.c           | 118 +++
>  .../shift => mips64}/test_mips64r6_sllv.c     |   9 +-
>  tests/tcg/mips64/test_mips64r6_srav.c         | 118 +++
>  .../shift => mips64}/test_mips64r6_srlv.c     |   9 +-
>  tests/tcg/mips64/test_mips64r6_xor.c          | 118 +++
>  tests/tcg/mips64el/meson.build                |  12 +-
>  tests/tcg/mipsel/float_convd.ref              | 988 ++++++++++++++++++
>  tests/tcg/mipsel/float_convs.ref              | 748 +++++++++++++
>  tests/tcg/mipsel/float_madds.ref              | 768 ++++++++++++++
>  tests/tcg/mipsel/meson.build                  | 217 ++++
>  .../dsp => mipsel}/test_dsp_r1_absq_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_addq_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_addq_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_addsc.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_addu_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_addu_s_qb.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_addwc.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_bitrev.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_bposge32.c |   0
>  .../dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c    |   0
>  .../dsp => mipsel}/test_dsp_r1_cmp_le_ph.c    |   0
>  .../dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c    |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extp.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extpdp.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extpdpv.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extpv.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c |   0
>  .../dsp => mipsel}/test_dsp_r1_extr_rs_w.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extr_w.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_extrv_r_w.c    |   0
>  .../dsp => mipsel}/test_dsp_r1_extrv_rs_w.c   |   2 +-
>  .../dsp => mipsel}/test_dsp_r1_extrv_s_h.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_extrv_w.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_insv.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_lbux.c     |   0
>  .../user/ase/dsp => mipsel}/test_dsp_r1_lhx.c |   0
>  .../user/ase/dsp => mipsel}/test_dsp_r1_lwx.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_madd.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_maddu.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_main.c     |   0
>  .../dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c |   0
>  .../dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mfhi.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mflo.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_modsub.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_msub.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_msubu.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mthi.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mthlip.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mtlo.c     |   0
>  .../test_dsp_r1_muleq_s_w_phl.c               |   0
>  .../test_dsp_r1_muleq_s_w_phr.c               |   0
>  .../test_dsp_r1_muleu_s_ph_qbl.c              |   0
>  .../test_dsp_r1_muleu_s_ph_qbr.c              |   0
>  .../dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_mult.c     |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_multu.c    |   0
>  .../dsp => mipsel}/test_dsp_r1_packrl_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_pick_ph.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_pick_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_preceq_w_phl.c |   0
>  .../dsp => mipsel}/test_dsp_r1_preceq_w_phr.c |   0
>  .../test_dsp_r1_precequ_ph_qbl.c              |   0
>  .../test_dsp_r1_precequ_ph_qbla.c             |   0
>  .../test_dsp_r1_precequ_ph_qbr.c              |   0
>  .../test_dsp_r1_precequ_ph_qbra.c             |   0
>  .../test_dsp_r1_preceu_ph_qbl.c               |   0
>  .../test_dsp_r1_preceu_ph_qbla.c              |   0
>  .../test_dsp_r1_preceu_ph_qbr.c               |   0
>  .../test_dsp_r1_preceu_ph_qbra.c              |   0
>  .../dsp => mipsel}/test_dsp_r1_precrq_ph_w.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c |   0
>  .../test_dsp_r1_precrq_rs_ph_w.c              |   0
>  .../test_dsp_r1_precrqu_s_qb_ph.c             |   0
>  .../dsp => mipsel}/test_dsp_r1_raddu_w_qb.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_rddsp.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_repl_ph.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_repl_qb.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_replv_ph.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_replv_qb.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shilo.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shilov.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shll_ph.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shll_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_shll_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r1_shllv_s_ph.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_shllv_s_w.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shra_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_shra_r_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r1_shrav_r_ph.c   |   0
>  .../dsp => mipsel}/test_dsp_r1_shrav_r_w.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_subq_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_subq_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_subu_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r1_subu_s_qb.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r1_wrdsp.c    |   0
>  .../dsp => mipsel}/test_dsp_r2_absq_s_qb.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r2_addqh_r_ph.c   |   0
>  .../dsp => mipsel}/test_dsp_r2_addqh_r_w.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_addqh_w.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_addu_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r2_addu_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r2_adduh_r_qb.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_append.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_balign.c   |   0
>  .../dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c |   0
>  .../test_dsp_r2_dpaqx_sa_w_ph.c               |   0
>  .../dsp => mipsel}/test_dsp_r2_dpax_w_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c |   0
>  .../test_dsp_r2_dpsqx_sa_w_ph.c               |   0
>  .../dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_mul_ph.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r2_mulq_rs_w.c    |   0
>  .../dsp => mipsel}/test_dsp_r2_mulq_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c |   0
>  .../dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c   |   0
>  .../test_dsp_r2_mulsaq_s_w_ph.c               |   0
>  .../dsp => mipsel}/test_dsp_r2_precr_qb_ph.c  |   0
>  .../test_dsp_r2_precr_sra_ph_w.c              |   0
>  .../test_dsp_r2_precr_sra_r_ph_w.c            |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_prepend.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_shra_qb.c  |   0
>  .../dsp => mipsel}/test_dsp_r2_shra_r_qb.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r2_shrav_r_qb.c   |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c |   0
>  .../dsp => mipsel}/test_dsp_r2_subqh_r_ph.c   |   0
>  .../dsp => mipsel}/test_dsp_r2_subqh_r_w.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_subqh_w.c  |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_subu_ph.c  |   0
>  .../dsp => mipsel}/test_dsp_r2_subu_s_ph.c    |   0
>  .../ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c |   0
>  .../dsp => mipsel}/test_dsp_r2_subuh_r_qb.c   |   0
>  225 files changed, 3935 insertions(+), 5750 deletions(-)
>  delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>  delete mode 100644 tests/tcg/mips/user/ase/msa/README
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
>  delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
>  create mode 100644 tests/tcg/mips/user/isa/r5900/README
>  rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)
>  create mode 100644 tests/tcg/mips64/test_mips64r6_and.c
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (93%)
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (94%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (95%)
>  rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (95%)
>  create mode 100644 tests/tcg/mips64/test_mips64r6_nor.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_or.c
>  rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (95%)
>  create mode 100644 tests/tcg/mips64/test_mips64r6_srav.c
>  rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (95%)
>  create mode 100644 tests/tcg/mips64/test_mips64r6_xor.c
>  create mode 100644 tests/tcg/mipsel/float_convd.ref
>  create mode 100644 tests/tcg/mipsel/float_convs.ref
>  create mode 100644 tests/tcg/mipsel/float_madds.ref
>  create mode 100644 tests/tcg/mipsel/meson.build
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c (97%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c (100%)
>  rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c (100%)
> 

This was merged into master (2a0ac9c8ac2d303ca515dc819043409aef18cab5).

Regards,
Pierrick

