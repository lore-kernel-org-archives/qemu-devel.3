Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ACC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 08:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcK8P-00079W-RC; Mon, 27 Jan 2025 03:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcK8N-00078u-Ay
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 03:06:15 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcK8K-0002qt-5i
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 03:06:13 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so3630460f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737965170; x=1738569970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRDFifUSykghhZo2AgAcnmAVAVfzz/ZXaFqrQ5/35Ro=;
 b=Z1+H6JrRglWZ/Z816aTHetlCROTN1qB9ySZ9i3WXusbbFJ201HHkIVGfCUVgmWtIQf
 bnuy5g8cmtUJ/5XwkObtMyCX2/JtyT4EQOTZ3US5Tubb9DMM+x8CHnVDxTkf0ppmcl+C
 W7NArHSnsbnbAEP6IVVnU1r6BKNYJ2oJL2BOrH3qyCV7FbpUz/nEddNmeOh2gYG42VIl
 dmvlgV3XxvKyAhoVvO5y+LUC/RdOA5hLCtYNuTZtIMHQfzwTq4F1EoybHe+6w6EWjApX
 XxAtFgXPaoOvkcNbRu9/TtcDzm2z8DlAMTF77YxUIB1U2xRnygyDv42UbBJSkmGmcJfA
 VX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737965170; x=1738569970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRDFifUSykghhZo2AgAcnmAVAVfzz/ZXaFqrQ5/35Ro=;
 b=J/iTaMM2M2BFmVbXz33I4n6efFaieyBzhoEvrgVcylwZDENJpMdkM6QcN3kjKqY2ss
 cQRq/qak2PO+UGx74gxTVAGf6e/0sGiXgG8RZHAKzvC0M1BvOGBtiNOCI/zYIlkDW9Nl
 lOZb0gqJ6lhCWFSk+CIHdxILMisOVKprzen9J/O1ZTUQ0hdVI4FTEYiMQiw/XO69cuSi
 0GJrzN+ZsY1VqBJwnB9HowxSpL7XTCgs7bd3LeZPtoKs5mG9CdgKz8Nk0aV56foVvko6
 hH/wWdFX4sE/saH3ARHFgOrWO6q74t5lMnDH5VQ+Me5LL5crfha6e7jxX4+bG2eFXsht
 0TWA==
X-Gm-Message-State: AOJu0Yz+bxMqzr0LLpSNziY8BiIRq3ZXPJ7rzgweenU6/caMVuLwu9lv
 XdwC/c5DxkCWJbCz4zS2uTjS14EaWYeg5gVXOgxokfZ69ySfsZYSQ2YzPdwT3NY=
X-Gm-Gg: ASbGncvYSg4+nb1ivu6adKogj1fFdJc84I1wpSx4wxo+uf18IsZyfjCTtElBAw6RMHg
 Z4Zfyl2y0fe6e/fSEejUP9big0LTIADuV1rRqm2K9haGChnUCQdtbZIw3Un+impUvBqQBkRN5RN
 GKUcup78Bm+8ewNhWKDQacq02q43x02IYIRED0ykSHZT4wHTS1yPElol0gqKkMM1Ih7dfXzy0sB
 nVucGGoHJSqbJSTuJWHsywCjN3WvsJkQGLHKrMH1v9Tfaa61FBc9wWCf3hMFPjBCtWCjsCOBcCj
 KRGM6B+gISdFtHxUaEBbhRjZGMolRDsxkpDR/oTS7PbupJp8
X-Google-Smtp-Source: AGHT+IFg7/mUPKBN/mM6PW1LQiacIdLORSuEIWD+zXq3W1Q+I+5sEiovlW+kacyejyZ1ShEcvJhhIQ==
X-Received: by 2002:a5d:6d82:0:b0:388:c61d:43e0 with SMTP id
 ffacd0b85a97d-38bf59ef478mr41661468f8f.48.1737965170570; 
 Mon, 27 Jan 2025 00:06:10 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm10518840f8f.69.2025.01.27.00.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 00:06:10 -0800 (PST)
Message-ID: <4ab5cc49-a8c6-430b-a3d8-82a62f0f0fe4@linaro.org>
Date: Mon, 27 Jan 2025 09:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: Introduce class_post_init() handler
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-rust@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250125165855.32168-1-philmd@linaro.org>
 <20250125165855.32168-3-philmd@linaro.org> <87wmegoi6g.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87wmegoi6g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 27/1/25 08:00, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Add a class_post_init() handler to be called by parents
>> *after* child class_init() handler is called. This is
>> necessary to have parent class check children properly
>> set some values or mandatory handlers.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Plausible, but I'd like to see actual use.  What uses do you have in
> mind?

See for example:
https://lore.kernel.org/qemu-devel/20250125170125.32855-25-philmd@linaro.org/

Where the abstract parent CPUClass checks concrete target implementation
registered a handler.

(I'll cc you on another use shortly).

