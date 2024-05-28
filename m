Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885BFC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtfi-0004te-Q0; Tue, 28 May 2024 06:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtfg-0004tA-Pj
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtff-0002V4-6s
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yfXwYzIN3h1AEDstyU9OVYoSktlXfyYCMnVX54LgpZU=;
 b=LKN1uSjxTdJI1df15zKOMvRcTgdbM2Ow9m0xcT7tz5JPDFPKUWirGB07zW+ykdDNZkvxmY
 XEWFaOLl6fqVkpCkjKoVwQZL7UI/wMq/pe9+q3KHpucmvN5LhcfLpJWOcvJSLyw047IIhx
 UI+wybpEA+8Q49Rk7pu2WwF/J2nPKv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-8aQlBRY2Myu8Hb_-unjzPQ-1; Tue, 28 May 2024 06:03:01 -0400
X-MC-Unique: 8aQlBRY2Myu8Hb_-unjzPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B651E8058D1;
 Tue, 28 May 2024 10:03:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B63492BC6;
 Tue, 28 May 2024 10:03:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A907518009F4; Tue, 28 May 2024 12:02:59 +0200 (CEST)
Date: Tue, 28 May 2024 12:02:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v2 1/4] MAINTAINERS: drop audio maintainership
Message-ID: <bixbyxczbjxaxvnlt5zj42g474qi2kbus5fzr7ojzuomrm2372@gjrpjzvbdx6q>
References: <20240528083858.836262-1-kraxel@redhat.com>
 <20240528083858.836262-2-kraxel@redhat.com>
 <CAAjaMXaucLgfWVuf96ZbjDyXxw3yZ-yzuJeZGK66ib0oCq6r6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjaMXaucLgfWVuf96ZbjDyXxw3yZ-yzuJeZGK66ib0oCq6r6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  Hi,

> >  virtio-snd
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> > -R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +R: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> >  S: Supported
> >  F: hw/audio/virtio-snd.c
> >  F: hw/audio/virtio-snd-pci.c
> 
> While extra reviewers are always helpful, someone like Volker would
> make sense, not someone without any contributions:

Matias volunteered to help (via reply to v1 of the series), and for
'reviewer' role I don't see a reason to be strict.  'Maintainer' would
be a different story of course.

If Volker wants step up (I see you cc'ed him already) I happily add
him too.

take care,
  Gerd


