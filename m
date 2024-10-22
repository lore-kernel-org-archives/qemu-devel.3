Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D93D2C561
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3G7P-0005iQ-9L; Tue, 22 Oct 2024 10:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t3G7D-0005hS-MT; Tue, 22 Oct 2024 10:44:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t3G75-0000QV-5k; Tue, 22 Oct 2024 10:44:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXvzl2XJ9z6JB90;
 Tue, 22 Oct 2024 22:42:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B9FC714039E;
 Tue, 22 Oct 2024 22:43:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 16:43:53 +0200
Date: Tue, 22 Oct 2024 15:43:52 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Ma?=
 =?ISO-8859-1?Q?thieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S.Tsirkin " <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <qemu-riscv@nongnu.org>, <qemu-arm@nongnu.org>,
 "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 1/9] i386/cpu: Don't enumerate the "invalid" CPU
 topology level
Message-ID: <20241022154352.00001a4e@Huawei.com>
In-Reply-To: <20241022135151.2052198-2-zhao1.liu@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
 <20241022135151.2052198-2-zhao1.liu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Resend. Claws-mail is still chewing up the to list for unknown reasons
and I forgot to fix it by hand.

On Tue, 22 Oct 2024 21:51:43 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> In the follow-up change, the CPU topology enumeration will be moved to
> QAPI. And considerring "invalid" should not be exposed to QAPI as an
> unsettable item, so, as a preparation for future changes, remove
> "invalid" level from the current CPU topology enumeration structure
> and define it by a macro instead.
> 
> Due to the removal of the enumeration of "invalid", bit 0 of
> CPUX86State.avail_cpu_topo bitmap will no longer correspond to "invalid"
> level, but will start at the SMT level. Therefore, to honor this change,
> update the encoding rule for CPUID[0x1F].
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

The drop of the invalid level == 0 seems reasonable to me
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

