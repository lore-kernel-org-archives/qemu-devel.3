Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A387C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvHid-0005Zd-GK; Fri, 12 Apr 2024 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvHib-0005Xr-Rv
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvHia-0001Y8-4a
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712931446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weUlRJmEriVGlhdTVB9SwCxAfTTm0SSH0zhQwH9vXfM=;
 b=DO3UtYbB0BExgtq6tGp2q7tlylGF3y9kHsj68sHQ+1efjZQR6ZF9aH1P0gOZ9xfV8vf6ev
 mP5ttTVop1ihH2Ba1VgnSp3bnP6DFzgMLKPsbfucfkirQRhPhe0yRhDJZViCblA2GB+Z65
 XM/YbZgOte4TzsinVZm8NojEgB7GY2g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-LZcQ6O75OUG4HowECK0WxA-1; Fri, 12 Apr 2024 10:17:24 -0400
X-MC-Unique: LZcQ6O75OUG4HowECK0WxA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-436507937ecso2998871cf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712931443; x=1713536243;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weUlRJmEriVGlhdTVB9SwCxAfTTm0SSH0zhQwH9vXfM=;
 b=rqZThmfpdcIucD1JUnHcqYefG0YRS8GxW6A8AzD81uxPpF6tw6Ft7giEI/10Rhj8u+
 JGE+KUJkU1Lf/+VNBKumwtbRnNmkWbM1YoA33lEKgKg75cd7AjeahCfoSFGgIK7b9wga
 LdX57INgn/dL+CAEsCUm2ynoPGVHmMNcWDKxZ/T4w5ELt7Rysx1Gk+Sao6LfjC23Jzcw
 f7BcdMu8jn9V3HswGJLWTAK4E6Bje+H+EkNF6DmvT224P/T88ZiPUIxO0c9iNgHp5Iq7
 soej+hjsMWuQCvc8c5dRSkWs8AhH+PV/h9IVOnEqePrxTDZamoqybpEJJKCFpqDS5tu6
 8oFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2MirLIpm1LXYTJ3ph7XLHaqCNydeMYWyWnM+0v5RU7K7kYDDHY+LZaqMkOLixHuvlnAV5NgIS/TFlaREmly9EZ+iiwQU=
X-Gm-Message-State: AOJu0YxrT4p6Rg5ktnG8wDQ7as3QNAF2kj7tsxGz6RQrGOkiWg//uPIc
 78V8hdfsg+IR+BLYFg7lM7OFJ2vnl7PwFailOvmaywdTKuy2+cyABEQjkuhbIIzTqCFwyYJkiHc
 6ifIRGdg2gRo6z2UAQZKIPejYUotVoLE3ppEZYQ74onipyjgFxEVEoMxJDFG8
X-Received: by 2002:a05:622a:18a1:b0:436:7438:9629 with SMTP id
 v33-20020a05622a18a100b0043674389629mr3179810qtc.4.1712931442417; 
 Fri, 12 Apr 2024 07:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDMlQV2BJpv84W6HEwI4YGb5XUn7eFJEbsY1CHddwxZqDLzr3X8nniqGoGo26mD4Y6T4yRkw==
X-Received: by 2002:a05:622a:18a1:b0:436:7438:9629 with SMTP id
 v33-20020a05622a18a100b0043674389629mr3179779qtc.4.1712931441880; 
 Fri, 12 Apr 2024 07:17:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 he4-20020a05622a600400b00434efa0feaasm2285983qtb.1.2024.04.12.07.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:17:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:17:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
Message-ID: <ZhlCcPTnW_-V85qR@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com>
 <874jc9v066.fsf@suse.de> <Zhan0Brg_CXzt79-@x1n>
 <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n>
 <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
 <ZhgvAicT_36OLEBR@x1n> <87le5jbsbn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le5jbsbn.fsf@suse.de>
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

On Thu, Apr 11, 2024 at 04:41:16PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Apr 11, 2024 at 11:31:08PM +0530, Het Gala wrote:
> >> I just wanted to highlight couple of pointers:
> >> 1. though we are using 'channels' in the precopy tests for 'migrate' QAPI,
> >> we
> >>    use the old uri for 'migrate-incoming' QAPI.
> >> 2. We do not cover other 'channels' abi, only have tcp path tested.
> >> 
> >> So, the TO-DOs could be:
> >> 1. Omit the 4th patch here, which introduced postcopy qtests with 'channels'
> >>    interface OR have 'channels' interface with other than tcp transport
> >>    (file, exec, vsock, etc) so as to cover different code paths.
> >> 2. Extend channels interface to migrate-incoming QAPI for precopy qtests
> >
> > You can see whether Fabiano has anything to say, but what you proposed
> > looks good to me.
> 
> Ok, so what about we convert some of the 'plain' tests into channels to
> cover all transports?
> 
> - tcp: test_multifd_tcp_none  (this one we already did)
> - file: test_precopy_file
> - unix: test_precopy_unix_plain
> - exec: test_analyze_script
> - fd: test_migrate_precopy_fd_socket
> 
> Those^, plus the validate_uri that's already in next should cover
> everything.
> 
> We don't need to do this at once, by the way.
> 
> Moreover:
> 
> - leave all test strings untouched to preserve bisecting;
> 
> - let's not bother adding "channels" and "uri" to the test string
>   anymore. The channels API should be taken for granted at this point, I
>   don't expect we start hitting bugs that will require us to run either
>   foo/uri/plain or foo/channels/plain, so there's not much point in
>   making the distinction.

Do you mean we can put "uri:" aside?  Maybe I misunderstood..

The matrix previously was (I think.. when this series posted):

  [tcp, unix, file, exec, fd] x [uri, channels] x [precopy, postcopy]

Drop postcopy as doesn't seem to have any special paths:

  [tcp, unix, file, exec, fd] x [uri, channels]

So logically we should still cover these, right?

Thanks,

-- 
Peter Xu


