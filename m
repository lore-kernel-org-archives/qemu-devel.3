Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AEAC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 15:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJRc-0004HP-0W; Tue, 05 Aug 2025 11:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ujJRW-0004Fb-Pe
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:19:10 -0400
Received: from p-east3-cluster3-host3-snip4-6.eps.apple.com ([57.103.86.29]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ujJRS-0005Fl-Jc
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 11:19:10 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 393B31800254
 for <qemu-devel@nongnu.org>; Tue,  5 Aug 2025 15:18:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=bULGQYdyYFFDevK4scCZ/+wyvz0F9BYAR3ThF7FiuZo=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=K2cLWhWOuN5/n0Rnnnu0WKsB5Hh0H2IigrZS8J1W4AWqgAokpo61gmYAq7avEDs4jHemE0dLFbbzWcJSe03z7D4hnPnjh3eBQlTt474bXBmaCvhD8eVKzbemln4qiftI4yo38kdlguc3Bi1QJIGzotvTUrSnvXFTP7WpvzxWIy/CaAxMpTlL0J8v0wAxq3SFhLAA3iRWL3bWlZgyMowEantA0i//tV1Oj0pHeagfnvVKymB5CmZjPGViVuQ1sPVaevQfSvS2JRTh2aBmh0orDi90uek4NXIjCL3j97ZkTZ81QP1fiWj8o4fykdHw8+b12V8sDQ4uIlHPGJb2U8wi0w==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 0F6A8180013C
 for <qemu-devel@nongnu.org>; Tue,  5 Aug 2025 15:18:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Asking for an account on the Qemu wiki
Message-Id: <A9FEEF2A-5443-4BB1-8C4B-5B6F974D1D66@unpredictable.fr>
Date: Tue, 5 Aug 2025 17:18:47 +0200
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: ohfLtS5CNtVV5HYpwDVMwZmfCS1TXkHq
X-Proofpoint-ORIG-GUID: ohfLtS5CNtVV5HYpwDVMwZmfCS1TXkHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExMCBTYWx0ZWRfX8SbHUHzeuBta
 9TUBXuJu/AVQ/E1Jn8VsqMGO0pycvatdBkgFMg6hl9z2m9o9p2/AAhdJ8mV8AX9w8uzJ4Lg52Qf
 NnDa7BYJu1sS+rMOG2weQ9Hb07zFBWq5JiL8z+AF0mFg8c3oSsjgMMRNfz3NTYxqiaQohdwiFK7
 AuJvw9ug4FUkNzqnPRNAkVMTrc+D18gYDx/YPbA1o4BORXiuW2s1meIKVe2pUrxIFWLfJIWzgne
 fm2xBwUxm6Yn230Ol2KnUbQKooKhqzu/sYyvMloHzu0pAuKRuyM32xSCe6y+AWvreYxko7/gI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1030
 mlxlogscore=425 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508050110
Received-SPF: pass client-ip=57.103.86.29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Just a random email to ask for an account there :)

Thank you,
-m

