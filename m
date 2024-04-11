Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0E9CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurGt-00034v-Io; Thu, 11 Apr 2024 06:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rurGr-00034O-VT
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rurGq-0005Re-FZ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712829783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsKRHfVFY1S1SwAai119QOi6hYJhCEIaE8J48KyCgKg=;
 b=QHkKAq5jsDFu1R3YHsGUr1/Ke1tBl1QK3Tr0Wd8xINKO/VruPUufd27qdelQOYzcbdj40J
 GiKdb+uDrfkfC06DnwPZKOAP8lOu40TTt9Pj0O/epFPPY3fbCf/GuoPpUCBfxbwd2eYkO0
 OjXHJNv8KP1/KPk+1rg6/RFqe2ZnMto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-HcLHS3cANuOaFO6LdG3srA-1; Thu, 11 Apr 2024 06:03:00 -0400
X-MC-Unique: HcLHS3cANuOaFO6LdG3srA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5752802A6F;
 Thu, 11 Apr 2024 10:02:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74FA32166B31;
 Thu, 11 Apr 2024 10:02:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 42418180063D; Thu, 11 Apr 2024 12:02:54 +0200 (CEST)
Date: Thu, 11 Apr 2024 12:02:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 01/12] ui/console-vc: Replace sprintf() by
 g_strdup_printf()
Message-ID: <spbj5olgyvktcaaardmh3mgkylkwtby5bsvyxtbtt3iktnm234@3xmownbeuu3c>
References: <20240410160614.90627-1-philmd@linaro.org>
 <20240410160614.90627-2-philmd@linaro.org>
 <dx3zdfuwz7gam7brijaqfd4kg4uttybr2s2pjonhl4twyivhf3@afcjz4iulzcn>
 <4c683f51-fe0f-4ef9-b424-aee8a859df0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c683f51-fe0f-4ef9-b424-aee8a859df0e@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 11, 2024 at 11:36:10AM +0200, Philippe Mathieu-Daudé wrote:
> On 11/4/24 09:47, Gerd Hoffmann wrote:
> >    Hi,
> > 
> > >      Due to security concerns inherent in the design of sprintf(3),
> > >      it is highly recommended that you use snprintf(3) instead.
> > 
> > > -    char response[40];
> > > +    g_autofree char *response = NULL;
> > 
> > > -                    sprintf(response, "\033[%d;%dR",
> > > +                    response = g_strdup_printf("\033[%d;%dR",
> > 
> > Any specific reason why you don't go with the recommendation above?
> > 
> > While using g_strdup_printf() isn't wrong it allocates memory which
> > is not needed here because you can continue to use the stack buffer
> > this way:
> > 
> > 	snprintf(response, sizeof(response), ...);
> 
> I thought GLib/GString was recommended for formatting,

If you allocate the output buffer anyway (and there are patches in this
series where this is the case) it's clearly better to use
g_strdup_printf instead of malloc + snprintf.

In case a fixed-size buffer can be used I wouldn't switch to dynamic
allocation ...

take care,
  Gerd


