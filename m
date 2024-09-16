Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F81BC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 13:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqBYx-0006Dx-7z; Mon, 16 Sep 2024 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqBYp-000691-53; Mon, 16 Sep 2024 09:14:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqBYi-0006iX-Gt; Mon, 16 Sep 2024 09:14:34 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X6lk6209Hz4wd6;
 Mon, 16 Sep 2024 23:14:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6lk36z2Pz4x21;
 Mon, 16 Sep 2024 23:14:19 +1000 (AEST)
Message-ID: <00b812a8-48ba-4d51-bb4d-30d7e461c907@kaod.org>
Date: Mon, 16 Sep 2024 15:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/49] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-21-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240219082938.238302-21-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=CK3F=QO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Harsh,

On 2/19/24 09:29, Nicholas Piggin wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> pseries machines before version 2.11 have undergone many changes to
> correct issues, mostly regarding migration compatibility. This is
> obfuscating the code uselessly and makes maintenance more difficult.
> Remove them and only keep the last version of the 2.x series, 2.12,
> still in use by old distros.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/ppc/spapr.c            | 1 +
>   roms/skiboot              | 2 +-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 5a2305ccd6..36bd3e15ef 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -229,6 +229,14 @@ The Nios II architecture is orphan.
>   The machine is no longer in existence and has been long unmaintained
>   in QEMU. This also holds for the TC51828 16MiB flash that it uses.
>   
> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Older pseries machines before version 2.12 have undergone many changes
> +to correct issues, mostly regarding migration compatibility. These are
> +no longer maintained and removing them will make the code easier to
> +read and maintain. Use versions 2.12 and above as a replacement.
> +

Would you have time, or a KVM PPC team member, to start removing
the now deprecated pseries machines in the QEMU 9.2 cycle ?

Thanks,

C.



