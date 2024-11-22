Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92425E65D3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 09:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQ2C-0006vn-Dl; Fri, 22 Nov 2024 04:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tEQ2A-0006vI-9Z; Fri, 22 Nov 2024 04:33:02 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tEQ28-00046s-HN; Fri, 22 Nov 2024 04:33:02 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 846A9A40B54;
 Fri, 22 Nov 2024 09:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DAC4CECE;
 Fri, 22 Nov 2024 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732267978;
 bh=T7xjCoT1gSzZczvGnuo2h0UKlSlVQBVAb2ODDoOJw7E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dFnVG9JydNxOkI9IcMrc6tSSTfPvRY820z//xZiXM4LRhOBK+QSHOpoFShEPZT8Rd
 7X1GkaMEoMRoXSQPvfj4VZtQU3Bmt6+33MThK64Hravl8VsDY1j3xhbirZvVoeTQMy
 H8dntZIOKz4lxxrDjyS0x06f5jixwX5pghf+nBhGsNn3nsXGfFWNjhMr59nzKYXK8d
 YRYDHXuljFYtsK6WNv5G6svznNOCNI7zuEhNOixw0bP/fe9nGTPwraA5bki/fLUKYh
 6X4TRI3IIrO7/mj5xJqgaPJtjU16MioxcQvwcGApzEHGyxLMhm8ihewj0UfDBzMxXI
 urpExye60hXOA==
Date: Fri, 22 Nov 2024 10:32:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/6] acpi/ghes: rename the function which gets hw error
 offsets
Message-ID: <20241122103253.1a1e7551@foz.lan>
In-Reply-To: <20241120143308.00005c31@huawei.com>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
 <3dccd08b82755bd42ab61408d5d86b2bfe2f2f01.1731486604.git.mchehab+huawei@kernel.org>
 <20241120143308.00005c31@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Wed, 20 Nov 2024 14:33:08 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Wed, 13 Nov 2024 09:37:00 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Rename: get_ghes_offsets->get_hw_error_offsets
> > to make clear that this function return offsets based on the
> > hardware error firmware.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As there were changes at the cleanup series, I ended merging this one
there on patch 13/15:

	https://lore.kernel.org/qemu-devel/e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org/T/#u
	
Thanks,
Mauro

