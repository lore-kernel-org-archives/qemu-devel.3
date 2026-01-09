Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE422D26D99
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJad-0000wn-9Z; Fri, 09 Jan 2026 16:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veJaQ-0000vQ-KV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:00:00 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veJaN-0003jK-PU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:59:57 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so1139451b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767992388; x=1768597188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2hwL3aYsuYh6e07e/EL2DvwSuzKOeCGa9fC4Y4QV9/w=;
 b=xDa2rlitFheyBnnLpqvMAx+sIp6juvmpM3IDHfXbxsY82qqVADswRrM/mCXuEe6LqZ
 dsEyexCFDWMCzi/b7UtWDI0r+tJGdfYm+v3t2Ph3luVQgnOW8yrlV7CenK8BNl+TGdPP
 iN9dJ/bBpQ4LucoWR9nniGbeRYtvSleDoFqv1zfwPMR6Wzi3S+8k6Ts/KYbvtVAX+vxX
 UBeWuqkS8QOvuZ0m+ROFWFMr4UfbSYgh2D620mUknLufleEFWmptrW2nDcYvNrM3p0e9
 LUml/E+W3Ye6JcfDymOu8jp6SQ+93bFwAclc8R+YlbhnjwZM6YIDkK42/7c54DRaJEm2
 GCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767992388; x=1768597188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hwL3aYsuYh6e07e/EL2DvwSuzKOeCGa9fC4Y4QV9/w=;
 b=beU3zXBtYAUZYtb6/5FjzMlHnKg4zl8bOqJ53WG5wVPAY3ZEPrx5UmIOEr3Fi5delf
 HVG3lODrpScj6Prf+xxCaoK8xWlNOj1GPXbO8xmMdjsMwnlW/IlE9lxbP7bmmqKrT5Fn
 5B7yqOdPZ0Vhk79rtz143I/H/9L6s0JZvWe8ttnEblV7nzLRG7v8k9p7fzzZIqnZZURY
 TTZF7gmrE/GkRh915g4RsLc1gOOhU5c5dsWyayHie4Ze4tfEQZzsof1tCq6i4WncVRMh
 V5gMAI3nVO2Us8FB2McLqh9pJjjQCozLoUOC3Ymc3ylhUDlPONiOCcw5a3aDEAqad3Ev
 Iong==
X-Gm-Message-State: AOJu0Yy9nPWTHMbq2yKKO3Oc6ZrF5V44BO1NOgDMMs2uqwCSgbMoKmGN
 6PWzGGszdc3Y6lv9X0RKFKVSonj2ubiGXxW0ZtYa+C+2mNWbpC3kadIEdlk4KwMoCII=
X-Gm-Gg: AY/fxX4qB+noOfQ18fBSZ7rxQwfvBBKc88/0zm8F9sPC5aGLYfdqDRx/nWYiklPbmM/
 /rOJ0EEnAIsSFGqpxiq6OvuzCf9+RrtP7q6NUEgH2ERL9Wn2ogtEH9Q7g7YDf+S9TqYZI1oagUM
 8wZNtHvoUWWqoNxI8Lwa2WHoEJUGaTWl7Be/5g9ipodZyzRocGIDUpQZtudCSlhVnANFic24ZsE
 DkghuhvV6mob0pPWLtX+zJzjG73SiixCNxWq9BKruMXysjlvAhihMPnnTmdkHZA1K6PwPkz03C8
 +5Sr1stipH0XxXDZ7uv+c6qFf6MrkyKEb/LbE6eWLZqOBdfvCu4HeKbKJWFv8R3gSmhytdiOhJu
 GLwKEB/KfuAQPLt+hmQgsNgMacV8+SibTSp6oblnT8AK2gQmfO7vzQb8RRzpC58mrgPlO/gqIV6
 niMA+LtBSUdmQY6C43Cljrm7TNG0HeZqQeB5TKOMKw60sxocC7HDne1qwrBgtqxzgeGIM=
X-Google-Smtp-Source: AGHT+IHdIGl7V2RPnBKerBFD0tzG5NI8uy2s4Xy98VCGbW2myWec78tTGlv8MH+4+3iB/fjNL6eQUw==
X-Received: by 2002:a05:6a00:f06:b0:7fb:c6ce:a863 with SMTP id
 d2e1a72fcca58-81b7d25ffdamr9567594b3a.13.1767992388107; 
 Fri, 09 Jan 2026 12:59:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d29516sm11365657a12.19.2026.01.09.12.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 12:59:47 -0800 (PST)
Message-ID: <412887ec-94ff-4b3f-af30-c8317dd89270@linaro.org>
Date: Fri, 9 Jan 2026 12:59:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
 <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
 <CABgObfZ6qCCS89u7i+QW=FU-_aKe9ytFuwqFHNEqNNLm6=tEEQ@mail.gmail.com>
 <a89124ba-3011-46f9-884e-938586c46955@linaro.org>
 <CABgObfYdW93DW5m=S-3f9MNZ+ovE+Dx0+=V1wmVzOP6e=UZbLg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfYdW93DW5m=S-3f9MNZ+ovE+Dx0+=V1wmVzOP6e=UZbLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/9/26 12:34 PM, Paolo Bonzini wrote:
> 
> 
> Il ven 9 gen 2026, 19:38 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>     Do you want to see explicitly .addr_type = TCG_ADDR_TYPE_TARGET_LONG
>     everywhere (except arm which specialize this), instead of relying on
>     default value?
> 
> 
> That would be one way, but in the get_tb_cpu_state function you *could* 
> return
> .addr_type = TCG_TYPE_TL, even if it's not constant, couldn't you?
> 
> Arm would specialize it, but the other targets don't have their 
> get_tb_cpu_state function in a common file.
>

Ok. That's what is done in patch 29, in case you might have missed it.

> Paolo
> 
>     Or do you expect something different?
> 
>      >      > Also, please call it addr_type since tcgv_type makes less
>     sense
>      >     in the
>      >      > long run.
>      >      >
>      >
>      >     Ok!
>      >
>      >
>      > Thanks,
>      >
>      > Paolo
> 


