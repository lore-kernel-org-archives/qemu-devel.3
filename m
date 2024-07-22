Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7DEC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVu8l-0000K7-PS; Mon, 22 Jul 2024 10:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu8j-0000J3-Pt
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:35:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu8i-0006dq-0R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:35:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so21919595e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658946; x=1722263746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKkbNP7k8veH9HBo1aRUDQDRNQnYv7nQb8tnSM7O4YY=;
 b=Cx7+iGjHqNV/Zjxl1iDf19JW/Vt0BrH8Qwre22MRDjmZqrQXTbfMImnjVm0LWWp8QV
 RmFataNs0Vit120u01mQZmKif/XCuy3Bsu9cll86JRfCypiPJtNHxS6qjM63jOCa1bcG
 K8iX1euJ91lRXMuI9J7eEQcmKKCP0k46Ixpx/cZtnGo86HYqIICt6BrUjIKHG9HVo7pf
 7LxZ6TS+MPoutpIY5gF3vQfAa+NIPPkd2icxcD61K1dUfLxOa7JgzTLA7TG2HtuuTSFU
 7EUcPHkYLVgq+Kg0wxX18REsEjlTjTOzkbkyNHIWhJUrIGCjfg9YSgcN+dCSs0fVoDLE
 YbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658946; x=1722263746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKkbNP7k8veH9HBo1aRUDQDRNQnYv7nQb8tnSM7O4YY=;
 b=Wo+k9KVbC5F4dm02N47Lj3WRRvxzoDHoa1K8N2v1iOljagegEYPB26b6Kjlxbr45c4
 FXsX9g0BDEpPsA1v9jHNxVrQzAEFFPQ669EUYOw17YbgFb0tustRixQkNcccWcK1bq/T
 JriK9bLQYbtG22TmL0kQrMhJ+dO/nfEog6uFcpHlyUh2mWAlfIiwaV9ZQ0Qr/BLpxcgF
 NxsoUER4rZHxIk6ziMAqcS/cO8sE44bRojcQc252SJio8xByFcNKu5KDM+2tNIFJOjew
 A6BP/L4QpM9uAoquDCi8UCN9Rb87sCgpHTKGvAeKqswxFzmiQEhMSS17vKRYkRoOAXab
 ZSug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCAPt7eJ9XtvnZf2dAeo9f0cE7NJp6fG4fA1/fwHPufAfI+BfFhJ8yNH1hzv8ULgVvvddhAEYvj04kGawq85U5dD8LJ1E=
X-Gm-Message-State: AOJu0YxRDEV450xkPYN+mRBJ+2n9bpTcgLVWDOCPNqoPN09/TX1p2OnL
 vR2nG5McU4ey2T7/uLf5/HWm6ARzstOL/p7pAkut35X2NYu1cDlI7X9k4zzX514=
X-Google-Smtp-Source: AGHT+IFjQyfdqB4LZaZ+N3giUeTnxHmG6OmgZSeKpgzAnnhth2CRDkscPej4ek7o9uR63w0O5bcFNw==
X-Received: by 2002:a05:600c:46ce:b0:426:686f:7ad with SMTP id
 5b1f17b1804b1-427da805e46mr54659635e9.10.1721658946393; 
 Mon, 22 Jul 2024 07:35:46 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm132263585e9.6.2024.07.22.07.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:35:45 -0700 (PDT)
Message-ID: <2870ed4c-4f7d-4f8b-b7a9-6bc5ceba60b3@linaro.org>
Date: Mon, 22 Jul 2024 16:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] crypto: propagate errors from TLS session I/O
 callbacks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722131611.2820041-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 22/7/24 15:16, Daniel P. Berrangé wrote:
> GNUTLS doesn't know how to perform I/O on anything other than plain
> FDs, so the TLS session provides it with some I/O callbacks. The
> GNUTLS API design requires these callbacks to return a unix errno
> value, which means we're currently loosing the useful QEMU "Error"
> object.
> 
> This changes the I/O callbacks in QEMU to stash the "Error" object
> in the QCryptoTLSSession class, and fetch it when seeing an I/O
> error returned from GNUTLS, thus preserving useful error messages.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlssession.c                 | 71 +++++++++++++++++++++++++----
>   include/crypto/tlssession.h         | 10 +++-
>   io/channel-tls.c                    | 18 ++++----
>   tests/unit/test-crypto-tlssession.c | 28 ++++++++++--
>   4 files changed, 103 insertions(+), 24 deletions(-)


> @@ -505,11 +551,20 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
>               ret == GNUTLS_E_AGAIN) {
>               ret = 1;
>           } else {
> -            error_setg(errp, "TLS handshake failed: %s",
> -                       gnutls_strerror(ret));
> +            if (session->rerr || session->werr) {
> +                error_setg(errp, "TLS handshake failed: %s: %s",
> +                           gnutls_strerror(ret),
> +                           error_get_pretty(session->rerr ? session->rerr : session->werr));

Could leverage ternary operator here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +            } else {
> +                error_setg(errp, "TLS handshake failed: %s",
> +                           gnutls_strerror(ret));
> +            }
>               ret = -1;
>           }
>       }
> +    error_free(session->rerr);
> +    error_free(session->werr);
> +    session->rerr = session->werr = NULL;
>   
>       return ret;
>   }


