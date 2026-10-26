Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bvs29nSt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NRQbWbjG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRvT-0003Tj-7M; Mon, 26 Oct 2026 17:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvO-0003Sz-75
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvM-0005PJ-Hz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIooL74080948
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=L0iEkAhAdKPxwjzZiN7HMW
 aRADHlPeJhZjCTTujvLDY=; b=Bvs29nStEZIfS7saxcUY6SVVQh0j5hzWqfvWbX
 hzgbJxdoEAxpbBoakHgku5BaYfhyXvF+9AlYzt56BU+/0u1x1t6089LOQM8OMVHj
 tKAlYUhdDQlUox+UzuPfyggMYKKvKPUXchIKmpV4BmCbmjxNG2T5OZAPgrAguEUU
 XaRbtARTM3fSx3gdb69oTmvLd39JSSJYXlcaJrcQOBGrIOCbHTnlHwgONydfQxha
 +Dr5NyG3UE2DBhDXHWwLolpXyygRBC3t5x0lHy8FLeLWMLb7w8NKfUJrZDhsjJGI
 7PZqzAASIB+rw9aU9y0NJizoZxaJVZswBvIVihIja2lsKRvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2c2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a06da65d92so2036871b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048886; x=1793653686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L0iEkAhAdKPxwjzZiN7HMWaRADHlPeJhZjCTTujvLDY=;
 b=NRQbWbjGxYH9CJfH3hTn/W2apsJzPJdPyECOs/aB6vFe2x7B2FidiHPrj728DWO8z/
 26BBUQE6bEgP6yNvQFlhY9UXPOyBbqpaLi9GqQs/4NZ8n6gH/uVINgdJyrqYsb4N52Sq
 QXkQPtT24UDu9Y7KODN5s0TAis+ex2tbKV1KhdCp9AJZ0AIM8bRrR/iGRl6zYygcQuhv
 uocFgSeT6okJMLWlp62cvhOjiTJ8rLDAWrxwV0d4i4aAzgQY8NmRe9Zy+FUSWjIxWNFA
 ugoCatu9RibR6+Zf8/WkcmOmwbg4wuHKTuJGjufhpC5QI/YoD8JPZyMvDSCmDBil7pHv
 /UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048886; x=1793653686;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L0iEkAhAdKPxwjzZiN7HMWaRADHlPeJhZjCTTujvLDY=;
 b=EE1PvEqcIdKFu92UE3HlUxcCi8Rz+6mc1agjUR3SLWZvbfp16oD//XxhVmBvkwphCG
 Wh0MOowlBwTLiv13knhiLzxAornux/SRjawmfulNk0LXxOmeuQm18ey4efqt6ziF4C6l
 oA1uUqmthVAJWI5uiNuz4/OYcEpa2R1i84THkjGn5BBW5omziQfLgz/nw8sJj298ZJLI
 +ihVMGc0GQqCemp7w0XpfgxD0NTlU8OM31zG2hP4UdFRiiolTMeATWTfHc/ry5F5qD/K
 mIWWdZxEbcIFF3IJr72Nk/C3ykdHHjlWr/eNIuyjOpg4uLm490gTBZ0x+X1A50bPM2zp
 J3vA==
X-Gm-Message-State: AFq9FYJEN3MmtT1PPRU1av8iuJp2bwrgaXJYryokbAs0RTHLJt+EVT0P
 yhvomxUEH7dxneTYnI+FmWR8v9VS2NpEJk4NCM8PksKKMcy2u2SVfvID4kEZmloMGQ+HYTnHn0k
 FYpJYWS/DOnZHfQ9vzLl2daekb6w3By1syHgt/46zchdxI7rJ8uYmhe7Khtq9XrDztA==
X-Gm-Gg: AYBFou1RIlqIeg0lS3eJgu/jruUKy90F60v+dEL/eqYyn2BNC6zHeleKkT7w6H6CsDl
 cbxrMWtu9BRm866y6OBndInwUBLKX8h38xhlSVvO9Z01Kbz+JyqOltEsdfpgAAcphazZ2ErjfPb
 yuIN+JdrW8H/U/lTmnA8w1ZqlMfE0UGrtBod0aoPM6AwDb1mu5ynmIx43TB3NakXbUEuzdDqdvp
 ICQZkBd0M/psE0kpxC+t5Dwm7+ot0YZ21RuICauMZ7/FLCWwunR6o1YA9rZqBXexB7Xq1sC0XJW
 HY1rdtacuUCPksUy7bTajluncwS4oo9ZjiAjAcyGxIjbdf11xrD2hTYx7FjNWIBGnJJsUO/uNHA
 PtZjrgevdFgTguWw1Ys8/9YbtATXXB58KWYo6aL/IJvNM0HI2gF7NlXFEZ163Gq8=
X-Received: by 2002:a05:6a00:3a0b:b0:89f:ec29:913d with SMTP id
 d2e1a72fcca58-8a367a2ef22mr7152006b3a.16.1793048886010; 
 Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a0b:b0:89f:ec29:913d with SMTP id
 d2e1a72fcca58-8a367a2ef22mr7151981b3a.16.1793048885495; 
 Mon, 26 Oct 2026 14:08:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36bb2a2cesm1650508b3a.36.2026.10.26.14.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:08:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 0/2] releases: build and run any QEMU release easily!
Date: Mon, 26 Oct 2026 21:07:59 +0000
Message-ID: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX5nDpMUH2c4AB
 urFmo7ZiprGjUWp5gTeLa6FV0FGot9KKDsPc+FZZPz6VhkrxA7p8OUx6D4FzgpB3vng7L34dad1
 wNmKuaVmoFdHmC3X6adPrJ1EK0WunIc=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfc137 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DlUO2TMUbiEHNw8gdkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX4HdagFxYnR/A
 8Aye4sgN1sp9Aekdvnee/0lVsvgfxx/zS6GMWKP2xJZ86NR6erLwLwlqhThEdTHWFoXVQto+TxU
 YwTbm8R/mqRSwUO0UhU5WPAWdWcRaqhw7aAba7q5BYczEWxTIltc36sKRuBpzQLXDe1bOrq5D3w
 w3ZEottB/pZucp2OmjEZSsUT3n46zK/TGYNDtOxIL7RGuK6m0XArkGDO8L2mT7VsWCmx7Q8eDRN
 8NdqRumjCJP2K5isLVvGKED4s+/qYlmzj4TMRONzHLaZS/p4L3nfLVErctsioV3gVZ2j8tcNefc
 +uPjZ4iAdSvukYCB2p0Kxk7So/aBWdp/nZjpgbC0igJZvnlukeIeu6gYRXya8BRvXcb/9qJfip1
 QcogSqwbWmoKBBKChRJihI+8FersJlDCT0F73LGOD2qkmOy6RuQBrFLLHtr6rpZC2UajFnacGew
 p1widPTHxJBBDhpa7tw==
X-Proofpoint-GUID: bIWrgvuIy75xjZDF7gKG93RQPEiu7mmL
X-Proofpoint-ORIG-GUID: bIWrgvuIy75xjZDF7gKG93RQPEiu7mmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
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


