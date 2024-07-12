Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE1EC3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 04:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS7md-0005ya-QJ; Fri, 12 Jul 2024 00:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sS7mb-0005y4-Pt
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 00:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sS7ma-00052b-0Y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 00:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720758078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dmWYrXOzVfgf7Xg7eXpPMkHRMJcggBCibv8+wtcL4Gw=;
 b=WnV7pnziV24KStRaXkF22SDba3BI09sI2K55aOpHGsoaQTmnFQJUxopwr5N+H+A1VqRUfN
 cSQi5pqErCBe8aUnPLVVLES5n/8zvDvJFUz+swdsDkyFn/IhVaVG1+SuxErt410k9+fNIe
 O3v2Ekw1/cyu44t9KPbWg870VPbj2nQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-k_B_VQdPPgOVKY0DxOLsxA-1; Fri, 12 Jul 2024 00:21:12 -0400
X-MC-Unique: k_B_VQdPPgOVKY0DxOLsxA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a797c5b4f47so98159366b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 21:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720758071; x=1721362871;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmWYrXOzVfgf7Xg7eXpPMkHRMJcggBCibv8+wtcL4Gw=;
 b=YHBWgAQxV/QKZf1AN4YACgLKe1XELfAR/DiprGXYfTG3x4Tjou0zm3eLnZCB/o+kSi
 bzKnn/WyArFAKygyUdFMUyAYya2SqWjnEv3Jvisfep86mG4mv9nbtYs0bAqaeCsi7XHx
 w/69a2ALQYLvhhLMrgL6XbpCC+fu0vTZ3eozu42B72WTVbkgn0vSh0DF2ehyB8G9D7zI
 ggbwMGBMobfSsY9chis+IqUhU0Eq3DoPAiJ4nPLnVVxgi0NS55sziGTFyfLL6tBUv8vF
 /U3rCLXzccQ1sfoCVRFb7Wjm5QMCuq16U40MP16OBpo6mjhUC7EI3v/D/QNSMYkiZqVQ
 Ob9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeUfJ+OHxWNzSN0XVTGa4qtYCK07VHQrZAkg+44+jTiB4ItevnuW6XKT1MQzppmS556b5N4onjpOaE3WZKZrWTY4XMuS0=
X-Gm-Message-State: AOJu0YzrLJq7oFjWSluAEThLAsZmSoyV31s+CyHmshF3byMpfLUADw91
 cjVS14vDKNcULu0MSqSf3qGWvPCg/1u/MOt4mmApDVVGv8ZL1PCwZ6LcZJnZaBesoQ9s5MwSTRk
 yeklQ7xO7iPmOrN+pDlx6TKk5Nz9VSm4W7ucRX4+bsul4cXX3PeyS
X-Received: by 2002:a17:906:32cc:b0:a77:da14:8401 with SMTP id
 a640c23a62f3a-a780b688941mr727477366b.10.1720758070947; 
 Thu, 11 Jul 2024 21:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4gUqxH31pXDIOZIWxSvy2Hu5wTFdQj5k2i1bvH0nID15r2zUxdQi1YIeHzfHkFhchR8gjQ==
X-Received: by 2002:a17:906:32cc:b0:a77:da14:8401 with SMTP id
 a640c23a62f3a-a780b688941mr727476266b.10.1720758070550; 
 Thu, 11 Jul 2024 21:21:10 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a856214sm310610166b.178.2024.07.11.21.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 21:21:10 -0700 (PDT)
Message-ID: <d678a0ea-794e-44a4-b144-70cb9e7ce352@redhat.com>
Date: Fri, 12 Jul 2024 06:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
 <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
 <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
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

On 11/07/2024 20.49, Richard Henderson wrote:
> On 7/11/24 09:45, Richard Henderson wrote:
>> On 7/11/24 04:55, Thomas Huth wrote:
>>> +    def fetch_asset(self, url, asset_hash):
>>> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
>>> +        if not os.path.exists(cache_dir):
>>> +            os.makedirs(cache_dir)
>>> +        fname = os.path.join(cache_dir,
>>> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
>>> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
>>> +            return fname
>>> +        logging.debug("Downloading %s to %s...", url, fname)
>>> +        subprocess.check_call(["wget", "-c", url, "-O", fname + 
>>> ".download"])
>>> +        os.rename(fname + ".download", fname)
>>> +        return fname
>>
>> Download failure via exception?
>> Check hash on downloaded asset?
> 
> I would prefer to see assets, particularly downloading, handled in a 
> separate pass from tests.
> 
> (1) Asset download should not count against test timeout.
> (2) Running tests while disconnected should skip unavailable assets.

Sounds good, but honestly, that's above my primitive python-fu. I guess that 
would need some kind of introspection of the tests to retrieve the 
information what they want to download?

  Thomas



