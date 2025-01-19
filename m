Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA51C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 14:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZWEO-0000BB-Tc; Sun, 19 Jan 2025 09:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emirpdalan@icloud.com>)
 id 1tZU4s-00039X-Ux
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 07:06:55 -0500
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emirpdalan@icloud.com>)
 id 1tZU4r-0002tT-DM
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 07:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=IAF1TWIcweMz8mgpVihOPVRLk2gM0I+LRTvHM8i31rs=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=K50VsQhwFT4o6PdpYcGgt0epuZQf4vlFAdo0gZG9q0YGOa5Zo6AkUCbeZb7HeEZtC
 ewHirWa2L3BAVXO0F+pLaCaPtRVAlVPGSpu22xFy+cqRQfaVRNpzipOOwZztuCcCOo
 BQKRBUGgraSkBiY2iinUxywNxdiJYe5kFfVJnPHEKmfwY4l+btWYcZjJejL6lQNBCr
 abMBrehNSh0L9w3FQNM0Sm4vPk9Bc8eWydDKryt4tMUItC7LC07zcQ5OfPMfyb7FDB
 EHAV0xntVmauTJ+T6RV7h136SwZwKaUuXygpS26ofT6xSt5tBrWtbpp++V8IzsRDvf
 JC2ZcDgfy/bzA==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com
 [17.42.251.41])
 by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 2E5D09C015D
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 12:06:47 +0000 (UTC)
From: Emir Dalan <emirpdalan@icloud.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3810.100.6\))
Subject: 
Message-Id: <BC0D117F-1CEB-4343-8BCC-46F1339E15CF@icloud.com>
Date: Sun, 19 Jan 2025 13:06:34 +0100
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3810.100.6)
X-Proofpoint-GUID: FHH2s8dcWEhs1EVlJ31mU3MQFLTmyLpv
X-Proofpoint-ORIG-GUID: FHH2s8dcWEhs1EVlJ31mU3MQFLTmyLpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 mlxlogscore=541 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501190093
Received-SPF: pass client-ip=17.58.63.177; envelope-from=emirpdalan@icloud.com;
 helo=st43p00im-ztdg10073201.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 19 Jan 2025 09:24:51 -0500
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

Dear project qemu-t0830

I am trying to setup project but I can=E2=80=99t errors and can=E2=80=99t =
find out how can you help me with that using macOS
=46rom emr09=

