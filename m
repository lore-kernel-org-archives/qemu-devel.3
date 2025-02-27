Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF2C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 11:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnc7f-0001oL-Qs; Thu, 27 Feb 2025 06:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnc7d-0001ne-U8; Thu, 27 Feb 2025 06:32:10 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnc7b-0004kj-TK; Thu, 27 Feb 2025 06:32:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D1E561521;
 Thu, 27 Feb 2025 11:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EEAC4CEE4;
 Thu, 27 Feb 2025 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740655924;
 bh=4pQJjF/Q4Q3WBRwJ6HQNWdlWY6WeeaYy/8fF3m2MQs8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b0xJdobA/gWddOf5S4ioanDDgZe0aVgoVbbx1BL7i1rGeCzvnUTTbp6HSFUxLFcz8
 zjhUDNlnIAHpVBAJey2QdC9/aH3Hlc4LwvfeqAOQOavUbFwxgzlCupE6T7PduKk5N1
 ysUy6opDNfIzKwL4cpFd7VBmS2JRh0Mov83pfW2FGn7DeuRVd7mu5tB+6BQVhstCbh
 Q9qeWKYagE/DxGHsENEzU6kCfPaVc1HZtiGc3+m3Mh6JIDc41w18yasE7YZWNiAr2A
 5s6S74eP3FvYEajG7jO69Di0B5+ooeKvNgeX6+aYDVNOwzjThv4LSC+woAFD9Yu8g6
 aaiw2kKp1giuQ==
Date: Thu, 27 Feb 2025 12:31:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/21] acpi/ghes: create an ancillary
 acpi_ghes_get_state() function
Message-ID: <20250227123159.46cf9b72@foz.lan>
In-Reply-To: <a84cb4567f087231991ce05980d2f331b772dab5.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <a84cb4567f087231991ce05980d2f331b772dab5.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Thu, 27 Feb 2025 12:03:40 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Instead of having a function to check if ACPI is enabled
> (acpi_ghes_present), change its logic to be more generic,
> returing a pointed to AcpiGhesState.
> 
> Such change allows cleanup the ghes GED state code, avoiding
> to read it multiple times, and simplifying the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by:  Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index c3a64adfe5ed..0135ac844bcf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -608,7 +608,7 @@ AcpiGhesState *acpi_ghes_get_state(void)
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    if (!ags->hw_error_le) {
> +    if (!ags->hw_error_le && !ags->hest_addr_le) {
>          return NULL;
>      }
>      return ags;

Sorry, I moved most of the stuff on this patch to 
	[PATCH 04/21] acpi/ghes: Cleanup the code which gets ghes ged state

This hunk was a left over from it. I was meant to place this hunk
elsewhere but I ended forgetting while waiting for the rebase bisect
tests to pass.

 I'll move this hunk to
	[PATCH 06/21] acpi/ghes: add a firmware file with HEST address

for the next respin (and hopefully the final one).

Regards,
Mauro

