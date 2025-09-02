Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4F2CA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI18-0000xp-2f; Mon, 01 Sep 2025 23:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI16-0000t0-15
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0v-0004aa-BO
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SCYq022315
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=8+aRBtyFvhb
 nN8LgYqCgFDeEPS2vAXMMQwGbH7A3A4k=; b=iGVIbHNEB9uldzGoOqLwcA4Qstr
 WTeKwe5npNRinn22aShYvrGU9L5A9BaYnTAQXH0DaHqGp61AyyFXPBnwgel809b8
 25h3yLKyAccTZLbJ3u6WhBjr2M7U1nCQvmMirrJGYkAn46mfb2fobeP6tY0y+mgc
 vpTSMsfMn0DlJWutIA8PNwMRf8m5VbFXaX7xtfLfgiytycoET6TKdbSG8eVzYvZV
 HhwevUX4Ady8xakV2wTpB4gQYGsb0kQu2mVG2VLKjYcumSdlV+jYALz83G8Ce1vV
 T7/0RQiB+EC8obWcZP9wSAhNOPmsOktxCLXlJMS3VLrCsX1gc864LUrBsmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6ht9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-329e375d372so273301a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784933; x=1757389733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+aRBtyFvhbnN8LgYqCgFDeEPS2vAXMMQwGbH7A3A4k=;
 b=pjIuTFWr0byxotoCFP7NJxSifELj1jEkQUa/8AWuD7/mza4O9Ti8y/7//0seL4bUc1
 9/DQQGjKu02DVG/FRIsPVRsFlqwdZqvczvT9sb3t5vNMN/Gc7vjNL8ntzWk4zd3TGFTh
 MQQY8oa7Z7uZ+CKtO5uaJhA5l76lPE/si3ifTTUBS5XPwcPj1vZDkIOTwO3gz9EPUgey
 xB8OoojGfjq7ioiLuqplz30+67KFIqlTvB3WOVanX+3x0OBGO/a3EcPnGrGP+6WMRZCZ
 C3eGuH+7Lyz2QGDKo/3fABQNJUcMIK8AO6fVmJbzgfBAwFtklpX3L91mmJTwWsHCdZu4
 PmpQ==
X-Gm-Message-State: AOJu0YxYaj+BEJl83XP454DweRj29ezoxjbSTzwjDSTWbWY4gfJHlOCB
 PatP3ybN9SLwQxVAuIh0NWwdbstyCtolk+4ul1DNPRpM6JgpxPoLRrUHG5jCqYX0dyfP2WvOyM2
 HYGpmx8zMFHMTh2zdHFGrNYly0sqVu1Eq8wkbkfC3w++bl2VrvuH5UU1R2MsM1HghcEE8
X-Gm-Gg: ASbGncsTS9uDioemTpo2VNIgPvIcas6e78FH+9dJcCHQ4BEunIGm0NsMfG1ojK6m4xU
 b114RnAOvWVPfsPU2M+dF8TBLtX4yRQJZPy9IPTrRRU70lpo19An/PjavzW5DEW4G0Isrhyz7v9
 +fq+diFO2ofH+zpeWzIsHBy63ZVupIJpnesMVSqPJo2/qnwx+8M6X6za5G4yQk7Kh/RodtEzgPt
 UM8BA9E38Ua0eD+uA41RRRWdWQVf1fD/MdsVmLj09cQQ3tnELLjew8uUJWO3b4qYvLwCSwls0Ta
 JnhS32NlXbn2nlLKOKHTbwbYUmYtDuaxE26uSqdHD1DpjIaNuQ7mLHlwYUbB9q3GcH4mH/mxnpl
 bIVQi4eloTCiK
X-Received: by 2002:a17:90b:1d45:b0:325:42f8:d73f with SMTP id
 98e67ed59e1d1-328156bb311mr15645311a91.17.1756784933028; 
 Mon, 01 Sep 2025 20:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnldTNNbiRc/OrSVcsceQvEoT0jj85VKTfqRR7xFlIwcY9IvXXp2TqaSfuAYEWnyGQfYMfaA==
X-Received: by 2002:a17:90b:1d45:b0:325:42f8:d73f with SMTP id
 98e67ed59e1d1-328156bb311mr15645278a91.17.1756784932503; 
 Mon, 01 Sep 2025 20:48:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 00/39] hexagon system emulation v2, part 2/3
Date: Mon,  1 Sep 2025 20:48:08 -0700
Message-Id: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VluTXXPNPBJxV6c4OmcIz-SFlMVswNf8
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66926 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jFlCOHn-nA9XB4dfpRYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: VluTXXPNPBJxV6c4OmcIz-SFlMVswNf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7T0gefNgDrZK
 x8Mz3phh2OvAvYa7sTKOmif3g45GpeUPAXoQ/hwUsIzARp9QiisD+JLO5mH3/u3T9gCACIO9Kj0
 jTP8ILBTn5EKYVacYf6yC9jzyky/8rVfw6ZPNFonMq0WnZRQmX2XF8/NJLSuAw1HQv6nHjW/RBm
 WEX3e42OLcUEQdXvy899KnZGKViMvCVE0XQdTkxglUW+7apduue+pGjBjlfrn6fCjkaZ+zLfEf7
 PkAaF5t5r7mluBahwTPPhtO9d2sgmrVzYtFd4eQ36Y9tMf8LahrWNhx+YnMDYkPsPbDjnRBTJDV
 w4XhKZT68GJiZpy5NjYz+J3+xxR7mKWagjFj8Ys7du1k8RAqZhWsc9QWK/ogZU91IWEDqLe+RMT
 nVFUo5bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As with part 1, several issues have been addressed with v2 but some remain.
