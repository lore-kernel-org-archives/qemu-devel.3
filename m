Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEE5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoNR-00078h-GL; Wed, 21 Feb 2024 10:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcoKs-0001XF-MP
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rchvp-00039p-Gb
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708503980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hd/ttXoszpMYTfUKQHfQwOsC/MFhsOZNvz3dXuB4uSk=;
 b=LpnbuMwRZrESyEem61SPKZpQlA0I2BiWsFb7DQk/6h7XvcaqAXVyLmgUz/1XR8/GU7q6DT
 fqj5h8ahyTwFQVMBEU+a6BP7V6Qicus7HaiIBP6vP5zCqWo3p1Dl5qHGj34XAZSPIT5iXr
 S6yBQiVbSPpC+gfS8sbd1QesKFI3Ncs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-28j0DJaQPSiRwC0YRVyZtA-1; Wed, 21 Feb 2024 03:26:17 -0500
X-MC-Unique: 28j0DJaQPSiRwC0YRVyZtA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so131158a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 00:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708503976; x=1709108776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hd/ttXoszpMYTfUKQHfQwOsC/MFhsOZNvz3dXuB4uSk=;
 b=dA50yHewsfqfG19cTN8QI//R7qkrLfcVnN9MFzA0aYygY9D9F4Wwx4WHbBSyAwLhzO
 EIVaMrjbsRruA/jrOEQrcSyYB75hlZDPoUKxkppRlgUKNOVwv+hzMpcum/rrHeUEuX3G
 Kg2ckohO7hi9qR8aZkb8bQxz91GGiWwPf8SbXkRA0//zL6j89DqzfSaK3nOLIZh0M5Fx
 YKeiKmWVtzQ4nGgDrLT2qLgFJUCCPBNh50VvdIIGjMphrGoDW5T69E+A9/a/mWWqRGf8
 R9+ROUQqrQsUEhid+Qqsm0M4P20Zuak4ntvl4aw/KwoeNAeVzVWPaXUTukUflT5Feyzb
 CP4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaLfOpuZtb06U+W14ukI/sYM99n47as13/F541F496bpigUWeU9k0F226if2Zf/3UFi1iZW/Cjb72JBl7PoDO0mX6rfcc=
X-Gm-Message-State: AOJu0YzF8KdhLxw9PHZnvvFG3yS1Ks/+MNHRXhW86CIBRtmPdsOdhglu
 McaylaEtahhGiMznX85Q0t1iCuZH6PtiWyF9+k76Gts1sYiVfmCPJ/oU6GQB4hhEOsUvlqZrN8D
 HOHdEWVUYCtXFVPXNP8tqYxatlLpTB2TxYmIxTWJ+ydGKyLz25Dph
X-Received: by 2002:a05:6a21:1a4:b0:1a0:810e:5f40 with SMTP id
 le36-20020a056a2101a400b001a0810e5f40mr18747231pzb.4.1708503976367; 
 Wed, 21 Feb 2024 00:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPlw51rZw4vIUQMgxAUEb1DsNWycXAndXUAhYQclvrw8/gMYgh0yl3zUReZwS/tc6RmtkBlg==
X-Received: by 2002:a05:6a21:1a4:b0:1a0:810e:5f40 with SMTP id
 le36-20020a056a2101a400b001a0810e5f40mr18747220pzb.4.1708503975997; 
 Wed, 21 Feb 2024 00:26:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 f9-20020a170902e98900b001db45855528sm7384596plb.198.2024.02.21.00.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 00:26:15 -0800 (PST)
Date: Wed, 21 Feb 2024 16:26:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi: Misc cleanups to migrate QAPIs
Message-ID: <ZdWzmbOuCVk8GZMn@x1n>
References: <20240216195659.189091-1-het.gala@nutanix.com>
 <87edd61ezt.fsf@pond.sub.org>
 <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks, Markus.

On Wed, Feb 21, 2024 at 12:36:57PM +0530, Het Gala wrote:
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 5a565d9b8d..5756e650b0 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -1728,6 +1728,7 @@
> > >   #
> > >   # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
> > >   # <- { "return": {} }
> > > +#
> > >   # -> { "execute": "migrate",
> > >   #      "arguments": {
> > >   #          "channels": [ { "channel-type": "main",
> > > @@ -1796,19 +1797,19 @@
> > >   #
> > >   #     3. The uri format is the same as for -incoming
> > >   #
> > > -#     5. For now, number of migration streams is restricted to one,
> > > +#     4. For now, number of migration streams is restricted to one,
> > >   #        i.e number of items in 'channels' list is just 1.
> > >   #
> > > -#     4. The 'uri' and 'channels' arguments are mutually exclusive;
> > > +#     5. The 'uri' and 'channels' arguments are mutually exclusive;
> > >   #        exactly one of the two should be present.
> > >   #
> > >   # Example:
> > >   #
> > >   # -> { "execute": "migrate-incoming",
> > > -#      "arguments": { "uri": "tcp::4446" } }
> > > +#      "arguments": { "uri": "tcp:0:4446" } }
> > >   # <- { "return": {} }
> > >   #
> > > -# -> { "execute": "migrate",
> > > +# -> { "execute": "migrate-incoming",
> > >   #      "arguments": {
> > >   #          "channels": [ { "channel-type": "main",
> > >   #                          "addr": { "transport": "socket",
> > > @@ -1817,7 +1818,7 @@
> > >   #                                    "port": "1050" } } ] } }
> > >   # <- { "return": {} }
> > >   #
> > > -# -> { "execute": "migrate",
> > > +# -> { "execute": "migrate-incoming",
> > >   #      "arguments": {
> > >   #          "channels": [ { "channel-type": "main",
> > >   #                          "addr": { "transport": "exec",
> > > @@ -1825,7 +1826,7 @@
> > >   #                                              "/some/sock" ] } } ] } }
> > >   # <- { "return": {} }
> > >   #
> > > -# -> { "execute": "migrate",
> > > +# -> { "execute": "migrate-incoming",
> > >   #      "arguments": {
> > >   #          "channels": [ { "channel-type": "main",
> > >   #                          "addr": { "transport": "rdma",

Reviewed-by: Peter Xu <peterx@redhat.com>

Markus, do you want us to pick it up, or let it go via qapi?

Thanks,

-- 
Peter Xu


