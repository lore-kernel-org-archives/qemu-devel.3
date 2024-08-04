Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6570BC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 15:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadOH-0005Ga-IT; Sun, 04 Aug 2024 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadOF-0005F3-Q1
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 11:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadOD-0005OJ-L3
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 11:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722786198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPBShP6gLkVLC4k9oCbDnZ/GHvgHuKYiNh1jOXPc5yE=;
 b=Cftr7vnd1Uog2KfappOsTFO+fxH8oAEvZ5BNxDZ/7cqCIs6mC45L0fYlVeVTSTxA+Tjis1
 9+oWXXvZif2DYxZ1kwitB1ctdGEl6aiNhnIhCLF6e+IBHFyfeJyruLvvQ7iQ+bTzJMwq7T
 jt1T76bf+PreMVXcMt4Xsl3eMo/oef4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-cBohN2xkNEKcZKLOzWu7hw-1; Sun, 04 Aug 2024 11:43:17 -0400
X-MC-Unique: cBohN2xkNEKcZKLOzWu7hw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-70954de6142so1727165a34.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 08:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722786196; x=1723390996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPBShP6gLkVLC4k9oCbDnZ/GHvgHuKYiNh1jOXPc5yE=;
 b=ktkFXK04OZBZsN/u+m0yOGPbIsoHDS/ClD8B05QdRLasDLR9E0IWiratumsZUMR+s7
 5BSOxf12nzk2Hld2YnplhsOAs52ULgoCY24+PtJiAb46GJAT/B3S9FEuNZ83zWS97xUs
 InueFtvUOS6i+miKClM4Yd6TLZ6WhtlMUg/YoSd8SgQqgWvjm2/7XeHAqNFQiCFFp7NC
 rHbthX5BOZ9P7f9Yw2RWfKKAYGBc2tOQsZRLf8Z3AnrByP/BR1PjRt0kG4iSWVcRFtL7
 dbsN72hZihyKJTM8DAh7xqVmsVExEICWJQ/a4NyKblPkog3qvULjCOmsAIjcd3Qh8E/b
 GOQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOvc8WohLpOfiOeVdizk7viQra84+7oGyCumDsm75sPaY2YaNNuN5NHIIg+VKCR5oKTD8MAsl8/dsw@nongnu.org
X-Gm-Message-State: AOJu0YzzGrrd37hW8OxLS5WWZTVCUWQFRdn/pAGI/l3s4+KFSrCC9TNY
 V8UFOEquyUoK1BGWYCv5ZJiFmyc7uthSb8inClyx9Hpo0D4ihgIDl5vUDLBYCZw0gXVOSCREElC
 DEIEGB+3jUNJjTyA5saaCk2LgUaCssm/Y0+5FjUQYcqJlJ+nkjNI7
X-Received: by 2002:a05:6830:6188:b0:708:b80d:f3f with SMTP id
 46e09a7af769-709b996b07fmr6408337a34.4.1722786196177; 
 Sun, 04 Aug 2024 08:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBJ2jfbD9XAW6u0h1bV4NdLix+NkmEFNg/TV8p9dP/irC0EaA7+yNhh+AAaPz8IWJ4UziKyg==
X-Received: by 2002:a05:6830:6188:b0:708:b80d:f3f with SMTP id
 46e09a7af769-709b996b07fmr6408323a34.4.1722786195827; 
 Sun, 04 Aug 2024 08:43:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87c487sm26759996d6.131.2024.08.04.08.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 08:43:15 -0700 (PDT)
Date: Sun, 4 Aug 2024 11:43:13 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zq-hkUnPGWHMoEY0@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
 <37d9e725-1be7-48e1-b621-3f657192f124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37d9e725-1be7-48e1-b621-3f657192f124@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Mon, Jul 22, 2024 at 10:59:47AM +0200, David Hildenbrand wrote:
> > So I wonder whether there's comparison between exec() and transfer mode
> > that you recently proposed.
> > 
> > I'm asking because exec() (besides all the rest of things that I dislike on
> > it in this approach..) should be simply slower, logically, due to the
> > serialized operation to (1) tearing down the old mm, (2) reload the new
> > ELF, then (3) runs through the QEMU init process.
> > 
> > If with a generic migration solution, the dest QEMU can start running (2+3)
> > concurrently without even need to run (1).
> 
> I'll note (not sure if already discussed) that with the "async-teardown"
> option we have a way to move the MM teardown to a separate process, such
> that it will happen asynchronously.

I just had a look, maybe it won't trivially work, as it relies on QEMU
process to quit first..

async_teardown_fn():
    if (the_ppid == getppid()) {
        pause();
    }

While if we stick with exec(), then PID shouldn't change, so the teardown
process can hold the mm and pause until the VM is destroyed..

Thanks,

-- 
Peter Xu


