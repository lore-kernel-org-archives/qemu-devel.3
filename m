Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B4EC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 13:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taxbY-0006h5-AJ; Thu, 23 Jan 2025 08:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taxbV-0006gp-MD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taxbO-0008Do-UX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737640232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fLZcur8ry0Pe5RUQ+0w7u4SP/Z9/v8c4DXd3ceCnUg8=;
 b=XvX/8oq5/Ibmk9ojZt0v9T6sTdzsdLl53lZ/RH2DhYTcw0+sRM6oZAOLXlMZV0xR3OYKQb
 Un2nKAgn7CfrcL3WC1t9sXPG03maP2qui3CicdiktIgcryBSQ9p/UqqmMJxm+jJ/y94c0t
 cCuag1IULP/oW106tlfyTHrWoOCQeVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Y7OwgqymNMWTzt2eU-Aujw-1; Thu, 23 Jan 2025 08:50:31 -0500
X-MC-Unique: Y7OwgqymNMWTzt2eU-Aujw-1
X-Mimecast-MFC-AGG-ID: Y7OwgqymNMWTzt2eU-Aujw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so400160f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 05:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737640230; x=1738245030;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLZcur8ry0Pe5RUQ+0w7u4SP/Z9/v8c4DXd3ceCnUg8=;
 b=EGLchBBgxv/QpsUJakg3ZiNSFbkgqRPm25Gj4JHLZvaiwEbvWIT/2qpGy/NQYyW1XE
 FuHRLI2JIUf7xSSLbd6VqQ6zi7IQVH9011WpGxe8wagncw7R1ruPfDA82whWzpfDPzOB
 akPYFmjAXo0+Tl0QaqTmWGIUy0r9AwOwXmES8GHoMW24cgwXtBn4Fhqtxq533hcrT6R0
 R1HRydWjfc8kgtt0VubOfMI4xDWL6ZSPN5Bgz41EQ23TirDDwLkhLi38aA/n1g4BPBhW
 C6AnPbaan8HhrOm6JizOVW0x3rRnwM4nHHkDx7DNEKbVj3FyAckE+pkWDJxpgSQMMY8Q
 sPEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSnAzK3nBgXCoxNC2PTkGzxthiO8y5q0Ge62zM5TbTbB66jeCHM3ruXpa+6l8DnehWa1tpqyBsm8H8@nongnu.org
X-Gm-Message-State: AOJu0YzYbFtLOku3x5a+WJSDR0oGxedk7NOTRlC64DDRwUk6Adord5Mg
 GzPWRPXJGwGNn/e3WBJOCnaqkKF2yRnUJ/T4/Q89JTpcOFdmzraeQyrlrukV7FoFZa4Cxga6ggd
 cOsSajCyWmTFJheLJgyfYYCGsrhoFyBObXsdXdTjocIPL67mli9yK
X-Gm-Gg: ASbGnctDr8SvnWKJ+NlLdZ3w7PbAw5jb0YuIjhfku0WTY3p0zFcmhdqKqmk5TdqdcDt
 J4JI8FwvvFJe0R4WLQPKc7F5JE2dmtQS+4TrU8ptOy9WXAHReXnql+vqoXQe7XEDb5iswPmkfWr
 Cb/J6fGu3hTVKjjZrOTUZwJC42Jv/Mg6Tklr0+awcYY46KQcm3Nk0IA16EfE1Dy4PoPxNOY59G7
 0+Sc4XhxlIhhP2kSQciF8UwUSyQS/JfssJ+zHyvHDgNj2LmFvJwkz/+4hT1+QlT63IiRj548LWe
 Mp0QCkJPTHIDxZmXfpPpTucnR0TkTGQF
X-Received: by 2002:a05:6000:2ce:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38bf566e683mr21748792f8f.5.1737640229849; 
 Thu, 23 Jan 2025 05:50:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyaIAtO2WAbvSstf+is/jQR74ATNitnseqOuN4DeC4a+DSbZUsqRUyOW6hJ/RAG4r5Xo9LsQ==
X-Received: by 2002:a05:6000:2ce:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38bf566e683mr21748732f8f.5.1737640228738; 
 Thu, 23 Jan 2025 05:50:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31b15absm62962915e9.22.2025.01.23.05.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 05:50:28 -0800 (PST)
Message-ID: <5ea637ad-c108-4fa9-854a-e36ef0294b33@redhat.com>
Date: Thu, 23 Jan 2025 14:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 00/26] vfio-user client
To: John Levon <levon@movementarian.org>, qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
References: <20250108115032.1677686-1-john.levon@nutanix.com>
 <Z5IV70w1qoR/EXid@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z5IV70w1qoR/EXid@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello John,

On 1/23/25 11:11, John Levon wrote:
> On Wed, Jan 08, 2025 at 11:50:06AM +0000, John Levon wrote:
> 
>> Hi, this is the 7th revision of the vfio-user client implementation.
>>
>> First of all, thank you for your time reviewing the previous versions.
>>
>> The vfio-user framework consists of 3 parts:
>>   1) The VFIO user protocol specification.
>>   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
>>      and sends them to the server.
>>   3) A server - a remote process that emulates a device.
>>
>> This patchset implements parts 1 and 2.
>>
>> It has been tested against libvfio-user test servers as well as SPDK.
> 
> Ping, would appreciate any review comments

Well, among the reasons why we tend to push this at end of
the list are :

   - the respins are spaced over time (1 a year ?)
   - it's invasive in an already very complex subsystem
   - it's HUGE. See the diffstat below ...

I would introduce a new hw/vfio-user/ subsystem given the size.
The commit logs are short. Most are one liners, this is really
not much for such a big change.

Any how, I hope to take a look before the end of 10.0 cycle.

Thanks,

C.


  MAINTAINERS                           |   11
  docs/devel/index-internals.rst        |    1
  docs/devel/vfio-user.rst              | 1522 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  hw/vfio/ap.c                          |    4
  hw/vfio/ccw.c                         |    9
  hw/vfio/common.c                      |  131 +++++--
  hw/vfio/container-base.c              |    8
  hw/vfio/container.c                   |   78 +++-
  hw/vfio/helpers.c                     |  185 +++++++++-
  hw/vfio/igd.c                         |    8
  hw/vfio/iommufd.c                     |   31 +
  hw/vfio/meson.build                   |    5
  hw/vfio/pci.c                         |  595 ++++++++++++++++++++-------------
  hw/vfio/pci.h                         |   35 +
  hw/vfio/platform.c                    |    4
  hw/vfio/trace-events                  |   17
  hw/vfio/user-container.c              |  358 ++++++++++++++++++++
  hw/vfio/user-pci.c                    |  446 +++++++++++++++++++++++++
  hw/vfio/user-protocol.h               |  245 +++++++++++++
  hw/vfio/user.c                        | 1705 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  hw/vfio/user.h                        |  132 +++++++
  hw/virtio/vhost-vdpa.c                |    2
  include/exec/memory.h                 |    4
  include/hw/vfio/vfio-common.h         |   54 ++-
  include/hw/vfio/vfio-container-base.h |   11
  meson_options.txt                     |    2
  scripts/meson-buildoptions.sh         |    4
  system/memory.c                       |    7
  28 files changed, 5280 insertions(+), 334 deletions(-)


