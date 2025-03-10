Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8073DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYuP-0002C9-7N; Mon, 10 Mar 2025 04:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fujunjie1@qq.com>) id 1trYAL-0001vH-G2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:07:14 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fujunjie1@qq.com>) id 1trYA0-0001HN-Ap
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1741593997; bh=1m3NpkLP/3kCEEfq6yVIpcmTeGIdXnJV/p1gVEI3Baw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lr+kdzdAwSolZjPMmgDA3ZWPUJzbKFWfeOUN5ufNg2OG9Xsc5etqcM8MDogoRQuHW
 eQvzdWhh3p6hG08n23igfpYieecJz3ipPVuLBdw7TZk4uAmrRB4o5AQpRGx51+wqFH
 LGaP5auHh1TQZQSXOZBa4SU3qoi7oIGyZBa7slRw=
Received: from localhost.localdomain ([2408:8409:1921:9c88:8c6b:6c8:9ab7:c93e])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 1469C4ED; Mon, 10 Mar 2025 16:05:06 +0800
X-QQ-mid: xmsmtpt1741593906tf5rqj6n6
Message-ID: <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7X1YVOCHdceq8Z1QLyi0d59A5grrf3cTfFXKpskIKhksx1fYvO3I
 ij/gK6eaWDYGapxhRzn/UpsIxMAqrFgAT9Fq7ULEZ5RW1POj5fRgfT6onhddhwoV1Qb80+1pKXmk
 mFGn/Uw/OgmgEpQeEZ76wkv22amBskHid/yKTYB40o89ypuWtQlkkkB8H66cBFxY+G4NxPaCzgv9
 pvwcCp7lwP/B9ISvisSCnZoRkIPog6M87djiXH/Qvdr97FqO/V9YUcP4KhIjyfNUWfzIYxHqQ/TJ
 H9JK66RVr3wYBxd0qnl9ip9gehTeW5P/1V0nY28iS4rBXjydCnlC3YpEAqpx9bl96gJJEk5xY3An
 dCOvxnFK/2BSKepkhb1hOi0DYiOQmJPiMGlFEmCRvUSJD4sFPaV1lkEKlOBscYazKTt04PnkYtHf
 j8JzaU0DBQ1r62gADqsXqEkAalPIvvZBpwyXxZ3ChE+udTHibw+YfwD7+y1uZvjl8f7jL6/LdpAg
 7dscFvLVZpiXpYCj2yOcDYy+OJYmPb/rPFl04u9kXNVUQpTO8C3SN0pYa2yVLQt/pKCyZ4ivk4E/
 f+LfYtQW8JU0ON3nOkq9I5e4rDRETnHDcJdaObKUeBiWq1+ANUjgo1LsH00lq02UxfSi/dGc0RaD
 Kl5M+gUcb8gY0VI7UPmbQ2kuJ/IjD86Y7/KNzUCWx94LdZbU4jRFK1f86iJo331MApHse0DU3Efz
 uZ6Ul2Du27vLEPLq1IHz+qeGaJzdnqmGMkqZaBAH663pIxZwjlEW07w41bcprFqJQxEBcs1wpDOn
 NoeWiZTijdwdcpa3S6TJPl4TRUWVk5bG/QAEEKisqEt+fDk8qZ0iWDmt6rICPnIG/jvj66EmVal1
 GGZaHa7DL88FFsaUPOpJalyqxN5YpH9q8ZRmoSxStQ9IvSzhojNs7j84fDvHdTWXSVdMGUHHr//t
 cyASLnTU0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Junjie Fu <fujunjie1@qq.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@Huawei.com, linux-cxl@vger.kernel.org,
 viacheslav.dubeyko@bytedance.com, zhitingz@cs.utexas.edu
Subject: CXL memory pooling emulation inqury
Date: Mon, 10 Mar 2025 16:02:45 +0800
X-OQ-MSGID: <20250310080245.291632-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215151854.00003e34@Huawei.com>
References: <20230215151854.00003e34@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.47; envelope-from=fujunjie1@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 10 Mar 2025 04:54:47 -0400
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

> Note though that there is a long way to go before we can do what you
> want.  The steps I'd expect to see along the way:
>
> 1) Emulate an Multi Headed Device.
>    Initially connect two heads to different host bridges on a single QEMU
>    machine.  That lets us test most of the code flows without needing
>    to handle tests that involve multiple machines.
>    Later, we could add a means to connect between two instances of QEMU.
> 2) Add DCD support (we'll need the kernel side of that as well)
> 3) Wire it all up.
> 4) Do the same for a Switch with MLDs behind it so we can poke the fun
>    corners.


Hi,Jonathan

Given your previous exploration, I would like to ask the following questions:
1.Does QEMU currently support simulating the above CXL memory pooling scenario?

2.If not fully supported yet, are there any available development branches 
or patches that implement this functionality?

3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?

I sincerely appreciate your time and guidance on this topic!


