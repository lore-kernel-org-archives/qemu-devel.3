Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9534C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tut4v-00036X-A6; Wed, 19 Mar 2025 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tut4t-000361-Ju
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tut4r-0003YP-5c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742389398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ke9374OLdlGCQ0iWuOiismuezIj2fvGOlbvJG+4AA9Q=;
 b=ZEmjTZAVrT+cflBoRk3a9BUyi3BO2ZG05OfnS/QDePFIGk5HSg3W/JJe1R0yaaxHhuvjOU
 tkirIBkJ7d3isgxPn9b8Q6+PvSOnexmv9DWTRcephRHVqRCUPJ+EMNGJqjBMkXPNtG/GQZ
 zJzoqibmTXoy9+tTEVCLahbHojcdLAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-CpM_EKjTNKeBzwufyaH9YQ-1; Wed,
 19 Mar 2025 09:03:14 -0400
X-MC-Unique: CpM_EKjTNKeBzwufyaH9YQ-1
X-Mimecast-MFC-AGG-ID: CpM_EKjTNKeBzwufyaH9YQ_1742389393
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B67EF18001F3; Wed, 19 Mar 2025 13:03:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 452711800946; Wed, 19 Mar 2025 13:03:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BF17618000AF; Wed, 19 Mar 2025 14:03:09 +0100 (CET)
Date: Wed, 19 Mar 2025 14:03:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <rjz4px5v7csjjo5vehhgpotbwjf6fptkexcyv5jg7omwgdtl7h@cnhgtnyjk4ly>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
 <Z9qlWV_TsnndwIM4@redhat.com>
 <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
 <Z9qshApFGwvNAD5F@redhat.com>
 <46ersbz6ema7tj6eei7d6rmr5nyaz4zultzdhhlc6ncaqtucn2@tcmnl6gb3jfz>
 <Z9q2pjalGZM4laWJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9q2pjalGZM4laWJ@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi,

> > > > There is 'stateless' already for 'firmware image in r/o flash'.
> > > 
> > > What's the behaviour of UEFI if build with JSON vars support, but without
> > > QEMU providing any JSON vars backend ?
> > 
> > It will panic.
> 
> In that case, we must not reuse 'stateless' with such builds, as that's
> quite different semantics & incompatible with current usage.
> 
> We would need a new 'uefi-vars' mode, or just declare that we must
> always use 'memory'  not 'flash' for such builds.

I don't see how 'flash.stateless' is any different than 'memory' (or
'kernel', or maybe 'igvm' some day).  If the 'host-uefi-vars' feature
is present '-device uefi-vars-$kind' is required, no matter how you
load the firmware.

What exactly will an old libvirt which does not know the
'host-uefi-vars' feature do in case it finds a firmware.json file with
that feature?  Play safe and ignore the file?

take care,
  Gerd