* From "Implement modify SSR": HVX context management is moved out of this
series (it is no longer present in any of part 1, 2, 3).  It can be
revisited after these land.

Issues remaining, to be considered for v3:
* "Implement wait helper" - move hexagon_wait_thread() to op_helper.c?
* "Implement arch_{s, g}et_{thread, system}_reg()" - remove
    arch_[sg]et_system_reg() entirely?
* "Implement setprio, resched" - use ~0 for BESTWAIT_PRIO
* "Add exec-start-addr prop" - don't use ULL for UINT32
* "Define system, guest reg names" - fix last five reg names
* "Add TLB, k0 {un,}lock" - revisit design with suggestion from Richard
* "Define gen_precise_exception" - reword commit subject

Brian Cain (37):
  target/hexagon: Implement ciad helper
  target/hexagon: Implement {c,}swi helpers
  target/hexagon: Implement iassign{r,w} helpers
  target/hexagon: Implement start/stop helpers, soft reset
  target/hexagon: Implement modify SSR
  target/hexagon: Implement {g,s}etimask helpers
  target/hexagon: Implement wait helper
  target/hexagon: Implement get_exe_mode()
  target/hexagon: Implement arch_get_system_reg()
  target/hexagon: Implement arch_{s,g}et_{thread,system}_reg()
  target/hexagon: Add representation to count cycles
  target/hexagon: Add implementation of cycle counters
  target/hexagon: Implement modify_syscfg()
  target/hexagon: Implement hex_tlb_entry_get_perm()
  target/hexagon: Implement hex_tlb_lookup_by_asid()
  target/hexagon: Implement software interrupt
  target/hexagon: Implement exec_interrupt, set_irq
  target/hexagon: Implement hexagon_tlb_fill()
  target/hexagon: Implement siad inst
  target/hexagon: Implement hexagon_resume_threads()
  target/hexagon: Implement setprio, resched
  target/hexagon: Add sysemu_ops, cpu_get_phys_page_debug()
  target/hexagon: Add exec-start-addr prop
  target/hexagon: extend hexagon_cpu_mmu_index() for sysemu
  target/hexagon: Decode trap1, rte as COF
  target/hexagon: Implement hexagon_find_last_irq()
  target/hexagon: Implement modify_ssr, resched, pending_interrupt
  target/hexagon: Add pkt_ends_tb to translation
  target/hexagon: Add next_PC, {s,g}reg writes
  target/hexagon: Add implicit sysreg writes
  target/hexagon: Define system, guest reg names
  target/hexagon: initialize sys/guest reg TCGvs
  target/hexagon: Add TLB, k0 {un,}lock
  target/hexagon: Define gen_precise_exception()
  target/hexagon: Add TCG overrides for transfer insts
  target/hexagon: Add support for loadw_phys
  target/hexagon: Add pcycle setting functionality

Matheus Tavares Bernardino (2):
  target/hexagon: add simple cpu_exec_reset and pointer_wrap
  target/hexagon: Add guest reg reading functionality

 target/hexagon/cpu.h                  |  13 +-
 target/hexagon/cpu_helper.h           |  21 +-
 target/hexagon/gen_tcg.h              |   7 -
 target/hexagon/gen_tcg_sys.h          |  25 ++
 target/hexagon/helper.h               |   7 +-
 target/hexagon/hexswi.h               |  17 +
 target/hexagon/internal.h             |   2 +
 target/hexagon/sys_macros.h           |   8 +-
 target/hexagon/translate.h            |   5 +
 target/hexagon/reg_fields_def.h.inc   |  11 +
 linux-user/hexagon/cpu_loop.c         |   7 +
 target/hexagon/cpu.c                  | 349 ++++++++++++++++++++-
 target/hexagon/cpu_helper.c           | 358 ++++++++++++++++++++-
 target/hexagon/decode.c               |  14 +
 target/hexagon/genptr.c               |   7 +-
 target/hexagon/hex_mmu.c              |  84 ++++-
 target/hexagon/hexswi.c               | 256 +++++++++++++++
 target/hexagon/machine.c              |   2 +-
 target/hexagon/op_helper.c            | 430 ++++++++++++++++++++++++--
 target/hexagon/translate.c            | 304 ++++++++++++++++--
 target/hexagon/hex_common.py          |   3 +
 target/hexagon/imported/encode_pp.def |   1 +
 target/hexagon/imported/ldst.idef     |   3 +
 23 files changed, 1848 insertions(+), 86 deletions(-)
 create mode 100644 target/hexagon/hexswi.h
 create mode 100644 target/hexagon/hexswi.c

-- 
2.34.1


