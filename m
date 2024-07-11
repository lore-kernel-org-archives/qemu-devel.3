Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33446C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwvh-0008P4-NI; Thu, 11 Jul 2024 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRwvf-0008OF-3m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:45:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRwvc-0005YH-5v
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:45:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb0d88fd25so8735285ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716354; x=1721321154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8TcJzyfcfWCfBK2S25EFYbu/vq/8j131Le+OQV29Mn4=;
 b=i9OEo5K5866yEGqu3h3Y82SrvRCgQsjpTysq5a7R5baQEK0R1W++7zASO/CKyT9T29
 XoWfJwvEFPLLTLm0lxm8f4sTSka89FNA6uHIzJwkIDKhgv0jMJ1M7yYVvHW2RkUWxNKn
 Ho9hV1nx0ZkxdOei3MMnP1ajORBEk5uclOEAsgufcCHZ1Re+/jlLCZIKfAhswMDp3u0i
 aGu4RLIlVjs5LrUyMlNgbgHWty5q/WiCwR8ek7Ko0DWdkpj45RbNuqrnTGHTm0n85WRy
 eueGGjHWukIto7nqmrrSFImHfLxu9WCO+UywARtwSvTqBNDF16JIgv9W1uLPzsU3kByq
 eqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716354; x=1721321154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8TcJzyfcfWCfBK2S25EFYbu/vq/8j131Le+OQV29Mn4=;
 b=Yx7QvIWFc8gmDKiECIrBe1WEo/s9jj6QOezp8VPIE3PyM9A4rWmnNWKhb0JhXGDRtR
 pSQ7ZEv9OnjaOwFd4t80ROUKZx7/SPTIU/zSULroEj7tDYA9mefN63n3sUF6IOda5YoH
 yZ+8WQB3edMMkMJJskECzqcug8o86FlcXzBpJ9U+673L80DhSQx6UYv+CkzhArm7KrI6
 V3eI1vzfVbUashikjkMEBzu2DFoKzDvd59S1ejRwvxrCHRH2ppAOk/lENeUhftrJm+Om
 Zh3TAvRSOwj0cm0+P15FemL6aT0P5RQCDQxXszbr9vbZej0jas/RaNhHAGUq90h0mkWp
 2+Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg2LZMqKPpL9FLSghhCC3dcpJ4dAm+J5lCFxVKjut0bG2tfolFZ+P25pp2PZvkCSVLFoqNPDOe/Vz8DtJuV2PNMS8tJFY=
X-Gm-Message-State: AOJu0Ywu+1jfmyFcM9Mbck1AZ5jdx7MdnlGuf+ygJXanZ42zRV365o/H
 WIdUs4fMo+I/3HfGCv8yVTnWMC/hex+sJHaN7xQrNVBDFoIcxRSlsIZwOA3rYxc=
X-Google-Smtp-Source: AGHT+IG2TMDN+jHoAyXEbrn9NZo+2EwVVvxPXAxL+2wa8eYwhuaJZJJfS3XuPon/+cGqnznxjl547Q==
X-Received: by 2002:a17:902:fd4d:b0:1fa:fe30:fc16 with SMTP id
 d9443c01a7336-1fbf0c80848mr1565495ad.25.1720716354424; 
 Thu, 11 Jul 2024 09:45:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab6d25sm52659275ad.158.2024.07.11.09.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 09:45:54 -0700 (PDT)
Message-ID: <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
Date: Thu, 11 Jul 2024 09:45:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240711115546.40859-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/11/24 04:55, Thomas Huth wrote:
> +    def fetch_asset(self, url, asset_hash):
> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
> +        if not os.path.exists(cache_dir):
> +            os.makedirs(cache_dir)
> +        fname = os.path.join(cache_dir,
> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
> +            return fname
> +        logging.debug("Downloading %s to %s...", url, fname)
> +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
> +        os.rename(fname + ".download", fname)
> +        return fname

Download failure via exception?
Check hash on downloaded asset?


r~

