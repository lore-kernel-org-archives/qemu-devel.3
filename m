Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C42CC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnt6-0000ki-7s; Thu, 23 Jul 2026 03:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wmnsg-0000Z5-T3; Thu, 23 Jul 2026 03:30:11 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wmnsc-0006pQ-MU; Thu, 23 Jul 2026 03:30:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EFC54114E;
 Thu, 23 Jul 2026 07:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA021F000E9;
 Thu, 23 Jul 2026 07:29:55 +0000 (UTC)
Date: Thu, 23 Jul 2026 09:29:53 +0200
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Lukas Straub <lukasstraub2@web.de>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, Markus
 Armbruster <armbru@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Alex
 Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna
 Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Igor
 Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, linux-edac@vger.kernel.org, =?UTF-8?B?TWFy?=
 =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 02/44] qapi: convert intro sections for acpi-hest.json
Message-ID: <20260723092953.1affa5dd@foz.lan>
In-Reply-To: <20260723044805.527643-3-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-3-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:  Mauro Carvalho Chehab via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 23 Jul 2026 00:47:23 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/acpi-hest.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> index a01f1dee095..8db804df197 100644
> --- a/qapi/acpi-hest.json
> +++ b/qapi/acpi-hest.json
> @@ -13,8 +13,8 @@
>  
>  ##
>  # @inject-ghes-v2-error:
> -#
> -# Inject an error with additional ACPI 6.1 GHESv2 error information
> +#     Inject an error with additional ACPI 6.1 GHESv2 error
> +#     information
>  #
>  # @cper: contains a base64 encoded string with raw data for a single
>  #     CPER record with Generic Error Status Block, Generic Error Data
LGTM.

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro

