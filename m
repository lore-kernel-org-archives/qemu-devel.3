Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE3CC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PWb-0000vx-BU; Wed, 09 Sep 2026 17:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWZ-0000vc-NW
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4PWX-0000V7-Ic
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:08:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIElQ2195986
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 21:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NBFXTawJFBfGX/1STSOs3Llh5052l9w32gR
 ZP3mKSIQ=; b=VfTChepwn8WE/sobkiS1EkAC/SwNqdkrj6CHZ6keZIENiO7mmU+
 hOZoCaaA5G4V1pKh+l+uvVbjxH+x5f4T/Ghp2wVQBSYVNJGW7RAO6xE2LbpAfV9i
 uDoswE+I7LCCFmAJ58tRIeSdYH3KIRPcbGceizlrO8/WZufRlHgUEJVm/kfwikTv
 SUIRzk73uIypxO6AoviCM8Tw15DPirByOvXxDQccW8tBGjsYHmRKTQ9ovWm2rPsF
 DaL3iqjIhRQWZ130Q/sEm00eEqMxo2yo4pJCyTtqd7HseOz2fxigTlp0kvlVeblw
 +gPVrDk1hjly1GG3e6yS6xjvH9XcWiNasvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyegk04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 21:08:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e4f946461so1153713185a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788988082; x=1789592882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NBFXTawJFBfGX/1STSOs3Llh5052l9w32gRZP3mKSIQ=;
 b=VvN5ne9P3TLF7ariU0U6MP9IuMAvzXXTmf2/j6kudOkJsM3WaxbOVf6cRY2hTNj/qZ
 SVJ+Mpg+zZkcRHHekHn1wlVoom1H3BNo3dHinJ0Q/iI286PCRMlR3isAQ5nam91d/SZB
 l3JCYwqDiycC6tRhMzvibvB6bFW5L8Xbi6/FKkJTndvHB7ExVUUXSGZphlQ5Q/3Q7vpu
 aASvbi9XcBK2got+CYgKBt8wO6LdDy1qgTOW6oF1Lh0QeSsZx9WAgtJ9cZuvs8PioAvd
 JIyrQaX0GM6RzG5/A3mqqJ9/DGeGXDyR+FkBgX0sxyE7/jqgwejakaCpW1i/JSy3h4RL
 5dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988082; x=1789592882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NBFXTawJFBfGX/1STSOs3Llh5052l9w32gRZP3mKSIQ=;
 b=avQZClxSZ8Zx3pe7lx20ViLgUlc41Upd+fkZlkJRuaoVzy+1MwExUSGCv8+vDso2eT
 JL7RNZxWE79ClGPkrudLox0D9A6EA5Riqi0xLcy/9BB2QSu50Mk0puRB3On8XPkrbWS6
 JullOIYrhx9BK2YA0MHI9xeorRbf52F/LqhY8Z1VubOJHN+AslYIDCAkg6CS/+lzWm43
 vA/O8w9xBAlpNkenqcn9ybrK5q2a+598XtMcSUWnwREhIIhZz8qU/VRvYH/t0zZC7RQC
 aKZx4cWONMOs042pK/tzesMnypO134pOzsdcNhgMsGFXzw9v3o6IWAYrF+cKYNoLZWFy
 ERxw==
X-Gm-Message-State: AFuF++lLT2yBhb0NzYpJUObKT4Mh2ErWeBXrWDrfRwB3CoqvwKQ/daSW
 ZQbvBuvkBvB6UKhnBIka5R+NhLlumEy5Giv/ITkFd/PpxyEFWsZMs7DHn7q+VdUZwgG6OcI7rHl
 odKuWdl2XnBIWGxcF6FuWv1dSS9vQr3/7yHtTryLwSnHhBbToJvVaDl/gLXbwe6GC5w==
X-Gm-Gg: AYBFou0pE8TmyeFbeftRirhf1JVIkXq4OsaS2PzWVQ6PTJB5ThgMs631mnXRotVJTxM
 wGk6gGZgyY3vw+5rwX589IZNDy5WrIzEKEqbWSo9+DyalU63XU+fArewyZX8aoAM7cnfQlT7a9R
 CAWontB030lcLnw00+xqPDQpH5sO5WttKmNApM4alF61p16EgXubFHJLYgpIfQjgOVRwU56VKfo
 9WzcosC/VKu85z1ac1BtSlydbeVFfPydYBggns2tDNt+fiSTMraaCBUqoGFSwCJm+rr15sVwdAA
 IMNZaimSuUbvnvySvvlLoF66xpkErZPPKKUfOLaSYgM3VaBAvgUtVMUGAHc3YEIBNxsSyt16yyh
 zPFMWQnS7Ts4zEsdu7KhiJGZeL6Od9bpAVtDJ
