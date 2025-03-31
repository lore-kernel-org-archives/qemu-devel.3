Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1AAC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDPe-0008Sm-TI; Mon, 31 Mar 2025 07:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDPc-0008SF-In
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:34:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDPa-0006zf-Hw
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:34:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso19358495e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420876; x=1744025676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/1ugXXeehKLqJ/iKVYIwHA6p7kmC9GpT9yN0mBLFq8=;
 b=FzWbrGIpozJX/GuckWci+22HuJwGIr0QUTsS4/Awjz5qdo5JjITHG3EVShWRFwvWTf
 jkKxI0uc2z6eJE6oeVfe402Lg9dldjBdqnxlJOk/5d/shsFUUr4V+00FgqlxKifGJFq5
 5ieIwQ5RwFi0X8hT4KR3ZnjAiM/eDpwYLaWCEVBCb5ibvUz3MU1sa7uclf78KvGXHcxh
 t+bdzI6mVSSifWX/7rjsss5Yq1uVk5yPJPknOwT7xbA8j4gQ1Sj1NTn3FcTT89d3mYWb
 c1ovoLlsCu0R67WO+ourfVqqCsRoIKBKEftROHpzs458MmqgoTrO0odkZ2nkMJBhqw/J
 xnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420876; x=1744025676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/1ugXXeehKLqJ/iKVYIwHA6p7kmC9GpT9yN0mBLFq8=;
 b=YUBvOVi4JtJnq+pef3wkCsjq2vuFnu0azM4ZNwQ1dCEWPLbwMwqS2iujdt9vTSmItp
 EgGBNwSCoQhOQ03JAurJzJQMCZgzyoFeaHcw+kc+3eqLWjK7PkHTR0gqafHhmY3oqDX1
 FI+ZLXC10J590ANUtM1ow3UzzdteleGencWuR5cmT1S6kzvth6tm8wh30hUJE2EGjz19
 KRIBlvEkMmXPauf5Gu7ux3pfp7uZb5724b9B+6WIMPPOTMQosgJgYNyTP9IhU7bPMUi6
 awLs2lL+XN9WUNGbd9tpokPWZUeWQvybswtC5RMNl+pusnvipUNz2SrQpu7MPNoiQGog
 A1RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlds8121R18A2TdmBYT+tXxJhk55BhK/XurN/XQR7o3bRhweMRnnRqZDkHYZpLKd+cM37l3Q/AxjbB@nongnu.org
X-Gm-Message-State: AOJu0YyeMmx0dXaH6I/dNCyxLTcXB84yODA1IO4oaZm1yjFCfLhpdvJx
 1nrP7xdOwqtOEh+cWX7RJRtA1rXnXlSGYkJ1w6tWcMsqeUwzivrK2FfibpIEE/w=
X-Gm-Gg: ASbGnctbIgmXe997MZLTy5x3AbkdnQSvoa+CLI6owphgRU04z0kBBVaA9cpBacVCyGS
 +hxIxH5GTxXclFfxFnqzb5ECGoghqFujuHSnrD36N62W0pcrWmdGX6DPsutSzRA3pBLKhMlWIS+
 YxuqRhizX3vk8iC9oPk1b1QgRgNljErJ/RjQ8bYqNJKPw2BcbirJo8Xj9k0LZRX/mGD9rZ7V8hj
 aa8hmkyPusH0JA/5buiqS4iicC7A963Zx1IzhpbJ7SIWyIWo9alQiGMcAz49uTW0DL2e4CoO54t
 1DAvISo13PT4TFYZKetSxZ4Lp0Y8PyZ77KPP7egOwXPuzaf+93PoRAZvkvO3haZhnESpq5nqtfu
 BtMtF7oHnLyMO
X-Google-Smtp-Source: AGHT+IGaYp2pVmIrTeKDbNC2ACpIa+1mAQPzjZz29IVj7CHAU8o1UNdIC8SOOaYgylVfEOSTH49cMw==
X-Received: by 2002:a05:600c:1e23:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-43db61cebecmr85395295e9.7.1743420876302; 
 Mon, 31 Mar 2025 04:34:36 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d900009e5sm119131105e9.34.2025.03.31.04.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:34:35 -0700 (PDT)
