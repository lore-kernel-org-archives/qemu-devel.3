Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F213EC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG1v4-0001Fd-IX; Sat, 08 Jun 2024 15:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1v2-0001F0-Ci
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:40:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1v0-0007jL-7J
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:40:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f6559668e1so27513035ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717875593; x=1718480393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlr5wGCcl4M9s+xYbIntxUfdPvKK2+zmnxARDbooMXI=;
 b=i6POzP2yDmFXFvFo+hdOHcrUBozk8ieHcJQrONhecLXEiitN80l0orUBbMhni0+92x
 cW7SN4YXfP3szkW1fbfgyPvM5r+axHvlh4JhOR+p+xBj8ywCcgmGHQ1TifLb1Fnk3oI5
 0vUwxNkWfZhehk8G906BhHv1OOoMD6Vp452KjUU9+K7sPzrUtLEoPxV28cr29F0ES9B6
 ms1vpb/xIHuxSGbehr9jq/cZaE4H25dDFR3h5qRsrpVszXbT1S4WE9RVelmHeLNAjy/b
 LnTQ21dINAEd3LYNfb0+65sVmO53CMaQSgQ3r78PtQxRm0vDS+pf0efOWx2DgVsO2nkm
 NGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717875593; x=1718480393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlr5wGCcl4M9s+xYbIntxUfdPvKK2+zmnxARDbooMXI=;
 b=rC7NVyPaj6oT48gUeMRTaCVSojALAd6ji52EgPWmB7RKBcDFXmCo26aLLuMQtcaKJI
 UpI/0mJvyYQQVqEFY0jyFJzols4O48VOVxgTXJtXbtml2aerkZ31Yp76NEHz/y3P6sYv
 z0cMTnWY+bi4zXkbRVd2suFOugDFr53Vj6c2mLCBGlTcRKM8neuAO/I0fJIRg2b0GNAp
 hubnCLjwgtK8ZpYmzin00tEzptt8MH68znzfdTHh4ZkogZ5oWnXSbLHcKN1FTQUOVNZ/
 chN2ljoXFUAvW5Wr3misCj5l+zNe+wjmsgxWEaJJJ2clFnAAAa4l3TOSgIGFs2/Z0ut2
 RE7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR9o5tHZdL7d+4nUjJpEiCejZR+OrCQb63EJn5NWIUcLW5jXd6W/7rqtBqpj2ertfIszaYTMxW/Sdzk7EpvaVaUwb11Yw=
X-Gm-Message-State: AOJu0YxaWlpXPLs15DrgPqylsHHbvrx4noRKzOWF1lwEKtgDKdkWN6vJ
 foFvEuKtFOi+HdiCTNy6xEs2bE8DBL47/eh1on6vM1BsORfzhx2qhd2VbMl5PPs=
X-Google-Smtp-Source: AGHT+IEiUJkkSMvMkskrxmOI5qnP84bkpWmCuLTmE1Oq09eEjxbCgiUwShiXpr5Vy0YEgdLTJwfaRQ==
X-Received: by 2002:a17:903:41cf:b0:1f6:78f7:14da with SMTP id
 d9443c01a7336-1f6d02e6cfemr68294035ad.24.1717875593340; 
 Sat, 08 Jun 2024 12:39:53 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd75efb4sm55135715ad.14.2024.06.08.12.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:39:52 -0700 (PDT)
Message-ID: <2299f5d3-08ce-4a51-8791-ac59c09be2a2@linaro.org>
Date: Sat, 8 Jun 2024 12:39:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] target/i386: pull load/writeback out of
 gen_shiftd_rm_T1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Use gen_ld_modrm/gen_st_modrm, moving them and gen_shift_flags to the
> caller.  This way, gen_shiftd_rm_T1 becomes something that the new
> decoder can call.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 55 ++++++++++---------------------------
>   1 file changed, 14 insertions(+), 41 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

