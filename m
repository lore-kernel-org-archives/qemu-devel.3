Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F50FD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM1W-0004rw-HH; Wed, 25 Feb 2026 16:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvM1U-0004mk-48
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:02:20 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvM1S-0006Zt-M1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:02:19 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso101507b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053337; x=1772658137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9IJfnYpw4cimNjTA9Hf3d6yA9sCjXuVzeCaUAzcGwuc=;
 b=J0P/6Ti0w7pOwkMRSTN/Acw2yZxqg2zQn5pO3UdfCp9RIhZd9+ptd+AfsIrw7/H/f5
 sfMdvHeabpy3ybndqI59C9NYU+dkpzAqDJEWifV1QMW9J55242MBCxb14IAkQPhn7NWp
 /O4nh8fva4fEYIcLy5Ww+FfUvwQ0eJAXmTc3MaQouLxw1Dd7IRWN33/bpXXuqEbhv2Pp
 Xo9I+hFG2/X0ZgptKbQEuK1XN7qAz5OiTXU4tUCHCZ5PeV0ZqO5Wlprh97j16TuzSOnz
 g30HopeNpeKp81pmcupJlW+TTpaCsVNu9Nha4bhC8zFnPHkYn/UdTMLmEQqWzyd21yss
 JOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053337; x=1772658137;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IJfnYpw4cimNjTA9Hf3d6yA9sCjXuVzeCaUAzcGwuc=;
 b=W+kOWLXhfkp08xm5wA6FXN/mplvaaF1kDIEfYHloDbRVn847tHs75wMl2/5sbUgyOG
 0uBSh+Pyre5ZlRHiTzenIWXCWi/R3O3p8NbBCG1BXMsmEdt4zD5JX7TeWcTYPURCcqS/
 vop8CY0tSP1Pxl5fOwc+WE1hSl09H6R4lbeRvfk18b8Ixvk2U79EspXIazjCKrjceFFb
 M1XtuudTQqIMLwIhsZ3TFMV8LXPpd9OwcTcygie8SHzJkO5CGIbX8/T4UJ4rqpRAKE2U
 E3HirezCg5nogydj+sFgdleA2rkuf9hWJvBCdJXt4cWUBHG4oShtkB8eqZ0trPWfC+DH
 D2Cw==
X-Gm-Message-State: AOJu0YzDLwhTv1aLGVVEEyA5Imi6JwfHXI83RawFJKIt91HmcIJKC/sg
 Phq3Um/TLgAm+aQo44xf3NO+5oCvzQo8WovotlgPOz4xMh3e5jq1TM7IEGC5m5mUXdhKv1CQAy+
 qMSSl
X-Gm-Gg: ATEYQzxnV0HF+AlINbAJz5NxxuAOeS870vP4TKD4PWDTe/q7CHGHlRBjemkWgthsqqb
 9wYbdORC/6ZjSW5u3FGfV5qhhP+Fm+DQ2rE3nZURHVNK0uVc/Y5vd+8zQpZXm02Lspqnt2ggSzJ
 T0QNYvuiqko0nwBYMRIbl0Zs7S1wR9CbRzx0NTBGvYkHkYmz9qpewsVB8b217X7lG44CHl3/gWG
 lQykSTxwwQB0Rn4SIFM9AdzjoguRsh4XdoTuBnPwucqgLi5fZUtiJ4tURwb4of/cjOkzK4mOYAx
 UMgStodSUmMmwMbh4KvZ22nON60M0eSFesgtTLnBRngg5cBM8NTafgXQrSxUyWJUjxml7sfMd2/
 0CqP7WTdPE79QIN6xwrYbd8iwxAAMS11aP2OkBpXP4AgfcYmlAmLIguGFqHLtWrlRpMajOtRIdi
 VaC12k4ChVEZ/vbprxOS3NFJTT/0PoK420RDb7v32U3/oGFPp7JAit7J5LmjCTjVY8ZW/F
X-Received: by 2002:a05:6a00:3a13:b0:7e8:3fcb:9b0b with SMTP id
 d2e1a72fcca58-8273986944dmr296646b3a.33.1772053337267; 
 Wed, 25 Feb 2026 13:02:17 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db3e4asm153225b3a.28.2026.02.25.13.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:02:16 -0800 (PST)
Message-ID: <996b0b2a-5c7b-4b1c-ae96-d4b08720b1ba@linaro.org>
Date: Wed, 25 Feb 2026 13:02:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
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
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/21/26 2:16 AM, Tao Tang wrote:
> This is a non-functional preparation step that adds storage for
> resolved security state in SMMUTLBEntry.
> 
> Together with the earlier commits that added NSCFG handling and
> PTE NS/NSTable helpers, the plumbing is complete and we can now
> refactor the PTW flow to handle Secure state.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   include/hw/arm/smmu-common.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

