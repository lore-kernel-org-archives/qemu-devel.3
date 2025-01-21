Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90999C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDj3-0006pT-BW; Tue, 21 Jan 2025 07:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDiz-0006og-O1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDiv-0005Rc-GC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737463874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2pG2uhhO+2ys+rKzycNpOYI49mEaIG9ue6yxLEqsFQA=;
 b=EqnufrTD72r4/lAbrps4isJONRiahienXoWeNrBnYAhPmFRf8RTb0ooR7Zxna3f9EDqShV
 tNdEpQ8p5BlnoM+VWkPVqX/5wELl/Cf65qJKYgdenewoWhL7bJHqlnFDECcRfEGiei6cwO
 0C7tlxlSD4UJ1YFLQZbpspZLCHdOHKE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-ab1EEZZyMd-rHJzhD_1A7A-1; Tue, 21 Jan 2025 07:51:12 -0500
X-MC-Unique: ab1EEZZyMd-rHJzhD_1A7A-1
X-Mimecast-MFC-AGG-ID: ab1EEZZyMd-rHJzhD_1A7A
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e1b036e9so468762285a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737463872; x=1738068672;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pG2uhhO+2ys+rKzycNpOYI49mEaIG9ue6yxLEqsFQA=;
 b=a5NObXm965L13bOq1taxRLCYju7cTr+GKYgXgKpIer7QNsCFOaLhAFYxYVejnwAnHH
 +IAi3hZVQmn5hrChJTlgEja6P0H7TQJPOP2evtAvsIcj3gcdaNqf7Y3xsQ15VPZIEE4N
 Ca5Hl85mwZsxO7fhoW3Rn2zFENryRO1QBrhdwHlCR5BW9a1Dzbusywj7GP+iTY+7KIBp
 PTQad/K7/NWvKKsW64kHA5K5d3uE29TWRXEznDD8LppGIXQl6ENJzJhitP9yWy9B69JK
 ZHqyc4yx4sgsZjT24fwvT3afpGH8tOexv+K4Gu6x6KdChWmhKeExrgoBIKN5q+Vj237N
 M71w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLMZ7upUe9ay8pbV9PtjQZZJwpUdcZVqLriekpMwPo+j+ledJpSz5vMFfO+wDSPVz7IgzsCeKC61eI@nongnu.org
X-Gm-Message-State: AOJu0YyfLO0XIcj5PF454PWcsj19ri8cOUbhdyHm8MITMv4qNzO4i1+w
 1uIBO8hA55gJzuxsm1/qzVwVWi5keH1q4t0EjWEXghA0LFopz6h2VYU8Sw+2/NPMqfWu9OvH2H6
 3stUGvNE6GgPY984QVBj4c0Y+PWJ1Fp7GzUjf+95kmORaBp1cJJ+E
X-Gm-Gg: ASbGncsgYMlliVu846NaTxPm0JV3hHN19kathoAFWzv8TT0uK43UdgdvyppX6Ggi0Fv
 Jh2YPVmG7luceGgy54aK3igktqCwhxlNJGsT7CKeTVV9i2Z9w2Vio3xVZfejX2S4qjN5e6WaYp1
 iCFbUJNrz/8/Y9WgASVn53bLgE9mU88htpnS7FUC7Ba7VjqxFnCGRsDRtl2u+8PNTjbD0njSHzJ
 14F7nMH1OlqlkE+MWaHYSNHsrCm7AmtU0rywNSlrDYimJORabfCaijy347jGOfY+smUu4v+CvD1
 Pu0+0b0QCX4+3nUaIzUPo3B02A==
X-Received: by 2002:a05:620a:2413:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7be631e71admr2662502385a.2.1737463872062; 
 Tue, 21 Jan 2025 04:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsj08+l8T5jSw2YkMX4TSZxb+ONfMOijcMaDbFVIvFPnB2a89GjET0TtYeQmaEzA/lBwrBbg==
X-Received: by 2002:a05:620a:2413:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7be631e71admr2662499785a.2.1737463871761; 
 Tue, 21 Jan 2025 04:51:11 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd3868sm50784896d6.71.2025.01.21.04.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:51:11 -0800 (PST)
Message-ID: <28500692-705c-44dc-86a2-461a61e8526c@redhat.com>
Date: Tue, 21 Jan 2025 13:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] testing/next (qtest timer stuff)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/01/2025 22.02, Alex Bennée wrote:
> Hi,
> 
> Thomas found that a number of tests fail under CFI and other exotic
> setups. The eventual realisation was that --enable-slirp masks a lot
> of timer misuse because it ensures there is always a timer and
> therefor things tend to move on (until the system is shutting down).
> 
> It turns out that bc02be4508 wasn't the solution after all. The first
> few patches are clean-ups and various tightening of test expectations
> before we revert the patch.
> 
> Please review:
> 
>    Revert "util/timer: avoid deadlock when shutting down"
>    tests/qtest: tighten up the checks on clock_step
>    tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
>    tests/qtest: simplify qtest_process_inbuf
>    tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
>    tests/qtest: don't attempt to clock_step while waiting for virtio ISR
>    tests/docker: replicate the check-rust-tools-nightly CI job
> 
> Alex.
> 
> Alex Bennée (7):
>    tests/docker: replicate the check-rust-tools-nightly CI job
>    tests/qtest: don't attempt to clock_step while waiting for virtio ISR
>    tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
>    tests/qtest: simplify qtest_process_inbuf
>    tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
>    tests/qtest: tighten up the checks on clock_step
>    Revert "util/timer: avoid deadlock when shutting down"

Thanks, I've checked that this fixes the check-cfi-* CI jobs and it also 
seems to help with the travis jobs that use --disable-slirp:

  https://app.travis-ci.com/github/huth/qemu/builds/273921493

Tested-by: Thomas Huth <thuth@redhat.com>


