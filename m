Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76119C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 07:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfZxP-00034y-N0; Sun, 18 Aug 2024 03:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sfZxM-00034L-QV
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 03:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sfZxL-0007us-03
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 03:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723964639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0THHF7DGPPS1TPpiHeeSkTwc81ncCdgdRXxo6WvHw0=;
 b=ii0rvr4pkUzxjH7LDXzkB3LJPhmgIuofIrJqATto1K4jWdnAWXltg7+TkjRPkpEF5QXcwy
 gTnFVj4e1tO2rNHxl/mEkL3juGaZRusp9fk6aCuo1L15CrQxiz2+92e+nZU13o+SH2bNIF
 aK1MD2lPw70+Wa8OtkLxQjN6WlkMbyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-qyzj8PasM6uZMLfNbtmu1Q-1; Sun, 18 Aug 2024 03:03:57 -0400
X-MC-Unique: qyzj8PasM6uZMLfNbtmu1Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so1794834f8f.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 00:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723964636; x=1724569436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0THHF7DGPPS1TPpiHeeSkTwc81ncCdgdRXxo6WvHw0=;
 b=ZY7wfQpGacf1I4+vUDWGCL5dL+9HfC6Dq9fM05Uc/Cj0lOTYYoGcxOK0sad+u7G+Ne
 IMdKpYJk2CWM8eOYf0ZK81I/onE7TtLj9PvPXj5zOx72N0d4kUnikDa9TRhtK634/80N
 WrN1yQRxvksriiXOI6qskCzzxDKH+q4BMka3UDj/4LFhwZH7r5OT0JlbNm6vCfDvkJMP
 CYNaX36GQb8ejYfQcuuZw1IR5geDIFGx2bYMiQ7TSCz8uQGTVs46zOL7VAfmELC7xUKB
 vpJRFOBE1lLjjc/fnAHJlKt0AsckCRzvyTYCg3GGbNNqE9pnHvjmHHZIi4bbve7AzOh/
 dC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfYMYZCPRoEPpcg+JaU/Ang3eZsT+YsaBe70HIjHsrHHGhK+9ESXvaQoiIHImGiLkvQJvqQFRzOlPeIRRWoaMoXMcMTDI=
X-Gm-Message-State: AOJu0YxE6vUUt4Upql9FuY8RnamsZzolNrjjs6PgGSpfzIBk8PWV+0Tg
 oPr+Kh5eu+yIyLRbYfEDYIB6512yMHFxUN/YNxn+QUp2xbxfvK4mIW5oQpfipxjqEObacY2kGd/
 L68vWR/6FUBuKTx0UQuqKjYvq4DsPi5lhzh9wI/RpS4mduuGldyes
X-Received: by 2002:a5d:6886:0:b0:371:83ae:808f with SMTP id
 ffacd0b85a97d-3719429e8bdmr5668161f8f.0.1723964635796; 
 Sun, 18 Aug 2024 00:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdUe5sI986RQNsHMJC6FFZ7H6yb1zO3cAeaHfrn9IVz++fRyBL5e4cYogDvarzfl6dXZ392w==
X-Received: by 2002:a5d:6886:0:b0:371:83ae:808f with SMTP id
 ffacd0b85a97d-3719429e8bdmr5668124f8f.0.1723964634982; 
 Sun, 18 Aug 2024 00:03:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:a585:e32b:7b99:cc8e:265b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded71ee3sm119210365e9.29.2024.08.18.00.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 00:03:54 -0700 (PDT)
Date: Sun, 18 Aug 2024 03:03:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com, jasowang@redhat.com,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240818030325-mutt-send-email-mst@kernel.org>
References: <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
 <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org>
 <ZrTjaZPyjDuJZK36@x1n> <8734ndhncb.fsf@suse.de>
 <7a330bb1-ca53-41b5-ae97-aec8694fc325@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a330bb1-ca53-41b5-ae97-aec8694fc325@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

On Sun, Aug 18, 2024 at 02:04:29PM +0900, Akihiko Odaki wrote:
> On 2024/08/09 21:50, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
> > > > > On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
> > > > > > This is too big of a hammer. People already use what you call "cross
> > > > > > migrate" and have for years. We are not going to stop developing
> > > > > > features just because someone suddenly became aware of some such bit.
> > > > > > If you care, you will have to work to solve the problem properly -
> > > > > > nacking half baked hacks is the only tool maintainers have to make
> > > > > > people work on hard problems.
> > > > > 
> > > > > IMHO this is totally different thing.  It's not about proposing a new
> > > > > feature yet so far, it's about how we should fix a breakage first.
> > > > > 
> > > > > And that's why I think we should fix it even in the simple way first, then
> > > > > we consider anything more benefitial from perf side without breaking
> > > > > anything, which should be on top of that.
> > > > > 
> > > > > Thanks,
> > > > 
> > > > As I said, once the quick hack is merged people stop caring.
> > > 
> > > IMHO it's not a hack. It's a proper fix to me to disable it by default for
> > > now.
> > > 
> > > OTOH, having it ON always even knowing it can break migration is a hack to
> > > me, when we don't have anything else to guard the migration.
> > > 
> > > > Mixing different kernel versions in migration is esoteric enough for
> > > > this not to matter to most people. There's no rush I think, address
> > > > it properly.
> > > 
> > > Exactly mixing kernel versions will be tricky to users to identify, but
> > > that's, AFAICT, exactly happening everywhere.  We can't urge user to always
> > > use the exact same kernels when we're talking about a VM cluster.  That's
> > > why I think allowing migration to work across those kernels matter.
> > 
> > I also worry a bit about the scenario where the cluster changes slightly
> > and now all VMs are already restricted by some option that requires the
> > exact same kernel. Specifically, kernel changes in a cloud environment
> > also happen due to factors completely unrelated to migration. I'm not
> > sure the people managing the infra (who care about migration) will be
> > gating kernel changes just because QEMU has been configured in a
> > specific manner.
> 
> I have wrote a bit about the expectation on the platform earlier[1], but let
> me summarize it here.
> 
> 1. I expect the user will not downgrade the platform of hosts after setting
> up a VM. This is essential to enable any platform feature.
> 
> 2. The user is allowed to upgrade the platform of hosts gradually. This
> results in a situation with mixed platforms. The oldest platform is still
> not older than the platform the VM is set up for. This enables the gradual
> deployment strategy.
> 
> 3. the user is allowed to downgrade the platform of hosts to the version
> used when setting up the VM. This enables rollbacks in case of regression.
> 
> With these expectations, we can ensure migratability by a) enabling platform
> features available on all hosts when setting up the VM and b) saving the
> enabled features. This is covered with my
> -dump-platform/-merge-platform/-use-platform proposal[2].

I really like [2]. Do you plan to work on it? Does anyone else?

> Regards,
> Akihiko Odaki
> 
> [1]
> https://lore.kernel.org/r/2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com
> [2]
> https://lore.kernel.org/all/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com/


