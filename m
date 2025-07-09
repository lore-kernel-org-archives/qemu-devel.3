Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4624DC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 19:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZaA7-0002WJ-PD; Wed, 09 Jul 2025 15:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chefkiss@icloud.com>)
 id 1uZZVX-00063U-J8
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:27:03 -0400
Received: from p-east3-cluster2-host1-snip4-5.eps.apple.com ([57.103.87.136]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chefkiss@icloud.com>)
 id 1uZZVV-0007vQ-PG
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:27:03 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 8EB411800204
 for <qemu-devel@nongnu.org>; Wed,  9 Jul 2025 18:26:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 bh=qaKAZ7ZthzQ84Ka51CW6BMcO7YPhiMhHchOnyvIxrsA=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=mFtCvZB19iY4mFv25atmx8IR29N7P/ghfdl++7h7Cb9cZNyeeS67wYgoAJymefDdphUMuiYbjLZXU0M+t/gixCNLZOZwocz9UQL8ukwKmKy5gTLLKTMyvY+bEDceWyfQv+8yO1zD6zyP29e9k+DKoUgi8yMC4V358J0jRizlQx9lGBesRX4pz6RX86OIO7aKRBlfxgXFB1gfGiUZnnpQ3jNzpPHq1DLBfVvjsKlip6Uf9v8sTkxiTogXTDExovZfw40mPJGtgZehKy+gGG8uyRuqqFEhY0Ay3IQlY1WzzQdib9UMHi8YWrxOS95Eb4dd45rsrQXjOl7GTQwaFDNUMg==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 2B11E180020C
 for <qemu-devel@nongnu.org>; Wed,  9 Jul 2025 18:26:55 +0000 (UTC)
From: chefkiss@icloud.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3858.100.10\))
Subject: NVMe VMStateDescription
Message-Id: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
Date: Wed, 9 Jul 2025 21:26:42 +0300
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3858.100.10)
X-Proofpoint-ORIG-GUID: YSXhYZ9TXZmOW5mFbxaaVm7Gb3VIK-mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NyBTYWx0ZWRfX6BsSVYQf3MQQ
 NhaR70ZPoyKhojSRB/EilpPkHmd/bVZkOiKuwkOB7B1Ar57kUTLpBuwJj8RcEM/03LTBjuM97qC
 /aeeaE3Olfeo7JHC8Dlm61iddzKTwLHoH2GuiOPlK+b1EoptdoVX42pwQOHkdzplB5MxO63Hgjp
 5zd7rSu/Wf6T7rsfZUDtG4PwqGjqwwZTV14aqXlyXG9yTC2I71lXFO7drP+s8Hn1Q4Gkc6+xc27
 FNEp65YbZhWEA5zqkkqQ3w7rBKiNDBOd8fXNMDy8Yxyw43dx/kWCiMy507rsfAzo174mwHNHw=
X-Proofpoint-GUID: YSXhYZ9TXZmOW5mFbxaaVm7Gb3VIK-mt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=780 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2507090167
Received-SPF: pass client-ip=57.103.87.136; envelope-from=chefkiss@icloud.com;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Jul 2025 15:08:58 -0400
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

Hello,

I am working with an SoC that only supports NVMe, and would like to be =
able to savevm/loadvm, and maybe also record/replay.
The NVMe has a VMStateDescription with just unmigratable =3D 1 ever =
since it was first added in 2013.
Is there a technical or other limitation/reason for why this is the =
case?

Regards,
Visual.

Cc: Klaus Jensen <its@irrelevant.dk>=

