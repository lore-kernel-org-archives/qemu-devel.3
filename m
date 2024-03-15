Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF09C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 05:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0OG-0004Iq-DY; Fri, 15 Mar 2024 01:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0OD-0004Ih-On
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:45:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0OC-0003zx-7N
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:45:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-414025406d7so392005e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481555; x=1711086355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDiaNKn/1v+4eJhIA9QQP4rzopEiqrmUBb2wpsBjuoc=;
 b=Q6+rhl6P1WEFBD2khVS05PH+gNqJ4MJUHig66H2E7Gtx2kNkza0l3f0VOI5u42PIUc
 5kVADpRsu7K0UPq7MBEXXeHVBBrBKtQvj57iLkne3yTts9BSyJkxZ2ASctTzSlal9GmC
 iLsN7lqbPzzVEYuhgcsJyscEJQxjyK/dxeXSNrVzKq8xIdN6GnwKu0JkyztH/zzkrgWr
 5cqFK8O76Z17wEPpAAdoZ9PzCI5lI1dt+2DYibNV++eUpTQSwvQX9qdUmVzJR3J/5CQw
 Z5gmd5vraxyFLjCucW2ngiE7mqfWdp52ddVM/cyz7jbWCsb+zjaNYg6PHZc+yMSSpRON
 LXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481555; x=1711086355;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDiaNKn/1v+4eJhIA9QQP4rzopEiqrmUBb2wpsBjuoc=;
 b=jObnsa2ONWpG+j4n2aaZeESfuNAt00UvDBTzRj9KmAzjRsivU8ABexeb+RbKeE/PPB
 5FbblhdSktrhmnTq5yjNapftbytbU7JtSS3veZhfEmVXVd3K5cVfn9z+OGByB4LUJAkr
 m7FzmzTEKEVP+fgAYeAaoHjF7tgRaKOhx0LfYps24FVI7ImHICh3a41+o2W4AIk0d2x+
 RFgq1DcgysbOMEgurwrSZfs6d8+3g73IbId4QMbdHcBu6SnpmQGjYlnvjzXw5MB0gLum
 KcIq+zIPAuAH6OXBOJelOM8ZySTgj4iRCPUdmOay0i6RDgSmf1NTitYHijrs+lZ3q1m2
 w1oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9SlgvKw5jCtGGj7S3LftMCfOD9A7NBydmwBO12hEyV1haynPfg4WAQvpYqhT7GF7vFIAGUL3lAbe94fAf2WheisEooVA=
X-Gm-Message-State: AOJu0YwFfseqnGJ3Itfb1000Ppc28LHPNR5gPH+EDSsvBuixM87FZadB
 dafpW5B4owPlgcMbi+lNZbybpBBkmVgE/IclhwLykIKKYn+TXtIEZgZKOVTkWYE=
X-Google-Smtp-Source: AGHT+IGS4rDNjZ447IDQHvouhqU3doumckvluqg5XctR6yzc/FZd/yNPFd6YvCBzorMzpeXTJ3K0rw==
X-Received: by 2002:a05:600c:5129:b0:413:1bbc:b25f with SMTP id
 o41-20020a05600c512900b004131bbcb25fmr2893311wms.25.1710481554737; 
 Thu, 14 Mar 2024 22:45:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.77])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c310600b00413294ddb72sm4535083wmo.20.2024.03.14.22.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 22:45:54 -0700 (PDT)
Message-ID: <1f41406f-0508-414a-b42d-fe32ce821198@linaro.org>
Date: Fri, 15 Mar 2024 06:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] roms/efi: clean up edk2 build config
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20240314115307.628118-1-kraxel@redhat.com>
 <20240314115307.628118-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240314115307.628118-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/3/24 12:52, Gerd Hoffmann wrote:
> Needed to avoid stale toolchain configurations breaking firmware builds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/Makefile | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



