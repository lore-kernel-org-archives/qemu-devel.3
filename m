Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD726CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 18:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8jes-0002pX-JE; Tue, 14 Oct 2025 14:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8jeq-0002p8-L8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8jeo-00008p-FY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 14:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760466116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+1dKwRBjDlYULLOrwDEsAyAmaDoYlzjkVheLqNBOEjg=;
 b=FIf1OP/yc2A/AiGXRoDuZeu4ZOKZyNq0pCC70ywztRLiWazsELGeSNHjYnsg4xDGvgcwqK
 k1H7snLgDqxfZx4KbJp2pHL14YQMWvavI/9mfhuGiS8Pj2330GTgAiqT2k1rh1ZvqpxrL6
 +bOJSctIaEUqLNiUD0L8+RpzKKjZlPE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-I1jM2-QvM6iZWLN7lkugTQ-1; Tue, 14 Oct 2025 14:21:52 -0400
X-MC-Unique: I1jM2-QvM6iZWLN7lkugTQ-1
X-Mimecast-MFC-AGG-ID: I1jM2-QvM6iZWLN7lkugTQ_1760466111
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3efa77de998so5536301f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 11:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760466111; x=1761070911;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1dKwRBjDlYULLOrwDEsAyAmaDoYlzjkVheLqNBOEjg=;
 b=d51VNAIikWoKec2JjtjD6RfJ8VgHqZJ9WW1JlFg6nxz2qImHqP8F7tovk7qmS/v8y1
 3jOJOsPLZUu5T02OKbt9Hx3lrmiN+/SVrEXiTHVjf0G27CQTECm3CrHHFTMkzPkhnRpL
 1IpqqOXo+SmBKW2JcBzCBXyvuE5gfKLzMdbXTvMrO2q4wYNgcMjRGDeeQmMl33S9cI5u
 Ta0J+VE0/ZJaUcYpvwtYDCdc9mfGxINkuPrLi0I9qYqlpDOyt70uLIGcRU4mNm7DbWgi
 a9g9PZ+rQNgG/B33UsdXAt1SvEIcjbE+tdWMM4sKHklKD6bsXd7ioGYlxF1yypUZvE0l
 pFFw==
X-Gm-Message-State: AOJu0YwjWGBQZcU3F0TkJXIEw2lk9YOZITXPbtQ75FIPCVinCv/oCJSD
 rc/PikUBlTXp+ChKpBrfPTdx2Xg5j6dXLUOTetCEuB8z8hGYQWtnFp7HPqEj6xenhPd3dHXQa9E
 T5o6kyo1HRWPStrWYk0qISXzOU3QjzWYtnj+N+5/ChCyFUcVbk/WBqX+/
X-Gm-Gg: ASbGncstX3qYE7Z3zUEjJi6ZsI5apnGiZegDkLnL/g+p0GF7eEuK1IgO+rYkoP9wO+s
 Q0Sjv2Vj/Boeb0lVahFDIcT3/1S6wxVlQaMrNRsnMi65WR5wEzcng0AHGWQki43kK+BcdFd8QeW
 zQRBMZ41rTX6hgA0wZTLgiBPfmxPGmlg0+8T04owNiO7iK5EzWhpSDcMY1uuusHDe9Fgi+pcp3n
 uEjFjq7/AUtItUofBCx36t/PDyM63suC1myEvPUt2ok8b0AYTl2S1FtHV0FqCjOWrX6l14Kg5QV
 sr9suHTETRH870bzMMUIOItgtXxwOiMyYWnHlDONJ/vkwaKkt/MRuKURY51YlYRtxPCsEWMq9lg
 8iAOicg==
X-Received: by 2002:adf:e18a:0:b0:426:d81f:a86 with SMTP id
 ffacd0b85a97d-426d81f0b0amr9669125f8f.58.1760466110995; 
 Tue, 14 Oct 2025 11:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbecB1C0bZflckKYFG4INZlZ916sUGPaRrx27aJMyNsQOc1QLfLVk0ygQGqNFlGxaTNdrjfA==
X-Received: by 2002:adf:e18a:0:b0:426:d81f:a86 with SMTP id
 ffacd0b85a97d-426d81f0b0amr9669113f8f.58.1760466110576; 
 Tue, 14 Oct 2025 11:21:50 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b39sm24583054f8f.15.2025.10.14.11.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 11:21:50 -0700 (PDT)
Message-ID: <a0d4ba3d-f799-4ec3-8d3b-efdc33527242@redhat.com>
Date: Tue, 14 Oct 2025 20:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
To: John Snow <jsnow@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, berrange@redhat.com,
 qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-3-gustavo.romero@linaro.org>
 <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/10/2025 19.39, John Snow wrote:
> On Wed, Oct 1, 2025 at 10:09 PM Gustavo Romero
> <gustavo.romero@linaro.org> wrote:
>>
>> The upcoming changes in the reverse_debugging functional test to remove
>> Avocado as a dependency will require pygdbmi for interacting with GDB,
>> so install it in meson's venv (located in the build dir's pyvenv/).
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   pythondeps.toml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index 16fb2a989c..98e99e7900 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>>
>>   [testdeps]
>>   qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
>> +pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
>> --
>> 2.34.1
>>
> 
> Do we need to vendor pygdbmi? Currently, mkvenv does not consult
> online sources and so if this package is missing, pulling in testdeps
> will fail.

This is handled by the "check-venv" target which is called now when you do a 
"make check-functional". See:

  https://gitlab.com/qemu-project/qemu/-/commit/75b1786996c422878d09bd12f166004a7d32e459

Works fine for me, did you hit any issues here?

  Thomas


