Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6306FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluEb-0001bf-3E; Mon, 20 Jul 2026 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEV-0001YL-Ln
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluET-00059O-B6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:04:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTcem447391
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=f1e280bgkCGDK9rlp+pEWq4IjPoQXpiKT+b
 x1YWsm0k=; b=mHvxt5Yb2g51mSmfG1GiLaWKmGe3mmSD8ert+0Sg7iOzJKGAET9
 lHy5gpcdyObs8+h7MNfZFIJiW6mBHSh/MozC9fSu9TA/rLZYtMCHskqXSh02yPDF
 xkWK7bno6h3m5O4PVOIO8xhyw9e9VKSXdN0c8qQ8m18km01wxkh4GGZRStxX+d8L
 lxSUSyr3TzCeQYNyljLaFF4vh2JCEgE7FJ5ThAoJ1j4Nbs3gpRa/FPLfs/3LunWG
 wroiXDP7DgW8uVhzw+XGCTeYst1kR1MippZMqKIt+E6pnLIm1j1TfI2kB5/Ir4cl
 w3MAoFQ5g4jV3wqQaBC+QzUqbz6QCnMoWew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5rp8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so6668741a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577894; x=1785182694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1e280bgkCGDK9rlp+pEWq4IjPoQXpiKT+bx1YWsm0k=;
 b=XI1bKqbPPcui/AxU+DeK6F+bPKNE1p/JHChfxKJ6t55CN3FGjJDM3bVaS7vknfnV19
 SGGPmRS/0zQzLOjtZE5Uk0anluA9foDxTyFURwTBCZnRKoAWeMSz6zSpfK0NpFzCJtyj
 tub7k0jgrVVFBpbBJMTh3ShYzCIPfgZ2uSmPgFSKO4jR+y/rT3eRM5M+dFPbWb0eTHS0
 vpTAcl0UpML1cv4MKgRYWiseE/iZCA9F/5rddEGJSNi4fCI81JD7hYwnWz/wDzqFLjp7
 NPvQTJEzrK4W3aJm0md6J8CxPLVbE00LbItbviIsvFvHGMzSaO6uoYBlu1g0bTkR6xBr
 kCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577894; x=1785182694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1e280bgkCGDK9rlp+pEWq4IjPoQXpiKT+bx1YWsm0k=;
 b=cE3x4HWdKKuZJjNZR9B74ATEPW4iuszeW6ZtRrJIsC9wwXGtv0LE05nndvBArcnR+j
 sGirBWyk7roDDA6f67vrzQ9euQVfk0EP7uANhT9TdxWQb9P5u2QlZa2FPLFnM8XODyEC
 iD9L3VeRVjUWiyvV/gD7mHJMPN/cv2zNtQKoG2ZjjsTmB+6TScn4SNquEA5s21SbBN0c
 nORqiVuOxRsxjMTyukRflLp6JrhUzwyv8FW92hLEZg949XZ5jcG80G1kFwaR2eLyD10k
 3WVEWGNd2+/zB9DwBrQbU2WBTGa719SUMtN7u3r1WGXnXPGI+MuttUmGZqPkMEi/BbaS
 KjQg==
X-Gm-Message-State: AOJu0YwAg1ksQPistQ7ZOzPoRkkjZE1S4Z5p7IZ9iF20qdJ6PCKGhGZj
 TC9i5TQht68F5U7xKexbGuL1RcZipStsBAk4p9BenAQI/aBsXtUrWGc1ytoCd9/0bAzOif53jCT
 tjU0CNSAOKh/sY427WDMc24q7IZtGtiu7UBtl9qTtrD0RdsAk9/2sx0yfgfJOAO4iiQ==
X-Gm-Gg: AfdE7cnHjCu3qEAwFbRyCyIxgaIx1AawnDsDjhkBDXCLotzS4OjBGLR7uWCL9WAL0Is
 XT83C9QPpAZURxcHaVwduhCuOXbdwyfZJPZ5ncwI3Y63jX7LnYh4l7u++nUX3rHTRzf4VmfUHQD
 J0xPyJSvyztuZw1KJFpgrrbgo/ZlAWNk0f8i4AS23iPUmWQZFK1cPfyMP2OLjYQD497tKEQbmF2
 sFNXWLDidZbNKTFinDMGoBBgXL3Et6StzwKUQt+VWQCR31L2bTKLv3rxbmOJpNbjZE+U8cw5XLx
 NZTUaNax0QqeWiSlY8xGXf22nYrw2Bv7BCX59J0vwEQGWcg9F0p6H/KkVS04IdQY+KoiDg1atzX
 WG9PNBmPnf+Tv6HGjoNoRAPEddXTAoYk7ecqYSG6P74+Lya8xEQT2piqEXq3slS4nN6mEDGk=
