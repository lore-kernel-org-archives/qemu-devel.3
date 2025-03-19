Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C9BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turxK-00010t-SX; Wed, 19 Mar 2025 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turxI-00010V-1F
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1turxG-0004ZG-0E
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742385083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLXp/rSWcC/pRAfPkrxc4xVzMvVjczB9qurAGqRN9VU=;
 b=PvPjMBP/rp9Hi4tXGi7+S9/il2WmpTkML1Vg886kGR4cPMvKr4AwlUbx20xZ+GcbA4aD6G
 rUfZserXHeUUmlAP0rX1vPW9xNWA7lOyz2rRyZVJnjE9ofHH/iWO8ErhnnGMHv2KcDcAHq
 1Ke9oFaPMS/Tg+LTLDUhhH68CYobBaw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-NP3narpzPzqwOouDFSVgPw-1; Wed,
 19 Mar 2025 07:51:20 -0400
X-MC-Unique: NP3narpzPzqwOouDFSVgPw-1
X-Mimecast-MFC-AGG-ID: NP3narpzPzqwOouDFSVgPw_1742385079
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91D231956089; Wed, 19 Mar 2025 11:51:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3F71955BC2; Wed, 19 Mar 2025 11:51:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C67D218000AF; Wed, 19 Mar 2025 12:51:16 +0100 (CET)
Date: Wed, 19 Mar 2025 12:51:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <46ersbz6ema7tj6eei7d6rmr5nyaz4zultzdhhlc6ncaqtucn2@tcmnl6gb3jfz>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
 <Z9qlWV_TsnndwIM4@redhat.com>
 <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
 <Z9qshApFGwvNAD5F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9qshApFGwvNAD5F@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 19, 2025 at 11:37:40AM +0000, Daniel P. Berrangé wrote:

> > > > +# @qemu-vars: The firmware expects qemu to provide an efi variable
> > > > +#             store, via "uefi-vars-sysbus" or "uefi-vars-x64" device.
> 
> I wonder if 'qemu-vars' is the right name here ? It feels like the specification
> for such device is effectively defined by UEFI, with any hypervisor providing a
> impl. Perhaps just call it 'uefi-vars-dev' or some name that's relevant for
> what EDK2 calls it ?

'host-uefi-vars' maybe?  Or 'vmm-uefi-vars'?

> > There is 'stateless' already for 'firmware image in r/o flash'.
> 
> What's the behaviour of UEFI if build with JSON vars support, but without
> QEMU providing any JSON vars backend ?

It will panic.

> We would want to expand the 'stateless' docs to mention that this feature
> flag indicates optional support for persistence in that case.

Optional is not possible do due to the way variable store support is
organized in edk2.  Firmware can't switch between smm and non-smm
configuration at runtime for similar reasons.

take care,
  Gerd


