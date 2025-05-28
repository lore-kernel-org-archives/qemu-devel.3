Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C630C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEYC-00026n-2V; Wed, 28 May 2025 07:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKEXr-000251-Td
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:02:07 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKEXm-0000EY-9L
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748430109; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dczlbXCtHutwmBPHRcJ1+RsizEDAapsPdthpNH1tpaUbP8+X5qUKanFH6QThZHpRkNvD7AAhgwctTifCZH3jW73N0MVFrvpt3x/tTm26ND7TOPZ058zZZNA1ouucpCSUHHDU0MMUtCZ7FmfFCQ4wnccnqJsCKAaBOsC3sz06o6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748430109;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uaYnYSNPBkzXrvW5M/63L1bxyIYPFwzX+ssH5+Y5Zyo=; 
 b=AVX9thqKNqkLAhZFWwR5xcAKQXDu23hPAaR3AtSPlKO4MhUJMxzA7a+4/PPkJGycEwNYs1kYQywxAqHGErvOBmmIocIAVpGKoqmNZ+oaqpyB4i1AfJB46qTo3OPga9PYhKlg4VXvBFP0lmTHV1muGl4yeljjCvmDXkFBh1eiQkA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748430109; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uaYnYSNPBkzXrvW5M/63L1bxyIYPFwzX+ssH5+Y5Zyo=;
 b=flpe8XTirdDI8c19lcIEJ2HjnS6GY2NxgdwveonmHmiuODEYnGuHBG1KPTf6ELUK
 ygGMX063h6QvjZXm+UH+pdLrBtngVgkGTzsONAlchiMPy04mAMU8mOMRiOMz/I2yskd
 jesVEAzwRLcc/Zt9XLg9ghhlv+7t26IKUni5ucGY=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1748430107024905.4658507757017;
 Wed, 28 May 2025 04:01:47 -0700 (PDT)
Date: Wed, 28 May 2025 19:01:46 +0800
From: Li Chen <me@linux.beauty>
To: "Thomas Huth" <thuth@redhat.com>
Cc: "Qemu devel" <qemu-devel@nongnu.org>
Message-ID: <197168e316f.1218d3d6f2931175.5928950932058477287@linux.beauty>
In-Reply-To: <e58a98e5-c6ae-456f-aaa5-c55924517665@redhat.com>
References: <1971648603b.dce1f5d22901195.6702025346547333607@linux.beauty>
 <e58a98e5-c6ae-456f-aaa5-c55924517665@redhat.com>
Subject: Re: Get "Message headers fail syntax check" error when using
 git-send-email
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Thomos,

 ---- On Wed, 28 May 2025 17:52:50 +0800  Thomas Huth <thuth@redhat.com> wrote --- 
 > On 28/05/2025 11.45, Li Chen wrote:
 > > Hi,
 > > 
 > > My emails to the qemu-devel, qemu-riscv, and qemu-arm mailing lists regarding the
 > > "[PATCH v4 0/4] acpi: Add machine option to disable SPCR table" series are being
 > > rejected by these mailing lists, while other recipients are unaffected.
 > > This issue didn't occur with versions v1-v3, which I sent via Zoho webmail instead of git-send-email.
 > > The error messages are:
 > > 
 > > ```
 > > This message was created automatically by mail delivery software.
 > > A message that you sent could not be delivered to one or more of its recipients. This is a permanent error.
 > > 
 > > qemu-devel@nongnu.org, ERROR CODE :550 - Message headers fail syntax check
 > > (... qemu-riscv/qemu-arm ...)
 > > 
 > > Reporting-MTA: dns; mx.zohomail.com
 > > Arrival-Date: Wed, 28 May 2025 16:09:36 +0800
 > > 
 > > Original-Recipient: rfc822; qemu-devel@nongnu.org
 > > Final-Recipient: rfc822; qemu-devel@nongnu.org
 > > Status: 550
 > > Action: failed
 > > Last-Attempt-Date: 28 May 2025 08:11:19 GMT
 > > Diagnostic-Code: Message headers fail syntax check
 > > Remote-MTA: dns; eggs.gnu.org
 > > (... qemu-riscv/qemu-arm ...)
 > > ```
 > > 
 > > And below is the email header:
 > > 
 > > ```
 > > Received: by mx.zohomail.com with SMTPS id 1748419823397138.51964085412385;
 > >     Wed, 28 May 2025 01:10:23 -0700 (PDT)
 > > From: Li Chen <me@linux.beauty>
 > > To: "Peter Maydell" <peter.maydell@linaro.org>,
 > >     "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 > >     "Michael S. Tsirkin" <mst@redhat.com>,
 > >     "Igor Mammedov" <imammedo@redhat.com>,
 > >     "Ani Sinha" <anisinha@redhat.com>,
 > >     "Eduardo Habkost" <eduardo@habkost.net>,
 > >     "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 > >     =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 > >     "Yanan Wang" <wangyanan55@huawei.com>,
 > >     "Zhao Liu" <zhao1.liu@intel.com>,
 > >     "Song Gao" <gaosong@loongson.cn>,
 > >     "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 > >     "Sunil V L" <sunilvl@ventanamicro.com>,
 > >     "Palmer Dabbelt" <palmer@dabbelt.com>,
 > >     "Alistair Francis" <alistair.francis@wdc.com>,
 > >     "Weiwei Li" <liwei1518@gmail.com>,
 > >     "qemu-arm" <qemu-arm@nongnu.org>,
 > >     "qemu-devel" <qemu-devel@nongnu.org>,
 > >     "qemu-riscv" " <qemu-riscv@nongnu.org>
 > 
 > Blind guess: You've got a stray " in above qemu-riscv line.

Nice Catch! I repost this series after removing the redundant " and it just works! Thanks a lot!

Regards,
Li 

