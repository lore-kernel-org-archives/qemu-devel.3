Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D68606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rzjPzhnM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKACR-0003K0-MI; Fri, 23 Oct 2026 04:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKACN-0003Jb-Qr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:00:23 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKACK-0003Lm-V7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:00:23 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261023080007epoutp03123e3d78ca1bbc5bdd41632f7b8fe325~hGbiXr59s1958319583epoutp03F
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261023080007epoutp03123e3d78ca1bbc5bdd41632f7b8fe325~hGbiXr59s1958319583epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792742407;
 bh=yMeJZS8ObZFl4t0yV2PKkIiUAVJPspT/JneWgMWpz5I=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=rzjPzhnMVXKIf8JiFZjViPgF2HJ9cvsE08k7r0p813iEF+RdBy0mpp0yE0fQd7h2Q
 EoHGxly04HOjanonbeudAsDiW6+9QXfIg7eTcE8kEGKR0z/LQd5g3/IwZlm01idTZV
 dM+fOti6ezNQCUZbU/CXqoPxsACVBnfD2zG53Ud4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261023080006epcas2p4bd0f3182028c6164ca2b74023b023f53~hGbh36WKj0922509225epcas2p4Y;
 Fri, 23 Oct 2026 08:00:06 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.211]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4j9wRV2ks4z6B9m7; Fri, 23 Oct
 2026 08:00:06 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2 1/8] hw/ufs: Add experimental fault injection
 properties for holding requests
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
In-Reply-To: <20261022074513.2292281-2-stanleyjhu@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261023080005epcms2p344c865eea89ea2129bd55804a36bef0c@epcms2p3>
Date: Fri, 23 Oct 2026 17:00:05 +0900
X-CMS-MailID: 20261023080005epcms2p344c865eea89ea2129bd55804a36bef0c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261022074520epcas2p29db44f4b96a09e19588ee3d554146368
References: <20261022074513.2292281-2-stanleyjhu@google.com>
 <20261022074513.2292281-1-stanleyjhu@google.com>
 <CGME20261022074520epcas2p29db44f4b96a09e19588ee3d554146368@epcms2p3>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
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

On Thu, 22 Oct 2026 15:45:06 +0800, Stanley Jhu wrote:
> +    if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
> +        uint8_t op = req->req_upiu.sc.cdb[0];
> +
> +        if (op == READ_10 || op == WRITE_10) {

Linux sd switches zoned LUs to 16-byte READ/WRITE
(drivers/scsi/sd_zbc.c:607-609, "READ16/WRITE16/SYNC16 is mandatory
for ZBC devices"). On a zoned LU from the series this one is based on,
TAG_ANY therefore never holds anything. Could READ_16/WRITE_16 be
matched as well, with the LBA from ldq_be_p(&cdb[2])?

> +    if (!visit_type_uint32(v, name, &val, errp)) {
> +        return;
> +    }

Task tags are 8 bits, but any value is accepted here.
"-device ufs,x-fault-inject-tag=300" realizes, and after qom-set to
4096, qom-get returns 4096. Such a tag never matches a request. Could
values above 255, other than UFS_FAULT_INJECT_TAG_NONE and
UFS_FAULT_INJECT_TAG_ANY, be rejected here?

> +const PropertyInfo ufs_prop_fault_inject_mode = {
> +    .type = "str",

Optional: the mode could be an enum property. A QEnumLookup with
qdev_propinfo_get_enum/set_enum, as qdev_prop_spdm_trans does
(backends/spdm-socket.c:255-262), replaces ufs_fault_inject_parse_mode(),
ufs_fault_inject_realize(), the get/set/release handlers and the
u->fault_inject_mode copy. I tried it on top of the whole series: 31
insertions and 118 deletions over ufs.c, ufs.h, ufs-pci.c and
ufs-sysbus.c. With .realized_set_allowed = true, qom-set still works
after realize, an unknown name is rejected, and the UFS qtests pass
29/29. It needs hw/core/qdev-prop-internal.h, and
trace_ufs_fault_inject_set_mode would need a small wrapper to stay.

Daejun

