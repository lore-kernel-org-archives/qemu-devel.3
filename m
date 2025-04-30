Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E985C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8xG-0007z8-OB; Wed, 30 Apr 2025 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA8wj-0007dK-R7
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA8wh-00038f-1X
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746025315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6v2gJGDE5f4p+2XVl88kcJvcEVCZZjzXb+rTxbDh444=;
 b=IDU94ArcXWOphhukm798N2p2MNSKTm9AhKvqpm8PnhYs8CWyuTLcKQxeHgJRjB+Vj1sn7p
 vt3okIUU95FzATngHMmZ8GNP+SFdDtyx7m+enqJDdsMjtHig0d7PcawdJ7KcNu9Oe+OxbW
 ZQF3x4igcl4dDaCo3/cBbcPKT36ev7g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-utE_L26vNmCjmPyRqQtQgg-1; Wed, 30 Apr 2025 11:00:57 -0400
X-MC-Unique: utE_L26vNmCjmPyRqQtQgg-1
X-Mimecast-MFC-AGG-ID: utE_L26vNmCjmPyRqQtQgg_1746025256
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so45778105e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 08:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025256; x=1746630056;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6v2gJGDE5f4p+2XVl88kcJvcEVCZZjzXb+rTxbDh444=;
 b=T1E6phY8R4HQy7uqxTFpKBReRxij5TGHpQsdb29esohXyUOhdBtAOehQAc/RNXpVc8
 +HBZ1d5Q2IGN5zULFD6y7EMj2eu1tBZOIR2FFrzbvfWaFARWQ5aKTCSJWkhPB74Y+NlQ
 8sDbnFNdhZSSqH37OJqhtfr4rXPFoK6qU3Ds5s0rHW696Gna9eO/GGTUgBmk1yY+k0xj
 V1v0ipnNGo72XcmCCb8gg4jeQplljPmeZ+rlFO2to2G4X/Y7pZqqbGhEqWAfbmpWXVqb
 HMqLm9Age2iot9NV7RhXUr+B0GRC4+iKje0LjV7YXDB7xAB+dv+J0fe6gyVNSZb1Poqt
 Mvuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvYAr1tnT5hppgGy6qaW8LFB9NfT9OM/GMrA67TE+Qlm5CUTFRx4WR50qXmALoybvmleFD1EYDZyRK@nongnu.org
X-Gm-Message-State: AOJu0YygmA+Y+g0D2NkxcLeINitN2L8qeuWBznKqRkjTVdGECGDrZskL
 5997RAB2LkjdQQoc8qQic18/wIh6tqtO4ByksZEmHgzeqyrkXNQye9gDHqljwFthJBIhAUcyZ1a
 StSmylQuzihYV3D94Js5DWuK/6GaUP7f/nHC9XXrCgqta5DdDw6tB
X-Gm-Gg: ASbGnctLTlklxq5pnMuAHvPur5Ci/rqRK5xqeqWCCrJZQQTDtpUApCA9UbsRL6QCxKC
 zOOChiuN2rl1OWkS4BWuPBDwDxdqmYAsR4iHnjWYXQGs3+qnkxVLL/QSEJfy03pwH8AzOgsuCfx
 5vDgcQYFk+az0GnfPIqtohC7YRzE+4BUgzRXHztm3r99vuef7UTIZwlMVPNphqJoTSIy+GujjeX
 HIxv1KARZ9Bbkc8u49UjT5Xjf82we0bAUvWOy8drx7nFiNKqNxlmtycz03uEhCGoDaReLY89ynl
 yar/IJ+YW49Z20pzpe8dUWBM9SA5nQBM/AZgBFgh
X-Received: by 2002:a05:600c:4713:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-441b1f5aec7mr25414735e9.21.1746025255897; 
 Wed, 30 Apr 2025 08:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVjaIxrEHc/n47nmtyoFqsP+z4GNiw7Z/4YF5Uh/dtg0bm8GhvHxP84Nmx068biKdtXVglbQ==
X-Received: by 2002:a05:600c:4713:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-441b1f5aec7mr25414195e9.21.1746025255323; 
 Wed, 30 Apr 2025 08:00:55 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b97262sm28617275e9.4.2025.04.30.08.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 08:00:54 -0700 (PDT)
Message-ID: <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
Date: Wed, 30 Apr 2025 17:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/04/2025 16.34, Pierrick Bouvier wrote:
> Hi folks,
> 
> $ ninja -C build precache-functional
> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https:// 
> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/ 
> gzimg/armv7.img.gz: HTTP error 503
> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https:// 
> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/ 
> gzimg/armv7.img.gz: HTTP error 503
> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https:// 
> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/ 
> gzimg/armv7.img.gz: HTTP error 503
> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/ 
> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz: 
> Download retries exceeded: skipping asset precache
> $ echo $?
> 0
> 
> Since we silently skip the asset precaching, how can we identify that an 
> asset is not available anymore (temporarily or not)?
> Should we rely on test itself failing when trying to download again this asset?

The current logic fails hard for 404 errors, so if the asset is completely 
gone, we should notice it. For other error codes, we assume that it is only 
a temporary server problem that will hopefully be fixed on the server side 
sooner or later.

  Thomas


