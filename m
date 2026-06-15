Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674E4CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSi-0008B2-9H; Mon, 15 Jun 2026 13:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSh-0008Ab-Bg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSf-0006kP-Me
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFi7qJ1015136
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PZhP7nXrqBbGaN4cUBVhHa
 upJTw/0NN86zD2NFNs638=; b=daiX+biqo7zKDXGg8n+q8XGyPQ49dS1HVEMPoZ
 ncwMrPH4ZdI8ABxG2ON1E0XsgjlqQcSM5hXnDLMs9wJspJJ1ZbgF1rf0y7oW1nsS
 G783//f0KR39hqAxE5j84A3WaxBWZVarsdOxb/iXoHW1/RePH8vYUFd2wyX5Hwaf
 6Io/Y+6pkFTUlJFPghsvPrdpFEGj5a1IyfFaA5wxB7AIZpxa4SNNRjBH8n/OmSl/
 sFjvtafiL9D+PQ6jpLHctJ+4ompH2Wpu5oxOaCgc8I+H0cSgnmWuHAfbtgzon7AY
 /X9lE80+hklE1HJWaysLiWKtO5wzDTBJItiny2h5aOupMeOg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2camqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3075fa5a407so6592302eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545860; x=1782150660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZhP7nXrqBbGaN4cUBVhHaupJTw/0NN86zD2NFNs638=;
 b=GIOgZ5b+s2gqUsDPicBZnh/cAMHvUMkuexCnp8rFJCBtk/R2RgvBd8ReyYML0Wf+PQ
 9vNhw7cCj8wVy1/MQ8BXcDAJr3JuN8ImOsyviUjcwO0SHGdoFtV3m82T6wSEg0vF8BYk
 E5S/ERygnBHZVmBCzmAqmWGKa0ADnjSh8K92XAIBetpKXlehtA5IO2NcdOBHL7l1UJPN
 fay5FM3OWq/xZUxmNqopvlc7uSGDhVfuNtFYjFnLQQinokscgEM75Elw821BUuJgsOm4
 ORsFiHs53J70DWsBPgyjDrCsXajkQQExMtTvaGFv1B67ZRkToLV1iXbf58jDnr7S964L
 XqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545860; x=1782150660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZhP7nXrqBbGaN4cUBVhHaupJTw/0NN86zD2NFNs638=;
 b=mFTW0VR4caPio+HhmayQJBaHHpeSRKa42Li0RPpDDoc5Sp4CGvR81JhvRYyo/bGeql
 EV3t2PeWVUtfv4aJf/SMn+02ELWfOJYfksFfRmkKkUcar7s/PZdaFqnWRQq3DcGvs+os
 DI/X4rxDcmOszv09iarAPrm9MlPVV/hbGh2dI2w7F/Q+q7kuN9XIDatzn9v8eTRbnqi+
 WxIXiggg3WXBvADMszGyNZZ4Ya3dDBcet4pipYeat80XNZB7IM/O0aSa27qfkzPuGTNu
 ul0kvCFzJG9gzVXg4mKtJWA3Mb3Gy3ID396sgrTot+ZJPy5k5gaZ312yQhNTEexn8cIq
 2PUA==
X-Gm-Message-State: AOJu0YwGC0eJGERenUj6ubkbrP8U7NuSTlUN0c+VA3+vElM8g8yaaHAo
 UdwAtnRGioKkr6FZwGLmJbMSk1/hKaFa2J3j7RKMXHFSFTPopC9EEti2AJMH5MBjRmEKb47tSuJ
 jDCYe3ObpQ1Z+7+CwqdYWy3OOh4xqltqe4ZZm26fa+ASOsfQxAh6PflTHQWM8yu1VPM6l
