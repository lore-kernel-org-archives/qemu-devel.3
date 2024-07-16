Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3F9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkU8-0003km-4H; Tue, 16 Jul 2024 11:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTkU6-0003kB-Kl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:52:58 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTkU4-0006yV-TI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:52:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so3369947a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721145175; x=1721749975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tWemBXWXVjRcxVzObgD+Nq7WEMm70YkS/FhSYsC1NnE=;
 b=UzDLllzemlf/GdlGlb+spndvn8Duvh0KFApdhoOVI0AZGnVMCTsLxrdKatsMjf0Klj
 QAmHstU9ov9zxNcirzWEniYB48f68QoMj/SBGV6rd9/LD6tbOYKRY3VJqatrzRMCMOhl
 cS2AFp6++IC0uaj/CUDKyGGAnEMPEnR067AO56/73IMlTW0lsruzTktMLTfS+ZQ4zZ5p
 7ra/xD/dG0wbpVEAeUyU2RLUNldU66Tu0egUazqnhqXq+2cuZPScQOBRtBMwAdK3VJLK
 aKHoNUgCp/a9QSw5Tyug+CzflS0FzDSVHEHcsWY4wqMe9xxxPz1EGe3L/QTyLfOBg/4F
 dQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721145175; x=1721749975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tWemBXWXVjRcxVzObgD+Nq7WEMm70YkS/FhSYsC1NnE=;
 b=B8jVVIFwJyw0RjOq5gEauF70I3CqP93LLxKQychcZpZP1CUXJIq0a6Ybf4J1aqKQtZ
 VndCFwsnb0T50JlsKHGVuWp+unrnn+jHTbJ9W/jfpTkdGFA6U488NHorCeIIDchmwfVQ
 tiLqKKZ0AzL4eYpCD6sPtqFzrcsqLyHh/2ZyemJU9+dfbmRdCubijJg2bjbndIPcZawH
 WQtZrk0d89Srrx+HbUHkei5R4/KnbdXacrmEreNLVLCtkfvWr7QsGP38UrDLDyG65/F1
 MJ6yzAgaXgBdBez16Ih6jPyuWG9Bm+UYwsrHEh3pi4/FiaNXPNBjaCu94ot6CkRbV6F8
 Whtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeso9DrrsNzag1roqtRLGqlYxIfkH4DYEFIxn+ZhzuTCnmW06w/WgPv50PTEoVSAq6qp2H5kPz4w68VpWaKXxc2/gbzOk=
X-Gm-Message-State: AOJu0Yzx0aNQumHU3mtIgcGFWytFJl0QyvTa3Wkr2R+83oERvI+aNZO0
 vRBM0fG9vJqclY6mdEAy+3gAtGSR72QLUCEsvZVGMlKBJFNwuW0BsGayOyo6sJs=
X-Google-Smtp-Source: AGHT+IHWINcOYoe/qK+Rlr4iyIznHjUHHXGrtlTRiTB1QYI6ZMUi0tZBo4yRE/3rsb+Y05CQ4WzgGQ==
X-Received: by 2002:a05:6a20:258f:b0:1c3:ba3d:3ec3 with SMTP id
 adf61e73a8af0-1c3f1275361mr3552182637.36.1721145174943; 
 Tue, 16 Jul 2024 08:52:54 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc3834dsm60132795ad.206.2024.07.16.08.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 08:52:54 -0700 (PDT)
Message-ID: <9eab74ef-5aa4-4bc7-9af8-061eae7625c3@linaro.org>
Date: Wed, 17 Jul 2024 01:52:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240716144006.6571-1-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240716144006.6571-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/17/24 00:39, Clément Léger wrote:
> +                    /* Restrict the range as we found fds matching start/end */
> +                    if (i == skip_start)
> +                        skip_start++;
> +                    else if (i == skip_end)
> +                        skip_end--;

Need braces.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



r~

