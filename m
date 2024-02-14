Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C57FC4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raA6k-00017h-RK; Wed, 14 Feb 2024 02:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raA6Q-00013M-8Y
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:54:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raA6K-0001a0-Al
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:54:43 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so46604165ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707897279; x=1708502079;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=80AktfsBJRLsWlMrFKFy7QPhIsptF3NRTk5FuAv6RUA=;
 b=z2RPdh612YNGXxqQSy5GOyiQ+Y2EKgGwyhaxlmRPmgaPjjSIQxdHKK68yTHxH8Cmdg
 MUDKfzKMrwDFDE+PkbM96ZsfT6K6yqQvqn0QhZbOY7OvS0iyXq4F19CyCkqOMbxokzib
 8SZz1b9Onp2ZVvcPNGzOwdpBbdqQ0Rl02KD9rbtAjObOfBZM+zTfxOyblTslXdfqBnGg
 nzlUhIER9QMi7Lfk9wmxbZD5dpziNQFwrj14hQuBhrBmXPsJCln2zDYLEY5xuhsR2IkH
 i9o76dglgMz9DYNwCH5MjR0zGK1aFcVljuQ19XfAc/h0Czi2KlUDkUFxcvFXilrOxELe
 nnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707897279; x=1708502079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80AktfsBJRLsWlMrFKFy7QPhIsptF3NRTk5FuAv6RUA=;
 b=ozmI/9fRDmA4p/taxWq16VMRMbPj/5aC65+8w5GHusT4/FKTUozA3DBmbGJb0NDMnj
 p4a3tnix+fmbI8/6q0qd5EpTF77Y6K2ucawhcp/TfUypenbgfS/Tb2CYHxnK06yJQXZa
 U9rO/iKbi5gC1M4+lInEOUj9LTez6u44sZmDzRjs3ft5XrORo0g9gV9tvNtPhXzPzHTM
 HjQKwo/iKvO3WAxhgZK1TwK0VT1EFIQKJNMyVWAjNNMAFcY5T0ZFsgO6LXDxkPKoA4Sn
 PlvnQewjOQ+szxuVFjgx0ofKiv0db2VmxtV0ZrpmizTQSzcO4iOnoarEpTOJWOLdAJGJ
 a7fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6oQ+CK6bMjsf9qriVlgfqnun6PDix+db542vLc/Fs4KhrwwtM/S1t99cNcW/GVzFzcocgPuZoUfGdhv7Hj5G+sFE9mfs=
X-Gm-Message-State: AOJu0Yzc3JlnnQInqezBSp7TnKjAQiBXXVAoiLrodZBePZn0XxIxVgh9
 qc5nU25e7fDgy+Pul4oJu0e4IvwsUCp+eWbCPv6PG392LMp8Eemtk+rACVBMXcRnVf1x1Jw9QN1
 e
X-Google-Smtp-Source: AGHT+IHgWWy56Cfp1PASxFgKAy8q7H2RUWmqdMtLJRfeX0EAgMW4GiWp6crBNsFkchSqbJnQnsPoyw==
X-Received: by 2002:a17:902:c947:b0:1db:4b08:fbe8 with SMTP id
 i7-20020a170902c94700b001db4b08fbe8mr1890373pla.44.1707897278911; 
 Tue, 13 Feb 2024 23:54:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVi9+BW7Ac7KercGamOm1xP9VPUsx8JPaDhhzGf+dhvmwrPjVTDTxqO71q5PlTGR7WI/8mEf7CZtYKeOfm1MvNlp4mE/Sy4rYQ9TsgrQKE11oETnRNUy8vsJtCftvjdqHU9fdOgsPOt4WX1ikKBTlIOAtNpDjA/Povu8v2NTow2AiKla3pGUvZmqhsA8l4nYEjB518/5nHPW1lVOilDkSgIzLUr9vz7850=
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 kg13-20020a170903060d00b001d8d04472absm3182682plb.154.2024.02.13.23.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 23:54:38 -0800 (PST)
Message-ID: <47379759-2a00-4c5f-81ae-30fd9b541ff2@daynix.com>
Date: Wed, 14 Feb 2024 16:54:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] util: Move dbus_display1 to util
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20240214-dbus-v6-1-411af2b9289e@daynix.com>
 <CAJ+F1CLw6FCMzz1vmNQTon4zR2ae=O5Er+5kU56xQGgCMp77Gw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1CLw6FCMzz1vmNQTon4zR2ae=O5Er+5kU56xQGgCMp77Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/14 16:05, Marc-André Lureau wrote:
> Hi Akihiko
> 
> On Wed, Feb 14, 2024 at 9:39 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Move dbus_display1 from ui to util as it's used not only by ui/dbus but
>> also dbus-display-test.
> 
> It doesn't seem like the right place either. So let's focus on what
> this is fixing.

Ok. Then please have a look at v2, which doesn't use util:
https://lore.kernel.org/all/20231215-dbus-v2-0-1e2e6aa02115@daynix.com/

