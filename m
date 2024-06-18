Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8ADC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhwO-0005bj-4h; Tue, 18 Jun 2024 19:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhwJ-0005aZ-3H
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:08:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhwH-0004fV-Aw
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:08:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-705bf368037so5446627b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718752112; x=1719356912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N50xs6gIuQCSjnPj2tCFC7wcSMaD5Y/VcjVvgK5fhfo=;
 b=CrPsFSZhvsABqqYTgsZHAkYLpiY1m3bO/rXlK5A5i7regF8kAlwx8uasLfgzDlHZcv
 JaXAj1C7wQG2/DwIZp//EYZSsTPeSGJZBhC7y9WQQGci/MFrZv3wX+Vag75TSijOn2Zp
 cbOeZFIt+NtfGK+e6t4puRaasreMDf3kP+2hE65RIQVHt3gLohz4YmAJqO8S4p4dzb7L
 BuGKbR5RvNDwuCWW8i6aoXgjYXpO92M9GhKBN3Piym83FOgjJntOn8y5hTzSkO/ifpOK
 QCpSxe4ZHDZYftFQWxbsE9oi+wYALYXOImUUBBDZKFpM8snXqX7ecM8zF1iT6A5+2I0Y
 YAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718752112; x=1719356912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N50xs6gIuQCSjnPj2tCFC7wcSMaD5Y/VcjVvgK5fhfo=;
 b=T3KizeqsmwJr9KgGMym9Nhr+XG3dz9n5Pw1g4WXVJeRCnlxE55iY3plmkXHOxm1VH5
 +Cfm2fNEOf79fd9h08RnWEAfHA+Rf3PqSVr17j82ioEhai+MLahMBaCe7Mnd3onUyDeG
 QBNZro1mzy4rGhInG70dY6l9N4cbsAHQUeA3koMBf3TU+7x65kiqgikWHLiE/cdGKGDi
 0fxtlI+G862+C4tMVcwfSY5qANfLNl2FxhZucEq5UFxp9Mzk/tC8gP/IzhMxCVa66gMt
 yaJyHF4pK8appgTgWWsvwx6m2Hjo5iW5Vh4SHRgsYvMvT2EvJsWupOT55rIwHwQwUaFd
 jsvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5TvNNBPz+LVSCV98tp74l9lu0ds4cv+5boGTdAX9h/VgYaC97Wp/2mWFQ/vBpf5SKdX/uy0WjkRLFYaMKetMSOc0+kak=
X-Gm-Message-State: AOJu0YyOrNKiVLTlXvno2PCAqi6mwH9p7bllgwxBbN47ydULBnmycLME
 nNNX/3yuHC0yq29P204WvLCVUuHZHlVVtRppNAp00R+QUL9IstUqDsNJP5Jda4fdmpt/XazAvBk
 0
X-Google-Smtp-Source: AGHT+IEoN1H9VEtww0gR+QGEevwdjqMEuB0I8DCYr/6AZ7LePU0IIVQUHTl4wiul8ls4FDKZyjOigQ==
X-Received: by 2002:a05:6a20:6c93:b0:1b1:c77f:56c3 with SMTP id
 adf61e73a8af0-1bcbb3a5d7amr949084637.7.1718752111524; 
 Tue, 18 Jun 2024 16:08:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb71715sm9794312b3a.175.2024.06.18.16.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:08:31 -0700 (PDT)
Message-ID: <516012e2-fc55-44cc-84ca-305e4e866b1a@linaro.org>
Date: Tue, 18 Jun 2024 16:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] include/exec: add missing include guard comment
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612153508.1532940-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/12/24 08:35, Alex Bennée wrote:
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/exec/gdbstub.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

