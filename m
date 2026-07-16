Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B7C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJf-0002g4-82; Thu, 16 Jul 2026 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJd-0002ez-6b
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJb-00072n-8K
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiX9O2475200
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+oAze4cUfSL3vuANzXriaZ70Ab+PghsQ5YC
 6/ca/oTs=; b=mr9pMzLL6ikigLU+r/eEWvF57f8BQTQCEy+afFGDq/tCy9OoBpA
 +bulDbCyy6/vjihZhFKO91CTw+SRTS2+K41uQy3r5YV0yAPM+2qYRE+cR3MwcafZ
 geUED9p/NMHB5PYE1H21Yj518QuiPedPGW/xo/WoeGwbMLw4GIaEVCNq6GQ2Jlkg
 hd/f4kxKugTjwkm7AobzaYAxLGoVCVEzxwVjjG6ebKQfPMhpJ/SUYFEo1NbLRgsC
 KJva0I1B4n9masiUyJF+fC2zMn44B2uMzksxQj9x0rOr+mVONIrQ4Z8Tuggx/lgI
 3QdAjNwUjR+9Hv0kPhrKuLN9QFiTV17rnYg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7sccs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8fdace20927so36900796d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205343; x=1784810143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+oAze4cUfSL3vuANzXriaZ70Ab+PghsQ5YC6/ca/oTs=;
 b=Xddae1ZPpd8CmGkpX6CAhS4o+e86KOa+SqiFZ3tRnE19Va3D2Jp+Oa0iVmWjgaudAT
 YI6Rl2NE08aSCLSGck55jXcn9qYVJXJOGDAw0lJJNRSoLbIyANuqioGbLq44dFfm6m9/
 4jAKNtcKDO16sJbJWL1knrr4sCsdRu65WZSykKGgFXGflPGJriSDN8EUY+EYUVdq8LUS
 qEdK5JVSMWx3BBu79Dj9HOInOd09innNNNkTE1Jxd6+uovZkQb2AhVj+X5rq534pEzBd
 H0bySywJjet8HToJ/5mPe7D6US+RUy3HHULFgOKIlDtMP+Ch6LK0KsDf3oOdPn4jTMSE
 gjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205343; x=1784810143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+oAze4cUfSL3vuANzXriaZ70Ab+PghsQ5YC6/ca/oTs=;
 b=BnMaR7nO913Npqpb9dTm/Y4+WTCcbcxvrLLWMpnQtqoH+qtflJwD8Hq9Q3mrDLkhKU
 T0OnvldV8PycDeFgwztmpeecEkdWI9CitbCaFHq44rk4v4QA3GAnWDACtqKnG6mBiwPv
 ZraiXbTXemCwit/93JL64jm3puRxiJQuIq3L2XDoxW1Ie5lZKjyfnwsh/piJVNLJvIwj
 9SfUnaUT1US3OZTQubTCzV9y3vuaHRsx6Cjixi1MA8C9b481WdHll1ma/d+zD7C1EIkG
 V0PIcqOqdwvfBt0VYGdXMoNiyvgiWnYlKCEzdxFN7O7tPZky93Ui6TyF/LLtNr8PPn6t
 hHNA==
X-Gm-Message-State: AOJu0YyUVoIWN13oFYWessLMDi6q9HaKT+fMr4lZ+v7+JgHfVi2y5LFe
 6UZunEO7WMN2ESbuUXyoyJDtJVL7vtv28Vs45qjz5zlybR2F9LF3xTAJEZ18PiOhs3KWdNpFrYP
 UHN/2N4zjxK5cfDfaHRjYmchXpQmM7dJYk1zQnzwKGEmGjNnaehRW9JVjLyfbAHODAQ==
X-Gm-Gg: AfdE7cmQTlSHpUzGA7/iu8LxXdpBr791L9uvbfDaRxF+TclRniAqSXwHIALzNgo9ynT
 Vz+z+zois6rzN8h1uEG816KJvaq/OEXR47plB+80lZGaedExncz9Jd6SGChF0FPpYYKKgjolmLj
 SJ0ztYUm8lzywpGFxhthUL5jNisnaIIrKB8zoTNLMay8LFPCQjt1Rbx2DMl5Zio4Qqeto1IU4Ie
 Baj3Oj98MoW3E3KIYj5QqbYk7Ee/nyalENtc4UGl4mV+RfZiOcZIYdahphFEbSUs/orv8GLTC6w
 E/rGQuqzt7tzS/pLjtjXKKaCUTLc3Io3wB6+YmODpmUJbgrUX8oqStZcjcRa46nNelV3anZu9Cw
 uDmccs+6KjpSk75XXyWEEl8oO1zg+/hvHRtU=
