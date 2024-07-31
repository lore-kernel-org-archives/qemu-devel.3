Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020FFC52D1D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3xX-0002KL-Jf; Wed, 31 Jul 2024 03:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZ3xW-0002Jl-6E
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZ3xT-0000QN-Ca
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722411673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7+xt/kACVxCrvGUX6C+l3WTb/o1RqA4rrnA0EJzD3s=;
 b=KfH0X9PfZg1dtdrqwCthrFf4OOl7NTCT8fSMwbs5xTkPkwodD/jX7wzMwFTaSDLwrG0MbN
 JZfnk0uf5z+winm4uWxZUnjXhzAHdh5vRnencrJcoFlyC3aamkeIlDemcbAy5vYGZkNUcI
 kqpOCkJyXGfc+8uyuEpwG3xU38UXzY0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-5lY5m1NuPQ2aoUxbXMm7tQ-1; Wed, 31 Jul 2024 03:41:09 -0400
X-MC-Unique: 5lY5m1NuPQ2aoUxbXMm7tQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7bcaa94892so468220166b.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 00:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722411668; x=1723016468;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q7+xt/kACVxCrvGUX6C+l3WTb/o1RqA4rrnA0EJzD3s=;
 b=XtkQap17VGU38WHubiQKxDdP0OAlvxj8VFiUoCMpHbuuvMST89b0LfevthYt/cVbLS
 K+WcXs4Aje0YjY4pS+Orrukm5bk+BEgoDYaEoZVFj4miw6bvMo10oud5yyMDX5JSCJ7C
 Y5hTMXXY9BgvJj+JkR1UD49P1uKFx/ttvMjVo4zmfnM7euE5KxBKxyZtvOz3uwPs43uV
 /ybC6psTMvxcQhp8Vm5JjSbsXMVQBwOSkLBb0rIQG/9znds7luMvDh4s3ej8fRJPAGOO
 CzWWeTEZm04yRZlkySa1HZprOut3uvLD9It87wLZikVIk1qmQLdH6HbfzOLltgXu5Uro
 5gqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0f5GMayrSKRNrHXUNrgc6jsb6e9FzxKwrmvkasBbghrd+2pzFGbjeNV84EFtEIV2NUI47o8iyT0X3V3hw7M3owaHqmAI=
X-Gm-Message-State: AOJu0Yw2dtFYfY2Ujc49MsGVMrt0BRTj8YqtTVaXd056s8hu4otgjxPW
 IirstypUzVpNhcGG3Bm5zAEDXWYYWyBJikPsBGslwWmhTqDcXsBc0gcSt6GcI7Qb1NIr4qh1pru
 4DrbKZHGh2wQwcJzDhy9Hli2ph0meSjxosOUJAv3PuQuqzKdjuQMe
X-Received: by 2002:a50:9e6b:0:b0:5a2:ec88:de7a with SMTP id
 4fb4d7f45d1cf-5b02394fe65mr8351805a12.33.1722411668578; 
 Wed, 31 Jul 2024 00:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLfgQhT39+UAHte2J+TC+KaQrKihD81bVvLgryjYx02KHWj+WRkvj3J61NNNJsa+mxA43zKw==
X-Received: by 2002:a50:9e6b:0:b0:5a2:ec88:de7a with SMTP id
 4fb4d7f45d1cf-5b02394fe65mr8351777a12.33.1722411667862; 
 Wed, 31 Jul 2024 00:41:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:d5c3:625c:d5f0:e5f4:6579])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac631b052bsm8243241a12.15.2024.07.31.00.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 00:41:07 -0700 (PDT)
Date: Wed, 31 Jul 2024 03:41:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240731033803-mutt-send-email-mst@kernel.org>
References: <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqnh-AJC4JPl5EkS@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 31, 2024 at 08:04:24AM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 30, 2024 at 05:32:48PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> > > On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> > > > This is not what we did historically. Why should we start now?
> > > 
> > > It's a matter of whether we still want migration to randomly fail, like
> > > what this patch does.
> > > 
> > > Or any better suggestions?  I'm definitely open to that.
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > 
> > Randomly is an overstatement. You need to switch between kernels
> > where this feature differs. We did it with a ton of features
> > in the past, donnu why we single out USO now.
> 
> This has been a problem with a ton of features in the past. We've
> ignored the problem, but that doesn't make it the right solution
> 
> With regards,
> Daniel

Pushing it to domain xml does not really help,
migration will still fail unexpectedly (after wasting
a ton of resources copying memory, and getting
a downtime bump, I might add).

The right solution is to have a tool that can query
backends, and that given the results from all of the cluster,
generate a set of parameters that will ensure migration works.
Kind of like qemu-img, but for migration.


-- 
MST


