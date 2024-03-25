Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321EACD11DC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rop7B-00080J-6e; Mon, 25 Mar 2024 14:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop79-000800-Ik
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:32:07 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop78-0007ad-3a
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:32:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso41464335ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711391525; x=1711996325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zMvNLLxSN+hUAoYwsagO5dYmz9SpvZ17rK56Mi0l2Q=;
 b=kWuDKg6lfAHU0bU7qycdzIfb1rKKwXbVe/Ha7TOyGknEqxUQqDWP93UQyYfbs/YtFj
 RLA1nQwMbpekAQYewAVXIA76iXlIfesRUZVnOLMhT7z6iWbFFSvuIxCnEk8cWqV54Hql
 OOavX9GvAArAJbPFzRGQ9hmas1UWFz3G/yTsQVZGQ25HiujLzI7edOMe+4+fFvqcSQFX
 cGmGLy6WgizNRPv6d82w2qnQlGvmYuvzhHveK9vdEEkYmWlZoUsESN3PC+DCFyHjNqXo
 ufdcOItcbzmELGXqiVrtnXz9gNDnO6VA+t4+z+VRSMpnZqdWNC6RgmfVD7wMmLh5kP23
 Gi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711391525; x=1711996325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zMvNLLxSN+hUAoYwsagO5dYmz9SpvZ17rK56Mi0l2Q=;
 b=UfIMJ8sYgftg3la0JpNmN/rf4vGfYww/JBk+8G2oXQFQ+L25DbgUCXmQsFCyON7AZW
 MbbnFS1zwuiOSs7X3anf2vtpoZqFjAs6IiA32cS4CIhkbUd2Fy53lWiyCaIHBDiPW3TG
 tXQm/uirossi+jPYCD9J0Jy8l+m4yPJXvFvzB90TB4lqUvGuj7TEo79cGUJPQjbmU2Jy
 XPCdfGKgMYxuiV4ez7McePAIxT4h6yYQlLr6Rb1vEa6mNmKnehxlv3PG0AWtdvrUhnE0
 m48NiMzzt6AIQaFMqJPaIFoKA5aAByMbvTOakdOzRdDU15XvbwmeRfrM3k5C0wlUJdq+
 wl+g==
X-Gm-Message-State: AOJu0YySaQ3SkSiVXkg/mOgK4Ifd+g+/pfjOQrlmYJtKm+bFoDw5Y8ul
 Cf29xchnzytxPaRw0ayLYV6MTmNGA+12QyQVQRPPyNebm1dfoJJk+Zy3UuzsWxk=
X-Google-Smtp-Source: AGHT+IFJnwH8REqRF1Rrl7mls9mPEc9KndmyJ7SOm10EqbVVBKlXyJfL1MRooXa0Ce79fn3wRLH5Cw==
X-Received: by 2002:a17:902:db0e:b0:1e0:c3b5:196 with SMTP id
 m14-20020a170902db0e00b001e0c3b50196mr4262009plx.20.1711391524682; 
 Mon, 25 Mar 2024 11:32:04 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 v64-20020a638943000000b005dc36279d6dsm6113301pgd.73.2024.03.25.11.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:32:04 -0700 (PDT)
Message-ID: <152b8700-0224-45c7-a679-06eefc36036b@linaro.org>
Date: Mon, 25 Mar 2024 08:32:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] linux-user: Fix shmat() strace
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240325153313.526888-1-iii@linux.ibm.com>
 <20240325153313.526888-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325153313.526888-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/25/24 05:07, Ilya Leoshkevich wrote:
> The indices of arguments passed to print_shmat() are all off-by-1,
> because arg1 is the ipc() command. Fix them.
> 
> New output for linux-shmat-maps test:
> 
>      3501769 shmat(4784214,0x0000000000800000,SHM_RND) = 0
> 
> Fixes: 9f7c97324c27 ("linux-user: Add strace for shmat")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/strace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Oops,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

