Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB3C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 15:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqkW-0001rv-K2; Thu, 27 Jun 2024 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqkR-0001qN-6i
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqkO-0002SV-Nk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lb3h0BLq0GjHlVSf7XQSVcbxxzmp/EiPvZxWVOiY1kE=;
 b=cG1wSthM306WvbtIhmlV9neSb8oCisZe+9jAtYBXwtkTQxGtuHrn8DIlPbrgMiXyOVvYdz
 FKA1TNX1JxLOqUWQIM1WtfhrdMYPQMRKHAepKg2hxhNvK91wRHNgwnR/p6gpUdbj+Y2v2M
 90/kpvOEOonZ4gS1x8sVsBSkiLCqhBg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-PgLVQWBLMTuvIO5JrOUU8w-1; Thu, 27 Jun 2024 11:09:12 -0400
X-MC-Unique: PgLVQWBLMTuvIO5JrOUU8w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b501871f8fso16199256d6.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 08:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500952; x=1720105752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lb3h0BLq0GjHlVSf7XQSVcbxxzmp/EiPvZxWVOiY1kE=;
 b=FAnWL4uu6vUR25woxGM0xaAI7bZL5kyHVRkYwIPM/z6DUUWAQkfy3hnOy4G2ZMbEbC
 FLFK+eNLtNFiOdvwb2lTczK0z7Q2kwVZcsB1wBZL8VCOYURjfVdZ+1Lggr5JMFU6OMRx
 QNVGbe3xSv1NtyOST4htpnUpNrQMKLXmkcMyi6yNVsD2DwMGKU/Tptr+WfxTnijKe+r0
 pD/SOH7teJ2wwkgmcRb0gPT7ZAasTMBQqH4a5pyUE1vnr2c5vUbjisTlbiA3eB0PCoHR
 3RCKzKq1m5jL7I1g9550MQb+FWTy+Ha1zcSWZToVyeoddl6KNBMAIqyDe/FXLiViXqhq
 sGgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeObuGiZTBzX6Q+LnXJ6AONQRQxJXy1nAT7JjOf5I+5Qn5WE58MdyV/h9zEpKlPzkqoLhkCDL7pa5cesTf1QXJ73Z1/dg=
X-Gm-Message-State: AOJu0YzjciDuBxiBsIUpJLkpWKwD98T7Dp5760RRelUswN7IkGPGMo2X
 LVThElApIAnOwzO/vB3H4dJ1E7qeH+ZL16XI2LudxTbDh1fzVTHVRALJIgKMP0NJOGkXPSICLIc
 7ZWZXpnbb6W7xZKZKPY1wjwDgtpAkuOz3WiJ1bWs3OWTqVQSyUNI/
X-Received: by 2002:a05:6214:2423:b0:6b5:838e:c7f3 with SMTP id
 6a1803df08f44-6b5838ed4c6mr44879786d6.2.1719500952093; 
 Thu, 27 Jun 2024 08:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfczyMk/KbTLjuXGu33IdbXR5x4NxB8Qoxs3rVZjEwd/+PTX3LPtSP63OW1mSl6wNby/1KCw==
X-Received: by 2002:a05:6214:2423:b0:6b5:838e:c7f3 with SMTP id
 6a1803df08f44-6b5838ed4c6mr44879446d6.2.1719500951608; 
 Thu, 27 Jun 2024 08:09:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59241b67dsm5882016d6.4.2024.06.27.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 08:09:11 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:09:08 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zn2AlMbRVCQoypg8@x1n>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
 <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
 <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 11:14:28AM +0200, Maciej S. Szmigiero wrote:
> Having RAM sent in parallel with non-iterables would make sense to me,
> but I am not 100% sure this is a safe thing to do - after all, currently
> non-iterables can rely on the whole RAM being already transferred.

And I forgot to comment on this one.. but that's a good point.

I think we need further investigation indeed on this one.  Some devices may
need special dependency like what you said either on memory fully loaded,
or something else like BQL, so at least concurrent load() won't work for
the latter.  What I was hoping is that we can start to collect some
time-consuming objects into async-model if they do not have such
dependencies.  The thing in my mind is still vcpus so far: that's what I
observed a major uncertainty on causing major downtimes as well.  I
remember vcpu only needs a loaded memory until KVM_RUN triggering loading
of CR3 so _maybe_ that'll be fine, but that needs some double checks.

Thanks,

-- 
Peter Xu


