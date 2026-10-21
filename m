Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4781606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hvtmm7g+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e2GEuE6N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJao6-0004Lx-M4; Wed, 21 Oct 2026 14:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao3-0004L6-9f
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao0-00081t-WC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpK0j791071
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+bPheUFkVV1FH1YkesIgXk
 VLIHzTD1hHlTyTaBKi+14=; b=hvtmm7g+9CFjiGp/0z4nurfeyMOUn2+IqqyFHj
 b6IkimOyGDjX33suX8NXBnbvFsvoaxMqoyZS3MRO7+PYjaQOjJzxLFzX/QJ0694l
 KA/lMbP01h91JqUm78O8AZSGJ0xKdQKdVZ+XVkMEEP6TnDKro6TaRqXHaFDdjMEf
 /mdCbqcJW26kjS3FxU8+kTJ/p9zfA/w8PtxFn+Tz61BpX7msiot3UhDZRlLsV2lN
 BfzVJ7tVtuOf9vEQq1+Np81OTh+i0XuiGo/Nq/UKxueCsPiFGO1Xzhkvb00QRqHr
 2hvK1y1KdaWy7Rv7cFdnJYZnDsrAcYr3zTzqYw9V4seaXizg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0myj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac76132001so836550a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606370; x=1793211170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+bPheUFkVV1FH1YkesIgXkVLIHzTD1hHlTyTaBKi+14=;
 b=e2GEuE6NFSBZJ6RNqntTz7sXg866JVMyu1+VLqnDlalm2i04nm/a51KNgLewvbukLB
 3TaJ2rTZWJn7UQp/rUMMfxhZERNFHKfmoCU/pYNNlY53SehSVFw6mIF55l5Nbx/lSAEU
 /CtfC6qyxl7gYKIVsgxtJn/Wr53skGQMr+G9e6XGH79saQS+wJV9j7wkPqFdhK2h1k+8
 pKpEUPvuk4NIbGY5ffsTuVqggUCFt1WXDJ0plOuOgl4CTHtmSZQD/4IuGRW1pu0/h/ea
 Fpvy7yMBCSJhNfrccO+Y/7W65esGG4QxQYCealrkXcV1P6kHTP/wkor/snNk2Xiz5ppq
 cE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606370; x=1793211170;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+bPheUFkVV1FH1YkesIgXkVLIHzTD1hHlTyTaBKi+14=;
 b=l7WCHzU2Ins2eD8Ffd+vc5trdFcprZ0hCuSvWb+L76zZ5vZmvZ9t+MKiyRR1e94UX6
 8rKhjK0cpGxu1wXAkUOrbvZbUjlMiCXng2eIvVS8E+FpcLtwrRFk5GBxbkG8deeINf/p
 IPKFHWPNP0+lAAtDH+4lokKjpm8GxGsYsE1j+buK1xQEbT0SGYAzthQzyOZTJhiipgq6
 iQSwSnIaCwCN4dkaIuB9y6y1w/HjHqSwq4L6zrJeJXEJP40SuU7vRyumcb5kr92PYJ++
 4G61DNuWB+Fqkk2fl9iSGZPNFvaWVyzZ6nUGBKv3cM/cwKMSOiz15FvwSQiGNAgvLk+D
 YyGA==
X-Gm-Message-State: AFq9FYJGtBRyC6ZeM158PdFgi2H+Xhcuq7qCwZLs/pkKMbkf7NDyvKkG
 YUfQ1V8oz1vgK1zSy+aQ4HwhMA4Q9IRk2ocIfa1GPFlD2iHYSzV4JIQ/B8qHeJBGKUivKP9rP6o
 W8oli+pSu0UwzSGBh8y/ngxwljrO4Z7CKFHp431QSWIIAh1KxvYZ8DROq1lkQw5LlCA==
X-Gm-Gg: AYBFou2IRMfOxXkZVxuu9vltZaCWkPMcnHmTI04lBiTkxWIwDjO7qDOoM4YZ7B5v+Bi
 Jd4axKTR4JFWgBNqIpO/ccH0PoCyvGWSMSI5S3BM8zIIW0aehN4VrhBupNSpnC5NCgYtxy4ecF4
 iUrg5Xxbz+ZX9HvyFSk4Wf48Q579JbsUI2gIETT+71CyoCw35y2rhX8owkNNNwlriYiSmfvJdty
 biF2dgi5RLjEGnXJUKgl6kzNXVrUQmqTJIlGKKdXZoZGV6bwc74RrAEIGZl1Yj/Av3stIDbz6QK
 pcXwNyc+vgWbfxpqvnHZHBz9Rx9ieho33wS6ef2ZG6hUuAn42UqAc1xzNGdqG/QVPy5QS4lwFs/
 I2Ck8k1F45rkxo2RrlF9M8o1DYmLbRDyCmebWDBer5hE2yRFS1tMGmPdTzHC9Kp0=
X-Received: by 2002:a17:90b:4c52:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3ad86ef4b3amr2005566a91.43.1792606369594; 
 Wed, 21 Oct 2026 11:12:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4c52:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3ad86ef4b3amr2005552a91.43.1792606369080; 
 Wed, 21 Oct 2026 11:12:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 00/21] multi-target: remove dump functions duplication
Date: Wed, 21 Oct 2026 11:12:23 -0700
Message-ID: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad900a2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OxOWoVgSNaT7bRl7YuUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: F5i1mjO9L5qDxe0kFBjj9pXJXqqtXTYo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX0mfKRPROksbC
 zJPIawH/J38n8W78MMtj27FKPDrXc8JV8Wv04iNIEqmTDap2CglF72MdJfDSOuNLTBvodE+bKBp
 aaq7trABvr7Rqcch9iwhNud+pn+Wq+g=
