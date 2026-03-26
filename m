Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C2510AB80E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qdb-000244-LG; Thu, 26 Mar 2026 15:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5qdD-0001xN-60
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:44:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5qd9-0005Ck-9t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:44:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so5933075ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774554273; x=1775159073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eYZyilGEHCHERBM0A5/C0R1XyB4TmL4Ixxh5zAMpxp8=;
 b=INnVhH6glSTMs4OZWN1TJlhXNScCXoZmuYlW5UmbM+NTenmq9Px376NQ98hGKpfnJN
 wYY17DIW3ws+Ys1iNYxfVMLsUt646rFSbZ2yFnRlzImGOGkJhXpcmu5grPBAnfu5L7GN
 iSb4EyLnrdVjWhDZdznPSSpGhcWs0xnk0rDH7mAkDOXubjGorX8UCT9CMPbLoxcmN17I
 A4mBfc8f0Zdp3rv4pKqWdh/BJBGVlMeCeGPpc07RLInwv479dLtA+TruyI+AVFgbvqnD
 AM6QAyrswT3fep32UK8KAAJqcWL+2H6sg0UanzcjVtaSxepabHLNLK2Zy7MGt1HZC/g1
 2QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774554273; x=1775159073;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYZyilGEHCHERBM0A5/C0R1XyB4TmL4Ixxh5zAMpxp8=;
 b=GTGAgCejl8vlo5km311yxh0CdjDNczPfRVEZfiGFGjSMecd6K5AxrndOGgVaZMx7Sy
 cnHNz+976eVSurpjNM0YDQwzehagyIAbvGUZB1AN9nRqYsvByrqlLGehMosMPk62108x
 Rn637zChYD98K+p29z2+aBe4bM8EbnaJhHdNhgZghEs2D+yskx7ZCLq58n+NJO3SXbRb
 4s+TxwLhv+/ywzDLKhs6VWqZd2+1EBrnMBNBTpIZGcDCQt+FIXdgcBCdukHKLX1Fd4+i
 RGG44rDkST3zQk0GmVHsYiBXhQnCCozvc2NFZ6pV8Y5SzdX7r4P6HF8QaJDPhKKP9yU0
 p9TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi6paeaFMRgnFVbZWdp9JiZvvMeUPoYSPLnUoqAICuG1ak45dtfaWnSBMeS4kA1DCD7hniVBzBbF5Q@nongnu.org
X-Gm-Message-State: AOJu0YwRSjAdPaXuHyGxzrFBW5A785+1FNQINuPkKuYniwAWWkhWv36D
 y1dq0a/J1N1Ls4RDTME1aykJ5FbqgIh1IWPsEPnE2ibqtQJB3kNjRAnPQgqQL3NKxI8=
X-Gm-Gg: ATEYQzzHexH5xNMdNUCAhXCQFy030MYwvZIe6owl9egwWMUDzcvMAYPj+mFW/5Af0O6
 1n/IzZfuQnn3AT80ba4P5AiKC7Vmog0qnsqts0VGuyh9z28nKupLlkX0fJPPk1v5Lc0v1AoO8ij
 KDLoVupAtS4ALYWQE+ykXe+XdeuOX2dl26kxxSQUX6HafgangO40luR9yl+/dClFME55v95qobc
 fOvAwLgppAioz1aKkekv21eD5tgb7hVQ0VPgN81Jc5fP8WA2KpZbRMJSxkT19MF3OysaIqSbUOB
 cVb9TsnOHmj9JnKnfuKyLdzV+2uhvMsoK+3fsPd+rsd4h+IWSps1uF06E2BIqyw41Oi9UBa8haC
 TZfvGlUFzzlWszTBLdGyZ+0Ck2fVCgyoCtN9lgOC8wZ82DKgVbjtDm1igs5rEgXGsbJBfSJnph7
 UyET1lYqjsTLRC3MzKPS2G3uEpeHcFWJUIPTkW3lk5dVQLz21VphLQIjxKsZbfUbJ+SM2o
X-Received: by 2002:a17:902:ef11:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b0b0af56ccmr90111105ad.30.1774554273498; 
 Thu, 26 Mar 2026 12:44:33 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8837e6sm38212515ad.52.2026.03.26.12.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 12:44:33 -0700 (PDT)
Message-ID: <6eb04a74-55b7-4663-bc7a-2d72c7fd37db@linaro.org>
Date: Thu, 26 Mar 2026 12:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] docs: add WHPX section with initial info
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260326193358.97858-1-mohamed@unpredictable.fr>
 <20260326193358.97858-2-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260326193358.97858-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/26/26 12:33 PM, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   MAINTAINERS           |   1 +
>   docs/system/index.rst |   1 +
>   docs/system/whpx.rst  | 144 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 146 insertions(+)
>   create mode 100644 docs/system/whpx.rst
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

