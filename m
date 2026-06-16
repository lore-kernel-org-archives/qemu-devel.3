Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EDFCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY1A-0007N7-1l; Tue, 16 Jun 2026 13:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY17-0007Lu-8s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:56:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY14-00030v-Uf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:56:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH91U13845349
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Gd/iIcj62a2+pXwvQQ5LoZbeOtYUldMrIwa
 J9NnEBD8=; b=YvfZTtCbfnf/IndzC+5k0iEMeH4KkB7YgYHkF8sc7NGFONdHtz2
 wsQ+f0IK6U2VUamFZsAsCJ+uFhSSLlMeL5JI/f2ebdxswhyjfONFQiil68Cas3NR
 MgPnPBKuq223JKUDdoOy6t2bqT1qTVBKomdx01o9EJGHGEwCH4Xa0eUw3Coch851
 xgkWUpXzsCCrDfsjDa6okUtV9g8zEDh/wwGsWt6jDOuymG/nJnrnz1qCP4H21T7b
 Eo4VxouDJDFaOI6HwxEtqqta+S5s38mbC6cZYlTp58AEjOG6SaaIgOwSMJyhy/Pz
 kWLcNib5Hl2V9OzJZ3V/b+f+nqOP2SWO5UQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu253jvmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:56:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c6b7c75550so2559195ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781632560; x=1782237360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gd/iIcj62a2+pXwvQQ5LoZbeOtYUldMrIwaJ9NnEBD8=;
 b=PxMZ0jV67Kz4OPrFi/HblknsG996sT3y4P6WajAVnIfpSVziVLNSEMQEt0wiXcYDQi
 sXkAcRdoLlQ8O4Gtfkx5dCsmeCVlvhYCTuXxe9p88kK6xgnZw6nNUUqwkpi5NpnfkIIA
 IOmiilNvc2ayl3tdlrmkuJB8ZH7zcIPUZdkM8LxBqSt5390LhdVhe9lAeA7+z/qD/4gW
 3PuoTCF0p9kXGtZpdKJLGwnG38HkNm04Ch1tJ/UL2C6+GQLnLHuAJP7xG4gf84P8faYH
 IXO/NiH6Korr743/JCQHYLL1MqPM9tL/h9OtJYSsGA794wOa4G4Y8WsErNfcy61Je34k
 ScnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632560; x=1782237360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd/iIcj62a2+pXwvQQ5LoZbeOtYUldMrIwaJ9NnEBD8=;
 b=AhC2spvAVwnxbDSK+HichWAevzgjDKDCf2LqAEpkkGfmM3oDuTbqe+Lc1gycQ1E9mZ
 fwlnBswF21jLyDDOCVVJbGNBDJyaKoHFq+GVUDo22p8CR1We6sp72jNgQ/9rCiabfMMh
 +bKyAEPogyPHk5Lp7vvFd5v5fDl1ki6Q2Tuv/pfNZxHioIftRr3BWQ0A8TvvtmB9PVgX
 q6zGZ42UkyHAq2rkuIZek3x+/VuztxZD6dWvZoFQw2mL7I3uggt3NuiHoI8HMCfTmlUg
 vXH5hucEMYPlWqdqQUeY/TiNi/bUg/3Mav9nRBkg5vnBVOu6wtYWwtLIiHrhRb6I0GL7
 Y1Cw==
X-Gm-Message-State: AOJu0Yw5z+7ebBLmWUHsAwV3TLzHL2JfjAv+mkRbzBXfxZ7AIYw3iQIX
 Y6Ecx9Q8YICOrj91j+dCwTuiH8d/ngYk2TqQ1GwrCf523LKfj/bFUHhMCEDjN/lQ2W94h0pgHML
 tq7jAMo3PF3rCLvncLOQEeM10tf9nCOidn6zsQ+A/FBjNd16gmZGgR0jRM7I81JIWgn/T
