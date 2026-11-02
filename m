Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADC60A2618
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KNLlNO3Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNshn-0007qd-Fq; Mon, 02 Nov 2026 09:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshh-0007nH-D6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshf-0005B3-W8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERGcnspRdMZgREuK6ajaeWJ8EJgrkzIX+zoK92LO4lY=;
 b=KNLlNO3Y1aaHuAr9UDCzrD+vN2cZadpK3IwsIozCojSVT44VGPlPa0hXlmHvzJe59Lv7Lo
 wsHP4A9MTf45B2GoE9gZAyV9zWMlrqvprWuytzhyRdO4cZFE5KG7PuYsZWNWuUiX7WVZJb
 oCMSj0MI4p4iGMiHaSG0lDbd7zj6DvI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-utjxyXUMPkCZ29kxY1estw-1; Mon,
 02 Nov 2026 09:07:58 -0500
X-MC-Unique: utjxyXUMPkCZ29kxY1estw-1
X-Mimecast-MFC-AGG-ID: utjxyXUMPkCZ29kxY1estw_1793628475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3861955BC1; Mon,  2 Nov 2026 14:07:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 046AD1956087; Mon,  2 Nov 2026 14:07:53 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 05/18] hw/usb/hcd-ohci: Add an auto-hub property and
 leave it off
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-6-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-6-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845010.3960472.4266154712960924675.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F+Y/7oWbL8SBL0XFLzDglAlN+n7OEfdEp2LujSibKlA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkvWPU+1uMT6MiAhZUb7waFsniXeuOw3woh
 sr/yLxvwfGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5XaQEACAAe4ccYhh8K8bFsPg+Wt7NK/vwPZYr8TK2vfzGAaiDl3S3aB4O/fQq7VxEoukWb1KjEz
 k+fiipFdAb6NneVOHgIHlW1m8w9paiOXPFpoRYDl1CyGx1FV5jtg3pvo5S/iUuhZC8s+1v2rgkl
 DdVoYFlQ4VVKt2SILbwtAeWAeDoI73AiEYN1SvPrhMlUYtmTjd11Jv/JEgmTLp6oTBqXb9S0LoV
 /Z/zS9g18j2lZt6nlfDBCToUOUA+vkoVBQabDieg77grSq5Av62YrkycnGUSA2+DZozKcpaPRNS
 cFC/nvb5s2seg1eWR5LBjpsaOuwofYU49UrYV9LIS/0DUHohTh1RgwSKllhenUl4lD/UXCZ0Dbp
 q9JoCIkLUQx6kIs/wVH44is7/1LzwZoZrGgSLZzaJNd5k6olqhH4rkDLNtkPAd2mt5AopP+H7w3
 A8oJg+V88NWWJ9OaBV0ULs8qES0os1cf59LemQUokJmvkS9q2jPMyDFrARTBPalF6eyPBGP7Arr
 vPSAZEldqvJcjt0RlzVU9V02xjVPY+KtQG8ow5lsF1NRD5LFyMgaRm7EGIaO6GFgc5S3OontUou
 PbWSfwqHh8QFsWAsfeOnrExuO7AVQvWPAQ6+W1SGabVX9HTEZIT3PMiCEtXVrQnNpTHWYNrR2bf
 +Oc4DzNpXsxR73g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add auto-hub and leave it off. hw_compat_11_1 turns it on for
> pci-ohci and sysbus-ohci, so an older machine type keeps the hub it
> has today and a guest saved by an older QEMU still loads.
> 
> pc87560-ohci is its own PCI front end, not a pci-ohci, so it defines
> the property itself.
> 
> A companion OHCI adds its ports to the EHCI bus instead of making one,
> so there the EHCI property decides.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261102092201.1729245-6-jamin_lin@aspeedtech.com>
> ---
>  hw/usb/hcd-ohci.h        | 1 +
>  hw/core/machine.c        | 2 ++
>  hw/usb/hcd-ohci-pci.c    | 1 +
>  hw/usb/hcd-ohci-sysbus.c | 1 +
>  hw/usb/hcd-ohci.c        | 1 +
>  hw/usb/pc87560-ohci.c    | 1 +
>  6 files changed, 7 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f79337e7d774..22d2b834595a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -47,6 +47,8 @@ GlobalProperty hw_compat_11_1[] = {
>      { "pci-ehci-usb", "auto-hub", "on" },
>      { "base-xhci", "auto-hub", "on" },
>      { "pci-uhci-usb", "auto-hub", "on" },
> +    { "sysbus-ohci", "auto-hub", "on" },
> +    { "pci-ohci", "auto-hub", "on" },

So it also needs pc87560-ohci, no?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


