Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF2C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 04:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS7pn-0001ru-1P; Fri, 12 Jul 2024 00:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sS7pj-0001rJ-LS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 00:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sS7ph-0006aI-Cg
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 00:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720758271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eq1wrgLlKaPUZmxtFFnnqulewn/VzCPb6AFgJX2G/zs=;
 b=CthE1kyd3cFo1WgrLtkwc4NE0DtmWWAAahdgIwb7DOVYgd47g2FqCaQ9ScwCPNzkD1wWRZ
 A6NXyHlbYxPPMhilWFsquT1ET3ZReN22D/gDfe8BpCIalNJPTA2zpKb7ZE7F2WSR+e+uQD
 AIbO8vKAUipuB684kgbC7Gwv/HO/wiw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-pA-CMZn7OLeEsvpu0h92yw-1; Fri, 12 Jul 2024 00:24:27 -0400
X-MC-Unique: pA-CMZn7OLeEsvpu0h92yw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52ea249d1c9so1428860e87.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 21:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720758266; x=1721363066;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eq1wrgLlKaPUZmxtFFnnqulewn/VzCPb6AFgJX2G/zs=;
 b=ideS067s37nwuW+MSYKR4nLofOp/Kb509yicCN4iMvRqb8q+HOQXYzDS/Tn6FTCAV5
 33XPLgMX6H06TkbuNKl7PpU3mFtNHgHQYrGl6zaPqsvgKiGiM7pUI5225i4ZougJZ2no
 ACRDTJQjIWXsw7gkPVFhoTipgLlFF8zch7jBU0ENHyhVasUZS69LVTSN19ko/UliVgKp
 KHx7HAqy65kE71LoZoRNVFsRGU8fT8+eFWI4UZEcN4hE/NpGnqTvjwqSN+w8Tg0z60lu
 a65bUXcm4MAyOQ8Q+DM9TQasXCdq+7EoyoObldBo/WRirI3w+7x9a9NnA8s1SCpwWQJH
 1n/A==
X-Gm-Message-State: AOJu0YzZ94DflbhsEdyZ+42b8VzttW8qLhDeP+vu283/soX0WfAG1L2a
 J2mXZmA0wBe091OsXFWxz6n/kt8E6gYxRmLd96tbqkH5RlF4xTmoJkuDDTFTVolkRaWEOF37gyk
 xT3pT8OHgLpJkC6Wme2wS/ITaLaXOx7HhmFuQOPzgHvfJPxT1JzIr
X-Received: by 2002:ac2:544e:0:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52eb999a765mr5349649e87.27.1720758266268; 
 Thu, 11 Jul 2024 21:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkK8vcokVXfzS95eQ+qClanM/JCwesU66EldcRIHB22iLu+HqgwgJlrGUVZ6QTD94b5usjQ==
X-Received: by 2002:ac2:544e:0:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52eb999a765mr5349640e87.27.1720758265857; 
 Thu, 11 Jul 2024 21:24:25 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bd459df2sm4088007a12.61.2024.07.11.21.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 21:24:25 -0700 (PDT)
Message-ID: <7b4f8ddf-5618-496a-90c0-c4af0df965ea@redhat.com>
Date: Fri, 12 Jul 2024 06:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
 <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
 <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
 <877cdrraw8.fsf@draig.linaro.org>
 <9e76ea42-e765-4f51-b9cb-cfcfd1421a00@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9e76ea42-e765-4f51-b9cb-cfcfd1421a00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 11/07/2024 23.35, Richard Henderson wrote:
> On 7/11/24 12:23, Alex Bennée wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 7/11/24 09:45, Richard Henderson wrote:
>>>> On 7/11/24 04:55, Thomas Huth wrote:
>>>>> +    def fetch_asset(self, url, asset_hash):
>>>>> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
>>>>> +        if not os.path.exists(cache_dir):
>>>>> +            os.makedirs(cache_dir)
>>>>> +        fname = os.path.join(cache_dir,
>>>>> +                             
>>>>> hashlib.sha1(url.encode("utf-8")).hexdigest())
>>>>> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
>>>>> +            return fname
>>>>> +        logging.debug("Downloading %s to %s...", url, fname)
>>>>> +        subprocess.check_call(["wget", "-c", url, "-O", fname + 
>>>>> ".download"])
>>>>> +        os.rename(fname + ".download", fname)
>>>>> +        return fname
>>>> Download failure via exception?
>>>> Check hash on downloaded asset?
>>>
>>> I would prefer to see assets, particularly downloading, handled in a
>>> separate pass from tests.
>>
>> And I assume cachable?
> 
> The cache is already handled here.  But downloading after cache miss is 
> non-optional, may not fail, and is accounted against the meson test timeout.

Unless someone has a really good idea how to implement that download before 
running the tests, I think we can start by simply giving enough headroom in 
the initial timeout settings. We can then hopefully easily fine-tune later - 
since this time the framework is under our control, so we don't have to sync 
in a cumbersome way with the avocado test runner any more.

  Thomas



