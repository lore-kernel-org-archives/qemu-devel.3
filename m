Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FD7C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77Jt-0000Y9-BV; Tue, 22 Apr 2025 02:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Jq-0000WZ-FQ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Jn-0007nv-Ak
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34463605e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304076; x=1745908876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9rNr4hys0zfLgUPvngT1iGKY6bsdEbk77gsdKeXGZdI=;
 b=suK22W2M2L3XmauKYScc/TvLpC8f0ywiM6NlDtHg0QmMv4AfXPA1QijP6wmGOdLCBW
 fvj3qJlfeT1AmM3317/pBHF5FaennUZi4wVtlpoeaUIXIL7rSPoa5l5EA+3REYTS7Jdz
 BW8JlnfcKSJkI0ay4P//nXp4n2J3iiyrOqT4eaQhW8njcNAO1AWDV7XIE1XORcZhR6pp
 AE/sD0SeJ90xyTnBRo0L7DD7jeSnfm2wkuANKRik5d7w/RT3rD8LGv3YVxSt2bRIr3fQ
 i0CwbJBvxBeRS9u/IPtNlz+WyIvI6mgna3ll/fx8FegNmpwpK/ndj69GKur5EZ3/8pXx
 GyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304076; x=1745908876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rNr4hys0zfLgUPvngT1iGKY6bsdEbk77gsdKeXGZdI=;
 b=E8TUgN1+AW5krDcnwJn6rcCY+FEaqTktKC5FHn9JvM1Zvb9Zo6lIWleEjSCx1p55WA
 o8f6SqAUyjmZCFlSp3sW2y2AZgXHd/mOH740g5tjAtUy58jAMMANSyj09hazIEH7Mndb
 /u+kEJpLpIA6rrCwFia4S+5DsbddvvS1kouL6THzb82vzruoFjfTKiGBPFo5DMIOG864
 TZnULHOElxqJD5kBCehepWGuLVr4xGXpV7EBMhDO7d+kbL1ZDx5FoT5xMq0D6LPFS87Q
 T4xPoYl/1e34wA9jXszQgVpwjVgR9LV9BuW+TSlhlOLPx1ZoLdJXoEtVwt6Ux1jYUXj2
 73gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe4kbQ6Uv8CfDTDL0XwKRQIgSTZ+aDtVx7/iCsS+8QBLMlhGF8sN3Gunh1Q5vkLCznd83ItU6tmnVL@nongnu.org
X-Gm-Message-State: AOJu0YxQQxL80Xet+SAVffWHukIz+IosjDppbnMqgQ5g+6uBwjiw0x2o
 qt6uVaW+g9GXIizgXtRlMtMW6ZrIX0FCNi+zyoVkcslcbgkSMavqP+baKacyF/c=
X-Gm-Gg: ASbGnctUH3T0S0Wfp/8+qNElbomrzPRcRABb1Nm/o1memL4GmFb7QzDUupj8s0L7XQv
 SyoyfFsFG/Oq4KY2mHFPcpikZ7JlbX5TSCQowdRXHz36eI7Trcv6pu2dMRrTWPgzDAutPX2SAzN
 Hgs3ymjDMOPSYaIZP0LspU/Bsys5x0spuHGVSTCSYOc/cfls49pYHddW1dt9psggErY1e57b/fH
 O72apgUD8D4AO3gtrwuTLSKeVsl3vAjlqhOBFin1OPAstbFVEwmCjDl4SZEIMgIlIWHGtUio88O
 /G3eUbCKGBv04W4NjWSd04ESF5sJtL+XQswsQ5efW690eqKAeFaKrZmWGSWgqhXQOKP/Zrne8bJ
 2k12PaoQn5KN6yPw+1hM=
X-Google-Smtp-Source: AGHT+IG4ZtK+iwu9U6jyXYYM80D4F6KIt2i04bTCGsufr5gmlfhiFb1M0CVJcFRT/FLpc9QsD6nv2A==
X-Received: by 2002:a05:600c:3485:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-4406ab7b67bmr113462525e9.6.1745304075976; 
 Mon, 21 Apr 2025 23:41:15 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c80174dsm7224665e9.0.2025.04.21.23.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:41:15 -0700 (PDT)
Message-ID: <415b113f-000a-4744-8ace-49ed0974d1fd@linaro.org>
Date: Tue, 22 Apr 2025 08:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] system/vl.c: Fix type conflict of GLib function
 pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <e9a50b76c54cc64fc9985186f0aef3fcc2024da6.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e9a50b76c54cc64fc9985186f0aef3fcc2024da6.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> On Emscripten, function pointer casts can result in runtime failures due to
> strict function signature checks. This affects the use of g_list_sort and
> g_slist_sort, which internally perform function pointer casts that are not
> supported by Emscripten. To avoid these issues, g_list_sort_with_data and
> g_slist_sort_with_data should be used instead, as they do not rely on
> function pointer casting.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   system/vl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


