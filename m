Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF0C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5rb-0002mP-Pf; Thu, 23 May 2024 06:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1sA5ra-0002m5-6P
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:39:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1sA5rY-00038I-AR
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YdIAX3/c11/5hipxeEgb+JPH8phBGPMadofbcWwj4lg=; b=nIf055iA7QZGNfPzVhO8uw2yFm
 xg5KInEEQrN9usPa8VfSoOqB7IdXl9+VLIET2VkzUoGV95gxNgleH4e8wCw7iuBBXSYgoSo98W1Mr
 haYK56FXXW5Pm6NzRIQz2jd3W7uqLGt56LaeQbKiPf9gQH2vNhP39vxINayDvnbsVawBNlxkMwdDv
 naRCGh6Ty6JalJsINQPMJvITh+Hkx0VEw3xOpvQ9OKMR1FAYyOFeaiCIXr99KvMjGzA1FoOoF28Sg
 Ou7XmZnsPa9Dibvz7c+dqJQYBmfWQrRHa6Ig01df1z5fjqoDVqpRx6uIska4JTbwREISMfk6OraDq
 l8Wxeviplt/gSKPK/0IvpCWrQLF1dRx95hE5nmfBwko4we0rjsLXSnboxS66BN78ULm1fzJm7JFVu
 k0MbyAuT+ep4zV/0lVe5KLvUElTkOoRWFU01c8tsUgu9KfvzF19D62nFCBAOUp4AmaeT4Mf5R43VC
 iwbIRTaXDKsQLQE8NWZNeSHzOVpIqzYRGOEJiy89InuBDnZZ02BxKx3X5sSc1IJknTz4LAnqKei9s
 p+F+LAz7Zq2EiTy0Lz1e8DgHQq0c9ZZcARGOlRGVTbF8CfCTmd85aZnwI2SnGh3V5S05JcU5QZIke
 nWXInVos82swHxGtbtoJhXT2CsC80DDhTNijG4MQU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Ratchov <alex@caoua.org>
Cc: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/4] MAINTAINERS: drop audio maintainership
Date: Thu, 23 May 2024 12:39:52 +0200
Message-ID: <1761956.6jPLiACWSq@silver>
In-Reply-To: <6c9a0d95-edc9-445f-8063-23a30dd74443@redhat.com>
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-2-kraxel@redhat.com>
 <6c9a0d95-edc9-445f-8063-23a30dd74443@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wednesday, May 22, 2024 2:54:51 PM CEST Thomas Huth wrote:
> On 16/05/2024 14.03, Gerd Hoffmann wrote:
[...]
> >   ALSA Audio backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >   S: Odd Fixes
> >   F: audio/alsaaudio.c
> 
> I'd also suggest that Christian either upgrade from R: to M: or that we 
> change the status to Orphan
> 
> >   JACK Audio Connection Kit backend
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> >   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >   S: Odd Fixes
> >   F: audio/jackaudio.c
> 
> dito

Well, best I can offer is "I try", but no guarantee for latency or anything.

On doubt put them on orphan.

Best regards,
Christian Schoenebeck



