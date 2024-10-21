Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EE3D15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v9h-0005WC-Sa; Mon, 21 Oct 2024 12:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2v9O-0005Kd-TY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2v9N-00049x-Db
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mstckrJMDjF6iw5guSYUvdoOXAtEPcsm4kpIPxJNTvQ=;
 b=LThZ7420qjkq2Hz5ccHaIeAOPCwSgHjcYFeERb9IyKNe1Ar0kSc64232Z0NFBqXemjUgLi
 bNyJjB1vY0JGtHbqg2GwKK/kU42cgBOZNEoJOpbwkCsrR4FOCCzn6PRtRB0UkYU7cBBDkz
 81lLrBvM4/74EP2x/kdfL732skXlGdk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-6fA5r8rJM2254_5I03tTmg-1; Mon, 21 Oct 2024 12:20:55 -0400
X-MC-Unique: 6fA5r8rJM2254_5I03tTmg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b14634dba8so863227685a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729527654; x=1730132454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mstckrJMDjF6iw5guSYUvdoOXAtEPcsm4kpIPxJNTvQ=;
 b=swAxG5dbGXFijo+96BhZpe26HjQAFFFp6zV7hWz5cDZaFcXgUHQ6pMZpx9pgYQS2/H
 388p+SmkatH8CIOnpa7GzTs+xzOtWvXEIJbKggR1N/YH9RuL387jXrX9k2Xh/5LUVq+b
 ZuAtSdUzA2mwf7ZSs0hAw4uU1HuiLE4TOO0JkPeoffCAFOJ96/POAXLl3IiTPUDRcUDk
 qmeW1JE9x5EOx7utAM8hkSuFh97KvBBMej8a8MBBwbb3IJU4LwoqjSA620D4sduf/o5J
 YnodoZAr2HXZCwidLtEBuoxknMkevNG/31JJqvdEZ5lRDV4ECLNYP2P3mLPMpe3yZCOr
 gZDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhIsgY6anf4yN7HqK4U4s9LrKfZXgfqwYUf1DAiQL8ALGnPGF/oHWvTHW19d/JnFoDyqJu3BjgCZfV@nongnu.org
X-Gm-Message-State: AOJu0Yx9SEysi1bjRzlJNyiSWz9VkPrhfTjYyig81ABL/jW4S1iJ+0AG
 w4HGP9z7hLfbj+/CmYBTFvt+WgYxGi0hCNlgh3e9gA0cK+epbeYOoCjYKq2UJJWbWd2cYGDd3jV
 gUhTN4RTNjDIhu/D0WFTVKEQPXuZKcAZHJjzMABbc4DYjV/h5sWBu
X-Received: by 2002:a05:620a:4620:b0:7a9:8679:993 with SMTP id
 af79cd13be357-7b157b3fda4mr1408578585a.13.1729527654524; 
 Mon, 21 Oct 2024 09:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3VHCI3p4b2OXIcOQqyeIoABfVO81wHSg/RLsTnOEM5BuMIK7JsWWI2G2bHN4LsN7fnWrxdQ==
X-Received: by 2002:a05:620a:4620:b0:7a9:8679:993 with SMTP id
 af79cd13be357-7b157b3fda4mr1408575685a.13.1729527654250; 
 Mon, 21 Oct 2024 09:20:54 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a06daasm184731285a.70.2024.10.21.09.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:20:53 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:20:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
Message-ID: <ZxZ_Y3DYgs8ZlhaI@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de>
 <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
 <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
 <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Fri, Oct 18, 2024 at 03:15:56PM -0400, Steven Sistare wrote:
> I understand this now.  The old code worked in this order:
> 
>   qemu_create_early_backends()
>     ... creates "-object can-bus,id=canbus"
>   qemu_create_machine()
>   qemu_apply_machine_options()
>     applies link property "canbus0" with value canbus, finds canbus object
> 
> The new code fails:
> 
>   qemu_create_machine()
>   qemu_apply_machine_options()
>     applies link property "canbus0" with value canbus,
>     error because fails to find canbus object
>   ...
>   qemu_exit_precreate()
>     qemu_create_early_backends()
>       ... creates "-object can-bus,id=canbus"
> 
> The fix is to provide a new function, called before qemu_create_machine,
> which creates only the backends that are needed to create the machine.
> AFAIK can-bus is the only one, because the xlnx-zcu102 machine has
> link properties.

Wanna share more on the specific solution?  I wonder if the plan is to add
one more special window for creating -object just for can-bus, and how to
justify that extra phase.  Perhaps whatever that do not require fd to back
it (so not affected by CPR)?  But not sure whether that's too special.

I wished it could be simply put into the "very early" stage (pre-sandbox),
but I think object_create_pre_sandbox() did mention that we need explicit
reasons for those, and I'm not sure whether this reason justifies either
for why can-bus is so special so can be created without the sandboxing.

-- 
Peter Xu


