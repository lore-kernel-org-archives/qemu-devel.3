Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD830FD4F31
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w02sW-0006Zb-1x; Tue, 10 Mar 2026 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w02sK-0006Z2-AN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:36:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w02sE-0003DX-Pm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:36:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ae5636ab04so99539965ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773171367; x=1773776167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=n2bcNOGv4JzTA0luwj5hrV+wm1NHSPPf0oQvbpWW8Rk=;
 b=J44i9bbDyI9OKeRk77Q81heZvLniA+Dtf7wLkhlSZp6BjPc3w7qq80oIsb/qglhRtE
 Xzf5DqlYcnIN6fGIeKqLKbogrpCxZHmHD1cwkHlY0UjLhJT9IvUgAh/jYczhQSps3RSO
 LEWgoqMAp8Cylb5Y6SwhHexQw6F62u6v+hadNCSJVpvYzSd1st32sp6tCdXYCPakUsUt
 UpFLUZ75VE4DVrCCX5CjJ0cKjl/5GbP0pJsObnQHG89c0O0VLYlBT8OzxHw+1iRZNtQA
 VnKgvFNAQi2Wy61swcr/IEUl2zqrSJUmTTNqQM/I4IJdwl5+LAXD4MONZmMTdJnjunnV
 COsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773171367; x=1773776167;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2bcNOGv4JzTA0luwj5hrV+wm1NHSPPf0oQvbpWW8Rk=;
 b=AcGwHP8CIWybUEIjnLTnS8vw9u60KVNdNnrbmdLsX751m3/u7eyorWJmMFfPzZlQWG
 dx+w10vFks8PPzlqfDbFHV2Yj9uhTO9qD0iCQbWe206oFLNNixuArsw7sUzQ0uBErS3C
 S4gB4TnEbkAF8EKqL0INIxZzwF7UOcADQjWHKVEk29ul2A7fNFERNXRcBOl7+p9MaQuM
 +KJsbZZgwzChMAKDTjT5IAG86XbFyEYyFbuxIO69GbLwmuEr9V8LZH5gHwKnTPAw6tqz
 3dBfXqVptbTCROpg3L0YaRT/yqBwElA6Sp9x9mCJnJD/ruVxqX6x3bNMqMdDe/tSB6mp
 2Saw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIFysHxWfPuw4M8PlGYLD1OdU+qvT7+lDuhXxB0Ahh05sSd7jBRDnXUX7/rkm2tnPE84oQaRZKjE8n@nongnu.org
X-Gm-Message-State: AOJu0YxnMwM9AGxoTfKCs3Cjk0MmtacaNvR17gjcc3/ZCZN/9Rpzsvyp
 e5Dr1SvFb+WdH1/jfBN05aygUTsnLSUatXcXnBbIylS4jq/sKh+6Lg8PkMSjeg4xXOA=
X-Gm-Gg: ATEYQzy2euE8WwgRSsKPErJYXV/63j65pjd3Vd23uIQ3rUXvfkAwhQe8aDNdNTn29l1
 wZMn98FjA+vIVd3O5BN1OFzKvDSRPqX54JaNonzunluEedKSE0NO9W+jfCc3BI5O56WLM/slqSd
 QglTis6rbpSziMVbQIZIjMyw8fIhq8wv6pL5c3NI+SZJuPNu639xnjcAPXI9oCSIzBOXHm/PcU1
 9JnE2fP4VxsjjBlx/KitUeQUIARN5qCVsR5Tt0TVnKiLEnFt2oh/PI6a7PCpPnd+uJWg3K5XjWo
 JkXvbL8Fy8v3YDKounE7ZtycQzUx09bpqVzB33bTmv8lsH1yzCMG0JibKzjVoxGJVf3LStyLRZn
 3qjEh3GnrZ45kmbpfdDWOxPbD2i1jwivVw0+Cdeb3+jQb1w5eU2G9VR2EKEFqnvDL6u2+YUCQ8N
 5BBxVkNjn+Hx/Jk1zgfEjnFTvysEQl1zn+/cK/l5i5XSUlkPNXDrWE/TnIWoJQSBBTs8Uk
X-Received: by 2002:a17:903:f86:b0:2ae:4029:2196 with SMTP id
 d9443c01a7336-2ae82481fa6mr147023005ad.47.1773171367228; 
 Tue, 10 Mar 2026 12:36:07 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae35eec6sm392135ad.66.2026.03.10.12.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 12:36:06 -0700 (PDT)
Message-ID: <2cffe423-e2f7-4198-b871-5721949be32f@linaro.org>
Date: Tue, 10 Mar 2026 12:36:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial v2] plugins: add missing docstrings to
 qemu-plugin.h
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
References: <20260310-add-missing-plugin-docs-v2-1-e9a91cb6974a@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310-add-missing-plugin-docs-v2-1-e9a91cb6974a@epfl.ch>
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

On 3/10/26 12:49 AM, Florian Hofhammer wrote:
> This patch adds docstrings for typedefs and function declarations in
> include/plugins/qemu-plugin.h that were previously missing. This
> resolves inconsistencies in the docs, e.g., the description for
> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
> but code cache flush callbacks not being documented themselves.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
> Hi,
> 
> While working on a QEMU plugin and browsing the online docs at
> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
> some of the API functions were not actually documented.
> 
> I went through the include/plugins/qemu-plugin.h header file and added
> docstrings where they were missing, hoping of course that I documented
> the correct functionality based on my understanding of the plugin
> internals.
> 
> I hope that's useful and I didn't miss anything!
> 
> Best regards,
> Florian
> 
> Changes in v2:
> - Added semantics clarification to the qemu_plugin_register_flush_cb()
>    docstring (suggested by Pierrick)
> - Link to v1: https://lore.kernel.org/qemu-devel/20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch
> ---
>   include/plugins/qemu-plugin.h | 101 +++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 91 insertions(+), 10 deletions(-)
> 

Thanks, looks good.
It seems there are warnings (and thus errors) about missing parameters.
Warning: 
/home/runner/work/qemu-ci/qemu-ci/docs/../include/plugins/qemu-plugin.h:883 
function parameter 'vcpu_idx' not described in 
'qemu_plugin_vcpu_syscall_ret_cb_t'
Warning: 
/home/runner/work/qemu-ci/qemu-ci/docs/../include/plugins/qemu-plugin.h:883 
function parameter 'vcpu_idx' not described in 
'qemu_plugin_vcpu_syscall_ret_cb_t'
WARNING: kernel-doc 
'/home/runner/work/qemu-ci/qemu-ci/build/pyvenv/bin/python3 
/home/runner/work/qemu-ci/qemu-ci/docs/../scripts/kernel-doc.py -rst 
-enable-lineno -Werror 
/home/runner/work/qemu-ci/qemu-ci/docs/../include/plugins/qemu-plugin.h'

Could you add those and check doc builds with warnings for v3?

Thanks,
Pierrick

