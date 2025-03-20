Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C82C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 08:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvB6y-0001uI-He; Thu, 20 Mar 2025 04:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tvB6x-0001tx-J2
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tvB6u-0003X1-UE
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742458718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yxg02BRiKC0jQlKzkYzZNHM00i4DDhRlkl6+yT0dUFY=;
 b=IDfRCjA6W9rdafLJ6S/K/k5OKB82QB7WegvCtp8/MW3qOLD/eVgLhEZW+KAvTmubEemjn0
 mJG9/AVb3gcb/JifYF5RkTs2gmUh4bA9w3xercuToD25Ht4O7vyHYHhul73qtrtjEqO0b4
 3fi3+ruiAkRAlf/01BDVAEQHzj6M5mU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-OpLdMsF3Mw-Ib-gDVxTAtQ-1; Thu, 20 Mar 2025 04:18:32 -0400
X-MC-Unique: OpLdMsF3Mw-Ib-gDVxTAtQ-1
X-Mimecast-MFC-AGG-ID: OpLdMsF3Mw-Ib-gDVxTAtQ_1742458711
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3914608e90eso289139f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 01:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742458711; x=1743063511;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yxg02BRiKC0jQlKzkYzZNHM00i4DDhRlkl6+yT0dUFY=;
 b=frCL6cD5YdfLoQkBRcGRu7XQ+6HVLrumliZvLNbZEvNooD547Frwvb2cce11XpPc03
 JJ9F3lXuAHmRU1/1aFyPDLoXx1D7p7A5+pTON1XfCRnmDing/tjuQoZS0shMEKkcFg5T
 uCXK+GVQnx8WPulxIavNWJYne8eGsy1UPv5tti0EQsEyQGAMqNsPa+4bSL92wn82wZ8Q
 z5OagsqW5p5jmLvrPS7jeeH1ZpKh6KPkT6p+gqKO3xFy0MGbKO2MmCgTgPmdZgkYGjqw
 0G2RvaxsWDaM1poCarJbTJrzKpS2fQju2zU1OvXoPlPjCaerGOpvYPTrm1g3ObvLp3h0
 r/ww==
X-Gm-Message-State: AOJu0Yy5MaBr8U2HzorBdmLiZ0DuGQbVgtP0J7MWoEX2t2jTXKoDxULe
 UyaTfALmig/dn8CQbnnnflLwLyz1bkdY6Ow6D5PNzIYrBwyjjtf5xbfahbOBS3eZYdfNf4MX2yZ
 6+QZrtapnF2R5Q3LszHsCb1U49k5gbL68V71cnw0k73bXhVDRqJn2kfhTaJbXwmbkrkdfnasRDu
 DzUnzJjPU6kcEflOvrruEIPw9aCrxl/nUYygQ=
X-Gm-Gg: ASbGncvFzg1S3JLzyCXFduF78V/ikJTZgQSLDi9iZL1s/qes1QDirhUZMv6wGRe9IOB
 uycJYZ/nhjPFNf8BYrWkyWdxlbcFVdvjYcGem6bKiyABPQUMEl1NwAlEg6gky5sSBlEuZz3UDEJ
 CVJtJ2e4t1FQnGGjWj56SRVlLdS3F94ty476kwsS2N2c8yzIeR8W3IfacXHQP4guQB7YexXQYeg
 iYkBGzNe6S3ul8jzhepWRup4FIxp0td6looPVtyVwLopu+Zx5ZrA48ZmvFkacrecjLCt9hQpwRl
 1a2gd8hLnmi2V32ZCsKGwqEgmEQgZFyzHYnsTz0oOOJtrFmBMGWxYwI=
X-Received: by 2002:a5d:6c61:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-39973afaa73mr4869749f8f.37.1742458711078; 
 Thu, 20 Mar 2025 01:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXL7yc9kzpxhn4y1BbncavaRkMd0H7XDdRi74F1pJ3Fev+DiwJQmcLjiF//exDsw2D6edjmA==
X-Received: by 2002:a5d:6c61:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-39973afaa73mr4869705f8f.37.1742458710550; 
 Thu, 20 Mar 2025 01:18:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d7c6a5sm41242825e9.0.2025.03.20.01.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 01:18:30 -0700 (PDT)
Message-ID: <cf9a3419-bb26-4d5e-bfe5-7b307fcc2f68@redhat.com>
Date: Thu, 20 Mar 2025 09:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: Explain how to use passt
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefano Brivio <sbrivio@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250311132714.166189-1-lvivier@redhat.com>
 <07d0ed00-f8ec-4b80-a6d6-368807998039@redhat.com>
Content-Language: en-US
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <07d0ed00-f8ec-4b80-a6d6-368807998039@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.476, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

I think it could be interesting to have this information in the current release.

Thanks,
Laurent

