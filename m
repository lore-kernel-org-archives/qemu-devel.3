Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF33EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWry-0001rV-8v; Thu, 01 Aug 2024 10:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sZWrr-0001n2-2d; Thu, 01 Aug 2024 10:33:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sZWrm-0006Jy-Rm; Thu, 01 Aug 2024 10:33:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZWb307f0z687SH;
 Thu,  1 Aug 2024 22:30:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A2E931400F4;
 Thu,  1 Aug 2024 22:32:58 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 15:32:58 +0100
Date: Thu, 1 Aug 2024 15:32:57 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240801153257.00006e30@Huawei.com>
In-Reply-To: <20240801145637.03c34fd3@foz.lan>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
 <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
 <20240801145637.03c34fd3@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
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

On Thu, 1 Aug 2024 14:56:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 30 Jul 2024 10:40:28 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > index 674f6958e905..4f1ab1a73a06 100644
> > > --- a/include/hw/acpi/ghes.h
> > > +++ b/include/hw/acpi/ghes.h
> > > @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
> > >  
> > >  enum {
> > >      ACPI_HEST_SRC_ID_SEA = 0,
> > > +    ACPI_HEST_SRC_ID_GPIO = 1,    
> > is it defined by some spec, or just a made up number?  
> 
> I don't know. Maybe Jonathan or Shiju knows better, as the original patch
> came from them, but I didn't find any parts of the ACPI spec defining the
> values for source ID.

> 
> Checking at build_ghes_v2() implementation, this is used on two places:
> 
> 1. as GHESv2 source ID:
>     /*
>      * Type:
>      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
>      */
>     build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
>     /* Source Id */
>     build_append_int_noprefix(table_data, source_id, 2);
>     /* Related Source Id */
>     build_append_int_noprefix(table_data, 0xffff, 2);
> 
> as an address offset:
> 
>     address_offset = table_data->len;
>     /* Error Status Address */
>     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                      4 /* QWord access */, 0);
>     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>         ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> 
> So, if I had to guess, I'd say that this was made up, in a way that
> the size of the table will fit just two sources, starting from zero.
> 
> So, I'll change the code to just:
> 
> 	enum {
>             ACPI_HEST_SRC_ID_SEA = 0,
>             ACPI_HEST_SRC_ID_GPIO, 

LGTM.  The naming is perhaps not ideal but the scheme predates my
involvement so I'm not sure of the reasoning.  Could change it
to QEMU_ACPI...
to make it really really clear these aren't an ACPI spec thing, but
may not be worth it.

J

> 	    /* future ids go here */
> 	    ACPI_HEST_SRC_ID_RESERVED,
> 	};
> 
> To remove the false impression that this could be originated from the
> spec.
> 
> Thanks,
> Mauro
> 


