Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1419C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Re2-0006wL-SI; Mon, 28 Apr 2025 12:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Rds-0006vo-2K
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:47:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Rdl-0006xK-Ad
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:47:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fd89d036so62914605ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745858851; x=1746463651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxk4OLIDYfZLBRkuxzNPnhMhtAZq6rOwyZBp7gqaYf4=;
 b=DrVgofHVFdExhX8pbkro/hpYwDMfb1mP8wobK4gcy2wvgAQT750RZOlJey6jGaKwEr
 oGQj9Wv3ClEb/FVAsZXqws6GeJi4vXEaO8+uwSOKn1qEeGEC8s66ObHd8TwDX77WLBL7
 vU21qbbGM4h4ySc00Vn078ekuVbC2raH572avENzSyj+ddkb6SxcHPYc+VMlXkC8FWbf
 mP8qgVaxFMU/jOjoficmN0eEbNE8HtF36+VrxYun9xMCaMDebRh5sSr2L/hhl1NB8qCl
 za1nuqikzScan2U/Nule2KZwS8paZVUzQLyCc+Z0SX9kP3U+Q24QO//c0QVlCa0dKfWI
 c15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745858851; x=1746463651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxk4OLIDYfZLBRkuxzNPnhMhtAZq6rOwyZBp7gqaYf4=;
 b=gpw7gL0eFJL7k2HaezTuVMpemGMkl79lnzb+fidzArbjF5ie8zCX6to1HbdjzPNkWG
 cq+J6oAujDuiR+uEjZoTn6O/CWqKShX3y3yialhRf0aUJZ2L7PHJbfszr3Vfgq56aTlz
 xVgx+zu+QhdffJwm/a1QI129iA0kt95ZSDUs5ZGeHOHY7IPfoX36io+X2NjEctyq6b8Y
 Mww7Ue4yx2d64nn6tEw4hFgJo9wnqFU8Wwebp2zhy2Cq5FxLh2MrH8JegGHbN6URYO9v
 UD9kys4hLdtgazfN1MKbLk7ofkVRXDQk6ooHIAyO7NPovzxmc0UbgyGSyinXdDY5kfTD
 sStA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMEjK/gpjqFUtC8JpFXKi0Evyee8IwZA+eMXGl5jjEN8jBR1TgLkLgoS7OmdfelK26iOKH17r4rqVg@nongnu.org
X-Gm-Message-State: AOJu0Yw9N5EzbJ0azNXuewQ9emeShW6ksgyMkLdoJgDedeURGFM1CuKV
 eUCLqc8yZHsaHC2VJxlWDcsK54sKa6EgKtXNB+Hi2qQY90FfyQtvnyQMWq2iyrQ=
X-Gm-Gg: ASbGncvH/bUkj4pGnOCXkch3re/Vqi578bAWdvqLCa8KR8m0ePVPfmUaXB0Oz0rnT9q
 KpC9mXp7oJli+SUr6WdtbJ6zS5WNRKryxRUHYQFV6AJXItTaex52mqKFCfrusRDy3GwmKqPd3WS
 uu42Dxgcfz2WLqSeJ/MqvMEz3DF3xydsbEppiLIvXm632WCm0SL4KWqvFsVuUAjBvs8H+M8kITi
 y5JGXcH9AXsQJkSG0GK15JOcCuHum0qNvqrCo55rrAkOSTPCLrPkZGaoBmqcWivTAIx88eTnsju
 Iq0c4Eugfs7HRlgyi1ScpAjYKgrfTllOM85qptMsgB7UvI5669sXydJaaFbPt72p
X-Google-Smtp-Source: AGHT+IGyAZOelw+q1HeOWDnJKJHe6OybnhdlC7C8tHQ/7YUbAttTGbDd2bLEZWWlj7r/Sb3T8BS8aw==
X-Received: by 2002:a17:902:f607:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-22dc6a54455mr160801345ad.40.1745858851546; 
 Mon, 28 Apr 2025 09:47:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50ea7casm84949825ad.134.2025.04.28.09.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:47:31 -0700 (PDT)
Message-ID: <6d7f8b57-b8d4-49cd-b0fd-72e5428bc94a@linaro.org>
Date: Mon, 28 Apr 2025 09:47:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
 <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
 <f84a52af-aecf-5235-7971-689580ffb71f@eik.bme.hu>
 <29f67d66-9eef-493a-9d96-99240ca25a14@linaro.org>
 <75b7e110-9293-32b2-64c8-26eabaace8b7@eik.bme.hu>
 <033d94c7-ac74-4a44-87ae-aeac964afd10@linaro.org>
 <c4479348-00b2-4604-adad-e8d8911c75a6@linaro.org>
 <21e6cbae-54fe-2d11-307f-2fe36a08c97b@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <21e6cbae-54fe-2d11-307f-2fe36a08c97b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/28/25 3:31 AM, BALATON Zoltan wrote:
> Since you are touching the lines using DEFINE_MACHINE it's a good
> opportunity to change the macro to be more general to be able to keep
> using it instead of replacing it with the boiler plate it's supposed to
> hide. Adding one or two more parameters to the macro is not a big change
> so I don't see why you don't want to do it. This could be addressed later
> to revert to use the macro again but in practice it will not be addressed
> because everybody will be busy doing other things and doing that now would
> prevent some churn. I too, don't like doing unrelated clean up which is
> not the main goal, but if it's not much more work then it's not
> unreasonable to do it. I only oppose to that if it's a lot of work so I
> would not ask such change but what I asked is not unrelated and quite
> simple change.
> 
> That said, I can't stop you so if you still don't want to do it now then
> you can move on. I don't care that much as long as you stay within hw/arm,
> but will raise my concern again when you submit a similar patch that
> touches parts I care more about. If others don't think it's a problem and
> not bothered by the boiler plate code then it's not so important but
> otherwise I think I have a valid point. I remember when I started to get
> to know QEMU it was quite difficult to wade through all the QOM boiler
> plate just to see what is related to the actual functionality. These
> macros help to make code more readable and accessible for new people.
>

Having been through that recently, I agree with you that it can be hard 
to follow at first. Luckily, we have perfect compiler based completion 
for all editors those days (I sincerely hope everyone spent 2 hours 
configuring this on their own favorite one), and it's easy to see where 
things are defined and used, even when code is cryptic.

That said, pushing to someone adding a new field the responsibility of 
cleaning up the whole thing is not a fair request. You can't expect your 
friends to clean your shared house because they brought a cake for dinner.

> Regards,
> BALATON Zoltan

Regards,
Pierrick

