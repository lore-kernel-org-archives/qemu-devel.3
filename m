Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B38C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gYh-0003Cm-58; Wed, 08 May 2024 08:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4gYb-00035a-7F
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4gYZ-0005UJ-Bs
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715171877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Qd1ROufodYLlLHDFoGox2MqDnx0x5IcbpSXqPReRzU=;
 b=IsxSoML9TtKv2ClTzO7pZELQT/AivoWBuf4uVYD5uun4XbM7oUKOsCxaEFMMDAYw3S8WVL
 R74d+WYNssq5cQN9uJOw5TGiOD6xtY3MdNi9En0MrPq/ohatCReij5PogmELpxDUE55OYh
 j64uhYF4212gH9aODddnEZUtYURfxFs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-08lsBC4mOfG9G1Os0wDR9g-1; Wed, 08 May 2024 08:37:56 -0400
X-MC-Unique: 08lsBC4mOfG9G1Os0wDR9g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572146eeed3so2121372a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 05:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171875; x=1715776675;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Qd1ROufodYLlLHDFoGox2MqDnx0x5IcbpSXqPReRzU=;
 b=OJKRuzNERajkQAn77hz+cyEyFwjDsDqvg20ptgGTlhzCWE928c6wE1fJLpWqw+5x89
 ZGwcWvxRMrRtbcoIK0rWA1pgqxB7KqcnZOPADB7qVaO89+Uh8E90QdrJLAK5RlKNqWbc
 MZNFquRGfuCr0F/y9+rfXPdwA6facGwPOhhyU8PastV/1uyOJ7Z/B6OcAes/pz1hfhjJ
 XgLKzOiyCP+3EFAJNQwt0Bg+HuNQofPcIBWtinCu8Eck6YX2tVuydpOghN5U0KlvUwj3
 s5Xj7qUSBH2cSMHJj0H4Nfm1sH3zZRM6tYzdSZCdfbIum63sc4wYL9LNG2hDl9ov1/8t
 aOAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEFDqQoXvBsiNx49Jlpjvk9XwaFH1j0lYyJH4BRcJEiYV5TMDKg6UH76HCfpXiTACgXZ3nEdXRdnGBHQxC8jDELqim+N4=
X-Gm-Message-State: AOJu0Ywu7zX19f0OTKXtieFnPS/CYYH/cuhXa3oJfir8lTiUFtwnbIfG
 FlnR9WZc10f+L+MJFnjuhlxKNqcUa3cxGAz44x/BtFHFWRrqMbWx+8CrU2b3CWrBWYFf/yUGME5
 3y4L0dEi9et/a8etLwdcJqy+SzJWvyp6dUatVLf+/dokYCVGT/ZMP
X-Received: by 2002:a50:cd93:0:b0:570:5e7f:62cb with SMTP id
 4fb4d7f45d1cf-5731da697ebmr1829739a12.29.1715171875425; 
 Wed, 08 May 2024 05:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu1msvbnoERHLRYUfLdwUq2Gk3IoExHvQPhucBGzpkRi5qaRe4azpLxkDk8pRd93kqwmTp0w==
X-Received: by 2002:a50:cd93:0:b0:570:5e7f:62cb with SMTP id
 4fb4d7f45d1cf-5731da697ebmr1829724a12.29.1715171875061; 
 Wed, 08 May 2024 05:37:55 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 g40-20020a056402322800b00572e0ab367dsm5647445eda.11.2024.05.08.05.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:37:54 -0700 (PDT)
Message-ID: <30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com>
Date: Wed, 8 May 2024 14:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hermetic virtio-vsock in QEMU
To: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Roman Kiryanov <rkir@google.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, QEMU Developers <qemu-devel@nongnu.org>,
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>,
 Mehdi Alizadeh <mett@google.com>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
 <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
 <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/8/24 11:38, Stefano Garzarella wrote:
> On Wed, May 08, 2024 at 01:13:09PM GMT, Marc-André Lureau wrote:
>> Hi
>>
>> On Wed, May 8, 2024 at 11:50 AM Stefano Garzarella 
>> <sgarzare@redhat.com> wrote:
>>>
>>> Hi Roman,
>>>
>>> On Tue, May 07, 2024 at 11:20:50PM GMT, Roman Kiryanov wrote:
>>> >Hi Stefano,
>>> >
>>> >On Tue, May 7, 2024 at 1:10 AM Stefano Garzarella 
>>> <sgarzare@redhat.com> wrote:
>>> >> I have no experience with Windows, but what we need for vhost-user 
>>> is:
>>> >>
>>> >> - AF_UNIX and be able to send file descriptors using ancillary data
>>> >>    (i.e. SCM_RIGHTS)
>>> >
>>> >As far as I understand, Windows does NOT support SCM_RIGHTS over 
>>> AF_UNIX.
>>>
>>> Thank you for the information. This is unfortunate and does not allow
>>> us to use vhost-user as it is on Windows.
>>>
>>
>> fwiw, Windows has other mechanisms to share resources between processes.
>>
>> To share/pass sockets, you can use WSADuplicateSocket. For shared
>> memory and other resources, DuplicateHandle API.
> 
> Cool, thanks for sharing that. So it could be done, but I think we need
> to extend the vhost-user protocol to work with Windows.

It would be possible to implement the memfd backend for Windows, using 
the CreateFileMapping() API.

However, the vhost-user protocol's VHOST_USER_SET_MEM_TABLE requests do 
not have any padding that can be used to pass the handle to the target. 
An extended version would be necessary.

One difference between Unix and Windows is that, if the vhost-server 
messes up the handling of messages from the socket, and therefore it 
does not close the handle, it is leaked forever.  This is not a huge 
deal per se, but I think it means that QEMU is not allowed to "open" a 
privileged vhost-user server process with PROCESS_DUP_HANDLE rights 
(translation: QEMU cannot provide duplicate handles to a privileged 
vhost-user server process).

Also I'm not sure what the cost of DuplicateHandle() is, and whether 
it's a good idea to do it for every region on every 
VHOST_USER_SET_MEM_TABLE request.  But VHOST_USER_SET_MEM_TABLE is not a 
fast path, so perhaps it's okay.

I think a virtio-vsock implementation in QEMU would be easier, lacking 
another usecase for vhost-user on Windows.

The main design question is whether multiple virtio-vsock devices for 
the same guest should share the CID space or not (I think it should, but 
I'm not 100% sure).  To connect host<->guest you could have a QOM 
object, here I am naming it vsock-forward as an example:

   -object vsock-forward,socket=SocketAddress,port=uint32,mode=connect

      takes the address of a listening socket on the host, and all
      connections to the given vsock port would be forwarded to the
      socket.

   -object vsock-forward,socket=SocketAddress,port=uint32,mode=listen

      creates a listening socket on the host, and all connections to that
      socket would be forwarded to the vsock port, where the guest should
      set up a server.

i.e. "mode" is what QEMU does, whether connect to the address or listen 
on it.

Another possibility for the names is to copy "hostfwd" and "guestfwd" 
names that are in netdev -netdev, i.e. respectively:

   -object vsock-guestfwd,socket=SocketAddress,port=uint32
   -object vsock-hostfwd,socket=SocketAddress,port=uint32

but I think it's worse.

Paolo


