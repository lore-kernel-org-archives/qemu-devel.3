Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8041C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFxd-0007xA-9b; Mon, 18 Mar 2024 12:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFxa-0007wK-Eb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:35:38 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFxY-0008PJ-TO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:35:38 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so5774347e87.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710779735; x=1711384535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VWxrXzjZ+6wi5AGBZhXYkgtdBUbxMT0Pmi1L1yNtdSk=;
 b=Whx4cfc8JpBh1JbJtHqmtMUa/AoJy2NPwNF45rgPYY6YYx8zKjuz+u4ayFJrxeQges
 tDVS1lg+X8Nl+B4h4EtEEcGOmxheXg3Sw1hF2oChz3L/Dwjvz+R4gTccPjI5a39DMIOs
 mh1R2IM06JFIaX7By3nxxzjbBUhAGwToK+taE6N3Uq7Qt5FdhEK8WB9l7uun1N2MjTgl
 q76NhiXr/u9PYXymNfUYUEeA7jDJtBi2H6KxBiWwhL+Sn55QCaG3Ora+y2sWvH9HP9++
 yVnzw33FPRwdugJzeb02GVjJ425fFbhq/aZreXrXO3OAdZqdwYhoBQN93dpBHQm7XkFT
 x7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779735; x=1711384535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWxrXzjZ+6wi5AGBZhXYkgtdBUbxMT0Pmi1L1yNtdSk=;
 b=JWey/hgoqk9v2UJ49C21z7OPmEFSk/e+EsPLACmhMyH7g4XKoBk4lWG7ORbDsv4T3o
 hGSp575wFIRNx3znAO3SyH9tszfjmEJiRXXuzNX2PyJ4z5pke1JmHrwW/qeDeW0y9Ml2
 uAHfzbHK+wW+6cx13NOlhYiAKTWLFTbUcnkrAQLgkpkBxBwSfkAYIefHeG+wQOQgaUpv
 kewRMFU27WCPBEaVjgF/Q6KiVnNdZjv/2g9/LcJSUUGQITfmDcoCH+VptjrQuZHmfPWb
 dtfiMe3Q9A1so3NYk5JIHLDsqzcbaXGnfziR8wsnj420jPJScuw7lyM7s4i3gBVKIaSp
 E7dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMsJJVrtUmReUJzSE1EZFZiXe7fT+IwyuM9DiJJzKLWcjtjAo8YHGtWqnMfTks+U3f831g4jxOqckFB0ShP8y1uA4Q774=
X-Gm-Message-State: AOJu0YzMYgjmGV/P/+rVd9TfL9FUa8Ay7mChfpEBB1/cIC2J1tQ8qhIq
 pEWceGjxz3z+MR7y0FQXD6M8dIESYWKvHyAVjbh4WQJgG0+VvqkNslI5w4DRcP4=
X-Google-Smtp-Source: AGHT+IGuO4g2v5sfPhq0BPqPtEYCI0u6qRHJzLyU9A9CwezH+KbCuddc/7M686lPDKHNoZ1dbsLeWQ==
X-Received: by 2002:ac2:4db7:0:b0:513:d0e2:8a1e with SMTP id
 h23-20020ac24db7000000b00513d0e28a1emr7768732lfe.54.1710779734988; 
 Mon, 18 Mar 2024 09:35:34 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 bg28-20020a05600c3c9c00b0041330d49604sm18520814wmb.45.2024.03.18.09.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:35:34 -0700 (PDT)
Message-ID: <7fdd2a28-a9d3-4462-a688-0199d4dc96cf@linaro.org>
Date: Mon, 18 Mar 2024 17:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] tests/avocado: sbsa-ref: add Alpine tests for misc
 'max' setup
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
 <20240318-sbsa-ref-firmware-update-v3-3-1c33b995a538@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240318-sbsa-ref-firmware-update-v3-3-1c33b995a538@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 18/3/24 15:08, Marcin Juszkiewicz wrote:
> PAuth makes run timeout on CI so add tests using 'max' without it
> and with impdef one.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 259225f15f..cf8954d02e 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -140,18 +140,36 @@ def boot_alpine_linux(self, cpu):
>       def test_sbsaref_alpine_linux_cortex_a57(self):
>           """
>           :avocado: tags=cpu:cortex-a57
> +        :avocado: tags=os:linux
>           """
>           self.boot_alpine_linux("cortex-a57")
>   
>       def test_sbsaref_alpine_linux_neoverse_n1(self):
>           """
>           :avocado: tags=cpu:neoverse-n1
> +        :avocado: tags=os:linux
>           """
>           self.boot_alpine_linux("neoverse-n1")
>   
> +    def test_sbsaref_alpine_linux_max_pauth_off(self):
> +        """
> +        :avocado: tags=cpu:max
> +        :avocado: tags=os:linux
> +        """
> +        self.boot_alpine_linux("max,pauth=off")
> +
> +    def test_sbsaref_alpine_linux_max_pauth_impdef(self):
> +        """
> +        :avocado: tags=cpu:max
> +        :avocado: tags=os:linux
> +        """
> +        self.boot_alpine_linux("max,pauth-impdef=on")
> +
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')

Odd, this tag doesn't seem processed in my test. Anyhow,

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       def test_sbsaref_alpine_linux_max(self):
>           """
>           :avocado: tags=cpu:max
> +        :avocado: tags=os:linux
>           """
>           self.boot_alpine_linux("max")
>   
> 


