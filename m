Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B1FC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkKR4-00036M-E1; Tue, 18 Feb 2025 05:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tkKR2-000360-BI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tkKQy-0005Ce-Ta
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739872950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vM8oQcw56iDzIkBNo5F9NbF7jvyuOGdoibeV82EJTvo=;
 b=LD0Cg1qGvsZwMLPW9MLTLFZca4J27IJm7zSbkbit4w8HAH3mETwXgFYHslIrnhyDDuoBJp
 bPWQunJcNOTPCzO0mHmZAnxRMAC3PmXkXb5RWm9E3QJJp7mqVNJCzkDlLR5/awwSaloQJ9
 FYfA26YxvWGdU8T4nMLBcTk4lpxzV1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-_h3Zs_SIPgmWXQaVOycpPQ-1; Tue, 18 Feb 2025 05:02:28 -0500
X-MC-Unique: _h3Zs_SIPgmWXQaVOycpPQ-1
X-Mimecast-MFC-AGG-ID: _h3Zs_SIPgmWXQaVOycpPQ_1739872947
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43970e7df5bso14604055e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739872947; x=1740477747;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vM8oQcw56iDzIkBNo5F9NbF7jvyuOGdoibeV82EJTvo=;
 b=piLxYUJBXPKIyV3mO3WvCSpBx0/knmMaCozIErJigA/tc2OFoNhjsjXLqV+JDEP6SN
 2aiwNj+Ax6kaAiPjOhZjm+AFh3Fo3oWCZUvhHYuas9QRVHEGuH2xjj3PrCQG5BXDYDZ8
 VeY2U3aKTMUJjUx/PtAlIpB1wyq89SO/InsIRWvdEA3b8sL6plgOlT3xQuChL9mArg+9
 LxGQaaDvM+33wCkejv4mZtZstsmb27yKtDngJ3FEGL+lHmvEFz7zxe9FbFWnQQC39ADV
 hhE2nijAdvIpVxHJaegLshbrkoEvfw0AJVaicT8o5qnVTncIKkA2E1qIH60CihTv8/oo
 JTyA==
X-Gm-Message-State: AOJu0YzGg+1IN7RWd+nFC3rTlgAnNnlpTqcuFvVba48bjPY4AWmd+Pj0
 xH2Fyzf6/ekC/aixbsBY9TMEEdsxTX0+Ys4hZzT2ReaMnu11CCrnqDwRnp0zyreMop4DpSIRn0K
 9rHEyBKOWBxK6Kuezd5znKiURidqIFcPij2vvcP7DEoZvX7OVUIca
X-Gm-Gg: ASbGnctksQJVNscMZY/JFcUdo/tz0YpJ8y+pPe4JRN1SEYsA4bC7Engx43qV4EfTRnW
 MJLqgAgI94BChHtTOyH0LkB8p2GhaOMyFemsGN1F+YgD56WqAC2kveNknKa4yQ9sFk39xiJXnSj
 5TT+pWqN50pWQ8eTqMavphB/7Ewczv8tP2evrTJdHodlC7AMsmdfoA7QBjS++vlVkoy0QqWjbU5
 4FjMCGgebrUeBgWWIQip61JqlBg3j6otgelUcQ3Q0SX4vefLTg4TaLKoINpwMzlIqh80kYPpvy8
 abx88w+7y48/u0aNCnpvqfA7SEsTO5c8rPlwHC58k2Q=
X-Received: by 2002:a05:600c:3b12:b0:439:96b2:e9b with SMTP id
 5b1f17b1804b1-43996b212d9mr9103135e9.9.1739872946890; 
 Tue, 18 Feb 2025 02:02:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNh/kIsdvirdjqAJEuNmlyW7FlbOcN76OpnaQ4ayGhPyVyoZhU/OhApcslDLslyjeXRRXPjg==
X-Received: by 2002:a05:600c:3b12:b0:439:96b2:e9b with SMTP id
 5b1f17b1804b1-43996b212d9mr9102755e9.9.1739872946420; 
 Tue, 18 Feb 2025 02:02:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398ba53406sm35956735e9.14.2025.02.18.02.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 02:02:25 -0800 (PST)
Message-ID: <a6e6ffa7-5536-487d-a9b1-126ec054eb13@redhat.com>
Date: Tue, 18 Feb 2025 11:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: vhost-user: add QAPI events to report connection
 state
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laine Stump <laine@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250217092550.1172055-1-lvivier@redhat.com>
 <87ldu3heti.fsf@pond.sub.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <87ldu3heti.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 18/02/2025 08:50, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
>> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
>> when it is disconnected.
>>
>> The NETDEV_VHOST_USER_CONNECTED event includes the chardev id.
>>
>> This allows a system manager like libvirt to detect when the server
>> fails.
>>
>> For instance with passt:
>>
>> { 'execute': 'qmp_capabilities' }
>> { "return": { } }
>>
>> [killing passt here]
>>
>> { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
>>    "event": "NETDEV_VHOST_USER_DISCONNECTED",
>>    "data": { "netdev-id": "netdev0" } }
>>
>> [automatic reconnection with reconnect-ms]
>>
>> { "timestamp": { "seconds": 1739538638, "microseconds": 354181 },
>>    "event": "NETDEV_VHOST_USER_CONNECTED",
>>    "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
>>
>> Tested-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>
>> Notes:
>>      v4:
>>        - as ChardevInfo is not needed, move events definition from
>>          qapi/char.json to qapi/net.json
>>      
>>      v3:
>>        - remove ChardevInfo, provides only the chardev id
>>      
>>      v2:
>>        - remove duplicate line info.frontend_open
>>
>>   qapi/net.json    | 40 ++++++++++++++++++++++++++++++++++++++++
>>   net/vhost-user.c |  3 +++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 2739a2f42332..310cc4fd1907 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -1031,3 +1031,43 @@
>>   ##
>>   { 'event': 'NETDEV_STREAM_DISCONNECTED',
>>     'data': { 'netdev-id': 'str' } }
>> +
>> +##
>> +# @NETDEV_VHOST_USER_CONNECTED:
>> +#
>> +# Emitted when the vhost-user chardev is connected
>> +#
>> +# @netdev-id: QEMU netdev id that is connected
>> +#
>> +# @chardev-id: The character device id used by the QEMU netdev
>> +#
>> +# Since: 10.0
>> +#
>> +# .. qmp-example::
>> +#
>> +#     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
>> +#          "event": "NETDEV_VHOST_USER_CONNECTED",
>> +#          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
>> +#
>> +##
>> +{ 'event': 'NETDEV_VHOST_USER_CONNECTED',
>> +  'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
>> +
>> +##
>> +# @NETDEV_VHOST_USER_DISCONNECTED:
>> +#
>> +# Emitted when the vhost-user chardev is disconnected
>> +#
>> +# @netdev-id: QEMU netdev id that is disconnected
>> +#
>> +# Since: 10.0
>> +#
>> +# .. qmp-example::
>> +#
>> +#     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
>> +#          "event": "NETDEV_VHOST_USER_DISCONNECTED",
>> +#          "data": { "netdev-id": "netdev0" } }
>> +#
>> +##
>> +{ 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
>> +  'data': { 'netdev-id': 'str' } }
>> diff --git a/net/vhost-user.c b/net/vhost-user.c
>> index 12555518e838..0b235e50c650 100644
>> --- a/net/vhost-user.c
>> +++ b/net/vhost-user.c
>> @@ -16,6 +16,7 @@
>>   #include "chardev/char-fe.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-net.h"
>> +#include "qapi/qapi-events-net.h"
>>   #include "qemu/config-file.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/option.h"
>> @@ -271,6 +272,7 @@ static void chr_closed_bh(void *opaque)
>>       if (err) {
>>           error_report_err(err);
>>       }
>> +    qapi_event_send_netdev_vhost_user_disconnected(name);
>>   }
>>   
>>   static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
>> @@ -300,6 +302,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
>>                                            net_vhost_user_watch, s);
>>           qmp_set_link(name, true, &err);
>>           s->started = true;
>> +        qapi_event_send_netdev_vhost_user_connected(name, chr->label);
> 
> We seem to use "label" and "id" interchangeably.  Unfortunate.
> 
> 
>>           break;
>>       case CHR_EVENT_CLOSED:
>>           /* a close event may happen during a read/write, but vhost
> 
> Like Daniel, I wonder whether provding events for chardevs instead would
> be more broadly useful.

In fact, it depends on what libvirt needs or wants.

If we implement the event for chardev, libvirt will have to find internally which netdev 
it belongs to, if we implement the event for netdev it has directly the netdev id.

But no one never asked for a chardev event until now, not sure it's useful.

Stefano shown that vhost-user event is really easy to use with existing code of libvirt.

> 
> That said, there's nothing wrong with the patch itself, so
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks,
Laurent


