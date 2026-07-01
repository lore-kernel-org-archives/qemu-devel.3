Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEDCC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetmn-0002KJ-IM; Wed, 01 Jul 2026 08:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetml-0002Jb-Ew
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmj-0002bc-QK
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8d0o754631
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 12:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NS233Ut5S1EEofp3zjBCOxg/hpaEBph1WTj
 dJr8r+e0=; b=onNqfenqeJRDGiOCfxPASOnQd3qZ076E3z9LHfDUw5GVST67Flj
 INTMYMMx1jEeAt7MSI3Bb/iNwaXQ7VXZRaeRrp48YO5wur2k/nB/JIdw893rTEH6
 kPIp4lPWzPKtCU1RFXMS7mpL8qBz9A2CzZeYnR1mW6L6pswcGAi3gXLvO2vj74us
 /h/UVYVfqrGOoavGDtQbvo6JcdSRSGUAFLdpI7p9dougyDxndh5AIu+5n9FhJ3ja
 EmJjzf25as8iWJwZhRPsfiWGc81b9EoTZIUJU5A50L9EKDsb9sPM07x5oLDVKu9t
 hNmHFbM5L63XMLzZVrfoyuz01pLMvSnHfoQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqrhda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:11:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92aea0d801dso65686885a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782907879; x=1783512679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NS233Ut5S1EEofp3zjBCOxg/hpaEBph1WTjdJr8r+e0=;
 b=CMqMIHk43SYtMxyncpzxQ5YXVITrkx9DXGVtwE7UQ0EWDGurhUjy5C4xy0B9pJfKFF
 JjmZmEyOjTYuOM4ltsbPdg8mKSFV7Qda/rbW2Eh4u3+ooM+LXRMRtTWTdWNUw5q2s8Px
 +oTQrRQU6WGULvMlR5Vy0sH77ZgTrh5KxclyVjAgNuUdN7pSHD/WNghdItJ7QNxT8bNb
 4N/A4Ssvd5rxDJgxps8ewtmNs0vQIlRIijVhwc1fYP8Caz02/u8ADCot5/0rOn+rgmtM
 vaDvVS3yli1bG49CnSdmVzqFZ/1AnOTyX9XCC4X2g3RYrj1d9fAFKeKF+1K6P5NAkBWn
 Du8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907879; x=1783512679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS233Ut5S1EEofp3zjBCOxg/hpaEBph1WTjdJr8r+e0=;
 b=VmJRqkG6B8CarQvCNTczRJ3Lvl0utCYB3Yo8d0k1a1erPdNCI1g0S8XfZmvp1O2vPm
 2Tvz/baXpNEQbWGS7+8ZGGYIcZ5bpLKRr8strmvHUhU2x9YLS04W+1XqVio1w2sK+gJu
 +CIfzVpBE3udJVWlEjkakTl7hXiN1A2aBKSJtILbhva6wYZk6NZss1bGgW92vlsQXcLY
 57YLoPJ6KgZp5fM0GZjYIW/Y8yu62PKGU0a2wy6Rogn0KVMV+RDeVktvtLrhCw7RFCJP
 VhwVByZa/tIXgDu/fsVSK+agswp6qOnQydwlxJdi6427AIRiDkhZivfIz4VWtmNaCH5v
 Z1vQ==
X-Gm-Message-State: AOJu0YwvWHI1pjX17vXePhMqi/M0UskmEGNMNfy8WCeH5xOOmPF1nP1n
 SFkbcemucHUDgAnR9lce0ZG3HrKHxcHTixP26a/5Fr22ffOGVisr5J3yb8s5uPqCfAHfcsHz3CN
 7K+UQQ5uUoFtAX1L5y3XloNzDDOSe+q4sGU0tWcpql23ekGvFHDv5YnA6e6xrSW/cCA==
