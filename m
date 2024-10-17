Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E378ED374AE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Sp7-0006Yq-HO; Thu, 17 Oct 2024 11:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1Sp4-0006YS-D0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1Sp1-0005h8-Sr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729180434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JEb+7spFTSOihVmXWW+wOCYhLEgoVcOuO6vp3oNfl78=;
 b=fH3HEOgfnVzkE+F57xDCKFfob/K+C3JNDn10iTgnGB8aPlmehrTyFOyxircguXzJrf9e8k
 VTtsT9M/k3Pcd7VLL4NQYPxuKaA8oZwdhqtwm8QZuc8WPajerUdjm6NhLOasHaWkyAgwzr
 L1hZZQAKztzByRH3Y42a6dqzdxO8SfU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-L6jpankLMJmKgueU0BF36A-1; Thu, 17 Oct 2024 11:53:52 -0400
X-MC-Unique: L6jpankLMJmKgueU0BF36A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a7fa073718so174873485a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729180431; x=1729785231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEb+7spFTSOihVmXWW+wOCYhLEgoVcOuO6vp3oNfl78=;
 b=UW5GMycPUiQsyV0ikbP1PyXQYdvd95oUyLnVkl0waKufIWlz/3Abuvn4cCOVLjXNtd
 EE0UByGZZc9z69xqjQ0zi1oNm6Sb2cF113czQdKurqC2/YcazoU3taINXVGHUlerFMpV
 JVsuP+n4uYgrqwlzgkZ6Ao6pqlWnM3GjwXovR2kbVMO2/9UDd7wqFaHIWXyInw8B2WVT
 sB5+oZUSWpKF9vuHxr/NWPF3bKcgA4ffBqd8DR+X/g3O/E3Kxt1THONmSnGw0bm+TP8l
 pYFGDxKOzCy1NnB0Cqx8ewu+j2zir3d49CPQgy/4G9wzbf4jxRf0/sjju1ukJ1Sv1IYd
 e2Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwxcldPW1ojnMO8x4cbYyY+jf/qWe9WPuL6iknjtlfS+8zBt9XTtjWtBhQ0vpLuM2IUOYDW2IgsPth@nongnu.org
X-Gm-Message-State: AOJu0YzZUi5G80AsD/eG+MYzF+YUDaOOMsaBcFfGmLyUpo0WS4dUDT0I
 qWCMHvR7EpUpgiC9k3ZmyGIRrkuBTP0IY7Ai7StdD7yL6lKxH2mPQr2413yr00FlMCankjxg1Wr
 oqfQez39tDLChzOHI6abMgyliZ90oGnTUICOltfHf+9zc8Llupnok
X-Received: by 2002:a05:620a:2992:b0:7ac:a077:6a3d with SMTP id
 af79cd13be357-7b11a34b07emr3138156185a.10.1729180430682; 
 Thu, 17 Oct 2024 08:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOLEL17Yk3/VkWVI5/3CfZ6MviuvUvsaNFEc+wHHcshcY7YD9lTyfbSBlM7kNzDhGyRE+2Iw==
X-Received: by 2002:a05:620a:2992:b0:7ac:a077:6a3d with SMTP id
 af79cd13be357-7b11a34b07emr3138153185a.10.1729180430365; 
 Thu, 17 Oct 2024 08:53:50 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136164e20sm306374685a.7.2024.10.17.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 08:53:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:53:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <ZxEzCrkAgf1LRJ3d@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <e7a02200-b68e-4375-9689-5bd4b0e2a8a0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7a02200-b68e-4375-9689-5bd4b0e2a8a0@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 17, 2024 at 11:19:51AM -0400, Steven Sistare wrote:
> On 10/17/2024 11:14 AM, Steve Sistare wrote:
> > Define a new qemu initialization phase called 'precreate' which occurs
> > before most backends or devices have been created.  The only exception
> > is monitor and qtest devices and their associated chardevs.
> > 
> > QEMU runs in the main loop during this phase.  Monitor connections are
> > active and can receive migration configuration commands.  QEMU starts
> > listening on the normal migration URI during this phase, which can come
> > from either the QEMU command line or from a migrate_incoming command.
> > Thus the user can issue query-migrate to get the socket-address for
> > dynamically allocated port numbers during precreate.
> > 
> > In this series QEMU passes through and does not linger in the precreate
> > phase, and the user sees no change in behavior.  The cpr-transfer series
> > will linger in the phase for an incoming CPR operation, and exit the phase
> > when the migrate command is send to source QEMU and causes destination QEMU
> > to read CPR state.
> 
> Hi Peter, I rebased the cpr-transfer series on precreate.  The
> cpr-transfer migration-test now works.  Do you want to see cpr-transfer
> V3 now, or wait until we get feedback on precreate?  The only significant
> change is that I deleted the HUP synchronization, and I post an async
> listen for the incoming cpr-uri connection.

Maybe you can still send it, because I remember there're some other
discussion that may not settled yet (e.g. how anon-memfd is applied, iirc),
then it can be reviewed and discussed concurrently when proper with the
precreate series.

Thanks,

-- 
Peter Xu


