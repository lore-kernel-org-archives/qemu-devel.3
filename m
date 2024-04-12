Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC105C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 21:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvO9K-0003im-KL; Fri, 12 Apr 2024 17:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvO9I-0003gi-Ew
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 17:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvO9G-0001cm-MJ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 17:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712956165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dal1NZcbygwizUjtOCwy8UwaHJQRI2H8SiQhJQeyYEY=;
 b=JC1dKgGTNT25vBRMgtqiZYy3l1XXJMtEgXuNJvsLG3nzL5jQ1hWL+LjYLYyS7mOBVdOOd4
 rsFkLugaJQ3XmhK7+aeUnvWmO3xDHXdYYFV8CvudLyyaopHr5kJDn5kz22x8Z8U4U5prcb
 66P4RQCRy2/IC7xmSqBSoqPWjIOABVI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-4bsiaSI1P3KgpM5bOA2rYQ-1; Fri, 12 Apr 2024 17:09:23 -0400
X-MC-Unique: 4bsiaSI1P3KgpM5bOA2rYQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso585642a34.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 14:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712956162; x=1713560962;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dal1NZcbygwizUjtOCwy8UwaHJQRI2H8SiQhJQeyYEY=;
 b=q6dnaiPyx0QEjYKj10n/8YGmTn0YUY2HtFqCqQVEapFhZH/5o0CHifQ9dxEHX1bnqz
 nhArPCWXYLc7c4THKITi/JClbh8v28raq9aPILTfnmPnX77N3XPnmf/EQ6CS5+VjYiF+
 XRr9MWwN6cNKw8jzNaMIlnFbeFh0tkCqEEzGyzhz/pbXxYewG/DKt5YSmZLs0YeCTW7e
 Yx76A33XNs6G9tQ1njZuhE/SlFkPAJ5FnVhN5h6EArogn8d4MCvzuc3l43fubHQNDg5F
 JwerF5BY3yw4gzCKEAryUztqfOdZot+f/IK4xCRxWQ4uj77KbtQg4FXV/KHtVv0EVlQt
 wO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo907eUDAv5Y8lbwpoyxtxBZAHXT/1D70c7tw7rJRb+eiy6CkAFbN2bcejDgxqhkLicrVJYt7c1UPcJc4nipStH0z+Jqs=
X-Gm-Message-State: AOJu0YybN6/WFVAgOA2fzrQbI5Uo39+g1QtmJOQ9RdgOjrxOcL/1+pbP
 /ffl+P4QM75r2bEQ/crtPMdiqoBMfe4mRDvJxLk0O0J95ngFGscnmyox6F8IGeKm1qvJ1/yOYMh
 Oim4//V+1vfCpcXrB8WzX8gx0w+l9J3LHEAogI540CYbn5o9oPDkm
X-Received: by 2002:a05:6808:13d4:b0:3c6:f7d0:43f3 with SMTP id
 d20-20020a05680813d400b003c6f7d043f3mr2161789oiw.0.1712956162492; 
 Fri, 12 Apr 2024 14:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQj2brjUiZ2iC9QFWD3Y4P3W/lnhw1w8kl/Srv24SWUApiyLEJd995T21fbsNKpPdZYefcIA==
X-Received: by 2002:a05:6808:13d4:b0:3c6:f7d0:43f3 with SMTP id
 d20-20020a05680813d400b003c6f7d043f3mr2161766oiw.0.1712956161852; 
 Fri, 12 Apr 2024 14:09:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o11-20020ac872cb000000b0043484220ac8sm2653190qtp.63.2024.04.12.14.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:09:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:09:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
Message-ID: <ZhmjABurFOqqkkpA@x1n>
References: <20240410111541.188504-2-het.gala@nutanix.com>
 <874jc9v066.fsf@suse.de> <Zhan0Brg_CXzt79-@x1n>
 <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n>
 <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
 <ZhgvAicT_36OLEBR@x1n> <87le5jbsbn.fsf@suse.de>
 <ZhlCcPTnW_-V85qR@x1n> <87il0mbpb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il0mbpb0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

On Fri, Apr 12, 2024 at 11:58:43AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Apr 11, 2024 at 04:41:16PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Apr 11, 2024 at 11:31:08PM +0530, Het Gala wrote:
> >> >> I just wanted to highlight couple of pointers:
> >> >> 1. though we are using 'channels' in the precopy tests for 'migrate' QAPI,
> >> >> we
> >> >>    use the old uri for 'migrate-incoming' QAPI.
> >> >> 2. We do not cover other 'channels' abi, only have tcp path tested.
> >> >> 
> >> >> So, the TO-DOs could be:
> >> >> 1. Omit the 4th patch here, which introduced postcopy qtests with 'channels'
> >> >>    interface OR have 'channels' interface with other than tcp transport
> >> >>    (file, exec, vsock, etc) so as to cover different code paths.
> >> >> 2. Extend channels interface to migrate-incoming QAPI for precopy qtests
> >> >
> >> > You can see whether Fabiano has anything to say, but what you proposed
> >> > looks good to me.
> >> 
> >> Ok, so what about we convert some of the 'plain' tests into channels to
> >> cover all transports?
> >> 
> >> - tcp: test_multifd_tcp_none  (this one we already did)
> >> - file: test_precopy_file
> >> - unix: test_precopy_unix_plain
> >> - exec: test_analyze_script
> >> - fd: test_migrate_precopy_fd_socket
> >> 
> >> Those^, plus the validate_uri that's already in next should cover
> >> everything.
> >> 
> >> We don't need to do this at once, by the way.
> >> 
> >> Moreover:
> >> 
> >> - leave all test strings untouched to preserve bisecting;
> >> 
> >> - let's not bother adding "channels" and "uri" to the test string
> >>   anymore. The channels API should be taken for granted at this point, I
> >>   don't expect we start hitting bugs that will require us to run either
> >>   foo/uri/plain or foo/channels/plain, so there's not much point in
> >>   making the distinction.
> >
> > Do you mean we can put "uri:" aside?  Maybe I misunderstood..
> 
> I mean the test name does not need to specify "channels" vs. "uri"
> because that should never be broken to the point that we actually need
> to go fetch those tests by name. We'd still have at least 1 test for
> each transport with channels and (existing) at least 1 test for each
> transport with uri.
> 
> >
> > The matrix previously was (I think.. when this series posted):
> >
> >   [tcp, unix, file, exec, fd] x [uri, channels] x [precopy, postcopy]
> >
> > Drop postcopy as doesn't seem to have any special paths:
> >
> >   [tcp, unix, file, exec, fd] x [uri, channels]
> >
> > So logically we should still cover these, right?
> 
> Right, I'm just suggesting we convert some tests to use channels, one
> for each transport, to test the channels API in full. The rest of the
> existing tests as well as future tests need not have a uri (or channel)
> variant. Just one of them is enough.

Ah so that's the "test string"; sounds all good.

-- 
Peter Xu


