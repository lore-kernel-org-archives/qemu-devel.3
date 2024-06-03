Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF297C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5jh-0007SB-23; Mon, 03 Jun 2024 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5jf-0007ON-1c
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:20:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5jb-00078l-7U
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:20:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a3d21299aso2970261a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717413610; x=1718018410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3PrsjsdSdVSRCiA/1fQoIFNQW5VnBHf/05Ib5C8jLN0=;
 b=QUxUsPCMzisoE1tod3ZV2vrmyYUacwdoONRHfY7HY4TKa3VaeS2r25NoZPAYPCN2b1
 srqWQWwLCQjY19//bKdishXqorCpqGma2SLN35lX2NvYSJ149kbuCm4SAthmy/cB3rmQ
 EqL2wcKv66WGtQKsVnaZaINWeHN9QKyrmenYROwcWVyZ/IW5NrBOXUT2w14D4q0yrTHj
 PP9kOo7hN1V/W6nzjtxsxw0Pu8PCghCF+lBDkETcc87bcxPIvLLtDHTNZQ03pXmw6D4z
 XMXFW8W2TjzzQNP669Chyah01Jd3oKywj9fhh88Z6cZXyMPLgvm3vmnzp3Dv3UuoU2QF
 ePCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413610; x=1718018410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3PrsjsdSdVSRCiA/1fQoIFNQW5VnBHf/05Ib5C8jLN0=;
 b=WfuHw9VdMU3MPqsP7hNipaqQKOFVU4FMfNI8QnBjqm20Ma/4MzwVq1WnScVuWzhm4E
 vFreigLlvtyJCizZceETHFZAxeTzRLnd0saIC9l7fheKhwo+/xX1yOLu6XtcGXsvirRG
 fzy9wHP8Pnt7EuBIyUMakoSKZdLjAF/rWHIzQGNlxmokA0DYy05eHcFOrn8BplBNsIVx
 FJ3/OA8uzsKrR+lLA5cg6aXe+GzN12s/OSlav5ke2BBPi83LT4s8Pluta8mUnzGYQwIa
 evTHC608OXu6+I0GZD6sTPl2y7i3wle3p97jOqG8WPUTtbkU5XRNtkWppP9Cbq+JUAUq
 dCtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpO8uNUeDJiYKj2HR5gfuaQEreRNpXMUDU6BKcn7HpSWXE/sbdXENk9JuODGyvVlhWSUIKlL3ptOSNm1qQbld05Uma1c=
X-Gm-Message-State: AOJu0YzVSsU3Bfo6mRS4qzrtfw3Ee/Xwaa1wILnd0FWvpe2jx3m60L9i
 oIzbp3yeiTaeqHegj6LChFBXGxb8J6GRldIi+ci9/qAvoIiJr+SkfVKqxVCt4NF3DcqL1eqN0FC
 L
X-Google-Smtp-Source: AGHT+IHDu/9PfDR8gxHXeBTYjPlLPDXsMNWGhmWTzmZvyJs8zrYcHwnE4MFZ8xOhI9u529VY3Zycpw==
X-Received: by 2002:a50:d582:0:b0:57a:2ccb:b3f1 with SMTP id
 4fb4d7f45d1cf-57a36448228mr5272559a12.26.1717413610000; 
 Mon, 03 Jun 2024 04:20:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31be5695sm5230292a12.55.2024.06.03.04.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:20:09 -0700 (PDT)
Message-ID: <1cb7361a-1111-4728-bc65-81e7b328ff0e@linaro.org>
Date: Mon, 3 Jun 2024 13:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/lcitool: Install mingw-w64-tools for the
 Windows cross-builds
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
 <20240601070543.37786-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240601070543.37786-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/6/24 09:05, Thomas Huth wrote:
> Beside g++ we also need the mingw-w64-tools for properly building
> the code in qga/vss-win32/ , so let's install that package now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/lcitool/projects/qemu-win-installer.yml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



