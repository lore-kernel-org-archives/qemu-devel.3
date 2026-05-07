Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E921DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyt7-0004m6-JZ; Thu, 07 May 2026 09:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyt5-0004kq-Sw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:35:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKyt4-0001p1-73
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:35:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so585200f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778160932; x=1778765732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlFCmk+1a9NiMbuSot6Ixj5tJUD0mRJsa4cXyaZiYMo=;
 b=QJfmfp8sCmlRaIOorcTLk3+eAj6pHCARsOFMzOlcZIV2lu6xkxbKE0cKuB5odAwshn
 pWqZA+xt/V6XziX3fx4r+Cx0bkrKx86kZmWVMq/JYGFglW03PzecCjHDOcSVu4o7NlfT
 zHQyRUNC91+d5FYsGb/qIJ0leXRNyjgmb1ov8R30Nd+0ep9rPZbr9QVN+u/9J1v7QkkE
 lg4exPKwaQ+Xm8G4SYYsquhnMKY1Wlt0I1mEheUf5+ht78vlYOO6x1rQC+nyTIP7EEeZ
 oCILZwQQJFycPshC/yZ2Q9h2oecZcaog2FSbXNSEHW1qDIHzR6WdXUeRHFl3hlY7jQEf
 AgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160932; x=1778765732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XlFCmk+1a9NiMbuSot6Ixj5tJUD0mRJsa4cXyaZiYMo=;
 b=tI7JRZ6J5k+8rVQZJ9GiEIe6CcVHDU7xJBw/2oi8V4qKERy+4IPayMU2q23JLUcbrf
 oiwmYcehJdaCMf/0ssfPqKTdMbhnM+SD+WZXkl//4tL8l1OFpeaZcAkKf3bVPhZbkMdg
 w2daPMIo0yH3xdXkGfIUVpK2Tw4YFVMJYJB1guhZXOKFbFDekeSssZwFZMyeuyzJ3gQ3
 cRBDRzESxBIx9bUH/9FrTm/2RMho/b9FyvMgxxNuJ+24rvWweZbB+bDEuhHjWmbgd1CL
 pVyR74mI4P7vUtjejOkP9EwMrYd/j07NNrhQQO+rPo++v9ceuEw6i1b7rAo+B1d5/ERt
 MP5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/j11TAkFISQfdUllVI6hHPFzapADi6+yPLC78iYiguSbGGqxGSLSkD1PH+Bv1FVezurUVIwiH5HuwX@nongnu.org
X-Gm-Message-State: AOJu0Yz5RR9JKQBrKpV0HwyeZLOUwBfpCwNbexslTNuSyMD9Libhh5L6
 Z+kQPhLc04ymmpTrykEeRfh5aIJCZDi/nfmxDRykE6f96/RlFeqwwkDSTVB2nXye9mM=
X-Gm-Gg: AeBDievHaCb3r+kxBiUEns0uDsBtY9ZlME9yaQHtDN0ngZHta06Zi/8zjX+0J5VOCzF
 btzyRoRNZKSpy4hV2wCbjWg8izJm44SSTRvnBHBOH0O5U6qRn3D45DVkAv6Yqqp0FbXiWGeCsVM
 6Kd0BlYY9gaMZsnsjUYsGITPgOBfxrQ/bclcXkItnDxi9A2MUfKzZiF/KZLCyGlETgJ+03uAy3k
 vZOgQUc6lk2a9OTPnn0FvNiWWhZLMfYK2qyEFUBsk9Dxo3xvaHTDq+t1Z42Kzis/xt3MKxZpCbB
 wOpFiCty3wIEFEM/LaF/arKahlQCOLGdgHOBlz9JVDbUo15hL3DKV4D6vRTUpamhASF9Gar859C
 LKgy0vS9IQ69s1K453JY8E9NOSWxr8PbWc+ytPqP77QtKnQBu35BpZMBTzpGuZD4/TcMagMag2n
 tG9qBVbTYCrX80m1VKWfruWoBU0Qn00lLkSu30Yixs2pjlCh/rfGOpLkOGFVSMe1IPrFfnW+NAU
 geskNdJSLJSQWc=
X-Received: by 2002:a05:6000:1acd:b0:441:2473:c30a with SMTP id
 ffacd0b85a97d-4515d5c561cmr12917120f8f.31.1778160931758; 
 Thu, 07 May 2026 06:35:31 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm21543079f8f.25.2026.05.07.06.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:35:31 -0700 (PDT)
Message-ID: <0794f07a-0f71-4891-a1a3-5a2cabb4e7a5@linaro.org>
Date: Thu, 7 May 2026 15:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark struct ip6_header as QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
References: <20260505201324.932323-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505201324.932323-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 5/5/26 22:13, Peter Maydell wrote:
> The ip6_header is often used by network devices to examine structures in
> packet data, and it's not guaranteed to be aligned. This manifests as
> errors from the clang sanitizer like this one:
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/net/rocker/rocker_of_dpa.c:321:37
> ../../hw/net/rocker/rocker_of_dpa.c:730:33: runtime error: member access within misaligned address 0x742970fe7ecd for type 'struct ip6_header', which requires 4 byte alignment
> 0x742970fe7ecd: note: pointer points here
>   00 00 02 81 00 60 00  00 00 00 38 3a ff fe 80  00 00 00 00 00 00 00 00  00 00 00 00 00 02 ff 02  00
>               ^
> 
> Fix this by marking the ip6_header struct as QEMU_PACKED, the way we
> have done to handle similar problems involving tcp_header, ip_header,
> etc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Queued via hw-misc, thanks.

