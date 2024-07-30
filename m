Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A99C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYn5U-0007Xk-Qk; Tue, 30 Jul 2024 09:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYn4t-0007H8-La
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:39:53 -0400
Received: from [2607:f8b0:4864:20::72c] (helo=mail-qk1-x72c.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYn4Q-0006UP-Sq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:39:40 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1d066a5daso314053885a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722346675; x=1722951475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZa+6PAPEgMz/YsT+iWVxJyWxpPIQHn7KQt9G5vV2Ug=;
 b=ZUIGsSWCFvL5UVZw34YnSr59r/qkrHraUfSvBQagmpdeFoNeGcrJ8ZD+OUY24Aspfi
 RIsdOd+9PHDNFBPziszSFQsAZaMoUBeK9AtItisXLJIpM5DA/560uETOFJekM/e4SfVG
 96PGXLSvfdYCHnOGoANVy1uuKCk68AisKetWtRIpqZVF83nH/VT9NRThzgMfZRGYd5Xu
 t9T73BRZ5bJyejuR9cMCZxDqalN2foY8MBN4qwlToERaxiyuN95BKWYK+1kTnNN4hYZp
 HcxBIHfXYnambWRim0CuEQDFTdaqpS3HqLtVAZUT38X3JO/MoSAguuGHBBz+vToka7+W
 P1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722346675; x=1722951475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZa+6PAPEgMz/YsT+iWVxJyWxpPIQHn7KQt9G5vV2Ug=;
 b=HFPmzOKIChaeT0l5su2M6b6gloJyBXXI98NsGzU036tUQjzPryro/GnaZMggMFAnNW
 ZOIu1/KpqC9bmrQN0VZ4oNEnHPBJbx9hby5bO4hqmlTQB6PyAVEnEOzVswyiUKYoguGK
 2UgrO5vKxqY8U5P/4Y9GLBQ2jloU+8trogB9OHbQIdlTfTMTtRMfCHVFicd1TDleNX7Q
 7IWjvhpNaf7uzQhElN8akqa5RES+YznJ/+SCab6TZnZUrXSnNf9M13MSp+J3tHTKH4LV
 r5BAGq3Cr7u0m5Oa8BehtqqZDsjZxY+bjPYmWAZR8KouojEwS2R7AmD6j4TFDab9U7Hu
 RwPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCADa+X4mh4VpgEmSPEJSYND57GlsnDhti+YXxN2B5plcS170GcLI7k7jv+KtiEtwCOGD3nlcUG0XfQ6LvnLDeMmpsyvQ=
X-Gm-Message-State: AOJu0YwNc15WCloSjotvaDVRyIdFVKlq/2WHrWIJhgAmDVZTCF+mWvnx
 bKvCooH6LsqukOWIdRf0g3wI/V3N/0f4n/rOqN5rhP3X2zoSP2hF2WYjfY5cnVi+1fFUAsIj2tI
 DfpzTqQ==
X-Google-Smtp-Source: AGHT+IFp4hbwCagiHj9qrAhKu6N/vHx4h/6CNAHvRjeii+8bYtZ3KzzZAZd5gocP9Pm/Wa6NNK6Iag==
X-Received: by 2002:a17:90b:4a83:b0:2c9:7d09:1e7b with SMTP id
 98e67ed59e1d1-2cf7e5e0c18mr9194378a91.27.1722342318022; 
 Tue, 30 Jul 2024 05:25:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28e424besm10387358a91.54.2024.07.30.05.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 05:25:17 -0700 (PDT)
Message-ID: <af7cf54f-0a88-4f17-a75d-51289a427a8c@linaro.org>
Date: Tue, 30 Jul 2024 22:25:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] s390x updates
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Collin Walling <walling@linux.ibm.com>
References: <20240730080852.649251-1-david@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730080852.649251-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::72c
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 7/30/24 18:08, David Hildenbrand wrote:
> The following changes since commit 8e466dd092469e5ab0f355775c571ea96f3a8e23:
> 
>    gitlab-ci: Use -fno-sanitize=function in the clang-user job (2024-07-26 09:35:27 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/davidhildenbrand/qemu.git tags/s390x-20240730
> 
> for you to fetch changes up to 442110bc6f3f308aedf884103fdba87ba906dfe7:
> 
>    target/s390x: move @deprecated-props to CpuModelExpansion Info (2024-07-29 21:47:16 +0200)
> 
> ----------------------------------------------------------------
> s390x updates:
> - fixup for a s390x-only query-cpu-model-expansion extension


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

