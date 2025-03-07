Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31929C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdNr-0006ea-0m; Fri, 07 Mar 2025 14:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdNd-0006Pp-RW
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:29:14 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdNc-0003Q6-AT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:29:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22113560c57so43068865ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375747; x=1741980547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vM/4GoJmU4Et/K89F5VksEx/cMGKR1QrYk0VLQEpzK8=;
 b=kI1bkcsbn2vOIbjsg3mcm0rMxQ9QgRZ2pidqK6JOqytD5rbo/ruPieK8BLSaLv1lLt
 EiWskDdH+o5AjI5XiONck7jdqtSmAvF25Zrlnqt96+sCxwBs7zfzwPGmSRXWfT4wFGNT
 yZu20q1HkIMjMIZh6RmVtFr2FFfW5cW9QS2RSAzjCTYpu1X6mAhz/eRaz+PsHtbQ9b6d
 /rY9EJbFcQknbfnU31SWcTzR0ZlGE/qit94DzzM0+tc1afIfEgpq9BhuDiEBMTNfJXWR
 Yas4i3XnCkf0SoC/aoTuJ20sMe/n8R79gU1NHc2udDz90NSr3oEq/PI8PhUWUBBcgcHr
 yYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375747; x=1741980547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vM/4GoJmU4Et/K89F5VksEx/cMGKR1QrYk0VLQEpzK8=;
 b=lMKHZU8Bfw5alrZuqTvNr6DXHM7HxgFoA5mj8fXlRoHzA5+cHjwdgzEdtVMnAU9M0o
 S9oG43RbIYm3/rhTY2J8gztw/ysqZculhY24LdwFO1PHN62+S25ka/H6AqMTN62iSmbM
 omZj4Jtl4Uqb00TdclqFD/LmcGQSGtubwm+CWVDz4MsCv18h3XBsYjJmxaATCZvkrZLO
 aNs/6hJnDbUu2aGuwgC6lffymjAq7Q+zvK7K82yexXLi/BiUFv8sHafiVaq6o0jSD4ug
 KnMTXKyyx+0kSFX7nPWQH/d0OS7Lt7OGabG9D6d1INZk+k9dUUk0kkzkb2iFzqbRZXc8
 mXrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAx5dl2URLUqTNZoBxCrKMxJZKa+sfGP08N7h8fiqpAjmvK4ucP/9/01l0w9RJ4yjjBwhjTp6+xbhx@nongnu.org
X-Gm-Message-State: AOJu0YytU+14sgeVJkkMGjDlt2wRU0PSlacEfK6GsUN1Fp4nlT3GoPGV
 XtDKOnHGgqnozEqPvZjodLn2wJOq1rwmYOtfTYnp0/BSHA8J7WN8wF8cTRFK5HM=
X-Gm-Gg: ASbGnctj5Mk5HT/SUvqQtPHUdfSE7v/erPIgWRc563NXm6JEcVXXG5gazlTnQ8sPoIn
 Dm8Sun1EFr1mrJMQOl4knIRAo8wrmbzAy24lOQMFsqJl9s9ymUXivDuhVtoJcH0u7TFzoi/LjO9
 EoWv5rFPhejG5q65I50BaASXJTMBLhJymmFCv4Bp+7i85kFalaiy2ytMcrOOlm7puY8tAWyzNI0
 4UMiaPPya4ah4FrSKoew08Zquv/1G+0IWEwUkPjjJtQ/QAuaAfdCsK630Go/tKvJRrv2FYgnjD5
 A5RF5MC6bJHEcZ374QBUcCR+cKTHufL9H1ayVcDlEQhlGfTIj7C/ooK4HjYDNux+KvfVqN20isZ
 9SvpKk5To
X-Google-Smtp-Source: AGHT+IEvHDSiQH/iV/bTf4XBW74jV5IfsDWGNX3u1y+rGlmccMUjCSOJWBwalVKFe1X3KfgPpwUc4Q==
X-Received: by 2002:a17:902:db08:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-22428ab7321mr86229875ad.35.1741375746847; 
 Fri, 07 Mar 2025 11:29:06 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109dd5edsm34064985ad.37.2025.03.07.11.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:29:06 -0800 (PST)
Message-ID: <46f3fb62-1b2e-4f49-a28c-8f1040d9595a@linaro.org>
Date: Fri, 7 Mar 2025 11:29:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] hw/hyperv/hv-balloon-stub: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/7/25 11:09, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
> index d3d2668c71a..f4aa0a5ada9 100644
> --- a/hw/hyperv/meson.build
> +++ b/hw/hyperv/meson.build
> @@ -2,4 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
>   specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>   specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>   specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
> -specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'), if_false: files('hv-balloon-stub.c'))
> +specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
> +system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

