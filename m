Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEFDCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVb-0002tO-Sk; Wed, 10 Jun 2026 15:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVZ-0002sN-5l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVV-0008Or-Vq
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJIkG52438327
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sYk5WTmfajFjwWgI9Gdmyi
 tQpj7sjy49cmn4l3W4A2c=; b=TALz/MnDi1hBxl2jErH3v7Y8mbb1fci5LZUm+m
 R0nSJsVNrOmteQ7ARMMmVl7dMr3tzNqi/u4ohCDDJDZYWm5iU/S16aqqC7mv0qD0
 pP/PE3AdeiMyEcV5aMT+TYdViD4Qk9jtodRkgE4JE0S50E4aPgxWZkxcMph8ZB/X
 IsX9MDjr/bJTM18rPlnZ9uP7FdogTYe/Nkf4Ma9zDsmU0thCH2x1aJZGgXM8Xrb5
 wDaJoozhv46Gi3I0MX84FnRB6Iuv2woAJbY7kjBGkrA+1cGfNMa2HRFAS6gxOE02
 9o8LJgZRfCGziG7KI2T0xi8Rqj7SAWlYvhhSJ/k2Yq0jN86w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvkxnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307625ee07fso9663047eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119351; x=1781724151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sYk5WTmfajFjwWgI9GdmyitQpj7sjy49cmn4l3W4A2c=;
 b=D5mwTlDPjTWLQf4/QVzhQAfQpFxmCjNuWUbqXilPdFUyHQjytzsXyBNLJUUmo4oJQo
 w9MgLtme3NcM8tKP68iYV27ok3AwencsQqigEZDtZkDUF0FqFECs7vIx4QGpPFu3sFq1
 V7MwO4HPgAvkQvBwFwW/88ml5Hh0NxrkPymDakYUVBvagTvNRTskPbYIxt0IgvrfXzTz
 iUt+TMpoMh66o8w/BpCREROf7ZQGUoU+wv0gUhzpWsdyLlzZUnZOglu+1cGHdbWf/c02
 r0F6cbxAF5r6pCq8I01Qkh2MNhmkf1+2AyqZckIoTh4xJlaeQgeAY//aMVmE/5ZUb5+p
 K3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119351; x=1781724151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYk5WTmfajFjwWgI9GdmyitQpj7sjy49cmn4l3W4A2c=;
 b=H96jVNXOk4yCzQuuX4L7I0R3asIvNLC+QT3mdvKUYWyMC30kS5gDb9c1TlVxNJBmqs
 +E5XYoEdsLbYxdFmr+JoY3/27pwfpxe43r2Gm74i3i19M5PvBFcd8QUbEosC8lb8uFLV
 +z8l4D8iWIGiKrHTU59g+XdxvjlC3pZSs4ad/5y9w1/rkZs0fTpu4P9ooCPNswrVOoC/
 Quv6qlyFgfVlFfuqsELdgBS6urcOzymHQ5V4ERylwZEcqhXbFZ3DVPBivQtNjs1VJuGN
 FNB/KOr/0EmMjUk2BZ+fccDSm9aP6xyFAqpKLSWhxjDTwYO7PSaf10uK9eu5L8nwtObM
 HgIw==
X-Gm-Message-State: AOJu0YxT3YSldYI2pyPYqC4kg2grJFY0eBEXL2gKLE1eZzIQ6f0NTMLS
 LDSRckMfytOZvrfIy1WZ+lsnZ66fp5nvf9OBLnn6TEQ0qvhNfWWQ1LOfwwSK1NcryN/RmGFN3be
 SOSG7owCuz22PS5ksGsswECLWfhmExDndfpgD1XLgPJJFm7oTnjSn9SfiMRN8Zm60lrlb