X-Gm-Gg: Acq92OHwYZ8nqcKNoZkE3pyBzjnOgyU0+Ozv3DSsjeg5XH64+7nIZyy1fIJhIriRDdi
 21Hpb5bPm8YLJ4lNIPzgsv9wgw0H8NN5Tnd65Vmd14h2ziHiR9XAiZhv8oFe7JharcnGGwWZH8A
 VZgnUlJ6idV39ifMiTAx3Rzq8s6cQuOOiLVH3WnraoRpZVqaoCQg+Acf8wdowaR5+9wVNmSTG0c
 no251rX9WQqwBWYqVT5gVhmrAr1AzSi9wPVwGLCVSjMrHPM0gVfZPirJZyDwIzXtN+GT3Rfi+Zq
 dBcRqO30H/rl9BaFmYQxcQ5imixMY1QagbcvzIKnIAPmC/brYBVgzA5LdxEr9B5Nyn9lIAbkc+m
 4z8Q/tT0ZLvGOyf3ab6F31CDDDvbtKpoDc/ht4l36Wx07EuWqJ/S7ajw61n9BO7iJ2j4whYSu9X
 4PUNLa4g==
X-Received: by 2002:a05:7300:818c:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-3093816c7cemr6508085eec.3.1781545859597; 
 Mon, 15 Jun 2026 10:50:59 -0700 (PDT)
X-Received: by 2002:a05:7300:818c:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-3093816c7cemr6508056eec.3.1781545859002; 
 Mon, 15 Jun 2026 10:50:59 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:50:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/5] Tests dockerfiles update for 2026-06-15
Date: Mon, 15 Jun 2026 10:50:47 -0700
Message-ID: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX5o7/r0twTNDG
 BJjAEJPv0KZ9fp/egX1JO/hLA3Yd1eZfzG86VfOIFPmMs/p8U2qjbKZnnbumx6wOJElQYLZInUJ
 78ixVv/8I4KhUR+WvEBLx8LwIb0XJmxZt8VZ7dSRbfRwLpZxZsW8Djyey3xOOFiPnRy/0mIB67p
 DeUq0ZrBKWPqmQAqZUoyXNn9yq8yLN6F7x08ys/jbuPmGyO6Xu9Z5zqu36oR4F8zXgoyjl6K58h
 ESlF5RacbsDGROh1BgndTAUgOnBU/0URUNLObvN7QIFDFlGRWHGskYtG2QvwxXONuxrikDMve5b
 /ZaNC/y68jfhbmirJcNWjEF6RU1WiyldPQqQwWynOAHA9SPYlE7oo6s4sxRWesjzgIfjpoa7CJH
 dn/bpCKVLHDTJDD7e2y+B901Zx599+y5v+T1hVMWyRXbZCvcYUw9SptIysmSCYS5ITSFWWY20I8
 OTyXCpbD5IRLHNy91ag==
X-Proofpoint-ORIG-GUID: 3umKo-H2dGE3ecgTZJ_ZxJEh0gmAv0Y_
X-Proofpoint-GUID: 3umKo-H2dGE3ecgTZJ_ZxJEh0gmAv0Y_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX2SKDEvh4iRAO
 M33/T5sclIhkijYFVIqM6/I3kpZPbQroF90aubhm8Nwyytsu2WliDFRoCH7eVio65u9L+TNL8LR
 svzVctJjFoeQywGKt65uE5fXaX/Z3xo=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a303b84 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BNV-J5ga8a3nNd8L63MA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:

  Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tests-20260615

for you to fetch changes up to 2750ff8d21a8eda2ad872b5bf97810de737b5c01:

  tests: remove ubuntu2204 container (2026-06-15 10:50:03 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/5] tests: update ubuntu2204 to ubuntu2404 (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (5):
      net/af-xdp.c: maybe-uninitialized warning with gcov build on ubuntu2404
      tests: add ubuntu 2404
      docs: update mention to ubuntu2204
      ci: update to ubuntu2404
      tests: remove ubuntu2204 container

 .gitlab-ci.d/buildtest.yml                               | 16 ++++++++--------
 .gitlab-ci.d/containers.yml                              |  6 +++---
 docs/devel/testing/main.rst                              |  4 ++--
 net/af-xdp.c                                             |  2 +-
 .../dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} | 12 ++++++++----
 tests/lcitool/refresh                                    |  8 +++-----
 6 files changed, 25 insertions(+), 23 deletions(-)
 rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)

