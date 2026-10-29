Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59941606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QsX+BFP9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCt-00016H-PT; Thu, 29 Oct 2026 13:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qE-85
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003ba-Jf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxEc1619568; Thu, 29 Oct 2026 17:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=c8DRm5rxPM+cji/5kstgpj
 x/mCP9npf0iaq2GZbXUd0=; b=QsX+BFP9UN+9hU+1LvFSTrzc1hUkaCQBwtFrIP
 SlqvQj65j/l+kYHQkuU3UoVi1lhiayvj7+EonsJoadJPifnJbgPNC20sbbuffN0+
 WBbM/db/IQDKPGSBf8L9JnKUkaNf6kPt7xrsyxcviFw34ryZzrzfvyPc/n7CWnAu
 +/ywpvlbFmuFIJCbt3ZgDAzAXyc3uB2G4+MIXauD7TWDRpFSBkSDTdGmyOOwSXAz
 2hK/MpZBccw298hLVXfjEZ5KdNbwyqO5l0Nn+5eQECRZFXSSPeK6UCQM9aVMM6/k
 44yILpEd21S769qLxiTqZUovJ1TC4p6wM1i3rjelXgPSOYTg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9wus-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEp12549232; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiDCf2549219
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:13 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 6A1D12577E; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 00/20] target/hexagon: add V85 HLX support
Date: Thu, 29 Oct 2026 10:43:53 -0700
Message-ID: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX5idicO1sr4dq
 VHj0cmYcaopAY1AJvytyi/vwdQ9EbBp+uZYxgyJDC87/Aw+gUYgl7zmvu5MQc4zjzJbnIBX4oZE
 SmZgAmUTP/kySBJMyRA+hlmKj1JdGEY=
