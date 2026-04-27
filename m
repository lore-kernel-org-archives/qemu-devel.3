Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E3FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSuE-0005Kt-T6; Mon, 27 Apr 2026 16:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSu2-0005Gj-Gd
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:50:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSty-0008JC-UP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:50:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso148609635e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777322997; x=1777927797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K9LQMhbq3UafJT/gSRJmDPNRrwYwFOmC8pKvQuYGvac=;
 b=ljWI9TEbZr9FZwmBlGq4XmlzlsJ502CLphZI0jNiAl1M8cgz4W344QGxF5x33LdJpL
 gtYfUFvZX+10DuudIVv2FB9pDFyXFmXYiL0xPAL2ENW48tG5IN3YfkMPgNrPegzNzP7T
 0J2Bpwqi6/Qb62HdXXsZVoVbhBWGmIj/7vFHFE5GZxpSoqc0SBMgSA3R/XOxDWLQBdDn
 VKkpOwYNbyc6ewDvjp48gU6R8CyZdcAjOwf9IUJYzGFE0Ocg6hMiTeTo63E+J28g16Qa
 k0imIqqia0UVRKUs5zLSP+abkVCAlN6PgfGSQuHeo5wzfQeuNMWkK2RbxQpg4LsKk3t6
 c9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322997; x=1777927797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9LQMhbq3UafJT/gSRJmDPNRrwYwFOmC8pKvQuYGvac=;
 b=lwi0bUhEG9cMJJDGdQ2jOFpib/q8ce35tsFeGqDmBBvFPVmorKjZXRpg84F7Iw7fHh
 H5NP6thZmkrWk0kxqqvE9L5KXgy9pcxcq29H3uTd5Ng2JDCxmK13sx73Y38Jd5X1mmWs
 DZq55OG57/9m2TOBPOoFY4iBb1KKmKxE6Nd9h8wM6EpiQuX/olQn0lohqRVSLVK0NrFx
 A/VKXe907wGNX3xeXWArM4cv4C4J2rsY4U1QTAyE9wKGFcDUFQT+mLAzg+iVsrx4nkjK
 vIKl1xCM5ogzsKqXcYYTDD8U9wLofQaBryoyP38LCFx5pP0DkHvQFQhVBbIgWBui8csH
 /y3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ94du/rj1wvpYYBHSS1eXPruggNw8AbORkwdxYbwJJmIHG7PmsdmxgbjRoAvrVye2pLRhdtLabErsN4@nongnu.org
X-Gm-Message-State: AOJu0YxQEW937DrzEEnWoFdMJxexsSW2lszDG4GdKNIov+TriHMLfbgp
 IXR8cSiPY01Nay3vwLdaYCEI/TX0duS5uwd3sT7WpLkCj//KHMUiSe5Nt6t6tx+JoL8=
X-Gm-Gg: AeBDieuH63PXWl/P1U/WDjKbneT6rHIJmVtR74JglL1P8X+btBT9mdY79gk2HdhccEW
 ZXKvenodslj+2laNk8moA3jetEPeFSnKtchk5SiLV3siNDDTta3xi4QrWf19L78HI1h+FHe+7PZ
 OB7H31vX9vdZDE/udAhPpUEy0AdyhKZS3yhVnDdpFvXVCIvaCKMNZifqKudVQ8paGLRKZqDwS6Z
 co9HOfrQXFdeO2PFd2Rvrax3ogI6TnihjTpGQxXTA9BIQ5pr43NSUKJ/xWAxXW4NIDArKl9Xg6I
 j4/yw9i6XUPMLYiyeqA03sQUpNFa6/OFQ4sU+E3aXSXb7eGp41gZcVm8U6RYw7/IBek3MlKtX7n
 +S2sXa71vzwVGKVfGCp9SPZ9gBE64JZQtcuC7XuJA3QV5oSLgd/aFhXcTLrMw+dSP47TMlK8rF7
 7jTGZervfdWC+ClTG92pndYN4V0qF7phZjTNnb0rYBopp4/lpSiM/FtPCChr3eDUTqn+9ovE3AF
 bD7
X-Received: by 2002:a05:600c:8b52:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48a77b1a4aemr3298595e9.25.1777322997325; 
 Mon, 27 Apr 2026 13:49:57 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77449ce5sm6328845e9.0.2026.04.27.13.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:49:56 -0700 (PDT)
Message-ID: <2143ed51-4076-45f5-aea1-9e43fbb0ae77@linaro.org>
Date: Mon, 27 Apr 2026 22:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/41] hw/arm/sbsa-ref: free unrealized flash devices on
 finalization
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-33-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-33-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/4/26 21:42, Marc-André Lureau wrote:
> Flash devices are created with qdev_new() in instance_init and added as
> children, but the initial reference from qdev_new() is only dropped by
> sysbus_realize_and_unref() during machine init. When the machine object
> is destroyed before realization (e.g. during qtest device introspection),
> the flash devices leak.

Hmm PFlashCFI01 is opaque, OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: e9fdf453240e ("hw/arm: Add arm SBSA reference machine, devices part")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/sbsa-ref.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

