Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F52FEC0461
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxLtd-0000ob-Uk; Tue, 03 Mar 2026 04:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxLta-0000o2-6Z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxLtX-0003X8-Eo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529501;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ttl2L3JCLrwmoyddb1zHUTpob2juNSI9oe274w9g4c0=;
 b=eChMV4732PAluE1go+mHiwRujh1ZfPWTZ6fNsQFlUvkuQaUePFvyq6XDMZw51q83Oa4D3f
 yOy72tvbs4vwBrZcjPMCbjKeqV6kUm2ovC2BkkGSNwmIuNYcNWDeAb0xcJxegKRIoNdi/J
 cnRf00wBh1ZlZAUafuaS/ZxEu60sWAE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-1XsQ4o_TMWOwvEl9Of4lRA-1; Tue,
 03 Mar 2026 04:18:18 -0500
X-MC-Unique: 1XsQ4o_TMWOwvEl9Of4lRA-1
X-Mimecast-MFC-AGG-ID: 1XsQ4o_TMWOwvEl9Of4lRA_1772529497
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D89919560AD; Tue,  3 Mar 2026 09:18:17 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D24BE30001BF; Tue,  3 Mar 2026 09:18:14 +0000 (UTC)
Date: Tue, 3 Mar 2026 09:18:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, Lukas Straub <lukasstraub2@web.de>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: qemu master compile error in hw/net/rtl8139.c with --enable-asan
Message-ID: <aaanU-ZiDQr72j4g@redhat.com>
References: <20260301121347.797dc9f4@penguin>
 <127d0e97-ca25-4847-a06f-954443bbc886@yodel.dev>
 <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 10:32:38AM +0000, Peter Maydell wrote:
> On Sun, 1 Mar 2026 at 15:15, Yodel Eldar <yodel.eldar@yodel.dev> wrote:
> >
> > Hi, Lukas
> >
> > On 01/03/2026 05:13, Lukas Straub wrote:
> 
> > > ../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
> > > ../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> > >   2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
> > >        |                 ^
> > > In file included from ../hw/net/rtl8139.c:62:
> > > /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
> > >     50 |     uint8_t  ip_ver_len;     /* version and header length */
> > >        |              ^~~~~~~~~~
> 
> On the face of it, this looks like a compiler bug (warning false
> positive), because we set:
> 
>     uint8_t *data_to_checksum     = eth_payload_data + hlen - 12;
> 
> and earlier
> 
>             eth_payload_data = saved_buffer + ETH_HLEN;
> 
> where
>         uint8_t *saved_buffer  = s->cplus_txbuffer;
> 
> and s->cplus_txbuffer is a uint8_t* which we set up via g_malloc().
> None of that is an ip_ver_len byte, or even an ip_header struct.
> So it looks like GCC has incorrectly decided that this uint8_t
> buffer has a type which it does not.

Yes, the problem is earlier code that also consumed eth_payload_data,
by assigning it to a 'struct ip_header' pointer:

            struct ip_header *ip = NULL;
            ...
            ip = (struct ip_header*)eth_payload_data;

As a result GCC now believes that "eth_payload_data" has the
'struct ip_header *' type for the remainder of its life.

Eliminating the intermediate 'eth_payload_data' squashes the bogus
type inference

            ip = (struct ip_header*)saved_buffer + ETH_HLEN;

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


