Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B28AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 14:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7vD-0003Fo-HZ; Tue, 26 Mar 2024 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rp7v9-0003FN-E0
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rp7v7-0002Sq-PT
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711463817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cpzzInqDNO4C4wG1fWofqfROiH0o91cDZspX3asccjA=;
 b=aMWRKjYTBFpmiJBnSs7mE4vq5igbXt7Y6JRYJDg6WRAgR0cX8xyPQZgOrl1Q16QGOlqmo7
 XzeTJVxkt4H2KUZBoU4iwfAKmWSfe9OnTpv84v48pAi4AjhhhYeQQU/AQ3P8E+2SzM2Fc0
 QG4WUY+/TUVPnW1vhzChKrkGg/2eEro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-DLNiGCW8MxepjFPpsl0B5A-1; Tue, 26 Mar 2024 10:36:55 -0400
X-MC-Unique: DLNiGCW8MxepjFPpsl0B5A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41407fd718dso30949185e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 07:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711463814; x=1712068614;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpzzInqDNO4C4wG1fWofqfROiH0o91cDZspX3asccjA=;
 b=MC2MBxgnkJezYK1LH6rFqt/ITx77F2Z5ZdrikiQFz8BvulduMFQDoHbKlXil5V1gdv
 9zMlERLZ/S9lvH3v+ozoY4/rWfILAzQPbEF/duixTBwWSDMqAAEDPAA6sC7E0m5iskeb
 x5t60Ol1ZG8EmzXTJ8HJgwaT2a4yHEJUuHTS/4OKuC8hdQL9R/AGs/HMBDOoZO1yvb3Z
 40x5h1GrXodmJYeUxglLbMNJinb9KhWP5TOhoCf0zQmzC/ob3COmjCM36NQZbuw3fimR
 kAU8Fm1ezNdT6xoZ+9QN2F0qudvD6wqgwlWR8vuiqDyB7V8jPCopoRxZiv4NJMt67v0X
 8M4g==
X-Gm-Message-State: AOJu0YzAZ5603XyLGYgOfWAFkrPu/wf253dO5u5g//boi2Bxjyky36W7
 Puu6zTnX1cgkmmZMHTJpe8XL/DsWD58LSaA6YoD1U9jQv35ZOa+CLUGLVAOHBDXfvGvBsfWfouT
 GHJp6fYKGezT5EThAQReQH1SzrURROFB7/f6vn7/RJBu/69OA6EVC
X-Received: by 2002:a05:600c:1d01:b0:414:624c:aaf with SMTP id
 l1-20020a05600c1d0100b00414624c0aafmr6289385wms.35.1711463814269; 
 Tue, 26 Mar 2024 07:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu/gIwF05ETc/Tc4xsZx1Dnwn6UrOryFr2vGYpO0ISNuZTZDbEeM1UEl2j0Mw25fNIcx2JzQ==
X-Received: by 2002:a05:600c:1d01:b0:414:624c:aaf with SMTP id
 l1-20020a05600c1d0100b00414624c0aafmr6289358wms.35.1711463813866; 
 Tue, 26 Mar 2024 07:36:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2?
 (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de.
 [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a05600c4f1500b004148ab95c36sm5240030wmq.41.2024.03.26.07.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 07:36:53 -0700 (PDT)
Message-ID: <348b5359-a683-486e-bf69-f1d5f0a95d56@redhat.com>
Date: Tue, 26 Mar 2024 15:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v2 02/11] libvhost-user: fail vu_message_write()
 if sendmsg() is failing
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-3-sgarzare@redhat.com>
 <ubrm3znnvrpwoiwoekvztbcga2r37folr6cjjcasfaarc2pwek@pz66newnog3a>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ubrm3znnvrpwoiwoekvztbcga2r37folr6cjjcasfaarc2pwek@pz66newnog3a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On 26.03.24 15:34, Eric Blake wrote:
> On Tue, Mar 26, 2024 at 02:39:27PM +0100, Stefano Garzarella wrote:
>> In vu_message_write() we use sendmsg() to send the message header,
>> then a write() to send the payload.
>>
>> If sendmsg() fails we should avoid sending the payload, since we
>> were unable to send the header.
>>
>> Discovered before fixing the issue with the previous patch, where
>> sendmsg() failed on macOS due to wrong parameters, but the frontend
>> still sent the payload which the backend incorrectly interpreted
>> as a wrong header.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   subprojects/libvhost-user/libvhost-user.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>> index 22bea0c775..a11afd1960 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -639,6 +639,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>>           rc = sendmsg(conn_fd, &msg, 0);
>>       } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>   
>> +    if (rc <= 0) {
> 
> Is rejecting a 0 return value correct?  Technically, a 0 return means
> a successful write of 0 bytes - but then again, it is unwise to
> attempt to send an fd or other auxilliary ddata without at least one
> regular byte, so we should not be attempting a write of 0 bytes.  So I
> guess this one is okay, although I might have used < instead of <=.

I was wondering if we could see some partial sendmsg()/write succeeding. 
Meaning, we transferred some bytes but not all, and we'd actually need 
to loop ...

-- 
Cheers,

David / dhildenb