Message-ID: <054c2f1d-9fc5-4219-81ad-c9cefdec4753@linaro.org>
Date: Mon, 31 Mar 2025 13:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: Rakesh J <rakeshjb010@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, thuth@redhat.com
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
 <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
 <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
 <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29/3/25 12:30, Rakesh J wrote:
> Thanks for feedback on [PATCH v1]!
> 
> I've posted v2 incorporating the suggestions:ve posted v2 incorporating 
> your suggestions
> 
>   Paolo: You pointed out the size issue with .min_access_size = 1 
> and .max_access_size = 4, where bswap32 was wrong for 2-byte accesses. 
> I’ve fixed this with size-appropriate swaps (bswap16 for 2-byte, bswap32 
> for 4-byte). On the extra swap idea, I stuck with a single swap since it 
> aligns PCI LE with guest BE expectations without overcomplicating it—let 
> me know if I misunderstood.
> 
>   I’ve sent [PATCH v2] incorporating changes:
> 1.Removed gt64120_update_pci_cfgdata_mapping() and moved initialization code
>    to gt64120_realize() for a simpler MByteSwap check.
> 2.Removed unused pci_host_data_be_ops and a misleading comment in dino.h
> 
> 3.Size-specific swaps (bswap16 and bswap32)
>   I included bswap16 for 2-byte accesses in v2—should this be restricted 
> to 4-byte only (bswap32) per the spec, or does GT-64120 expect 2-byte 
> config swaps too? It’s a minor tweak, so I left it in v2 for now—happy 
> to adjust in a v3 if needed.
> 
> The new patch is available at:
> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html 
> <https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html>
>   Could you take a look at [PATCH v2] and let me know your thoughts, 
> especially on the 2-byte swap question? Thanks!
> 
> On Sat, Mar 29, 2025 at 4:05 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     On 28/3/25 18:34, Paolo Bonzini wrote:
>      > On Fri, Mar 28, 2025 at 3:16 PM BALATON Zoltan
>     <balaton@eik.bme.hu <mailto:balaton@eik.bme.hu>> wrote:
>      >>> It should be fine.  You should take into account:
>      >>>
>      >>> - the endianness produced by pci_data_read/pci_data_write
>     (always little
>      >>> endian)
>      >>>
>      >>> - the endianness expected by the guest (big endian under the
>     conditions in
>      >>> the patch)
>      >>>
>      >>> - the endianness expected by memory.c (always little endian, as
>     specified in
>      >>> gt64120_pci_data_ops)
>      >>>
>      >>> Because there is either zero or one mismatch, bswap32 is fine.
>      >>
>      >> This may worth a comment but I'm still not convinced this works
>     on big
>      >> endian host because I think pci_data_read returns val in host
>     endianness
>      >> and if you want big endian then you only need to bswap on LE
>     host not on
>      >> BE host. Was this tested on BE host and confirmed it works?
>      >
>      > Looking again at the code, there is definitely one problem: since
>     you have
>      >
>      > +        .min_access_size = 1,
>      > +        .max_access_size = 4,
>      >
>      > the bswap can also be bswap16 if size == 2 (and bswap32 only if
>     size == 4).
> 
>     Per 'PCI LOCAL BUS SPECIFICATION, REV. 3.0':
> 
>     '''
>     3.2.2.3.2. Software Generation of Configuration Transactions
> 
>     Anytime a host bridge sees a full DWORD I/O write from the host
>     to CONFIG_ADDRESS, the bridge must latch the data into its
>     CONFIG_ADDRESS register. On full DWORD I/O reads to CONFIG_ADDRESS,
>     the bridge must return the data in CONFIG_ADDRESS. Any other types
>     of accesses to this address (non-DWORD) have no effect on
>     CONFIG_ADDRESS
>     and are executed as normal I/O transactions on the PCI bus. Therefore,
>     the only I/O Space consumed by this register is a DWORD at the given
>     address. I/O devices that share the same address but use BYTE or WORD
>     registers are not affected because their transactions will pass through
>     the host bridge unchanged.
>     '''
> 
>     IIUC we don't need the bswap16.

What I'm questioning is why we need .min_access_size = 1
and not .min_access_size = 4.

