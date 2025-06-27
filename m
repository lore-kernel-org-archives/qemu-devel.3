Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B36C7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVFJZ-0003lM-Cr; Fri, 27 Jun 2025 16:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVFJ2-0002f7-KM
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:04:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVFJ0-0007nt-GM
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:04:16 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b34a71d9208so391517a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751054652; x=1751659452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NVc3lEG3HgIOLLighhJrXC1Quq3q+Kych/evABZhQx8=;
 b=Bq/O94TCgwQtvqj5J3Jq6KXAn7HE9K0gi6AN66lQ8AO5gxa1MR5H4EsYuWTVfJtJ/Z
 iQau0uQ8rcxZ/QWFZwB7k18nxUXIHvbJeoLvZt0okftTP0+ppGuUcyhxBp0GVDto30BF
 CmA20V5e5DxBr+y1jevRk87lJFxvv0b+qVUOo01UzG0jFOgkDGkJcyl0+oc3vuX6+1uy
 IUM1C1PrOv2rCI4TZPytjJsNWKCjJrkYkgG/Fc4TcMYjJUxhwGm+MDGR9JnEn7wL3GDu
 FSkMoWwPvnxPCFwR0C4eqgyFhq/RM8uWGu3a7zf3jWmJ5+WMxn/DJgy/aLhLAzXyS2RE
 3uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751054652; x=1751659452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVc3lEG3HgIOLLighhJrXC1Quq3q+Kych/evABZhQx8=;
 b=YnwhhwwXGiI2aM6oDynu+7RS+4agfD7gYwzuZXop6DrxASmapLQiQvshvclmLsDGB5
 PMFYG+Gs5kPmWGCWBeENJh6omgySzkyeSV1kwa/CwCrU5LJjdgsQ+KG1X3pa1cbTBxlY
 KKb7KdD/HMRwlhpaR6XhucFVt9OhTld2ajXnU4V20RPEBQrk69Q+25b2xP4te0VBGnvx
 jf9LzO17WobMpgjf2fLbyHayP/eh2VX+ByD+fSRrYyIICAYdCy3ED5AKbKh24rkCtfen
 n5FNM9HlRXvdImXNh3VncZG91hLrzvHityDc2ZBAMcQ6eSZdLEXD60QeBt0knRm6jteG
 XyhQ==
X-Gm-Message-State: AOJu0YyncGP4YPXrSkfBh6k1GBlw+bHhFCjPXJQTMOjnLOHzJjBau+HC
 K8BnaVX8ejxTRf8U6n3tY0MsWO9kEsmOs/n4rL7WSbzBHYH2fubYclaXjmpAc48Gs85wdEo5X7M
 86bil
X-Gm-Gg: ASbGncuVjwJeL0XUV6oxytJ91Tmrx3eWZr+lwcltyKfl4j98UPMZvZH1BXsDcAbeXXf
 qP+3a2DgeadOwGn75IEed8LLaoIRmi5WyDecnVB2ffUTRTDlx4yfi/MqtPFf+7Y1S1LvHe8Z+XX
 F1N427Uo2hEaK6XrHRBuX7mDUuH36qFBostvXfcYjckmTLtS9+tm1K6SME76taDeS4mCnB6ym6l
 prD7FMJCmr5MKt1ZLJUs4KXt1iGSS1GjZ3DlRcLp0Z/qmYAN12tDgfJQl/vyoKAgJJ3EQZrWJOH
 mF8ZRk/iffAyX5PBK0DouY9xcWsXhq08u8HzC4RIP9xGauqovKMWGjewrWR6CKIs2TuQiIZPrxY
 =
X-Google-Smtp-Source: AGHT+IGPvr5lGap3SYyeDTQILUDUbGFtze2ENXTBwTE+uQQPP9gB8n+nJx7OyMI7Xfs1J/ShtmingA==
X-Received: by 2002:a17:90b:4a07:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-318c92eeb4fmr6207325a91.28.1751054652576; 
 Fri, 27 Jun 2025 13:04:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3bc495sm23596685ad.201.2025.06.27.13.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 13:04:12 -0700 (PDT)
Message-ID: <2f985eb5-8c3c-4f52-b24e-4b3f5a126cd2@linaro.org>
Date: Fri, 27 Jun 2025 13:04:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, jean-philippe@linaro.org,
 alex.bennee@linaro.org, eric.auger@redhat.com, smostafa@google.com
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/27/25 1:02 PM, Pierrick Bouvier wrote:
> This test allows to document and exercise device passthrough, using a
> nested virtual machine setup. Two disks are generated and passed to the
> VM, and their content is compared to original images.
> 
> Guest and nested guests commands are executed through two scripts, and
> init used in both system is configured to trigger a kernel panic in case
> any command fails. This is more reliable and readable than executing all
> commands through prompt injection and trying to guess what failed.
> 
> Initially, this test was supposed to test smmuv3 nested emulation
> (combining both stages of translation), but I could not find any setup
> (kernel + vmm) able to do the passthrough correctly, despite several
> tries.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/functional/meson.build                  |   2 +
>   .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>   2 files changed, 144 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>

v2
--

- remove debug trace left my mistake (" || bash")
- minimized asset size (180MB -> 40MB)

Regards,
Pierrick

