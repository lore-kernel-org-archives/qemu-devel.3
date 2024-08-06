Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C68C52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDO6-0002Fy-VG; Tue, 06 Aug 2024 02:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbDO5-0002Dt-CU; Tue, 06 Aug 2024 02:09:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbDO3-0001XP-Rz; Tue, 06 Aug 2024 02:09:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 08CA260ED5;
 Tue,  6 Aug 2024 06:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38BAC32786;
 Tue,  6 Aug 2024 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722924573;
 bh=WdUQXtCTwgFQAc0kxtSdRM0UmI9ZDfDvqTso1AuHq4I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OSzKUNwynmDwBT77gK1GM8p0fXbTxR0IULEdL5T9b0U6fy5Wg7cEisPBWbUQfnU96
 5cBgNyFVd2YfbHFKQKNyGXnCvPSiwpUGha9dg8wKTayJIr6v/8PbISV7TTWc28u/Nz
 shI24RkQqr/yU+uwSlSu08flS36BB4zVcjohiOkj+uW3HaL0tsle4I1HE3sBMkZ2oK
 sUPd5MdB0/YWgDOBmyXnVWuaLq1BqV2lPAUJS08OekqOPsH7uvBKNx3dkXqn5IoZ58
 hGEmH/2+RRIXH2/03lY8o05eNxSLar7nC6ds2cLA82CsSLf4xjPlv3FbvercrK/bls
 8BuzLx9GZb2bQ==
Date: Tue, 6 Aug 2024 08:09:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806080928.5a04c550@foz.lan>
In-Reply-To: <20240805175617.000036ce@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
 <20240805175617.000036ce@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Mon, 5 Aug 2024 17:56:17 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri,  2 Aug 2024 23:43:59 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Add error notification to GHES v2 using the GPIO source.  
> 
> The gpio / external interrupt follows through.

True. As session 18.3.2.7 of the spec says:

	The OSPM evaluates the control method associated with this event 
	as indicated in The Event Method for Handling GPIO Signaled Events 
	and The Event Method for Handling Interrupt Signaled Events.

E. g. defining two methods:
	- GED GPIO;
	- GED interrupt

I'm doing this rename:

	ACPI_HEST_SRC_ID_GPIO -> ACPI_HEST_SRC_ID_GED_INT

To clearly state what it is implemented there.

I'm also changing patch description to:

    acpi/ghes: Add support for General Purpose Event
    
    As a GED error device is now defined, add another type
    of notification.
    
    Add error notification to GHES v2 using the GPIO source.
    
    [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
     rename HEST event to better identify GED interrupt OSPM]

    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Regards,
Mauro

