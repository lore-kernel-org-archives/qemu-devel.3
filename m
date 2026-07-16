Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DCBC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSDw-0000rd-7J; Thu, 16 Jul 2026 15:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSDq-0000ph-VB
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:58:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSDp-0000K4-2J
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:58:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJp7le3792736
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3kNU5qvo10iMoS3oJMk2DX
 /BgTlnwND31hrGgfsuG7Y=; b=Bw/nP5d8oiyxAtDjQJnp66QtCxE4YT8NIBcXux
 ZM4CETMnseuqS1EQycaTR6Mn/c9sLP83sctSc5pskQUsPsxno27jHcaQ4Epls1JK
 gV4O32WUgd3UaQYPsH3r0SCAG9seqY++xLkz/x7fWheh57/n8YgMcb+3bCZjfsre
 i9NE722WF7pIJmC/SVxsamXlY7R+Hn+IEXwRLUfchc+jDi0EqnniSIxF+ENK3pA+
 qgIuUYxYyB839uDXWIUbI0cqYPoFjpnTTJ2v6mSy+/EU9kOFysQyz3hOzvWoIQ3T
 bxX5/kwXbbO2kMjuiZpD0c0n3vtJQ4xaPEuJpbyJkcwHv6eg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1twb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:58:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cd01a14e81so102849485ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231895; x=1784836695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3kNU5qvo10iMoS3oJMk2DX/BgTlnwND31hrGgfsuG7Y=;
 b=E5DYyJm4G7vHLK9G2yf38oNrjdN4G2SJ8eO3NSfyPkaIZROwx2GzAX6lKuxPyzGpFk
 0zGJ0WFSe9p2KsQXfibFmOwTs8kfNmafl1KuB8cxXY/oHZMasa97QxZniLgin1gpnEZ6
 7toMJ84meTFt4n03PJcKExAwR+t+7R+jF3k33R+QaUkNN/hS3gWY2U+siXVU+P+i1wD/
 Qo55KUCEfO08MAuC2aLJp0qH+wtJxjZk4kBCUuK5iPGsrX4rwnW2hPU2m9Yi2y20HlUf
 zu0300op2prFdY/gl34rbgrgIXUhcfNFKh/z0waKLhtvKh44xh3dnsSYk6VHPKx4ROXb
 PLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231895; x=1784836695;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3kNU5qvo10iMoS3oJMk2DX/BgTlnwND31hrGgfsuG7Y=;
 b=PRlRFj/eIfDHBwCeudkX7Tn7uD3SX5A3z7L5NZkR1vTUbgEFSSKR4pA4bIh/0+C740
 /BXXx06DUMT3dRxXPLBFNrZ+axzZOEGqnbkyv6wKAjM3aIl6wfzBLUal0Rs1rjIgZd6Z
 0oj1RGLDecJhfSmDi16WF9LPlCRkWSDnK9fGJ8EY1ohJRPpof6MU2im4mPghlSXN/AN0
 NHKEwpkQ9o4/4fmSiW+h32j/X7AKx6LTa/iS3p2cTMKH3NCVAVclBQb3qALFerJG/lhm
 tnvzK3U50ePj5lbtxZVqltD0o6ti10GhENCLHhknUN1WGMmPlrsvKiKmTBlXjs95GBSJ
 3YPw==
X-Gm-Message-State: AOJu0YxPoG2by/zRn55QZ9JAevL8rphheMFBmK5SUHL22xhwsfK4h4Eg
 u+UTCB71wCH0SC8OH+uDj8aEEBhHhUXV7Sna/6yx4tudhJPSEf8vUYR7LvKU5Q5n9Jugwrrv47i
 zkXXtZBnGWcCAvcS35Fi1etjXp5D3+JC49R9Bunci/Z7w5eurQ21EBp7F2YSlzuk0FQ==
