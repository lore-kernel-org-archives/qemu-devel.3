Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B0DCAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uys9Q-00043t-PA; Wed, 17 Sep 2025 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uys9H-0003wk-TF; Wed, 17 Sep 2025 09:24:40 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uys9F-0001UD-UO; Wed, 17 Sep 2025 09:24:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRfYc1PwSz6M4ks;
 Wed, 17 Sep 2025 21:21:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CF4CE1400F4;
 Wed, 17 Sep 2025 21:24:28 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 15:24:25 +0200
Date: Wed, 17 Sep 2025 14:24:24 +0100
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, "=?ISO-8859-1?Q?C=E9dric?= Le
 Goater" <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Auger
 <eric.auger@redhat.com>, Helge Deller <deller@gmx.de>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, =?ISO-8859-1?Q?Herv?=
 =?ISO-8859-1?Q?=E9?= Poussineau <hpoussin@reactos.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, =?ISO-8859-1?Q?Cl=E9m?= =?ISO-8859-1?Q?ent?=
 Mathieu--Drif <clement.mathieu--drif@eviden.com>, Nicholas Piggin
 <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, Gautam Menghani
 <gautam@linux.ibm.com>, Song Gao <gaosong@loongson.cn>, Bibo Mao
 <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "Fan Ni"
 <fan.ni@samsung.com>, David Hildenbrand <david@redhat.com>, "Igor Mammedov"
 <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Strahinja Jankovic
 <strahinja.p.jankovic@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Laurent Vivier <laurent@vivier.eu>, Andrey
 Smirnov <andrew.smirnov@gmail.com>, "Aurelien Jarno" <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, Jagannathan Raman <jag.raman@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "Halil Pasic"
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Fam Zheng" <fam@euphon.net>, Bin Meng
 <bmeng.cn@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Peter Xu <peterx@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Max Filippov" <jcmvbkbc@gmail.com>,
 <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, <qemu-block@nongnu.org>, <kvm@vger.kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH 13/35] hw/mem: QOM-ify AddressSpace
Message-ID: <20250917142424.000019d3@huawei.com>
In-Reply-To: <20250917-qom-v1-13-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-13-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Sep 2025 21:56:25 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> Make AddressSpaces QOM objects to ensure that they are destroyed when
> their owners are finalized and also to get a unique path for debugging
> output.
> 
> The name arguments were used to distinguish AddresSpaces in debugging
> output, but they will represent property names after QOM-ification and
> debugging output will show QOM paths. So change them to make them more
> concise and also avoid conflicts with other properties.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Assuming the fundamental change makes sense (which I haven't looked into in
enough depth!), this CXL bit looks fine to me.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 


