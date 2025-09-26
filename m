Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D58CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 06:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v21x5-00037R-Vs; Fri, 26 Sep 2025 02:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v21x4-00037J-Ax
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v21x1-0000PY-A8
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 02:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758868138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lpQpAIJosCOed9258DodS2zvga0mExJzCeEg8bte1VI=;
 b=aOqQH0Ua5xxowD5Oulmnr3GTukP4d6QkpFwyUmwrBiCCP66uHfd7zgqxM7IhxmDz0vP/yr
 Ng5yHgIQyqmAPxk1FbM3gSRmWLkInd/iVbYInMcZdxsgqSpciabjOOBjInVsz1IrpePmXm
 3N/l/V0tg5rvjY16hTwkfMsDf4PFrXg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-C2hQ0JUEPH6d9YCiF3DJqA-1; Fri, 26 Sep 2025 02:28:56 -0400
X-MC-Unique: C2hQ0JUEPH6d9YCiF3DJqA-1
X-Mimecast-MFC-AGG-ID: C2hQ0JUEPH6d9YCiF3DJqA_1758868135
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-62f9731a4f9so1603526a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758868135; x=1759472935;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpQpAIJosCOed9258DodS2zvga0mExJzCeEg8bte1VI=;
 b=B46zccb582uKGUKA+K+8CvJeWzXwWyuym6KFa4eZjWvzpOOhc2xZin2lnFIrQZRs6M
 23BMZ5OdjbH6P1Aih+i+fa1vrVWqyWAMeaoO7kjYJPq5dpD5hnFeuKLVGrb3ixlZ/AKO
 WdM/VbRoE2j0c/9uOHdsIPfj71zbscxIj9qEnODYkofJs7vGdinIwUa0W7LpE3UwLEfn
 VwxQYYQrBzfjpr4gDb9GsyIvXRAr3rKX/ZYtxyM4aY9pC1dq0oITsxPL6gfco7Ocu5YF
 2Pet9Xot3pnS8/fY4PNLGceAHHwRaErAb5MTiKzCm0P2JU2/vSeCKRgS/2F/4gK1c/Jh
 jpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSyoLT37jVlve1sP+wsEzHV1T21J2unaIVed1cnBVe5KQ2aGqoQ5+HxtXYQme70v4GUfCqorbYIa2B@nongnu.org
X-Gm-Message-State: AOJu0YzSNZ/PGKRFn9zvyLwvbpPzdzGYvWMH4HNVuvdl7R1+W4ldC962
 G5WaYrPxgh6YLjV8L1h7oxfRv+MqBLRPCGPgX5vOxe+2IWagj8ixkdq6OlXK/T7v6rG9cP6HLAN
 mrCce4pRatZGrkS44FuaxRkX5nQ+ThdadGoMozcZjWxr2pNST3lFVJJ7h
X-Gm-Gg: ASbGncuely+zDToOj/2nY4kbNcxWExAHIowqYzfMPGx/2ro+iW9izqagrRLBNcnSEDZ
 8ZyZcSPHAFRRRjqMR6XTdwrsTIsjr48EQrnm6/RczivG+dSODVxeD0x4fsJh6JIGv40HrYJNMhH
 RYzfWuoyrbP3Z5/a/17Jgwekwy7TnmjmTtx614PUjeKloGpTj7LtcZQG4zUKak5fYpS0ypMt/mK
 cHpoqIEMPB2rbbyeBr5nlfTfVWRzGbrq4hi7UWwV2ljJa2xo5SeaDBX9QhKgjSyCVZKyTC6lK+U
 GtzL8I8CJZu18WixA/C0AZYpF1Sk6oqP8C2pSmJKM6RMIodPNSo0eCxpbZapnFQG9pQ9jJjT36S
 JbkfXNw==
X-Received: by 2002:aa7:d497:0:b0:62c:75bf:6501 with SMTP id
 4fb4d7f45d1cf-6349fa2fef3mr3741753a12.15.1758868135096; 
 Thu, 25 Sep 2025 23:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhgwiaoxBsPv62eQfLoFJ8YatDsnSBmqsOBVupRttOobdqbChYJ/uMhzoKUcmKPiT5XpkKAQ==
X-Received: by 2002:aa7:d497:0:b0:62c:75bf:6501 with SMTP id
 4fb4d7f45d1cf-6349fa2fef3mr3741725a12.15.1758868134269; 
 Thu, 25 Sep 2025 23:28:54 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3af4c7csm2352860a12.35.2025.09.25.23.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 23:28:53 -0700 (PDT)
Message-ID: <6610a755-c215-471f-a357-a7a0a8d365da@redhat.com>
Date: Fri, 26 Sep 2025 08:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] python: Install pygdbmi in meson's venv
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-3-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> The upcoming changes in the reverse_debugging functional test to remove
> Avocado as a dependency will require pygdbmi for interacting with GDB,
> so install it in meson's venv (located in the build dir's pyvenv/).
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   pythondeps.toml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 16fb2a989c..98e99e7900 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
>   [testdeps]
>   qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
> +pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }

Reviewed-by: Thomas Huth <thuth@redhat.com>


