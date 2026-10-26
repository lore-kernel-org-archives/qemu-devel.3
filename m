Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD650606A336
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C4MbfEIQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZvG4XbmI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRuz-0003KV-Dm; Mon, 26 Oct 2026 17:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRuu-0003Gn-Ax
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRus-0005Ni-B4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoh4T4131808
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=L0iEkAhAdKPxwjzZiN7HMW
 aRADHlPeJhZjCTTujvLDY=; b=C4MbfEIQ6yaIxor7OdIqHRiRGnxNFz+j6/x+07
 dmyhgJwMfhLHJ0lWNFrPq1PKeTVB26vMX74aANvkeAjSxlriXTTZGahzxuM3kO2i
 LOqqDJYdXbCE7rRVErWAd3pzlVU/NNwo8XiRigUjQId5lifqLo+DyVQYQYAlzOoA
 VVD1xQciOHP1n7dPBXIqGFeM7mP0S/jtFkm+0/Z7zhcCXWKIOj4KYhZNxE/tqnf3
 FM6DroD7LMgMZbdstGf2hTZ88oxXbGNtEdC4SPqhnwvuXuo8s+05YJvxoHuVh/VZ
 L2TMJHvK0ViyEXD2PBIAXsSYybgVFkJlJQlahyf8mQmLw0xw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xsva6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so3270564a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048855; x=1793653655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L0iEkAhAdKPxwjzZiN7HMWaRADHlPeJhZjCTTujvLDY=;
 b=ZvG4XbmIShLL5/cH/8jMmxgEaVNUWqio3U2mizMMAUL7fwQiUaFt6Ij5PDMY/PLwnV
 GfB7rF9Qt+IKHpVFrUAswasZbBcP3sRVaIL9faZxqsJpLtiaz4nFzOTNXhgXYbG7zRtE
 qJGYQxi3ljsnTyYqV44JteA/d90JCnhLbSWrhqQFO9LycGh5w72oyhYSTXfGme/dbcUl
 Wbgpg6o06Zk8Ghpz9hRIk8NO/BEcEAyyVsHHmoXMn2we3RGfk4VMh9dHBRz1J71JCMBz
 HCq6MySHU9O1r/8BkTQx4Te+vAhFzCZm4xG02p4nusQtTQDhwWhx81A6Nw4Q2phSqpI1
 8XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048855; x=1793653655;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L0iEkAhAdKPxwjzZiN7HMWaRADHlPeJhZjCTTujvLDY=;
 b=UelmmYh2PV0UYsGDe3arNfz3rvH9FxaZLqcwr2fsrUirHhTEiBnDnJZ2Zt1y9mO96A
 XWHumqc6XqhXRksBK7LuigQUoZSFl1hy6SdBosQdf7fajdsc+kcfSR7uKd5V2KlySNUa
 mUqHPvfOPxo+Dal2RJHru/vh4iX+jABtf/GbkcAWYg9+1crEpMJ2ag61gwvNACBy+FKW
 CqKkCkD3uDJiuEFS3n34A2aFJEu6zUN+CsnduPN5UP9k/Ma5DK2tUgHiwdeVwG8js+pI
 JullzileduenhUoE21/XHHtWWgn3lj6TSMrrhoPhGCfswOl4ToqUy2BFWnN9JD+RAIpu
 iutg==
X-Gm-Message-State: AFq9FYJBQ/t6bVy6oxN9AXsrlvz4s+HCR4yy2tJkI2yg7+bVEXG6fiI4
 d8RGCD1yaAFto3yDYpGYaXTiT7ssWHHEK4jK2WX4S0HDvFUyZGoGMKSR4awiIdgtpMR9m+jRIfn
 NsBEkWf++5zZUWDz3309H0Nt7irpdtOz2A/UK4ncLXZx1htSlqizhmz67XUhEJyR7yA==
X-Gm-Gg: AYBFou3a62gGXpmjh6OhptCDREOVKoCvAxM9XROKtxPaa8AbISNGKjJgd3Y5ULxTMWN
 fM9J7Xmqd3MG0Fqh5W6rqrwc70YCvPYDjfrue6sWua3CP2iygcSeF3YmqrYniWIqgvQSjSSDWsI
 PalCv4bTjitaQGUE0HQy5kG3aWVB/ZpAEJneSitbDFkzEw8RLniCGxTHjbevaf6d+/uGYoV1Oz+
 Q/gwwLK2WYS3rTwrbWfcPVqlf27klsFNHNaZepikhx4LdyNe1p7UhTiBKN23dWNKtB1gmBbxkJf
 +ghVUZL4h17/JXz7YVnVpUb5wuGb0PptVIIGQLpUTrUfs78XIV8qwxFZhyPu3pYpQwzU2G9OeKv
 UJSAXwdaS7mJKyQKMi9d1B5wmNoLZlK01zRu0u53iaXRiRoLk05VOGJGkqFuzFm8=
