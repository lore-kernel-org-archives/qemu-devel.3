Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272B8C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1S2-000518-2X; Thu, 11 Jul 2024 17:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sS1S0-000501-8r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:35:40 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sS1Rx-0006j0-MB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:35:40 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-77d3f00778cso998381a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720733736; x=1721338536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUXqTH1nU0jpA5bal0cayFcqNPOwz52PYWTeLDhouIU=;
 b=WgZ/0eWL5Cl5vM07ZYPKQqlze804VoxCoW6CyVQ3Z/s6xWkT+w3w3M7SR5FC2pKAkX
 jnvG8ULLxnCTO/DSlNMPsHKIcuBfXB2mokWE1EQo0wQM40jbTmGHo+zlqAiW2lT4btUA
 /jqtbSRwqUG/k80vKbScW4N5FKuZU5xViQ9bDj8qRr7LYVtafnZPRYHTYOc1TWg3Mogs
 k5OfzcHj52ai6rVUb3lQTVVzxWWPiWTOc/GGG34M+oRtNkh5nVXDA1u+MXapgvXiGbCm
 glkC1FFEG1VFksUCEbfI7YB9gAQDoiLzMe7S++wqXCTwHw3KM4n+jorCqL5dkrbyHkCF
 /sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733736; x=1721338536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUXqTH1nU0jpA5bal0cayFcqNPOwz52PYWTeLDhouIU=;
 b=JorbtjizhOIeC28DV2hQSQnBTaT0FokMSE+ZQ6SY0nM+6paj8OLkAnYTWnQSZQQDdU
 UKAK6/sKUx/cyhG+3t+qurFtzA9lUAY9sKW1hhS33/DvfTETcJ928oCaMWIKakN8nSQ+
 GaS49/riAGdNSv3NylM0GLtcZy7Nxfafnm/THS8KtG9PLd9QC0og0Jrv+HsXwY8+Jlpd
 4UMzS9YNXRg3fJdc54kOdAxnRfVo3wHW85P5B/9iJLm1pGd4VNDyA8mBU3LcY7s4QdFx
 VyyXg5oqCdoUM6p8YWIKDuKHXZkFbhKoOPrTvLuUSaKyinvN/Pf1T77Hf5u7NY0r7Xtr
 +lmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSKkqVA7vOCN3fc6jWclJ1SWwkS6WxdtbVhaFSHmMy0RGCyWcQj2fp9HXqfjqtI8nIdBtsd52p4RcRsfGadTG3FPIZjY=
X-Gm-Message-State: AOJu0YzZA2lP+Oigyw6cnTzT1gBc7s9wSzWvTWqI/c+TdeIXp9Y3u0lM
 5K77SXNMov3fEUIIcoRfGEis4dPDdpOz+oR/KCBT64U4rifKm0/pWf5uOCIo/3U=
X-Google-Smtp-Source: AGHT+IE/GWKCEwXTFUsOJdj/ezQhC65Op0pfoGNzkwSuNt9NHNBqaOswqEKXI0AQ3fKAyAztxZ3ilQ==
X-Received: by 2002:a05:6a20:a10b:b0:1bf:df4:84db with SMTP id
 adf61e73a8af0-1c2984ca2edmr12205213637.42.1720733735647; 
 Thu, 11 Jul 2024 14:35:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d5f1a7d16sm4774021a12.13.2024.07.11.14.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 14:35:35 -0700 (PDT)
Message-ID: <9e76ea42-e765-4f51-b9cb-cfcfd1421a00@linaro.org>
Date: Thu, 11 Jul 2024 14:35:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
 <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
 <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
 <877cdrraw8.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877cdrraw8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 7/11/24 12:23, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 7/11/24 09:45, Richard Henderson wrote:
>>> On 7/11/24 04:55, Thomas Huth wrote:
>>>> +    def fetch_asset(self, url, asset_hash):
>>>> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
>>>> +        if not os.path.exists(cache_dir):
>>>> +            os.makedirs(cache_dir)
>>>> +        fname = os.path.join(cache_dir,
>>>> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
>>>> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
>>>> +            return fname
>>>> +        logging.debug("Downloading %s to %s...", url, fname)
>>>> +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
>>>> +        os.rename(fname + ".download", fname)
>>>> +        return fname
>>> Download failure via exception?
>>> Check hash on downloaded asset?
>>
>> I would prefer to see assets, particularly downloading, handled in a
>> separate pass from tests.
> 
> And I assume cachable?

The cache is already handled here.  But downloading after cache miss is non-optional, may 
not fail, and is accounted against the meson test timeout.


r~

