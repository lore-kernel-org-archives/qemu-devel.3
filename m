Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD95C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKK9F-0005nh-F6; Thu, 20 Jun 2024 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKK9D-0005nY-Cb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:56:27 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKK9B-00065B-Rd
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:56:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7061d37dc9bso962511b3a.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718898984; x=1719503784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kx2p7zs3c3DAHoCuGUZcJle+Rm51/9W9K4nbuEndMpk=;
 b=oBs+E5O7yLs8b+7fBwIpVnzzawDTvpmUqURrMMeFjCDp8ithZS+b5kziTxQqNmp3vr
 I6/Qb1sbk2srsVvRVKq63kfXzB7MrRwWi+yDvukRV8ypEUPdE7moowrqcT3mzi4NJYks
 ATetQkKqTSxmP/uzevDa22DIieGmYqy6O32f55MWD/9PsB2e8JW3IxIl/eRdpDTKZLv2
 U9iXzwg2ZhaOqH2optslGDvxoMpIua0wJW9AJjmXcApCRXgJQ91FkCIYBH7gtPbsc2DO
 uV2YGCJelMOxIATOy18OyfqKdbATDLszYkzGca4xttRjDTEUCNmZEkGYG7WRZ7FpKH9O
 t2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718898984; x=1719503784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kx2p7zs3c3DAHoCuGUZcJle+Rm51/9W9K4nbuEndMpk=;
 b=Z86zFBJSlCmE++ocxOMwtnpXYcyz0OOB2ffd99OhE2j8GvqDHekSZPGoLZjHIiT1or
 vRRnJprio9YAgyiycuTVLr+lU9uHZr7gvLSMsiLJbgrnwHHGC22XQGiOhgZ7tRawafWv
 6Tte6sNbpNiD7s6kFc2YJ3MmbdA8ys+e6vkM6+r0NmhciQDh9rN0lgCbivL8NDO0O43U
 f9xrioOwKjzbJiuPeUk5rfGuhL8mq3LxKrFyFnh01DfESxUmdkBWErZcMKm0E7+ATG/F
 HeklSqE9lEP+WLNqimuqfq5m+3tmWESPJ064OGvjqMtyQEMuyRH/c5Qcxn0jE4Q4kOnP
 icAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnobdeHSKZiFITYFgTXhauaJ4My4lW2Tw9V9kaTIuKmrInA0uQmRONH9TMGpl17Bn4jkEGt5aIALUIGhV+wj3hNQ64Adw=
X-Gm-Message-State: AOJu0Ywa2We5QuGzj2ixcj5fXbTPIChO7YkpyDEzGFjcMmTdEfy0TTWT
 35+h0jqrgH7XEuy0pyg806/A9v3BRzY0PqfTGmsFScTExJN/BgkplUTsni6rYDE=
X-Google-Smtp-Source: AGHT+IGSfXCxUlNKnnLF4LjPSC/gOTjibaCmSom/zIq6yQolTnzHTeF7HkcTG27BZlT5ShRb9vIL2g==
X-Received: by 2002:a05:6a00:23c7:b0:705:9526:3c0d with SMTP id
 d2e1a72fcca58-70629c32428mr8174822b3a.12.1718898983960; 
 Thu, 20 Jun 2024 08:56:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3deb4sm12472861b3a.127.2024.06.20.08.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:56:23 -0700 (PDT)
Message-ID: <32659c74-eb58-4536-b715-c580568c638e@linaro.org>
Date: Thu, 20 Jun 2024 08:56:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/i386: try not to force EFLAGS computation
 for CC_OP_ADOX/ADCX
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240620095419.386958-1-pbonzini@redhat.com>
 <20240620095419.386958-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620095419.386958-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/20/24 02:54, Paolo Bonzini wrote:
> When computing the "other" flag (CF for CC_OP_ADOX, OF for CC_OP_ADCX),
> take into account that it is already in the right position of cpu_cc_src,
> just like for CC_OP_EFLAGS.  There is no need to call gen_compute_eflags().
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

