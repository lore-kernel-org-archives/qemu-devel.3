Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B22CC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV5e-00026R-9z; Tue, 20 Feb 2024 13:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcV5c-00026H-GV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:43:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcV5a-0007SB-Py
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:43:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41271fb0087so3557435e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708454611; x=1709059411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbehfVHdw2Ee47vLoUTmO+Phn2Qzg2OeKaNviVgsX9U=;
 b=GH7bwKbUdq37Bnsq3P2wF3YqL/FeaWhJA/FDk1o4eF/Wt5ARwBxuEZthS/ul0//wdy
 9c2Q9q2ogGTk8ZvNmPY/uqKV8B9A7AFIRCVl/skIHqbJ0QLzmrEytwKh9vKZWvGmUpZ6
 jsaj6jkl1fiVVmqzOyZPnCp9QtyGN6D/EHDRYMkmEruzY1Q5EsrsWAG2ppPyaJ5emxKK
 PhHV/d3bKVXKKm1FLL7PzXiWOGldTa0lL/VRJuq7bkRDvNK4qlmsu/AwLoZfklKdrdys
 nTeie0598S5nH8hgWrgZ7GxIoLLQfbAqoV4Uzydt0oqi4lc7bj8zcTojquIUppNFt8p7
 FTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708454611; x=1709059411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbehfVHdw2Ee47vLoUTmO+Phn2Qzg2OeKaNviVgsX9U=;
 b=TkBED4d2SGCW2UDr8L1L1U0lbYz122iZP8HLvLodWCRh3tfqeYYz1cy/pQjiQmIEsC
 tzAKGk6PMh5UNC422kTZ4aROHqWgcXtatfUg1PFas5u5703maJt68mkNyFM22DVtMr06
 dcCw0l9nqNFLNolo+2dwDUXyCR55LAL8Bl1LcnTZyCCLKJEbJ03t6Vb9Qt5pVfUqqu6a
 C0TAE7giZalaUI4afhv38zoH8JGYroesu4P2WG//8T6UoRP4YY5CyzQm4Yxdr75eYEQ8
 DOu2SkPMK3+H11iCZ8LpZY0Zkl63X7GN8eyKckgaDeEWlRCaLo4YGLzFxVvQkyCo26/E
 c9Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkXfGjmZ8kLdLZCA6OaIF/6ha3qFlb/2J/VenHpP4QnP+QzcFrFUTrU2TcSVfdQamTdneM6i4nEQA+u9QyZp7D85g6sLg=
X-Gm-Message-State: AOJu0YzZaBzi6NGYUyLG5O5pmc0aVar8BW8ugn4eS+n18vmTYPRE/VEW
 HU774HC7XyXxTE3X0oMW7/ssPpSTEziax2TGCWfECmYdtoN3Q3cyfqZOAPUqXyI=
X-Google-Smtp-Source: AGHT+IEclWuRF7FiH3RwkUQUb1F7HDeew337+j9bNqCJnpkGQAUfsB55boX4uLygBNJ1Hw+iX0YMeA==
X-Received: by 2002:a05:600c:4e4b:b0:412:719d:443f with SMTP id
 e11-20020a05600c4e4b00b00412719d443fmr897124wmq.16.1708454611500; 
 Tue, 20 Feb 2024 10:43:31 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 bq28-20020a5d5a1c000000b0033d73e1505bsm810111wrb.18.2024.02.20.10.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:43:30 -0800 (PST)
Message-ID: <af1b6d64-eaaf-472d-94de-5f900eccf834@linaro.org>
Date: Tue, 20 Feb 2024 19:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu-web] _download/windows.md: Drop 32-bit Windows support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240220180618.158100-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220180618.158100-1-peter.maydell@linaro.org>
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

On 20/2/24 19:06, Peter Maydell wrote:
> 32-bit Windows is no longer a supported platform for QEMU, and both
> MSYS2 and Stefan Weil have stopped building 32-bit packages of it.
> Remove the no-longer-working i686 pacman rune, and state explicitly
> that 32 bit Windows isn't supported.
> 
> Fix a grammar nit in the page while we're here.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   _download/windows.md | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


