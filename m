Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B13C47BFD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 14:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd80z-0000UE-QP; Tue, 06 Jan 2026 09:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LK-0001Bq-IB
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:26 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LH-0006Qa-DE
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1767707004; x=1799243004;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=bIUt6HthtoUVrCyiDset73BSbw6CTuDs9QMbkQTNoNY=;
 b=Ck+kdWyv0ailV8LOLJYEJCngDMDbh4TjEbNcb3nouf74/jP28+OUzpUl
 N8lW3sQ9/1xnP6LFQMCrNusS4XCkpg8EnOJRcejnXxf6NSagA6m0G4icv
 GhxUbboKuZtBCw0Iwl+OHRO2BfTnarugpBa+cmNCpe5oZKc46k3JP8mxP
 GOmst1dDgEK8ZIWdmAPlq3s09PIvuxjOUmLLAPATx7ZUN69q4DaNy1Ad3
 REJmlX9Re0ydcHs0oABWpWMdqI6JTyThuAReO9NInCrRxXmigEXOPmqVA
 SB05xgIlMSQ1igKIiz60zkjpNEFo1R2ck8wyO/1WBr4BAqMNHsjO6nj5B A==;
X-CSE-ConnectionGUID: kBYqsiqWRYqaHTiXB+Ia4Q==
X-CSE-MsgGUID: 79laH8xbRuGkOS2DKkoXoQ==
X-IPAS-Result: =?us-ascii?q?A2BdBQD6D11p/5oagoZagQmFGIFqCIRPkXSaGIYEDwEBA?=
 =?us-ascii?q?QEBAQEBAQgBSgcEAQGCE4IuRoxuKDgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBgEBAQEBAQYFgSGGCUYNhwQPAUY1AiYCSBYOBYMCAYJzFAawM4EygQGEf?=
 =?us-ascii?q?NoEgSUGCQELgQouiFMBgW+EAIdHgRU1gzOCYQICgiuDDoJpBIEOgRSBDo8Oh?=
 =?us-ascii?q?gIJP4ECeCwBVRMNCgsHBWGBBQM1EioVbjIdgSM+Fz5jIQkFgmwGiQAPiVqBF?=
 =?us-ascii?q?QMLGA1IESw3FBtDAW4HkAqCdgGBDysigTiBHZZhr1YHgjiBZ4welVQBMoQEj?=
 =?us-ascii?q?ROGSZMLmQaKCoN/llCEPQIEAgQFAhiBf4FpDgdxgzZSFwIPjioZHINCwxd3A?=
 =?us-ascii?q?joCBwEKAQEDCYI5hA+NHwEB?=
IronPort-Data: A9a23:R+b6W67zjRBDHteRbodBQAxRtEvGchMFZxGqfqrLsTDasY5as4F+v
 mcYX2+APfjeMWGme95wbISz80oFuZ7Xm4dnTldt/39kZn8b8sCt6fZ1j6vTF37IcpeTHBoPA
 +E2MISowBUcFyeEzvuVGuG/6yE6jufQGuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWcc3l48sfrZ9ks25Kqq4Vv0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3V9zxF8
 +ihgLTrIesfFvCWxL5NA0Ew/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFutfWQlzG
 fIkxD8lbTqynvm32Y2Be/BlpvgiHOOoHYpDgyQ1pd3ZJa5OrZHrWbrW5dJImSxqw8kIB+nCZ
 48QZXxjYXwsYTUWYQtRUclm2r32wCCiL1W0q3rMzUYzy23a1hBw1v7uKt3YfN2MSu1YmUCVv
 GmA5XvlAlQTPdefxDzD/n/EaurnxH2hCN9IRefQGvhC3wyXz0xDGBcsSHS4hsLjpm29XOJYE
 hlBksYphe1onKCxdfHkUhil5XKJoBMYc9xXFeI89UeK0KW8yw+dC3hCRDNHbtErnMs3QzUw0
 RmOhdyBONB0mKeKVXKQ5vKP93a7fzIKMW9HbCNCQQZtD8TfnbzfRynnFr5LeJNZRPWscd0s6
 1hmdBQDuog=
IronPort-HdrOrdr: A9a23:JW2sLa9wF4GIRbA3phRuk+AuI+orL9Y04lQ7vn2ZESYlFvBw5P
 re+8jztCWE9Qr5N0tBpTntAsS9qDbnhPtICOoqTMuftWvdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0EKMrzN5C9B4/oSjjPVLz9q+qjgzEnhv5am859HJTsaE51I/kN8EEKWA0d2TA5JCd4iFZ
 KG6sdCrzqkcnIHKt+8GmQEWObKqdHNidb+ehgNCwQ85ATmt0LT1FfVKWni4isj
X-Talos-CUID: =?us-ascii?q?9a23=3AMUkjLWsje6PBb/mx/JinV7pl6IsmWEzE13bJHHW?=
 =?us-ascii?q?JEG9JdLylYxyx8f9dxp8=3D?=
X-Talos-MUID: 9a23:cHXnIQVM9v2xx2rq/GC9gDhCZNdi2bmBC2c2y7kluM60MhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,204,1763420400"; d="scan'208";a="16285292"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 06 Jan 2026 14:43:18 +0100
Received: from mkroening-ud22.fritz.box (2a0a:a54a:c75:0:1df6:38e8:59e6:777c)
 by rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 6 Jan 2026 14:43:17 +0100
Subject: [PATCH 0/2] semihosting/uaccess: Swap bytes based on
 runtime-configurable endianness
Date: Tue, 6 Jan 2026 14:43:04 +0100
Message-ID: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A7EIApuRSw0PnUKY8j4A3HvB
 stT3PuQIgqUmuyhiFNUNp9Q5Bm5pfczWMZkssZWpjAVK1ZZNt3Fz+zCwbtefeChrEcMsHUJS6k
 NEZPc/7ft3vcDDIOwMWcAAAA=
X-Change-ID: 20260106-semihosting-cpu-tswap-b47debe274e2
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [2a0a:a54a:c75:0:1df6:38e8:59e6:777c]
X-ClientProxiedBy: RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:49;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-4.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 Jan 2026 09:26:27 -0500
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

This series adds cpu_tswap() functions and then uses them in semihosting
to properly swap bytes based on the runtime-configurable endianness.

The semihosting ABI [1] states:
> Multi-byte values in memory must be formatted as pure little-endian or pure
> big-endian to match the endianness mapping configuration of the processor.

This series ensures that semihosting data is properly byte-swapped if
the guest's CPU is currently in a different runtime-configurable
endianness than the host's CPU.

This is my first series submitted to QEMU, so please tell me if I have
overlooked anything or should squash the two commits.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
Buglink: https://github.com/taiki-e/semihosting/issues/18

[1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface

Thanks for your work!
Martin Kröning

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
Martin Kröning (2):
      include/exec: Provide the cpu_tswap() functions
      semihosting/uaccess: Use the cpu_tswap() functions

 include/exec/tswap.h          | 30 ++++++++++++++++++++++++++++++
 include/semihosting/uaccess.h |  8 ++++----
 2 files changed, 34 insertions(+), 4 deletions(-)
---
base-commit: 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0
change-id: 20260106-semihosting-cpu-tswap-b47debe274e2

Best regards,
-- 
Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>


