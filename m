Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB9EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOWv-0004zm-M1; Wed, 11 Sep 2024 10:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1soOT1-0000Bo-ER; Wed, 11 Sep 2024 10:37:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1soOSx-0005F4-3N; Wed, 11 Sep 2024 10:37:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE1A04E601D;
 Wed, 11 Sep 2024 16:10:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 2a5-7Dj__MKk; Wed, 11 Sep 2024 16:10:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7534F4E600E; Wed, 11 Sep 2024 16:10:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7180A746F60;
 Wed, 11 Sep 2024 16:10:07 +0200 (CEST)
Date: Wed, 11 Sep 2024 16:10:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>, 
 Hyman Huang <yong.huang@smartx.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Michael Rolnik <mrolnik@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, 
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Klaus Jensen <its@irrelevant.dk>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 20/39] hw/ppc: replace assert(false) with
 g_assert_not_reached()
In-Reply-To: <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
Message-ID: <232858c7-6270-f763-adfc-b6c8259bf021@eik.bme.hu>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Tue, 10 Sep 2024, Pierrick Bouvier wrote:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
> hw/ppc/spapr_events.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index cb0eeee5874..38ac1cb7866 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -645,7 +645,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>         /* we shouldn't be signaling hotplug events for resources
>          * that don't support them
>          */
> -        g_assert(false);
> +        g_assert_not_reached();
>         return;
>     }

If break does not make sense after g_assert_not_reached() and removed then 
return is the same here.

It may make the series shorter and easier to check that none of these are 
missed if this is done in the same patch where the assert is changed 
instead of separate patches. It's unlikely that the assert change and 
removal of the following break or return would need to be reverted 
separately so it's a simple enough change to put in one patch in my 
opinion but I don't mink if it's kept separate either.

Regards,
BALATON Zoltan

