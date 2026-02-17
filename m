Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA33E9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSl0-0000No-8w; Tue, 17 Feb 2026 16:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSkv-0000M6-Bf
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:37:17 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSkt-00058m-DT
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:37:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso170140f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364233; x=1771969033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpSN3Lrab8r8siEkLa/h4lJ4FB1v8ZaMvflu5Rz6HY8=;
 b=diaNcOWMXNSO4IVXSjkHJlOjc7QOKVjKXXJK4kW3G72rMasggJ4OdUdKFnmgJr85OE
 PEd6DcOVuFtyoyrRGVFiZI/xvKaOKp1P+7apjA2rAcwbork5LExwxrFVkUbDhkL5vWg0
 Zdh/Ep3HPgHCCyg51Tu7C/h7Vn0rbbg2xmDMFlKCuyYe5KTr7WtubEdY4sGbn7y+fld+
 1xsJS/oalxmrVdPH8nmYrIKkpGVgFQkBhaywg0F1Xq0EIrXdy9dv5PhDTaGkl1ay6j4k
 JaMn2wgtaDvO3Q1m7RTTzrdOvbaE+DX7rcZoXjkhk/iKo09hZEK6HCD8nRl9xxKhab/m
 Oxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364233; x=1771969033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpSN3Lrab8r8siEkLa/h4lJ4FB1v8ZaMvflu5Rz6HY8=;
 b=e9qugr6v41+hVfPQ8vD8AvMBCH24epAFv4DVwuPwQgBI7QSLpCPA5hPQa757/Ew+jP
 t3RpfrMTa3WiNtG8kTNmIAbvNIsPYBU3Gcz6CFnz0/gR3BAFGFXqs7X4ziADqnXfSoCu
 gpd1/Id6jkAd2B13lYaRZZLvku/v4m7Z93jd/dOy0FBS4ZqTyBAgaBHizdE+Q2f5zS2W
 IEm58migeuTjrU/e2Wf58X7LgPYtNra/L4C1QTepP5Ov4cXtHEQVaFb+o+nmCE6kDvVP
 GIJ2gg4oPSA2aTx5DH7aYuAihWQaRYjS7qylDz/Qe8OK3spt7Pcpml2peiLBqQ4Igokd
 3QPg==
X-Gm-Message-State: AOJu0YyY/qOBU0uNOD2vWxkveUQd5E0TRFJNKBUIzC18BR3QvPMrpAhM
 oncdRaj4r/TqUmSZWouWp9Yu09OXtAnjk4fA1GuH6E2VJ8WvDFEwjt7G1wrusYFG148=
X-Gm-Gg: AZuq6aLJa1FijMR5sDb5ZqGiKLOQfVWnnwEDQrH/SlANwdWmMfYjUxuG60q5jGk4pNa
 Ye+2o5QhmfqFuNIR/tyXpXGWCcn78s93gpz8rlnmr5G+R32Bg3ij4KW6fGJFVnB+aRT/nEm+YUE
 aGFu9ID4vKXsIWTviWkUfLJOBDkk0UI2AY5OENC19X631PY2T25anSiXBRnSwfed/lzVX1AGMbg
 lOsvK6SPZfhL/id9iPOt6CCqiceFhPQp6V3H5sTw6SQd3m4vsyzf+O+JL8InhQR8Tp+Ac7ehYqJ
 FLsXBgpDxQT5FGmTBVzwAYkv/T7COuyatt/8KkP1iXXPVdpYPqw5d4buGBxNcHAaUc4Tlr+FCBS
 tTvTWpoLHUULDCVkKQmxUrXk5qORQu9+g+jpTucVPS7W1RJ+DeoEPT1A0JOH/R6eQeDFUhjD/0r
 v4Un2gz/yS2T5drgda/xRm7+tWr0l6veLbdpZOt3d74O7Q+XGVKKY7jq3DDYBI9VJQOw==
X-Received: by 2002:a05:6000:25c4:b0:437:722d:5c66 with SMTP id
 ffacd0b85a97d-4379d612ab8mr25241446f8f.16.1771364233141; 
 Tue, 17 Feb 2026 13:37:13 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8209sm38808711f8f.30.2026.02.17.13.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:37:12 -0800 (PST)
Message-ID: <2f323211-af73-4897-8d50-62449737b080@linaro.org>
Date: Tue, 17 Feb 2026 22:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260118215945.46693-1-philmd@linaro.org>
 <20260118215945.46693-3-philmd@linaro.org>
 <EC8E03E9-3E48-4425-B4C6-D395BF34B454@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <EC8E03E9-3E48-4425-B4C6-D395BF34B454@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/2/26 11:15, Mohamed Mediouni wrote:
> 
> 
>> On 18. Jan 2026, at 22:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
>> host hardware accelerator.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
>> 1 file changed, 25 insertions(+)
> Hello,
> 
> This broke VM save/restore on my setup. Will have a commit to revert this in my next revision
> of the HVF nested virt series.

LGTM, thanks for taking care of it Mohamed!

> 
> Thanks,
> -Mohamed

