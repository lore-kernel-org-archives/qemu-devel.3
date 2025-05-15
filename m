Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A52C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 20:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFf5e-0000CZ-Gh; Thu, 15 May 2025 16:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFf5d-0000CE-0q
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFf5a-0004sM-QE
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747340516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MxfTHOe8i/TMBGDSW+4K7+WeCimetlMaa+IvHXdVu6U=;
 b=b1chnfmGJQAcPIZyOYpBJ4bR1Bd16CtGYBdDeFqQ3eQTVSzfNXWLVHF8Dt0/At8vdJ2k3V
 JG5YVtPVvnf8isPzwXj4x0iuAwClZh2twrIWgAIU5PJ4bnMB71/OqNM2dsKtHq4UQXCW8r
 1VyYcO+9Is3YX+ijJrajw6ZvkPd9Kec=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-DLH8VtYCPwOuU1oADPEgBA-1; Thu, 15 May 2025 16:21:55 -0400
X-MC-Unique: DLH8VtYCPwOuU1oADPEgBA-1
X-Mimecast-MFC-AGG-ID: DLH8VtYCPwOuU1oADPEgBA_1747340514
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c7c30d8986so357997385a.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 13:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747340514; x=1747945314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxfTHOe8i/TMBGDSW+4K7+WeCimetlMaa+IvHXdVu6U=;
 b=oHdgvXcDXq1isSbJxp0mJ+wWB1OOpVtjXN7HQVMG1AXP9Fd2of6Dj45oVmMwt20bJE
 NWsdZHwN4LPp1ALZ7gZm6afuMDeZQy7IW+SJ0E+C/+ITnybGxcwtdSEdiviLOvJfaSOs
 cHecJUFzEDfLvGU7ff3id3b0qV1YE1U4LD3KQev7sZE3K1S2zHs6518Vn1PP5UKDNail
 M5z6T5L+c2SvOSrx9GXrOPyKzRaQITWmeCl7BK0P4//cR2tCwJxGGANQjjhpHoxWiot9
 IRwmnpJI+nIiIog5qW0TWezqTxs8FcQkKqdP1N9dU36q9pDOs0VsLiJ5rKYKuiAv/tG4
 E0Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKuaSUpEL9KObvmH1lkFa3jh8/TeCfoqSoNPfpoCMV09H4zbNFIDqJsVFvtjT1qx9+Z2/wQ0Kl2yJh@nongnu.org
X-Gm-Message-State: AOJu0YzHhyxl5SyxoTHdonuS+3m+tD1Qtvb+2bIe5jzwM4wkGn4EX25x
 9IEueKH1wv8WhtjErSdXqqHNz7EfU+4lnqBM+R4VJc3g/HgARZXSTOFj6IZDnFAU5OAQYrvlZry
 bObBt5ln2flOvXoZY9UKZkCY6MraevRIKmondUxP2I6jiQLLbnbi6EvDr
X-Gm-Gg: ASbGncufraBARaFJy99EghBj/et4TpsRBM8fjY53Bl7nDBfunKHH7Mh71OpGuhUEYmi
 4ufjQOTjRs7IDHhi2UiZ18Hi/dIDZp2ivKnJ6pcSWzCDOjRKHDf/bcfaayAZS7ymPC2aJ6K/4a4
 3m/tqphJcA3GA9/fKKsXoEbd4uCQ41enIW4hfnXZ6tdGpMEj5vAYYdUHoIidQQbdd7N+5V1qdBn
 cOoBWf5/RnxLpJT60DHETh8zxKCdUL7hwPxvSPpX72mFw1m876nImKfXWUncm09RA7WZ+suMo2A
 6zI=
X-Received: by 2002:a05:620a:801a:b0:7c5:fa85:1ac3 with SMTP id
 af79cd13be357-7cd47fb1e28mr16107385a.45.1747340514486; 
 Thu, 15 May 2025 13:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBlWTlvv93+AGONNzEle+d3H7agB66ytx/88O8iWl3/IKH6C5KTW6x8mrZYdi+/1rB4AfZ0g==
X-Received: by 2002:a05:620a:801a:b0:7c5:fa85:1ac3 with SMTP id
 af79cd13be357-7cd47fb1e28mr16105085a.45.1747340514171; 
 Thu, 15 May 2025 13:21:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468ccbfcsm26074385a.107.2025.05.15.13.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:21:53 -0700 (PDT)
Date: Thu, 15 May 2025 16:21:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
Message-ID: <aCZM3nOeZ_Z5eVIg@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com> <87v7r6fz0c.fsf@suse.de>
 <Z_1DzDB8v6FOT9TG@redhat.com> <87semafxpy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87semafxpy.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Mon, Apr 14, 2025 at 02:40:25PM -0300, Fabiano Rosas wrote:
> > Can we make the two approaches mutually exclusive ? Taking your
> > 'migrate' command example addition:
> >
> >   { 'command': 'migrate',
> >     'data': {'*uri': 'str',
> >              '*channels': [ 'MigrationChannel' ],
> >   +          '*config': 'MigrationConfig',
> >              '*detach': 'bool', '*resume': 'bool' } }
> >
> > if 'migrate' is invoked with the '*config' data being non-nil,
> > then we should ignore *all* global state previously set with
> > migrate-set-XXXX, and exclusively use '*config'.
> >
> > That gives a clean semantic break between old and new approaches,
> > without us having to worry about removing the existing commands
> > quickly.
> >
> 
> Good idea. I will need to do something about the -global options because
> they also set the defaults for the various options. But we should be
> able to decouple setting defaults from -global. Or I could just apply
> -global again on top of what came in '*config'.

Would it still be possible that we allow whatever options attached to the
"migrate" command to only overwrite the globals (either set via -global or
migrate-set-* QMP commands), rather than ignoring them completely?

If so, we don't need to do anything with current -global and it'll keep
working.  It's the same to most existing way to set the migration options
(e.g., otherwise do we plan to disable HMP "migrate" usage?).

Making the above '*config' to only overwrite also do not stand against the
mgmt using it to ignore the default options, after all the mgmt can decide
to always set everything in the '*config' then it's the same as ignoring
the globals?

-- 
Peter Xu


