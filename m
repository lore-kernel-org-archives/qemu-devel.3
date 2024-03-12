Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwNs-0001Wm-7y; Tue, 12 Mar 2024 03:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjwNp-0001WX-Ms
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rjwNo-0005gy-3B
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710227827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Obq0syRwpGRKRmE4G4QbL3f7PveuiAZJevpxYwbvJ8=;
 b=SPQzlxvZejn98zeQpY5rxiFl4pqaQXRKZa1S2f68A6rbBm1BoBkczaWfO30qdrBsP0mLy2
 f8q7+sczQtCjOuq/9F32DkmfriZNm2qgOX1Jq2e3vYf+F9ho0zCCA6UeBgbhPinHnZ+VO8
 0jWSM9iGfmH2dbOxiHT2HmvhVTt5WnI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-2ZA1enSSPf6szkJNKk6zAw-1; Tue, 12 Mar 2024 03:17:04 -0400
X-MC-Unique: 2ZA1enSSPf6szkJNKk6zAw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6b269686aso8073534276.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 00:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227824; x=1710832624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Obq0syRwpGRKRmE4G4QbL3f7PveuiAZJevpxYwbvJ8=;
 b=D0IHs2W1txcE9wF+sVus53hkh8FIhEamQAOa62DS/UW7KCSbC6ZOy9EK3tM3KzsTK0
 438TGL/rt7RpETiBeEe5smOAypmzB3IGF2Nsa1mQ8Zc4PG02JnDKriN4aKmkYKxybTQq
 8FEDuVuwaUzU9jsNqIPA3fUj5u8swZlD8++8PJtFjjEram0qoY1AP/xtZ90f4QpyMk/Z
 xpZFJKoQFuRaR1vlPr8lDPNRa2Bxuwa4heRJM5wX6PRGL+wQ/lad0JMlMfqEBrVzNSFB
 RnwHutAAfclXPPs+8cC6RBItJziY3eZgbZvztKfpb8hwYz7+BWnds8xDGTw724N4rohb
 F5Xg==
X-Gm-Message-State: AOJu0YxVVerFbsZkbeG3CA5mEvi6cRvKa/+ssiaTvob50F/EvueebURT
 UTcSTmFCg1ykyEp+j5P4ilceqhJu7iewLBtRdpXzyg4kmCtVtvkky7KzMEltt6h73jhm0C/TPdI
 WboMTuq6UziXSp74mDIESObBBzlPO7BzetzizrA1ZpQL0YngUf99/
X-Received: by 2002:a25:b109:0:b0:dc7:465d:c06d with SMTP id
 g9-20020a25b109000000b00dc7465dc06dmr2473800ybj.28.1710227823883; 
 Tue, 12 Mar 2024 00:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyMZcVM7/trpDZ98QsCJ2zIjgYtXNrLrE7Uyug8tRUKbafHPMNI8dKEwz1vAK5PTCUb36Ydw==
X-Received: by 2002:a25:b109:0:b0:dc7:465d:c06d with SMTP id
 g9-20020a25b109000000b00dc7465dc06dmr2473779ybj.28.1710227823546; 
 Tue, 12 Mar 2024 00:17:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s6-20020ad44386000000b00690c5cc0ff6sm2766084qvr.124.2024.03.12.00.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 00:17:03 -0700 (PDT)
Message-ID: <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
Date: Tue, 12 Mar 2024 08:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
 <Ze9ogyFZT73gB-La@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Ze9ogyFZT73gB-La@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On 3/11/24 21:24, Peter Xu wrote:
> On Fri, Mar 08, 2024 at 04:15:08PM +0800, Peter Xu wrote:
>> On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
>>> * [1-4] already queued in migration-next.
>>>    
>>>    migration: Report error when shutdown fails
>>>    migration: Remove SaveStateHandler and LoadStateHandler typedefs
>>>    migration: Add documentation for SaveVMHandlers
>>>    migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>>>    
>>> * [5-9] are prequisite changes in other components related to the
>>>    migration save_setup() handler. They make sure a failure is not
>>>    returned without setting an error.
>>>    
>>>    s390/stattrib: Add Error** argument to set_migrationmode() handler
>>>    vfio: Always report an error in vfio_save_setup()
>>>    migration: Always report an error in block_save_setup()
>>>    migration: Always report an error in ram_save_setup()
>>>    migration: Add Error** argument to vmstate_save()
>>>
>>> * [10-15] are the core changes in migration and memory components to
>>>    propagate an error reported in a save_setup() handler.
>>>
>>>    migration: Add Error** argument to qemu_savevm_state_setup()
>>>    migration: Add Error** argument to .save_setup() handler
>>>    migration: Add Error** argument to .load_setup() handler
>>
>> Further queued 5-12 in migration-staging (until here), thanks.
> 
> Just to keep a record: due to the virtio failover test failure and the
> other block migration uncertainty in patch 7 (in which case we may want to
> have a fix on sectors==0 case), I unqueued this chunk for 9.0.

ok. I will ask the block folks for help to understand if sectors==0
is also an error in the save_setup context. May be  we can still
merge these in 9.0 cycle.
  
Thanks,

C.



