Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF5606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7g/5JJq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BdGBPlwU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQtJO-0004FO-RW; Tue, 10 Nov 2026 16:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQtJM-0004EH-AT
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:23:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQtJK-0005er-G2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:23:24 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAJC3aW708805
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=r1kEKxYg33vnsMFJbarPH3
 e8qec7VsisKQxNXjPP06E=; b=o7g/5JJqHvOK2W0dOuPa7tEO5mD1P1iHTJ8959
 bx96m4AMCCOdB80TN3RoTwj6Q6B8zFV0Ltf4f2zXViN28StiDb8Er0G4f3qEg3zX
 jCW1K7S0N3uOhL7MLJfHEHZ/CioCQ/t8JvxbZ6Dx5h1s99T3C+mR6iL2dUgUfXmH
 Zww9nWCQEvIE5PKRi1AYoDTJsgntNqBR2pXjBw2AY7P7bE1jTKxJ4feiL/27qjBW
 WfSZP25O79bm9EQBVXRqzmLM61mnuw9Zhsojt1dP4Z7eN45lulxrwQf5DLS6asg7
 8YGJYKLx7FogNKLIQUaNYXgUPouivS2ZYBH0DSB0BBKMh3WA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c8h6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:23:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53661e036a2so50639761cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794345800; x=1794950600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r1kEKxYg33vnsMFJbarPH3e8qec7VsisKQxNXjPP06E=;
 b=BdGBPlwU63PYCw+mwt8j1gSIEJFl+QATElf7N3oenVu8u6oppR5teiYBAJIQTqxkMH
 nQ0zbUOA2p5ukEpfsISCLfKJ9T7aIAdJS88YLYhjCZFowCoKHP7HfgJ+NzSM3q2Zq9sl
 d+U3JLjVUEreTyN71eEUpAHVyNLXF5LiGsrcYgWxVYDrsHqVa88Ip4waYE/WTIvxKkpR
 ohMOXfl2mLpcGoVEHRgmUbQGCcqPHD5jO1cWTCzshLTlaXpx5kghVWCh2R5aPwOUSfF3
 lHtu4ZY8K+77NodNv0+MGqOwv63ZdAstDuh9Wj1B/D+12v7ADqOd8SxNIopUfiRivxFR
 eBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794345800; x=1794950600;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r1kEKxYg33vnsMFJbarPH3e8qec7VsisKQxNXjPP06E=;
 b=V+GZPlUNQqPg6EwKFz/EYJ35J2vDmjxEmnCAYoREI6aP/z+rhZpbL+fS9xx0zZua6X
 10WoiemMs833eyqt4pO8jbytSf8MEjz5K0hDxrFzCwAunvp+Ohsu46cF4WYHrHnjKwUF
 YY67PIKnwcieX/m1LYdRUvKMUoDc77iu2x4Kcubfr/jRO3AEDCdDucdGVuS4Za0RTSF5
 SeOrSw/iK4j532DD0AcrZXB617Y4Vig8qsgLZ5yg9RZ7a/D7W40DbxJg0sJl0Gm8MSAU
 QWkHtHdavrG4J/Sm+uYmtpQsxxr1H5ermSjv7kScd4lBiuX7juLQZRoH3xF/F/Jl/99L
 1WVA==
X-Gm-Message-State: APuU4Z86CEWrq49+bxgfNdbvuXHNqgikvZGaVfj+119wJtdxwZFdnDVI
 Ju+OW5+5oPlb2SlO76TX8x4q/KylsezrxwXgfO/YkLm1yUlzjTvPPj+iK1whHpMgxPkbArg2iKH
 Nb13H7alV19iD7eK2MXoR9wkdOZbghxQK+LVsA1kYAEfyCC9mgckIBSgo4s6UolRGaw==
