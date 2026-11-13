Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A9606B35F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NwOjXaiK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hQw0vDwl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvg-0002yz-KM; Fri, 13 Nov 2026 03:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xRmvd-0002yN-45
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xRmvb-0007TE-Az
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:36 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8V3Ck3827003
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=m5xPQ+IJ4/p06rqRIwYy+IBQ9Oy5GfUUAUU
 4mwKpMrk=; b=NwOjXaiKsqANDxmROv8B9UlDJ/x+V4NVD2NGGH7ISpTWc5+PkLH
 JwR7/NoRvqlAP1yLO132CYmFOXLd+Y/T5xOgnT2S9zvQ5pdqveDgSjFXdVL7R56D
 4plxvgJFWszxYu+GEQGcyHugigDag7AJc5VaubyUiip6B/B+Lfsni813v5t2WGQE
 +vWfZ/q0QRmhezxb4yb0qN/OJB5pltIj8Ec4ZLFBBPTHML/eo+OoDv46qzQSpe4R
 itw8RubDgMPIkDHhU3Q65BQa0gwL9yOQtqcQkAsB6G/g+fnQ9UFsaGDur3DHs3N1
 zoZnQOCqu9MZ/q5QVDFZYhPsnHV8lJ82Qlg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37gs11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:46:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37549877380so980367eec.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794559591; x=1795164391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5xPQ+IJ4/p06rqRIwYy+IBQ9Oy5GfUUAUU4mwKpMrk=;
 b=hQw0vDwlPzOd2tc63VybbiDQM12QVuvFA12ECWkSppkS1SwqIFKdos1wWf49Wwd3M1
 VQzE1lOHAR6Xz6ogWkth2GQMuEKo+ZI+EVPjYHOH2QIhC0KivzwyT9kTdoVBF2Vag+5f
 u5ogMKhM4c5ynyU+rUML+1FYmzOM0Bn6tqI9diV/RIVHdZ8PsmUAAkz+76Wz7jBl4Njr
 fg3PtLSDVHtSApKrBImzl/YwF3GewH+89iEckd2Gpf2XRGnN9yUqW7BxqoLFAPIrEfOi
 +rYiKmHIBwgOkCpaLD7F9pepN2juOL9RDfuBa8YvZ8zcwUSCRJXdmofoaT0djQIjGFEg
 mjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559591; x=1795164391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5xPQ+IJ4/p06rqRIwYy+IBQ9Oy5GfUUAUU4mwKpMrk=;
 b=ZNMSPSPJCRQLNhlXIPPV2KP0mqutNZCie6xvHTxkXunWVG2yGF6DtAxnS4OZX1r7sC
 aaTcQ08wKqUKk5cGjeVeJKstFA559AtGHw4rZRoI1YzavDFuBtwAx6y0Wj5Ah3F741K4
 9wzMuFiDPQI8wVpoQAdP1TeZBF8EFxO2ZK80Fsk5igJU6Jv10sdQKSJmTSQXyGtYzfmX
 k5XP1l99q8jfQ7S/LiqXse/Kr/HzOZRbDcPMgNX/6c9jVTePic+how9iYMBm+eRrhENG
 fAtv5rUrnDjcME33viTi/IOf/jLDETS0jeGqIp2fww3Ma5n+RNqfLSuUhxWsL7pQghal
 P3YQ==
X-Gm-Message-State: APuU4Z9F9jYHNl1d6JNoZS7EsBChm2kM2FqwnoHQY792ryZg3+IJfgBP
 bGWiOiqdiMlqhy9hf6hXE/CGIL50kzz0M+fWYfslTbTJIzcuhhBEN1bd+65WpGZYaCg8sk9jQWz
 dKJirUR6i2PUIZPjdz/5hlpP26hWJFvScYPzneD/iJztNJiNUL79H4M8sxh6KcrKEew==
X-Gm-Gg: AYBFou2D7Dr527zh62Bxhfd5CnzGbbi/Wtxs11Dh7HNFgscWydrTofXjz3B+jJHCac0
 jMECcm4BluPTzFXJu0xgXRjfaVIfWLb1lonQ5XoMOWFRPSEGLsOrkt1bEact1XVwmqWX5CNotQf
 17ntEZY1EJfXOJLGlssPi3/WZ2QxYpDbtHjgHW0N6JuZdmGmFJcDurUntjQdFx9O9keqffqAaLH
 k8QOAxi4C0D3lnsapQNdLOMPE4YUhgNTjr7Ft8+Va9V6LNG/zTAORIAQML5LZ0GB9TJGh9GC+41
 lyHwBIwHIKecY1sx1jY3/03hEZ4pxTSRp2fRgoXiiKf3jPD38s0CmYhP5FB+dUu0gDFE1ur/a5j
 8O+k7p+TdXKPbK7xRaFdK+21zBB7vgcb6Dw28Hj/sNAMsQe9rS/LKQuhojFjiLT2xEKn2KFtK1g
 fdaAdHJvKxEkHtpq9gL218L0y2hEpb2lU69rCUnQ9TrbDALKjGWLZqvDL5uBSVYqIanslFRaqz
