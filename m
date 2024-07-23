Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA5C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOlh-0004o6-Ac; Tue, 23 Jul 2024 19:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOlg-0004nS-B0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:18:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOle-0004ji-If
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:18:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so10297825ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721776681; x=1722381481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+bU3aS7EUD2K3dWQABqEG2pBbwAfVn3dX7jYchowhY=;
 b=D/RdW+GT5yz6m428RLcz8In8rxA8RKqcEADyRaVoefricf8bu9l3soFKH0wwpw5wXx
 2lT6ywWVZwQjL/fB5rWT3v9aGj5L6cAIneqKpmtFE51bTwiue0bAni/J+nujGYBI4cij
 lzEwtQAy+ILc1qIXVwtiof6ppIK99MMZodVtjyVmUZanyX0+djYuYm9b7ziQIGjNa5Gi
 roLB/SrKcAMWOx5vH0WkDweq6CRHT+Doyg0UGg6nw8FObDvET1q8FCwRLr1KEF8DR78p
 DpTp+Mi+MGUa9VS1K77bkQVGyzxf8QDueiM6QA46kQKLAQXpKdSlEM+FoT7+UuxPkn12
 biYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721776681; x=1722381481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+bU3aS7EUD2K3dWQABqEG2pBbwAfVn3dX7jYchowhY=;
 b=NQ+P966UVdCVsKCjVXsOWFBipDO4SR1x8Jn5OWPNfYUBBio2b7vnrmlGyqppzmH6I2
 6KS2MBXR9Vlb2rUp7UAiSbenMHnfDxMbem0AKEWhf3ujmJOT40c+5KIQgOoBYmMbOh63
 TwoRhiJ6JqC/vL5uaqR7JU+nqZSyeQYBN8cv7tYobCE0EZD9agXCta5RpEqbOZM3CJmR
 Bz6AUipXe//8VsPAkViart8BmgFszM7+m2M5r9FS+PapuXiamqsb9AgivmzgP7ow2y9c
 urwD7Kom8vzQ0CKlp2OhxkH8kNI10J7Y/FFknVfPTSl/yN7HzBN2XezMyTHnMxaUdMPn
 mEug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjy9b+EYDwPJwVVV8BDIroYXpT66HCp5kSA1vr/OLWLNzWBW9Zfzb9LmaJINvims0CBKwVhlr68jt7l0m165MzvpQIkTs=
X-Gm-Message-State: AOJu0YyCLFm7TL1CbNX9P61ljewf8gTurZ3PVZXkK0qb4Fq1K1Yoz6km
 QZRpZ2d260nR/M+DOnxsU4HB4F9IjdCW5jPU+b2XpCUgF2pKDpfLEMKs3V4fPnA=
X-Google-Smtp-Source: AGHT+IFLcvVFRHM4dRBnHL7YxttzkDXZQY7FtVPXto+ZjZ3P8vtAva/8Zp2ATpUD3vxLtd5p3S8fuQ==
X-Received: by 2002:a17:902:dad1:b0:1fd:6669:a847 with SMTP id
 d9443c01a7336-1fdd214fd53mr12737245ad.24.1721776680462; 
 Tue, 23 Jul 2024 16:18:00 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f48875esm80392115ad.287.2024.07.23.16.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 16:18:00 -0700 (PDT)
Message-ID: <c9f2eb38-d448-4593-b3ca-6dd076dcccee@linaro.org>
Date: Wed, 24 Jul 2024 09:17:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/25] Misc QEMU-GA patches 2024-07-22
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/23/24 17:02, Konstantin Kostiuk wrote:
> The following changes since commit 23fa74974d8c96bc95cbecc0d4e2d90f984939f6:
> 
>    Merge tag 'pull-target-arm-20240718' ofhttps://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-19 07:02:17 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-07-23
> 
> for you to fetch changes up to 8e326d36dd16b91d9abc4963b5f75b8f637c2312:
> 
>    qga/linux: Add new api 'guest-network-get-route' (2024-07-23 09:49:07 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2024-07-23
> 
> v1->v2:
>    Fix clang build failure of qga/linux: Add new api 'guest-network-get-route'

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

