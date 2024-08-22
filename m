Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61817C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh2sR-0000V0-MT; Thu, 22 Aug 2024 04:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2sP-0000US-RE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:09:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2sL-0003Fo-J0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:09:01 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240822080847epoutp02a718de436beb60584099d027cd9ffb90~t-pBBjuxD1564115641epoutp02w
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:08:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240822080847epoutp02a718de436beb60584099d027cd9ffb90~t-pBBjuxD1564115641epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724314127;
 bh=GLLIbHDiRLsbLygcfpp+tvX+LCAZ07HGR4UvFuzMzMc=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=HI0PSB47OeLKBlumeRlbgvLl0FyINtI/6DxMhkho860ZGxslWQ+9LDnik9YodN00K
 k4tXe4I4jfvP1wHTN4j9JYzFZ7qbFFMPNX6+QO9IZ0OGr/S2sMh5iq7jZz9efz6G++
 HOaXD65qQTJ7wvHZ7qFNnXLgHOncinWN57LmVHmA=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240822080847epcas1p11256b65d9640821a519e09f5f054fb80~t-pAex9Uy0227802278epcas1p1M;
 Thu, 22 Aug 2024 08:08:47 +0000 (GMT)
X-AuditID: b6c32a39-8f9ff70000002606-47-66c6f20ff840
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 85.10.09734.F02F6C66; Thu, 22 Aug 2024 17:08:47 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 0/4] hw/ufs: ufs device testing function added and modified
From: Yoochan Jeong <yc01.jeong@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: "thuth@redhat.com" <thuth@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jeongyuchan0629@gmail.com"
 <jeongyuchan0629@gmail.com>, Yoochan Jeong <yc01.jeong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
Date: Thu, 22 Aug 2024 17:08:46 +0900
X-CMS-MailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCmgS7/p2NpBp3zeC16Xu1js7i/9Rqj
 xacGKYv92/6xWhzv3cFisfKYjcXuszPZHNg9ds66y+7x5NpmJo/3+66yefRtWcUYwBLFZZOS
 mpNZllqkb5fAlfHg7iaWgja2isN3jrA3ML5g6WLk5JAQMJH4/7eFsYuRi0NIYAejxJqv89i6
 GDk4eAUEJf7uEAapERYIkDj56DM7iC0koCDxY/lNNoi4nsTmtTPBytkEdCQafjqAhEUEVCVe
 Ld4ENp5ZYCaTxPYDnhCreCVmtD+FWistsX35VkYIW1Ti5uq37DD2+2PzoeIiEq33zjJD2IIS
 D37uZgRZJSEgKbH+tSZEuF7ixrXHbBB2jcSjtltQY/QlrnVsBFvFK+ArsXdhJ9hIFqDTXp9r
 hBrpItFw+D0bxJnyEtvfzmEGGc8soCmxfpc+RJhP4t3XHlaY63fMe8IEYatILLr4HmqtlMTX
 E+uYIS7zkHhz3R/EFBIIlFj5XXUCo9wsRGDOQrJqFsKqBYzMqxjFUguKc9NTiw0LTPWKE3OL
 S/PS9ZLzczcxglODluUOxulvP+gdYmTiYDzEKMHBrCTCm3TvaJoQb0piZVVqUX58UWlOavEh
 RmkOFiVx3jNXylKFBNITS1KzU1MLUotgskwcnFINTEssbUP4nherrP7SPL982+OtrpM/rYia
 sKyg4dX8J1xz2SWWvz0xv5PbZpqTX8WJbUYyMR/vZtnt23n8h0KjvPXN3tdejZaFHxnL2l9M
 EBPzEkpf3Nqd/CdO9TpbXRajxtKXDVwPV69LWPprx4bJzupCnQcmi9/k2iJh+KGLs7FC4dyV
 3YFab156nI1h3SSYbP62e+/LVMefL1bH3w0L+Wj9d6X7757M7px9+V33nj7WUIh4/VjuQ+O+
 yXITJV+aH9hm1/vrtMqbMH/TQ5pKkWLRZ20EuZsa7e+si/o//5TUPU+GiXYBctI/rmQLuxTO
 z94xMSJY3+RduOuqRNvjj7JMCu/fe1DGlu7EaNV+UYmlOCPRUIu5qDgRAAlbinB8AwAA
X-CMS-RootMailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
References: <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=yc01.jeong@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: yc01.jeong@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previously, it was only able to test virtual UFS devices if they properly
read and write storage data. In this patch, three test functions are added
to test if virtual UFS devices properly read and write its metadata.
Each functions test reading and writing flags, attributes and descriptors.
Related minor bugs and errors are also fixed.

Yoochan Jeong (4):
  hw/ufs: minor bug fixes related to ufs-test
  hw/ufs: ufs flag read/write test implemented
  hw/ufs: ufs attribute read/write test implemented
  hw/ufs: ufs descriptor read test implemented

 hw/ufs/ufs.c           |  19 +-
 include/block/ufs.h    |   6 +
 tests/qtest/ufs-test.c | 384 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 400 insertions(+), 9 deletions(-)

-- 
2.34.1


