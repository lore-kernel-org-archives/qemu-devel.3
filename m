Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB9EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 10:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3Z7s-0001HN-2y; Sun, 05 May 2024 06:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3Z7p-0001Gx-Hl
 for qemu-devel@nongnu.org; Sun, 05 May 2024 06:29:45 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s3Z7n-0008CC-CD
 for qemu-devel@nongnu.org; Sun, 05 May 2024 06:29:44 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2b37731c118so752775a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714904982; x=1715509782;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMb+NL2JV5o5bue7UPFwYy8bgklZrqQMWJt58wpkW8s=;
 b=Gte38bYYnKuG8VV/p6iCmIERv+784HYG/BfO8VVCXBDVpvAXfdp5jnATzqDk/pxI4V
 6/3uvSoe0ANKPY9KxcEaRw6dix/fvu13sbxUOAQkxY1FvAKhYZJShrzb9ekncC3TZ9+1
 OclZBK9Qavcvh/HVNTuM5gj1uPSFj6QUdMtL2tmLj1d1IAg4aYS2KhIDcCqSq82hxrsH
 MwZk2beTvn5GY84da7zQLbYweh6hGDpDS1mlKynUmQz5abY8QdbA/1JgF5Qvj8ks5Qr5
 /uPAjWw66h/rCMdgOcvKuDUs9jnQE+7hxCI20B5kdA4Om/lxZTaIMuGlDHKJHy5bCF/K
 l51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714904982; x=1715509782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMb+NL2JV5o5bue7UPFwYy8bgklZrqQMWJt58wpkW8s=;
 b=oOKO/JRaQthHLY+HFy6Vdc1Pj+4cu+WlLtFEh90wnxNLMHwMxaJp164yWDwke8vBlb
 E9AwAe219sADIEbuGVW7wLsoF9YljWhAu6lFI2PUq1L0SqhH2P5G1IdpegAFQ90mfyxX
 KbczZfv5zSMtHqhbjuWYnjUCzYSx4Iy3Jd1xMorqgtUpQ/e8xuCR4H81N+0wbsKsmCXY
 fVYMZ+oG+/ttkpp39dtIRZwXPttE8B/EWvpLNshq1cknBab2jvfVOvCpI4yL7gIutf5t
 6aKOf6pP09bi2A8rI9iaMwHBOa9INP39b1uOSq7PeGHC6Oqdveh2NXIQAfPBU5lFiFvw
 ZUuA==
X-Gm-Message-State: AOJu0Yxo81pAG+dZaJQ8MLXTvv9R1o/pXdAb4BmXK7qDNOaqVN7OmgRW
 OEoLtqhQgPpzB4IJPASrmWE4u2JwOjeaS63RhkdoQuNI2pVBUpPhEj7sBLP8kRF1j3Jscv799Gt
 jRaA=
X-Google-Smtp-Source: AGHT+IHC21i7WUZekdavOCRZJ5JpOZgZS72w7tgns6ft0+pP6TyxfOvlnT//lofhjNgfQ2tytZKK1g==
X-Received: by 2002:a05:6a21:18e:b0:1af:8004:4be1 with SMTP id
 le14-20020a056a21018e00b001af80044be1mr8224225pzb.33.1714904981748; 
 Sun, 05 May 2024 03:29:41 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 gx7-20020a17090b124700b002ab664e5e17sm6125060pjb.1.2024.05.05.03.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 03:29:41 -0700 (PDT)
Message-ID: <edad61c6-2b7c-4982-9038-afcd765f6df6@daynix.com>
Date: Sun, 5 May 2024 19:29:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-keymap: Free xkb allocations
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20240501-xkb-v1-1-f046d8e11a2b@daynix.com>
 <b3b6ba1d-3f58-45f8-96fc-800e6ec95284@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b3b6ba1d-3f58-45f8-96fc-800e6ec95284@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/05/05 19:24, Michael Tokarev wrote:
> 01.05.2024 10:55, Akihiko Odaki wrote:
>> This fixes LeakSanitizer complaints with xkbcommon 1.6.0.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   qemu-keymap.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/qemu-keymap.c b/qemu-keymap.c
>> index 8c80f7a4ed65..7a9f38cf9863 100644
>> --- a/qemu-keymap.c
>> +++ b/qemu-keymap.c
>> @@ -237,6 +237,9 @@ int main(int argc, char *argv[])
>>       xkb_state_unref(state);
>>       state = NULL;
>> +    xkb_keymap_unref(map);
>> +    xkb_context_unref(ctx);
>> +
> 
> I'd avoid freeing any resources in main() entirely,
> since it's much cheaper to free whole process by the
> kernel at exit time than to mess with each chunk of
> allocated memory.  Dunno how useful it is to "fix"
> these.
> 
> /mjt

This is purely to satisfy LeakSanitizier; the LeakSanitizer complaints 
result in a build failure with many noisy logs. I don't add Fixes: tags 
for this kind of leaks.

Regards,
Akihiko Odaki

