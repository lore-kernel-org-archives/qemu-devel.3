Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15503606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=my1wqv0+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZzdszLOn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfXS-0000nj-Sw; Wed, 21 Oct 2026 19:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWR-00085z-FT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:15:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWO-00053y-Rj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:15:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeKNx2160548
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VZU4cKBDKOA
 kQ2QyTiStp9cg3ziJbCt5cXGlv1EAxGI=; b=my1wqv0+3656WDgz+16KXqtMwEr
 03sE/+Z2tht3xWvH6jB7eMfO9Wi3sH3GKSjTabrivKfBD3r2KCxergmbbAf8Ssgr
 UtYGS7ecoPHjy8N9/BjeZei+7rvTPilaDGEDIo+fKjXgc1MD4A2KGnHJREQj8tpV
 XA699H9CYkWnRa4GvinY+LDvRUEc7rZmlioTU3dg2mxnRfa+Cvm+N0Wx2VaU/muP
 BxqbmekRp7Wqo3dHKTqMI8F16r8+RW3l+4ntsHvPgmnxlQPMWR8mSiHFbhhfwn+k
 UiNA0KscYPbJYthHCvpP8qYXsvmH0LxR6gsdJcADpDDVO933ZIX90nUR81A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3h360-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so26204211cf.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624489; x=1793229289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZU4cKBDKOAkQ2QyTiStp9cg3ziJbCt5cXGlv1EAxGI=;
 b=ZzdszLOnAr4iot4eMq/Tc7LUZitkzqdDiwSwnaPr3nGvPbqYnbJwPkpIDZWxOvZwrU
 OkLZN16e7Bc+He/uoPyK+PyjlQNggfnK7Az/h7IlnhnGG83ZKM6hiMpwvsSIkxZwkhgX
 QqI9mn97gkKxxwt8u95/0oQ4LVcT47VzYPLO4egcyKQe4d5KTIS0YqFkQ+nM5krSCcn6
 INtcnwFhKYHPzyn8Ir4NGWr9KSxZVOjL2godPO+mlDKRVLhP4fVffSpGAjrMgLBXrTfK
 8Yu0Cb0aSI1v1SC9FLxaDMlVbnHmKqP82HC43Qfy/4+9iYCJk3AqTGwz7jSpjA14UWnY
 fVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624489; x=1793229289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VZU4cKBDKOAkQ2QyTiStp9cg3ziJbCt5cXGlv1EAxGI=;
 b=jKc52gjTRxevNCj2GafsUCQtx3CPeblfnXRe1hkRCqTa2HoFwJnThG5luu7Gq4nWBi
 1vCl+xAecHjDvlXQ5+qEUmma63AkMTUk4pcra/YAvWZu6WyIa0bVkjOECGW9EKGqv/0b
 3YpJ9vNSdJVX2j9z9Urer0wNLEn6px3JfqiOsJrn40uegD4LJLQVeC89omhzsTxFeQSf
 XOLGcSyrUfr51c23sJiPTvenTLOM0fY90T4sGI8gyfMkdv02TjaJK/wTzhzSslw46vd/
 uMtA5mlxGbIa2umApykXYn+Y0VdOmCnEc3GnqTrDoCa5OMOAW7va+EfTHW7xqoHeft2a
 M4Ew==
X-Gm-Message-State: AFq9FYKhsCR63R2/ufLElj7LfmbytbGdcMuDwwkCsricm3VR+/oeLEJx
 HTc24w7d/9aYnQWyBMItWcaPGvvUc1aIA340I8MeHmqMJFQnNvJ55McDxv2JgZ0S9oqQHv4MGGB
 uHF0jwESOVZVaaKPDFBS1dOWVO41dq02JIpKhPs14oBhRAAMscvu2141Kp/t4c5y6Ew==
