Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AC4CF6BE5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkua-0005EZ-AW; Thu, 08 Jan 2026 02:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkuX-0005Du-1f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkuV-00074R-M7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767859103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t/CPbyE0JV6ZN4NRtLSGLhXrNpqUrSK6JDrePHwTts8=;
 b=b2C2lWkqS2WVIZ9GbfdN8oWTpdYD5Idc+fmFU6vpcVNfyV4FzN24xywxy2YEaeLdL6FbBu
 SO4Kdfjrkz9xpmz1JYsLruezSe0kDbkyxBYZe/txNU29wnm6wb3AkJuPJAARE+CdTGx+yk
 Shi9hWeWkPZBeqQwaayji40hRcNPGKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-zbGzUT85PTqiK5pLgqmGzw-1; Thu, 08 Jan 2026 02:58:21 -0500
X-MC-Unique: zbGzUT85PTqiK5pLgqmGzw-1
X-Mimecast-MFC-AGG-ID: zbGzUT85PTqiK5pLgqmGzw_1767859100
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so19707355e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767859100; x=1768463900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=t/CPbyE0JV6ZN4NRtLSGLhXrNpqUrSK6JDrePHwTts8=;
 b=QjeDvmjU+uM6tVJnt9mpZzq1Ze5hPrGf4h6nDy0TnJI8utmbsg9oq9kqmhv7zgWJne
 sHFUwMS/A6nqd/d6mPQWFrlFPBlC15KUfG+bQeO/VaF93BLz1WDp1rf+rDfOe549SOvz
 4ghO3zemUD6lokl8LYbm/B3hasc3sxqTIXAGF2K5+RaCyAMHpevwvQ2zxRONR22M3EeO
 ZRcCrQxT6/72c8mbtdXcxBSU1Er3kyBW5gqgxtxuLyNcqSKBfJej3y7YILrWk5NH3QnB
 355wnvqE5NDjxKiXhddof3+vYbBumuBgbEy/EymM71O7lY7Owp1i0OBshBsqI5XFTVTB
 G7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767859100; x=1768463900;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/CPbyE0JV6ZN4NRtLSGLhXrNpqUrSK6JDrePHwTts8=;
 b=I/rIBh/WpKhMvQDW3Hl+ePBJPMq40oVcGBkKqM2IXjfN2hjljtsfAkuxRTn5KvN+Ob
 oRFUA6p+KmFxh3akxFpMDkc5/m8OZorX3FotfPb/pEjXCNBNxcFzjoUsrZbUnq0xW4tR
 0n1+HfG/80kEhRZ9sB22tLPzAKLEACXkTprzTKbBsaXwocKxYjC6EqlIq22qiqc9chj4
 0hX6Cd9QnRPjEfKVOkquapGTYtIvntNwW+eGmN2Lg0/RjNXLxU8ITIbNpoan90oK5O4y
 RoQDMydyxBqYZufTUVz5+eLCgpJYSmTyTGlQPl72g9NZLeMSDrbjOGc/K+BPihLUl6Py
 Nabg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLPrZP8nFe905hpbeJtYnYZZyDr7gF1gGKT9VQKlYPFbY1C7Fr0SQsBdJHr/WBQZMn0jlv9eIQ+xN2@nongnu.org
X-Gm-Message-State: AOJu0YyLlvtuilz4t7zPSxtIqiEQ1Qyw02ZGa112tepUhdVMKnEGXW9U
 RgclcomONzrMOb024zXbOpArEiQt+GYvT8ppSMCy4mamR2wB7gDp5qLNNMiKs1/PWTYwScpsHwF
 8TkSvN3UjqyiGPNNsD/NeqL5fQxHlXcdVRZKj2smNQeHuqoDhsujNv++G
X-Gm-Gg: AY/fxX7ZZC1gBDeEdNDZviWOUMKG8TGGXEKQA7HWP06ZMbjHO6DIGvnHz825hZSLONK
 UCAJAjlU/v+cmSQ2H2PmerSuXLGe6nTUBCQUXN0zZcn11bHoptwaz0aVH5lNfwpK3uUjlLrIf0F
 TxDSdpZNs9PPaMJElpRnq4idBxCgRd2bw49HIEqxjHPYOxIPKuVAutxwQNoRBVkTXsBGqXyeLtM
 X5j2WZnCvTTcUBIWy9ZaPaCj9cdMkBDVt1aiU/KEalUSlKFzJo1Mp7FfBJYEDlKP8OkwjSxyuiB
 YYdrZknpnlvqkEGorbB+nLEB70Kc+E+NWV3rm2MILAk7N2OfDHWyTlkhts+vA78Y7ctMoOXRRmh
 ABNZkTaw=
X-Received: by 2002:a05:600c:1e1c:b0:477:8b77:155f with SMTP id
 5b1f17b1804b1-47d84b0b204mr55144535e9.8.1767859100354; 
 Wed, 07 Jan 2026 23:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsxlE3QMJRpKDHQa9LW4lcLNizlJI6E0gE29UEOygNRZNuGKYXuyn6Yi9GeY16zllgcJ9o1A==
X-Received: by 2002:a05:600c:1e1c:b0:477:8b77:155f with SMTP id
 5b1f17b1804b1-47d84b0b204mr55144475e9.8.1767859099994; 
 Wed, 07 Jan 2026 23:58:19 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695225sm139721355e9.4.2026.01.07.23.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:58:19 -0800 (PST)
Message-ID: <fe8e217f-857b-4df9-9e74-f29aa317f555@redhat.com>
Date: Thu, 8 Jan 2026 08:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/s390x: Simplify S390_ADAPTER_SUPPRESSIBLE
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-15-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
> Commit 1497c160661 ("s390x: add flags field for registering I/O
> adapter") defined S390_ADAPTER_SUPPRESSIBLE twice, one when
> KVM is available and another when it isn't. However both
> definitions expand to the same value. Unify them, adding an
> extra safety check in KVM-specific file.
> 
> This allows removing the target-specific 'CONFIG_KVM'
> definition in "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/s390x/css.h | 2 ++
>   target/s390x/cpu.h     | 6 ------
>   target/s390x/kvm/kvm.c | 2 ++
>   3 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


