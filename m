Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B9DC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmocC-0001Xl-Ob; Tue, 25 Feb 2025 01:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmoc8-0001XD-8q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:40:20 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmoc4-0002S3-BA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:40:19 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250225064004epoutp02a0a05e09ea79ea5316f912c6b6f70d87~nYD8ABjuY0714507145epoutp023
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:40:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250225064004epoutp02a0a05e09ea79ea5316f912c6b6f70d87~nYD8ABjuY0714507145epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740465604;
 bh=dvSZmk7OaTK0r0gItj3YIG6WwaNDDzrrW2w8DsCx+Mk=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=OxJFd8kDiPknDbBzFyDQbDply4iIBP/hGsbzu6v0t3u/YP7lJNGqcLhM8apz4PShD
 FO3+WFuGS91xeRlpIMsUfJfHhdighr5tKc5YlzNUweHdcg1oPLfhqD43PB7XW0YMor
 d28DNCjzQgHFjW4lp+jKEC+xNrNjMDZDKM+2zHrw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20250225064003epcas2p49e4dc2161c022e595407760959031080~nYD7Tpwl80794807948epcas2p4h;
 Tue, 25 Feb 2025 06:40:03 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Z27JL2bKqz4x9Q8; Tue, 25 Feb
 2025 06:40:02 +0000 (GMT)
X-AuditID: b6c32a43-0b1e27000000599a-67-67bd65c2a72e
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 20.97.22938.2C56DB76; Tue, 25 Feb 2025 15:40:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/2] hw/ufs: Add temperature event support and test cases
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Keoseong Park <keosung.park@samsung.com>, Jinyoung
 Choi <j-young.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Date: Tue, 25 Feb 2025 15:40:01 +0900
X-CMS-MailID: 20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmqe6h1L3pBjc38Fq8PKRp8frFcmaL
 B3f7GS16+7eyWdzfeo3R4vjJd4wWSy6mWnxqkLLYv+0fq8Wsd+1sFsd7d7A4cHs8ubaZyeP9
 vqtsHn1bVjF6bD5dHcASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
 XS8vtcTK0MDAyBSoMCE7Y8OBfpaC/ZwV94/vZmxgfMbexcjJISFgIrH28HK2LkYuDiGBHYwS
 c5Z9Zepi5ODgFRCU+LtDGMQUFvCUWL/CB6RcSEBJomvhVmYQW1jAQGLd9D1gNpuAnsSU33cY
 QcaICPxglGjaeYcJxGEW2MMoMaHzCCPEMl6JGe1PWSBsaYnty7dCxTUkfizrZYawRSVurn7L
 DmO/PzYfqkZEovXeWagaQYkHP3czghwnISAp8f6qIkS4XqL1/Sl2kL0SAhMYJRqP/YGaoy9x
 rWMj2F5eAV+JOx92gM1hEVCVuLj4PBNEjYvE67uvWUFsZgF5ie1v5zCDzGcW0JRYv0sfYpWy
 xJFbLBAVfBIdh/+yw3zVsPE3VvaOeU+gpqtJPFqwhRXClpG4OOcc8wRGpVmIgJ6FZO8shL0L
 GJlXMYqlFhTnpqcmGxUYwuM2OT93EyM4cWo572C8Mv+f3iFGJg7GQ4wSHMxKIrycmXvShXhT
 EiurUovy44tKc1KLDzGaAn08kVlKNDkfmLrzSuINTSwNTMzMDM2NTA3MlcR5q3e0pAsJpCeW
 pGanphakFsH0MXFwSjUwWcr3Smvxub+KVGM09/7H2r5D6sLHq8Lac7cYLuVjZnp450Ju3U2/
 04bzd/ft0o7v0Uz3eJLYJ/FZ923ppWXrn8XN/qfwdOZJzgP9NpvD4i/eSf9seznhR5+va9Yk
 ptaDzIZf7Sa761yUfKiz4c7NtPIpDjNYgpZPsNu/VGeHLK/qt5WRLyZUz7X1MLXafnv6iYDN
 ius7p4VtPqT8r/NY1xXPbgfHGRll13rM9iaXH015K5J++aGz2dQ56pq3UsVjNfZs9C1yfppT
 qyiszrxm+akLk3af31+q0v/Aoa3DxSJdRuRtHcftOWazFJwaDcpVT72Ndu6bm/JWle1ohpDX
 pXe7Ph4V8TOaLfTk3ZZ9SizFGYmGWsxFxYkA/YHlpSUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8
References: <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=keosung.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series introduces temperature event notification support in
the UFS emulation and adds corresponding test cases to validate the feature.

The first patch enables the UFS emulation to generate temperature-related 
events, including high and low temperature notifications, following the
UFS specification. This feature allows UFS drivers to handle temperature
exception events during testing and development, improving validation and
debugging capabilities for thermal event handling.

The second patch adds test cases to verify the correctness of query
attribute results related to the temperature feature. These tests ensure
that querying temperature attributes returns expected values, helping
to validate the implementation and maintain correctness in 
temperature-related operations.

Keoseong Park (2):
  hw/ufs: Add temperature event notification support
  tests/qtest/ufs-test: Add test code for the temperature feature

 hw/ufs/ufs.c           | 78 +++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h           |  2 ++
 include/block/ufs.h    | 13 ++++++-
 tests/qtest/ufs-test.c | 24 +++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.25.1