X-Gm-Gg: AYBFou15ZD/KhkNyUIaqAv1W0MuRNv6MAf9cH1Z9wk+6EDiC5VK0hoezHRzwJTnxwgZ
 d3V+TvzkEqSxhT1FiNC3HHCwV852XbIpQqMcCvh/BGMIfEBW1M6ysHf/CYNWbatGO/o9UbkBcPY
 0ylYbiu9xfNhyj7q1uGrPA43nnrlrRKouB56PIloDHrxTdS+kCCKPqx35Xff8jaHmqNkNkPZYjb
 5Fnj3NdGl+u7LfxImWnbgDI5iOwUAguppIj2ijBCtfJD05qqnM8rAX4RHcZmN5rcJsKMdP7p2jL
 Yk/1rNAOf2hRh9Uow5HcRe+5XkPBY0FDyLH0n+TN88YY+qOqNYuwYpKDRvXbaVUxvqLLWqgZhGv
 9KDOLMGu9ytq/fnWQkfAagygZK3rDfHefITGKeRPL790Se0nm+nnHd+EWha8EXEWAJyQQZfHDoQ
 ==
X-Received: by 2002:a05:622a:544c:b0:535:a5fc:3b5f with SMTP id
 d75a77b69052e-5369bb2e57dmr55266421cf.75.1792624489084; 
 Wed, 21 Oct 2026 16:14:49 -0700 (PDT)
X-Received: by 2002:a05:622a:544c:b0:535:a5fc:3b5f with SMTP id
 d75a77b69052e-5369bb2e57dmr55266021cf.75.1792624488575; 
 Wed, 21 Oct 2026 16:14:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 18/18] docs/specs: document RISC-V hwtrace (e-trace) support
Date: Wed, 21 Oct 2026 20:13:45 -0300
Message-ID: <20261021231346.2452179-19-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad94769 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=tU4Byx4yQiio4BpKx7AA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: dHyBmR1DeiA_jy4jI9Rm6FkEfcKCKiG1
X-Proofpoint-GUID: dHyBmR1DeiA_jy4jI9Rm6FkEfcKCKiG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX3RbSiEry+psG
 /p63IaE/2+laBQ1lKbITcNE/uexX4BglXSWV7K5LsLfu+4vggUFsZFjGEFhr6B7C+rmy0AF6cQt
 teQZmtfgedIxlvu9Me3LDiH+6WKJ9qVUnb95ThcNMcEOhFEWog3h7kPaVqf7JZ4QcrvogwaVYT8
 eHEWkLg98B9W0wsmlsIZ3iOcM+7GUM2fjuxhled1w54RvjyQMWaYaqMO7T4hJwYsbC0MBNbTfOJ
 WA+sQt7/iULcbsaUt+DPKCKL/uScb7UWoRBzjlbMYGf54Sy0sZBlaMdNSeFUnCoOaE9E4+3ViI/
 QYDRFruepfErwG6BpQpZEuVrsled+DTVjjBVI/Z6Lxp7yech30bzRrySInUjfgoscr1IfFeWhwA
 hqGz3EJA+KeRTo5Gn1fmkU8vX7aNsB9zQdQTBZLgiudxhPJOUzwzyBXEXrkH3StbOj77f5rqXOk
 FzdYrggoDsKd2CDxddg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX2t+vy/vGBJYr
 PNmpq/MhiOwcSJyznk8iDdtL1kAQQNAghl8sTl+FaVf7CwVL1autm8519juqYz6F5YdrWjm9HCX
 X7ZsfGU/XwkOeOyN99BF9gVElGTpndo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add extra information and context about the e-trace support added in
QEMU.  Most of the information documented is already presented in the
commit messages, albeit in a more pleasant way.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/specs/index.rst         |  1 +
 docs/specs/riscv-hwtrace.rst | 96 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 docs/specs/riscv-hwtrace.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 44e108db02..4c18fd5b7f 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -43,3 +43,4 @@ guest hardware that is specific to QEMU.
    aspeed-intc
    iommu-testdev
    s390x-secure-ipl
