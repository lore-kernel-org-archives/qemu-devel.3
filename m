Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D7C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDdG-0002FZ-Fo; Tue, 07 Jul 2026 17:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdF-0002FJ-26
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdD-0003KU-CM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5DII495468
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CK/SMNA6e5/xtJ0NNW+hGQ
 3UrlQM4xOOV8F941wHnwo=; b=eMbRBzk7yPOg/uanZtM8GhB3o7Wd6yeophts3i
 eLRKjO8HVAg7Z5/8DdRtVSsg7iGxgihd0S0NthvQ+TF6og8K7sKyTV20T2YK3mJq
 x/wLL40UXbXtM3a0UtpQ2XV3qU4N/AhWUhWHACZFbqiN+Skcnug9pAL52DHa/iRs
 cQ8yslfd3K9EC+V7IO559Quv75ok2BbIBZMr0YPDyNWMxjQI0U8eBdm3bwF774OJ
 DHrRdtosDD+65ElF+c3UQSgnkDM+YRNoIZkk0V7ZJJTXeAOUOoCzvqOcKHbvpdr2
 v2prf/Tgf0RgE7eTY4YAOLvDuDeQ1eX1pOvGw9GaIVyFmPBg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0jwu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:47:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so2301295ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460823; x=1784065623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CK/SMNA6e5/xtJ0NNW+hGQ3UrlQM4xOOV8F941wHnwo=;
 b=dAt9q+fyCFveYKaGR38NYTf8sxWIE1GP69umn99zu+l175ShyBoo8mCQQt/NYQ1T+S
 QMZjJOqXXttz6VjLe/jviVlYkMDvsHMRT1EpVbPf4hAScKu7puquDLIIXE9+VW6Pxqt2
 8UM0uxLvFhRBgbyP6kK3qK6PXu1he1sFwCeGcbCx9OX2Zi8z6IQi5vrin7Jr1J+S+xuH
 RBCJ51jneO4GyNfIOVW7JuTMlQOeDbNOp8P70Ef49xGy3wHhm9n8AKxmyqK0IWZKu7A5
 YrZdGM5//lp17hRg3VELxxMalQ8NswqowKrgP/G3ls+k8p8TLYysltnm5Bglv3L5hB0d
 I7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460823; x=1784065623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CK/SMNA6e5/xtJ0NNW+hGQ3UrlQM4xOOV8F941wHnwo=;
 b=UqBzTGd907O/ocMHXJfNCXrb+p801WQHouOKWQoOiKzRvUE8MDS4T+b93Ud3nPqkwK
 5ZIHrD3nvYVeC4N8jrNxdOZZzGVxTQIbSxNodTLwjenQRTn3OhbERVup+e2iCwcNxOwm
 czA3JYagp70k2eO91xMVxvObt5EjPXvu9RXhPCyvBUY3ewtc1/Dck9G5efNoBxO1JEXu
 inkp6o26vPsT5+MtUm98VrJ+pKVCG7vbAITX/qCD4kdAuRKPuuIhd83WMqYma++6WXSW
 vbtLiDwcNdQjhAPeDKSw09cDE5LOhiQk+I/0ewYgHTF7LLTpXk3hbkBlR2/YemROLMvG
 MRwg==
X-Gm-Message-State: AOJu0Yx+ukadA9xt36M3eCnjvLcTWyf+sCa0iWT+Qm5jVBi/uCqBk5ig
 hhqL8UEYLn8gwBCLlzwRsOfEhLY+eLXZTj5qs7AW1MO+fBCLzeT2OQAmRCoa0qmkmRBwgNb7E61
 ymteOGfjT4A4vxjeaSyA+X4vsKdjDjbouQuPnqZSTVmEyS7JzkPHILcZqv3iEGyr77Q==
