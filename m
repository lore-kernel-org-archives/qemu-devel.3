Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D560A2603
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WNIpWVgZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lCYKwFDp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLIuz-0008PJ-RT; Mon, 26 Oct 2026 07:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLIup-0008NH-7W
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLIun-0001Sa-QB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793014257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OoKI9ohna/5hCK1qrPc7su5IYtNYCgPEp4ip9YBN1jE=;
 b=WNIpWVgZAKgZcUJDrMM8vQh/tFKOXL/7/bwrebVB7EgRe4W4716/RBCKaxucujB7aZbZvR
 jncN6/B6MCAigd1ci7R5L1gKZIwD98Nd2pAPwZswjOgDPTmKyjnPD+2vS5KuBZFG6bwAEY
 3B4JQqrqX/JZnesuRWBUbWZmWvvuFMg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-tXRRIlWpPPmXPGdVUo25XA-1; Mon, 26 Oct 2026 07:30:55 -0400
X-MC-Unique: tXRRIlWpPPmXPGdVUo25XA-1
X-Mimecast-MFC-AGG-ID: tXRRIlWpPPmXPGdVUo25XA_1793014254
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a2b0669946so13687755e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793014254; x=1793619054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OoKI9ohna/5hCK1qrPc7su5IYtNYCgPEp4ip9YBN1jE=;
 b=lCYKwFDpnAyovjPAWrnrQO2glK0H7kFAJE4jTMkwh4wKA7NbedevubosU7crIsm5Re
 7mHcDMqHUu8tOC8AS5mAGK38Oi81NqI3GpJnDO/97AeyDH5Lr0x6/W7NAz5L9wFlmZSK
 dUJuSzNYTAGtIgMvkxeXzLDD8IwpWwVYWoVXoMQWd4xoCWLIuxHVpB8UyZT92oDHU0/k
 d0wN6w/GzUcfv9mFGW3QZJcemxrLlAnClyMqJ/KBIrvnNtIFj4M23vV0qVW2+3ue6TPr
 hnhX/NR6VvsevMv8DtQ4k3Pw60RwXqS+siLKoyuOHosulqsKNH9j+iEZ+jBvnNR0cZ2H
 5chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793014254; x=1793619054;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OoKI9ohna/5hCK1qrPc7su5IYtNYCgPEp4ip9YBN1jE=;
 b=xblXb1X71dQ6Bidk8+XFPKuzLqvISyDqzMlDELi9sxCHvJ7cbMY1frvmvvFPLgHsyg
 4+x44mwaDcR4oAPCr5XfyUmrGj73R6+iqMv6ugCv+WNxtG3x69ryvZToGVEaXCnSIM7G
 LWMGG9up2oEpdvZgoMxZQUqrVJM57BPehnp+Kkm8XDA3S2qK/g6xzo+Kx66UPWvPeUEC
 RqBwZ39yCRVR0KGh7z3WxUq28+xUN9Ccry89PvlRF2oxTdQsLu5dqvRyz/pm3gOSrfMd
 HN6VhiDO3JHnIQmK5ujNnAF1RgOqez0dbixrJdIp3JJSuZ3zpkZB94pgZVmC7MfBYmJo
 0PUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByu/rg5gML3QwgsTrvvECkFi56rLhO5rh/9CbHEnFMCdrqZMcZxhCDhtcSZerYZJ4qAQQFNnWlyx4TS@nongnu.org
X-Gm-Message-State: AFq9FYL+Kx59aN+6D7kp5F9ihuzpKLHMNb4NPhrQkjNXIpdTgjKFZKAt
 qmNQpKKyuIr9v+zz98Pu3zT16PuESmupMwdJj2Z6RNLd5KXHr2Wdt1M8AePbx22bjPwpJU+gTtc
 hGtq7h7MTWXPhY0lrw98k1mKvoJYtWSrcYUaeXEUaM7HcHnDNmkYYkPUf
X-Gm-Gg: AYBFou1NSy1QEB5L2V/mYen5w00+TgD5Iaf3POt3VX7bvPhp8zp62atZAnA+uaCFhR3
 MEPACoAUXuZf3rGZWo0pprFzfejcbQS6RQzdbNrZV1QMlPKBnWGmozt6dSU9a4NgcPq1lxHkyLr
 8V7eu1hd2sCe4cFWgRGL1z2LlsBXzcVCqdrQVJdenVGQHWLoM1oM7/Kzgcw0hlaFPJLSD9QgsAH
 g7zHxfH1m3nQEKJc0/bVulH2zaTec6kFnd17BoXtAzbHAU001sWY+0M5k57Ct/qpQihkp0ehqY3
 aUwkFX0/qijTcwja2L2JMXIuzwH6V113Pttn7APFxZSNXtnQGpgzolnai4NmCiLWZhbcnX4=
X-Received: by 2002:a05:600c:3f07:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a35ac91137mr105673275e9.11.1793014254389; 
 Mon, 26 Oct 2026 04:30:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3f07:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a35ac91137mr105672765e9.11.1793014253923; 
 Mon, 26 Oct 2026 04:30:53 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.93]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2ed5a2sm200306095e9.15.2026.10.26.04.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 04:30:52 -0700 (PDT)
Message-ID: <ffdb16f1-7a5a-487e-a9d6-74767ee399b8@redhat.com>
Date: Mon, 26 Oct 2026 12:30:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20261026092313.480889-1-thuth@redhat.com>
 <87fqxs67ut.fsf@draig.linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87fqxs67ut.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/2026 12.04, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> I'm occasionally seeing timeouts of the device-introspect-test for
>> the aarch64 target when running "make check SPEED=thorough" - looks
>> like the 720 seconds aren't enough anymore nowadays. Add 2 more
>> minutes to give some more headroom.
> 
> What is taking so long, I can run all the introspect builds in under 10
> seconds:
> 
>    ➜  time ./run meson test --suite qtest "*device-introspect*"

You've got to run the tests in slow/thorough mode:

G_TEST_SLOW=1 time ./run meson test --suite qtest "*device-introspect*"

otherwise a lot of the tests will be skipped and the tests will finish fast.

  Thomas


