Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09182C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 06:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxL7H-0004YN-MP; Thu, 18 Apr 2024 02:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxL7G-0004XO-9P
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxL7C-0001gb-2C
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713421159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+qq/ir9YB40T0v8/pT/1m6Y63ECIfPcYJYr7zEV2ht0=;
 b=HGdU45wtORr9EGdOAG5LpM35igJOxUjoyRH4w42a21vR/WoDNAeM+RU66fwubBePAAXsxJ
 ajX3lsYyDkXF/hOomvTpf7/6EDusrfnG9Kg/cf3271mWaSm/2+JQsDi8ytavus9n7064pg
 JXZOj5K5CXe4Rg3lOX8cPwOv/b5weIc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-VdOEjmY_NoqWbWeDnkV7Yw-1; Thu, 18 Apr 2024 02:19:17 -0400
X-MC-Unique: VdOEjmY_NoqWbWeDnkV7Yw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-349e1effeb5so542987f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 23:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713421156; x=1714025956;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qq/ir9YB40T0v8/pT/1m6Y63ECIfPcYJYr7zEV2ht0=;
 b=QYNbeq/2JZHUwL7rr3fWJNlmubJtqAd0/fkp97NNsccuvum5XjgZMiyazzhXKH9cno
 r3+eL4b+YRLcd04DgV6eDLEi2QBiQsc047Udwv58b1wlF9HWat8lfkFHbpp6qlbzZcOm
 KSc3RdgQW00G/dp36HWY8F3TEmi99//fmmPjvYyBI1PmcY9FZ/xqzEqZchdR9N9OvKai
 HyB3f5oGiy1Nxvz4BWirGBVDFyZuFazOQv/ii5I0Gba2b5HFAdLIPFYc83LmXuqV2IeZ
 1iyPx95RuLX7PQezLIan1fQ3gz47uQD7bVMAB9ZHYf3My43ncjmV4FXmItCWIeO31IJF
 IB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxBacTWh2OkiC6wZwnzM7qsAT5nLO7juirpxqBv9uPVe88X7rRV77MJ80wJcZ94HMvlo8N3/kq89y+FahBnpnA5u5Jl7Y=
X-Gm-Message-State: AOJu0YxufoiKC/ox9k+AmpIYvgDaQkaYeA6c1X7Apwq5pzy0lNo/SmS+
 RFEfyyJpT9rvvLmDU/5DMPCp4e+MIZox0vfX1sWvXx6VK3xx5BEScDC/kT2Ecdpu0ZdWpiHv9VP
 srZz3cPVXdQiJGeSA/E/r+URUvcz8o5C9/29UaYWl5Lg1eq8NXGyybSkOztq1
X-Received: by 2002:a5d:4083:0:b0:349:bb17:6e60 with SMTP id
 o3-20020a5d4083000000b00349bb176e60mr783214wrp.2.1713421156381; 
 Wed, 17 Apr 2024 23:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXul00931VO1aUPDJWx0G0phcreMsTJGcbWtEbGlefrxaJ64sejmPyP3EIzWELr3Vj8/auA==
X-Received: by 2002:a5d:4083:0:b0:349:bb17:6e60 with SMTP id
 o3-20020a5d4083000000b00349bb176e60mr783202wrp.2.1713421156044; 
 Wed, 17 Apr 2024 23:19:16 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de.
 [109.43.177.117]) by smtp.gmail.com with ESMTPSA id
 z2-20020adff742000000b00343ca138924sm945232wrp.39.2024.04.17.23.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 23:19:15 -0700 (PDT)
Message-ID: <d2daac8b-0a89-423b-9bf3-6ec93af04c3c@redhat.com>
Date: Thu, 18 Apr 2024 08:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] tests: Update our CI to use CentOS Stream 9
 instead of 8
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-5-thuth@redhat.com> <Zh_1l1v13QG6fNF3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Zh_1l1v13QG6fNF3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/04/2024 18.15, Daniel P. Berrangé wrote:
> On Fri, Apr 12, 2024 at 03:24:06PM +0200, Thomas Huth wrote:
>> RHEL 9 (and thus also the derivatives) are available since two years
>> now, so according to QEMU's support policy, we can drop the active
>> support for the previous major version 8 now.
>> Thus upgrade our CentOS Stream container to major version 9 now.
> 
> The second reason for doing this is that Centos Stream 8
> will go EOL in about 1 month:
> 
> https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/
> 
>    "After May 31, 2024, CentOS Stream 8 will be archived
>     and no further updates will be provided."
> 
> I'm seeking confirmation, but I suspect after that date we
> will be unable to build centos8 containers, as the package
> repos will likely be archived.
> 
> RHEL-8 and other derivatives (Alma Linux, Rocky Linux,
> etc) remain actively supported by their respective vendors
> / communities. Only CentOS Stream EOLs.
> 
> 
> This has implications for our CI on stable branches. It is
> valid for our stable branches to continue targetting the
> RHEL-8 family of distros, as a 2 year cutoff in our support
> policy is evaluated at time of each given major release.
> 
> IOW, cherry-picking this change to switch to CentOS Stream
> 9 is possibly inappropriate for stable branches.
> 
> lcitool supports Alma Linux as target, so we could switch
> stable branches to Alma Linux 8 if desired to keep CI
> coverage of RHEL-8 family.
> 
> Thoughts ?

Either use AlmaLinux for the stable branches, or drop the EL 8 testing in 
the stable CI completely ... I assume that the probability will be rather 
low that we break something there by backporting some few patches (and if 
so, people can still complain by opening a bug ticket, then we can fix it in 
the following stable release).

  Thomas