X-Proofpoint-ORIG-GUID: Ef0TgEI2eTDTw1cdubVXaPQD0lF7qwhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2r+67hTM2HT1
 +X+eqhVKF3/UVW+AzHziFa0JnBcqdsp7u/2j3FCu0s9+hzuAt960wJ/zPp72twlpWQbk9/V5PbB
 Sh94tmZUNRWaQbrk1/ZmLEWyuEQiA//IOmpVI7H2V+7U4l/ERn9qp5JNr8SUdTIiXweFdXJL9kq
 cocZwDABn6WVQIOAgtkAGPvlwv8I331YZAi395uWQxeRXZ9/o9kXawl0+uts5VaTR1Efu/4/tuY
 TmImIRqBlhka3cpSilb5/DSpdwFs02kcN3JBXHTFQEk6TbM3vgxqTEawCd+gabwT05EEe8YEy0G
 3YgeSh4rXwVtqyBfkUrQnP7+JO/0jEdbyisd0Mo/UhjurTYWDYYbUFHv01edXXJXqpzwlxbyx7f
 BRJTN5Fk5i5PeaH42djsNVmpTvofQAef4k0sujCOAmUX1HLMKmh+4ucGv/egaaLyk19b6nJgdQJ
 +o6lqRqtsWZMx6n9JLQ==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae385ee cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=cYZQUQpYROdJcZHkDVYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ef0TgEI2eTDTw1cdubVXaPQD0lF7qwhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Marco Liebel (20):
  target/hexagon: manage HLX contexts through CCR
  target/hexagon: add HLX attributes and exception cause
  target/hexagon: add an HLX instruction trace event
  target/hexagon: generate the opcode translator table
  target/hexagon: add HLX register classes to generators
  target/hexagon: add HLX helper support
  target/hexagon: emit basic HLX vector operations inline
  target/hexagon: add HLX unsigned saturating gvec operations
  target/hexagon: add HLX compare and average gvec operations
  target/hexagon: add HLX absdiff and sign-fill gvec operations
  target/hexagon: translate packets with HLX instructions
  target/hexagon: add HLX packet slot and resource checks
  target/hexagon: decode HLX packets and add load and store
  target/hexagon: add HLX common ALU instructions
  target/hexagon: add HLX paired ALU instructions
  target/hexagon: add HLX shift, average and lookup instructions
  target/hexagon: add HLX multiply instructions
  target/hexagon: expose HLX registers through the gdbstub
  tests/tcg/hexagon: add HLX instruction tests
  tests/functional/hexagon: add HLX system-mode tests

 configs/targets/hexagon-linux-user.mak     |    2 +-
 configs/targets/hexagon-softmmu.mak        |    2 +-
 gdbstub/gdb-xml/hexagon-hlx.xml            |   51 +
 hw/hexagon/hex-subsys.c                    |   16 +
 hw/hexagon/hexagon_hlx.c                   |  113 +
 hw/hexagon/meson.build                     |    1 +
 include/hw/hexagon/hexagon.h               |    1 +
 include/hw/hexagon/hexagon_hlx.h           |   33 +
 meson.build                                |    1 +
 target/hexagon/attribs_def.h.inc           |   23 +
 target/hexagon/cpu.c                       |   34 +
 target/hexagon/cpu.h                       |   24 +
 target/hexagon/cpu_bits.h                  |    1 +
 target/hexagon/cpu_helper.c                |   36 +
 target/hexagon/cpu_helper.h                |    1 +
 target/hexagon/decode.c                    |  118 +-
 target/hexagon/gdbstub.c                   |   51 +
 target/hexagon/gen_decodetree.py           |    6 +-
 target/hexagon/gen_dectree_import.c        |    9 +-
 target/hexagon/gen_helper_funcs.py         |   86 +-
 target/hexagon/gen_helper_protos.py        |    7 +-
 target/hexagon/gen_hlx_ext.py              |   25 +
 target/hexagon/gen_idef_parser_funcs.py    |    3 +
 target/hexagon/gen_tcg_func_table.py       |   29 +
 target/hexagon/gen_tcg_funcs.py            |    7 +-
 target/hexagon/gen_trans_funcs.py          |    4 +-
 target/hexagon/genptr.c                    |   23 +-
 target/hexagon/helper.h                    |   36 +
 target/hexagon/hex_common.py               |  708 +++++-
 target/hexagon/hexswi.c                    |    1 +
 target/hexagon/hlx/decode_ext_hlx.c        |  117 +
 target/hexagon/hlx/decode_ext_hlx.h        |   14 +
 target/hexagon/hlx/hlx.h                   |   64 +
 target/hexagon/hlx_gvec_tables.c           |  286 +++
 target/hexagon/hlx_gvec_tables.h           |   25 +
 target/hexagon/hlx_helper.c                |  236 ++
 target/hexagon/imported/allext.idef        |    6 +
 target/hexagon/imported/allextenc.def      |    4 +
 target/hexagon/imported/hlx/encode_ext.def |  180 ++
 target/hexagon/imported/hlx_ext.idef       |  540 +++++
 target/hexagon/insn.h                      |    2 +
 target/hexagon/internal.h                  |    2 +
 target/hexagon/machine.c                   |   47 +-
 target/hexagon/macros.h                    |   56 +
 target/hexagon/meson.build                 |   53 +
 target/hexagon/mmvec/macros.h              |    5 +
 target/hexagon/op_helper.c                 |   13 +
 target/hexagon/opcodes.h                   |    1 +
 target/hexagon/reg_fields_def.h.inc        |    2 +
 target/hexagon/trace-events                |    6 +
 target/hexagon/trace.h                     |    2 +
 target/hexagon/translate.c                 |  128 +-
 target/hexagon/translate.h                 |   48 +
 tests/functional/hexagon/meson.build       |    2 +
 tests/functional/hexagon/test_hlx.py       |   49 +
 tests/tcg/hexagon/check_rev_gating.c       |   10 +-
 tests/tcg/hexagon/hlx_abs_cmp.c            |  570 +++++
 tests/tcg/hexagon/hlx_arith_h.c            |  197 ++
 tests/tcg/hexagon/hlx_arith_w.c            |  695 ++++++
 tests/tcg/hexagon/hlx_asm.h                | 2286 ++++++++++++++++++++
 tests/tcg/hexagon/hlx_assign_conv.c        |  354 +++
 tests/tcg/hexagon/hlx_basic.c              |  119 +
 tests/tcg/hexagon/hlx_lanes.c              |  455 ++++
 tests/tcg/hexagon/hlx_logical.c            |  275 +++
 tests/tcg/hexagon/hlx_lut_ilog2.c          |  289 +++
 tests/tcg/hexagon/hlx_mem.c                |  258 +++
 tests/tcg/hexagon/hlx_minmax_avg.c         |  801 +++++++
 tests/tcg/hexagon/hlx_mpy.c                |  375 ++++
 tests/tcg/hexagon/hlx_mpy_adv.c            |  452 ++++
 tests/tcg/hexagon/hlx_reg_writes.c         |  151 ++
 tests/tcg/hexagon/hlx_shift.c              |  545 +++++
 tests/tcg/hexagon/hlx_shift_acc.c          |  275 +++
 tests/tcg/hexagon/hlx_test.h               |  162 ++
 tests/tcg/hexagon/meson.build              |   16 +
 74 files changed, 11548 insertions(+), 77 deletions(-)
 create mode 100644 gdbstub/gdb-xml/hexagon-hlx.xml
 create mode 100644 hw/hexagon/hexagon_hlx.c
 create mode 100644 include/hw/hexagon/hexagon_hlx.h
 create mode 100755 target/hexagon/gen_hlx_ext.py
 create mode 100755 target/hexagon/gen_tcg_func_table.py
 create mode 100644 target/hexagon/hlx/decode_ext_hlx.c
 create mode 100644 target/hexagon/hlx/decode_ext_hlx.h
 create mode 100644 target/hexagon/hlx/hlx.h
 create mode 100644 target/hexagon/hlx_gvec_tables.c
 create mode 100644 target/hexagon/hlx_gvec_tables.h
 create mode 100644 target/hexagon/hlx_helper.c
 create mode 100644 target/hexagon/imported/hlx/encode_ext.def
 create mode 100644 target/hexagon/imported/hlx_ext.idef
 create mode 100644 target/hexagon/trace-events
 create mode 100644 target/hexagon/trace.h
 create mode 100755 tests/functional/hexagon/test_hlx.py
 create mode 100644 tests/tcg/hexagon/hlx_abs_cmp.c
 create mode 100644 tests/tcg/hexagon/hlx_arith_h.c
 create mode 100644 tests/tcg/hexagon/hlx_arith_w.c
 create mode 100644 tests/tcg/hexagon/hlx_asm.h
 create mode 100644 tests/tcg/hexagon/hlx_assign_conv.c
 create mode 100644 tests/tcg/hexagon/hlx_basic.c
 create mode 100644 tests/tcg/hexagon/hlx_lanes.c
 create mode 100644 tests/tcg/hexagon/hlx_logical.c
 create mode 100644 tests/tcg/hexagon/hlx_lut_ilog2.c
 create mode 100644 tests/tcg/hexagon/hlx_mem.c
 create mode 100644 tests/tcg/hexagon/hlx_minmax_avg.c
 create mode 100644 tests/tcg/hexagon/hlx_mpy.c
 create mode 100644 tests/tcg/hexagon/hlx_mpy_adv.c
 create mode 100644 tests/tcg/hexagon/hlx_reg_writes.c
 create mode 100644 tests/tcg/hexagon/hlx_shift.c
 create mode 100644 tests/tcg/hexagon/hlx_shift_acc.c
 create mode 100644 tests/tcg/hexagon/hlx_test.h

-- 
2.43.0