X-Received: by 2002:a17:90b:2542:b0:3ac:adce:60a8 with SMTP id
 98e67ed59e1d1-3ade9b2cf27mr6499245a91.5.1793048855125; 
 Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2542:b0:3ac:adce:60a8 with SMTP id
 98e67ed59e1d1-3ade9b2cf27mr6499228a91.5.1793048854576; 
 Mon, 26 Oct 2026 14:07:34 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0dda7sm6421185a91.4.2026.10.26.14.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:07:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/2] releases: build and run any QEMU release easily!
Date: Mon, 26 Oct 2026 21:07:17 +0000
Message-ID: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jie-XilPXC4c4WJiSrAlzE3bA9dr8_km
X-Proofpoint-GUID: Jie-XilPXC4c4WJiSrAlzE3bA9dr8_km
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adfc117 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX4QeIP1WDfRxB
 0qG7msh+qV8Bhi/p1MPeiJ+76FTFmTHH9c82tcaLAOlxB87HCUqBYemqDwm8dd6M/bJYT4WwRWL
 6QG9+Ml5N157nrhyCT4SRFXq+Ff1mEHzxMKFRdGb/p7Wr0mVhqvI3D7NFePfb+VmA/lc+EeuVb+
 wDGzy1HzB18jc0qBp5D9ZDbHv6/ZD63igGv3ncrSCPxlwm5YxI1mDDWWxqO2laMME3L7trXhc0Y
 igks9rjbOIVmRSPK1D/Qgbz/ZT+BCwOyLd3LG+jBtaL6j7ZrOkIJbuEA4Y0r9P9ReWEx6WE41e/
 9rX2AOtvveP3LiJ1CdO65BEFhRoHPWlvqhgvEaPBjpV6cdoPLTj7kWUcBoX9VSXm5FKTl6MgZJU
 lU+KyRC7JT105h5Gm9TMUdAOTf0jBf+Z71+N95Nn++EC7U0z1uJOtFqePHt5qEnaMa94S4xhRr/
 l+hwlAbablOhIOzV9gQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX7DQQzj6ZKJJV
 gVW+83Yoo3M+L4ZZHcWRBtI3c6ypZq0y6Miv+uc0I3uarSV8v8NnfDx3Dl/GCiGLO9vZlRh5SPE
 4L257pD1uVTA5iKUI3i27ZBP3PQGvfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series was inspired by a recent post from Fabiano to provide container
images for migration tests:
https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c

The idea to be able to build and run any QEMU (past) release with containers was
in my mind for some time, so I gave it a shot. Finally, it was easier than
expected to obtain a single dockerfile (with a few hacks) that works over all
our releases.

Images have the absolute minimal content possible. It's only qemu binaries,
artifacts (roms, keymap, ...), and libraries. There is no shell or any other
tool included. As a result, images have a size from 581MB (v3.1.0) to 1.1GB
(v11.1.2).

This series adds:
- a unique dockerfile to build any QEMU release. User has to provide an explicit
  Ubuntu version when building a given QEMU version.
- A script build_release_container.sh which automatically detects which ubuntu
  version a given release should be buildable on (based on date). It works
  great, and the heuristic works for all our versions.

TLDR:
$ ./scripts/build_release_container.sh v3.1.0
$ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version

v4
--

- supports build for any version (tag or sha-1)
- adds an optional parameter to build_release_container.sh to use an alternative
  URL for QEMU repo
- simplified Dockerfile by supporting any version >= 3.1.0.
- removed patch 3 generating wrappers to published docker images

v3
--

- extend dockerfile to support ubuntu 12.04, and lower older revision we can
  build from v1.6.1 to v0.12.0.

v2
--

- fix generate_release_links.sh: was missing userns option for podman
- dockerfile: cleanup "|| true" and replaced with proper ifs

Pierrick Bouvier (2):
  tests/docker/dockerfiles: add release.docker
  scripts: add build_release_container.sh

 scripts/build_release_container.sh      | 63 +++++++++++++++++++++++++
 tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 scripts/build_release_container.sh
 create mode 100644 tests/docker/dockerfiles/release.docker

-- 
2.43.0


