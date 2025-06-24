Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067F2C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU33l-0007IN-Dj; Tue, 24 Jun 2025 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uU33b-0007Hb-DX
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uU33S-0005BD-3n
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750769229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WUIuLtJbOUTCUtWtIQE1zfatifiHJ8cNKd0rQYnOR5Q=;
 b=ZDdd0HaO7UI/KcTPpshN1jSOM0aRF71Yk6BGmdFJEel/1Zrvwoh0jln6zYLC6KpTz7Ikae
 4r6SfWYbnPh1iJZvcMzHk3ycAcxsiRQ3Dh0ILtfTRMefBhSIpbbYwMqSRMIUkaO7RZ/W9B
 dpYg8lACTHQhPpAI/SvHDMA9SD5Cwp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-8iwia1vROPK944AmnXjOHg-1; Tue, 24 Jun 2025 08:47:08 -0400
X-MC-Unique: 8iwia1vROPK944AmnXjOHg-1
X-Mimecast-MFC-AGG-ID: 8iwia1vROPK944AmnXjOHg_1750769227
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d64026baso2525835e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 05:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750769227; x=1751374027;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUIuLtJbOUTCUtWtIQE1zfatifiHJ8cNKd0rQYnOR5Q=;
 b=DL/E7/M55aWlMCA0cGFoT9yIj9y/ncEsFz6qtn6u5aACFCrapTo5MHryoa88k/0sBk
 qhoOdtQRzgY9eOkF+DUfi4Qzk94R78NFyW9o32tA8apmxjrOZF3lpjADdV/n5U9rbyeK
 Zaj3+r6jTzb59tJvyVJHWJbML0td/bdiOpI7oRY0nYmTJEa9c9POzUjepFYFbwypRoxg
 DxbSf7oTHePyBdRTLvhLIzWwiyyoB13q3egiqNkDA6EpM5AtrRaVkJeuagcthdTqKAKI
 YAvx4vE4HY8vkg5BnUvBmYGDnmLpNRhWdCU3OwLy87hGOZfEgxUO3UdBYzI8W3f/2fpz
 fr2A==
X-Gm-Message-State: AOJu0Yw36NeXDAw8x63+el/lVY19ALK4yy8pMcZl3hhqYoxDlDR5NM04
 FP+tPNv8Q2ok/u3EYr81D9UAUJ/Lsa2XWlDmTZ8AKHJ4bn1pIDPuyJUFN4HeN4e+xwP+oA+Tty9
 FeOJx6JAFuAxd7Q7zpzApY2QRCuRpmLw/7JfyYVK78xDFCQwI+rW6jO8s
X-Gm-Gg: ASbGncui0x3yiU78AYhe0neG7f7BVejQcnxngGxJggOLiQJLmTuUXpjvX2OM+WYbhpA
 P00efWtgg3WI0mPrz9RFajkUt55uquq6V//8BMr+iKHTUWambVXrjTdsAKFTlluHez8CMbR9UWH
 k1vdS0I16dTVOvoFu1DI7AMk58AaMxZAcIUt4nJt5972v+dKFfPVw1z4fjAF/f6h4eDMScOZ9Tb
 Oagu80T5vkwkQVClZsSAq9XQPYUoIbJUyQgmmEd0R6GWG1c7MBcuFuOnFo2b4ovifW/J6W9NPyG
 62x5xwUdOPKSFNwnQK18NsyGOeg4SDCZlg1FJCnhV7ZF0I/+aReG0S/y3G9hrA==
X-Received: by 2002:a05:600c:4fc5:b0:442:e03b:58a9 with SMTP id
 5b1f17b1804b1-453659edd23mr141117805e9.25.1750769226930; 
 Tue, 24 Jun 2025 05:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07vWdVIKX00UnlHUirBTx2VRcRyH3Z26Hvw0Itxu9RQxIk000ykN+xoyGicZcCH6Ag7zPiQ==
X-Received: by 2002:a05:600c:4fc5:b0:442:e03b:58a9 with SMTP id
 5b1f17b1804b1-453659edd23mr141117435e9.25.1750769226523; 
 Tue, 24 Jun 2025 05:47:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f2274sm1851506f8f.48.2025.06.24.05.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 05:47:06 -0700 (PDT)