X-Gm-Gg: AYBFou2CJC/kxk02sJoWQVLcM+NJskNgep+l26YkOp/loNgDynn9FvOUYpq0v9F+LsZ
 fv0jD05WnbGqkryh7RSZ/JTb92JdnRjMv1YEFKDTTaWirjmK9533Sh75o6ZnQ7Then1T2bqw28e
 PBqJTnbMfnAi7kRFbUsvivfDX9JHd3zo+yyLE3zQhHiyNicpLRHDV9uy22UJE485ruqWfi0w1fu
 0c95Iv7cfMnUpdlfOjm8z1/b3Ut+nh45E+j6qDFlkk2r1a95At0aLqQhifmeVc7LBJ3cIkQKsS9
 wtQic3HHIqslCNDdYsjoUToNpgaSBXgKqMBJMDMsTiQoc2VvyXdsTlHNbAIVwy6/qRca3hJwv6Z
 uJjob2MUiGmZX+BVXw9qwqhEXoAKziEq/kTk6OxuxI7zVBqLzzOEfgk7gW9nm9ZLi51ttUxNazj
 +EGYnqcXztw3M=
X-Received: by 2002:a05:622a:298c:b0:537:8412:e659 with SMTP id
 d75a77b69052e-556c0bc1bc1mr2025211cf.34.1794345799654; 
 Tue, 10 Nov 2026 13:23:19 -0800 (PST)
X-Received: by 2002:a05:622a:298c:b0:537:8412:e659 with SMTP id
 d75a77b69052e-556c0bc1bc1mr2024751cf.34.1794345799089; 
 Tue, 10 Nov 2026 13:23:19 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91efe5da1b4sm13117746d6.13.2026.11.10.13.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 13:23:18 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v4 0/2] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Date: Tue, 10 Nov 2026 18:23:10 -0300
Message-ID: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4NSBTYWx0ZWRfX3/XUi4h/tSrk
 vzeLy7BHOjekIIYZx4VOuqC5I24koG39vK/WRZxzxvi+uZMVGC6Mw+txqn287FBqXyI3JMRcdFd
 ENNu9B0gxBd3wa8VZ5BDD7AbiWrKwIl5hwnJZC9Dq1Y4dXuvFE9MvaA1/gHkt7Whyvg3+s89Vmx
 mqE21rIhkE/KAu0JVLYoT6UCRz1IgUZhW2Kfzf2qnNxpXvjJB79msYQObiGdC2UktVLgiy1nBZP
 l9p1MsJV7PGJMLzY7rT0racVN9ED6DQXT9fu8bQ53aVXDGcA8TmiffJDkeXSURHF+n3rs6Kxkr8
 +x4EDsG1Uyjid/sTKDTxvQUTbdJe+dhfMR8mQCsYIfQ2xXy9Ux6NaiaPE5ZSF+7n+cLbBIZ0J8d
 D7LWTvE3cVgAczXEYr2cqaMigj1ORImPvsDLetOp3Pm8Tx7JhEVfv1pwKUvktA4ty6Bw8Dj288H
 qH94lVtKvWKBtGb/q8A==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af38b48 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=dZbOZ2KzAAAA:8 a=Yyj5xFip5HGosDxEGYIA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 3kWkh-0MhjqONCXCcN0tLDq4tCjGjSCO
X-Proofpoint-ORIG-GUID: 3kWkh-0MhjqONCXCcN0tLDq4tCjGjSCO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4NSBTYWx0ZWRfX5LQMaS5HdnPk
 +Uoix+yJ6gDM4JGp9waLRFXLnMrHhWkFx6vloDh5Bj/r4Li3wsS6GrSVpBOmCVkUoKMj2y79CQU
 NtZnQj1m1IXU38uTpVZSnwqO8uk8jr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100085
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is a new version of ZhengXiang Qin's work in:

https://lore.kernel.org/qemu-devel/tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com/

The patch got dropped due to a type mismatch in env->badaddr.  But so it
happens that the patch fixes Gitlab #3501, still pending since May 26.
Let's get this over with.

Patch 1 is a trivial change I did while applying the fix.


Changes from v3:
- patch 1 (new):
  - use riscv_cpu_cfg() instead of env_archcpu()
- patch 2:
  - use uint64_t instead of target_ulong for fault_addr
- v3 link: https://lore.kernel.org/qemu-devel/tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com/

Daniel Henrique Barboza (1):
  target/riscv/tcg/op_helper: avoid env_archcpu() to access
    cbom_blocksize

ZhengXiang Qin (1):
  target/riscv: raise access fault for Zicbom MMIO-like accesses

 target/riscv/tcg/op_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


