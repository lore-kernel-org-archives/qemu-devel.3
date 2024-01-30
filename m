Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB98C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrZQ-0001G9-Ty; Tue, 30 Jan 2024 12:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUrZM-0001FR-UO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:06:46 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUrZF-0002dN-Qs
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:06:43 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.9.213])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 28E8E20232;
 Tue, 30 Jan 2024 17:06:33 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 18:06:32 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00106b97671-13be-4df6-aea2-ec41010faa09,
 20D2C6FF0051686532C09B7171B66A66C8D21C17) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 30 Jan 2024 18:06:30 +0100
From: Greg Kurz <groug@kaod.org>
To: Ani Sinha <anisinha@redhat.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, <qemu-trivial@nongnu.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 1/3] hw/i386: Add `\n` to hint message
Message-ID: <20240130180630.0e269e7d@bahia>
In-Reply-To: <6E771066-49E8-448D-B90A-21766B108874@redhat.com>
References: <20240130155653.142283-1-groug@kaod.org>
 <20240130155653.142283-2-groug@kaod.org>
 <6E771066-49E8-448D-B90A-21766B108874@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: cb3013dc-e91d-4a1c-a898-9d33cf76acd5
X-Ovh-Tracer-Id: 3213599812810480059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdejpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghnihhsihhnhhgrsehrvgguhhgrthdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhshhgrnhhnohhnrdiihhgrohhslhesghhmrghilhdrtghomhdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhgrghoshhonhhgsehloh
 honhhgshhonhdrtghnpdhmshhtsehrvgguhhgrthdrtghomhdpihhmrghmmhgvughosehrvgguhhgrthdrtghomhdpmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmpdhqvghmuhdqthhrihhvihgrlhesnhhonhhgnhhurdhorhhgpdgvughurghrughosehhrggskhhoshhtrdhnvghtpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 30 Jan 2024 21:43:27 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> 
> 
> > On 30-Jan-2024, at 21:26, Greg Kurz <groug@kaod.org> wrote:
> > 
> > error_fprintf() doesn't add newlines.
> 
> ^^^^^^^^^^^^^^^^^
> 
> Should be error_printf(). Ditto for other patches.
> 

Thanks. Posted a v2.

> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > hw/i386/acpi-build.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index edc979379c03..e990b0ae927f 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2697,7 +2697,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >                         " migration may not work",
> >                         tables_blob->len, legacy_table_size);
> >             error_printf("Try removing CPUs, NUMA nodes, memory slots"
> > -                         " or PCI bridges.");
> > +                         " or PCI bridges.\n");
> >         }
> >         g_array_set_size(tables_blob, legacy_table_size);
> >     } else {
> > @@ -2709,7 +2709,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >                         " migration may not work",
> >                         tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> >             error_printf("Try removing CPUs, NUMA nodes, memory slots"
> > -                         " or PCI bridges.");
> > +                         " or PCI bridges.\n");
> >         }
> >         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> >     }
> > -- 
> > 2.43.0
> > 
> 



-- 
Greg

