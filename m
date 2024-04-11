Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvOP-0000p6-8F; Thu, 11 Apr 2024 10:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruvON-0000on-IK
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruvOM-0000tk-3K
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712845625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVao6WQq6GlF4InXsU8dQ9kDPyVt9Ra6P0r3D+7rDIM=;
 b=dsCKmiX0WsoXFwmw6h6MkC6wwAlKgvNE9N8veC3C1+ygNfRNWat4pug6Bs9qVMfaZjHukv
 qNIzTxj5kwTDvr1MsVCNsXkIThHBQGs6VXF0vroXqIFGSEH1EbmgzMVC68iPvrtdSJjoxa
 38DzHbz1Y9gkf1UVM9d/5nXQYCn7YRw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Sw5zniVcMee8T_T8WAykxw-1; Thu, 11 Apr 2024 10:27:03 -0400
X-MC-Unique: Sw5zniVcMee8T_T8WAykxw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6ea2ec4773eso654128a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712845621; x=1713450421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVao6WQq6GlF4InXsU8dQ9kDPyVt9Ra6P0r3D+7rDIM=;
 b=WKBY5YPQS35OGUTfgwITeLzW/d7CVfLdgtJ4JyB4mfqUwPfq5J+jtLjz3JGMshJgGD
 2YuYc2BHXZOSPXh7FBhBWX+gdwjA7bYmkbMGpiY6yABr5DQRkZ5/ko2CzaLwStuTMwJV
 gw04IzNRDKY0Rp/HUGr3OeJwSL3AAdgQtemm8ceH74sRXiMPVRTwkRhuivNn3sXHDFMa
 pH2IGWxb7rHU5K2MVl1PeK3oq7fmq0JSzCDrm4tKtNxY1Aw26472gAoZblJHCMMoGc/d
 gclkdNqx2SA/I91miK4af3FgR6NtU0mmTK+DvgkaCwTSyvkVcmT4qrmiGDqwMazJ/4YX
 boDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcySX1y4+jT3AupxjKRrT/XwXJWH+7KdBm0vd28XLBitLw7fM0wX/6Yb2Qwt/1ij1UrJgprh5Tjv1zYQlTshVAtz59bEs=
X-Gm-Message-State: AOJu0YzyF0uCm7+Ei4yUJVel+UVALu7vnLIi3i9mvgO2jrrErWOyH3rI
 Q5m5LtHtQyVMysYScAhkIVp2+tc3Y2zwCtg5hEdLUK3IKvGynOT90rcN8fkeE/U+dvNrrJp53sd
 zXx6vZZc+mUT3U7wNJd9Hn4krxD9m+xc82njaOuxJ3nr3uGlR4k4j
X-Received: by 2002:a05:6830:1d62:b0:6ea:2a7b:2de4 with SMTP id
 l2-20020a0568301d6200b006ea2a7b2de4mr5560613oti.2.1712845620872; 
 Thu, 11 Apr 2024 07:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcmQetJHXZGtZwkKTQIe33ejt9NR4IjPmI3CBuwt2lGyXzewibOz1OdymWG1PJh+CIyyy3xw==
X-Received: by 2002:a05:6830:1d62:b0:6ea:2a7b:2de4 with SMTP id
 l2-20020a0568301d6200b006ea2a7b2de4mr5560577oti.2.1712845620248; 
 Thu, 11 Apr 2024 07:27:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 i6-20020ad45386000000b0069b4d64ab0bsm694023qvv.138.2024.04.11.07.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 07:26:59 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:26:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
Message-ID: <ZhfzMt3t2oU7qt90@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com>
 <874jc9v066.fsf@suse.de> <Zhan0Brg_CXzt79-@x1n>
 <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 11, 2024 at 07:45:21PM +0530, Het Gala wrote:
> 
> On 10/04/24 8:23 pm, Peter Xu wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Wed, Apr 10, 2024 at 10:04:33AM -0300, Fabiano Rosas wrote:
> > > Het Gala <het.gala@nutanix.com> writes:
> > > 
> > > > This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
> > > > 
> > > > After addition of 'channels' as the starting argument of new QAPI
> > > > syntax inside postcopy test, even if the user entered the old QAPI
> > > > syntax, test used the new syntax.
> > > > It was a temporary patch added to have some presence of the new syntax
> > > > since the migration qtest framework lacked any logic for introducing
> > > > 'channels' argument.
> > > That wasn't clear to me when we merged that. Was that really the case?
> > Yeah these look all a bit confusing..
> > 
> > I'm wondering whether do we need the new interface to cover both precopy
> > and postcopy, or one would suffice?
> > 
> > Both should share the same interface.  I think it means if we covered the
> > channels interface in precopy, then perhaps we don't need to test anywhere
> > else, as we got the code paths all covered.
> > 
> > We actually do the same already for all kinds of channels for postcopy,
> > where we stick with either tcp/unix but don't cover the rest.
> Do we want to add other transports too (vsock, exec, rdma) with the new
> interface ?
> I believe we have tests for fd based migration

Het,

What I meant is we used to do white box testing for migration, trying to
cover all the code paths would suffice for us in that case.

It means maybe we don't need the postcopy test to cover the channels
interface as long as precopy has covered that and also if that covered all
the "channels" abi then we should be safe.

What I worry is we keep extending the test matrix but we're actually
testing the same code paths.  Then the test runs slower each time, we burn
more cpus for each CI kick, but without a real beneift.

Thanks,

-- 
Peter Xu


