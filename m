Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB96606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nBuYcFki;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f0sUwWTY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTDd-00077m-8o; Wed, 04 Nov 2026 00:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTDR-0006jU-MY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:07:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTDP-0002Mu-HM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:07:17 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A442EC83300468
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ykGphCsnyV+rZDtLpbPxk2LlmuCCQrZHZOI
 can+7ByQ=; b=nBuYcFkiq+le9YF0Vz9WjYHVWP82K827O+I9NMOAFQduv958WlY
 40nYieUHIfEpLNGXLqTl8Bl1/1fhM8IzZTRJjnt5kDqd5xy239D6RFK5MoPE2WF+
 6MZ7mq+2KsvedJo18JePA9dwGvaW6ZUi5KH4xVb2Jk85ljp+tkAvbvey94Ieatpu
 Kp6RzOT+EPSujAycntc+TAel3Bguu7Bk0V9x6AJWcXaYowYxHx0IO/69ZbcPLnEb
 63JOOFq8Tsc7o4xwxqJSBTIOg7ZzK2pWqhEYpZ0U2X9kkn22qBH92Xbv4taXtYSx
 RjAR0jr+JL+Dky+8JCROZaqEA/jIcg157vA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb087rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:07:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c58d35c0aso32251eec.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768823; x=1794373623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ykGphCsnyV+rZDtLpbPxk2LlmuCCQrZHZOIcan+7ByQ=;
 b=f0sUwWTYviXjfs0rs/Mka9FpH29zUqxQzKpxbDYmKTCZpiSr+DJ6FuAATawiWJon2+
 DxpOHlqhcH+gtE8gzLCWavCDWV8dM9vcj8xnY4R7G1ckYdhS6RNUJC2d9hy1jSrOmKyc
 tl3xVrCgxOZ3Kn5+4nqSWytOnfvv7UjlY1pjiuUknD36iPlu8oiRgZaJFOi2BZl8Lkhx
 Lcmi2+awW/3XKn3rCYs24Q1Mk6wepvbPWfKa1BDLGTqcBOHFMe29V0e2ITi+9P2Jbu8P
 FhE6otO4iPve2XEDI4cEWmOw1/+Z5KdXRdKHzwjlsMFXWeVC/othpaeRWjJzbgJECtY7
 gYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768823; x=1794373623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ykGphCsnyV+rZDtLpbPxk2LlmuCCQrZHZOIcan+7ByQ=;
 b=u6JC6mp0O+AQdVJjtvimlGWU89cK59AZ14lzzSVKffsMhYDHtLv0reDZ86Mk5kYIfG
 btptqrrTnYsqsrNgxtf0JrVnKJKaTfEmYG4osRvHiSQYEgcnwjSpezLrgd0W502viV4k
 qB2dEkH+myAYao4xXUkR8fugO87PRH3MURM2TqQkyu57lkJgD7qn2VhtbVb+N8Xe51MB
 6oVdBHEv81UWNIcBLej/01oXYxsG2ri0qAtN1mzXB/JAAUNH11Og3MJvf5v6J/Na603O
 aINIS+6NKBsq/3mc4gPqDBACijzlHlSPDSSzft6lneB1sVOsPms7EoDM2bGfvr4I3zSA
 rMzA==
X-Gm-Message-State: APuU4Z8TMRfPkaGpeRbRLoXejPdLTSi5nuO5WHnPGgqBlJUtSr0JeQGm
 6ceCG7bZyWb2iudRVBhOyDcG4N0FiZcOjYEEiK0pVl46HMPAaqxHqzAPX7+V83L4+GhHvIhGd6E
 Z68uVMaAkDzxbJjn0O/CVGoSndwkITQFD02VHMICZb28QmXLlK8rkCtbr7kq40uUSIw==
X-Gm-Gg: AYBFou0oMMTqs3Yrlsva3a9k7MiyeyG8MozLF4BpycuMpwlpkXVl0Y5+kRgfFeg4k1E
 DnipQmgkRoO+hxnmPRmikQYpMhcbQb3345xjva1/IrH1mmawfPg5Pr9h8hYLIMs9QhtMiLhxZsl
 iK3I5poandGihFhaCpNY+P/C6vg6hjsbBRH4wftsdRH765G03CAeqBfyhY+KTDJJkFfu8gKzzGf
 xu+DxJA/bXZs/jrDJvXSVjZU4B3ljT09L16G45dxWZMNn6tMAXEedJU2yZahuR5CdaP64axpuA8
 JRAj9+AIXL7ISzVNxkf1gRG0HXwE0ulyMk87zBWmxhepvcAxbwVQ7TuSbvUKYUpAzIpW0YPMrOW
 8eDHq4UQpaGH703L1AnSMbDNCPliZyZ5Uwgow8lXkQ0XMLgidUa+J9sg09tN/BJ1iqiZ927OC0r
 Q2JC3MoICTX7D4pk2j2s/CxPX5Ftr9WQmQyBHPuDIi79HOW6qO0V57oGIBSWlxPZzw/F6W4C/dm
 /oztAI=
X-Received: by 2002:a05:7300:7a9f:b0:36a:143d:98db with SMTP id
 5a478bee46e88-36a4234fc7fmr33145188eec.1.1793768822825; 
 Tue, 03 Nov 2026 21:07:02 -0800 (PST)
