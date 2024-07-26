Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C563C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXOv9-0001d0-Jv; Fri, 26 Jul 2024 13:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXOv6-0001cE-U9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXOv4-0004sW-Ky
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722015593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2cNW9KIZaZSppconmcGb9bj+CJjKMhkvW8N9c6C+1jw=;
 b=JLeNU5ULiIBaOaYwK/1Keuctx786GJ9yth3AI3KttDBqfcaIByvk7RXNSTbUP7JADEnb+v
 7vTXNGSOz8N3gQRu0VVnBksWecpRxrNjAInUN1reWyJ6Vu3pc6fWzU9yDLN8mx8xfPX0Rd
 LLZchJ1L0KtXpGgyySgBUG6+YdoMH0E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-D-OpsjxFNcO9eavk7-7Apg-1; Fri, 26 Jul 2024 13:39:50 -0400
X-MC-Unique: D-OpsjxFNcO9eavk7-7Apg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7ab81eea72so164559766b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 10:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722015589; x=1722620389;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cNW9KIZaZSppconmcGb9bj+CJjKMhkvW8N9c6C+1jw=;
 b=KHiJ8ZkOTqZ9pM1VmJ1QGGOEXUW9OLuWRoT7ybR+50cNh/Pj/o1Z2Y8l9OBMcH8gQv
 1973FHjPJDYRu2dv/k2hrbwc4EIMz8sVh3HHmOnJg0Kj/TZTbUpWhz1KBxmhYTXeJmet
 sLpDbh4yYDmbXCPbYoM7ZBQkpNWDzJDmvylPSwYzgqv/Lq96zIeqbcoF4o9JCbpUk2JK
 SL1jhsAZSdYaYHra6qO0/DKxSXaLdHok0pVsXcVtWT6rcaWbZ4TzcC7+CjQxEkL4vplM
 8iTOkl0nPvlJPqIOxGd3gB6bwvMXT0m/+HH8beRHYhL0hEnIWdqhojq2LE7bqP6FL0fA
 CHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmnWNqjQywf9tOzkdrXHfANOEtbeCr89mztU2cHDXddH6LULb1xArRJ2I2Kb3HCxIpOzgFAANcCZpP88fjBUSXUZto/40=
X-Gm-Message-State: AOJu0YxF1e4P/h6DnXkuGtCMLcOwsu+zmlq9Qe/v+pgJN5jhjKGO0Ovt
 qwDOp+kSezpHDR1rQUaTS5tDUXQoD3uzkIqvLIk4qKnCPqimmBeKUJPPEI+kWGLZ7knkY9OD8Ni
 IDIsAu4PDgl2pO7AtbNkNtzr6iOvWanJjMzQJRx9aRy2Ydd9l+6ru
X-Received: by 2002:a17:907:98b:b0:a7a:83f8:cfcf with SMTP id
 a640c23a62f3a-a7d40071d9emr14931666b.35.1722015589200; 
 Fri, 26 Jul 2024 10:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyihqUtqwpMf1Wha3Dsy13e4JB86eBb7PoJXfpCqp7qHs+0bXJCz0SrxZ7iObdyXpyq31nHQ==
X-Received: by 2002:a17:907:98b:b0:a7a:83f8:cfcf with SMTP id
 a640c23a62f3a-a7d40071d9emr14929866b.35.1722015588684; 
 Fri, 26 Jul 2024 10:39:48 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-36.web.vodafone.de.
 [109.43.178.36]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad9308asm198024666b.180.2024.07.26.10.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 10:39:48 -0700 (PDT)
Message-ID: <fb5fbcbd-ff55-466f-b48b-aa12adca3179@redhat.com>
Date: Fri, 26 Jul 2024 19:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <20240726032520-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240726032520-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/07/2024 09.25, Michael S. Tsirkin wrote:
> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>> USO features of virtio-net device depend on kernel ability
>>>>> to support them, for backward compatibility by default the
>>>>> features are disabled on 8.0 and earlier.
>>>>>
>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>
>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>> USO supported, to another host that doesn't..
>>>
>>> This was always the case with all offloads. The answer at the moment is,
>>> don't do this.
>>
>> May I ask for my understanding:
>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>> depending on host kernel features, or "don't do this" = don't try to migrate
>> between machines that have different host kernel features?
> 
> The later.

 From my experience, it should rather be the former. We've seen similar 
issues with the s390x machine in the past when trying to automatically 
enable features depending on the availability of a kernel features. While it 
looks nicer at a very first glance ("hey, a new feature is available, we 
enable that for you, dear user!"), you end up in migration hell pretty quickly.

Maybe we could elevate the "--nodefaults" command line switch to avoid 
enabling such features automatically?

Anyway, while we're discussing solutions: We are in softfreeze already. 
Should we disable the UFO bits in the new 9.1 machine type for the time 
being to avoid that more people are running into this problem?

  Thomas


