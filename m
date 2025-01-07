Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C54E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3bl-0007ig-4K; Tue, 07 Jan 2025 02:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tV3bj-0007iP-7L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:02:31 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tV3bd-0004w3-5z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:02:30 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250107070210epoutp04ea3089705b3615fbe32cbb2a7116d14b~YVwP5cJZ00182001820epoutp04s
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2025 07:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250107070210epoutp04ea3089705b3615fbe32cbb2a7116d14b~YVwP5cJZ00182001820epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1736233330;
 bh=uJa4rYsMaTg8VDExdSda4Cb/uCHunn3DcwEJtGO17A4=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=QRWn60CxwvcL0Ow8ar4q4VGJ1O3LzvOQowzZpGM8wdTGq2xz8EAGX3ng/hJ2qtN0+
 2ysMrE7E/VfZvgub0oXJQB9tDcXkvlOOKGktwNwkmB+v8AbQfi6l7Rpw/qe7Q1KDWf
 y1nzeVWDQWNl/fEDEDtf+RjOWAwFACKL2/u5xizU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20250107070210epcas2p49de1e36506d2ec0c466c3d44efafe561~YVwPgKfmH0221702217epcas2p4s;
 Tue,  7 Jan 2025 07:02:10 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YS26T4T3Yz4x9QH; Tue,  7 Jan
 2025 07:02:09 +0000 (GMT)
X-AuditID: b6c32a43-0b1e27000000599a-8b-677cd1716725
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 4A.51.22938.171DC776; Tue,  7 Jan 2025 16:02:09 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] hw/ufs: Adjust value to match CPU's endian format
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Date: Tue, 07 Jan 2025 16:02:09 +0900
X-CMS-MailID: 20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmmW7hxZp0g+2zRC1eHtK0uL/1GqPF
 8d4dLA7MHk+ubWby6NuyijGAKSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJ
 IS8xN9VWycUnQNctMwdoh5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgx
 t7g0L10vL7XEytDAwMgUqDAhO+NR51nGgjNsFZ8bJzE2MM5i7WLk5JAQMJH4tfsokM3FISSw
 g1Fiytv/jF2MHBy8AoISf3cIg9QICzhJbHqymhHEFhJQkuhauJUZIm4gsW76HjCbTUBPYsrv
 O2A1IgKqEq8Wb2IBsZkFjCWWnJnKDrGLV2JG+1MWCFtaYvvyrYwQtobEj2W9zBC2qMTN1W/Z
 Yez3x+ZD1YhItN47C1UjKPHg526wMyUEJCWm/pCACNdLtL4/xQ7yioTABEaJxmN/oOboS1zr
 2Ai2l1fAV2LyyTlgv7MA3Xl01jcmiDkuEtvmyEKcLC+x/e0cZpAws4CmxPpd+hAVyhJHbkE9
 xSfRcfgv3FMNG39jZe+Y94QJwlaTeLRgCzTAZSQuzjnHPIFRaRYimGch2TsLYe8CRuZVjGKp
 BcW56anJRgWG8JhNzs/dxAhOa1rOOxivzP+nd4iRiYPxEKMEB7OSCG+WRmW6EG9KYmVValF+
 fFFpTmrxIUZToIcnMkuJJucDE2teSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWp
 RTB9TBycUg1Mx/Sv5dkUusb+UPx+yXDLhZ8Mno7vWf4uYZw2a9OLtJiM4/uX5r8NTZrxfknp
 PNGDIbK6xc4bxa7XBucm3zo24+URlxV7thh6OKvYH1g88+5DocrDBd6PL3tcKfFf0Tp3EYut
 5Is5/iuO1nTNYvC6U/s0Zt8sR74Hk7t2ZYs6iC69dS+TQat5YfX7xtrvqbsSQl/vfev1SSOU
 v+i7wdXF/uGJIrJlNcnt6o1XgzqixYo0e9W/qXok10t8Ug98GHFjzRcnPWEfJ78kD2+nLpHN
 B1kl1+keURNQKc2oPvFAn6NknfjNjJVXjm59f+7STrvQts7yvsytoat+zj2xwS7IavGrZY+e
 /5+7rTyJaZ+XEktxRqKhFnNRcSIAzrFCGPQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29
References: <CGME20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=keosung.park@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In ufs_write_attr_value(), the value parameter is handled in the CPU's
endian format but provided in big-endian format by the caller. Thus, it
is converted accordingly.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 hw/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 8d26d13791..428fe927ad 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
         value = ufs_read_attr_value(u, idn);
         ret = UFS_QUERY_RESULT_SUCCESS;
     } else {
-        value = req->req_upiu.qr.value;
+        value = be32_to_cpu(req->req_upiu.qr.value);
         ret = ufs_write_attr_value(u, idn, value);
     }
     req->rsp_upiu.qr.value = cpu_to_be32(value);
-- 
2.25.1


