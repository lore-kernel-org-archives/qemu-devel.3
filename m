Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D53D6E2A4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE48P-0000sZ-Hk; Thu, 21 Nov 2024 05:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tE48O-0000sQ-3d
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:10:00 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tE48I-0007hn-RY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:09:59 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21262a191a5so6367045ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 02:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732183793; x=1732788593;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QKNde7XZveIduMh11CzqsJSyr1BhS5S7hWDk6mZeBIQ=;
 b=cyGwlM/pEQOuXcC+t25gflr9pJwSjlw9Gu3r3As593oktuguRVp3LMuXiUYimdP99K
 CdVACeoZyP8RQQ+BlOWgWL/0CiCZFxFMCdRSz32kr18AiUYSiPKTQtUEg2FeniCBlwts
 jJjehDyJypK31kQPV77RPzw1eQaMltTC1fq6m5ZIu+DI4IlTdO3XlannPecZq9WqA2Wp
 bzSv4cDfqjs47Bkib0l5aiDwnY0hPwcc3B/beo4A6Z5tjhcBSm/rUwf3+cKKWtTnb5KV
 mQbMe+lV5tOye/N2MMvqgs+TkyUkj3JgsBVBkaaUfOtTuqZINjecIuei4VRou6KmudAy
 vCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732183793; x=1732788593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKNde7XZveIduMh11CzqsJSyr1BhS5S7hWDk6mZeBIQ=;
 b=OBAo3wnPMdvtk4Zlw2VI5Vi2SnAuS5xfXjoUyWIYVetQ/LsoH7wU10Dqt5NaWa5yao
 IRAPtqIssl5/MfafG5vpvXTHpgNVVReMVAAmoiQq7ktsesFAtJ7s1kOqgsXpA2N6qa8N
 Y6pD8FTc5ynKqir2G95nrpxJkFLaeIpelW9TJoDSpw0i/vlmE9Adr3hof+f1aNPg44mS
 aljy7EasTVr8IxzTEmpZpWASmI8+8wtT+hfioUJV+Uj9mh6FX/DG6ga4Wcuuvor0BjnT
 jr/0RBySaGDAG2JPL3mNIYqSKOCIKrI81LdAjG1P8NMOgPjPHLjHxFA3n0wIvjiZfHIf
 7h9Q==
X-Gm-Message-State: AOJu0YwDCrj4nNr17RWDeCiigP1MnZnPxgqEPoxaM237W6QSI+KHzl6w
 T3JvRkNhrVSx063KZgi+2H+RjhCd4Ws6Z1uz5fQ9ebxPi6S3/lXx9AKCCh9qqR8=
X-Google-Smtp-Source: AGHT+IEXgOyonBPU5aeNCjGxDL7y7ppMTstFmrwWqXq/VQqmd9A51BFKYxUv0fBWNfoB9m/bLwMJaA==
X-Received: by 2002:a17:902:ea0c:b0:212:66cc:8100 with SMTP id
 d9443c01a7336-2126b8a3817mr84736545ad.0.1732183793093; 
 Thu, 21 Nov 2024 02:09:53 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21287ee14e4sm10140765ad.147.2024.11.21.02.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 02:09:52 -0800 (PST)
Message-ID: <3525b64d-9262-4eb4-9891-d30ace0db69f@daynix.com>
Date: Thu, 21 Nov 2024 19:09:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] virtio-net fixes
To: Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
 <56718639-49b4-4660-94f2-3bf6f66e293e@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <56718639-49b4-4660-94f2-3bf6f66e293e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/21 19:05, Michael Tokarev wrote:
> 11.11.2024 09:40, Akihiko Odaki wrote:
>> Most of this series are fixes for software RSS and hash reporting, which
>> should have no production user.
>>
>> However there is one exception; patch "virtio-net: Fix size check in
>> dhclient workaround" fixes an out-of-bound access that can be triggered
>> for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
>> can be applied independently.
> 
> Hi!  Do you plan to submit this and "virtio-net: Add queues before 
> loading them"
> for 9.2, which is at rc1 now already?

I want "[PATCH v2 2/6] virtio-net: Fix size check in dhclient 
workaround" and "virtio-net: Add queues before loading them" for 9.2.

They have Cc: qemu-stable@nongnu.org and will need backporting if it 
misses 9.2.0.

Regards,
Akihiko Odaki