X-Received: by 2002:a05:6a21:7d06:b0:3bf:a698:ce4d with SMTP id
 adf61e73a8af0-3c3ada8281fmr16436223637.54.1784577894152; 
 Mon, 20 Jul 2026 13:04:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d06:b0:3bf:a698:ce4d with SMTP id
 adf61e73a8af0-3c3ada8281fmr16436190637.54.1784577893691; 
 Mon, 20 Jul 2026 13:04:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dd90fsm38487229eec.22.2026.07.20.13.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:04:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] Plugins fixes 2026-07-20
Date: Mon, 20 Jul 2026 13:04:44 -0700
Message-ID: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: StWCyR-hQ4tBATbA5aX8aN3KR9SBqI-N
X-Proofpoint-ORIG-GUID: StWCyR-hQ4tBATbA5aX8aN3KR9SBqI-N
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e7f66 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=TK5EyZ6kyjgOOmnKNUoA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfXz23rvmpc20Ax
 4N9TyqT0QoPA18gQ/3LsHp0bBSlNys4rcDzGHWQcFxWC4nqufCTt7cEODUZeGd8H1Q8MQFH+E1G
 +wRH2xhY25O+dYzBq7U3gpOr4/4epnk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX8gbS4PPvC5uG
 B5m+oOjiyf/2BxGMGh4P902WL4KB5V1s30LIeAGoO/FWuO9qWiQOGuh2xeS/z41iPODi8hcbiZx
 4bE5E5X3u7X6CfSmIBC2RT8sEfngKwkgpealMEfvAasSoa2cO3HNSXfqR3QZViwFG+ku64vry9y
 R3wvemftoVrJ1N8dp0zsQAkmhI49+sCj3Oz9QmWbZV1p+9AQqViucEFE3pEVlgZfNowfiW++1vo
 i1NSWMZI4NzzY7GAKcE0vJq0d2Ow5fSsc8qpbJQ9Wyb+6SJWp0p5/BMUEnikDEmdtfDXrtP5661
 5ETVKinWthMp8MB/5XMaPS+L3ZtrCH8mGvurHggbXnqhyclnEM45WIoDYXfzcn87NkJA493Yqdi
 7kPfsS4DDFllbWCSHCUDA87SxzuIPwzDzfidFbWwLMmEj29s55YpnewlmeUd02nJkbrT3H/XPJJ
 9XDZlC5lFiVgYHJEFtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200219
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit bd6079a7a1d14de0918a7715ef6db85dc32de3bb:

  Merge tag 'next-pull-request' of https://gitlab.com/peterx/qemu into staging (2026-07-20 11:12:38 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260720

for you to fetch changes up to 533c98e769c79bcef56c6e466c4f3cb4c195181e:

  docs/about/emulation: sharpen the dlcall boundary and its guest requirements (2026-07-20 13:03:14 -0700)

----------------------------------------------------------------
Changes:
- [PATCH 0/3] dlcall: correct the syscall number claim and the guest (Ziyang Zhang <functioner@sjtu.edu.cn>)
  Link: https://lore.kernel.org/qemu-devel/20260719074730.1520517-1-functioner@sjtu.edu.cn

----------------------------------------------------------------
Ziyang Zhang (3):
      contrib/plugins/dlcall: correct the syscall number claim, note the data model
      tests/tcg: correct why the magic syscall number is safe here
      docs/about/emulation: sharpen the dlcall boundary and its guest requirements

 contrib/plugins/dlcall.c                         | 32 +++++++++++++++++-------
 docs/about/emulation.rst                         | 31 +++++++++++++++--------
 tests/tcg/multiarch/test-plugin-syscall-filter.c |  9 ++++---
 3 files changed, 50 insertions(+), 22 deletions(-)

