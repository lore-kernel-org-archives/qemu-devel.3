Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A741EC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclXS-0002ik-Ls; Fri, 18 Jul 2025 09:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uclSd-0005vI-Bl
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uclSb-0008PY-M9
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752846552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjGlNlf8zwpGQynY2vEPoNssNpsDu6qikmmpoXGF1Kk=;
 b=ItxbDnB6e9/3TuNqzp7PuE6SxKaYpbKIeOD7tjfuZwoHxsE/szxqjOr2AbaC+klmwiur2b
 oJvnxyHlAkFsTEj3ycHguV3uPP2PlwLpgwD/NUx+QCPZNwo+onYW7ouXMxT6vwwfDnYPoT
 OiiaB8hogzbkSOe+bmc1W68MWlVZ8LQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-aahiOxrUMyy9gPvw3q5YGA-1; Fri, 18 Jul 2025 09:49:10 -0400
X-MC-Unique: aahiOxrUMyy9gPvw3q5YGA-1
X-Mimecast-MFC-AGG-ID: aahiOxrUMyy9gPvw3q5YGA_1752846550
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fb0e344e3eso20959136d6.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 06:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752846550; x=1753451350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjGlNlf8zwpGQynY2vEPoNssNpsDu6qikmmpoXGF1Kk=;
 b=TD8hCti7UwOrr1X559/wpizNDvQo9SizGhCPzKP7rB/LKUP8Uz7Ajoj5IIDzpjPKKd
 /7HzQpb7dtyBGEPBdv40MsQzj2YIxUkuHQOJfgoZOVHe6XgcGG8lWj2S/uwn82ccuQLv
 MOqezIRXjfqYnHK6nPq0/36Fs24e3MUXgBZYkbw5YyPM2o8sUpVruYosxXQO41LyBq8f
 +A7o3GMcP2aSZ81D2gVolwHSN83POdxvHxtm82bulNS36LLW1TYkFFNUAphNf6ZPtuMR
 seIDzGkku4+jZ+OtWDU5isi0XSqHCBG+YaJ2sVTvDwA+pjWz1KAoLWrYImquV0q4Znoc
 09kg==
X-Gm-Message-State: AOJu0YyFPg3g3QIm48jHIFv0kCGlkaYMSPGR+ZHm6kAIzukKbZzpWcav
 ssGjZTEazIn39j60q/9BeGlimPaF8K9e6wRnf1tIHKV6UPPxJrACH7V6Ph8hCji73rI12PnllDK
 6FduilbEcZK5WGFRenHrRWP4IQYGZnU+1bPuhNzZmLQ3zz1Z4GvKpTBG7
X-Gm-Gg: ASbGncvJdWCxOoHf3JeAUO0V1Pux8Ex8A255OXYN9RNrmNSNnPBPw4Ag/sw2xjl8Xue
 xdN32jWHnkmLpkwfga4sWngwDo4434t5VjpdCyfzSeiIl0aZPLepTZ86gB20mSMRJIayKmTWF9x
 ClRmHO1OK0OosNaFzkNWQTvJUTt8ofhnZC2RZDG+67l+//H1wejH/HSw1mCeoF4HicqJCCCUZHT
 09b7Fr5tkdK9JWcYNkFHmFZHaMs/GJ1hb7AeR0ZOhfafQwJUx7yMg4FbVUcMTNyyGvgOPvwD8q3
 LTLt6wTH7Gtj7UbP9rfxJ5ovTAaJaUTJ/WncvTUSrC/4r+VEFvAI7l2Rx8Q4zUzDNAn13jqbQrX
 ean1aFRnzOLV2ioY=
X-Received: by 2002:a05:6214:3c88:b0:6e4:2f7f:d0bb with SMTP id
 6a1803df08f44-704f69d2e2amr116970806d6.4.1752846550218; 
 Fri, 18 Jul 2025 06:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ytU/9AFkclHqqERvVcEGpp16bR3Z+MIdD5y1g8q3lBEalfyjUDnC/Wq7BCKS4E8rg1cBjA==
X-Received: by 2002:a05:6214:3c88:b0:6e4:2f7f:d0bb with SMTP id
 6a1803df08f44-704f69d2e2amr116970236d6.4.1752846549550; 
 Fri, 18 Jul 2025 06:49:09 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba93626sm7630916d6.87.2025.07.18.06.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 06:49:09 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:48:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 13/13] net: implement UDP tunnel features offloading
Message-ID: <fm3i2r4lmvzdjp4tly6gbk57knayn7533a27yzk2b3qc6o56io@idk2vwpexjfo>
References: <cover.1752828082.git.pabeni@redhat.com>
 <b59ee8e3eb926dd510a7a0f2de16f3d0380589f0.1752828082.git.pabeni@redhat.com>
 <7eaaizkny73ki3o3ph7bi2x6y7cjtfgyupsbyywxmcismtkdvn@vtgzq3bfygzz>
 <a137cad8-862f-4601-93ca-b1d9240acc71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a137cad8-862f-4601-93ca-b1d9240acc71@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 18, 2025 at 03:44:20PM +0200, Paolo Abeni wrote:
>On 7/18/25 3:22 PM, Stefano Garzarella wrote:
>> On Fri, Jul 18, 2025 at 10:52:39AM +0200, Paolo Abeni wrote:
>>> diff --git a/net/tap.c b/net/tap.c
>>> index 23c6c118e7..2dfa843547 100644
>>> --- a/net/tap.c
>>> +++ b/net/tap.c
>>> @@ -62,6 +62,8 @@ static const int kernel_feature_bits[] = {
>>>     VIRTIO_F_NOTIFICATION_DATA,
>>>     VIRTIO_NET_F_RSC_EXT,
>>>     VIRTIO_NET_F_HASH_REPORT,
>>> +    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>>> +    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
>>
>> The *_GSO_CSUM are not supported by vhost-net, right?
>> (sorry, I don't know the details, it just occurred to me by looking at
>> the fetaures we enable in the other patch.)
>
>Yes, the kernel module supports/exposes only the 2 features above:
>vhost-net need only to be aware of the exact virtio_net_header size,
>which in turn depends just on them. Enabling/disabling the outer header
>csum offload does not change the virtio_net_header struct.
>
>The actual csum offload is implemented by the tun device.
>
>Please LMK if the above solves your doubt.

Yes, thanks!

Stefano


