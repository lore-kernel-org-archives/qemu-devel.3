Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF8D26D97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEtD-0005OO-5k; Mon, 12 Jan 2026 05:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfEt9-0005Ns-Q3
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfEt7-00071A-NY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768212664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j9shlgCkL+vi4GflzTpN6dbKLnCnNaVZswwkpXy8Koc=;
 b=OIWjo2fc8huJD47UcGx+7+PnlXKgZLN0Ph8rBmQNWpo4aCCwnBswRJ58dyS2Lqpm0jFelr
 SdBGvWwQLYaJbGf42lZd77yELCFCXPoFyM7u6Vc9qqgFB1eudrdgZx7be3YUMEq6/p0Ovu
 2+/q/WZu8jm2PxgY72aRU82EpfUt/2o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-vNF5VIYCPNypdTrhf5lgXQ-1; Mon, 12 Jan 2026 05:11:01 -0500
X-MC-Unique: vNF5VIYCPNypdTrhf5lgXQ-1
X-Mimecast-MFC-AGG-ID: vNF5VIYCPNypdTrhf5lgXQ_1768212660
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so3098156f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768212660; x=1768817460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j9shlgCkL+vi4GflzTpN6dbKLnCnNaVZswwkpXy8Koc=;
 b=XI3UfUDQxc4/qw2mPEIAATBMLT1FJsiMwwyHabEZQgZ5WS/EQZg5dEykeuFWNOBf8o
 qp2J9bGK5iGFah/VRYa95TbYlGYUObyqRMlo3YM9D3xhLl3hd1wu5Rg7qwsZQ0t8xqo2
 PAw4Fn2WEr763oGi6YvDPQHJ8+gxlRGHV8FGS8dlqVugENO18lsL1zAD9srnFUSvzND4
 WyaiFKTyS29LKMxS3uq1AAmnKb0eGtTbtTMTrbAaxuXC0YN7DOaHvlx4V4Owru1DtiF7
 3vFY1NJnXUkThDdChuI0ryu7lzjJnjnNdpXSrjRBoU0ov/0jpSeQdXp+E/Nuqq0CRyOK
 bprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768212660; x=1768817460;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9shlgCkL+vi4GflzTpN6dbKLnCnNaVZswwkpXy8Koc=;
 b=doXeJmHJ1hehrCleK9oK1JOsi4qNvLsUc0N6GxwiAIkzNQzRQexOuVVUOCVDwYj0qg
 oE29I9v2joBehWbBZ8pUlZazgiDdoGKekGlb2tgepXoeHwP4BVzszKRu/YYAfoi1CjwW
 dlYWgbdhH7wKWC3tQilKbN9xWBtU8Od2aNIdaaycZv3q0NKgBX6GcaZadchj0ueRixUK
 2/K7YYcVegB4xlafN5/+k9273MdIshqSJNB9Myx0YLYXdSes6GnvCWRcQ+F/fMURMS3e
 5bv3McrDxyzK9GA/mJ0LPCSy1zW908TmrYpNHrN/pp2QbT0H3PE6QFdR+kF5oq7Jvq1X
 elXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQZ2EpM2OsxK/aPctVgdv9zR5gbjgzfX51VPTsszsjX5V5/0QNJTs/QKyoiva335l9Jiz9mOIkI6T+@nongnu.org
X-Gm-Message-State: AOJu0Yx1FPYLAQgT0h/V2GnXNIlMlSs+pQMmbOy14Lj+AIVgvJIUXOEa
 +tsZmnnsNMk8kuPjfBYEt7p5Go2VF5AR9nhCc8dWxzwbnM1Fom3OxgwJRafKbnro20ffoRbngVT
 5puXGjZDH5y/HhFDM6iJycFk438RKvN3u0ZRBAyGa5iIjwk6Rro+fwZa7fQ8QTvzk
X-Gm-Gg: AY/fxX5o+JhjkozUMWxIpzT38kPGlRSF+HJieCAHp6bpNwnSLQH5HKvb/xF0aLOtoW0
 MVYTHWSWRshUGzHz9lAr9jGri7Ba9Me62V7jIhR11gd7zLgjTJp9D1XWz4/BIa3PoqFcQBSgnrH
 Ow88pOvIWG3x2jJ7QtHbHqod82ArXgMzqc3Y8MMLyLA411o+PtJPp/BCvWK6zONzol8C9KyFk2A
 jIw+W2SKyqaxOOeIeAKq1gUgw6qnVs4hbaxL/PXAvf/bihFOdRKyDC7cTeBdhkX0xVcl1uE/ZYx
 QYEmHjVGz/1uMvLwqDE+vu6S3+fQswPfdmhPJOGOgchXJ3rv8csFYqV54bicWnncHeJvX4UMnqB
 UNCQZon4=
X-Received: by 2002:a05:6000:208a:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-432c376238amr18893059f8f.21.1768212660152; 
 Mon, 12 Jan 2026 02:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8MeUNC7yHdQWr3aS17GyE4SfrkIqLSv3h+cfBef+mLxgOj/tzb1nyxYC8o+PJOOU8IHJvDw==
X-Received: by 2002:a05:6000:208a:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-432c376238amr18893030f8f.21.1768212659713; 
 Mon, 12 Jan 2026 02:10:59 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff319sm38394300f8f.43.2026.01.12.02.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:10:59 -0800 (PST)
Message-ID: <1fb9f24a-eac0-4497-b182-e2ea3f6e61d9@redhat.com>
Date: Mon, 12 Jan 2026 11:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target/s390x: Fix infinite loop during replay
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
References: <20251201215514.1751994-1-iii@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251201215514.1751994-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01/12/2025 22.49, Ilya Leoshkevich wrote:
> Hi,
> 
> Here is my attempt to fix [1] based on the discussion in [2].
> 
> I'm sending this as an RFC, because I have definitely misunderstood a
> thing or two about record-replay, missed some timer bookkeeping
> intricacies, and haven't split arch-dependent and independent parts
> into different patches.
> 
> This survives "make check" and "make check-tcg" with the test from [2],
> both with and without extra load in background.
> 
> Please let me know what you think about the approach.

Since there were no other suggestions, I guess your patch is the way to go 
forward with this bug now. I'll add it to my next pull request.

  Thanks,
   Thomas


