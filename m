Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17285FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFS7-0007sR-5b; Mon, 27 Apr 2026 02:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFS1-0007sA-AW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:28:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFRz-0005Cd-JT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:28:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so57794f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777271290; x=1777876090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s4ejvdUYaq6DlsYnj34U2UvIjH4M78KlDPsl9ul19P0=;
 b=qx1EbSQefVuGFm9JIp/N6Zh50HGtG4Q8oyEH6RTt/aK82Sg/WGXm7nx8tQp5EpyZxH
 Gt7+gbLBeN6G+Y/cI9+l2uI/UPuXzKeQh2uJvnKM6FnDccuAYfKqi+uPU8IfwnJhOOTF
 wAXOuNBRWE2sEwS2OOkSOo7QPobleyyJgiY+ICj3KTDUk8AjPvLGloawIEWJ0aK5bTgN
 Yn+U9LFwBj6w/vTOnT0gVuEEtesHIT4QSa3yGie/Uy+Ulx3ac7EwNb26AyA0S8nb+Xtz
 HpRjldgiv6hGi1BNFRzs/Sf2M/ZVTpmNwMihHt16Iz21bcpOzaYgeoyI08GhO/5/EW0n
 aaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271290; x=1777876090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4ejvdUYaq6DlsYnj34U2UvIjH4M78KlDPsl9ul19P0=;
 b=cJGlrRaFvm4aff9DLEcVvBS1cNe6bqsd92YpJ0bSrmSsWJC9Ffzdqcv9Uu/AN4jDQU
 JBZTQUYbFOlDuICQe2StkFgEabU8ZsGd3WczMBF5iGieEa0MTnesgunpEh1SYWHPKcVV
 1Ls0ffIb/1z4p5Y8xPFvDuRaZl3mZKJGKPQiENDBkDZxiZBJXO0hOBdinuS7oFTMHI2c
 f/nQg2GnRNCdkGZ/eYpO7zMIg/IFiI8ql1sa70MJVOobcFSN0obcjRmfCH/RO4kENlO0
 L6lrO6RyvHBf1H2BMMcqox74L5CqA2yggbPzXMJl2XESu8kmrXzeWRLOaH1OhSdlRdOW
 YNtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ozf5dxZ1Lo6DKser9mNtWP0BZT50eRohF3e30Lf/RDX8MnXnpRUfvYvdJhznx7IFnje9lu2wgy5Xv@nongnu.org
X-Gm-Message-State: AOJu0Yxnr9DJtvBJSh9iZDyeUcWKKFQXKWfI2Tkqrlxj5/GZifm94wfB
 DagBO9usnA/+x5VhrvHRkIwxNicxqPXNxSbNPBtU2TDez3JnULmPp+VKWIQyqiLyicw=
X-Gm-Gg: AeBDieu/aOEo8uylY4ar0oUiMSM+kHYtZYfr4dEvjP34fn4cKvYDbxAYrriwud5habT
 J0K3L16OB+K2tSUAI8mQusuvq/taDqx5L+dw8F8cjAXPC5cA+5Ow5snI6jn8RTRC/EJMA7Nu0Ex
 2wSacaOPJg/ALDVhY/2Hx8eAL0u0TmQRgghxSaYEkpG2asj4AUquQYURRoldI5TuGX17sL86ocl
 BWsqHtqTZdzZIuu8eZzZWMvNr/gbk0AD8uyIJ3rIIzpnxDT8LUeAnL3Y3uWyFIyumNc1lK8Jqpt
 T/Ox/oS1w167uLlpQ4D6wnCiVD0vu8/aqwjuMhCJacGGGZ1RT4oEkUWTcZp4xRE8cS6HJEdx0p2
 zxBE0TDWgBtIbIQmcpZW/N/ovB9tu/masazogo86HFqYqqoAxdGvvuodOFHy+M/scf8LzNi/hn0
 TE90Dd01JNIb3+7QiKH6a0FhcolfdmoJqbU5Qyd/BZ9H4kfnNPFMQsLK0wzZ17I4odQ3VRzgdwZ
 nTSy6u8GZnfb7o=
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id
 ffacd0b85a97d-43fe3dcbbeamr60488007f8f.11.1777271289789; 
 Sun, 26 Apr 2026 23:28:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm69374496f8f.14.2026.04.26.23.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Apr 2026 23:28:08 -0700 (PDT)
Message-ID: <f2ba01e8-9331-4526-882b-ffd39784f736@linaro.org>
Date: Mon, 27 Apr 2026 08:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/14] linux-user: Flush errors by using exit() instead of
 _exit() in error path
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tobias Bergkvist <tobias@bergkv.ist>
References: <20260425155140.50186-1-deller@kernel.org>
 <20260425155140.50186-15-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260425155140.50186-15-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 25/4/26 17:51, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Qemu user mode does not properly flushes error messages related to bad
> arguments when exiting (at least when the output is piped to a file
> instead of running on a terminal).
> Ensure that we always flush by using exit() instead of _exit().
> 

Reported by: Tobias Bergkvist <tobias@bergkv.ist>
Reviewed-by: Warner Losh <imp@bsdimp.com>

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c49d1e91d2..84e110dfe9 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -767,7 +767,7 @@ int main(int argc, char **argv, char **envp)
>           execfd = open(exec_path, O_RDONLY);
>           if (execfd < 0) {
>               printf("Error while loading %s: %s\n", exec_path, strerror(errno));
> -            _exit(EXIT_FAILURE);
> +            exit(EXIT_FAILURE);
>           }
>       }
>   


