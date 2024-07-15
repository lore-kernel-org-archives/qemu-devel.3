Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9580C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIGq-0006Nd-K9; Mon, 15 Jul 2024 05:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIGo-00061W-MH
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:45:22 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIGl-0005gb-4e
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:45:20 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eedea0fd88so20500741fa.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036716; x=1721641516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a//mJPbnFwiilWEMy8qsTHnOig/DBpBaAeFKZiMZFzA=;
 b=yN8AcUUW4/4yKdzIp650pVtptJvdpU5U6MukcZAH9ySmzd2/z5vM1w5xFRgJgINnbv
 GXWqhoVp2Hgc69TEjfjTXb67IqMB+H0QTgMlnJ5qAAlzdvymwsTrB1pzRYwdO1Kty+H7
 ttDhmAqvvsUcRoaPCmpBGr5KdwwEqS9O8Wg6IhHg2tK6pMpLOTdGE8jl+zQu6n+kb/Iu
 loEqvCZv/BTH4vKX1ufUYY+MkJhZ531z3QLhKTGjhsT7pdQfP2Pr7+C475/gaHanEZ/a
 arXJIH24gLcOPobew/Eyn6zJ9jSc/0uIcsyfFjGtd4aDBqt9oMvCL1Y0gIoAMZnb7S9x
 kyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036716; x=1721641516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a//mJPbnFwiilWEMy8qsTHnOig/DBpBaAeFKZiMZFzA=;
 b=qJu2eNgaYkc2hKiJn1hDCAh/uNOOaNbQIEVhRbcGKC01/nqZhOGoFUaCT51CbOrJF7
 VuuzjLblEPjK2v2ciMFBm4UEUbDxv40KIGr+hrBMic75LU3s7m6BiSsh1md950W97c9J
 GO8bazYgHc7Gir7JkeQ+XqRKEu7dlS+vgG7ToDzKdvNkwvDeWv/HARdab4VhO2wUgzVb
 i7Yf62qNtW3ffi6OMrmZWxgcpi7mW8gXAq9WvJoM+4v3j8kmJmCBi06nJ+tEt+KzME1P
 qLzTgObezboz77hQnmRHjYegZNGGMESzT7KaxV46mq4LO3z3tb7JoUJmiu8Ho1eQEfr7
 7J9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsBxaUbM3fboVMmJuLqLOBwFsrL0ClS9bmmR//Nl0KNSi/wG31PpLslQJ+OVHJgyhH8ki+IuBCzTNDL4Rq676ie3xU5hc=
X-Gm-Message-State: AOJu0YxhjxL7X7zH+8iNIAYZCgF4j1z4IBH0uRTBffW2+E1k6E6jstzy
 2dusi7moe05SqlrZqntmjwtsbIAz1AEQzv8kyaw8jYcAFVL5GGXQtGJNkiDwF8Y=
X-Google-Smtp-Source: AGHT+IEmGRFsbDYOB8eIAOJLbucWkYaSVGq5DqOyoqveB8u+UAmtnOhk1qYkQAKf5+U+O0my0JS43A==
X-Received: by 2002:a2e:9583:0:b0:2ea:91cf:a5f0 with SMTP id
 38308e7fff4ca-2eeb30dbe58mr117780041fa.19.1721036716237; 
 Mon, 15 Jul 2024 02:45:16 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb478sm79597375e9.33.2024.07.15.02.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:45:14 -0700 (PDT)
Message-ID: <c2e194f0-d774-47a7-ae53-f0a11f00fd1a@linaro.org>
Date: Mon, 15 Jul 2024 11:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] backends/iommufd: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-7-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: Yi Liu <yi.l.liu@intel.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   backends/iommufd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


