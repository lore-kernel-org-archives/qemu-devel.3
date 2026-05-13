Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BA4CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAeh-00061B-6R; Wed, 13 May 2026 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAeY-0005sE-9a
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:33:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAeR-0005ji-15
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:33:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so30725345e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778682806; x=1779287606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+y/sucRIKAsVA6dYQn5pKsOZUNWYTP8d30FeSh5WYU=;
 b=zI66GwNTNV2GqUSJfQu9mpzWWHsmH1B/ZmZC9yK11nZVZknLutRKfcoxX7nUHGCNDX
 5XkUKFABUzLRP83YTuCXnRjBA0X9R2mj0Kf8gOdVZg6WMS/94Z5y+zD9JSRty8YHS/Ar
 XoxKiNfQSZkggL5pFHFw5k4h6jiJ5EgFmKMjf7IpRKN32k39+60bAvR8RDfL1iWLbmhs
 q+PQxkhtocjOcacuAEUBIjgHZCh3JtVpEL79fOvSC8Oryu6KTetSVvd6GWzerExSfLZ5
 I6sFMOhMuxIEbByBuzRwMzJ/y2XDW/Rz9J6PtfL4UgbTBc88Aafv7qggoIJbMxNqNKBr
 HI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682806; x=1779287606;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+y/sucRIKAsVA6dYQn5pKsOZUNWYTP8d30FeSh5WYU=;
 b=G3b3fez/r1YK015VrRmEk0YJ/MphYLdDXkoOrUvQUgRJR0KYtXIk0ep6VOZBRCcAH4
 8Hi4TeJXrd7hg/+F3b13mvT37bVB19t29/SVYoffk54evQAsKo8r73brhZQa/EwnOW8z
 WxKR+lHr80pug8cKj6i7LnGcGlCV+B3VrbFwRhBOkHI1H+xPNsH/HMsV0pMnBgOmbVXw
 LhVrBPBU0Xjsj0m9SM7lcyRFocgv4qq4eb8A9+D7jkANFuVBamUcakQeh+9C7vVoH0vz
 Cf+6r8TcERtL1B2192xEUT+7qUVz7aa/hdBkNKxg4wttslofhv0uVy/U0QT6xS7fe4Ed
 wOnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wRn3biQNeob24mDddQjB4qBd/2iMfQBEH0EJdNmcPeaQyMdJ9Y8WkvyhlWyED6904xGQDs5dezUgW@nongnu.org
X-Gm-Message-State: AOJu0YyeTvkvi+ydypyNHLsufvVMCmxhzVsVP14t+tT1fuCXgooYyoOo
 kNa+j2JLnSHS4l5+XOpsl6WFPptsngPm6StdVWJT0fP4cE/bWfUmYx9F9sa2vz4vyn8=
X-Gm-Gg: Acq92OFQz7ucb2+6uRwWEO75HjjsTTvvSHTbCgx8jbSOYywbqNE8td62Z1HnoJxepDg
 SnozRmsPqaBAvv4mi0syxLeZeXQ146veXFWszyW9aIPqY3MgkSWZjgutIkfKaDnzwHsLZm84n22
 JlLd6+nwE/ZD7OLrFWOo43sqYciQnXq/F1AA5kD0FlqIgymQsxCqNLCnpJjYenoPu6fJZUDJEin
 pyGjKqYfFg7qdTgFl8K3gODJlIMnjrsao8mRXFYdsWHeyyXU0xaH8FabIPtvilicBPkGUxFaKMN
 ULHXO/Hwtq2+qfKlEDuDbOBD5kDifSKKed4ISkkiDYiWYLe3VgASUhQtvJOy25IGbYP0ZaTtuLf
 b3c//Wn9FxlysZRGmGyd2P3JZBkasDZUD9jDiG7R2iD4RDQKgV9sLwr8penXDYjAczhUfOFzgGo
 GiWz+SmSQXjJWWZpFfRPaDs7PI/5N3bG30Zs/R/K84uEyB2ETIHiRcYEnR7jt31bEQzA==
X-Received: by 2002:a05:600c:35d6:b0:489:a4:e58a with SMTP id
 5b1f17b1804b1-48fce9f38d4mr52778025e9.19.1778682805850; 
 Wed, 13 May 2026 07:33:25 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f438890sm51991045e9.23.2026.05.13.07.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:33:25 -0700 (PDT)
Message-ID: <71b6149a-ece9-4711-be9f-013ad7ad93e8@linaro.org>
Date: Wed, 13 May 2026 16:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] qom: add trace events for object/property
 lifecycle
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
 <20260512122958.788097-2-berrange@redhat.com>
 <712c5b65-43f7-4db4-a7ec-6bac8983ca91@linaro.org>
In-Reply-To: <712c5b65-43f7-4db4-a7ec-6bac8983ca91@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/5/26 08:16, Philippe Mathieu-Daudé wrote:
> On 12/5/26 14:29, Daniel P. Berrangé wrote:
>> This adds tracing around object allocation & finalization, the addition &
>> deletion of properties, and the addition & deletion of children.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qom/object.c     | 34 +++++++++++++++++++++++++++-------
>>   qom/trace-events | 12 ++++++++++--
>>   2 files changed, 37 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


