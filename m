Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7422CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtoc-0004zK-3K; Tue, 09 Jun 2026 06:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWtoa-0004yo-1i
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWtoY-0004Sr-Dj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781001369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=476xZ3aw8WsRlJZUxEuaTxFQvtn7IxL0SABWEggIlAE=;
 b=V5e+GctYfsuA4TptCuIhdC5z4OnnfowIN9VuH0b4BNMa+FCf/GtE8iaMGRHiQKHKTpfVCS
 Fyk6866OMrO6IiVO03gP/b8HCca9RDCmhVKI10axgsblA9Y6kTGFWCviZrq1DWS7vC1gkt
 4iZn/9AC2UYZRv4mjNDNww1kJwb1Gdg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-QXTKLxs3N7O1BFaaWFvlCg-1; Tue, 09 Jun 2026 06:36:08 -0400
X-MC-Unique: QXTKLxs3N7O1BFaaWFvlCg-1
X-Mimecast-MFC-AGG-ID: QXTKLxs3N7O1BFaaWFvlCg_1781001367
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so28781275e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781001367; x=1781606167; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=476xZ3aw8WsRlJZUxEuaTxFQvtn7IxL0SABWEggIlAE=;
 b=GAmOnuvr1QqpNtOTSfzhVye6w8lTn0ICRpeG4hbRy7E3J4hr8muGc+J7a37kGdL76d
 vYRI1/5XftKW3W7Pcdf8gQHtPDi6R6KjAzRreFRtxVwNabeukvNBGXr1J7VYISOo5ZBP
 gwUtEOVnmfrmdH61SJYKzw5XLwUSzFrJG6IIXNbcSxyYPqAM7T2myZnAvNradt59RsjF
 M/VmWh8GzQnHY+5nefosfQGxLff51inxHPotdS4rTAmh+j0AKA7x2lpy0yww7Y1tXA2i
 6+Q0X3fFN2c6mA3BYL59fEQoQyoLtr/x9C1uFc3jzz7OfdOku96h2BqiZ/SKeMQsD1vF
 Er7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781001367; x=1781606167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=476xZ3aw8WsRlJZUxEuaTxFQvtn7IxL0SABWEggIlAE=;
 b=BcOs2VDsdEjXpO/dcT/W9DYY0IV6Gimy+zZ3jsrvCXGdvMIdNlDbdvOQAnmVnOmUBG
 u3t96/808fZcC263JDNxHJ5PXdjbuQCmO6zbQx9gh29qPvwPSZqItB9gd486KVePJzoS
 eE0eA22U7kxUUGIXGGoJznLHWpY9IfIi8lSRmKcSBonDn+SGQ+IT5iBFFDoX7gYqnwV4
 qEiDWci5Ncvo4FO3Z7hND9JKqx69i+NxcqS1goBJO5IJTq1BI0eb+o7H5LcUAsVmMZOg
 EceUdTE+ERkILqd67MEsV0pujT//PbPkswhggzRXR8QsljDnFDRd5Oac/tInL/DMnVX0
 guuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87iyAefIkrN7DKeb0oEZHAxD54eo4MsYXXdebJ/v4xzlANIyc3zAuvT/IMGjGnG0R3MLokogsBsGMS@nongnu.org
X-Gm-Message-State: AOJu0YzQ8Y9CqThycvCYm8+jaHU3LzI2GwSP+iCAl9o8t8xusIucohtM
 OTHaGhNCl81SPI8WiBakYJV+3+YLJHJtuBKo4gtdrVEejNGF7cjO+EZPhU1hIvpcwkvzW7dZwEp
 U4jv5JqommZlVc8bTYjT5+UDQS61knQ4qruWO71i3cL3I9salsN/cpa6g
X-Gm-Gg: Acq92OFV4vQMOTtlaox94zZpQjZDo/8n9auQIoaJOfHjnaiZyec+/xWMnb3nCqlz/dF
 eZfjrHpx4NwF103CEb7CyTlo5A0yE4gLXueKheIQLSu9LdpihtDzXsOq2r9Qt1KGsbJlOrOMMMP
 0/L5L6J6g8zbg8NzwvevNwcnCiFzqe0vrW0/FzuKLMzV7O6auyHAicOFbsZNJEbnr014asfvTYU
 c5hpuS9AElTJsYPd/Lts5kzJgXhC3tLTafRFoRCafi4uCDApLOasuU3pKaWIr0aUZ2RO/rQhe05
 9vOLikCaOHh5WlCUl0jjq309BaEJBX+wn6cqy0oMxeRxbWBSt0Z0t5dGZmdAxGXZrCZwAWwuXm/
 EN34VQ7TPTrgyS48yz2UzNFWEhazW62jQZ/3JzqCARqZHz7TXayeMpw==
X-Received: by 2002:a05:600c:6388:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490c2d1412emr250001305e9.14.1781001366963; 
 Tue, 09 Jun 2026 03:36:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490c2d1412emr250000715e9.14.1781001366387; 
 Tue, 09 Jun 2026 03:36:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d37edbsm374334905e9.2.2026.06.09.03.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:36:05 -0700 (PDT)
Date: Tue, 9 Jun 2026 06:36:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, amit@kernel.org,
 berrange@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, maxbr@linux.ibm.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com
Subject: Re: [PATCH] qapi: drop "must exist" from ID descriptions for
 consistency
Message-ID: <20260609063539-mutt-send-email-mst@kernel.org>
References: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
 <20260120081821.884342-1-filip.hejsek@gmail.com>
 <877bo8q9yc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bo8q9yc.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 09, 2026 at 12:34:03PM +0200, Markus Armbruster wrote:
> Uh, this fell through the cracks, possibly because it was buried within
> a thread.
> 
> Filip Hejsek <filip.hejsek@gmail.com> writes:
> 
> > Make chardev ID param descriptions more consistend with ID descriptions
> 
> Typo: consistent
> 
> Not worth a respin.
> 
> > elsewhere.
> > ---
> >  qapi/char.json | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/qapi/char.json b/qapi/char.json
> > index 140614f82c..fbac5a1cb7 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -791,7 +791,7 @@
> >  #
> >  # Change a character device backend
> >  #
> > -# @id: the chardev's ID, must exist
> > +# @id: the chardev's ID
> >  #
> >  # @backend: new backend type and parameters
> >  #
> > @@ -832,7 +832,7 @@
> >  #
> >  # Remove a character device backend
> >  #
> > -# @id: the chardev's ID, must exist and not be in use
> > +# @id: the chardev's ID, must not be in use
> >  #
> >  # Since: 1.4
> >  #
> > @@ -849,7 +849,7 @@
> >  #
> >  # Send a break to a character device
> >  #
> > -# @id: the chardev's ID, must exist
> > +# @id: the chardev's ID
> >  #
> >  # Since: 2.10
> >  #
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> I can take this.

maybe after it gets a signed off by tag from the author.

-- 
MST