X-Gm-Gg: AfdE7cne/IydtACsZniL9kBms9txVoB2+UB8f2TdzLBi0cB4uIlBsEtvYJWu0rH2zRg
 7B1nLxF5w56kDa1R+ucTAJHMV/FoZRzdc0YziKwUzKLxxHvGwjVlK9IwjGODTFrrcKyl12LYY3I
 N5FaiXjLtqvwJ0ST30fABYZSHEUWGo22Uk2fIMQAvVybP5Ghp/tLJLmKJiZ1LpRXbvkkExaOEgy
 7wenPNInQDwEsfgTacbGCguQEjwfElZKt+OjYE79Rar6UqKSZpOyBFzLTJQ9m1UX9A+jjw778T/
 qSmro6/EPEddTcZFz4d8rvS17lC8ikWQ2TEaalgks3Hnfr/f75qpRjJJfLgiwQX2kWJy5q7xIyK
 4ULcRfivnttyIvf6pzjyZmKJ9r/fwZ5Z/pjiw8/qAfYuT/qE7TJWf5Of1H6ZHBFcmYtyoL/yMyT
 rk9my3WqM=
X-Received: by 2002:a17:902:f610:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2c6bbcae428mr1323465ad.0.1781632559718; 
 Tue, 16 Jun 2026 10:55:59 -0700 (PDT)
X-Received: by 2002:a17:902:f610:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2c6bbcae428mr1323135ad.0.1781632559285; 
 Tue, 16 Jun 2026 10:55:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac80asm125643945ad.39.2026.06.16.10.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:55:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docs update for 2026-06-16
Date: Tue, 16 Jun 2026 10:55:34 -0700
Message-ID: <20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0dhCbFBt78ZMLN8BANAAf8u-JjlVy_w8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX+l/gKaXqrFBB
 RTwrOmdsv5QFbcTG8aUiY/ZioAL6Xo4fUlLZswiEkd+d1FAbc4TcL8HPS5nlKa8rycvOAwifir0
 nMvQVniW8oqiSm7TvI7g8W4g/GRDw94=
X-Authority-Analysis: v=2.4 cv=WNdPmHsR c=1 sm=1 tr=0 ts=6a318e30 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=G-81AXr2r0-U5TI923EA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX41GxcH1rehHL
 gcTjvYXx0kMAc5THSrGxuXtCftEKjLyOe2oqHGLsjefEnPTvRbsiiznWTDvptsRVVxftSsp0Ub6
 Oy6RTZgbwfqfED4kRnuMzExgJGgihTYRlzpiVXuIUkIovxvqP5Ahsj+HeV2J5UBibjLySqfFido
 cWAYZ4bJTdvioz/pyxbuxDWqq+F5bpLEcCqfSwiUvJS7rz9yBrOUKa5i58+Xl6BQNdqYkbh2IRq
 LvgRcVZcMvs5NjOt4G2sdapvqxvPFtdzidYEKFDs7h6Rr0ZZ/Ut3w2uIktM0trw5iHPFhVY7o9Q
 /zEafYdMSJ0I3tNeCIZ2CNw9Fks5WtGc+TCS7AibYjhVHLrU78MHhVtla2CWJQ3zyeKuM81QFsx
 gKNoO6Py3bnYNcpY2PwaMKwDAYiZH0SQg7UgTrfPqiJzQqYHET4wnQ3TGKsFM9NJokZqDduqMEm
 OUqwxywww/ltg09ltHQ==
X-Proofpoint-ORIG-GUID: 0dhCbFBt78ZMLN8BANAAf8u-JjlVy_w8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160183
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

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260616

for you to fetch changes up to 717cd7bc7602323ef03ddd63046e66e20f17dcb6:

  add a note on -shim to direct kernel boot docs (2026-06-16 10:54:58 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2] add a note on -shim to direct kernel boot docs (Gerd Hoffmann <kraxel@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20260612161707.158029-1-kraxel@redhat.com

----------------------------------------------------------------
Gerd Hoffmann (1):
      add a note on -shim to direct kernel boot docs

 docs/system/linuxboot.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

