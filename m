Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B86C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa01u-0008BI-Tf; Fri, 02 Aug 2024 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sa01t-00089W-Q1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:41:41 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sa01r-0006y7-NB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:41:41 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so8090865a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722634898; x=1723239698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxHXksN8bUg1QWy9ag8p/fWj8jd1Vr521xmJPRZNlkE=;
 b=K3kLI1NJeCsgDJE++8xdt3Mkxlx4Hog3U/KtJjnRj/6TiCuj2jsYsaZT6hGqhI64oX
 D1xHZWWAux7GChrb2+H2TH2MeFrmz63qPVGamQLKDcZpda6e2Q00fb0TrLHZHgiZ2eV2
 FluyX0GG6BQlXJqLemTtnRGDIA9MAXRMNfqPa/jvWb85iwhyxXClc9KAPCkPGOlZtQS3
 uAh7rRaXPCUmQZchCM+HgDVUFhgCbeq0eF5cTLG81IfKzgu0O4uruZpQ5D1sROH9kIW6
 IkflVz7Bu2vZOOsE+WZ1J8EmvBTg3oqo0I5cxddqx/e7NmLnGbh6vEKTb3Gd30dudK3m
 +I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722634898; x=1723239698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxHXksN8bUg1QWy9ag8p/fWj8jd1Vr521xmJPRZNlkE=;
 b=moV/vtc/hcruNzP3jWETNAYff3sDbRXj25338FUL1fI3Ovqf1S5rSdY/BYY32foNui
 1+Jizn4boaWyBy51kGus3b68i6K8No3cm891Xex8sRDcDm5s8a0ZoyAqsrD+j+Aca0kL
 TJIEMn10aoXH4TyFFtdNjQ05bBySclLp3d4nXs1Ea+tXe12ZqF8nmA7XnvNVbnRDtATl
 mjba4swlkW+2/v2FsbLJPFUpYOmrbDqhBT7WPpxUhsACysBlfrDAgn0Cy3zpqefzWYch
 wQaKPEctzJ7mpU9mKRqORTv0t7Ak4D1nVGtLBkOiaYi0iI0hSryQFYXup2c0fsDdu0qh
 o0ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIx+aABQgJY8LNMFMs7BM9vuKJVqdRwqvNVm9woHQ12rCVVg51N+DbMaezgSkYD7M/rNmKFHTAOZIU6MWbiBaGbdP8+zs=
X-Gm-Message-State: AOJu0Yz+USv5D2/KrcXxh1kZk+rndRXdm3/S7kvtJTX/7rS/gx8OdJ4K
 fj51PKmkYkEt33cuFxxL9TCgJZBDieIDGe2uEy10VtVpu2cGe47PsqkKFt9wld4=
X-Google-Smtp-Source: AGHT+IHPA85ZgVx8AeCMoZp/XDBtNLqmyOF2SOasHl2V+L3kF9plqZyVtO7uDz0r7qbI7ag9lLP82g==
X-Received: by 2002:aa7:c3cc:0:b0:5af:2e08:d362 with SMTP id
 4fb4d7f45d1cf-5b7f540af9fmr3449242a12.23.1722634897872; 
 Fri, 02 Aug 2024 14:41:37 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b723e78sm1567043a12.59.2024.08.02.14.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 14:41:37 -0700 (PDT)
Message-ID: <ac870295-4fe0-4c46-a5f1-36eb2945a5dd@linaro.org>
Date: Fri, 2 Aug 2024 23:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu-img: CVE-XXX Sanitize untrusted output from NBD
 server
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, rjones@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-6-eblake@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240802194156.2131519-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 2/8/24 21:26, Eric Blake wrote:
> Error messages from an NBD server must be treated as untrusted; a
> malicious server can inject escape sequences to try and trigger RCE
> flaws via escape sequences to whatever terminal happens to be running
> qemu-img.  The easiest solution is to sanitize the output with the
> same code we use to produce sanitized (pseudo-)JSON over QMP.
> 
> Rich Jones originally pointed this flaw out at:
> https://lists.libguestfs.org/archives/list/guestfs@lists.libguestfs.org/thread/2NXA23G2V3HPWJYAO726PLNBEAAEUJAU/
> 
> With this patch, and a malicious server run with nbdkit 1.40 as:
> 
> $ nbdkit --log=null eval open=' printf \
>    "EPERM x\\r mess up the output \e[31mmess up the output\e[m mess up" >&2; \
>    exit 1 ' get_size=' echo 0 ' --run 'qemu-img info "$uri"'
> 
> we now get:
> 
> qemu-img: Could not open 'nbd://localhost': Requested export not available
> server reported: /tmp/nbdkitOZHOKB/open: x\r mess up the output \u001B[31mmess up the output\u001B[m mess up
> 
> instead of an attempt to hide the name of the Unix socket and forcing
> the terminal to render part of the text red.
> 
> Note that I did _not_ sanitize the string being sent through
> trace-events in trace_nbd_server_error_msg; this is because I assume
> that our trace engines already treat all string strings as untrusted
> input and apply their own escaping as needed.
> 
> Reported-by: "Richard W.M. Jones" <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> If my assumption about allowing raw escape bytes through to trace_
> calls is wrong (such as when tracing to stderr), let me know.  That's
> a much bigger audit to determine which trace points, if any, should
> sanitize data before tracing, and/or change the trace engines to
> sanitize all strings (with possible knock-on effects if trace output
> changes unexpectedly for a tool expecting something unsanitized).

I doubt the trace core layer sanitizes, but it feels it is the
trace backend responsibility, since core layer might just pass
pointer to the backends.

> ---
>   nbd/client.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


