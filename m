Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiIQ-0002k4-MM; Fri, 03 Jul 2026 14:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI1-0001oE-OW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHz-0002Qk-3F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiqxO685472
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4Yvu2Fw4Lme
 yR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=; b=ELyvaYosEH59XRVNqG2gRd36zW8
 Diw5AE2GUMwlhy7lV/fqg8AoDSelzk/SGqfr1H+vX/kfzOr3vPPwBI8SMBCaEuCD
 J/KYApczt5NW4wgmsziBM/tHWsqhLanIPNqKHQ4xahCA66LA1oi1HwURILrVShus
 3CBbts8kLkzWSRmR/aQX9zU5opCjFrF8e186d5858NsAKlMF8p9PY7kp2L9DARyD
 fKMP+0iImBHry52rESx+AjMOynQdtGcLNJRrM4a3abgc+VPRhRSVu8hGNGcLAFIp
 4DV2SLNJ/OCk/8lBHZNwPPhzCLTJQthm38tSiTUT4qR0cfDAv1YAJM7yWLQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qck6p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so5328451cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783102017; x=1783706817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Yvu2Fw4LmeyR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=;
 b=Q82kh9S3rfqdpkWqo5Zb6kUEFeUAJFDe+88NTdnl4IHeSrpdskPmmY1DNwP4XiMBzc
 upWhcngmz2GEkM7oMGc8yklkeWPE9CCLDT5PBPhfhm8sURYgnrZFm9NmMSQZ43U6Hr32
 3yzs4chn4WN4bU5DWkIxmWWQDnZhSO/QecnlEKSHIDv0UcYRjTkxDIKxnqKl8FXrIxV9
 Ov1FEEhRAGj0ujNDq3eNwngTYRBdbQZTwAF0Ayi3hcYRXVAJYiMCTpYk+r4qdI93nhIB
 y+jD5uLAXscyPBvg3baO3oF7Rnp8pEwECJVd8eE0pa6CDHnJMOeXG/CZyHmrW3yqby+H
 sZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783102017; x=1783706817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Yvu2Fw4LmeyR/bMRwzcwj89l/JCaFfxPkZEgK9zj/8=;
 b=JtPfq6ZMHAoY4Hu0hUEc2Fi4sLSfFn70FtQ9nt0SAu1xLAKtgigovMq1CXxQhWRUw3
 8iWTYYLT8pbsRtvfOVr6Y8tKolaxb2yOSM9MvDIik3OJlYM0mQQPbfW4KzUePmUdSIW7
 9QWh1kJLBBuuYyjSOsVtxtboveat8oLfyTbJQq05xrRY/4ajkE/SbMJsjohOeq/s+Dpi
 BUqFvuTgGtM1PGmdNftLRxu0e6GVwRIHNhmPN1/2tVSiRscBydm11J9o/AtjYlt97BJm
 rcY7L5CdQFZTdRbMzuZT7Rsy4g4qKjq00Fywpa0NrJtAXGNjGZsXvSOVx/O0Ej+tWjTF
 ypiw==
X-Gm-Message-State: AOJu0YxYf+FQCLw5tb72h2CpceigphPpZb3UPSBHCQwBq59erPDKHlPS
 W2+3XHjii37qY5Zu6kPROB1hiYLfOfy6Yy+sF0/dWL51j7bAIxibSckpAMo8svawmcY4SMxfK+o
 xly8d5SwkjWZtn6oEHv8ILaKcmm9zGnwmwhnqjSd5RmjxCUVUvC/IlmyQifWt+o8bkg==
X-Gm-Gg: AfdE7ckj5CWxjQalIXssKoqcsqgxLVYypyyxvKCxZ4JcEZZRNmUtXvwLwWVm9vz2mLx
 Pkvvwx61b6MH5rxhEVD1K6sCOI1ZxwppDhq/SguWAGwtgB3oRMgrpKx8rcqc0uqZpG9OiycbVAo
 ptbiRW1nDcKxhd8QgnS5oyd5BsVRtRHcF4p9jDUhzt0tLAC6g5875Wdp1aONhlN2UY07SxjI9Hz
 bJsYqNkzf4LJ8KdTVrRZ3qL2s+9dHwaDCLaS1QHSQIVXCC91RG0MGc85OkQ46mtEZs8JadooX1R
 Fe43JzvP/FFX5bLIX8zEIF3cLAiXdHBzRbUMoLucg4alKbvDQd13ESu6xuVI3GH5D/XGdlMQLjc
 i7G7aVcLPNai1xqoWLlOgeEmX9wGOI9jchi22hfmpmAMsTA==
X-Received: by 2002:a05:622a:214:b0:51b:e60b:f27c with SMTP id
 d75a77b69052e-51c4c23ba77mr9048781cf.5.1783102017365; 
 Fri, 03 Jul 2026 11:06:57 -0700 (PDT)
X-Received: by 2002:a05:622a:214:b0:51b:e60b:f27c with SMTP id
 d75a77b69052e-51c4c23ba77mr9048261cf.5.1783102016972; 
 Fri, 03 Jul 2026 11:06:56 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:56 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 24/24] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build
 job
Date: Fri,  3 Jul 2026 15:05:36 -0300
Message-ID: <20260703180538.3346781-25-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vNSv6cCRSxdo3QJuc1zSV618PU0J2-tE
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47fa42 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=BEvAcZqKd-QGyfCP7A8A:9
 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: vNSv6cCRSxdo3QJuc1zSV618PU0J2-tE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXzhxMprg5/D2V
 q85qs/Ol++cAMMiXHIKZMjV6tAYIIh8/PC7jzIrgYRa71hJU19T5IfaJrAVtARA4xZbimmaPX4s
 hYr6zAWtDZpdgRzY/XVYTAvb76Rc+EC9AnJJg3wVG0W6+Y3JMz2PKJlyzuFWj9eo4d7O8MPZYrs
 CXFXjsX0pXbJTJZrMOVFXfhdPo0n/3kO/y2ItJb4hGlssN+8PvJeFtIJNmenYyB0DLPIBXRTl03
 6ZR5qwwZiV7DbGsqpbWyqzeTdDF5rWLIED9R6yHVNCUFjw9CvoRVZYAz696QjXYiDf38CXodK6v
 Y+5KT6BqF6dURSEXf1s4aQkDBxH+rGs4agwv2tFXoPl+u8lOvbGCIPZtpDV/DSjUcD7ioQ7M9CW
 v+uE4/eGM8k/52UACU8LmgFGrf6xwAGgelXlgJ7VkXHTsgHHfMqm0ot8YubxBAAPW6/UoEaMdbm
 SQV4koc4knEq5FnnIFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX/jofwgUShOYL
 IVB70S01ajixsBzN8PTAgvQHAtxpQXxndz77mcIHV8ZAU5vXqk08neuFARyfe9R/JvFeF6H3hfq
 fie8hvJJk1XCKH3vVfje/kDxYK11Am0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zephyr Li <fritchleybohrer@gmail.com>

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index eaeeb533ce..a823aaaa21 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -59,6 +59,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    - job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


