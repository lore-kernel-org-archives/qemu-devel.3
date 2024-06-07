Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C1CC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSi2-0008TZ-Oz; Fri, 07 Jun 2024 02:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sFSi1-0008Ss-4B
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:04:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sFShz-0004JV-BY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:04:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso1425906b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717740253; x=1718345053;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nZjMndhfpm/9kUUuzlL9awZQ6k/0bCq1VnV9MEmuw2c=;
 b=gBrTj1KM3zorBWDEYeCc96YYLCxJOGWe68Gv23n660oGS8NS425o5zhI/v8Atku/w3
 cgijUEX95SEa1nCzSCxewnJIP8bo3xq7TjNyWEHWRMW0i6l3cESILTSnGnOHtxLCJp0T
 Tu0+0F7oA4bMzMVNY+sokv8l66PhWRsdHLGdwuUKs/VPAZdx9abC6ka9iV6ppSWohrei
 Ebiny3c6Wnqc8y2eOzJL2fklTQdT+EFPdejzGZm/zYQB1ifddAv9YPYrQDp3kmDv3lzz
 SixrskB4Cc1UWHZp6x4rpkrPkg6ncDfmwGrUQvQ6CQSnx+SX7A6TviMYfoPRthLsuZ6G
 FQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717740253; x=1718345053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZjMndhfpm/9kUUuzlL9awZQ6k/0bCq1VnV9MEmuw2c=;
 b=OysQlL487qeKfngInFmtyO+M2s9ZzriCx5YyiX+oKw56cuu7HscvfgyK+uZJLyNIx9
 QeQm9yU00Ih9XR7sQDbfvnVJQ6+HUnuJQArSOGTF3YBRZd3yw50G67gLqPtl/dcuGkZ/
 G+XwpBGSb8eeEB7XpRrxXyDQZkeALqRcfYyo1CgUIT99TNM4e8dcVPOMgBCQf863JHR8
 74qxx+EoeIQpL1vufpkflLs/ZLEQrwMoJ1XDd+BnuOMQlRr0SGuc6ewgblrt3OSda5Bx
 dWDj3kzIJH8v4RYu5C/47bRt+NgJKxpLG0l6U6juTrE0g1p1B8WnyMEMvpnlOWCydQos
 KagQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg919o7kUVeTsxUTeGAfY4xhsCvMfGCd9chCYb047EHW/Qo6weTpHiiWABLhzq4yA82EWUUvNcXrgmknZ2MSnKua383Sc=
X-Gm-Message-State: AOJu0Yy9rMD3ctCmmbpne88LQBd2JwR56JHgWamSC6cG+flDHFWmw7Jf
 laCctn+ya+uYCL9zlVhBx2vYtc72Fwg3lXq9wFkXeW5TZBH5qh0Z/jh5YCyQ0g8=
X-Google-Smtp-Source: AGHT+IFttIKc4R97EoY22YY5J6y7/a+639piuy5UcRRrcH/PTe/1jk3+A1iziAj3QAxonGIPlceW2Q==
X-Received: by 2002:a05:6a00:22c4:b0:702:2e33:af33 with SMTP id
 d2e1a72fcca58-7040c65dae4mr1645018b3a.12.1717740253465; 
 Thu, 06 Jun 2024 23:04:13 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50f3f0sm1935241b3a.195.2024.06.06.23.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:04:13 -0700 (PDT)
Message-ID: <1c74a33f-00f7-4da7-8cea-1a43f126be39@daynix.com>
Date: Fri, 7 Jun 2024 15:04:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-8-jasowang@redhat.com> <ZmA8r20rrbCxKMEY@redhat.com>
 <8a2f0c43-1d48-48f3-8ab2-dafebe252ca7@daynix.com>
 <ZmFh64syjkG6JTcZ@redhat.com>
 <7b4aefd5-1949-4fa5-9bc0-e3ebb4218e73@daynix.com>
 <ZmFsTrS5QGAOfVpn@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZmFsTrS5QGAOfVpn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/06 16:59, Daniel P. Berrangé wrote:
> On Thu, Jun 06, 2024 at 04:19:11PM +0900, Akihiko Odaki wrote:
>> On 2024/06/06 16:14, Daniel P. Berrangé wrote:
>>> On Thu, Jun 06, 2024 at 05:14:20AM +0900, Akihiko Odaki wrote:
>>>> On 2024/06/05 19:23, Daniel P. Berrangé wrote:
>>>>> On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
>>>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>
>>>>>> Propagating ebpf-rss-fds errors has several problems.
>>>>>>
>>>>>> First, it makes device realization fail and disables the fallback to the
>>>>>> conventional eBPF loading.
>>>>>
>>>>> AFAICT, this is not a bug - this is desired behaviour.
>>>>>
>>>>> If the user/mgmt app has told QEMU to use FDs it has passed
>>>>> in, then any failure to do this *MUST* be treated as a fatal
>>>>> error. Falling back to other codepaths is ignoring a direct
>>>>> user request.
>>>>
>>>> The FD options are more like an assistance rather than a request. When QEMU
>>>> does not have a permission to load eBPF programs, a user can get the eBPF
>>>> programs with the request-ebpf command of QMP, load it, and pass the FDs to
>>>> QEMU.
>>>
>>> That still doesn't alter the fact that if the user has chosen to pass FDs
>>> and QEMU fails to use them, it *MUST* report that error back to the user.
>>
>> The user should be more interested in whether the eBPF functionality is
>> successfully enabled or not, and that is irrelevant from whether the eBPF
>> program is loaded by QEMU or someone else.
> 
> No, this is wrong. A mgmt application or user will have made a decision
> about *how* it wants QEMU to configure a particular feature. QEMU must
> always honour the mgmt application's request, and not try to do something
> different.
> 
> If the mgmt app did not want the FDs to be used, it would not have
> passed them to QEMU in the first place. Ignoring the FDs is not likely
> to work, because QEMU is unlikely to have permission to open the FDs
> itself.
> 
> Ignoring the errors when creating the FDs, makes it much much harder
> to detect and diagnose deployment problems, because the root cause
> error is being discarded, and replaced by a later error which misleads
> the app managing QEMU.
> 
> Always honouring the user requested config, or giving an error back
> when it fails, is standard QEMU practice.

I see.

I'll append a follow-up patch to the series "[PATCH 0/3] virtio-net: 
Convert feature properties to OnOffAuto" to remove the fallback path. We 
can keep this for now to remove the flawed error handling code.

Regards,
Akihiko Odaki