On 14/03/2025 09:43, Laurent Vivier wrote:
> cc: trivial
> 
> On 11/03/2025 14:27, Laurent Vivier wrote:
>> Add a chapter to explain how to use passt(1) instead of '-net user'.
>> passt(1) can be connected to QEMU using UNIX socket or vhost-user.
>> With vhost-user, migration of the VM is allowed and internal state of
>> passt(1) is transfered from one side to the other
>>
>> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   docs/system/devices/net.rst | 100 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
>> diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
>> index 2ab516d4b097..a3efbdcabd1a 100644
>> --- a/docs/system/devices/net.rst
>> +++ b/docs/system/devices/net.rst
>> @@ -77,6 +77,106 @@ When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
>>   connections can be redirected from the host to the guest. It allows for
>>   example to redirect X11, telnet or SSH connections.
>> +Using passt as the user mode network stack
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +passt_ can be used as a simple replacement for SLIRP (``-net user``).
>> +passt doesn't require any capability or privilege. passt has
>> +better performance than ``-net user``, full IPv6 support and better security
>> +as it's a daemon that is not executed in QEMU context.
>> +
>> +passt can be connected to QEMU either by using a socket
>> +(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-user``).
>> +See `passt(1)`_ for more details on passt.
>> +
>> +.. _passt: https://passt.top/
>> +.. _passt(1): https://passt.top/builds/latest/web/passt.1.html
>> +
>> +To use socket based passt interface:
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Start passt as a daemon::
>> +
>> +   passt --socket ~/passt.socket
>> +
>> +If ``--socket`` is not provided, passt will print the path of the UNIX domain socket 
>> QEMU can connect to (``/tmp/passt_1.socket``, ``/tmp/passt_2.socket``,
>> +...). Then you can connect your QEMU instance to passt:
>> +
>> +.. parsed-literal::
>> +   |qemu_system| [...OPTIONS...] -device virtio-net-pci,netdev=netdev0 -netdev 
>> stream,id=netdev0,server=off,addr.type=unix,addr.path=~/passt.socket
>> +
>> +Where ``~/passt.socket`` is the UNIX socket created by passt to
>> +communicate with QEMU.
>> +
>> +To use vhost-based interface:
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Start passt with ``--vhost-user``::
>> +
>> +   passt --vhost-user --socket ~/passt.socket
>> +
>> +Then to connect QEMU:
>> +
>> +.. parsed-literal::
>> +   |qemu_system| [...OPTIONS...] -m $RAMSIZE -chardev socket,id=chr0,path=~/ 
>> passt.socket -netdev vhost-user,id=netdev0,chardev=chr0 -device virtio- 
>> net,netdev=netdev0 -object memory-backend-memfd,id=memfd0,share=on,size=$RAMSIZE -numa 
>> node,memdev=memfd0
>> +
>> +Where ``$RAMSIZE`` is the memory size of your VM ``-m`` and ``-object memory-backend- 
>> memfd,size=`` must match.
>> +
>> +Migration of passt:
>> +^^^^^^^^^^^^^^^^^^^
>> +
>> +When passt is connected to QEMU using the vhost-user interface it can
>> +be migrated with QEMU and the network connections are not interrupted.
>> +
>> +As passt runs with no privileges, it relies on passt-repair to save and
>> +load the TCP connections state, using the TCP_REPAIR socket option.
>> +The passt-repair helper needs to have the CAP_NET_ADMIN capability, or run as root. If 
>> passt-repair is not available, TCP connections will not be preserved.
>> +
>> +Example of migration of a guest on the same host
>> +________________________________________________
>> +
>> +Before being able to run passt-repair, the CAP_NET_ADMIN capability must be set
>> +on the file, run as root::
>> +
>> +   setcap cap_net_admin+eip ./passt-repair
>> +
>> +Start passt for the source side::
>> +
>> +   passt --vhost-user --socket ~/passt_src.socket --repair-path ~/passt-repair_src.socket
>> +
>> +Where ``~/passt-repair_src.socket`` is the UNIX socket created by passt to
>> +communicate with passt-repair. The default value is the ``--socket`` path
>> +appended with ``.repair``.
>> +
>> +Start passt-repair::
>> +
>> +   passt-repair ~/passt-repair_src.socket
>> +
>> +Start source side QEMU with a monitor to be able to send the migrate command:
>> +
>> +.. parsed-literal::
>> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -monitor stdio
>> +
>> +Start passt for the destination side::
>> +
>> +   passt --vhost-user --socket ~/passt_dst.socket --repair-path ~/passt-repair_dst.socket
>> +
>> +Start passt-repair::
>> +
>> +   passt-repair ~/passt-repair_dst.socket
>> +
>> +Start QEMU with the ``-incoming`` parameter:
>> +
>> +.. parsed-literal::
>> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -incoming tcp:localhost:4444
>> +
>> +Then in the source guest monitor the migration can be started::
>> +
>> +   (qemu) migrate tcp:localhost:4444
>> +
>> +A separate passt-repair instance must be started for every migration. In the case of a 
>> failed migration, passt-repair also needs to be restarted before trying
>> +again.
>> +
>>   Hubs
>>   ~~~~
> 


