Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A898BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7P5-0007h4-5S; Thu, 06 Jun 2024 03:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sF7P3-0007gt-Oz
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:19:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sF7P1-0004rF-Gf
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:19:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f480624d10so6267685ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717658354; x=1718263154;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w5QdUg+nEWPtEW5/hMt3S5JbsblYNq3govcKbcjyzeY=;
 b=yKD9BVC6dUQirLB6wd7j34rXJ2iHGZipbI5HxoVaMqWhQCtZK4Zwsh7RNOu9d/1tLA
 NKAjLH3ZLhbMWz2mcmWdWMSyl+GlMQE4VXhCbsLTIn8xRs6xh5bMZ854CxFdUnsBgZLb
 Lx8SikhGfdvQCSilY9wKjbFuf5NnafBkO+S9crZ6lQXpHPKj2yW+nHgYSj+gEubOf4RM
 ue8K6Lz51NzRP9CRVvVK8vp75YqKUrSzlhVP74NSGLatCFV1553hAu9ny/8fv+qTSTVB
 +dr9jBeve5C1wuWtEmmLHIVovKAFVOzJbp8HvWn9vv7fx10ZHlbW9cw3VK4NmjBVFddL
 boBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717658354; x=1718263154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w5QdUg+nEWPtEW5/hMt3S5JbsblYNq3govcKbcjyzeY=;
 b=e5/nBumAOVBzBrGuIuBzi3k6B0ZDJIT+NFhPy4vISP+stPZFWDPR8C1EiKGLhGRLWl
 snUEv9r92qMYpbfvkhFDqlrYz89DOkeIyDtdaw8SMuz9C9L9rR/mdMk2UghZdCDU5QId
 8qzOqio5bKBpTJl0KP+6UL8XcdTqgwnoDqxrWQ+G9bTaUV9fuTfsaxqZWBKP6sTYt4fG
 Pz6Pdb8YqNpQip8Thp0kvNFMvSlgtIEwcxrx4e9yEKngPjTzRjgQ+Hcx9o1FaJ8TZZ1w
 LA12Xh2F0jAhBWrRPbUAFGJ+4tadxojSnV1RaNxShNHyqPG8LP0KMWrzBsARK6BQXThY
 Vu/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtECD52y7rgHLbEOZA1PhcYPHV5PiuvEaBKI5P6XqGKi2GIrNmhB17JBO71ZqMf5MDy2arDVSfI6L4PYQGkQEUwlyj7Hc=
X-Gm-Message-State: AOJu0YzFHoPCnLO551nYlGLDYCav6pLz0ShvhHZhJ29u21cM/GzMe/iT
 mcoxC7CmIunbjQXKUfycBjSNbQ5JYWhscwYWdLp699tUEimymRrWr1WNYEqQ/kk=
X-Google-Smtp-Source: AGHT+IEkVFJtnmYtTQ/2N22z4jnG6D/bb7Uw46GFqgTwXXLwLRozPUJM9sC3LvGnwQHFFfmI6+zrgw==
X-Received: by 2002:a17:902:ea08:b0:1f4:8a14:f4cd with SMTP id
 d9443c01a7336-1f6a5a28f49mr58284755ad.39.1717658353794; 
 Thu, 06 Jun 2024 00:19:13 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd81dfd9sm7280125ad.309.2024.06.06.00.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 00:19:13 -0700 (PDT)
Message-ID: <7b4aefd5-1949-4fa5-9bc0-e3ebb4218e73@daynix.com>
Date: Thu, 6 Jun 2024 16:19:11 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZmFh64syjkG6JTcZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

On 2024/06/06 16:14, Daniel P. Berrangé wrote:
> On Thu, Jun 06, 2024 at 05:14:20AM +0900, Akihiko Odaki wrote:
>> On 2024/06/05 19:23, Daniel P. Berrangé wrote:
>>> On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>
>>>> Propagating ebpf-rss-fds errors has several problems.
>>>>
>>>> First, it makes device realization fail and disables the fallback to the
>>>> conventional eBPF loading.
>>>
>>> AFAICT, this is not a bug - this is desired behaviour.
>>>
>>> If the user/mgmt app has told QEMU to use FDs it has passed
>>> in, then any failure to do this *MUST* be treated as a fatal
>>> error. Falling back to other codepaths is ignoring a direct
>>> user request.
>>
>> The FD options are more like an assistance rather than a request. When QEMU
>> does not have a permission to load eBPF programs, a user can get the eBPF
>> programs with the request-ebpf command of QMP, load it, and pass the FDs to
>> QEMU.
> 
> That still doesn't alter the fact that if the user has chosen to pass FDs
> and QEMU fails to use them, it *MUST* report that error back to the user.

The user should be more interested in whether the eBPF functionality is 
successfully enabled or not, and that is irrelevant from whether the 
eBPF program is loaded by QEMU or someone else. It is being worked on 
with another patch series:
https://patchew.org/QEMU/20240428-auto-v1-0-7b012216a120@daynix.com/

Regards,
Akihiko Odaki

