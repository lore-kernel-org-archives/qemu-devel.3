Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C2D2E015
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 05:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3UET-0004aO-NQ; Wed, 23 Oct 2024 01:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3UEN-0004a5-OQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 01:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3UEI-0004kV-HO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 01:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729662500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCZZo0R5poqzxZCOrW96d+hclFH6Jig4/4yuG7Y1hnU=;
 b=iyLBNKBG4KzEX/pz9F04aRdKnMB2fnkfBa3Ej1P6lOCTFrcgkjTdk9TBnOVbFYlPPdLtEk
 qCvHd8oiHpOi1UN6NKm6i8fRABpdgCDri6cZYRIv6I9c7t1bC119IFrhbFgLnqgZPyv37S
 aCnPTqfLJ95/lPWOHq8oGr82AKiOTAA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-J5Bi-OgbOdeBq1ddRRsjUQ-1; Wed,
 23 Oct 2024 01:48:18 -0400
X-MC-Unique: J5Bi-OgbOdeBq1ddRRsjUQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65F001955F3F; Wed, 23 Oct 2024 05:48:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E339C19560AE; Wed, 23 Oct 2024 05:48:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D024821E6A28; Wed, 23 Oct 2024 07:48:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cal Peake <cp@absolutedigital.net>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] qapi/crypto: Rename QCryptoAFAlg to QCryptoAFAlgo (addtl)
In-Reply-To: <619777e8-2238-81f-1d61-185dfcd1ac4e@absolutedigital.net> (Cal
 Peake's message of "Tue, 22 Oct 2024 17:14:13 -0400 (EDT)")
References: <619777e8-2238-81f-1d61-185dfcd1ac4e@absolutedigital.net>
Date: Wed, 23 Oct 2024 07:48:07 +0200
Message-ID: <87ldyfweso.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Cal Peake <cp@absolutedigital.net> writes:

> Hello,
>
> This is a follow up to commit 8f525028bc6f52e4af3f737928d16c3f39a6ea54 to 
> take care of a few remaining QCryptoAFAlg -> QCryptoAFAlgo renames.
>
> Signed-off-by: Cal Peake <cp@absolutedigital.net>

I posted the same fix, and it's in a pull request now:

    Subject: [PULL 07/14] crypto/hash-afalg: Fix broken build
    Date: Tue, 22 Oct 2024 16:24:08 +0100
    Message-ID: <20241022152415.1632556-8-berrange@redhat.com>
    https://lore.kernel.org/qemu-devel/20241022152415.1632556-8-berrange@redhat.com/

Thanks!


