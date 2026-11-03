Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFE606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xXnmDvth
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5ym-0001lw-KI; Mon, 02 Nov 2026 23:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO5yk-0001l9-Jd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:18:34 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xO5yi-00035o-Kr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 23:18:34 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso1988076a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 20:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793679511; x=1794284311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3qvcWja37BQSUb38wcCCseaJv/dMXLqqX95oekRperw=;
 b=xXnmDvth0aEG0Pxh4zvWBeUeri7AK9VV8OtxjtcJmk+NDTztnt/gtPaeLBqRPvk287
 8oSwmrxeNPR7fwhDilULqAwA0J6EWXSnFsv6+h6ZXniZWELaDeCJA5WCMeuyXbw/D34h
 SmEka6OTena87OFZ3pa4CZtJwgsgBXZ1LlcaEuluYspL5MT1+X9ZflyJsFa6Wsbvi0qk
 HwO54El+kfzXqK6imS+SWvD/+Hu9Kc6JmdPL2jiBnAnuARMTEmpw4ujUr3QYbYq/lm3H
 t2i/PHzjbdXMqq+v3dDxu915+m4a1D3u86V6lnuHmBd2klS2u4s25LaRfBL75o6SMQdO
 xXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793679511; x=1794284311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3qvcWja37BQSUb38wcCCseaJv/dMXLqqX95oekRperw=;
 b=nb4ZDRhCsHMfqQfUfNGackeHFy3AmnrPDCNMXo4tzlrS/+eKC2trs12brcYJTRZycV
 t62dCfKl6vtZ/Qmqu3G1Ebn6O/3FkrKAU8fAZMStSlu+Ooa6yiq0h/SfaMrIQsOSH3xk
 09t8ZEqgYFez8B/bBOcfljGWiy6cdr4vcRV7lMchhi6t/3f5wRVum6CVxNjtkbRCg4p4
 xIt7bWJDmp83m1hwuJ3NcN6mzCcyoDiIJE0F5KFPMnghKo8+CTnYcYd37AXVJdoMNFi/
 YFy+AuE+YMQ4hunWLp48VezsvocT0pev9/KtLId3pp33FHNTpxhglXAhwPafF1gm7WDt
 +hgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2q6VFtuiOomSUuLZwb60sSamf8urJK7n/+cKNA2Y3XSofXzbXsVVeZqN9blX9fmc/o8FtpHnfYtBh@nongnu.org
X-Gm-Message-State: APuU4Z+DfNtRIdzg9RQzmC+lAh9I9iXR5yCqXqRJ+OYRvzooQOgw2pz9
 I02nIwuGOtmQibgUc2WNYYBoW12z+BCzVyLlmm3DhVSgJbmtMTwEfvXNoKAbGhK1lU8=
X-Gm-Gg: AYBFou2XOvWtR5igr97KKUHs/o7eUQuNAlaVwBpKmJfatXty7n7kInzYBwcKqUN7ps8
 8OVxIyOeQn8Z4eaBfX1+WBcca8vp03NVGQdg0iQhabzEEZ3QGdtQowhP2oHgpHz4H33jtAfGA/Y
 uTPIMNZfNJdaitmUK9tTi8WEp1dI58LexA5XJuTW6xkzwqpPO7RGiq775CJ1vOHZ0kK9FJAYuTA
 phaZkQNZO6+u7qWXU91vHTSudUrbphQMnn8tXYf3dJVQ2WkOekPPdtHzbazNnqb2g0bp/DYUhji
 58wF80MfUdf+rR9uxnOWmkcSwuC0rWUS8z2OOtzdgSZFZJ35E1ry1BP6mmanggzx90Q0yWldj+3
 v6JUKRMrEDMZkp/ZOfN8xmAulq68w2yWnWdmNCOx+bN3thCmzFh/8mY5IMfyChZSQgH9zr3t3B9
 w06K2vgngvtht6V7oFkqU+1ie7qimtdwjwUBEJAAEKZZDy6xsHRCEFDg6jsxYbqxILdg+8gvxy0
 dBZw2Q7zId3wbm81oCbIGpFUZ8TmhShEs1MPzOZP3Zje3TDgKvKJQqSx+hiDS0HfnbwVGQcKwbo
 qOzSCjEPtTuJVKhdsrRjVQncqWH3Qf4315XWScLDocdAskN2VYDCSPE0McihAgdJR8IwYAA=
X-Received: by 2002:a17:90a:ec90:b0:3ab:189b:6981 with SMTP id
 98e67ed59e1d1-3ae898311d9mr9320030a91.48.1793679510721; 
 Mon, 02 Nov 2026 20:18:30 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c627193sm2137901a91.6.2026.11.02.20.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 20:18:29 -0800 (PST)
Message-ID: <b5a341a4-e637-41d4-9fb2-662921b82665@linaro.org>
Date: Mon, 2 Nov 2026 20:18:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] s390x fixes for 11.2
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261102161424.241623-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102161424.241623-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 08:14, Eric Farman wrote:
> The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:
> 
>    Merge tag 'qga-pull-2026-10-28' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20261102
> 
> for you to fetch changes up to b71287f0078200b07ee2fa9a28991645a3a92777:
> 
>    s390x/pci: Change reset method from legacy to resettable exit (2026-10-29 14:43:37 -0400)
> 
> ----------------------------------------------------------------
> s390x fixes for 11.2:
>   - Fix zPCI cleanup during unplug/system reset

Applied, thanks.

r~

