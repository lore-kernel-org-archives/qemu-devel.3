Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FFC28B25
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFUf-0004qd-Vd; Sun, 09 Mar 2025 08:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFUe-0004qD-5s
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:10:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFUc-0007mr-JD
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:10:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so1085527f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741522252; x=1742127052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePHuTVHFTU/Fr3lIDVw1mtDTdZbcL7KDZ1AWGj/HcfE=;
 b=rIbvCH3ZAaHFw2n+QIiK+wSMmCWIwEFtgspB8wrazTxI/ERxM0/2FtV9swVADsowqP
 8Cd9ZuvUoS+OrkenhIvmD/6dxpt31BJOUVZAA+XDS4qITM0Df0B2XwGKiWw6NS5amdfT
 XxCODr9Lm9dfFWvcIYuTeie+AGxNJshdBtmrrxIAngUqoUrRIVZpqEtbwBJgJanbvEY9
 wESUJ5inJFyTSxSuterAOZoEg1manTV7zju3RnCIlabMkxv2vENLGdvNuuE+BsxMt2Rt
 pbaLeNyD3sRZqZajLIM8Cmlalv5ww1RnyExV9/OGht1s9oXfE+Zn3mnGM1TRMjhKY6ev
 Y97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741522252; x=1742127052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePHuTVHFTU/Fr3lIDVw1mtDTdZbcL7KDZ1AWGj/HcfE=;
 b=FCrGmeVlIbHCeAYCAJGVZB6VhhkijaRko0AGFe70iAInCfNvCzW+u9DDWSmWa/DaJ6
 Xi4b8M7VFPQHG2JjcKVr6NuTkydhcFXo5nnT6mtu0lC5v4o1f/PjN8cLeutLtwdUrujl
 QBQX1GfKsiNlkVrBLwnBexvmjtv9HqW+AWbmMtv1Rg61bBmqQ3gLZI7kgBffQz7z/Rv9
 h5Sy21EuFfVlYegqvE+zMIBLGcFOP4UzfzK/c/HbWrfKzorR6zKxW3loYYFObPbSqL62
 7P/3DfUZVcEYLoMpyLjyTG0aNmuh/n7LRBrIOTL7JS9XBLI9O9lnYAzzz1rUdeE7jyd0
 J0gQ==
X-Gm-Message-State: AOJu0Yx8bwWIbkYC+MqZROQpNm2BhXSBHxSWn4IpxFFDtBbBUm51wAaa
 zO+V3liNry38jgNu8pgXlPFVdkXtm0+c6W/V3gBaT6IgmSc8nKviuc0nJMhR82jdQ55FiDBldsT
 AVSs=
X-Gm-Gg: ASbGncs834nGmP4ztiUy7LUkDd1iOZIEBGqWQyaMj5TXeGDUO0sSZqsPCu85LobpZBQ
 qvM7wVg4ERUDDdhQYQbsWFc3mEtwFYaSjNID9pGEWf2gZZUOKnIKBnRFVUWx4beiFaCvuxoxKoG
 vD3nlgPeYUpJuxaiIiHEfuIl93dZJp9be1zjmE4L1532eT3CTH2AEJgo4RpqsoZ0Zwr47OeFEiz
 H98baU/Qrb0UbQ1cEgZTbpFhJyLLRx+LK1dLKvTv7pJCc+e5NrQLR5ObT7j7OKnebpMy4JR+CGd
 BWBT+/tHAVexTNYIBpouK4rFD8j85wYwqtuJBic4Oax+rlcXAebvdbxu6D+dbZd0q52CjNDoXgD
 wutZV4Wt73H9+wfz4ddfa4zk=
X-Google-Smtp-Source: AGHT+IH2aMfJpuE+zUnqsLdsRjFFsI+6T+nzeYR5vPyg6ipqVA+XQFx5WHft/TYnbb2+kKTIHW6vaQ==
X-Received: by 2002:adf:8c09:0:b0:391:3915:cffb with SMTP id
 ffacd0b85a97d-3913915d422mr4358669f8f.43.1741522252289; 
 Sun, 09 Mar 2025 05:10:52 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f41sm11563615f8f.85.2025.03.09.05.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 05:10:51 -0700 (PDT)
Message-ID: <43853b50-6165-4383-bd58-8295f0ef8278@linaro.org>
Date: Sun, 9 Mar 2025 13:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] user: Extract common MMAP API to 'user/mmap.h'
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
References: <20250308122842.76377-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250308122842.76377-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/3/25 13:28, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    bsd-user: Always use mmap_find_vma_aligned() in target_mmap()
>    bsd-user: Propagate alignment argument to mmap_find_vma()
>    user: Extract common MMAP API to 'user/mmap.h'

Series queued, thanks.

