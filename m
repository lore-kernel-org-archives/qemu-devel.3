Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF93CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6JS-0006DH-AE; Tue, 07 Jul 2026 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh6JR-0006D6-4i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh6JO-0000VI-LR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783432689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RagEaxAEiG9XeyOZd53ViIM94pb32RaRYI5CJpqK1KQ=;
 b=CZvafLGx7P3UDnks/q9ZlxVU9xINUGx50PufHlWzU08NZUtn1HcBoRW5vdkyGJ7uTIl76M
 z4rbAsWac3IvTjZLKK1hY3HQSDx1QZ2/R3y0iH4Lc46LTFGPgfQyHGcdRYnN10Aao1sM5k
 UXj9HbiSh1LBwKSe7+EdEwubnVlmvkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-23ccRKq-NmWTErzxFrPRQA-1; Tue,
 07 Jul 2026 09:58:07 -0400
X-MC-Unique: 23ccRKq-NmWTErzxFrPRQA-1
X-Mimecast-MFC-AGG-ID: 23ccRKq-NmWTErzxFrPRQA_1783432686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C531E1806CA9; Tue,  7 Jul 2026 13:58:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53172195604B; Tue,  7 Jul 2026 13:58:04 +0000 (UTC)
Date: Tue, 7 Jul 2026 14:58:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: philmd@oss.qualcomm.com, qemu-devel@nongnu.org
Subject: Re: [philmd@linaro.org: Your email to Phil Mathieu-Daude Re: [PATCH]
 docs: outline some guidelines for security classification]
Message-ID: <ak0F6avwblY42d_O@redhat.com>
References: <20260707095144-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707095144-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 07, 2026 at 09:52:13AM -0400, Michael S. Tsirkin wrote:
> Maybe we can merge a mailmap entry so get_maintainer DTRT? Thanks!

This case was my fault for cut & pasting his address from an outdated
source, rather than get_maintainer.

> ----- Forwarded message from Philippe Mathieu-Daudé <philmd@linaro.org> -----
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date: Tue, 7 Jul 2026 06:43:21 -0700
> To: mst@redhat.com
> Subject: Your email to Phil Mathieu-Daude Re: [PATCH] docs: outline some guidelines for security classification
> Message-ID: <CAPMQPEJDi9d_mTpvfsYRJRLmBxkthBMPF_XV3n7_q2nonHxzvQ@mail.gmail.com>
> 
> Thank you for your email.
> 
> Phil Mathieu-Daude no longer works for Linaro.
> 
> If your email is related to Linaro business, please use the Contact
> form (https://www.linaro.org/contact/) if you do not have another
> Linaro email address to use.
> 
> Thank you.
> 
> ----- End forwarded message -----
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


