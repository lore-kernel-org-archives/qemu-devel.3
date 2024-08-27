Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACB7C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 21:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj3Xb-00060Q-2W; Tue, 27 Aug 2024 17:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sj3XY-0005zH-U7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:15:49 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sj3XW-0005hz-FS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:15:48 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cf6641765dso2505519a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724793344; x=1725398144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MUgQPowhVMQHofMnMD60IayUjB5hx7hEMl/RTEeQkK8=;
 b=Gig85y+JVymijhOgdiq+yU5nRFEkjAsqqSlgGYDzMu0NmOKd69JIb+9SOtpabN/+D+
 hy7cZawumRMvS6YX+L75H+I46wcov7YZTQbnoubG3zid8eyRmiYYtWFrA85G/3qcdQrf
 Fo3IRqGYrTdlouWKIbTB4jOlFev7P7p04oeWszjsfgZ51i9a46bxRSQTywE1gSSiV9sO
 NFZWviZt6pnVgAwasLSglq6scTSBg7SOQtYfvTqwCG5zJkv4tKxPwheIM920/S/Hw7t+
 hYyCTtm5xnTwMHeDJ8m55j7hpFkyW6LKjvG8dVLAOqU49hU7qAeUmys3Ko8S45Zvsnfw
 Vuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724793344; x=1725398144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUgQPowhVMQHofMnMD60IayUjB5hx7hEMl/RTEeQkK8=;
 b=GYkqZMz2plq0S9W/K0XKs1IjmXcDE9NWXgvxlrGYDp1FZu+WYptWE1fA45CkP1G443
 vkiSiWAVKM5HmmggJMOwdK362ZOirNNYMmUBIyTFLJoIK5oWgrWkNnCdD37kjqRbOm94
 ekapf42SvLJHfMAfWCqNVXtsEjIqMbOrM+J8P1AACh093VRLL4XYg0/mwG/QhO0/8XYU
 nMvmcYavJkjxNoANAPoXZZSrMAzISX6iiMvbTPo7MnlvxgwR1//EfEJMXLE/Do121/XZ
 kP56rmEAiZQMZrUf9395qqEGVt2IQMmSXTWqN7wreMy5P8VUiVgtyakPy2jFDF9/hhHl
 x6TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOfzQO2f+FeQJlwieGihB8SzECCUL145CHDsgfIk9mtuUML/vp68/lNZ81wvnRvcBsUsdDQ0GCWI0W@nongnu.org
X-Gm-Message-State: AOJu0YzG8NlUE7X7+kjJxtQ94g3ImYS5c/T3Abe1ZSSlk4Q681SWnhLB
 lhlPxF/XKZ61UcxBBeI3MOdxBxlVBopDWulMYetE855KCJbQnq5k+bbHZ4ov6xunvvilPAwQaHy
 +
X-Google-Smtp-Source: AGHT+IGO+gRkmtN+yxL35+Z37qHBXl6ONRrWLT63CQaajEKMtq75NYExrmfgIlJ3OaU9/HFLFDTIlA==
X-Received: by 2002:a17:90a:4926:b0:2c9:752a:301c with SMTP id
 98e67ed59e1d1-2d646c3fa9cmr17443383a91.24.1724793343975; 
 Tue, 27 Aug 2024 14:15:43 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:204f:c99b:4c13:a7d0:815b?
 ([2001:8004:5100:204f:c99b:4c13:a7d0:815b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebbd9fc8sm14868253a91.53.2024.08.27.14.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 14:15:43 -0700 (PDT)
Message-ID: <376ea209-71c4-43bf-8f12-8d6673a3c717@linaro.org>
Date: Wed, 28 Aug 2024 07:15:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-9.1-rc4 0/1] NBD patches for 2024-08-26
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240826135044.1692814-3-eblake@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826135044.1692814-3-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/26/24 23:49, Eric Blake wrote:
> The following changes since commit f259e4cb8a8b4ef5463326fc214a7d8d7703d5de:
> 
>    Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-08-24 08:09:27 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-08-26
> 
> for you to fetch changes up to 3874f5f73c441c52f1c699c848d463b0eda01e4c:
> 
>    nbd/server: CVE-2024-7409: Avoid use-after-free when closing server (2024-08-26 08:42:42 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2024-08-26
> 
> - One more patch for CVE-2024-7409 (use-after-free on nbd-server-stop)
> 
> ----------------------------------------------------------------
> Eric Blake (1):
>        nbd/server: CVE-2024-7409: Avoid use-after-free when closing server
> 
>   blockdev-nbd.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

