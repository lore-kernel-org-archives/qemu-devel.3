Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBE1C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyrD-0003ii-7x; Thu, 11 Jul 2024 14:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRyrB-0003gK-RL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:49:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRyrA-0001qf-5k
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:49:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fb3cf78ff3so11438895ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720723766; x=1721328566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LTpGy+6jx3kNpf77E72EA+ObyfWGWXbb8nINmhfVmTE=;
 b=BC0320DqU1+EceZUWVNu2LSRcuvYRg0+HmERh+92PTpWq/inYXQwu2tMk2+UpNl9Tp
 LUZE7vtj4ahEN4CTKJf8ltxEih/okgFlRad24NyXqSJQdD1anuxxoMjKS6nZd8j92lPx
 vdjKzKBOxdoun0lqn6b2t2fJGH9jjOMBuZTSJMD/q8ACrDAYhFVTg74zTrCLr7xs8mnm
 0d3Uai2Q93OXrDGnmoH+Ul4nJT+61WzJVfQcA36l4c1YI9HYMWrCgnq2nQaT+m+a89UH
 5bHj3sANT6g4/kE696Qt7ODRCyRH1BHdoZwPO/1oHJ08PtdBwiTgXf5p+vKsMfoHdLKZ
 00Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720723766; x=1721328566;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTpGy+6jx3kNpf77E72EA+ObyfWGWXbb8nINmhfVmTE=;
 b=eC7LA2jCkJHiTSWCEvvd6LrjiwPq6J7177tOC9uXfAQB0/ugRcHe6KlIBL59WdTLAP
 xD6hEmeLjhV/yKA9TGE0vh6cr0MdCRkXbfzv4bANmURHHewBG3GbfCEgZrq8dAfFtvhR
 FnuefzuIu2gcn8BlA/5Y4ymG3qeiivShwylb8m7HVVGWSAB7pHOPJXDdNoxMHT3/4IBG
 FZfwiwArD6qdbUPokZesSdOWWFQV4/UQGV7WjZl9DTxPnK73c8MTVUGxrteu8U+dBUUj
 RncF9eP+KX9VQAiwWRLwTU52+lFLGFMqNMRabQjZKWxegO1cTZ/KcloTHSbC6XuMPZqs
 Iokw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLwnceuIeKhedwqpvWqDQTJGzu1FsSkVrxJhySkOoK/ozFx/4tBTLZ4+PIOotPN/a8McX5vOahIcpQYUQ/Sq6vEMwvsOc=
X-Gm-Message-State: AOJu0YwUOlsk5GNKmF7ZLwXo1OT4sySTONghslj9oQcYyuqLXJjbppMN
 SsskjmiBKLbo5lGwW0sG2C0MMX/dLBAwJnD3X9NvD5zVwfFz31ytKTfNdtYN3Ic=
X-Google-Smtp-Source: AGHT+IGLc7kISXVDi7fwgSn7w2Sr8vn1RgLNeroQ6AowynUtpnBQ+LDP0YKldvXcTSFFodB2QNQR8w==
X-Received: by 2002:a17:903:2292:b0:1fa:a89:fd1a with SMTP id
 d9443c01a7336-1fbb6ce5267mr86113835ad.10.1720723765930; 
 Thu, 11 Jul 2024 11:49:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a2c0cfsm54007915ad.107.2024.07.11.11.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 11:49:25 -0700 (PDT)
Message-ID: <b07b165d-57be-4144-a3d3-19c4ae94c261@linaro.org>
Date: Thu, 11 Jul 2024 11:49:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] tests_pytest: Implement fetch_asset() method for
 downloading assets
From: Richard Henderson <richard.henderson@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-6-thuth@redhat.com>
 <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
Content-Language: en-US
In-Reply-To: <081298cb-536c-4487-b90c-b184b0f93ce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/11/24 09:45, Richard Henderson wrote:
> On 7/11/24 04:55, Thomas Huth wrote:
>> +    def fetch_asset(self, url, asset_hash):
>> +        cache_dir = os.path.expanduser("~/.cache/qemu/download")
>> +        if not os.path.exists(cache_dir):
>> +            os.makedirs(cache_dir)
>> +        fname = os.path.join(cache_dir,
>> +                             hashlib.sha1(url.encode("utf-8")).hexdigest())
>> +        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
>> +            return fname
>> +        logging.debug("Downloading %s to %s...", url, fname)
>> +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"])
>> +        os.rename(fname + ".download", fname)
>> +        return fname
> 
> Download failure via exception?
> Check hash on downloaded asset?

I would prefer to see assets, particularly downloading, handled in a separate pass from tests.

(1) Asset download should not count against test timeout.
(2) Running tests while disconnected should skip unavailable assets.

Avocado kinda does this, but still generates errors instead of skips.


r~


