Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EEFCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KGn-0003ow-4R; Thu, 16 Oct 2025 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KGk-0003oe-VC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KGe-0001JQ-34
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760606844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K142S9tepB4ZTDxhXP61XZYKYruEe/XIHqtI6f6OEpc=;
 b=cR+J5U4vyrYh7n/+V1En/UpvdeGgieq03yKvRcFbBplouI352kz4x0008x60XW/yKVyxK2
 7Zqmyphgl16P0H/qNcEH39d/faFJ1EKlPEU4JFSorHmLscx6KRv++lIyo2uOZkRC3KvJyq
 ByizJ2RCLYir5LAc8/zFxiRnX4Caf8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7W0R9Y9ZOEmsclM2dR8QjA-1; Thu, 16 Oct 2025 05:27:22 -0400
X-MC-Unique: 7W0R9Y9ZOEmsclM2dR8QjA-1
X-Mimecast-MFC-AGG-ID: 7W0R9Y9ZOEmsclM2dR8QjA_1760606842
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so3966675e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760606841; x=1761211641;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K142S9tepB4ZTDxhXP61XZYKYruEe/XIHqtI6f6OEpc=;
 b=f8hCCPbzrS183YrhOIpoZYrDHD0TtwFNHBisdZ+xW+ijSN6hYGRMw7EksrDfcm9qVb
 phz/VYDQgYKZG964e/6lRU5l7F9lbFvTfmTOHgJ/h4C+SqxX2Dp2oJo0Pv2yaKajpswS
 aQDFUhoQQaPUkRL9+CPP4/TkGUPHHakiUA1wHRCqLkn5DXtcX9btZ9M57s1QVLgygjiG
 8GYUPYHUZbU4b3AtpyfZ+jj7luBjdnB6xMDkJMX5qT3TqB0VcxwF8vGuAW+v1+CeLlBO
 z8V+PdTb+bE8mk21qposuzXnw8clxcbeAUkr7HCgdDfyM+KpUDlifCJuYzOkvKFolR1w
 VoBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1hbKPuq849j5gRlA0EE7MTfUbsiXICqZ1BdRIC3tljdiWZnBiCIF5WmF56NX9KmltSBwclJjZspS/@nongnu.org
X-Gm-Message-State: AOJu0Yxt/k5Pzm8INvrcUq6pXILohnzrUb5xlTVlPnpzeP0oHt01B/9J
 w0sbY9vFyuNTUKJUbMoCa0rYenFKBkTuVlC8p/INmWKYuW9U9/iJlj+i3uzsb6fWCZ0c/6BTc2c
 0PFLCx0ijVkkqdNSjIiHmsxvqbhzBLAcx4hlJWqlTmYOb7zx9q/EE5aom
X-Gm-Gg: ASbGncvRk42yEva6EcKIlCNpPSHealRDak6Nws4lLPPFU2FIa7dmftv8XqIbr+LUGac
 HocCLTLN1LJjeJ1uF09c/STRVFJBdLnsnviZOeQYZCKwXrvcxiiTeemkyo5peCj0vnL73EAl5WQ
 ApRdBqSBOdaaLVZljBBTy/r1Ej0HkFgG+Z2uwMKy5U0/nwRsYJBCPxrmiXi/cxHsnmkrhDuFNEK
 6AC5CIlgYbAy6VWrmYGkTcchwb3W0bh7ZQmhxBFSwU2weDoR8zVxpsBf7unfkQTukCFb2Oho0nM
 TockUaggny/+Lej8cc4qNIslY4zwwsukRp7igzURFNe87z4vvPxxPKV+r72Keg9Npfo1r9ndVnQ
 RLL7oarHDLWAWyNE2gR/XfMr/tMOWCSHHzVz+eazE
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr263299875e9.19.1760606841535; 
 Thu, 16 Oct 2025 02:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqt3ExgyuacoYSlC9a/DMros5P4375J5n7o5gAlSsi0BVY6eKZAyEaysy0RksqGsEr/zEcew==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr263299685e9.19.1760606841040; 
 Thu, 16 Oct 2025 02:27:21 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm17732855e9.2.2025.10.16.02.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:27:20 -0700 (PDT)
Message-ID: <5352c759-d2d9-4922-9ba1-f8e98c86cd38@redhat.com>
Date: Thu, 16 Oct 2025 11:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: remove use of getLogger in reverse
 debuging
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20251014140047.385347-1-berrange@redhat.com>
 <20251014140047.385347-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251014140047.385347-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 14/10/2025 16.00, Daniel P. Berrangé wrote:
> This fixes the gap left by
> 
>    commit 8a44d8c2ac0921c8064fbfd00ef28e3a2588918e
>    Author: Daniel P. Berrangé <berrange@redhat.com>
>    Date:   Fri Sep 12 19:22:00 2025 +0100
> 
>      tests/functional: use self.log for all logging
> 
> ensuring that log message from the reverse debugging test actually
> make it into the logfile on disk.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/reverse_debugging.py | 49 ++++++++++++---------------
>   1 file changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>


