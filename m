Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FF2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2iD-0006FO-U7; Thu, 08 Aug 2024 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2i8-0006Dk-KS; Thu, 08 Aug 2024 08:57:45 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2i6-0001qj-PP; Thu, 08 Aug 2024 08:57:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 68DA861653;
 Thu,  8 Aug 2024 12:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBF9C32782;
 Thu,  8 Aug 2024 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723121860;
 bh=Iktp01tK2DrO7g0ygEnpzyl+ejX/bXOo+4ZZZfl+E4k=;
 h=Date:From:Cc:Subject:In-Reply-To:References:From;
 b=jL7xCT1B8q7RbQQW3OONnhAcTRkSRqvyC5YB5ObWzYkYd6L5XR5GengkzYhIpRhaJ
 FdCQE0jfyjnGZ2AFjZ2UFaz7zHJbOlRB41xl9BgqvMwD3AwQx8ssplaGmpsY48GISB
 dmj17vxv8evvsvoCGbho72fb9+dZU7e9vmKevXD0vX4oMrvk939pk1APCwCAn2oRX0
 ELWffz5j60nuvSZQ+Oh6FBSOXF+FTW57YqbwdX90mtSQMQr9CAk8wzFtUo3L0ll6jt
 BJO7SwWcin1nUVjzRyedOm5SahZzpx/SIlNaObVG5C8j3y6NebrT5dzyC/MOvVTNpd
 A9N8g5hx1h6xw==
Date: Thu, 8 Aug 2024 14:57:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/10] Add ACPI CPER firmware first error injection
 on ARM emulation
Message-ID: <20240808145735.70f81f76@foz.lan>
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Thu,  8 Aug 2024 14:26:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> v6:
> - PNP0C33 device creation moved to aml-build.c;
> - acpi_ghes record functions now use ACPI notify parameter,
>   instead of source ID;
> - the number of source IDs is now automatically calculated;
> - some code cleanups and function/var renames;
> - some fixes and cleanups at the error injection script;
> - ghes cper stub now produces an error if cper JSON is not compiled;
> - Offset calculation logic for GHES was refactored;
> - Updated documentation to reflect the GHES allocated size;
> - Added a x-mpidr object for QOM usage;
> - Added a patch making usage of x-mpidr field at ARM injection
>   script;

Forgot to mention: I dropped the PIN cleanup from this series, submitting 
it in separate - and it is not related anymore with this changeset:

https://lore.kernel.org/qemu-devel/ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org/T/#u

Thanks,
Mauro

