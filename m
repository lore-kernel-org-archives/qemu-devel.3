Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A697C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBf8R-000604-JX; Mon, 27 May 2024 14:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBf8G-0005yJ-RM
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBf8E-00011j-CA
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716834696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=44xd8ACQgWoUiy/RUP62Kmq/A/Uh8J5UBRlIjIaeLc4=;
 b=JOChDXo8/53bNI6DMQCQcIOhdgRav7e0zi4mGBpQ0fU7Oy+HYD3EEB+HFYk9vBMLbg8/AN
 lEBziOueO06lc8gmEn0XDpUN2BIGVRsctisQzXUSFgvYqGzLaethIpBvbHbsG6Y7r2FExB
 jSorMxm6SiBBHVAz32tlH5DcYIf9Ch8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-jKhznWeiPWe0YR_0zf3syA-1; Mon, 27 May 2024 14:31:34 -0400
X-MC-Unique: jKhznWeiPWe0YR_0zf3syA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c9b3ae3a5dso29353b6e.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716834694; x=1717439494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44xd8ACQgWoUiy/RUP62Kmq/A/Uh8J5UBRlIjIaeLc4=;
 b=CxRQMib//146S2+zDprfklmd3YI8sXS4sb9QHry0h0OXPKg4EnhvHNDOsR4dEuyz7/
 sp7SRnMRVfSbYrFPFubR0RPFZUdVTpOg0yAYtvPZ0wXzvAOKKhsT3AmzJu0l59mT91Y0
 EvYsygvf5T3mrfia9WMNqzR6lcjInUZGc7drep8DjmAWWak1mHD8Z5Iu8gU56BVqZLER
 E8BBiP/Qq24p5D5et5Jm06kooBVB1TyJ8D/ZHc8snGeeSnmgG1WgzBd4A18wKRIhpNMK
 UTNCAJMe+eq8ORsS0mT7DuTwq5QFuPbqWUIJmiyxrs8IjuwJloezyKU3lP1oSFB1hNCI
 yJBA==
X-Gm-Message-State: AOJu0YwZGiuW/RFhr+ul32LNHLtbssIP01o6aSSWEmY8x683Ukj63Q1+
 WZJrucZxsG2s4D4rngAoBkrKMq2Z+Niakaxawb4931IihPyEO/JxDneK7VPGbg1x4BQ2XwA+v6o
 2hsf9qwjgvdyblK2awespQJW64k6xd9KE1IhDLqEt8PZQGj7psNaa
X-Received: by 2002:a05:6358:281a:b0:192:47fd:8bf0 with SMTP id
 e5c5f4694b2df-197e5669578mr984304455d.3.1716834693647; 
 Mon, 27 May 2024 11:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuwbkJF+DNwhwWJcMLJY8q+liD7hQEmUni+2xcGApXF1g2R7Z51I4BeNKfqez5ss4CmKyjJw==
X-Received: by 2002:a05:6358:281a:b0:192:47fd:8bf0 with SMTP id
 e5c5f4694b2df-197e5669578mr984301655d.3.1716834692907; 
 Mon, 27 May 2024 11:31:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0e58sm316274785a.40.2024.05.27.11.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:31:32 -0700 (PDT)
Date: Mon, 27 May 2024 14:31:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 08/26] migration: vmstate_info_void_ptr
Message-ID: <ZlTRgsNatkvsLKpL@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, Apr 29, 2024 at 08:55:17AM -0700, Steve Sistare wrote:
> Define VMSTATE_VOID_PTR so the value of a pointer (but not its target)
> can be saved in the migration stream.  This will be needed for CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

This is really tricky.

From a first glance, I don't think migrating a VA is valid at all for
migration even if with exec.. and looks insane to me for a cross-process
migration, which seems to be allowed to use as a generic VMSD helper.. as
VA is the address space barrier for different processes and I think it
normally even apply to generic execve(), and we're trying to jailbreak for
some reason..

It definitely won't work for any generic migration as sizeof(void*) can be
different afaict between hosts, e.g. 32bit -> 64bit migrations.

Some description would be really helpful in this commit message,
e.g. explain the users and why.  Do we need to poison that for generic VMSD
use (perhaps with prefixed underscores)?  I think I'll need to read on the
rest to tell..

Thanks,

-- 
Peter Xu


