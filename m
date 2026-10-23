Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j38TnO2D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKADf-00045t-Uy; Fri, 23 Oct 2026 04:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKADe-00045W-IA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:01:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKADc-0003Yv-Bi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:01:42 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20261023080136epoutp0176af3e3209e869d528dae534015c5f36~hGc1BNScX0624106241epoutp01A
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20261023080136epoutp0176af3e3209e869d528dae534015c5f36~hGc1BNScX0624106241epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792742496;
 bh=+y28ctBQuWsO3GmNu3HVWzGqmzNjYtU9yNIGsMsbVi4=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=j38TnO2DR7tqT00DzQYx41kF5mjd1S23vGZCjB7FBMRB26RfmZo/rwyF4Fj3kuqDk
 PofOWENS9qPc0v+QJiylYJy9LTt5SgdOL6w/VOsN42pGrhUyLwZ6Q6iqAST4qXZKmG
 qnHYjnT52rYR5CvT7DiTsYwBIr9W/XKU2aLkN6d8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261023080135epcas2p4d9b720c85c0e2b3528df9f2bb06ea717~hGc0fVh2-1954319543epcas2p4W;
 Fri, 23 Oct 2026 08:01:35 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.211]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j9wTC0ZNpz2SSKs; Fri, 23 Oct
 2026 08:01:35 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2 8/8] tests/qtest/ufs-test: Add QOM fault injection
 task abort test
From: Daejun Park <daejun7.park@samsung.com>
To: Stanley Jhu <stanleyjhu@google.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Jeuk Kim <jeuk20.kim@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jinyoung Choi <j-young.choi@samsung.com>, Daejun Park
 <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261022074513.2292281-9-stanleyjhu@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261023080134epcms2p2148696f3da2f7eae77b698010a406808@epcms2p2>
Date: Fri, 23 Oct 2026 17:01:34 +0900
X-CMS-MailID: 20261023080134epcms2p2148696f3da2f7eae77b698010a406808
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261022074653epcas2p469213ae4a01eb00ed403a0b656ed967c
References: <20261022074513.2292281-9-stanleyjhu@google.com>
 <20261022074513.2292281-1-stanleyjhu@google.com>
 <CGME20261022074653epcas2p469213ae4a01eb00ed403a0b656ed967c@epcms2p2>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=daejun7.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 15:45:13 +0800, Stanley Jhu wrote:
>      qos_add_test("hce-reset", "ufs", ufs_test_hce_reset, &mcq_test_opts);
>      qos_add_test("tmr-handling", "ufs", ufs_test_tmr_handling, &mcq_test_opts);
> +    qos_add_test("fault-injection-abort", "ufs",
> +                 ufs_test_fault_injection_abort, &mcq_test_opts);

All three new tests use mcq_test_opts, and UFS_FAULT_INJECT_TAG_ANY is
used only with ssu-timeout. To see what is covered, I removed each of
the following on top of the series. Each build succeeded, and the UFS
qtests still passed 29/29:

- the legacy half of the abort-success branch in ufs_fault_inject_tmr()
  (2/8)
- the READ_10/WRITE_10 match for TAG_ANY in ufs_fault_inject_exec_req()
  (1/8)
- the body of ufs_fault_inject_sq_cleanup() (2/8)

Could the fault injection cases also run with io_test_opts, and could
one case cover TAG_ANY with a READ(10) below and above
UFS_FAULT_INJECT_MIN_LBA?

Minor:

- 7/8 and 8/8 drop G_GNUC_UNUSED but keep the old continuation indent
  of ufs_send_tmr() and ufs_mcq_send_scsi_cmd_async()
  (tests/qtest/ufs-test.c:1903-1905 and 1932 after the series). If each
  helper is added in the patch that first uses it, 5/8 does not need
  G_GNUC_UNUSED.
- 6/8, tests/qtest/ufs-test.c:2014: the comment says the queue
  status/pointers "remain 0" after HCE=1, but only the HCE bit is
  checked after it.

Daejun

