Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EE8C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOF5z-0004g3-Ma; Mon, 01 Jul 2024 07:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5x-0004eg-Qw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:21:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5r-0004iK-S2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:21:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso19871235e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719832870; x=1720437670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HqYKcm1A89FEOMNRUkVlvdrvbaPWNfCd2gw1vOazbek=;
 b=UTkl6yI539ktzxHKza4YuZLfGfJ9hJx6dWoGYWjl7sePwnqxcGC/Xmmx9m6WVzvN4g
 4bzGaCY+6E274qQMn2iux7EC2js4Mzz1pfcerPqQ2z4tvNSfT+dJyri10F9TVAY37fl5
 LSV32wxOdR2xHOIwCcglXD5yPpXns99kbQdGgCIeqBRIJVvljVMDIWX8s0h0N9MEQb+h
 g6BIO2avCAwhmcshVU2x8dqteyLASuV6Uoabaydy0SARR4Mst1nK7uYeNjF0GZHXUnR6
 FG2nen0qTmY1Osd/nRHEYVuz9v1fuuuy0sY+wXDkDTyJO8AA5rnsjzvMCaDs0PCIp1Mu
 H6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719832870; x=1720437670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HqYKcm1A89FEOMNRUkVlvdrvbaPWNfCd2gw1vOazbek=;
 b=T53oONuJgP0uL1Q5nMFulK/ab6yxQtEjbOVcAoS3GBawrXLhhH+wBY2ktVU7qBTOJZ
 EnYmW4aYmCH3b0vEYsLucZReciIPdcwQuk4W08J7w6uyU+Os7vVy3D21nQdhdtqzhgyq
 I8lc/lYxqqCjE0h2yGklHJjVaG0xqrQ7Mh1l67gQ7Q2T+yQ8uC94TlovQ8jf44cKvfkC
 yelpsc4/dxACBFne6S9xO2DkU/fzA7qfM4WXlxB/msBOfLB9kjC1ZV3jOyGxjZS5XBm2
 NR0tVYZltC4qEhgitX3Ua7svCzRRzw6mhIgOJwbQNMJ19+ap2YuwDgp9E/Kfb3j1Cgu9
 B/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6DEnakLomC21/xFx6F6zSWE6arXmVi0JuVoWuV7WJKWn7xNc2VSOcgFhuWdf0hBwj5S48/n1O96R9/ao1Vts5MG2UI0E=
X-Gm-Message-State: AOJu0YwuNLj/JgRNy44y7qyx7UWLX4j/sAQ9HmkCU7WgR9FEesKkIpeU
 9sJROz36WsmbbS+cvi+2vT6DqvR/6gD9vV6m70nQ0VrlVo7Rmh1M0ws1XPO0pl0=
X-Google-Smtp-Source: AGHT+IFb4DIdpprbeyX2xW5x8j2uVH+M74r8AZ26BvpgjK0wiroWvV11eBtMmAbfrDXzz+aJFtJrbw==
X-Received: by 2002:a05:600c:331e:b0:425:65be:3477 with SMTP id
 5b1f17b1804b1-4257a03c3b6mr39176545e9.18.1719832870480; 
 Mon, 01 Jul 2024 04:21:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4258014f8b7sm53525045e9.41.2024.07.01.04.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 04:21:10 -0700 (PDT)
Message-ID: <d2fa5c04-7e55-4051-a587-055c19cebfd6@linaro.org>
Date: Mon, 1 Jul 2024 13:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] hw/i386: remove obsolete manual deprecation
 reason string of i440fx machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-14-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> The automatic deprecation mechanism introduced in the preceeding patches
> will mark every i440fx machine upto and including 2.12 as deprecated. As
> such we can revert the manually added deprecation introduced in:
> 
>    commit 792b4fdd4eb8197bd6eb9e80a1dfaf0cb3b54aeb
>    Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>    Date:   Wed Feb 28 10:34:35 2024 +0100
> 
>      hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc_piix.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


