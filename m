Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28757C021A1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 15:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spUZn-0007RI-6K; Sat, 14 Sep 2024 11:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spUZf-0007QD-5S
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 11:20:36 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spUZd-00025E-5f
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 11:20:34 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-206aee40676so15136815ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726327231; x=1726932031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B9zd8/Fmj7kzTO+YWpanBR2/pemqo1awmt5Ke9BQeBI=;
 b=M3NwZcPBZ+PCT+2uEqIVL+Vu3CCF1dDalUKZeHBm0oI9y6DVWv2E6zokKbAGIo30MK
 PsAA+KBiTntzcoZW7OvPGbeSRswmD8jIKdvKpPVsiSs74saIR1VvoA+FPa7yZdfkACwf
 3MI1TTAPGD3aGTx2T8kwbMSQtJvvtFJUDws0Rfasx6FkoYJ666XCCNssNjtpX3WWBmr3
 WHDNGy4Q/aJLBW97CDprPmN9bxpzFlEXRhVqvCugMYJchAbtH96trnzLdnP2fEq47Rdl
 AShZiYskAmOTOFYJg1IT3xjuNEo+DwXyuZext6t5Q/SxwyT65AR0rnH88xyV/HtheUQE
 SuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726327231; x=1726932031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9zd8/Fmj7kzTO+YWpanBR2/pemqo1awmt5Ke9BQeBI=;
 b=f+r0OusgHehvduSwrmLhFVytdNZtiqweKqE4gQzaCf7MgbQkEzEJNwrmiX3GfdD6lC
 3nyaRr/rsA5elVE2gJAB384tdvFkqGGiUfOAMCZUOjxiym5g0vXFlqwPyF1bvMxC/Wn4
 viwZRltCvQcQXE5Dd47O8j+ptwJj5jz5qM2K/xi2feRTj44PKl76qw1OwKQXPiCfiaTN
 nZn1rGoWlyc7DDahh/h+WAqS/OLQFnykI+YUovePf6F1y60IdXtvdhn8G+FS/N1SIU8I
 ad4sSJXZNGsoUBLjiBWwtt2w8z6H5T1SSANmp4LdxgIx9oQxufnVCPo+/JxZYBGzmyvR
 SVoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLnxFiC8AkR1FttMEyVj04tiHVJLdAFZO23phY0OR/OTulF9+uqV+igo4sSmS+ZSctQ+7iFAtBXGb@nongnu.org
X-Gm-Message-State: AOJu0YyZLE4NdeKj1Sl1Gf93gdUAPyea+E4vmnqI7xs6hExIT3LkV76B
 GAarMLyOA+MoMy9MpiXhRqOalZj0y4mItt8oxJ8wmzXeZG+W/qTOncGT2QVr7/c=
X-Google-Smtp-Source: AGHT+IG9Ge8VCVfcOlICkpEeHa3PiKh+2cuLR+vxZUSQLBk1Q+v2b6rGTbDHqNEeCeIs4hWO/2uIWQ==
X-Received: by 2002:a17:902:ea09:b0:205:88bf:bfe9 with SMTP id
 d9443c01a7336-2078284bf3dmr101373695ad.15.1726327231065; 
 Sat, 14 Sep 2024 08:20:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079470f38csm10542255ad.205.2024.09.14.08.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 08:20:30 -0700 (PDT)
Message-ID: <86858aa5-8bdd-4bdc-8a4d-6db9e314d794@linaro.org>
Date: Sat, 14 Sep 2024 08:20:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] contrib/plugins: avoid hanging program
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Elisha Hollander <just4now666666@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240913173807.189747-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240913173807.189747-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/13/24 10:38, Alex Bennée wrote:
> Although we asks for instructions per second we work in quanta and
> that cannot be 0. Fail to load the plugin instead and report the
> minimum IPS we can handle.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Reported-by: Elisha Hollander<just4now666666@gmail.com>
> ---
>   contrib/plugins/ips.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