X-Received: by 2002:a05:620a:29d4:b0:934:9524:2e89 with SMTP id
 af79cd13be357-939c93ce8ebmr1139828885a.13.1788988081901; 
 Wed, 09 Sep 2026 14:08:01 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:934:9524:2e89 with SMTP id
 af79cd13be357-939c93ce8ebmr1139821185a.13.1788988081343; 
 Wed, 09 Sep 2026 14:08:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040646d59sm151811336d6.8.2026.09.09.14.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:08:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v11 0/5] hw/riscv: Server Platform Reference Board 
Date: Wed,  9 Sep 2026 18:07:50 -0300
Message-ID: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfX2lZSKn3eDzqL
 pGnHzzCUBC70ZVVTR9AfXLzRXxsTkgYYnJecxFZqYNWnPXsclKdeESBE1KYZOn7aTgHsj4LwACF
 d2mW8hiFhANnt2UPxLrhMdtzwOBesZ0=
X-Proofpoint-GUID: LYXeEznnPVZ1i6Iezdvkif-eIEfnfFni
X-Proofpoint-ORIG-GUID: LYXeEznnPVZ1i6Iezdvkif-eIEfnfFni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzNyBTYWx0ZWRfX8791NplpCFDC
 nWagNOvyvsEJhyZMJGoEJok00DQdbbCL8PoT9m5Ql6pgDlZmzhpEGNQ6VWllmezLJnxF5AfwlgG
 bTZkhFCdhsINRRKYZQGL579fTVLyOUWrE++ekVQgQpk+Ge794H11LVhPKvgXHLMDORk4U4EpXsE
 DsR0EpPuAvXPHf+4voW8x70T3OPltbt69S7K7NiOIIJe2yqX176uQAl2YMMnopFy0BKwQQ5jG9g
 Wal/jozWdJZ/iLvKwIpUCSQk3HuLqEjbxGNsFwNpXtRgIJB1xt1LoLpXkCQfv+4FfFnJa6rWXrY
 zOnrWCcmi7FsHJpeRapC/SDLAZkphHvVDRBSOXRmUEeKNqelqyGM3+A5QRSzFm+euy8tM3q2xAI
 w3f0UyiFZhr4uEqtCe40pQ1ewPey/fNXK7OtpmN5HJjxFDm9O6RNJQiBjXdzMrYzkVCgVafyyU3
 +GLfEMklYBjRD1zXrcQ==
X-Authority-Analysis: v=2.4 cv=Go/XaU1C c=1 sm=1 tr=0 ts=6aa1cab3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=x26-pumYbLzhefK_VDgA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090237
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Greetings,

This version has review changes proposed by Drew in v10.

Most notable change is that we're now defaulting s->aia_guests to 5.
Users can set a different value N using the already existing "aia_guests"
machine option:

"-M riscv-server-ref,aia-guests=N"

Docs were also updated.  We're now commiting to do a new board version
for every riscv-server-ref spec release. 

Patches are based on top of sdext-v9 patches:

"[PATCH v9 0/7] riscv: add initial sdext support"


Changes from v10:
- patch 2:
  - added sdext as dependency
  - renamed profile to "riscv-server-ref-1.0"
  - reworded profile comment
- patch 3:
  - added RVSERVER_IRQCHIP_DEFAULT_AIA_GUESTS macro, default value = 5
  - s->aia_guests is now set to 5 by default.  Users can set a different
    value for testing purposes using "-M riscv-server-ref,aia-guests=N"
  - fixed whitespace issues
- patch 5:
  - reworded the "versioning" paragraph to make it clear that every new
    riscv-server-ref spec version will trigger a new version of the
    riscv-server-ref board
- v10 link: https://lore.kernel.org/qemu-devel/20260904195610.964829-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (5):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  target/riscv: add riscv-server-ref CPU
  hw/riscv: server platform reference machine
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/riscv-server-ref.rst      |  65 ++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |  16 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 790 ++++++++++++++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  33 +-
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_opensbi.py    |   4 +
 tests/functional/riscv64/test_server_ref.py |  88 +++
 11 files changed, 1001 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