X-Proofpoint-GUID: F5i1mjO9L5qDxe0kFBjj9pXJXqqtXTYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6XIrTd2D/sYR
 oHLL/5HWcHVkvV66q0Ea0WcXTDcgw+XReZOhVrayNvb87jwvSIoGYjF1cdjtKfRhdC/g+QpZWP2
 mfuOmClf95mHxJxOq3zsUYmOT2LMC0rcqlNEkPFZsvRqYjKy0BC0HrfFeBiqswB+kP5MSUHz7RU
 63MAtwwez1GrUqCpyS6ygw6zqVvLeuocX7mXzN2iciy1xyxNEsrxjtpyr2kZZZ+Wl4jqQHRpDcK
 w4yevuS9mbGMu/flNisZZlzJ8PWRozpYBVBL1oLWiTXDcCvghHBhUokip7nVLkZlzQL8g2BwIJq
 Pc4LhIQMbkGmRYGYkBl0GKsrZAQQCLo6+9Kaao50JQyUv5jO1ocR4iCZ0G13X11+Fk2fv+cCM4W
 ll4LFisPmHiVArkCOuD71fPp7Uc2yOsKoB1MMDb1+b4ptTFMGJK72XhtJd11oi2l6UAX6oJKJZN
 HmCfMzJ/H1nv8UqgV7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
target. For this, we define a new sysemu operations for a given cpu, and
implement it per target.

Existing implementations were using first_cpu, which is what we continue to do.
When we'll work on heterogeneous later, we can revisit this to either forbid a
dump, or perform a dump for each target active. Meanwhile, add a check if we run
heterogeneous emulation, and refuse to dump if that's the case.

v5
--

- remove redundant typedefs for ArchDumpInfo and GuestPhysBlockList
- make new sysemu op infallible (get_dump_info has no return, and get_note_size
  return size_t). Keep fallible global wrappers.

v4
--

- define global wrapper for cpu_get_dump_info and cpu_get_note_size, both using
  the sysemu op we introduced.

v3
--

- riscv_get_dump_info: add const to riscv cpu
- use forward decl for ArchDumpInfo instead of including system/dump.h
- use forward decl for GuestPhysBlockList instead of including system/memory_mapping.h
- update comment for get_note_size sysemu ops
- add target_heterogeneous to target_info: returns false for now
- edit commit description for dump_init changes about why we can have first_cpu null
- add target_heterogeneous check in dump_init
- rebased on master (previous "based on" is not needed anymore)

v2
--

- Add new ops to existing SysEmuOps instead of a new DumpOps.

Pierrick Bouvier (21):
  target-info: add target_heterogeneous
  dump/dump: do not dump machine if doing heterogeneous emulation
  include/qemu/typedefs: add ArchDumpInfo
  include/qemu/typedefs: add GuestPhysBlockList
  hw/core/sysemu-cpu-ops: add get_dump_info
  target/arm: implement get_dump_info sysemu op
  target/i386: implement get_dump_info sysemu op
  target/ppc/cpu: constify cpu parameter for
    ppc_interrupts_little_endian
  target/ppc: implement get_dump_info sysemu op
  target/riscv: implement get_dump_info sysemu op
  target/s390x: implement get_dump_info sysemu op
  target/loongarch: implement get_dump_info sysemu op
  dump: reimplement cpu_get_dump_info using get_dump_info sysemu op
  hw/core/sysemu-cpu-ops: add get_note_size
  target/arm: implement get_note_size sysemu op
  target/i386: implement get_note_size sysemu op
  target/ppc: implement get_note_size sysemu op
  target/riscv: implement get_note_size sysemu op
  target/s390x: implement get_note_size sysemu op
  target/loongarch: implement get_note_size sysemu op
  dump: reimplement cpu_get_note_size using get_note_size sysemu op

 dump/dump.c                      | 14 ++++++++++----
 hw/core/cpu-system.c             | 19 +++++++++++++++++++
 include/hw/core/cpu.h            | 24 ++++++++++++++++++++++++
 include/hw/core/sysemu-cpu-ops.h | 12 ++++++++++++
 include/qemu/target-info.h       |  8 ++++++++
 include/qemu/typedefs.h          |  2 ++
 include/system/dump-arch.h       |  9 ++-------
 include/system/memory_mapping.h  |  4 ++--
 stubs/dump.c                     | 27 ---------------------------
 stubs/meson.build                |  1 -
 target-info.c                    |  6 ++++++
 target/arm/arch_dump.c           | 22 +++++++---------------
 target/arm/cpu.c                 |  2 ++
 target/arm/internals.h           |  4 ++++
 target/i386/arch_dump.c          | 14 +++++++-------
 target/i386/cpu-internal.h       |  5 +++++
 target/i386/cpu.c                |  2 ++
 target/loongarch/arch_dump.c     |  9 ++++-----
 target/loongarch/cpu.c           |  2 ++
 target/loongarch/internals.h     |  5 +++++
 target/ppc/arch_dump.c           | 18 ++++++------------
 target/ppc/cpu.h                 |  6 +++---
 target/ppc/cpu_init.c            |  2 ++
 target/ppc/internal.h            |  7 +++++++
 target/riscv/arch_dump.c         | 20 +++++++-------------
 target/riscv/cpu.c               |  2 ++
 target/riscv/internals.h         |  4 ++++
 target/s390x/arch_dump.c         |  8 ++++----
 target/s390x/cpu-system.c        |  2 ++
 target/s390x/s390x-internal.h    |  5 +++++
 30 files changed, 165 insertions(+), 100 deletions(-)
 delete mode 100644 stubs/dump.c

-- 
2.47.3


