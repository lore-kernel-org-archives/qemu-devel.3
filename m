Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E0BC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcV7-0004vK-U5; Thu, 30 Jan 2025 16:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcV5-0004uc-4V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:55:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcUs-0002tf-2u
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:55:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1193166f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738274081; x=1738878881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6cOHChUiLm1Lkp1lZc4xhZKxfhQwGE8VXRWiTHbK8U=;
 b=FxXvDED8E9ouukrj+802KDupcFGPxAiI8Bmhd0pz6R5N/I+lRoC/DykJPlAo3yBDxD
 ubiMmkT7rep8krM+j5CXYL298oOF3jeTUx4sIdNjVt0FQSGeuKXlYY1L2YQ0zxIAzrM2
 Mj1poscPQWiH597e3asv2u3cav5P9s6a3ozTEBk9Ev1JSxZblsO3X5oOiJPrJxYlOgXz
 ziH8nX4wVw4WScc1mp3lri8qhTSp90hAxvTBru31LlCzg8at6RqTZo8MBMLn72cGjSl3
 iEvx4MfMtHG0xOy+hgVOdob30iLKsnGeIPH6qLtogVFnpFqUCrwFCVQgg4xC3nV/AFWW
 C2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738274081; x=1738878881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6cOHChUiLm1Lkp1lZc4xhZKxfhQwGE8VXRWiTHbK8U=;
 b=b7SMOJnTTlOxfFO15VL4qQsNSQj+bjooTQ9YEaqcqDZ+KQ5ZnyswDkocTawh0s2o9/
 BtthSpX6F2AlA9AkZzIHQkuEJbZhx5VeZhPHREiRrjslixFszkRBkbPP1eK5MWXxL0Y0
 K0y2FsQUa8ky3zsSX/1NcVSzQXt3H6vnLsrFTAO2KrTg4NaC7Hc9ngZIaCkGY2HpmmKx
 DnS1KYHcpYBFbvypgFgUcxVbSQCJ4nHBqmOr/S7OPwvY8rPmrvVgjdx6qqV/q3KlFvpv
 aqqQXIsMFVsnvtyIT8C0AZrghTmMYqmjIzqWyd7UBJ4aOLMk2UTO0L3n83TJncp9SLAr
 AjEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0QbYyI/MfKiMFBujFsexcXDpGLqsDZ968dI/CrsqjV052X/1sKwG50SJx2zpcpLd6oRD832pLyRPj@nongnu.org
X-Gm-Message-State: AOJu0YyMTot0ElhSimgzXzJ4jYZCNoyJdKEeUpE886hXpHLsQv/d4myB
 Zcs2/DYAX1jmFxbt3D7eeA0qarW3w9Jk+teEu0c/qwMkbBauVYfLyh6vCmikTBg=
X-Gm-Gg: ASbGnctD26/0TLk5yG09RN+u2FTlTcrk7VYVEd24bWcwUNiRqT2Exbx7jJzmrchOZUk
 MW8BASQxIeNb6XO+k/6f77vXilHguLjdGZQoTzaSZQlB+I9wEiCSk/pYFgw78xaTrU50RDOxliO
 z8tqwjaT/pPMBOZhVAA7TX1H13o/+lKGsoQEQJ6sUygu9RGfir8674um5u+rrMe4Ur/Vo3eOMHJ
 T+9XOXgGrJK8TcT8Gv8W7QGuGL7ru8bc7IIeuWisCG8Jt1SrKUFS86IL55Y66LLfA8Kk8VpSWie
 mVw48M62VX2zZ6kwliSqrBsHundfCnhwjzyZrBqOam+FWLF8TXndV9AK+sA=
X-Google-Smtp-Source: AGHT+IGmfuE34/iS7t/ABilOONPgh204qTrBC5hThmK7Epdqbo9BO6wPS9yuRfYvPmiHjsHNMN5woA==
X-Received: by 2002:a05:6000:1862:b0:38c:5d42:1528 with SMTP id
 ffacd0b85a97d-38c5d4218cemr3425899f8f.40.1738274081479; 
 Thu, 30 Jan 2025 13:54:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf560sm2994173f8f.89.2025.01.30.13.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:54:40 -0800 (PST)
Message-ID: <883592af-e85a-4140-b728-1380b764ce28@linaro.org>
Date: Thu, 30 Jan 2025 22:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/usb/hcd-ehci: Fix debug printf format string
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20250124124713.64F8C4E6031@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124124713.64F8C4E6031@zero.eik.bme.hu>
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

On 24/1/25 13:47, BALATON Zoltan wrote:
> The variable is uint64_t so needs %PRIu64 instead of %d.
> 
> Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v3: Fixed commit message to match what the patch actually does
> 
>   hw/usb/hcd-ehci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Patch queued, thanks.