+   riscv-hwtrace
diff --git a/docs/specs/riscv-hwtrace.rst b/docs/specs/riscv-hwtrace.rst
new file mode 100644
index 0000000000..d9400eab00
--- /dev/null
+++ b/docs/specs/riscv-hwtrace.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _riscv-hwtrace:
+
+RISC-V Hardware Trace support for RISC-V CPUs
+=============================================
+
+QEMU implements a hardware tracing support based on the Efficient Trace
+for RISC-V v2.0 specification (`etrace spec`_) and the RISC-V Trace Control
+Interface Specification (`trace control spec`_).  Only a subset of all
+available features are implemented at this point.  More features will being
+added along the way, probably including support for N-trace support as well.
+
+What is available at this moment as far as hardware model are concerned:
+
+- e-trace supported added in the 'virt' RISC-V machine;
+- support for all TCG RISC-V CPU models, i.e. all available CPUs are able
+  to use the hw trace;
+- topology: one trace encoder/trace ram sink pair per CPU;
+- trace encoder has just the minimal bits specified in `trace control spec`_,
+  section "Minimal Implementation";
+- trace ramsink has SMEM support only;
+- no trace funnel support.
+
+A lot of considerations and simplications were made to adapt to the current
+TCG RISC-V model we have in place:
+
+- We do not have a pipeline model for QEMU RISC-V TCG CPUs.  This means
+  that an instruction that is emitted will be retired shortly after.  There's
+  no concurrent insns being executed in the same CPU thread;
+- all trap packets are sent with 'thaddr' set to 1 because (1) we'll always
+  know the trap EPC during a CPU interrupt and (2) there's no scenario where
+  a second trap is fired while the handler of the first trap is still in
+  flight because, as said above, we do not have a pipeline model in QEMU
+  RISC-V and all insns are emitted and retired in order;
+- irreport will never be set, i.e. irreport == updiscon, because we'll
+  always retire one insns per cycle.  Likewise, irdepth is not implemented.
+
+This emulation is compatible with the riscv-etrace-lib library located here:
+
+https://github.com/riscv-software-src/riscv-etrace-lib.git
+
+And some of the code being used to generated the packets were borrowed from
+this library.  At this point there are no plans to make riscv-etrace-lib a
+dependency for this emulation.
+
+Encoding parameters
+-------------------
+
+Several assumptions and simplifications were made in the code, in particular
+with the so called packet and itrace parameters used to write the mesasages.
+The present emulation does not allow changing these parameters, i.e. there's
+no way of changing the iaddress_width_p value.  In case there's enough demand
+and use cases we'll consider creating encoding properties to make them
+configurable.
+
+Here is a list of the parameters being used in the encoding process:
+
+============================ ===============
+Param name                   Hardcoded value
+============================ ===============
+.packet.srcid_bytes_p        0
+.packet.tstamp_bytes_p       0
+.packet.type_width_p         0
+.itrace.arch_p               0
+.itrace.blocks_p             0
+.itrace.bpred_size_p         5
+.itrace.cache_size_p         0
+.itrace.call_counter_size_p  1
+.itrace.ctype_width_p        0
+.itrace.context_width_p      0
+.itrace.time_width_p         0
+.itrace.ecause_width_p       6
+.itrace.f0s_width_p          1
+.itrace.filter_context_p     0
+.itrace.filter_time_p        0
+.itrace.filter_excint_p      0
+.itrace.filter_privilege_p   0
+.itrace.filter_tval_p        0
+.itrace.iaddress_lsb_p       0
+.itrace.iaddress_width_p     64
+.itrace.iretire_width_p      0
+.itrace.ilastsize_width_p    1
+.itrace.itype_width_p        0
+.itrace.nocontext_p          1
+.itrace.notime_p             1
+.itrace.privilege_width_p    3
+.itrace.retires_p            1
+.itrace.return_stack_size_p  1
+.itrace.sijump_p             0
+.itrace.impdef_width_p       0
+============================ ===============
+
+
+.. _etrace spec: https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
+.. _trace control spec: https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf
-- 
2.43.0


