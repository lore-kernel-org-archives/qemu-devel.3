Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEECC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLDP-0005OL-Oj; Wed, 12 Mar 2025 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsLDN-0005OB-K0
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsLDI-0002Dl-FF
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741782569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DFig/tT++RgTmwBf88C+yaw/1Jm69Oryipn9zny2SPQ=;
 b=Rh/nf1Y8gxXE2HQ0n35EKJHKfatzbTY3Ys4hZYow+zykdtEcEEiYh9bP2cvLuuXJwt3Tz2
 0hAV/tI0Q+PFVmmR5u8KvSre1ANniyj4Rs0e8aNXSVVS910fWBiBdu1rFqneY9q/5VTY/K
 v3ymILWRwtjjMb+TOfxrYxrKpuCuZ9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-LfLUtLb3P7CetNgYem8ing-1; Wed, 12 Mar 2025 08:29:27 -0400
X-MC-Unique: LfLUtLb3P7CetNgYem8ing-1
X-Mimecast-MFC-AGG-ID: LfLUtLb3P7CetNgYem8ing_1741782566
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so19282045e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741782566; x=1742387366;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFig/tT++RgTmwBf88C+yaw/1Jm69Oryipn9zny2SPQ=;
 b=OVHt431u0DUt2wuJ7HFZFdYi9VNm9d5p2+SE0OVHd1M6bE7PjY6dxO1b7bP+lhhrJr
 kOadsoafyw/Das8jasEN9aI32mT1ZFOCIG0oHVJlwBMs0Wvhn0IgDrNW/Hn58A/IaHRe
 x37ygssFXD8To3ppo+SwJrtbuZlfo1wNGlzRlQAOkFUiVaH6ZKncA/gW33qgk3dK1A3C
 OI7vnB6A7yWrkdTzbTFqG/EVQ8KIsLuryFzQBLRMIQjPTHURgxWsfEIEskFn+WP8LM1w
 7KMrOkVnHR3LsgJRAE7PQCB5C4X64c8l3ZLnWsj7LWqJqgy9GiMfDSKyseobt5toXsWd
 C3tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUetWgD0Ovi6MDid+tSksvVqO3u3WljB3YAwmgzZS9dHewzUtMeMQoPMXGQXc97kM5nR979Qc/SOHeu@nongnu.org
X-Gm-Message-State: AOJu0YxGnOHpxLekbN0Mxkaf6HSWqEGv15S52uPOTPpwHr19SrGE/AwC
 /B4rftos7iBGKew1VqorrnYuCjZpzdDD36n3DET1G6ny90X28K2opEP/7sxXJmZlFPR5ZruBsDt
 SZERGKODdR0sWunPE+mPGLTSuZpyyZ5rk+g73RfrJcvAmBwX8Rv6M
X-Gm-Gg: ASbGnctX0O/ZzG+uZip3extN4Fivpt9ihNnKPfF+2qhRWqhsPj5N/w8sHmdzydG4uFu
 Di/NS/Cxxs+0LuhKnjei9mgT5r9B3qlBRMl0raDPDklnozUTvhHgeWD/+fpC3bq7qj0O6xRW/ea
 0HG0KiRnLyzJZthoUfiDUePm+9XVLFdN/qkqT+drCbOJVlx6LfnBgaN+zHi4XC9buNDTeiD+Ofh
 AZpHkqEnllZgk7Fv49M54ZYZaVRx8fbsi1FjcFE23SV9Fp1t09uXddaeJfpCd1rNsOT6b90lfjn
 fFhEA2AUCCsolK5iXkzlhVQ8FivXLr60RUFUJ6zFz+N7YDM=
X-Received: by 2002:a05:600c:45c6:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43ce7ae4f6cmr149797715e9.0.1741782566214; 
 Wed, 12 Mar 2025 05:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwd6WpZAbAm2s6Vs1fFTYX/fFLxVM04uR0yWigNlCziybEK6PVoRkfvnBejeqraBFxiDenlg==
X-Received: by 2002:a05:600c:45c6:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43ce7ae4f6cmr149797495e9.0.1741782565830; 
 Wed, 12 Mar 2025 05:29:25 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b6asm21230307f8f.66.2025.03.12.05.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 05:29:25 -0700 (PDT)
Message-ID: <741d932c-95c0-4a6a-b91e-6d07e7767675@redhat.com>
Date: Wed, 12 Mar 2025 13:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <b9550966-3c60-48dd-b0f3-a6833bd59cd9@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b9550966-3c60-48dd-b0f3-a6833bd59cd9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/03/2025 13.18, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> (patch merged as commit 4f7689f0817)
> 
> On 16/8/23 23:07, Thomas Huth wrote:
>> When starting a guest via libvirt with "virsh start --console ...",
>> the first second of the console output is missing. This is especially
>> annoying on s390x that only has a text console by default and no graphical
>> output - if the bios fails to boot here, the information about what went
>> wrong is completely lost.
>>
>> One part of the problem (there is also some things to be done on the
>> libvirt side) is that QEMU only checks with a 1 second timer whether
>> the other side of the pty is already connected, so the first second of
>> the console output is always lost.
>>
>> This likely used to work better in the past, since the code once checked
>> for a re-connection during write, but this has been removed in commit
>> f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
>> some locking.
>>
>> To ease the situation here at least a little bit, let's check with g_poll()
>> whether we could send out the data anyway, even if the connection has not
>> been marked as "connected" yet. The file descriptor is marked as non-blocking
>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
>> not cause any trouble if the other side is not ready for receiving yet.
>>
>> With this patch applied, I can now successfully see the bios output of
>> a s390x guest when running it with "virsh start --console" (with a patched
>> version of virsh that fixes the remaining issues there, too).
>>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   chardev/char-pty.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index 4e5deac18a..fad12dfef3 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
>>   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>   {
>>       PtyChardev *s = PTY_CHARDEV(chr);
>> +    GPollFD pfd;
>> +    int rc;
>> -    if (!s->connected) {
>> -        return len;

Old code discarded the bytes here if it was not able to send them ...

>> +    if (s->connected) {
>> +        return io_channel_send(s->ioc, buf, len);
>>       }
>> -    return io_channel_send(s->ioc, buf, len);
>> +
>> +    /*
>> +     * The other side might already be re-connected, but the timer might
>> +     * not have fired yet. So let's check here whether we can write again:
>> +     */
>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>> +    pfd.events = G_IO_OUT;
>> +    pfd.revents = 0;
>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>> +    g_assert(rc >= 0);
>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>> +        io_channel_send(s->ioc, buf, len);
> 
> Could io_channel_send() return -1 in this case, and if so is it OK to ignore 
> it?

... so now you get the same behavior here in case they could still not be sent.

Why do you ask, did you run into any problems with this new code here?

  Thomas