X-Received: by 2002:a05:7300:da04:b0:369:f420:8679 with SMTP id
 5a478bee46e88-37968b93b2bmr1777282eec.38.1794559590872; 
 Fri, 13 Nov 2026 00:46:30 -0800 (PST)
X-Received: by 2002:a05:7300:da04:b0:369:f420:8679 with SMTP id
 5a478bee46e88-37968b93b2bmr1777261eec.38.1794559590315; 
 Fri, 13 Nov 2026 00:46:30 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379559189e8sm5689242eec.11.2026.11.13.00.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:46:29 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 0/2] target/riscv: Fix icount trigger exception PC
Date: Fri, 13 Nov 2026 14:16:20 +0530
Message-ID: <20261113084622.738278-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX9WBisLViGBG5
 RUtB5lPFPFmC/rcHQHgYqhntEBCdS8Y9R06Ete/Dk0RhnRwjD1PN1GJgz/8o50HXH0zY0hEcsyP
 ey4uognfJoCshqOPBHQvjWRAlpBGuh8=
X-Proofpoint-ORIG-GUID: FSJIElUiePj6pUWLKM0t_5IfDuz7sf7h
X-Proofpoint-GUID: FSJIElUiePj6pUWLKM0t_5IfDuz7sf7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX0XWkNr+TzS1v
 87NR9IIR+tqJSOXda+aj390uLXMtODDVxAETfDpmmCh7OjWuUCN/Zh8YtStb8+8x3tt/fUnO4sA
 f5dK0ea2M8q0lwn0mTh3SYn11YJkGyCec6+4i6aje49YTkd/2O6BDINP49xQXsN9xyi/gzufJF2
 V7KNrNWuhEfqK775gBZoOdvGowBnOMQdCn7KP422N2j2N6V93IuaS+NZRZRErsylMR6rJdzrLG0
 BFnw7h/i4v7IYpu42vgsJ+0LGbSlTZ4iBgh0FbKZtU3ZgfUkqZ4RU6WbWNu4R8uyyhCu+jmGhPA
 gJCP4qiV/tVf0I7K7/iXUY2WIx7Z1ro/hpNDnYFuFGQQdLl4OzTmW2ZIrfVycHxbzzp7bwuqgek
 p9vw/fBr2zL4Narm4N2gab90oyx2MhSbnXJB3FSDUmj8AsO0IOFZI/GwIJ3a2zHG14cNRA7bnDC
 OtCnWnfSsQJ/GHlR4Hw==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6ce68 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EwCL19PAiXdwFe56MGIA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130034
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Changes in v3:
 - Split in two commits
   - guest-visible tdata CSR availability change
   - icount trigger exception PC
 - reword the commit log to properly phrase the rationale
 - Added fixes to CSR available change

Changes in v2:
 - Added fixes tag
 - Always load itrigger_enabled flag in migration load
 - Reload itrigger_enabled flag after tdata3 write
 - Refresh stale itrigger_enabled after mcontext writes

Changes in v1:
Per the Sdtrig specification, on a breakpoint exception with icount, the
xepc must contain the virtual address of the next instruction that must
be executed to preserve the program flow. So for a one-instruction
trigger must fire only after the counted instruction retires. The xepc
must contains the architectural successor PC which for a taken branch
should be the branch target and the fallthrough otherwise.

QEMU previously disabled the translated-block trigger flag when icount was
enabled and relied on timer and privilege-change callbacks to update the
count, so the trigger could fire outside instruction retirement before the
guest PC advanced, causing Linux to observe the old PC and re-enter the same
breakpoint while single-stepping with icount.

Fix this by
  - publishing the icount trigger flag in translated blocks even with
    icount enabled
  - making the helper decrement the trigger count after the
    instruction has committed its successor PC and raise the trigger
    action only then
  - privilege-change callbacks refresh cached enabled state because itriggers
    tied to privilege mode.

Also make trigger data CSR availability depend on an implemented trigger slot
rather than the currently selected trigger type, so software can disable a
trigger with type zero and still write the rest of the slot state before
selecting another supported type.

itrigger timers are completely removed as they are not required now.

Himanshu Chauhan (2):
  target/riscv: Keep tdata CSRs available for disabled slots
  target/riscv: Fix icount trigger exception PC

 target/riscv/cpu.h            |   5 +-
 target/riscv/machine.c        |   5 +-
 target/riscv/tcg/cpu_helper.c |  10 +-
 target/riscv/tcg/csr.c        |   3 +
 target/riscv/tcg/debug.c      | 171 ++++++++++------------------------
 target/riscv/tcg/tcg-cpu.c    |   7 +-
 6 files changed, 66 insertions(+), 135 deletions(-)

-- 
2.43.0


