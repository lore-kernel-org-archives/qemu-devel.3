Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCBDC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 19:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdx5L-00053A-Ty; Fri, 31 Jan 2025 14:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tdx5E-00052U-Vc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 14:53:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tdx5C-0000bw-6i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 14:53:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2167141dfa1so43112575ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738353219; x=1738958019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdYBFyRouL2xy1wdUJEHzSeaf3oPgWsNnALcwGimA7o=;
 b=TtaM6VBBL+o23lWy/eIKkAlqEg0fUZeC3WAoSN4DMGUSii5umLZW7AsctMsIsLDjIp
 Hv3AARXB1wlhby964dkYLp+wDrrEEWWJz4gHZ55GTsxyKN1UaTHHXHHZtwTG0w72Rqyf
 q+qrGA6esJ+O+L5W4tWMxSobIwRbUT10205au9R5OQZTH7pRTy92rVYsQAyNBavSSxZb
 2JesKYQIlkHs8uMtGwR6u4zDgk15QGjlNor6r9axWaRwKFO5tto4T9UybBL5cwTadANy
 rW+o35GablJIAcpP2g4BKWHigDiM4C4dlLoGucHIlUm3M+QM0C/4V/xdPNabYqbfykNr
 1SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738353219; x=1738958019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KdYBFyRouL2xy1wdUJEHzSeaf3oPgWsNnALcwGimA7o=;
 b=lW4RUjXNYK5wFKit88P4FI2BmDFQ8RZuIubH+QxEcP3Bo/7yUgQ1NZCSAoqTNi99Fg
 9onGzC/3uTcR82Na7yc/vT+Y0Su4t5h4WpANVlxJ8trqwOHFW8yJqQ2RNCmO0roMAVeV
 tQyrHwys6uL8eguz1xQOiMig+FYx4T+Wj7TuRb4nVoccMUvP65FS0ERwT9R+UgXOMzHW
 GKn0ibmL9YqYtTNwx1JIO5dwCDx4QFO0FeWZ7YzGZ2NSM5gcc/ZRQme7pm8RUwqyuYPp
 Cjo8NtTApWomCTVy8GgT2iME7Bm8d2l+JsZcRvu3Z/ttFi9/t69mvtx2pmDP3Fmt6i8t
 nXdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqSbMS6se/M4XTyQ6gSUC/vKy7GJJkgl8ZjEfvWNkscvIphDKn+oLgFYcO5UpDc9jbfhfN7zcNCzC@nongnu.org
X-Gm-Message-State: AOJu0YyYdxcsRiMl/2YqZgk1nj5w/C3toIi860OKekAiES6rkvAMiXdz
 SFQAedJBXEntfebY0tEKyyvhaMw0MwqZVu4Tme1J/mGHlmJ0eYWUTFwPgmxMhak=
X-Gm-Gg: ASbGnctYTiFRW7V7hn7iOvN9SLs9YcoCgkddRkq4feOHHf/bmqEB4o70+l1VLsfjctC
 IllmPhJhzMK7PD7+cyGChcl1zBlJjM4qBUwiR97d1rcMN3jSGdOwQHdf/Xv1McR1yzw9lOCmr3T
 WwRyyYl54+FgmTETu7x3DlkYYbrE6YNORFcpqcwOavPLHeZcQELOjxiU7zgbAXo7yhuJBqKC9qY
 5hgInCk74MKyyktU7YEWyWKRBHvQF+3Xue8sQvScyPMoYC33NwqFwnZQgy7hGDHmCrp9UifBmg/
 FNBzm/HGMbB9vR4HszJ4oYXGIdHa
X-Google-Smtp-Source: AGHT+IGeCHSsNbrMcT+uBCMqBrDxPgw0On3VhyzfAzTA/KXu9UD9bLf2WjzUU6M4Nn4EzPEmapdgCw==
X-Received: by 2002:a17:903:120a:b0:216:3f6e:fabd with SMTP id
 d9443c01a7336-21edd7eafccmr62880435ad.7.1738353218640; 
 Fri, 31 Jan 2025 11:53:38 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de31ee042sm33879025ad.22.2025.01.31.11.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 11:53:38 -0800 (PST)
Message-ID: <1f2ceb5a-e40f-42c3-beb2-e3839e0229fd@linaro.org>
Date: Fri, 31 Jan 2025 11:53:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] plugins: add tb convenience functions
To: Luke Craig <lacraig3@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250131175716.3218600-1-lacraig3@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250131175716.3218600-1-lacraig3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Luke,

On 1/31/25 09:57, Luke Craig wrote:
> This PR extends the plugin API with two functions which allow convenient access around tbs.
> 
> The first, qemu_plugin_tb_size, provides a mechanism for determining the total size of a translation block.
> 
> The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a reference to an instruction by its virtual address rather than just its index.
> 
> In response to feedback from Pierrick I have updated the implementation of qemu_plugin_tb_size.
> 
> Additionally, I have added these functions to the insn.c test plugin in response to Alex's feedback.
> 
> Lastly, I'll provide a reply to Alex's feeback (repeated below):
> 
>> But the general comment is this is an example of tying the plugin API
>> too deeply with the internals of the translator. Why does a plugin need
>> to know what is an implementation detail?
> 
> Finding the line between implementation detail and relevant to plugins is challenging, but I submitted this change because I found myself implementing these functions in plugins. If you'd like for me to enumerate examples where knowing the tb_size is relevant to analysis I'd be happy to submit some.
> 
> Luke Craig (3):
>    plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
>    plugin: extend API with qemu_plugin_tb_size
>    plugins: extend insn test for new convenience functions
> 

For all the series,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

>   include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
>   plugins/api.c              | 20 ++++++++++++++++++++
>   tests/tcg/plugins/insn.c   | 10 ++++++++++
>   3 files changed, 51 insertions(+)
> 

To accept this series, commits should be signed off [1].
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

Thanks,
Pierrick

