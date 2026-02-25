Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF8FD45F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 20:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvLsF-0000sv-O4; Wed, 25 Feb 2026 15:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLsC-0000sO-9p
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:52:45 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvLs8-0005Om-Vn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 15:52:43 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso207828b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772052758; x=1772657558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+CjhqJS/rnKmF2c/ep0+L6f/EiuaYSiBjODpsO0RTQ=;
 b=mw4wB10YW6Mck4PddW9PAlI6XGMWbo7uPsKzEi+S7XcTNVLab44N3pY7VKko0lEkLO
 WwTOnhBcNVE835L7htJ0CK2DiJ2STUyEM8NtsbQ04UGG/afIb1E4Yw503N8KtgN7lfEi
 uDRhWHTL1UCVdgpUSl/wrDrYsMH4I50e6WTfxR8A8xtZ+gj+pVMB9e4GpgGhVytEY4NX
 N/EBpEScFyQuIEJpoAVDZZY+G0QMvaxLaAEDenCGKmv6rhp+h80ntZxISYDCD3vRZl00
 IodFLfV+tIbQOt6kESN1GEQjJ5TpbX4TITqChjmvkH8vrO0BpePy+x2tJfs/oB8Dd3cn
 TgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772052758; x=1772657558;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+CjhqJS/rnKmF2c/ep0+L6f/EiuaYSiBjODpsO0RTQ=;
 b=gYJl1z+rDKuhrpf3M/YmMA74PPfd0DrbMiPadqcH/2tBUA3VzV032SAasPkfNN/hyW
 r0FI39G1KEbUBAYC0QBFqrc0F9IjKjNv0d4982G022hByPNfp5ihRlIpEoUKA4Ucd1fR
 S95mU73/48p2WYuk3icpU3xuNvgeVAg6dqcHxsPYfFs0Vis6ymEzUBn5rPDSruFa4XD/
 tG40r49Ovsp4Ru3oGYGXWspfxE7fwT2kMjMJmPyDRtv1CuCn1y7v2VqbvaD6CbFfggCo
 EnMAHuuCGLg4yMSlOEtVTPAmS0ZexdJ8o3m74YVqIKcFIzIsqZb/afbGjoIaLasAX5hL
 Er1A==
X-Gm-Message-State: AOJu0YyaAoC6k7TWby1/eQURRHtvyW025hg/rzBO8igqXs1jkVTt1mWM
 L2SIU+iBRnofE22uXDwG/IfFL8kREgpCVxQTVOZQVtnjoih/RKAJNR7AstkDDh7Yyxc=
X-Gm-Gg: ATEYQzwurloLJqFMBnLkUI3XuGEEjokLzmhZSZE+afjMKcg4vSkC+v9TEsc7eAaqf87
 SNDt0zBKntYvgHfUScSCA1N2MdxSVramnXmCZAqp3HUhxewxosUS59OkHRRXghbMMiTZ6kt4rgp
 oKt86G8jpu5TFBZHnlwJAr6SN7rakEj45Pd9GWc+Ju8NEeqiylUph9nMcyCBAJfccOzLhW2Q3RH
 x+huZzARxS7Vs1l3kN4l0xLChLYGIHt9slpoJp4zZxVEc+JhWchiSmUplaPlqcL78trhUkpHAf2
 gKrZ4CLORE0TH1CUOeR6+l1MKGLUiPhJThgwnaGvUyBdQdw1jkIX7laizAi+Jz9iQ0AlpbA0tQI
 2cx39nUfTBthKHCQz7wf0jnrLQl76U2al9WO0oEkqos8aOaZTe2uyufjXFChf+vGugoNPxY+htP
 zknMmd+w6565WHPCvEs/IczfpwYyvpyu3nU1Nyns/dEQCLRRs7WCAe1bpG5NzIlXef8VsKqC+F+
 ZROe7s=
X-Received: by 2002:a05:6a00:949a:b0:827:2a66:1fc4 with SMTP id
 d2e1a72fcca58-8272a663da6mr2245705b3a.28.1772052758149; 
 Wed, 25 Feb 2026 12:52:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a01a99esm124657b3a.47.2026.02.25.12.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 12:52:37 -0800 (PST)
Message-ID: <efcf906c-011e-4454-93e7-feadeaa16a53@linaro.org>
Date: Wed, 25 Feb 2026 12:52:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/31] hw/arm/smmuv3: Enforce Secure stage 2 capability
 check when decoding STE
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/21/26 2:02 AM, Tao Tang wrote:
> When decoding a Stream Table Entry (STE) from the Secure stream table
> that enables stage-2 translation, verify that the SMMU implementation
> advertises Secure stage-2 support via S_IDR1.SEL2. If stage-2 is
> requested but S_IDR1.SEL2 is 0, mark the STE as ILLEGAL.
> 
> This implements the requirement from the Arm SMMUv3 architecture
> specification (IHI 0070G.b, Section 5.2, Page 218) that a Secure STE
> with stage-2 enabled is only valid when the implementation supports
> Secure stage-2 translation.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