X-Gm-Gg: AfdE7clUi6lr1sWkdCmtqEboC687LiXQ+CbY3iP/gDrzjezQpBoIBuFJJ9H67Ngyz0N
 2R/cir8qHo3AvoDamMBYXjv8wt8cInX6JAFwXQe8o4S3hgub9skIuZ4ebkYASavsfo6wU0t7fRc
 Vph9QC/HY0k2VwzTAS4TvOwK3Uc3wMgMiQjtC+jSHNXzKmkhcVPo6YWsdYZYG3cce7YV+aakWqy
 6wHalmuB2EMis04FpmKE0TZfHyEVUv1SFR1Fh7lcHJ1NURyKFGOcQfgJ5A8EuwsdeWliBpht2p+
 py9WaEJ/EF8DAscq/jDeohCe0p37kC13pDmdF30MmQ2SZtiy9KveQkcR1zbPlt2YBN5N+BaJRNx
 njCVWtTJYSHh4cli+iJrLFhnC/w/tdv16pDBDOKm360J3Nbox5kQEquG4GtQ/K/d+BsOGfh9+
X-Received: by 2002:a17:902:d508:b0:2ca:12aa:a395 with SMTP id
 d9443c01a7336-2ccbeb1baafmr63296925ad.17.1783460822758; 
 Tue, 07 Jul 2026 14:47:02 -0700 (PDT)
X-Received: by 2002:a17:902:d508:b0:2ca:12aa:a395 with SMTP id
 d9443c01a7336-2ccbeb1baafmr63296815ad.17.1783460822324; 
 Tue, 07 Jul 2026 14:47:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdcbe2sm18368045ad.9.2026.07.07.14.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 14:47:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
Subject: [PATCH 0/4] tests/docker/dockerfiles: add missing apt update
Date: Tue,  7 Jul 2026 14:46:51 -0700
Message-ID: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LCArZOq618YAZtV4quMVT_do_1zeeI3a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX3oZHdeSlwEHt
 T4pBRBQbyZRGwsWDQPOVTrC3Ogi5mIujzfEECMRb82Agk8KTwTIxyAh0yvf/o0UfiDUdpsG2uv+
 up4de1bdPbGj/sFYcSU4Rby6iFvAOJE=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d73d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=n6MYwUk4AAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=hEjqGYFSoslTsHafNF4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LCArZOq618YAZtV4quMVT_do_1zeeI3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX2oPOyYVaq6b/
 62V8sTUyX7dZnb9pPsyyFZMf+HeuAVDK6UjM0lPaQi8d823l7tgFwN0dbRSP62rWPm8L7o1wCTN
 NURtw5A+5PVeEwxbA22pHXMyxzi6B++covhkO5MOhhxVLkLilny0YoriQD8zEs14l3i0RvvLOBf
 REvB3b7YW7gk396XfEZ4otOMSfq71vGBA7AtUCrlqtDhEpVF2D9HWUeboDq1NfdkMZunAli8TS+
 LBuyrtmtJ8/fCkSdO4JFgIQb/dC2si3K9cAOt0GVBKZGLxO4qNL5QDaffbLbXBc1/s04yQT94/l
 NTWw3YRq2sSVTK70DBDjhv4TNN3k3sFDTaRKE+90H8GeGyeC+jyF8Q+2rcwMOduoOP39ldivscT
 c9/lxzowwGxfRtZ+iD6h2P+YXVgAIZQncSsN0wfDf0afOdXC8WYlazRRy9KWinu0lb5dbh5R0JL
 5woTbaM2mFSQ6dFU8xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070213
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

Some of our dockerfiles include custom statements, and those are missing
explicit apt update when doing an apt install.

Since docker caches layers when building an image, not including an apt update
may result in error, since packages file will not be up to date.
This is also documented in official docker documentation:
https://docs.docker.com/build/building/best-practices/#apt-get

This issue was first reported on:
https://lore.kernel.org/qemu-devel/4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org/

Pierrick Bouvier (4):
  tests/lcitool/refresh: use raw string literal for trailers
  tests/docker/dockerfiles/ubuntu2404.docker: add missing apt update
  tests/docker/dockerfiles/debian.docker: add missing apt update
  tests/docker/dockerfiles/debian-all-test-cross.docker: add missing apt
    update

 .../dockerfiles/debian-all-test-cross.docker  |   4 +-
 tests/docker/dockerfiles/debian.docker        |   3 +-
 tests/docker/dockerfiles/ubuntu2404.docker    |   3 +-
 tests/lcitool/refresh                         | 213 +++++++++---------
 4 files changed, 116 insertions(+), 107 deletions(-)

-- 
2.47.3


