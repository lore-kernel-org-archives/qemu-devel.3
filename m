Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F56606AB84
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWYPzJab;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hKV0x7Xo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrBc-0001Zy-Gf; Fri, 13 Nov 2026 08:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRrBK-0001Tl-Ri
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRrBJ-0006rQ-0b
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794575944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cl2c6obxTb/1B0qcnUY/ghZHaM8q9aCrARahmdWrmXU=;
 b=YWYPzJabsX3OoaqhXR4J7LI9pEysEvuHtBWj5JZe7oHTR2IOO67+Hg7GHgfq3X/i2m4/RU
 3CpYVJaQL00NMiQHvWFrcMh+fUwV9koxYiaS18uOwgXpJvp9dazVa+b6wd495WdhiM9Cnc
 0Ayo71zCHgq0RISYSRRAeE50gFbWhO0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-qCkNG6mwPP2Ku42OmuJBTQ-1; Fri, 13 Nov 2026 08:19:02 -0500
X-MC-Unique: qCkNG6mwPP2Ku42OmuJBTQ-1
X-Mimecast-MFC-AGG-ID: qCkNG6mwPP2Ku42OmuJBTQ_1794575942
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so10404605e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794575941; x=1795180741; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cl2c6obxTb/1B0qcnUY/ghZHaM8q9aCrARahmdWrmXU=;
 b=hKV0x7XolYMo9MqCm9NJQ48NG2m/QuCLmnfdyGHnWLpRsYYbFAXhjb06YRO7DsOTsc
 Ep3nCJUlZ9S3LZQ28x8Pi309LlYS9K1Bk4O2jV7FV1tXxYyHIGXlCKBLxnqUAr9R3751
 aElC1tyU8qXoCudw4S+0tsHxiVAOHhYqTp4tOGEIXyMYoYivskdX0yJJFmOd6EWSEg1P
 QefRIo7AqtcoyTHIkpb2pWoJrAFIrKfRyLYllFHVqnLUG1MXmaroGrIMA5YeBVdV19bP
 H/dpOKBrJccnCNJArKjPWSz5vbRunv+RnGCtVvRMO7Fj1zT1tpgqlyg0p9pU9HqCcnG4
 kZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575942; x=1795180742;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cl2c6obxTb/1B0qcnUY/ghZHaM8q9aCrARahmdWrmXU=;
 b=xb+uJ6SXkGqAXeo70HditllOqi/Zu4ou3MAG9m+Y7KYn3bL49fuPZlnBXm7VAD90Zj
 qy5G959A2bldHNvmHXlxCnyVszByWK32LNr9WCZVcmUKVVTTrGkvDwry/zZM6/RYyRTU
 YM8Qi1xqjWeYtTcmKZ4mgRYvu/mLdA+Mrlvu8lCOlMxuT11b/1+5SBnn+Fj3x6fGsrHc
 HB+31pvy0Yo7pJXB3QBElRg6BTPIPUX6OYLr+dyV+qvU9VpgWFMR0EvEhuliCxeGNwHA
 t4e2L/FMFy1Ivc2YYv+SwEl9woeOGrqbq9LeHjQQqETxJffsOKKFvcwXj7IY9RGEnC1W
 +FeQ==
X-Gm-Message-State: APuU4Z+YmafqOK54Agem4vI1VTDmb3KnrMkSdxjNXF8unEGG5zjvVfyp
 CzhJpS1a7d5l1u8cicbozWNRsT9y7mndzK2Z15BVmqcNUxRApe4N6ngE3ZqhJISMhiXzTqjaQso
 G8ImPmNwtA8gtuZhovM10WKVBjGh2CqjRaFhATQgvgO+JmeaRT/skvD+J
X-Gm-Gg: AYBFou3QvGa4t+iATSq86JZwZ2LMBH2YBJgqspWVXTKHfMo/Qiu2NYmrb8+D/b6hUk9
 AGPrmiAD6wfRg+HDk3zAz1jQ8eQQpDOfGOMGOaQAUj3uTDNmiNhlKShk8k665aeI5EKaxM9wemC
 ZgVW0XXwJQzJ+Q9KAHsRWfz/xI9FfeODcbZ3fmL/6fEuGnOgG409LuBTisEUOJ0gJddjh9oXfLH
 I0CSKaUUGuNA255PXhwyhIlzQn9ge8FdkRQzLaixQ2wfmaDcvNSld3viUvnd4TBmZlPBNY4vktr
 hLH9JacfYF+6BhacC4G5DWqIffVNRq/PG+QDnJBRzVjYBEkGfHFxeCVvH3LD1E6AD7rodnvKyVN
 Vh/MJUzGxvPmYmCMdc+v0YJr9gqpzGbJW4vc=
X-Received: by 2002:a05:600c:8b38:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb55a7b45bmr54295965e9.10.1794575941667; 
 Fri, 13 Nov 2026 05:19:01 -0800 (PST)
X-Received: by 2002:a05:600c:8b38:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4bb55a7b45bmr54295245e9.10.1794575941101; 
 Fri, 13 Nov 2026 05:19:01 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm68462975e9.11.2026.11.13.05.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 05:19:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 14:18:59 +0100
Message-Id: <DMU42TIQJJV2.2CC6UQJNNTXDP@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Junjie Cao"
 <junjie.cao@linux.dev>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 5/9] hw/usb/dev-mtp: Validate container length on first
 data packet
From: "Tommaso Califano" <tcalifano@redhat.com>
To: <marcandre.lureau@redhat.com>, "Tommaso Califano" <tcalifano@redhat.com>
X-Mailer: aerc 0.22.0
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-6-tcalifano@redhat.com>
 <179455878072.754321.9063742155881524526.b4-review@b4>
In-Reply-To: <179455878072.754321.9063742155881524526.b4-review@b4>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 13, 2026 at 9:33 AM CET, marcandre.lureau wrote:
>> usb_mtp_get_data() subtracts sizeof(mtp_container) from the number of
>> bytes received, without checking. A short packet or a header declaring
>> less than 12 bytes makes these unsigned values wrap around.
>>=20
>> Reject the transfer if is smaller than the container header.
>>=20
>> Cc: qemu-stable@nongnu.org
>> Fixes: 88d5f381ecb2 ("usb-mtp: Introduce write support for MTP objects")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
>> Suggested-by: Hui Peng <https://gitlab.com/benquike>
>> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>> Message-ID: <20261112174907.158825-6-tcalifano@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 7233470558db..6fd92e5a687b 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1784,6 +1784,13 @@ static void usb_mtp_get_data(MTPState *s, mtp_con=
tainer *container,
>>              return;
>>      }
>>      if (d->first) {
>> +        if (cpu_to_le32(container->length) < sizeof(mtp_container)) {
>> +            usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->tra=
ns,
>> +                                 0, 0, 0, 0);
>> +            usb_mtp_data_free(s->data_out);
>> +            s->data_out =3D NULL;
>> +            return;
>
> Should it call usb_mtp_reset_pending_write(s) here as well?

Yes, I'll add it.

Thanks,
Tommaso