X-Received: by 2002:a05:7300:7a9f:b0:36a:143d:98db with SMTP id
 5a478bee46e88-36a4234fc7fmr33145121eec.1.1793768822022; 
 Tue, 03 Nov 2026 21:07:02 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d3580sm3639698eec.10.2026.11.03.21.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:07:01 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Charles Perry <charles.perry@microchip.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, marcandre.lureau@redhat.com,
 berrange@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 0/2] hw/riscv: add RPMI support for server reference
 platform
Date: Wed,  4 Nov 2026 10:36:48 +0530
Message-ID: <20261104050650.776580-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX9G/0HUatsM2W
 1e9+xeKoKs6GfAOf8iRmiohN80CDulhyi1KRV8+tXVPWsvQQAscxOkmduFFSsvXQmYyr4ySjlrf
 GkMlBx5wrqmcwPBdcgu0s2VTDt5JwxU=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeabd77 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Ssm4dOjzjMnu0MGFRxsA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: zoPA_rIN5z0-I_O0AWgXytMsaEUU2moq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX2/xcpojv39Aj
 P6oZU697QTj7eIuH22lTtqnqJWeScC9B+pSV1fx8MTOmHctsu7qiTZe3FaCzDUB0EX/L/W1gYmy
 8g2QamNP+WptgTh/Di7Bqypalbrd4/6g+0uzamRqiD3+H0XtwMTCRsGjayYohiOYwmF1mIeEBac
 OXY6CRY1roaWL3rIkyy/BsiTR5DMDvOD8ZYimz5axBoiggRTiVYIgIimgRBrJcJpj2r9WkV/1gf
 4zjFJumkWipRIyPw+pi7cYahjnQ2GSfwKJqsNGGd9frlKzSrdPEEOzPOP9fZX8CWv78sHWJm+mO
 uMautzTuD3j3vltuKqrAES7niPWROFa2ZFmKuzfCjVBYJ57npt+9GLegKaWvN22BLHqBEwLo9nT
 AjvuEEkPuA0u/jluDuXkA4tqRFd625GCV747+sEcTQ3cUmkuxSiyBQqwbJ+Ho+YOwDKNJsNYoYm
 9DofoWpo7BKhDzuS/6A==
X-Proofpoint-ORIG-GUID: zoPA_rIN5z0-I_O0AWgXytMsaEUU2moq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add RPMI transport and service-group support to the RISC-V Server Platform
Reference Board. The series applies on top of the initial RPMI virt support
series and wires the board's reset, HSM, and system-suspend operations to the
same librpmi-backed implementation used by ``virt``.

The RPMI FDT service nodes are emitted as ``/soc/<service>`` siblings of the
shared-memory mailbox. Each node keeps its ``mboxes`` phandle and
service-group ID, and the server-reference qtest checks this hierarchy as a
regression.

Dependencies:
- [PATCH v14 00/10] riscv: add initial RPMI virt support.
- The server-reference board is already present in QEMU master at
  74f7bf4c59e6b6d50dbc6e124d93440be8be4386.

Changes since v3:
- Rebase onto QEMU master and the initial RPMI v14 prerequisite.
- Keep the board integration and its queue sizes unchanged.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Use per-machine queue sizes in the shared harness: virt uses
    30 KiB queues while server-reference retains 1 KiB queues.
    Derive acknowledgement offsets and ring moduli accordingly.
  - Inherit resume-address coverage for RAM-backed PCs, MMIO and
    unmapped rejection, and RV32 width checks on mapped high RAM.

Changes since v2:
- Rebase the server-reference integration onto QEMU master and the v13 RPMI
  virt prerequisite.
- [1/2] hw/riscv: add RPMI support for server reference platform:
  - Add an explicit ``rpmi=on|off`` property, defaulting to off so the
    existing board remains migratable and retains its legacy reset/poweroff
    device-tree nodes.
  - Gate RPMI realization, reset/shutdown callbacks, and service nodes on the
    property; reject explicit enablement for KVM and no-librpmi builds.
  - Document the property, migration restriction, build requirements, and
    both device-tree layouts.
- [2/2] tests/qtest: cover server reference platform RPMI:
  - Reuse the common RPMI protocol tests and register the server-reference
    machine-specific subset.
  - Add checks for default/off and explicit-on machine policy,
    service-node sibling placement, mailbox phandles and service IDs,
    legacy syscon nodes, and migration behavior.
  - Name the RPMI-off migration test as a policy-command acceptance check;
    it does not restore a destination VM.

Testing:
- Both patches build individually with and without librpmi.
- RPMI/server-reference qtest after [2/2]: 30/30 subtests passed.
- Without librpmi, the default machine realizes and explicit RPMI
  enablement rejects with the unsupported-build error.
- Normal and TPM Linux boots with RPMI off and on: 4/4 reach login
  using the unmodified device tree.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: cover server reference platform RPMI

 docs/system/riscv/riscv-server-ref.rst |  43 ++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 149 ++++++++++-
 meson.build                            |   4 +
 tests/qtest/riscv-rpmi-test.c          | 434 +++++++++++++++++++++++++--------
 5 files changed, 531 insertions(+), 100 deletions(-)

base-commit: b4296f9b36dadd701e7b9f7163f344fbb438d490

