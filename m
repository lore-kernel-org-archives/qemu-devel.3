Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD05E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5Sq-0008K3-Tj; Tue, 07 Jan 2025 04:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV5Sl-0008JS-PI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV5Sj-0002Dk-Lq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736240480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TjNEJ8u8sJjr7qqTrGTkbbbZTbBXhYVu3/0aQw6MMkk=;
 b=ZCWji+zj8zQ6Xcy36UWY1NhllTFVxxrM+tKUbYT2q3n6KG5aL3JO/kOh43Nfr/Q1R21ZCA
 sVdBv6IuioMa9/64mnV5J9QUzoYMVYFzs3hwzkRvprty0yUcNUJQaZ1rXYBR0d6rLyFG4W
 GkuaBT1WnJzpWTwdQv49DhRNrNGY8FI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jm2TBXKbPGmYK5mIV3eExw-1; Tue, 07 Jan 2025 04:01:18 -0500
X-MC-Unique: jm2TBXKbPGmYK5mIV3eExw-1
X-Mimecast-MFC-AGG-ID: jm2TBXKbPGmYK5mIV3eExw
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d92efa9ff4so248082336d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736240478; x=1736845278;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjNEJ8u8sJjr7qqTrGTkbbbZTbBXhYVu3/0aQw6MMkk=;
 b=kEEyCxAlaHX7kO2it/Mr0x6+HsgPnT0EOCl5IlszT3kF468bKjPocSiKhHEnUGouBZ
 L+wiU7GI+N/j5puOC+MpPg5de5HxbUhDhhE0mIp69uBoM3jz7akOwHAJCzStRE8rkp3O
 4tqqLTX7u30bwnYijXJLBLiEAavKBDHjMGW1f9M6XaCIVdUBZmEMuniIQiK3mCjAKMLW
 ighoAcB3ITjBrFrtxvK7KIrvXUdEnBi2a24l4iD8VHQV20YmsQpuRbCh13fGJ2+asUzj
 zBUtCzd99DFjQqwo1ellkuCNa5cwviMgBvjP+nPOLhVq27Lixks5biPDE16WLyP673H5
 CuTw==
X-Gm-Message-State: AOJu0YzZn79QcSAOYWbB38mknJ/fWcSL4ShsX2plroBpidNynLe3uEX3
 7+N0Il1jGkhpslOVjbqgJQ7qJLtn59E8Jwt+6cDe99giE0nzzoKSGMQszlwL3Ny9Rh5/FJ7yWcS
 eVy8rpcqYw+op3dmQmMz12iD3sXCvBFza5omDZ67mfsCy0SpIwIIi
X-Gm-Gg: ASbGncsRhzt/vlA3Bn2IF8Zjp+OjmWR/2F8e71olObmBhHqCFN24maR7v1R2NdjcEaq
 AFmElY3FZihzU4Q2YotiGJArN7r0sWOJAbF2FwFsdWkPCVTuM5nNj4pPIX/YbuDbK3qgzwrku69
 Pa1OoB6XfPNPFsLJQfjD32CeVjvUFnlH0CRxTXPnjk4/JfFyGg1wdRinM7RYLkHUr/k8spCsCln
 U5UZW7PCvUJWiB/4OeMgMjjNY4I0xseAHgTKZGugK3i/RpYaLUIPhnn6jfIVrpkenWNvkdUCaaU
 Kn0NQAB2W3kx
X-Received: by 2002:a05:6214:449f:b0:6d8:a127:e744 with SMTP id
 6a1803df08f44-6dd23355f97mr1061607036d6.20.1736240478139; 
 Tue, 07 Jan 2025 01:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzSF4bKxbD6oQJTFsPPOBo73wDQfre7o7XPY0Bvp47t2x4BSuaODUXIRyYOZG1uPfuQTfE5w==
X-Received: by 2002:a05:6214:449f:b0:6d8:a127:e744 with SMTP id
 6a1803df08f44-6dd23355f97mr1061606716d6.20.1736240477810; 
 Tue, 07 Jan 2025 01:01:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-182.web.vodafone.de.
 [109.42.49.182]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18e3c3ffsm178844956d6.13.2025.01.07.01.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 01:01:16 -0800 (PST)
Message-ID: <cb5f1730-9a5a-496b-acb0-24fdb6b502d9@redhat.com>
Date: Tue, 7 Jan 2025 10:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test_x86_64_hotplug_cpu.py times out frequently in CI
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJSP0QW02Mf5Vtp9UbvAUc+UXKV0Exw_ggFCMAgVQ0+dH7Jf0w@mail.gmail.com>
 <CAFEAcA8C916fiLab_86JhXMe5sjVQBjFZQVCP6YP+715pn9qLQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8C916fiLab_86JhXMe5sjVQBjFZQVCP6YP+715pn9qLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 06/01/2025 17.49, Peter Maydell wrote:
> On Mon, 6 Jan 2025 at 16:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> Hi Thomas,
>> test_x86_64_hotplug_cpu.py times out frequently in CI runs. Here is an example:
>> https://gitlab.com/qemu-project/qemu/-/jobs/8777540230#L1151
>>
>> The detailed test logs are here:
>> https://gitlab.com/qemu-project/qemu/-/jobs/8777540230/artifacts/browse/build/tests/functional/x86_64/test_x86_64_hotplug_cpu.HotPlugCPU.test_hotplug/
>>
>> I looked at this failure with Dan and Peter on IRC. It was pointed out
>> that the final command assumes that device_del takes effect
>> immediately. The console log shows that the CPU was still visible to
>> the guest when the final command executed.
>>
>> Could be a bug in QEMU, the test, or both?
>>
>> 2025-01-06 15:45:29,308: :/#
>> 2025-01-06 15:45:29,313: cd /sys/devices/system/cpu/cpu0
>> 2025-01-06 15:45:29,315: :/sys/devices/system/cpu/cpu0#
>> 2025-01-06 15:45:29,320: cd /sys/devices/system/cpu/cpu1
>> 2025-01-06 15:45:29,322: sh: cd: /sys/devices/system/cpu/cpu1: No such
>> file or directory
>> 2025-01-06 15:45:29,325:
>> 2025-01-06 15:45:29,330: :/sys/devices/system/cpu/cpu0# [    7.337146]
>> CPU1 has been hot-added
>> 2025-01-06 15:45:29,330:
>> 2025-01-06 15:45:29,335: cd /sys/devices/system/cpu/cpu1
>> 2025-01-06 15:45:29,337: :/sys/devices/system/cpu/cpu1#
>> 2025-01-06 15:45:29,342: cd /sys/devices/system/cpu/cpu1
> 
> Though the fact that there is no final shell prompt after
> the last 'cd' command is perhaps evidence against this being
> a simple race where the guest execution of the "cd" command
> beat the guest handling of the hot-unplug event.

Yes, sounds like a race ... I'll try to come up with a patch to fix it.

  Thomas


