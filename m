Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1389D44C4C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggQ5-0001Fc-5D; Fri, 16 Jan 2026 04:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vggQ3-0001DU-8p
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vggQ1-0007vw-QM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768556820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EwLgkfq8KrfgI2K/fa3/Wv9KwOQ93DY2mkKbUTn7OoU=;
 b=JnDAUL185rO4llO43HuMXsH0a8C9/t4wysv/EZmFRyFCL6QMS9xbPs8o1qhQJpdfuvkleA
 3RyxwDpnYE8kHUV68GFUdmBnRpiPTTi/V0k8UETtqOtYo65weLxl1N2XNIu9Y1CvafVIZc
 mkUDZWXDWkCaq5styuMnlNIYk9tm8Xw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-umG--4w6P0CwRPnckVnhOA-1; Fri, 16 Jan 2026 04:46:59 -0500
X-MC-Unique: umG--4w6P0CwRPnckVnhOA-1
X-Mimecast-MFC-AGG-ID: umG--4w6P0CwRPnckVnhOA_1768556818
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b83c3dd2092so284329266b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768556818; x=1769161618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EwLgkfq8KrfgI2K/fa3/Wv9KwOQ93DY2mkKbUTn7OoU=;
 b=hKVXHGwH6xmmwPx8iYOuxicnY/6od5EG9EKP6QT9vZ4okOGKBWK8jk7qgWM6T0Vh4f
 AF5ZZVf8H41jhokStRkmA622Z05PlGE6/9CRBypcOtY1VTDwldtv8X1Gk1ZPXGc1N+xk
 OEgoIb2MAKFNtZQP6tenw3T7H2pnecAYVe6O5ZkNSgIxyYHEPzVd5ylGxzBfqiCwQHUo
 Aw3ihAfWDXw8Lk/MFE6orpwmDbFzP+10ntQEtzk7nL8+Ub/+ulfqAjinAkslQx1hDCTr
 9OrUzbyajlnDIex+/1GhhCrbctpKubIg76GR0SOWjOT4FvjyAf2WZemyvt+2t/aHC3CO
 P2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768556818; x=1769161618;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwLgkfq8KrfgI2K/fa3/Wv9KwOQ93DY2mkKbUTn7OoU=;
 b=hJDfx0T2gqkrCRQPs2iMQ0y7h6SVm+DE3OgNymNCpr1EXn/PF9sSrymGnsicnTUnZw
 ZJ6kar6c9Lg7zjKJfJEr4HwOrr9x5/6VwdGQSQ79maxFF8VIsjd2TRiYnZQ53b3RRqI2
 GkAcubLSoznBNxSbe7jlC5cgehvowAcWnmZcERW7fgnHbVZINRCm86tALLkm6LUJpge7
 gALjWwNk6hrIEUovTKn3Mw2JXxRSNoWkiRKZ6daqq2AMg2I4JX88w90GfMmppMKkvGe7
 uxtiE+KFjw9lTpA7+jZG5RQn5UMzYbB9gcpv4Tk66k/kN5SY2b7xhRwVo1xl9/h98XLs
 SVpA==
X-Gm-Message-State: AOJu0YydkSzoeqgDoyAcCJ0N/jjpIJUm8L3of4q7HHWPujiChrfDv670
 YqRDSjr8lY1ENrcmtgUgD5vitH035fIQlqrbklgmpiTj3HqC7j2uOJDIW4u8ax0Q+lojYn184Se
 6pNEcdnXy+kFQOfZn500xAfe9ujKAapuHKUfEM3fBJB5CMazD9Gzt72B3
X-Gm-Gg: AY/fxX6QjMCqQ0lRQyECSwyaUXdtndE9Magh7XiCI7LumjUyWA5uo1WtW/915QR/oue
 WXdmsjJgH1JXGP3yhoN7t4MIiINL9wCZz7QSdLNHG8evVDQ5qoq8qnp7OWiLXO/ca9b/Vf/p806
 gN595HHhbjdd1XboYJ6ganoQnHSAeI/E/tw2VWKXl+GdwRmQG28jfh/ZNeDaJKpKTgQ8J3TBhnL
 sj8wwEYOheZtx1p4nAfqq2lZlH8cBRGIif8MQP6A0T4SLxOOs7gHkhfNuvxO6PCvtD1l+oI1be9
 93hrFsYsWwShCVpkKMW9J4geYCC1D5grTJ0X1/ak2zTS7MapRPpTwvNwg4ZvI/JMh9VxniXDxlV
 6hRvxAj4=
X-Received: by 2002:a17:906:9fc8:b0:b87:24e1:1a4c with SMTP id
 a640c23a62f3a-b8793243ad5mr223559266b.35.1768556818043; 
 Fri, 16 Jan 2026 01:46:58 -0800 (PST)
X-Received: by 2002:a17:906:9fc8:b0:b87:24e1:1a4c with SMTP id
 a640c23a62f3a-b8793243ad5mr223558166b.35.1768556817673; 
 Fri, 16 Jan 2026 01:46:57 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9763sm171968666b.35.2026.01.16.01.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 01:46:57 -0800 (PST)
Message-ID: <b0d8a389-3292-400e-b74f-7514ceb14c6b@redhat.com>
Date: Fri, 16 Jan 2026 10:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Limit the memlock test to Linux
 hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20260114095904.35442-1-thuth@redhat.com>
 <aWdpi4ibUm9qNrwa@redhat.com>
 <fdc2093e-8acb-44fb-b280-edf40f5f8883@redhat.com>
 <aWoITn43oMG_WSM9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aWoITn43oMG_WSM9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/01/2026 10.43, Daniel P. Berrangé wrote:
> On Fri, Jan 16, 2026 at 09:09:17AM +0100, Thomas Huth wrote:
>> On 14/01/2026 11.01, Daniel P. Berrangé wrote:
>>> On Wed, Jan 14, 2026 at 10:59:04AM +0100, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> The memlock test analyzes /proc/*/status files and expects the layout
>>>> from Linux in there. However, these files also exist on NetBSD hosts
>>>> with a completely different layout, causing this test to fail. Thus
>>>> limit the test to Linux hosts now.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tests/functional/x86_64/meson.build | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
>>>> index f78eec5e6cf..97286d78b8f 100644
>>>> --- a/tests/functional/x86_64/meson.build
>>>> +++ b/tests/functional/x86_64/meson.build
>>>> @@ -9,12 +9,13 @@ test_x86_64_timeouts = {
>>>>      'virtio_balloon': 120,
>>>>    }
>>>> -tests_x86_64_system_quick = [
>>>> +tests_x86_64_system_quick = \
>>>> +  (host_os == 'linux' ? ['memlock'] : []) + \
>>>
>>> IMHO this should be done with a decorator in the test program, so
>>> we keep all conditions in the source, not meson.
>>
>> If we already know here that the test will only SKIP during runtime, I think
>> there is no need to add it to the test plan. Otherwise this will just always
>> waste some cycles when running the tests.
> 
> One could say the same about many of the things we check in the @skip
> decorators. The time saved by doing it in meson is negligible, and
> also ensures it is skipped if anyone runs the test program directly
> outside meson.

Ok, fair point, since we support running the tests without the meson test 
runner, it makes sense to check via decorator, indeed. I'll send a v2.

  Thomas


