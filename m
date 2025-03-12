Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EE3C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJBD-0004lB-Lg; Wed, 12 Mar 2025 06:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJB7-0004jG-MX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:19:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJB4-0007vY-B2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:19:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so17689235e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741774742; x=1742379542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pAnkd325psDdD2kO4ozYFP8L3VUqJGQ4D86Zkhxtsgk=;
 b=KHuXP4Xq28JPzM7TnufhpByVCa+OBhqBVeLo4Qob29I7Od9EoJbhvjLhVF9qKKXQBa
 1FHwZc8+R9QwJb4sZZmWa087WfQi2NZSJv2VMbyC6pK4b3vfEfaNa9RmT5lyfFshcFpE
 YF/vsjxZ3kTC0dUmMBtjwR2EwESXQCgK5qXLuT5DZVkBgMl4FMgcml5LtQ/azw1UehSa
 Jj3hMiTz1CPw2CBzdTHg6YwZuUUTRPfqrhpGMXDxpAFyahZVSNt26Afy8Nh0oBhjBvF2
 8nB2YvLzZ+TzlZ9uijUSHBSg+KxAUQH9aNyJoc8Kv14aQx3x8F3vVsYfvPtMlo/FB4jJ
 jTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741774742; x=1742379542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pAnkd325psDdD2kO4ozYFP8L3VUqJGQ4D86Zkhxtsgk=;
 b=rj1Rqt//oHuZjBzGNT+gddLyzxJd+GL/RRy1jsqQOQpJ5PxLswPPpOH54PNRcrEjCF
 FtRFOQcYQWEhOJMkAhxS9HeZdzPbdClDNkVJkfhOm5VAtHsFGJBG3EcXgTlhKnpA97lR
 R9ZN5giQ7WDqia0cksxMUeE9UOelk98z21gLYyfodvRf8pEQ9wBKqoUqfEYmBG/rU5qO
 eDcG8APUXDLCzLsWDB8A7PLtg+gJy90s6oZac5MI3hQ9Vnu7V/PyV2XJe2JK5CwiHhPm
 4bX4CROkMdH9nokQ5WRhFb24Uyl9PTl5wQr9XQ7b7awOClmR7FwYb9F/E8pld8do7LWz
 y8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNArJyiCQ3ZWMy3/HAB0JE2ZW+QY7ZnA9ovwwEIZ/VLUzIsNcyGENqZcS6U2tJ7q40mmCC6Bb+zcxP@nongnu.org
X-Gm-Message-State: AOJu0YzcJrwMHEkuhDfX+PXgyNu0XV4N0q8ubuyZb3vcHrGFIrjHne0P
 5PACKXyQA9KxThw37Yc3GwqFzq4tlMkBkSWawiwZujD2KDXZx4xhWaPTseRUEkKRF/W9CZKDbKG
 j
X-Gm-Gg: ASbGncurcuk4UzoMRVcKuLKrhEI3VFoLY/OdNgvOdj6WkX/3nB27EHT0gztQXrHM/I5
 +CmF7kctOmsgITIPhtS3M4YAjjkUudIH7aQ+hXZbH8X08PxQiLm4bRUN7eA1QT9DEOM8Lk2it+i
 SooZZpOUc1nZ8YeHj+Og0LPBxI6kB0JST4o9xSZCTOQZVWcwYygTSUEZmBSzzJwBN/f+B51PIWR
 f8nND4our4/g8im6TO8ohm80VzUOtQEK0CvsfzIrh6R2qHy1DvGCPRYORadEq83SID5Ifx0FoWw
 ewlUWwfxDBW6bxzjWPywseq/tXRrrWjMS0MBRB4DqNd1i3DgEFBlsF/g6863wmFwDTRDJwjr071
 dPAOreQ==
X-Google-Smtp-Source: AGHT+IHer8vGHufTNnTZdpJYUeye17CAo4Y852/HPJZNG8WYgms42J/bwqhNP56WFLMZPHFUyEKlPw==
X-Received: by 2002:a05:600c:1990:b0:43d:ac5:11ed with SMTP id
 5b1f17b1804b1-43d0ac516camr9839935e9.24.1741774741805; 
 Wed, 12 Mar 2025 03:19:01 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba8a9sm20647421f8f.9.2025.03.12.03.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:19:01 -0700 (PDT)
Message-ID: <33ac4559-462a-4623-ae19-517ccf64381e@linaro.org>
Date: Wed, 12 Mar 2025 11:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Giving your own patches your Reviewed-by
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Bibo Mao <maobibo@loongson.cn>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <878qpamvk6.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878qpamvk6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/3/25 10:45, Markus Armbruster wrote:
> I stumbled over commits that carry the author's Reviewed-by.
> 
> There may be cases where the recorded author isn't the lone author, and
> the recorded author did some meaningful review of the patch's parts that
> are not theirs.  Mind that we do need all authors to provide their
> Signed-off-by.
> 
> When the only Signed-off-by is from the recorded author, and there's
> also their Reviewed-by, the Reviewed-by is almost certainly bogus.
> 
> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
> help reduce the accident rate :)
> 
> Here's my quick & sloppy search for potentially problematic uses of
> Reviewed-by:
> 
> $ git-log --since 'two years ago' | awk -F: '/^commit / { commit=$0 } /^Author: / { guy=$2 } /^    Reviewed-by: / { if ($2 == guy) { print commit; print guy } }'
> 

Since you are looking at this, it reminds me an orthogonal discussion
we refresh from time to time at the KVM forum conference: is it OK to
merge unreviewed patches?

