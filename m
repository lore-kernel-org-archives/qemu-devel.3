Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58538D6C29B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVnp-00080g-GN; Tue, 19 Nov 2024 16:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDVnn-00080U-Kt
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDVnl-000289-Ra
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732051823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gXii4Hr7D9nfMDBWFbyQQbUxihgNHkfw0zJHjWProw=;
 b=YUcaSrWPmGr7tGJjxw1lhWRD9VR3hDKT2SRbH/qa8q2ajBVQHH3HhE8bop5IM4a5ciQhPv
 5jEg+BJZQKST13EQ8Wf2iNm9MTMufmeFsYpnZk3bZRn1goo35nXtcRETMR63dA7OP+hT8v
 vNt5erAyjuf/KT6x9k+N2O+OgtKzBhs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-QHl_u3NfPtC_3DbBglO45A-1; Tue, 19 Nov 2024 16:29:15 -0500
X-MC-Unique: QHl_u3NfPtC_3DbBglO45A-1
X-Mimecast-MFC-AGG-ID: QHl_u3NfPtC_3DbBglO45A
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-50d83a838b3so2307818e0c.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 13:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732051755; x=1732656555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gXii4Hr7D9nfMDBWFbyQQbUxihgNHkfw0zJHjWProw=;
 b=INVo3UtBpm8iyd77Q8EStPepmDH2l4wgxuZdNgNQfhj0rVqclJCOf0Dfe7lm35dN/c
 E9Tew8Xh6oIwqbz2ubC+9KK1OQsUgJFT7QMHq2BwH14rt4ND52JAivXfgUVssW2ByXzf
 Aayrr1qIuLvgVxrMVhUhE3eMpsMmrbFt7F1NVbzUyiTeyl8l34eYNTFM+5zTHvMqJnhE
 yW1PVYhRoUEYjbvY3rCl8kZX4VBSr18QLMH/rSVkEYAkWoIVZYMeRL2LCBwGx+Rd5fta
 iUg35DK7mAKlpVLVj+1xCBPK5DsELA5DRe2Rd7Ku/keyaNgJf0cWRIKr/VBJfLL1QVIs
 SIew==
X-Gm-Message-State: AOJu0YyJT3svn3WB7gni934VEw5Krm+IWgvoKxbghkvx7WhgyHvHjW00
 GtTIVQ0GO27U8wFRE4s25ox02QNBcq06KGdqOLQqLxuoNzUWXmbdkSFKIfQZk6ZtqwLCiu2d5Rd
 3C+0LGlC2QuK4EbB9OvzWxjcXHIidjyKdUZZmhSEu8htrE4ROdoo9
X-Received: by 2002:a05:6122:17a9:b0:50d:2317:5b61 with SMTP id
 71dfb90a1353d-514cf8ba80bmr476722e0c.6.1732051755085; 
 Tue, 19 Nov 2024 13:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE3KK8iC5xeJi6XhDgD/vOzLghdHNcrWy/eO4lEMEkWA7XyNaiLLDEzpVV09iCK5RndLGufw==
X-Received: by 2002:a05:6122:17a9:b0:50d:2317:5b61 with SMTP id
 71dfb90a1353d-514cf8ba80bmr476707e0c.6.1732051754770; 
 Tue, 19 Nov 2024 13:29:14 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d4380f44bcsm979026d6.69.2024.11.19.13.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 13:29:13 -0800 (PST)
Date: Tue, 19 Nov 2024 16:29:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <Zz0DJ3RB-bVofkmo@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zzz6NVoJss4JdEHh@x1n>
 <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 19, 2024 at 04:03:08PM -0500, Steven Sistare wrote:
> On 11/19/2024 3:51 PM, Peter Xu wrote:
> > On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
> > > This begs the question, should we allow channels to be specified in hmp migrate
> > > commands and for -incoming, in a very simple way?  Like with a prefix naming
> > > the channel.  And eliminate the -cpr-uri argument. Examples:
> > > 
> > > (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
> > > 
> > > qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
> > > qemu -incoming main:defer,cpr:unix:cpr.sock
> > 
> > IMHO keeping the old syntax working would still be nice to not break
> > scripts.
> 
> The channel tag would be optional, so backwards compatible.  Its unambiguous
> as long as the channel names are not also protocol names.

Ah that's ok then.  Or maybe use "="?

  "main=XXX,cpr=XXX"

Then if no "=" it's the old?

> 
> > I was thinking we could simply add one more parameter for taking
> > cpr uri, like:
> > 
> >      {
> >          .name       = "migrate",
> >          .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
> >          .params     = "[-d] [-r] uri [cpr_uri]",
> >          .help       = "migrate to URI (using -d to not wait for completion)"
> > 		      "\n\t\t\t -r to resume a paused postcopy migration",
> > 		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
> >          .cmd        = hmp_migrate,
> >      },
> 
> That's fine.
> 
> I do like the incoming syntax, though, instead of -cpr-uri.  What do you think?

That'll definitely be lovely if possible, though would any monitor be alive
at all before taking a cpr stream, with this series alone?  I thought you
dropped the precreate, then QEMU isn't able to run the monitor loop until
cpr-uri is loaded.

-- 
Peter Xu


