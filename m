Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2519DC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDLy-0008Qt-9q; Wed, 28 May 2025 05:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKDLw-0008Pq-DR
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:45:40 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKDLs-0004Fs-Pp
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748425533; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gB0PfFsMRszum4py+n24CdZDDr1aPxgN0xoa5hzGJ+ti+mhps9VU/7s7Jc1uvJIFOFSDK+I2mvaVy39r+stAzxGKpbxDpopBFWnHjLJDpYzpmCWY7J8x6q9w900+dfJj3DYNHDYsKeT8YC3mQs3V+ZttS+jTiryHulecBXchxX4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748425533;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=PYG7cWDAcmD49KHbWKt7tJfsrtrQo8SbsjcTRbu9ZxY=; 
 b=bopHIfQ4+kstEBHKEmOTnyhMHY6v2/M2rH29JaerUSoJHMhppATkL4vWKawo9C1D044+lvBTQO1Nr8tpnKRUkx2Yd4zbIWxWS9MDxqHRxFGzRQyp11MYRqiA4syqHmAq6Eh4NzNr/SFEqueVYM613q8hKt/nfZ3losTwcguYPdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748425533; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=PYG7cWDAcmD49KHbWKt7tJfsrtrQo8SbsjcTRbu9ZxY=;
 b=gVqqBLC2lgQ87/M2o2RuwvWF/LeCyMIDMjsEbKLHiSibKc/sHorTYNurKW1ko8de
 LZc1KJc5h5/r/cKN8NLo//gTOWi6/KoDkBy2+OTwBCMk7EozVIWq1LmsYzJUwCgG2yG
 vuk/b2/D0PTehku8a7fsgXAPyByzqE9Wi9jQKz4A=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1748425531539242.44862166913617;
 Wed, 28 May 2025 02:45:31 -0700 (PDT)
Date: Wed, 28 May 2025 17:45:31 +0800
From: Li Chen <me@linux.beauty>
To: "Qemu devel" <qemu-devel@nongnu.org>
Message-ID: <1971648603b.dce1f5d22901195.6702025346547333607@linux.beauty>
In-Reply-To: 
Subject: Get "Message headers fail syntax check" error when using
 git-send-email
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

My emails to the qemu-devel, qemu-riscv, and qemu-arm mailing lists regarding the 
"[PATCH v4 0/4] acpi: Add machine option to disable SPCR table" series are being 
rejected by these mailing lists, while other recipients are unaffected. 
This issue didn't occur with versions v1-v3, which I sent via Zoho webmail instead of git-send-email. 
The error messages are:

```
This message was created automatically by mail delivery software.
A message that you sent could not be delivered to one or more of its recipients. This is a permanent error.

qemu-devel@nongnu.org, ERROR CODE :550 - Message headers fail syntax check
(... qemu-riscv/qemu-arm ...)

Reporting-MTA: dns; mx.zohomail.com
Arrival-Date: Wed, 28 May 2025 16:09:36 +0800

Original-Recipient: rfc822; qemu-devel@nongnu.org
Final-Recipient: rfc822; qemu-devel@nongnu.org
Status: 550
Action: failed
Last-Attempt-Date: 28 May 2025 08:11:19 GMT
Diagnostic-Code: Message headers fail syntax check
Remote-MTA: dns; eggs.gnu.org
(... qemu-riscv/qemu-arm ...)
```

And below is the email header:

```
Received: by mx.zohomail.com with SMTPS id 1748419823397138.51964085412385;
	Wed, 28 May 2025 01:10:23 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
	"Shannon Zhao" <shannon.zhaosl@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Igor Mammedov" <imammedo@redhat.com>,
	"Ani Sinha" <anisinha@redhat.com>,
	"Eduardo Habkost" <eduardo@habkost.net>,
	"Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	"Yanan Wang" <wangyanan55@huawei.com>,
	"Zhao Liu" <zhao1.liu@intel.com>,
	"Song Gao" <gaosong@loongson.cn>,
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>,
	"Sunil V L" <sunilvl@ventanamicro.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>,
	"Alistair Francis" <alistair.francis@wdc.com>,
	"Weiwei Li" <liwei1518@gmail.com>,
	"qemu-arm" <qemu-arm@nongnu.org>,
	"qemu-devel" <qemu-devel@nongnu.org>,
	"qemu-riscv" " <qemu-riscv@nongnu.org>
Cc: Li Chen <chenl311@chinatelecom.cn>
Bcc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] acpi: Add machine option to disable SPCR table
Date: Wed, 28 May 2025 16:09:36 +0800
Message-ID: <20250528080950.443075-1-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

(...subject and body...)
```

Any ideas what caused this syntax check failure? Thanks!

Regards,
Li

