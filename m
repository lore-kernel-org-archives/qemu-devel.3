Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FD6C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDB5-0005GQ-OC; Tue, 21 Jan 2025 07:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDB4-0005GI-Oh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDB0-0008K8-4o
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737461772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dLUmQaqiAio8pjquEn9nnNeE2P5SlutEAVPxP8mrd/E=;
 b=GN45lo93nASLlLyGAujR2ijQ4ZtnXh/vk+HUqeBdFGdtoYaemmGwlPm7v0Uj4xCBBX2ylR
 ChkEDyk59UpVL0rLQDR7wxQm9o8R9+4HpZO3N43YOUnvwdOYf5Q1aQtRjTSNMIjkH8Ylsj
 BdflgiAIL0OkFxnA6VlE2he8Pm54ykY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-KLU8R0aeOwa0IKwj0e8_AA-1; Tue, 21 Jan 2025 07:16:07 -0500
X-MC-Unique: KLU8R0aeOwa0IKwj0e8_AA-1
X-Mimecast-MFC-AGG-ID: KLU8R0aeOwa0IKwj0e8_AA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8844560e9so127561266d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737461767; x=1738066567;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dLUmQaqiAio8pjquEn9nnNeE2P5SlutEAVPxP8mrd/E=;
 b=jVzFV9IBKws0XuiEmd1h2bhLqQ3l0ViHIgblXY0chRGRSrjDb6R0UAI5xNQEDEDJco
 GiFMkHKwe3G1Vv3H9yL/O2V1ySKFQ4kZ5iOuy8g3x/jCyj4d6o5UxllLzdCLD5HFO9NA
 zJI0mC5GEE9LpZT1aljDNcGCosuiwHt5R2vJGmoonCliUaL4fff62Vco8M/FqwxJ1IyW
 1fxJAohzmvUv4tdNXEau3gIjqr+lHkEKAGDQEpL9NFXNelYVqw152w6jVqSNZBgPh3qH
 z5giYnR6JjD6meKNzdu3qSrFiWVAfLNIn8zy8/PQF+dko3ziYbJN5OmIWVALc+/nuf3/
 /+8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOCDqU9SxIeUWdTUYbq1gsw5OaC+aWkdrG6KBdM7xVwTpnTJI7lJf7hPOd7OkflL1JdD6a2st/6gz2@nongnu.org
X-Gm-Message-State: AOJu0Yzs3kVbpoci7c8PmZMlYTCieuqXk9LWvz4uVPnoJG2QotOmK8Aj
 erMZKkRLPjm8Q9Zzs+zM4DQ2d/thauiq47+WApalv9V3/BcFihcxrAgbtrDdjKYdNpmBBZtS+ZU
 tSYY/6a6KDOvnt9GQiqBUxH/Pxfv3q91c5bKP3EH3b7M1FtUd5C41
X-Gm-Gg: ASbGnct3XBIwEuyjrs0sbjwpcgdcScLrOZ6dBc6fpUW2kHafQsRlcfSaZGZVxys8LHh
 RfFvWXj8cCfsftxgjDqhZweJHu8j+MeGDN54kr8MPVW+/pIQSvsIA2e+Uzos4/o1Hug1ncgZWoI
 fQOgceyTQvF2HLDy8/9ACLlZNSR9cMi/W0FeHweAojRVsluGvqp5kQli5k4xV8hFUe86HO9pvv1
 lJHOZLDGFpIybYz4xRU8kGwbZQPXxVCEbFv8+dqLr4m6P8FD1ZoSZTxuG+TD9mUwlxVRdVwXUon
 zNyBOT5e323YjPZhgeMqAcaICQ==
X-Received: by 2002:ad4:4ee4:0:b0:6d8:adfe:4c73 with SMTP id
 6a1803df08f44-6e1b21a4f85mr249309866d6.27.1737461767225; 
 Tue, 21 Jan 2025 04:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBu38IJzp2As+3xO6IGpycjTv7IuBBghCtLUE78T3QqHhtSUKptswuPflc0UGWjl1bM8dzAA==
X-Received: by 2002:ad4:4ee4:0:b0:6d8:adfe:4c73 with SMTP id
 6a1803df08f44-6e1b21a4f85mr249309606d6.27.1737461766945; 
 Tue, 21 Jan 2025 04:16:06 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc22eadsm50392206d6.53.2025.01.21.04.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:16:06 -0800 (PST)
Message-ID: <1e2fc164-0721-435f-a29c-43d54539eb74@redhat.com>
Date: Tue, 21 Jan 2025 13:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
 <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 21/01/2025 13.07, Jiaxun Yang wrote:
> 
> 
> 在2025年1月21日一月 上午10:36，Thomas Huth写道：
>> We are not aware of anybody still using this machine, support for it
>> has been withdrawn from the Linux kernel (i.e. there also won't be
>> any future development anymore), and we are not aware of any binaries
>> online that could be used for regression testing to avoid that the
>> machine bitrots ... thus let's mark it as deprecated now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   If anybody is still using this machine, please speak up now!
> 
> 
> FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
> time by time to check TCG's compliance.

Ok, if you're still using it, we can certainly keep it around... but it 
would be really good to have an old Linux kernel or something similar 
available online somewhere that we could use for a CI test for this machine, 
so we can make sure that it does not bitrot... do you happen to know whether 
such a kernel is available somewhere?

Also, please consider volunteering for becoming the maintainer of the 
machine in the MAINTAINERS file ... currently it's marked as "Orphan" there 
which was also a strong indication that nobody really cares for this machine 
anymore.

  Thomas


