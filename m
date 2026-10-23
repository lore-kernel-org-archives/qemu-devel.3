Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CC606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=PewVYvFh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKADA-0003hm-9m; Fri, 23 Oct 2026 04:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKAD8-0003gX-6T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:01:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xKAD5-0003Xo-07
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 04:01:09 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20261023080102epoutp0263c5bcbdc51a4165930953c76d0fc07f~hGcVySmSV1672116721epoutp02S
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:01:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20261023080102epoutp0263c5bcbdc51a4165930953c76d0fc07f~hGcVySmSV1672116721epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792742462;
 bh=WWRav6D+K/iBHgNb9kqlcNq5eu3LrVmYSdu7AMlGiPg=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=PewVYvFhwhEOf3mPT+k96rH9OdyNEnrMJ09m1mx0CvLUSrwWaSSfK2jd0t646eS0n
 sXOGggwLhKMxFPG2sDkmn6mg39cOU84RHJ1eZi9eQprss0E2GsilOwRzta6rS82eHU
 oveQILN6nvQ0pCPPWiTIxhfb3nai0ZpivcOC9/TY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261023080102epcas2p46cabe4181d6d442d73a8c21f81e0a276~hGcVdVWzq0538705387epcas2p4L;
 Fri, 23 Oct 2026 08:01:02 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.204]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j9wSY5jDYz2SSKm; Fri, 23 Oct
 2026 08:01:01 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
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
In-Reply-To: <20261022074513.2292281-3-stanleyjhu@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261023080101epcms2p7070aa02ae311188492d194457eea1a3d@epcms2p7>
Date: Fri, 23 Oct 2026 17:01:01 +0900
X-CMS-MailID: 20261023080101epcms2p7070aa02ae311188492d194457eea1a3d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261022074630epcas2p4001e9e28de17b02cffe601975aeeee59
References: <20261022074513.2292281-3-stanleyjhu@google.com>
 <20261022074513.2292281-1-stanleyjhu@google.com>
 <CGME20261022074630epcas2p4001e9e28de17b02cffe601975aeeee59@epcms2p7>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 22 Oct 2026 15:45:07 +0800, Stanley Jhu wrote:
> +    if (tm_func == UFS_QUERY_TASK) {
> +        if (u->fault_inject_mode == UFS_FAULT_INJECT_IN_TRANSITION) {
> +            u->held_req = NULL;
> +            u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
> +            u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
> +            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +            ufs_fault_inject_complete_held_req(hreq);

Which host path is in-transition meant to reach? In Linux, QUERY TASK
is sent only by ufshcd_try_to_abort_task(). When it runs from
ufshcd_abort() after a SCSI timeout, scsi_timeout() has already set
SCMD_STATE_COMPLETE (drivers/scsi/scsi_error.c:391), so scsi_done()
drops the completion posted here (drivers/scsi/scsi_lib.c:1772). The
request stays MQ_RQ_IN_FLIGHT, ufshcd_cmd_inflight() stays true, and
the loop returns -EBUSY after 100 "not pending" replies
(drivers/ufs/core/ufshcd.c:7993-8026). The "completed" branch is never
taken, and recovery ends in a host reset, as with abort-failed. I got
this with O_DIRECT writes on mainline 7.3-rc7 (MCQ and legacy) and on
ACK android17-6.18 (MCQ).

If the target is a path where the host does take this completion, for
example ufshcd_abort_all() from the error handler, the host would see a
WRITE succeed although no data reached the LU.

> +        } else {
> +            /* UFS_FAULT_INJECT_ABORT_SUCCESS or default */
> +            u->held_req = NULL;
> +            if (ufs_mcq_req(hreq)) {
[...]
> +            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +        }

This repeats the generic ABORT TASK code in ufs_process_tmr(). The held
request is in UFS_REQUEST_RUNNING, so ufs_find_req_by_tag() finds it,
and releasing the hold and returning false gives the same result. The
same is true for the QUERY TASK SUCCEEDED branch above. With both
changed (17 deletions, 4 insertions), the UFS qtests pass 29/29.

Daejun