Message-ID: <3bb6ca25-c691-4a9a-9de3-9db7444c8904@redhat.com>
Date: Tue, 24 Jun 2025 14:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com> <87pletlflp.fsf@pond.sub.org>
 <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
 <87pleticbb.fsf@pond.sub.org> <aFqUENpgRvcYru6L@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <aFqUENpgRvcYru6L@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/06/2025 14:03, Daniel P. Berrangé wrote:
> On Tue, Jun 24, 2025 at 01:55:20PM +0200, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>>
>>> On 24/06/2025 10:16, Markus Armbruster wrote:
>>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>>
>>>>> This commit introduces support for passt as a new network backend.
>>>>> passt is an unprivileged, user-mode networking solution that provides
>>>>> connectivity for virtual machines by launching an external helper process.
>>>>>
>>>>> The implementation reuses the generic stream data handling logic. It
>>>>> launches the passt binary using GSubprocess, passing it a file
>>>>> descriptor from a socketpair() for communication. QEMU connects to
>>>>> the other end of the socket pair to establish the network data stream.
>>>>>
>>>>> The PID of the passt daemon is tracked via a temporary file to
>>>>> ensure it is terminated when QEMU exits.
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>>> index 97ea1839813b..76d7654414f7 100644
>>>>> --- a/qapi/net.json
>>>>> +++ b/qapi/net.json
>>>>> @@ -112,6 +112,125 @@
>>>>>      'data': {
>>>>>        'str': 'str' } }
>>>>>    
>>>>> +##
>>>>> +# @NetDevPasstOptions:
>>>>> +#
>>>>> +# Unprivileged user-mode network connectivity using passt
>>>>> +#
>>>>> +# @path: path to passt binary
>>>>
>>>> I'd prefer a more descriptive name.
>>>>
>>>> Elsewhere in this file, we refer to programs like this:
>>>>
>>>>      # @script: script to initialize the interface
>>>>      #
>>>>      # @downscript: script to shut down the interface
>>>>
>>>> passt isn't a script, of course.
>>>>
>>>> I don't know, perhaps
>>>>
>>>>      # @passt-filename: the passt program to run.
>>>>
>>>> or even
>>>>
>>>>      # @passt: Filename of the passt program to run.
>>>>
>>>>> +#
>>>>> +# @quiet: don't print informational messages
>>>>
>>>> What does the printing?  A peek at the code I snipped suggests this flag
>>>> is passed to the passt binary as --quiet.  Correct?
>>>>
>>>>> +#
>>>>> +# @debug: be verbose
>>>>> +#
>>>>> +# @trace: extra verbose
>>>>
>>>> Likewise for these two.
>>>>
>>>>> +#
>>>>> +# @vhost-user: enable vhost-user
>>
>> [...]
>>
>>>>> +# @udp-ports: UDP ports to forward
>>>>
>>>> Is there anything in this struct that configures qemu-system-FOO itself,
>>>> i.e. isn't just passed to passt?
>>>>
>>>
>>> Yes, all parameters are just passed to passt.
>>>
>>> Do you think it's better not to add all these parameters to netdev backend but only one
>>> generic containing the passt command line parameters?
>>
>> I'm not sure.
>>
>> Thoughts from libvirt's perspective?
> 
> We already have passt support in libvirt that leverages the existing
> vhost-user netdev backend to connect up QEMU.
> 
> I see this backend requires QEMU to be able to spawn the passt binary
> itselfm, which is not something libvirt would allow via our security
> confinement of QEMU. So that would rule out our ability to consume
> this netdev backend, as currently written
> 
> Is there anything QEMU can do with this passt netdev, that can't be
> done via the vhost-user backend ? ie is this merely syntax sugar to
> make it easier for humans launching QEMU, or is there some feature
> / performance benefit ?

The idea is only to allow user to run directly QEMU with passt in the same way it's done 
with the netdev user. There is no other benefit than the easier interface for humans.

For instance, we want to run '-nic passt' as we can run '-nic user'.

Thanks,
Laurent


