Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958E6EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMNE-0002tB-H5; Sun, 08 Mar 2026 18:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMNC-0002sS-LD
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:13:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMNA-0008QA-JC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:13:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso3982225e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773007995; x=1773612795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsx74MyDH7KJyFPLeVgbpBGFYJeh8RWY/evLyakF4cM=;
 b=U2SdZD8wr7ukd0QY1WQpwD7bPvBhFUj9WZSNymO+FgytuuuCaCqnYmme9S9o2FA7uV
 rD2ksV64U22JwRu4JyUqI8YpCqbU5kQtUX5FskqYBhNXrCIvx9kUFR0MQ8+UR6GxdPPz
 GphqHPRoUfJK/3oKItqmnmjx29eZyV9aCe5rIBgzch1Zs0OHqnMOuyGajXnp50r+U2SV
 rcsO85pvXVsOtaZB3nj1XWJ9saJfSl7j+/dx2Ll9pwF4iPtIPw61dxjcThFHcxNrurlJ
 qCoszrl+vTX18bexnjc2Nay+nXHS/tCF/6hU6DtHLkDheQ8Kr579622W29MDDLpQ88B7
 C68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773007995; x=1773612795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsx74MyDH7KJyFPLeVgbpBGFYJeh8RWY/evLyakF4cM=;
 b=v7Y015jLmS54zwFqX5s9prk+T7/vYbYtz7Aat9noRCwF0fOg2edOzupsqEdV+7iEri
 T3bX1eIU/doncaS54TZAv2JJ+eSd/QN8Sp+uRA4LRXXjOkmmivj1AqcXP+GmHIEW8v49
 toz9B1k6ftmHQMY7wHs0/zfbBCHYNJr6jtM5xnK8CY/dPaerLbCt6MbSzyJr1gWhA4A9
 g1v1/gKxm6VP63Ii1F3QnPAb96xUGH37+PvjFk/MQlMp+J70ZYD9l/I3mXkfk1yxU+60
 JE2C7xASevCYr4j8v/FtFO/JFeduqar7iEP23P8t2EsIE0fVc4tUWzel7AK8nTuVIDWu
 AK0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQa9qLdQCQkKkxhb77f/y7MGZlKOB+uZUe4lmlbzDyIZ4qZFZwZ1ncJ5GonpcGYUNYY9Kj2/bBi1Mx@nongnu.org
X-Gm-Message-State: AOJu0YzfHDWYOrmEVfSDSemVOjkJGEXPyMLVVDOMJdgtNdajmBz6Ri/V
 VZEMZ7aKZfi0Im0JTQH73LBA0QnTI+HeFe4iOCe6EH/tmJ9boaRRyLqJFaFRskCQtts=
X-Gm-Gg: ATEYQzyvr9Xck+h3gxZlWEeR7ruZHvxT0do3HFyog5tKxfQyW0doz/cG4WW5EdSRdRY
 9iXUXyDCBUSla8MSdx+mEmN+yY3j913vXZITOIOpWWWkLn9peVM0d/zSObZnhNySkj933+bIGUf
 IR6GzaV3m+YEG1V42Zw142jCjmx4+Z9HpZSANk4jmjHb3OhEq/Ht+gJrAkGs5WYgtWOUOXYzrIB
 8ux2nsyzyvxGj+02zSK6ZwLckyH9Ar3Cdhrbr0Sv5Mnmtau2AuS2H0pxkZwB/gbR3bqCEBKi3ST
 xcD8ovVaDypNFM/11iQdg/H4PyD+j90L8GhY4uqayvOnEMcg5nybD51rUWQtvKfIYmh/SEOUCxF
 fzlgyYBgNYudDC0a6tAAjk0eaWwvWyhOnm3bTdYx+bY+Bto2q6NoYlic86ArRhvnmDcWxGIEofh
 gGSN+4KMccx0q7/VBJqz552JtCTUb2i9xQgtoNTMs1C0zrTv554V/YrImRjn+IhD+Qag==
X-Received: by 2002:a05:600c:138a:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-485269196ffmr173793425e9.5.1773007994646; 
 Sun, 08 Mar 2026 15:13:14 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853616a085sm33693585e9.3.2026.03.08.15.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 15:13:13 -0700 (PDT)
Message-ID: <2fdfc484-cf0c-4d91-96b8-4ca0e1bd6f76@linaro.org>
Date: Sun, 8 Mar 2026 23:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/xilinx_axienet.c: Prevent writes to PHY
 Identification registers
Content-Language: en-US
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org
References: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/3/26 13:13, Jim MacArthur wrote:
> There are other registers in the PHY model which should be partially or
> entirely read-only, but this solves the immediate issue.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3297
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---


> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index d85f8bb23f..970732b162 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -141,6 +141,10 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
>       regnum = req & 0x1f;
>       DPHY(qemu_log("%s reg[%d] = %x\n", __func__, regnum, data));
>       switch (regnum) {
> +        case 2:
> +        case 3:
> +            /* Writes to PHY Identification registers are disallowed */
> +            break;
>           default:
>               phy->regs[regnum] = data;
>               break;

Checkpatch.pl complains for pre-existing coding style:

ERROR: switch and case should be at the same indent
#27: FILE: hw/net/xilinx_axienet.c:143:
      switch (regnum) {
+        case 2:
+        case 3:

total: 1 errors, 0 warnings, 10 lines checked

Anyway, queued, thanks!

