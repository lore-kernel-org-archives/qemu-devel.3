Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BAD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 14:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyX8-0002js-Ve; Tue, 09 Dec 2025 09:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSyX7-0002jc-TT
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:17:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSyX6-0008Ef-9r
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 09:17:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42e2e6aa22fso2698581f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765289858; x=1765894658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dVZb0DavteDetiUQncHLC+nicNx15FdXHct2DguvH9E=;
 b=WvCj9yiTSrKKbGPkfDnK764jmpFjiejN5AKROv96iwScfHe79iAh6l3UldjJjI2+34
 x6ugtRnPPBgb2YPVmp3xLahGtZidezuIvluz/V6OmsnYDqQ/Mqcm1sXTXR44jyorHkdy
 +mGGxaJoDpLRwlYS1kLF5xesrh87U4vU2qZ6Hxw2/x7HvkfRgbQnRwSzMzmDlC4lXXgu
 r76QrogN7G5b/1sihGraU9AN6wBpAgyMLJJK0Q2BmWlZnYkLNGeiO4AVHgdOzJpkg5mS
 SQqTnl+CRpjqo/hJoUzcD5gIB4udvObAbJBbZsw6TY7U8O/Ahkd7CQHj5AHWqsZxTAD5
 1SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765289858; x=1765894658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVZb0DavteDetiUQncHLC+nicNx15FdXHct2DguvH9E=;
 b=fn88F86ehN3a8XhJFwGl6SObNGLKwTj4hv3QC+Woo5ybD/QyCtNNXKQkYdGjcHbTtr
 IvzbHzbifZmtI1RugHlKQIjxdiSfBt6t/RUxKfiIjqcwwXNeHRN1SJxvuCRoHX2o/koi
 rl5VebhXTFAKTsx/z1cdVLz/VZrU9MIQqFg6/xbeqmH3t8RQQbgqTP3SFV7VCSSJ3N8M
 8KqOIZdzx6LGMEZQz2hyYCcw5s4kn1i9pDtGUIXkBRg5+lHR+s6xGeBHI/BmJIT2Pn+g
 yQM/8N62BhA8bNOOlrVpLYc2SL6rKg4Iwo0Zj73JArfvN5SMtSElMGWnS+ptspaGwWcJ
 oQHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXORoy9XLzjVgbuyCQ3Cxbm8pw8bcCxkx6LUY8rLtb+VEggA2IIaBNy5SQ1y7CPrRbMVF8Pm309mJyp@nongnu.org
X-Gm-Message-State: AOJu0YxqVKt3YseUX7uuf9BpGaMPZHxtTv8dr3DnQlDSUUDZdUbabP/L
 T5824GKWvofDlWF5xLg6vJjqokBRBtiuys0i7pL4wzfuzYBlcX2OZFzjvt9uBkdVH8HDVzon4rt
 3LSc63yg=
X-Gm-Gg: AY/fxX5vMuANLQoaXseymBVONirvTPvCJd586oFE9xyAqr0S1UevGVe5RkzdPj0QJHO
 K2FsAyZAHaYTN9sulrkHl6o5xQQMogyt/eMt+/+UV3PlE4OAR+z93Cr/HLL6DK30JK8bJgQRcbE
 ZU1eLRrphoYg+bLXLkpKYVYogINnrLpa4pYeHNKn21QlRjKywf8GZOPFxzQU3q3PX/t8H7DwRfO
 EBaUIfrnvC1SE2EF5O1M4OL1MD+pgewOLJSvL1qtVnwt4r03ETtoDtdUiYZ9AFeb5R3iHydDsjf
 6kMf8zMuA7M95kBfkjbwYpkmLczPbXil9gj1B93BVFF5x1elPu4SnOaXHtKLXOguF0s3izDaMId
 4i6fX14VwyUn7cL8PzKvQSMqARQmKs/BtvXT8aD0pB+RF+ZqG8Nhnlj61nbIvaGwFQ/pjzli7s3
 k4LKArKq1SOWDrhbshIUz+f2GPEWyR9gL0X1wIb15rSwrtIPsfBuVC0g==
X-Google-Smtp-Source: AGHT+IHk3OIcBQfzsSL2cyiNnUMxP82JgsXh6X+e8rZaBkRMKZuRx0EpFuwLEFlxn1/wXyadoPwwNA==
X-Received: by 2002:a5d:5f94:0:b0:429:d725:4125 with SMTP id
 ffacd0b85a97d-42f89f70667mr13254284f8f.54.1765289858435; 
 Tue, 09 Dec 2025 06:17:38 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331aeasm31594533f8f.37.2025.12.09.06.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 06:17:37 -0800 (PST)
Message-ID: <42fea8b4-cbaa-4b5a-8638-3ed11882d535@linaro.org>
Date: Tue, 9 Dec 2025 15:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] Fix order of function arguments
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20251209125049.764095-1-sw@weilnetz.de>
 <96877ee7-21b4-4a33-bbe4-33cd1304c177@linaro.org>
 <aTgflpl0DUMQRTXT@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aTgflpl0DUMQRTXT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/12/25 14:09, Daniel P. Berrangé wrote:
> On Tue, Dec 09, 2025 at 02:03:27PM +0100, Philippe Mathieu-Daudé wrote:
>> On 9/12/25 13:50, Stefan Weil via wrote:
>>> This fixes a compiler error when higher warning levels are enabled:
>>>
>>> ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
>>> ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>>>    1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>>>         |                                                  ^~~~~~~~~~~~~~~
>>> ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
>>>
>>> Avoid also a related int/unsigned mismatch by fixing the type of
>>> two local variables.
>>>
>>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>>> ---
>>>    migration/postcopy-ram.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>> index 3f98dcb6fd..8bef0192aa 100644
>>> --- a/migration/postcopy-ram.c
>>> +++ b/migration/postcopy-ram.c
>>> @@ -1467,7 +1467,8 @@ retry:
>>>    static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>>>    {
>>>        PostcopyTmpPage *tmp_page;
>>> -    int err, i, channels;
>>> +    int err;
>>> +    unsigned i, channels;
>>>        void *temp_page;
>>>        if (migrate_postcopy_preempt()) {
>>> @@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>>>        }
>>>        channels = mis->postcopy_channels;
>>> -    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
>>> +    mis->postcopy_tmp_pages = g_malloc0_n(channels, sizeof(PostcopyTmpPage));
>>
>> I suppose we wanted to use:
>>
>>      g_new0(PostcopyTmpPage, channels)
>>
>> What is the benefit of g_malloc0_n() over g_new0()?
> 
> g_malloc0_n should be used only in scenarios where you do NOT have a type
> you can pass to g_new0. For example in the audio code
> 
>    cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
> 
> any calls to g_malloc0_n which use sizeof(some-type) in an arg are
> code style laws IMHO and should be changed to g_new0.
> 
> Or to put it another way.  g_new0 must always be used/preferred except
> in the handful of cases where it isn't possible.

Thanks (you confirmed my view).

Regards,

Phil.

