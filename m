Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D97E7DEED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmua1-0000uE-Jp; Mon, 02 Feb 2026 09:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmuZy-0000to-F8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmuZw-0001Hu-JN
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770041219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZBaDwm3KNKyC4Wv0KVdxwntO5KknTcomWwiyr3/uDA=;
 b=JHzPPCR/YuVFZC6TsKt/NDKmF8YKz3Hy++X/5ejWys5XMAiuKy+E7RDTmf5DMhLJM5VvXN
 KWcsQ+daxaqdc/x/01ZrFw3jBx7UPIruvf8CGsx5mMbyeVyGHx52lMJhfePokyER0E5GNz
 mr8FZi7IT3FnVeTmnyIB2LIDfYjYnIY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-u73JQfdXMcWB1IcKEZC3BQ-1; Mon, 02 Feb 2026 09:06:56 -0500
X-MC-Unique: u73JQfdXMcWB1IcKEZC3BQ-1
X-Mimecast-MFC-AGG-ID: u73JQfdXMcWB1IcKEZC3BQ_1770041216
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c882774f0dso70947785a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770041216; x=1770646016; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eZBaDwm3KNKyC4Wv0KVdxwntO5KknTcomWwiyr3/uDA=;
 b=ck8yWjrA0W/AEeWZqv+zh+wdjyHxXWXH6uJkvq1GDPYMZG/aBIzwVw9whWE8tJ8zfP
 RFJgsWKxrqk74lM3tZUGi/aUNWzn55KRj0FquzLpo11RqRaGzMk/xszWhzWSABH0MR1F
 domdKwCy5fZnRiIEcymHBRH/3X4csi1aBxewR3grRi9XtXo6+a/OAkpiUl8Bn2YSFvYe
 5jOas5F6HxbN9Wf0gYqPhchRqFNMS4dm2GMvrnQtSBFoWIHr39apI/5jmit8vVCX7tK8
 oElO/eaKnhcHWuZu5idQ1JP1tHFPJKVXZwYcq2azvBmDv53Ddekmu/vbO2TsRyi4FBm8
 eG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770041216; x=1770646016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZBaDwm3KNKyC4Wv0KVdxwntO5KknTcomWwiyr3/uDA=;
 b=TH/WFpu3YkCHdMiGEuVyBlfJYuoKPL9MWT87a89MKKY53+Kd8zAJKcgTBsScFHSczt
 f9NdGX2W/+TCW6navTFRRRcliuX2s4SgMb5wNtk9wutyn9qPKovaby0D4ZvgWiANekE7
 VaiJki//6X/7r38xzI2Pk/VqdwthBrWOlvAYDp5GSC2w060OgC00bDVVM6MabBxuoJpT
 8SbDIwbI3UbqwZt/mhYNM4toUoNj2P85I09VPFEta6709jh0QzSVTAz+mRADPjPHo8uY
 HhK3t6XkYsTHHrbj96skhtiwtQSW+1zDN2bgqvZ+nodWpzbLa86i1IiZa9hbmkRBLtj7
 30uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTzuRvVodUHQmxiNwdw1Oe8RgoiMNGeBedzDwX68RmFlgthDzLivb/HeGk2XHIjU3YdDwynZgyyU7@nongnu.org
X-Gm-Message-State: AOJu0YyzGvMmf8eI4J6/E162XJFoj6/8xL1ahpEbwan+oXRyZsG4EXYh
 WiMpQhNKx5cHNktZgUXpa66Bg+qGHlURvZbyL5FMjOCXfViH6M+OiqvjSm/EogYa3gOqv/gz/ik
 TrqY+tbNqqxyvk+1aGgLlWgaJAzOrcUgQ/A7Iq6Lo7oODcFf9lDx9DBTe
X-Gm-Gg: AZuq6aJ6fcHg25+yAB6ALs+iL+M8jjp6l3B68lfSx79X0dh7Z/Ga4Dp9lva4ItBVF10
 f0T8Rnwa8gAzqS5M3RbjcVboUo6gnA3H7wc23pWZhoAJRUjb4nwuWfQbGJCbitj6VeniRmgIqPA
 mZ77eeQ+s2c4eLrz5AmUDaPXuT+FZTWeAC0PgmrgSK/pdBtLvgdA/r+rT2cL9OpSbc/2UdO03tp
 CZ4GQT7uNUZpR/XWwteM7ECFOsdkm3hlezjUQ/sF95bTtEYyI8OYYvaXqjFE0YlF8kJd8TQjyZ+
 Fzu0CfchTyTXEmKLwbfAmAhlJd4uI1M+mqMC1eJcVIVo4Sk/huYrG8ZEpYSZzr8f17/2OhXP3C1
 nVj0=
X-Received: by 2002:a05:620a:4089:b0:8c7:1156:efdc with SMTP id
 af79cd13be357-8c9eb2a3397mr1405196385a.25.1770041215274; 
 Mon, 02 Feb 2026 06:06:55 -0800 (PST)
X-Received: by 2002:a05:620a:4089:b0:8c7:1156:efdc with SMTP id
 af79cd13be357-8c9eb2a3397mr1405185785a.25.1770041214270; 
 Mon, 02 Feb 2026 06:06:54 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b7c789sm1236142685a.7.2026.02.02.06.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:06:53 -0800 (PST)
Date: Mon, 2 Feb 2026 09:06:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Message-ID: <aYCvexnciB7THTkr@x1.local>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 29, 2026 at 04:58:41PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 28.01.26 23:39, Ben Chaney wrote:
> > Tap and vhost devices can be preserved during cpr-transfer using
> > traditional live migration methods, wherein the management layer
> > creates new interfaces for the target and fiddles with 'ip link'
> > to deactivate the old interface and activate the new.
> > 
> > However, CPR can simply send the file descriptors to new QEMU,
> > with no special management actions required.  The user enables
> > this behavior by specifing '-netdev tap,cpr=on'.  The default
> > is cpr=off.
> > 
> > Signed-off-by: Ben Chaney <bchaney@akamai.com>
> Hi!
> 
> I'd like to note again, that I'mvworking on an alternative solution for live-updating
> virtio-net+TAP, passing FDs through unix domain socket, which:
> 
> 1. Doesn't require second migration channel
> 2. Doesn't use CPR: the whole TAP state, including negotiated parameters
> and opened FD are natively passed as usual migration state structure.
> (look here: https://lore.kernel.org/qemu-devel/20251030203116.870742-7-vsementsov@yandex-team.ru/ )
> 3. Still should be compatible with CPR, and may be used in context of CPR-update
> 
> The latest version was
> 
> [PATCH v9 0/8] virtio-net: live-TAP local migration
> https://lore.kernel.org/qemu-devel/20251030203116.870742-1-vsementsov@yandex-team.ru/
> 
> and I plan to post v10 soon.

Yes, thanks for re-raising this.  If we have similar features being
proposed, we should always discuss whether we should stick with one of them
if that'll work for all.

IIUC Vladimir's solution looks indeed superior in that it has less
constraints, and also works for CPR mode.

Thanks,

-- 
Peter Xu


