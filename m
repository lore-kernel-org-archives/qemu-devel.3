Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C63C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 13:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saEez-0005bd-01; Sat, 03 Aug 2024 09:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w@uter.be>) id 1saEew-0005b2-CH
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 09:18:58 -0400
Received: from lounge.grep.be ([2a01:4f8:200:91e8::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w@uter.be>) id 1saEet-0003kl-Pk
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 09:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
 s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9cC1egtmn/Lo8zik2HWOOWN9Ibmq25pzFz70kK2mYPg=; b=kpaGVmEt92stLE4IdfE+OhScV+
 96iWXZMkO4t90N3wlZu9QEdI74Bq34Kl0fZd0bEw/rFEyYoAXTy80naMds8q0iieI/ByzOexfHi25
 MA95/NnwRbNDdVhYNSZf7+rkyZxRanFqkJO4c+7PWuajNi/bTBJraP9EDFJJa6RzBUw0N0No/RTub
 r5mePISWk1FLPdK9riJFllF3GgJ4p9NzmkOtD/EZP4nNiQZ2xLSvUknBv3mJajavTiXukPMxpHVoT
 D+a8Eq8a/q8QkmrSjZUzeLKKFYj/hdjVABHA+hhXFKZdAc7L0jry8L8J+xJ7ezCXkLyhPZjhGogfk
 X1G6NdOA==;
Received: from [102.39.154.62] (helo=pc220518)
 by lounge.grep.be with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <w@uter.be>) id 1saEeg-00Chc8-38;
 Sat, 03 Aug 2024 15:18:42 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
 (envelope-from <w@uter.be>) id 1saEeZ-000000001uG-3qBA;
 Sat, 03 Aug 2024 15:18:35 +0200
Date: Sat, 3 Aug 2024 15:18:35 +0200
From: Wouter Verhelst <w@uter.be>
To: Eric Blake <eblake@redhat.com>
Cc: nbd@other.debian.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: Tweak location of qemu nbd extensions
Message-ID: <Zq4uK9Z6GX7Ga-qY@pc220518.home.grep.be>
References: <20240802133811.2001029-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802133811.2001029-1-eblake@redhat.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
Received-SPF: pass client-ip=2a01:4f8:200:91e8::2; envelope-from=w@uter.be;
 helo=lounge.grep.be
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

On Fri, Aug 02, 2024 at 08:36:43AM -0500, Eric Blake wrote:
> Upstream QEMU is moving the location of its NBD docs, as of its commit
> XXXX[1].  Instead of pointing to the raw git source file, point to the
> rendered html version built from rST.

ACK. Please push as soon as that lands.

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.

