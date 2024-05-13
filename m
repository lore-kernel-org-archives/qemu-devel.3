Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CB4C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PZs-000365-63; Mon, 13 May 2024 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1s6PZp-00035l-CW
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:54:25 -0400
Received: from mr85p00im-zteg06022001.me.com ([17.58.23.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1s6PZn-0007Qh-RG
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1715583259; bh=IGEG1PX849vfVhmV5U/p4vBL4bQgjAWlgXBgNhaiqhQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=hmBOGbP+mOs8+GY0QW2EiBdjDWAMMIYlLogFCQc56PoakS926ele14vjVs7G3jooG
 VVDxZA2PAN4INkAcxTYol4KJ101bPRZXqRHrDySAlFg0I9j6jWaqrRCYNpguaS2M+i
 LpIZmYr1j9JIBIWy4ch7lVCth1Z+KpCf+KWJFgQj7IMM5RSZ/z41r1OaKbR0oQ5Ad5
 fNmVBqa4O81fAhLAjgnb1MXMR0APxfl+HlUvmUT3NEgBLKjcFOjuxtLYyWLMCNOxrt
 2ou6q7QjftKs7+bRtq7LsVHFVlmg4iiUWFPGQ25jSOfOYo+AGcltzUeH2sxgro3oHB
 dqjtDLd5+8Utw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 8665C800189;
 Mon, 13 May 2024 06:54:17 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
Date: Mon, 13 May 2024 08:54:04 +0200
Cc: Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: 7bit
Message-Id: <E9F457F8-455F-4D7F-B51F-406887E0FBBB@ynddal.dk>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-Proofpoint-GUID: aBTtMjleQcNWYGJw-fpwgqaEvV6l3cX3
X-Proofpoint-ORIG-GUID: aBTtMjleQcNWYGJw-fpwgqaEvV6l3cX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1030 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=880 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405130044
Received-SPF: pass client-ip=17.58.23.193; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06022001.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


> Why are the timestamps non-monotonic?
> 
> In a situation like that maybe not only the negative timestamps are
> useless but even some positive timestamps are incorrect. I think it's
> worth understanding the nature of the instability before merging a
> fix.

I agree with Stefan on this. We'll need to find the underlying cause first.


