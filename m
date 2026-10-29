Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZtoENRfj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=daAZUSWb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDha-0001kQ-2n; Wed, 28 Oct 2026 20:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhY-0001jx-Ej
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhW-0000EN-Mw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMARKk1877999
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=c3IyP1lGIz5w07VSAlCb0w
 0D/uuqOqO+X97e0MGYzgU=; b=ZtoENRfjfDr3MBuotUn69xUiD6oQ8Hx8Hz6aHf
 7E1x1iOwLW/mR8dRNBiSNg9faS9Kn2cKYUlZ9eMQYRv4ee3G9nctubIwQ/jfv+2a
 OspkXM8V1FBTvEZOuKZ3i/eOZIjMeguG7n5vbJQOeU92MGlIUOb7sAjpWtkpAucY
 iR2uHwBJo5TaUjXQI8+TTo4kskWQGER6S90K7Wm878UZdDfY27RNsc9pXDGWuBob
 ItPG4BO57Y0UO/kfhU5GAdjOhTvkGt8zmj5KgKYpFxBPQ6JBHUO4D2xLfePxwkEX
 l8bx96rT4pJPwosbh1UaFoRIWdmEKmhuIMYVm3/5RVQt40aQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3n8fc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:08:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd6532dbd7bso938283a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232539; x=1793837339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c3IyP1lGIz5w07VSAlCb0w0D/uuqOqO+X97e0MGYzgU=;
 b=daAZUSWbiX9jedg1bqIpkFoHMdEEA7bFfra8kJYQEkTa1gDzYj6xef5XXYdmf7nVLl
 T/PN8grovc5OJwTU2fPVk9JhOdF9bFJUirgRjcvAsq3R7ov+phQjLT3Ix3IhYktP0V1/
 8irKKOJM5g8xEGUNFue+wGEAyhOlILRSRETN+82ymsVgWhXMP8qlIfJmFFSX8nrx6xYX
 7LFadg9fWZqdcWHpBGTtNxtKeRRGwZWCmZfxr1hs6IhzkyzslcvyR7ClQHbgMjvoqfHD
 L4LmhfuVhO/LESjeVe11+1jLxSJnH/hNHauASmWUoQIobLVNISUc1uqkj2WyCmTdg4Nn
 bAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232539; x=1793837339;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c3IyP1lGIz5w07VSAlCb0w0D/uuqOqO+X97e0MGYzgU=;
 b=I+ZDebPFE1A5x4fqmqn1ZxwQTpIS9NPhkRrUnVrHEAgJC7ZRBWcHTsLSckVTktYONa
 tkd7qspy5iLymaD3rjyS2NoisJA4k4JD4u02r8BDUJm8RW84FiEa4G8tp7uMWq/1z1ua
 /Xy4fPv3uGpRWRu2Y5iH9E3IDZAEHudIK20/KTogokmFczKvdpW2X9JLiyWH26Dhud0j
 nIdF0EDJXmV9pRMji3ERBsPNFoeh32WwmC2rxrf64NPy2W/lSuquxESUJyxfDhEB/G6+
 aU2bpGkHqjGWTU1+bj8QpUL6bVD50EQ/fzLDOz3pJlO4c1kRlnNpSJHFXb2S87du9/JR
 gqKg==
X-Gm-Message-State: AFq9FYL3cCEGaU+wUfK3LOf++Hg7hdy8OY7+t6dGMdbsb80hHaFdUvlw
 ximfPtf2sZZLlvRq22ntr6Ysgfli6cwDvgmJ4baBEOMXA7r4tJJJ4Ob4kpf/o3dBw9gv+52onq/
 2F6Oe3Nq/Si0peoZyAonprCEcNLhXbpIlN79/mTJ2GEovBqM394crEJq4Ks/a/Cy2ng==
X-Gm-Gg: AYBFou220pRxu144pnH1trJRm+2i+yKJB4Sh5wTfBKZ6U9RcdOgze7wwnjNixCKjftH
 l7+nYHGq8rY0IQRX3vhmCCGFGMNad8HMRcP+J1Y7SZGVd14ejnfDyoUeeXZYge+bIL3QA16ptk4
 DdHZ8vfjkgPG+nYGr8tLnDBr/xxYvZY01S+ZaQUqNdZPW4eCO10uhARkaDj+rPoeyMBeuqPTUv2
 UEvaysWHLzX9LNm5G+w9+uhhw2N3iHLyn8yiHsDpVjfbmhX4ZyySvqV5nLNpkEFq0HenHqyHTWp
 iKH+Dezbfd5ls+q8N9KGU7kIplgZr5DtiRPeK8d2kBK+Zzdces+pcJbv3zD76t98DXQsA6FnzRu
 H4c/cKR3bIatsdwloni5teLtNHLBoAOhWXcqvk7Os5VM+culGspXfvwkLQlFCQ4/8hBx5aNQ4uw
 RNG0wt8gdU2sTwk5CifbWjZbUMJl/Rr/O/hmOQ
X-Received: by 2002:a05:6a21:4c03:b0:3e2:a935:8bc4 with SMTP id
 adf61e73a8af0-3e9022ab951mr3341384637.13.1793232539144; 
 Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c03:b0:3e2:a935:8bc4 with SMTP id
 adf61e73a8af0-3e9022ab951mr3341362637.13.1793232538645; 
 Wed, 28 Oct 2026 17:08:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc682d8sm4644744a12.18.2026.10.28.17.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 17:08:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 0/2] releases: build and run any QEMU release easily!
Date: Thu, 29 Oct 2026 00:08:51 +0000
Message-ID: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _0r_fFonKQbimOlnYeMWyKRxgKtGtL69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX8danyMiJe+6o
 hWmIrmW+aBimlwdMOzKCQCNi+6m8h+6XxJAJpVN8yxtV3a8dz4oBfPwi4fa8tCSg8EOFahhSs7Z
 Ci20+nTPv67bR0Lo64SDYVsIrOkV2EFOBEMWiEqbHd3XBBUNbOjz6unwH7k6nZV83Rt1K96UCCr
 +VaY9WQ7yfBW5d9d4jAp24mEsgBEESdFgNh57oMDDG5aPbf68y5wX/PXiEDfz+xvxSbKB7Bii7b
 I1MRTvbb02rVv6MWCPCRSJajaO7YgLVFhcm+dD7wIAxdHXIr9q6GGS3iSCj8GCbURvVSSpz60jG
 X1k4jZiOdf9Tlg+snXmWALg9vCta9yHesGX2zlNoGtNhqggoPYEhPhqeDF+7P1oOwkasvQHjHYm
 5rVLWZPVh34Cxlb8y5xyWHGRocO0/z7YyAPSwfIzgOtyAOnV+NnG+Qp3hifb52Dc7UzETab7p0o
 buoNtyPFds/ZH5H6q8w==
X-Proofpoint-GUID: _0r_fFonKQbimOlnYeMWyKRxgKtGtL69
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae28e9b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX0WJVLn5OprZ0
 K09LXkKaLR6mfuXEuJ10IGMNDBvOfKLEJbR50xzVcuTs9v90YZixuE03BX61fR6LvcAfeOy9X1x
 ofk0AAzIeTgxAqe6UxjkLiM+TwHx3LE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290000
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

v5
--

- fix build with docker (missing context)

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