X-Gm-Gg: AfdE7ckvhan/A6AFPZI3KSgXwR7Hbl9Ldcsw8oHmhaBQwJE/1HZOCqEz+yCPCnBJl6s
 Bjq/J2UG16QmV07gg1pH6lG8iEup9F5dlIUrjwohUxZu0i3II6K9jybMuf6PrMAudFSEKXP9Obe
 Mwc4KigeTAsUruDOouA+AYxwmGCk8gjmjoYLZXLoP1A922++4WhGqEgfoJ8k3g3hoEob9fPAJGy
 qXP+GRB2Dx1Rpz/KQ2AOZWp1n+gMRDx6PGOWTAB8sMsDSVm1V/HRhlKvngeh9jndcjvkykyRZhu
 CCdetzGsnAipj3nZ1KYIAygIxccZ0+NF9A3KKR7AJAe6P87nE2AOMANd2x/uk0akWG37P0eyD4q
 ckh7/LaMYGVJhSECTMxnBBjqfNQyw0hU35UNRttd1itK/LASN4hjbR+28j/rZAgnWMiLKLdo=
X-Received: by 2002:a17:90b:588d:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-38e2a0300a8mr8294989a91.16.1784231894898; 
 Thu, 16 Jul 2026 12:58:14 -0700 (PDT)
X-Received: by 2002:a17:90b:588d:b0:37f:d9dc:557 with SMTP id
 98e67ed59e1d1-38e2a0300a8mr8294957a91.16.1784231894340; 
 Thu, 16 Jul 2026 12:58:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c23c0sm14140471eec.24.2026.07.16.12.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:58:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docker fixes for 2026-07-16
Date: Thu, 16 Jul 2026 12:58:06 -0700
Message-ID: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfX5GAB6mURVnXi
 iw2WcBtrrCWGlrYV3DlNi90xXMHExPktvLM5xBaj0h/yIucqerAOH0mukA4jGNiouEN+O4ZS75h
 /QWM2oYT6rzKJDzQamcpBmxLmJki1H//s8OxiqQ5+VjUzkCY9Cz25lnig80Wxui4A91O4bmtK4H
 /3X9i2QUjC1LcmqHePQFy1QmRObfYRQKbmucyRfPaUKWT6kzRVHF83D8g6rqUsKvRlmf6cOueWk
 SXIUp4E6Y0b8F9ctaCZ4CY+6U+z98xcCPo2JwodD3uat//oFwoTokR8bxSwH8laDTg8VrSwa1cq
 wkz9Ush3pnCduaVOAuNzyXjEX7kPI0bjXTvRaNJakFVtv+dvoQ6hXIqiHD7q9V5ERz4xcKSL8zP
 QKDwZLWeC/oTLFe2lm0GbR0QvKd6ATimBjmzMliRjMSeBYoSuumOgz0CAStt+3maMDnEOTV5HyE
 XjHNX44ZKcu6te7YyAg==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a5937d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=m98AXBtd1jWFNP0ztuMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: pvWx0oaGt4zGWTHhw-ihryfmfXg8EYMx
X-Proofpoint-ORIG-GUID: pvWx0oaGt4zGWTHhw-ihryfmfXg8EYMx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfX+v2W7FewaZR6
 zdDPzgeoee8oM7qq5EDIGQxNHp/qwn2nJ+NkI2ukqPXlk55nCAWy1hPxHUxZ/MhKSZgP+kE1an3
 4JYa0Ak41V1Cq0ZCyDDqnYZrhT5Mwgw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160204
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

The following changes since commit eca2c16212ef9dcb0871de39bb9d1c2efebe76be:

  Update version for v11.1.0-rc0 release (2026-07-14 20:36:23 +0100)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docker-20260716

for you to fetch changes up to c4ce04cfb7460d46c0262d437a7f35bb5c5fc449:

  tests/docker: ensure container command is probed at most once (2026-07-16 10:49:11 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v3] tests/docker: ensure container command is probed at most (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20260716102515.1503404-1-berrange@redhat.com

----------------------------------------------------------------
Daniel P. Berrangé (1):
      tests/docker: ensure container command is probed at most once

 configure                     | 25 ++++++++--------
 tests/docker/Makefile.include | 13 ++++-----
 tests/docker/docker.py        | 67 ++++++++++++++-----------------------------
 3 files changed, 40 insertions(+), 65 deletions(-)

