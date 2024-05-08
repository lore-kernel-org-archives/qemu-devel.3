Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A22C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dlQ-0007w5-D2; Wed, 08 May 2024 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4dlN-0007sa-S4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4dlM-0000fb-Ae
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715161139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7N/yN+nPCNNDov8icVGS0dzaBiKHm2CYjPhFHiya1A=;
 b=PHOQiWwU9V9GOFcYn8whdCSdIKTbEwAemO4htuhyujVYC8XQ7WgsBmw907CNiS8EJc+0fU
 Y2PANB1XGrZXni4sUI1f2cKCYJX7zoaTuvgg0TmY/l+dU7qpPfyXbRZPENNMRz+BuiWq6A
 LEmQyAyT3r/5tDautFpDmUk7wa5CW68=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-MeRvY4wxNPOjpcApT01Qiw-1; Wed, 08 May 2024 05:38:58 -0400
X-MC-Unique: MeRvY4wxNPOjpcApT01Qiw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e482d3d8b3so2289301fa.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161136; x=1715765936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7N/yN+nPCNNDov8icVGS0dzaBiKHm2CYjPhFHiya1A=;
 b=FGS/aDrHFUeloafRDOKNc7LprX34aqMpVq+ZTRt5xMLtlyzRlS88a1sOFyeslcpk7p
 CZx/XCYstaWmhjAC62+XIq3zpF8u6QGwg23R1z4HS9MT6LGKk2K3VzWFZR9sd/jmrlEK
 OMQqAxvooaF+MXAXYUQQZIIVsbpZOtxALsmz1f6gqSe+saXQKmcRdMOUgKjYxqZnece/
 W1gKcdFMLVrbiRUWIKXjDP7dCIfmWNobT0MI7IU+4LLvYnZlYMZzFYpDf1xK2spg9vdt
 g8XPFaGGNB48y94yKj5SlV/5sCVbIC8RiQubPjXRMzS8CpHsaAYPAzoa7Tc6iob1/bHa
 Hs9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIbZF8jdskccUF7r6Hb9hFLUD+osgsicaH+52nf6bKWFkDv4+WzRN0RhzMyYm1KfSIweOOAxpHhE+HRzixTilpz/jGT88=
X-Gm-Message-State: AOJu0YzpWOtAGerfOwJ+pLEHZjrBV819UZbPGt78UY3vm4kSI3/ooH7K
 ImmSSHiR5GuAqo1pdhq7bR8aWddb9UpSj/09MsbpLoPxv3ODDQhnF6XQ95fJCZ++I23mJyEcJNN
 utXuGaF+OaqNInTak08FI1HLZoOyOszZqSaQZByR3ILI4aVzED/53
X-Received: by 2002:a2e:90cf:0:b0:2de:7cc5:7a27 with SMTP id
 38308e7fff4ca-2e446d83cb8mr12214321fa.5.1715161136551; 
 Wed, 08 May 2024 02:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtz6ZpeDbPZXGgrZk0Vrca8hJX2yTjJE7h7AVCHK520sgjbv6t4oNujY92zUjuTpRwvvX+8A==
X-Received: by 2002:a2e:90cf:0:b0:2de:7cc5:7a27 with SMTP id
 38308e7fff4ca-2e446d83cb8mr12214191fa.5.1715161136145; 
 Wed, 08 May 2024 02:38:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87b2648fsm16768065e9.7.2024.05.08.02.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:55 -0700 (PDT)
Date: Wed, 8 May 2024 11:38:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Roman Kiryanov <rkir@google.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org, 
 QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
 <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Wed, May 08, 2024 at 01:13:09PM GMT, Marc-André Lureau wrote:
>Hi
>
>On Wed, May 8, 2024 at 11:50 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Roman,
>>
>> On Tue, May 07, 2024 at 11:20:50PM GMT, Roman Kiryanov wrote:
>> >Hi Stefano,
>> >
>> >On Tue, May 7, 2024 at 1:10 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> I have no experience with Windows, but what we need for vhost-user is:
>> >>
>> >> - AF_UNIX and be able to send file descriptors using ancillary data
>> >>    (i.e. SCM_RIGHTS)
>> >
>> >As far as I understand, Windows does NOT support SCM_RIGHTS over AF_UNIX.
>>
>> Thank you for the information. This is unfortunate and does not allow
>> us to use vhost-user as it is on Windows.
>>
>
>fwiw, Windows has other mechanisms to share resources between processes.
>
>To share/pass sockets, you can use WSADuplicateSocket. For shared
>memory and other resources, DuplicateHandle API.

Cool, thanks for sharing that. So it could be done, but I think we need
to extend the vhost-user protocol to work with Windows.

Thanks,
Stefano

>
>(you can also share other things like D3D textures etc. those
>mechanisms are used to enable -display dbus on Windows efficiently)
>
>
>-- 
>Marc-André Lureau
>


