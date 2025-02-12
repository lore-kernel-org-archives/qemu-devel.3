Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FEAC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 19:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiISn-0002Ui-6B; Wed, 12 Feb 2025 14:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiISj-0002U8-Aq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 14:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiISf-0007xB-4V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 14:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739388710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ASJugYjD36C2V4q+/a1OZhSiJFtauIbtJzQkO/gvT00=;
 b=XFFKfN57doE6d6vhzckS0W6hF52v26IYPW2p2hrUOs0VLI4x3fa9DhWkRe8ZUDTp+fbpwo
 iE0/Y2KmQWSLIttJBGRYrxqxEBFe1W/Eo8qMTLL5AESDuqfpd7zXpIvMw7wBdj2b7nnyJe
 2xvuVatH3K8j9xuaysDCY2AwR32/8DU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-7stSsz2CP6aKJZIk08WmfA-1; Wed, 12 Feb 2025 14:31:48 -0500
X-MC-Unique: 7stSsz2CP6aKJZIk08WmfA-1
X-Mimecast-MFC-AGG-ID: 7stSsz2CP6aKJZIk08WmfA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddf370932so37461f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 11:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739388707; x=1739993507;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASJugYjD36C2V4q+/a1OZhSiJFtauIbtJzQkO/gvT00=;
 b=SPmhnX3mpS5fk9O7/M53/rVI18ibgXgDqmY7aEG+2c3CMQmMS5M9atpC7whj1eCIVQ
 FVhTzmDpAqoVVVBnTIS3DRauk/laeAu1rXXNIhc4jFOFePeCMTH02iGUzx6/mcHaD8cq
 ylDGHupLChvuCrm3iXsbZlkNriVJLIwAnOaQnrkYrEJnM8qF8lyK/wO56qR9gCvgn+10
 Ym6Ksj54Dv+Swg2ZI1202VKxpqAdySvt/mTsCGEZ+2P83z2l2GjZq58W6fg26iXOnxXl
 E2bZIDbXIQVWd9tiWvXibcGVVOx+q502ydPqAOtU55LijQy7NTo29md8obnUVDTlMZI5
 Yw4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS9rY9G74vPUWpijLIcuIMVo6bQsEx7m9/iEH7u0UY1dQHOGi7/RtnfM0Fl8m3j4+adAtzjX+h/v23@nongnu.org
X-Gm-Message-State: AOJu0YyVSBbFkRzY47f7oyH7HrmqVdcoqHtERnA6XFAjKD2gcQK7X5OJ
 NisEa9CgzDenila8X3Kgv5sZqEHViGDDmE2wqXnjIGgwapnHVoqYrTYJlpVd6T9Z7HERKEg4ZKw
 BuI6WpEpryCnDibbpzlxfnGcSGjCf9tTYAlswd1KZu+niJUuw+h/B
X-Gm-Gg: ASbGncvCGG9JbH1mFFuSClr4apNYbk3KQZoBPBhb2IWZCm4wfxXoI46j8hxt9AHj6mm
 KCE614kmeRGqWrGGFvKduDpOCREPjSLEI0yxWWl8OwnZrIZRSnq/rKWd8SBRkREHjL+A3L2EEHs
 Z6eMEZDmsJqNMcAGgvQRd0iyHq5D2F/Bilf3n5pP8a5M4b2WkL5ioCsL9Q7GT/0xWufWQnSQfpT
 BdhjmfOxaglTGO19fpp0tghW8ONoqs3vYimOfZ+0j0S4zSPmBEI5PNt+VLKPwN+f/Fw1Evp6h8I
 AGrfdLqIm/gYoniP2NJaSHa0YxxguR+8Aw==
X-Received: by 2002:a5d:588a:0:b0:38f:2073:14a7 with SMTP id
 ffacd0b85a97d-38f24526be2mr694882f8f.47.1739388707365; 
 Wed, 12 Feb 2025 11:31:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLvLgnlQRLZeD5HthBTj9kaVj6nTQBMYURqem9QdlvU1szHVUj7qOmb4vCMwsFVsbNoBUAYw==
X-Received: by 2002:a5d:588a:0:b0:38f:2073:14a7 with SMTP id
 ffacd0b85a97d-38f24526be2mr694868f8f.47.1739388707043; 
 Wed, 12 Feb 2025 11:31:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd1093bb2sm13431598f8f.40.2025.02.12.11.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 11:31:46 -0800 (PST)
Message-ID: <773ea2d0-91c1-45d6-8c8c-2a73aba685d1@redhat.com>
Date: Wed, 12 Feb 2025 20:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: Eldon Stegall <egqac@eldondev.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
 <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
 <6e62808e-0fc2-4de0-a732-621e81f1937e@redhat.com>
 <82b70c1e-fc21-47b1-bfcc-167399af1882@redhat.com>
 <Z6wnTouJXLr-bbo5@localhost>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z6wnTouJXLr-bbo5@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/02/2025 05.45, Eldon Stegall wrote:
> On Wed, Feb 12, 2025 at 02:39:16AM +0100, Thomas Huth wrote:
>> On 12/02/2025 01.41, Thomas Huth wrote:
>>> On 11/02/2025 20.03, Philippe Mathieu-Daudé wrote:
>>>> On 11/2/25 19:53, Philippe Mathieu-Daudé wrote:
>>>>> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
[...]
>>>> Well, apparently related to network failure:
>>>>
>>>> INFO:qemu-test:Downloading http://www.qemu-advent-calendar.org/2023/
>>>> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/
>>>> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
>>>> ERROR:qemu-test:Unable to download http://www.qemu-advent-
>>>> calendar.org/2023/ download/day13.tar.gz: HTTP Error 403: Forbidden
[...]
>>>> However:
>>>>
>>>> $ curl --http1.0 -v https://www.qemu-advent-calendar.org/2023/download/
>>>> day13.tar.gz
>>>>   > GET /2023/download/day13.tar.gz HTTP/1.0
>>>> < HTTP/1.0 200 OK
>>>> < Content-Length: 4752277
>>>> < Content-Type: application/gzip
>>>>
>>>> So I'm confused...
>>>
>>> Looks like this also happens in test runs without your patches:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/jobs/9108828196#L844
>>>
>>> The test then silently gets skipped there (since we only fail hard for a 404
>>> error now).
>>>
>>> Maybe Eldon could comment why the downloads are blocked for python scripts
>>> but not for curl downloads?
>>>
>>> I the worst case, we have to mirror the asset to another place, I guess...
[...]
> Hello! I recently switched some of the underlying object storage for
> sites including the advent calendar, and this was a (very) unintended
> consequence. I have now switched to a good old apache upstream for
> these, so I would not expect this error to recur.

Thanks a lot for the quick fix!

> Also, looking to make
> another attempt at a calendar for 2025 (end of 2024 was a complicated
> time for me). Let me know if you'd like to produce/contribute!

Sure, count me in for an image or two!

  Thomas