X-Gm-Gg: Acq92OGXqR9+j/241BiHmKV8QPOWl7rfynLjcPAtMmRs/oJ4v3Fkz6r0FvFfAEkqM3Y
 Qg7RBUdvuZZ+ByDU/tveySv4TPq6eeRwkrOKI2HoDk5YN4JbMO6WxbHKclC6BJpDbAUCcKcv0BM
 geS1O33ABFrERXZjqC127LhWm1nyZDOkmTMVu8qq5ao0VOMcF686KFLdBjQMQcr7jz67JLvfO4D
 Alg3G3WEZ9+P8J5TkFHbFFic6cegGOpOyvLzyxCeGKbSAqmDipfhu4F0/mfr1W0fO6u99Tv3Nrr
 jIGzHNwvNKiBMkSez7f0BXwZKE8Y9pGhSFI7OmFr8mRU8MfBkaU1sGh1/hSk9GRo9OkmeWsST6J
 JhlF1hOFx3XsKSDh+auApFI7W44McUiZgioV3rmNjTh3nH4QxkOsET4yef1v/z6HZ4FThWV33y2
 3pTYg6CQezveMqv/o3
X-Received: by 2002:a05:7300:3c04:b0:304:641b:12fd with SMTP id
 5a478bee46e88-307ff61a686mr362330eec.27.1781119350635; 
 Wed, 10 Jun 2026 12:22:30 -0700 (PDT)
X-Received: by 2002:a05:7300:3c04:b0:304:641b:12fd with SMTP id
 5a478bee46e88-307ff61a686mr362295eec.27.1781119350066; 
 Wed, 10 Jun 2026 12:22:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 0/5] tests: update ubuntu2204 to ubuntu2404
Date: Wed, 10 Jun 2026 12:22:17 -0700
Message-ID: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vRwnED3eHvR7nR-wN12zg0fkUPLy3SeG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfX5zVjyPRyat1U
 WNiTMxX7/EhjRxUELTpaDLv+G1Nejcm5wRuzBeguTENLJ5cvuqfQ0zkNkG04ypSbjbD+C0IUGkh
 pQKbNwiMJ5PJBbLs1tVPfAPe+DB7YnvpK6b2UL0nUPKXIIezPSvrP1PIZWeebUOmUkBPJCfELos
 beA7OQg+bLo2A/ZBTs5LiQgnFXgjNBRmweirDzgyRUzciJ2fC1ZvTGWB5ZuWm0Da3spv/0aMiFr
 dH9ulAROXqN6MlwjH/8dghr0LRnNIATccTZ4bf0/lYWQ1tTGjgyigGQrWMZ+0jtLCngFwaD5QZl
 SeOoDtiLB5rWR1nQzWax/82eR2PSEGt3BkNiAypbOYHogSBNUI05npL+cpUYyM8+hVcb4E41ExU
 BNDOaqaiBB2lh2/H0fEqzKfRhWT3GXbMfXJTE73EdXYXTvFSg5gg8b9pIhzRse144dT61kDBnY9
 E0fvVUDmnofvBjGEyDg==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a29b977 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9MlDViEfR6zZWpE_CGcA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: vRwnED3eHvR7nR-wN12zg0fkUPLy3SeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Ubuntu 26.04 LTS is now available since April 2026.
If I followed correctly, we support latest two LTS releases, so we should be
able to update. If not, feel free to correct me :).

v2
--

- edit warning fix patch to explain in description why it's a false positive.
- edit doc patch to mention all host images s

Pierrick Bouvier (5):
  net/af-xdp.c: maybe-uninitialized warning with gcov build on
    ubuntu2404
  tests: add ubuntu 2404
  docs: update mention to ubuntu2204
  ci: update to ubuntu2404
  tests: remove ubuntu2204 container

 .gitlab-ci.d/buildtest.yml                       | 16 ++++++++--------
 .gitlab-ci.d/containers.yml                      |  6 +++---
 docs/devel/testing/main.rst                      |  4 ++--
 net/af-xdp.c                                     |  2 +-
 .../{ubuntu2204.docker => ubuntu2404.docker}     | 12 ++++++++----
 tests/lcitool/refresh                            |  8 +++-----
 6 files changed, 25 insertions(+), 23 deletions(-)
 rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)

-- 
2.43.0


