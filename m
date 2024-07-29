Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B09EC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQYD-0005M6-Ag; Mon, 29 Jul 2024 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQYC-0005H5-00
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:36:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQYA-0004kK-AV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:36:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368526b1333so1005478f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722260188; x=1722864988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z8QTTPQAwBjqMzCNXb4DUOkXaRUpE4z8fG5XuT5aCQQ=;
 b=Pkx8+4qJBkMIxBSVNvC7x8pLztn9v7WELjjQDfmx5UK3iUDNCYpma6aa35QO7p/Pmd
 Hxav+oKiNyxqKfqUjp7BKWQeQzHLCA940LTKXT+eZe4MumN2DvUgA51tqkXwyfqFXD3J
 aoh4gh1aEoi/Uj4Jx6XR0LLAV6iFiIGIARiBALLIFEj8CHWLnol3W/1x/EBA3M3OZoot
 2iAfLoGfkjJ6G47ltZQJP5bmMMfxhkMpu58NbdzLCy7b934G3ujSQfjQB0lJpk9PscB0
 PmDTsNXvlf6csoYjUCZLW1zodt34f6P2I8EUMQq0PAHYiMSBJwzlAy3WtNAq/vnoAqdv
 VLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722260188; x=1722864988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z8QTTPQAwBjqMzCNXb4DUOkXaRUpE4z8fG5XuT5aCQQ=;
 b=wG5z6fmRyh6w0cmY4MFxFHBFEZ6D85H2vVfNoiS7hDpRLkjWsH/zd8O3QDrvT6qs7E
 aT6hVzNVuGH6wEr4X4JpRtJy/rTUeFyrXnOjRxk1DT8ApRHc4ynwqiDCN7bN42L/lHR1
 rC7/vQghVvmw0pdwMHi9Y+1z+6y6eYqudZFlReg8zSvOYmqmdI9/8UwkeqB6ceeT+//m
 vop7vvvvWg0M9WNK2CQrXXmBy8fcnNNZU1FlWFWDReaZuyQL2TxMUnhIpll4CtWz4EKK
 pN9iskA3z9793RyRZCam5nc6AIIqfdl+GWFxcpsfaXeEcpDNghATWRDtnXnNNM3TbA1o
 VuAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9kOSBupwOs/JQBv6u7zF80ftPmdbcLt1dBzs+AfZpF06JApKNynwCAzX7CSVf3qU2MmCcsw7eGSvguXSdJEA6oJ4Bxcw=
X-Gm-Message-State: AOJu0Yw8md3ouSTlR055C9KTkyIPA6XCB9XxarbG2UHvDFrQ2G4+JGU1
 9pYOaFViqKps+HrdKKhszEsE/flNE8TTHjkGj7TGZCnOnFyYttTOELM+qzHBx+Q=
X-Google-Smtp-Source: AGHT+IHG26cCLhianZaKRvS/mQLsB3rHXNVmWkqOYhON0irp/Td7P4C7tDr5/lBY/5/2sb7lqDJZqg==
X-Received: by 2002:a5d:5710:0:b0:36b:33eb:f0d6 with SMTP id
 ffacd0b85a97d-36b5d7beea6mr5704915f8f.2.1722260188134; 
 Mon, 29 Jul 2024 06:36:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857dc2sm12219412f8f.77.2024.07.29.06.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 06:36:27 -0700 (PDT)
Message-ID: <735c512e-32e3-42cd-916f-d2b1fe3f0794@linaro.org>
Date: Mon, 29 Jul 2024 15:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/sphinx/depfile.py: Handle env.doc2path() returning a
 Path not a str
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20240729120533.2486427-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240729120533.2486427-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 29/7/24 14:05, Peter Maydell wrote:
> In newer versions of Sphinx the env.doc2path() API is going to change
> to return a Path object rather than a str. This was originally visible
> in Sphinx 8.0.0rc1, but has been rolled back for the final 8.0.0
> release. However it will probably emit a deprecation warning and is
> likely to change for good in 9.0:
>    https://github.com/sphinx-doc/sphinx/issues/12686
> 
> Our use in depfile.py assumes a str, and if it is passed a Path
> it will fall over:
>   Handler <function write_depfile at 0x77a1775ff560> for event 'build-finished' threw an exception (exception: unsupported operand type(s) for +: 'PosixPath' and 'str')
> 
> Wrapping the env.doc2path() call in str() will coerce a Path object
> to the str we expect, and have no effect in older Sphinx versions
> that do return a str.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2458
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/sphinx/depfile.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