X-Gm-Gg: AfdE7clM88fyjjIM+PAkmQvWtn1bymP6FnW8G6KHaxmfr99uAmJUHFGDjdvrEAxyUpJ
 ht19jCyo3SeWtmGde7N/jcSVYBVgydMMVm8n5vbR3cAyJBHF4vUVVV4qhOKhZV4uo9JWlCzGYGp
 IkG1mytcNcE5a0lmtiPnTfoSD9yN+EnnbvttMFDEQHXuLHZA2tji/w+3J+PS2iUyTugZwFHlepJ
 PlH+MvovZ4sX1g/l7tpyCCuhaENVBK9U7NIUbu8KVQS9qQQgBQfzg1oA72CrFWiPmpZKEtouh9t
 PH83Onzeq83ufipoD3EINrYcqLqtrq/V/Ip9DCLmesmYTQ3a6Nb0wvTAVZSiU05vh6jtIm8TRSp
 NoLXjXr1H1pcZ/vigA+10bIgVcFqmg+0BNSHKiPS5/J883g==
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id
 af79cd13be357-92e7b473836mr81358385a.69.1782907879348; 
 Wed, 01 Jul 2026 05:11:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id
 af79cd13be357-92e7b473836mr81353385a.69.1782907878920; 
 Wed, 01 Jul 2026 05:11:18 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f3611df020sm19794706d6.30.2026.07.01.05.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:11:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/3] hw/riscv/riscv-iommu.c: additional PTE checks
Date: Wed,  1 Jul 2026 09:11:08 -0300
Message-ID: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: igSHQ0tzOHN6H8s0i0HCaxRGavyiWLtb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfX3I/QGqeWtKZN
 Pml+tkwtBp1xJrNn93y+Q1sTQjQrbEXsFgySOufSEOAZ99sIXiYmTs5oabk0NapjpHLeLvke52B
 UDbfULncs7ThqsrpRgMMw1TCM1Dnxdk=
X-Proofpoint-ORIG-GUID: igSHQ0tzOHN6H8s0i0HCaxRGavyiWLtb
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4503e8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=br9rMvBsDiccbJdZmBUA:9 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfX1YGODpkgBsHZ
 LRPwuQvPJ9rJ+xn6hE1+uMG1dvxAncBBgkb7yKoJ7HNZyt7GCWWt+GYS8sHF9iMQDBQCInNlqub
 uDBkDF5AwygDOdrObYDobjOMMQf9TCeDRJS3XSEwAleQiQp8ZDVhxFznGO3IRp7w8V1yOt38/t3
 PXE1Y+fnmoHb6OOB6nmNxFKGl34OEavdOlxASqaVdHVRzRrsYPuPvK0K08ElTBReht3mKv/K9I+
 WPrNKWf+poBxIwn7ig/YAWYKUgMY8zI5KEb6UUzD9DLnYZ1UifKImdX91ClQZVNCi8aZGok3vNr
 JsY93bhzNko7oSRG6NGUolwv1mLqBjmxnmRwOWUaenUB+l9ijg00DgWkxt12JxvdzzRwaQmf9Kk
 SBjG1bQ1EzH7BK5GRk+UuwwO8hAuZWC0pP1FmE8Zp+mJ/9Na0R8qYmZhwY7QkmjYbelzDp9qouz
 RIYXp2wwmzNqGPRlmyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010128
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

Hi,

I'm sending a v2 because I just ended up fixed another iommu bug that
happened to be in the same code, and it has a test dependency with patch
2.  Sending it standalone will cause conflicts so I'm adding it in the
batch.

Patches 1 and 2 didn't change.  R-bs from Chao and Nutty were added in
both.

Patches based on alistair/riscv-to-apply.next.


Changes from v1:
- patch 3 (new):
  - add another PTE_U fault that we're missing (gitlab 3555)
- v1 link: https://lore.kernel.org/qemu-devel/20260629121334.567587-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (3):
  hw/riscv/riscv-iommu.c: check for reserved PTE bits
  hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access
  hw/riscv/riscv-iommu.c: fault for non-user PTE in G_STAGE

 hw/riscv/riscv-iommu.c               | 20 ++++++++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.43.0


