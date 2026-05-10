Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FC5CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLxEU-0008AJ-SO; Sun, 10 May 2026 02:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxET-00089g-Qj
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxER-0003he-8D
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778392898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEs4n2Mw6h7n4KjyihMrCzb3vhyt5mdz2DYwyJGMSvY=;
 b=cVO6e/yICV4NYqObrMDjSvxsrjBjsSGbuu0HP4uiNuWp5ezaKdOOJA3xLg8XDRnwS8nNRW
 9VfKAD3D6I9qcJfax5BBFhP0IWZIO4un5772KsXj93xIic+OknHIr45u13LhbL790bieLQ
 Z89icrxKV62NM+UwZqJnAh/JZNT2ww0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-MkbU4DVSP6OMZ0FPjaKVdw-1; Sun,
 10 May 2026 02:01:35 -0400
X-MC-Unique: MkbU4DVSP6OMZ0FPjaKVdw-1
X-Mimecast-MFC-AGG-ID: MkbU4DVSP6OMZ0FPjaKVdw_1778392893
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45A9918005B9; Sun, 10 May 2026 06:01:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8093219560A2; Sun, 10 May 2026 06:01:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 09/28] hw/display/xenfb: Use Linux key codes
From: marcandre.lureau@redhat.com
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260509-input-v1-9-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <20260509-input-v1-9-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 10:01:15 +0400
Message-Id: <177839287566.1301060.18404851357869345635.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qjQY5UBBRwW5nVwox884+aUYYy/sdKjXjLc6sdHGpY0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAB8ux31i2OjPThwX/WvZqQBUqSbOl5VdLlH59
 QlmmwBfPa+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagAfLgAKCRDa6OEJdZac
 5Z90D/0SZReBmcadPFxXsnFC26Uuod4cS1U9BfiAD22bDyM2r1Hk/hRHn/HUrCIpOBcEnQ9jVs9
 b3ut8PDyj6TfzxCJwf1m5FEXsYov4NZYQBkYnuW+rSXY8d3kThpTy2taEUs79ysSZhvBTDF3Nqi
 lX9t5qOQ3HLJUeWzLj9+puzcqI/Q9H4/CqR+j5mJs5QfjxD/JSP3KAeHnWKnozfxixTyVWBbY90
 ZNSILV2FCZG5Qhm0pfhRIU0Hy7qpFVlvNmJyi9zo8t/0yj2aEiDl/8WQu2N/WoLQ2YqRonsSaFn
 l5ko6l6+IIJNR8TDa2IYdVox0A4tt9f29wcXM2RMCgMxn0Hkie12+lSO97rTcG/gAgJvfp34UKG
 S4M86L8TaDxeHF3VF+mdgmVvl+dXBiMVrZo3nbVBLVTf/XbNB/jPTtABxOzBtSgwkxEYUZkDEnT
 OmnXfYIS5DjZ2iecSr2onSSJktvz25/uifof78fxsiJN+LbTStP1zt/UMNmC9gxV47Mpze3Yd2L
 LUVPAk7s3zkTURip+Zi1hmRHvt8hPFs/HlaxPOelgkaJjaSpT8DNWCQ+gaOW/ykqG4NvMR3vtrU
 3FF9z1hLxBf5gCj2ZaitPFWlkNL1oTUMd3MZnriBoVvA9J1tNW43SP29VKNFen2gF4QsqYZSW9e
 cH6KiV6KlsXYJLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 09 May 2026 19:34:21 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 9bf89a1e622..ee23c483499 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -191,29 +191,14 @@ static int xenfb_send_position(struct XenInput *xenfb,
> [ ... skip 23 lines ... ]
> -            trace_xenfb_key_event(xenfb, lnx, evt->key.down);
> -            xenfb_send_key(xenfb, evt->key.down, lnx);
> -        }
> -    }
> +    trace_xenfb_key_event(xenfb, evt->key.key, evt->key.down);
> +    xenfb_send_key(xenfb, evt->key.down, evt->key.key);

As before, it should guard against KEY_RESERVED (0).

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


