Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60513C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc6-0004kJ-MS; Mon, 29 Jul 2024 10:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRc5-0004fQ-EH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRbv-0008RO-1x
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42819654737so12237225e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264265; x=1722869065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fGIvyokF0mBN85ur8KilgrswbirGGzlSdx4nrId/gRY=;
 b=yj+GEnfB50Xbd/34S5tWeyGbcMNXdyaWNZwceLn1+CpKLrAbBP8BEs5n9NbcgRB/vr
 epcVLskYRexHrZ2dMOmHbJsOrx0+vU6kU9XjOWF3yj1HXuRx+qqvcqWp6Gla/qebWkat
 ixjdXVtLli5EqI3VfvCEtwCb7Il2I6kv0+zLOqKUMfggFl8p3bDOyvWhlSIWFk8TcSBw
 QQ2fNkM/MQv5rKEaOzMAyhuQ3hnsDiEkOMXfTj89MM1FZfFarCbi54EUjkNnHuzeOBSr
 ZnUcsLPeDSBoT49jokjBxdL7npoZ92tbg/llvPe6u9xJqmEvbu16w3vtRb9lGYIlmFPC
 Qw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264265; x=1722869065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGIvyokF0mBN85ur8KilgrswbirGGzlSdx4nrId/gRY=;
 b=prF6TST5GB/CE+Xp6M2rFKdRmjFIRVbTIJQjCR6cWpMnYrykTNeTW7fIMfNQLjGvta
 yH/yXlA0eWnyEQx+4oY7qW0A8myg0CU2uIjkK7isVlFfNs5fK2+d5nx8Kn4Se4WQXbUw
 biXgksn6gyYH34zLE2INBhkn6BC0kc2UQ4Rgbb/S2SvAAcSx9XYWMGkPLVPp4vVYdfji
 Azcbeqhw5YIWQvR527ICvoOMyQ0ua4GGYcFRxMxb93zhnDtJ0NCToTdiUvGrsRsWb5iz
 rcf8V8NsaF18E3uPxgOLPF7YZWhB/Jhy0QJt29mpL4GPLV+0uP4TxuR+mCgbWQpQYI8z
 3Tlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0fYRBL3JT/KNcBCBvX/bAkH0RuT6GW8pt6WHheHoQbjGm8hdf/1r1ixjfkQyZHQLiyXXGJC5CJM7DRWyIYBDwoZixR0s=
X-Gm-Message-State: AOJu0YzBOHl4FsJPtACBOuz9bFifFoN2b2hgz/toYpwsfGccsoG7Htfw
 0+FwK3tDKb/rrGOaWpv+N/VALM4fAzHj5AJlthGbe+Iu3WvsmHabNLopkLxHs8E=
X-Google-Smtp-Source: AGHT+IFYvrJmzJyqBu7FRa69HZWew2YSJNuBn8eF6YmD4wuY1POV9ybKFm5aRpbwWQRCse48EyhyIA==
X-Received: by 2002:a05:600c:198b:b0:426:627d:5542 with SMTP id
 5b1f17b1804b1-42811dcd36cmr48248685e9.28.1722264265352; 
 Mon, 29 Jul 2024 07:44:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730bdbsm182021775e9.5.2024.07.29.07.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:44:24 -0700 (PDT)
Message-ID: <f65c14f8-bc56-41f4-9fb2-73cdf0339a00@linaro.org>
Date: Mon, 29 Jul 2024 16:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/7/24 01:35, Richard Henderson wrote:
> On 7/25/24 03:52, Thomas Huth wrote:

> I'll say again that the download *must* be handled separately from the 
> test with timeout. This is an absolute show-stopper.

Queuing patches not related to assets downloading
(1-6, 13, 15 and 23).

