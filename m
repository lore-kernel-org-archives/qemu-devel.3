Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A055CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPxO-0004aC-14; Wed, 10 Jun 2026 16:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXPxM-0004Yd-5P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:55:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXPxI-0004lD-2B
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:55:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYBG32604341
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 20:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ej1XtlsUy2Rlx/HhDdSf6Wo4edvKnfnnCv0
 wNseGCI4=; b=Dq74U6MpGd791EJYUse6Yj03IHQ2rCl5nix+/8J2b16mnNlr3tV
 LrB3dsEexkht9PqlE/hsSsgOT0E+yTRTFKCaAMIolDeswyRnvsUaufSaJGT3ObiS
 D+I9XSgiwpyl/erXn96tfnnAN0dL0iT9U3CltXZ5bdEQgO6o+nYN4rIsPLwfgC/4
 26jZ5xRDypoN31gT2AfYhdJiC1rGzHaMbK1F6TB5MXjIb5XfQC9+4P8DuxNVlDJC
 oWIY7gMO01MQ1P0Y8ORpqzehGaxKNu0MGS2igqbkLm+/gd6aA7elzFyqhEYzqDpq
 GkRY/HfnwfaU6fpHi22uxmPY7aWqHxYkyRw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u09cc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 20:55:17 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59ed1788158so4000872e0c.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781124916; x=1781729716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ej1XtlsUy2Rlx/HhDdSf6Wo4edvKnfnnCv0wNseGCI4=;
 b=BZHRYz/UGvPh1p2SMHIRLkn+o8xxPa3lbCUwj2VN7W6m9Oor3M0AlcHouHfudFo0vX
 BQMBvHZnFoCFhLt9dGnAF5LHFtYCvAbKHur9+X1zLk4W4Glb0V0NEVimR+YzPHvTmN8N
 9+cLiax0WqJs3vZGrYsgQJupDTcMTuWYVhyTtxSnL//+LhgUUlWquqc8vALsbsAETbKb
 ggQxHxJd+Y5ZoCzHfHeKvg5VyKa/FLEnas3Yi8fTMkVP/uaqjxWumFqQWejcGk3q1SJH
 nhPNpT6Oq7d7FS4PaRVjWvtU46oRPpubVEQDrJeyyPn9LZ3qP+Ziux2HBMdGFjTRIpL7
 CvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124916; x=1781729716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej1XtlsUy2Rlx/HhDdSf6Wo4edvKnfnnCv0wNseGCI4=;
 b=lF+N5fcAolpvbQgkmGrN+3evW1MZoNgK5dqiGJnA/+3vVfvGnZe+0lO1/2qluh9eV6
 v/jruIP7gCAsx27LRH2WP4GvM4UQC1ID8vfnUf3OZuJChaUIS3+5rYBZHi0mbVA0REHj
 Ce/JWy9X1pyV0jtDPqppjJlCLMRNq3RHrja/+kdFo3d37MlQXV45zwYaw++hgeRBQI5T
 7usVkQJ8SWViZWbTJoGlNraohBZT0hYKPG0b8TXxndaBTRM48qFjMhy+pP3Ifbk3Fv/F
 Tg0JssekAJ3l64P0b+h3LhaGZlb2EOEO86QONvl6IhnwBlslxLfR/RJo4c/Z3Hj9wMZ5
 XjEQ==
X-Gm-Message-State: AOJu0YxO6c7Wug6r1EU6/5FoYdp+2UkWZn4hwOLEj4hRAzTeuM7eUHqt
 f/AQhSryUdMrKLCb/pWbHXuxiioIJn2u2PRaxyho2joMp4hCPXdiPobyf8itfESo9Yp57Nuaso7
 bbppX18mPOYW+ijMJQv7hHH0OrJ1LAlYCkXvv0e8ydIJVMH2bzj3Io94WbP6XVugFnA==
X-Gm-Gg: Acq92OFY5kq/0HNKFW1zVjAhY8LLWPqcPGHPJWKlyfno2WKMnBS69kqn+Z6lh7gVieg
 FfI5Ldm/yWrSKi+vEyBAwpBtY1PyWkkMaxrbp9QKnZTACOnGAFRcOkjB5dAI+5n0pUHMlcWRxag
 cPydOtOCi4M8s+UOFAL41BYjjeBqrIjTAFXnyLib/vjLnRLdkPQViNEONxdEgxYxO93v2KcHbT0
 na+jE2+3LNzia/Qob8J9tJVgC2Q4Qo4Vy+embtstsxiZ2FmBVj43iHTjM0TkOmkyYxb3SCE9sBR
 pe5cyUO734q1tscRDUvEXObXAVZfTSSUE+SCUtGxLlotYT3ZWNSIzzmdhKad5AY6MGp6oJtazzs
 JCNmAnTYn9mbeW3MhykwwzcXLibvk4WtFgymP1UsFzo/tnIugYPnBwZ4uKrZTGdO1TIJ1SA==