X-Received: by 2002:a05:6214:5e12:b0:8e9:f62b:8fa0 with SMTP id
 6a1803df08f44-90401d69c74mr229565576d6.53.1784205342990; 
 Thu, 16 Jul 2026 05:35:42 -0700 (PDT)
X-Received: by 2002:a05:6214:5e12:b0:8e9:f62b:8fa0 with SMTP id
 6a1803df08f44-90401d69c74mr229564926d6.53.1784205342388; 
 Thu, 16 Jul 2026 05:35:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:35:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH for-11.1 00/17] target/riscv: Nick's debug fixes for 11.1
Date: Thu, 16 Jul 2026 09:35:17 -0300
Message-ID: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX97r+3f/jgSdC
 hiXtv+tI4X+L/+vZaxQzXJFtlZtPS2Z27F0cAk9PHb7x08lzqXNngteYH3pTzhXJntzEUl2Vygx
 tDjTF8OKhxqY8KC85hQrYp2PlfegKHo=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58d020 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Bu3byT1gSwfub-_dy3EA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX3GilhCvDiseY
 jYUtoJNDVBtC0zTOOnQc8Xk1RDM4n+iq5sxn6sSguggMIdSYU8JjaNSjESfvvYmGlDHNj/Gobz0
 RKFatwk7yEN8NthwO0G0iHutuHSpb4HYVwBLBSHg1rOUrz/7Xx5X3BO9l8TTO8zgLzYaWD5imcM
 vW8QmlYnthRHEpmZlHerss+qe7mo8+R2FQSGhz2F7WwBbWtQ4DAmy4s0aVN/ttVOgZW0gC2wgtx
 2E+RWmRYEirwqeDqtEl0+ocMu2TaoxZj8R+RAktcC/lH3o0CzVFPKKNlpL0ZNnbWHWCgoriS8m2
 O3iIWKALL/R9J96YnUnIBgBc4fDnrZ9L3PmMNs0K44Zww9znGqaR9Bt6zmWPeggcGbVI+xfqt99
 LkAC5AWuqODIW3zFFn2kj//ZMPsZ/3SLQrZyAbJ9qC0kpW9xHrhI7q6exzPiCVjxgwR2zf71uiY
 rpvE/NnS8pL8d2EDZUw==
X-Proofpoint-ORIG-GUID: x-yN40yhQPR13rkmAesHyJ36xayaT4sp
X-Proofpoint-GUID: x-yN40yhQPR13rkmAesHyJ36xayaT4sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160129
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

Nick sent a RFC with several debug fixes and some new features back in
January:

https://lore.kernel.org/qemu-devel/20260114044701.1173347-1-npiggin@gmail.com/

I took all the bug fixes in that RFC, rebased and I'm now sending for
11.1 upstreaming.  All patches are fixing something that is currently
broken, with the adequate "Fixes" tag, so I'm comfortable in sending all
of them for 11.1.

Mister Chao, if you could take a quick look in these that would be
terrific (you have acked patches 1-4 already).  This is the first step
to finally upstream your sdext work.  Next step is to split debug 0.13
and 1.0 support, which I am going to do by maybe taking some of Nick's
work in that RFC, maybe with some new stuff, and then we'll add your
sdext on top of the 1.0 codebase.  This is all 11.2 business that,
hopefully, we'll get queued and ready to go as soon as the 11.2 window
opens.


All patches acked. Patches based on master.


Nicholas Piggin (17):
  target/riscv/debug: Check only mcontrol triggers for break/watchpoint
    matching
  target/riscv/debug: Handle changing trigger types
  target/riscv/debug: Implement permissive type unavailable trigger
  target/riscv/debug: Fix icount trigger privilege check
  target/riscv/debug: Update itrigger_enabled after changing privilege
  target/riscv/debug: Implement get_trigger_action for icount type
    trigger
  target/riscv/debug: Fix icount privilege matching icount_enabled()
    test
  target/riscv/debug: Implement icount trigger textra matching
  target/riscv/debug: Maintain itrigger_enabled in
    helper_itrigger_match()
  target/riscv/debug: Fix breakpoint matching action
  target/riscv/debug: Put mcontrol load/store match address into tval
  target/riscv/debug: Remove breakpoints on reset
  target/riscv/debug: Fix migration post_load icount_enabled() test
  target/riscv/debug: Insert breakpoints after migration
  target/riscv/debug: Advertise icount trigger type in tinfo
  target/riscv/debug: Reset trigger type to unavailable
  target/riscv/debug: Fix minor comment typos

 target/riscv/machine.c        |  13 +-
 target/riscv/tcg/cpu_helper.c |   7 +
 target/riscv/tcg/debug.c      | 326 ++++++++++++++++++++++------------
 target/riscv/tcg/debug.h      |   5 +-
 4 files changed, 229 insertions(+), 122 deletions(-)

-- 
2.43.0


