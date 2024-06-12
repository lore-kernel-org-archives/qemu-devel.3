Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659DAC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNTP-0008OJ-GV; Wed, 12 Jun 2024 08:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHNTN-0008OA-TC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHNTM-0006gp-01
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718196783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kBKhPdahuTIUSjkPE4vkxUnzv4NUQ9mGx4aSv1VsZ8=;
 b=bocScZBkShMnixTsBESF2PcXm4nwJL/m2BHig9hQz6cpp3TQss+M/ZZUAJUIHdb//7R4U3
 uGm8wHy0/844Y/MdHVSTxNweF+oLdlX7E6Ejr+Hons3r1jK5cR8IG0OzayF6oPYvzZJ6GY
 4BFlhBU0kBvFClppxYankJXUdFX+Tsw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-sdt4U7peN1aFrFSFACXbRg-1; Wed,
 12 Jun 2024 08:52:59 -0400
X-MC-Unique: sdt4U7peN1aFrFSFACXbRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B34519373EB; Wed, 12 Jun 2024 12:52:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CED519560AF; Wed, 12 Jun 2024 12:52:55 +0000 (UTC)
Date: Wed, 12 Jun 2024 13:52:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Dehan Meng <demeng@redhat.com>, qemu-devel@nongnu.org,
 kkostiuk@redhat.com, michael.roth@amd.com
Subject: Re: [PATCH v5 1/1] qga/linux: Add new api 'guest-network-get-route'
Message-ID: <ZmmaIzYPUlQTF7DK@redhat.com>
References: <20240612103105.301456-1-demeng@redhat.com>
 <20240612103105.301456-2-demeng@redhat.com>
 <6e00233e-63ab-4513-aa0f-c55ab4ef0747@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e00233e-63ab-4513-aa0f-c55ab4ef0747@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 12, 2024 at 02:48:24PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Dehan,
> 
> On 12/6/24 12:31, Dehan Meng wrote:
> > The Route information of the Linux VM needs to be used
> > by administrators and users when debugging network problems
> > and troubleshooting.
> > 
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >   qga/commands-posix.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
> >   qga/commands-win32.c |  6 ++++
> >   qga/qapi-schema.json | 56 ++++++++++++++++++++++++++++++
> >   3 files changed, 143 insertions(+)
> 
> 
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index b3de1fb6b3..58f51aecbb 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1800,3 +1800,59 @@
> >   { 'command': 'guest-get-cpustats',
> >     'returns': ['GuestCpuStats']
> >   }
> > +
> > +##
> > +# @GuestNetworkRoute:
> > +#
> > +# Route information, currently, only linux supported.
> > +#
> > +# @iface: The destination network or host's egress network interface in the routing table
> > +#
> > +# @destination: The IP address of the target network or host, The final destination of the packet
> 
> Maybe clearer to start naming this @ipv4 in case you plan @ipv6
> support later (see @NetdevUserOptions structure in qapi/net.json).

IMHO IPv6 must be supported from the start - it really isn't acceptable
to write new IPv4 only code today.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