X-Received: by 2002:a05:6122:3124:b0:5a4:5605:c681 with SMTP id
 71dfb90a1353d-5b63156038emr1991021e0c.0.1781124916480; 
 Wed, 10 Jun 2026 13:55:16 -0700 (PDT)
X-Received: by 2002:a05:6122:3124:b0:5a4:5605:c681 with SMTP id
 71dfb90a1353d-5b63156038emr1990732e0c.0.1781124903989; 
 Wed, 10 Jun 2026 13:55:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413f91f2esm19548084241.4.2026.06.10.13.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:55:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/2] target/riscv: parametrize debug trigger number
Date: Wed, 10 Jun 2026 17:54:55 -0300
Message-ID: <20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a29cf35 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wRnqjUqX6ojlRaorIEkA:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: xT4gIPNvgg7nyIe7kuT4EZDurEWs3uR3
X-Proofpoint-GUID: xT4gIPNvgg7nyIe7kuT4EZDurEWs3uR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwMCBTYWx0ZWRfX8BJwQtBJVqCY
 +VfW0tdaRV5RGnqreBcGrmblXUrE661E4OTDYvHJvdsN3UbqKC+19E8TQYcrtTL7GMLKkPCjkOA
 Z+R2Se00bU8mArYZjBgc6EfXgVDyd74Yyo0/prpbINowfCCBxKpKoGsSDNfoBsXPpok7M72G81X
 6hRNVttABEQSo+Ba1Gwg/7X2jiQyd9vnBgoQHEFBoLOGCVl0YdESR83YE2p60kWu/TVeLUWMLaB
 aW/c8RTQKoOVS5BACQGMZlDx2+GADA/LJ8ZisIy6srQMpQuTsXT7COkZowqk+soTm1f75VVhqyZ
 QBaFdkEphOXOghq0oNESZ//lf6wBTNEGHsMxKi5nJFPHL5jDD1OMuJ005ABOcVc48Kxh/uiMQe0
 qlrhM9e8lZDiXT5ch27fYi8BOWnFD/9HBDjYnckEWljkWMqk0255uL9aq5gdZePov/FIwgzS6m6
 wdN7aPgKtpYHzvO/zhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwMCBTYWx0ZWRfX3NB3xJHTrj7g
 07+iaHGjNQY9aXhTCiHLhsV5t2z4kvjMIxIiMwmzbcWarYMG6+5frNPh2XInvfgFaNXS/TYWgrZ
 Y49gZtUPXXRWwPWmp+YTIpoRCpU/8P8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100200
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

This is a follow-up from the solo patch [1] that I decided to split in
a short 2 patch follow-up.

As seen in [2] we faced a situation where we were unable to set a
dynamic array length in the existing VMSTATE_UINT64_ARRAY() macro,
having to resort to VMSTATE_VARRAY_UINT32().  But that also means that
the env.tdata1/2/3 arrays can't be statically allocated, so we'll need
to dynamic allocate that.  But if we're doing that, why not do dynamic
alloc in all other trigger related arrays and avoid the extra footprint
in CPURISCVState.

And here we are.  Patch 1 is a prep patch that parametrizes the number
of triggers in a new env->num_triggers (changed from trigger_count after
seeing a pattern of calling this type of field num_stuffs) field.  This
will serve as array length for all the trigger related arrays, that are
now dynamically allocated.

Patch 2 does the rest of the work by creating an user facing
'num-triggers' property and a CPUDef '.num_trigger' property to allow
CPUs to customize the amount of debug triggers.

Patches based on alistair/riscv-to-apply.next.


Changes from v1:
- patch 1 (new):
  - all debug trigger arrays are now dynamically allocated during
    realize() time;
  - env->num_triggers is the length of these arrays.
- patch 2:
  - changed property name from trigger-count to num-triggers;
  - changed CPUDef field name from .trigger_count to .num_triggers'.
- v1 link: https://lore.kernel.org/qemu-devel/20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com/



[1] https://lore.kernel.org/qemu-devel/20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com/
[2] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/

Daniel Henrique Barboza (2):
  target/riscv: dynamic alloc of debug trigger arrays
  target/riscv: add 'num-triggers' debug property

 target/riscv/cpu.c     | 11 +++++++++++
 target/riscv/cpu.h     | 37 ++++++++++++++++++++++++++++++-------
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 31 +++++++++++++++++++++++--------
 target/riscv/machine.c | 16 +++++++++++-----
 5 files changed, 76 insertions(+), 21 deletions(-)

-- 
2.43.0


