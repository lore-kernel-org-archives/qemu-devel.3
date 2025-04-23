Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF5AC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WRX-0001M0-5H; Wed, 23 Apr 2025 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WRP-0001Gv-E0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:30:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WRM-0007KB-Bu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:30:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso5995521f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400646; x=1746005446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KHbPwA2HazptBArc/9hBXD+xDFanJgELaAjaI01g+is=;
 b=n/hJyAxhuvEIxSzBO0qxZ2h9HdQawcOTbvv1eyMz68sykV+QtudSCo3E1mMIYmCslb
 1BKgC2B6W7u/nQ/oOApBYhgqQGXS2crLZVxjyvgrqqyGis80mYukuxcB1mKFdp5qbrS9
 9v4ElwKqHqHqJmCPuovMQL8w55uBGEIb56/Wm6YVi6qDQHlMNljJ48ZehbohXdN2gNqt
 hSJdND8XdmauqY1oQPoBanK4MHdPM54GsUvPCaCDeTIHSisJsTwKnNDngeFmZBOe6WDd
 MniGv4qQurvj4vLWE7F2vHmcWPqyra3nfRUGZHlOzskrOr5Ck9R0vnUR1DBVIiVN1WE4
 J0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400646; x=1746005446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KHbPwA2HazptBArc/9hBXD+xDFanJgELaAjaI01g+is=;
 b=AEnTJZn7ADiXDyAmDLmCqjNxwFxOntZXIoQr9nA6/o1KsZzkvomajFl6h25xyiYXHX
 /2ok8GnwL8/EpZMywuGTDyJTj+bAqpHtBZe7EllHfyFYcsKV/qI/ldakIEKtTkv9wnsl
 e46EdoTrc09dEI3Cj68tEEYZdmXKfRJNIYIRCZixmCEBdEqVgyPVMFbnYrmXRgl9qrNJ
 Aaet00HNqFz8OMj7ln/kVDHFmm+JThymodAATLqKxwEdUArr6DuYETioyvjSoBN1mEim
 aWXZFO6YWEyxHXFZZjmCbWOjtdd7IeJ3b7dE4/nRGBcaZw6NFb5xtp0JvXIJL8r/jrGs
 qOvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVerk+fniBK8oA0RGdLSKur2rOWhrO5Ne1FIk1sYeK9w/gsfqCc1fYFb+7NXdAMKbNwGIqxvDozxnBe@nongnu.org
X-Gm-Message-State: AOJu0YyXpujgHW5J4zzSjICy0qUPkCWeIYlB/dDIrv3EtupSxvyK0x3K
 NXP6P63pSuOKEKAPCIbvnssc1TzRvjpzrcDvpsmGK/kipK4g9lsMUhG0wjKhjTw=
X-Gm-Gg: ASbGncvJ3ql5HhRE/q5mWQIH+J0IhcUf9iC35Ndu1cfdgK5e2n0VDjTSeicPZIpSf7U
 k8ea9Zzu1UlFJ/cXlFyYJgJuhQ95WwX58zTCOrrewcvaedZWyr6CSoCMw9Erj7aYVg5z7a059Dv
 HxxvFIMRBWV6J2v5bf9JGYbIcg0vVPcB07DlkKiP23sXXu7Xa3sivLaUg3RpB4Emr53iOwFp6nL
 WQle3jbz4TVkpNHBihbwH9nCIwH0Q9qfkZllu1xR917JFnh2anN+vkFcOUJFrOlzyaR+IRXuCJS
 NRYalRgWit6WoyciUbtonKZcX6jFRsJrO4uzjfSAmcqBpQNvyAFqdcXLjPyojujOC0+//zTyWMN
 ehHb592ka
X-Google-Smtp-Source: AGHT+IEMGlY+owEcLbuFchLzyziBPoly4xN7FjtAGISFBFKraEdt68P6BALbyfXz3BF6q1R5/xEudw==
X-Received: by 2002:a5d:5f4c:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-39efbaf263amr14489853f8f.49.1745400645816; 
 Wed, 23 Apr 2025 02:30:45 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433191sm18411174f8f.31.2025.04.23.02.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:30:45 -0700 (PDT)
Message-ID: <68189f65-7c94-447e-b34c-cd4a3fad9282@linaro.org>
Date: Wed, 23 Apr 2025 11:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 031/147] accel/tcg: Implement translator_ld*_end
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-32-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Add a new family of translator load functions which take
> an absolute endianness value in the form of MO_BE/MO_LE.
> Expand the other translator_ld* functions on top of this.
> Remove exec/tswap.h from translator.c.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 49 ++++++++++++++++++++++++---------------
>   accel/tcg/translator.c    | 26 +++++++++++++++------
>   2 files changed, 49 insertions(+), 26 deletions(-)

Great!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


