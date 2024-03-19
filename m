Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC869C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 12:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmYw8-0007JH-8T; Tue, 19 Mar 2024 08:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmYw6-0007J7-0z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:51:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmYw3-0002Ab-GG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:51:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-413f76fcf41so41237915e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710852676; x=1711457476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ee8to+l0RqVF6uBDTyoio40vVyqZSIm6JrEx7OyFtrw=;
 b=lSEnFDuz8TQWyc8XuIVyhgu/N3j6Xyu24Y5OrQh1QKbgHbEGxl4WSyJ6BY2yPYswI+
 drxkIcnKSal+1E+D2mehoQPTWQFdDK8MinuN6JBTw1kHLeWrj/Q8vIdM/cNU8KBcBQoX
 4sIdF4VlaJZf5bJ79VmRiaLmezL/nHUh5GOp+5INZI4liP0PnrAmAaHsJkzlzqA+RcFS
 CcTusJ6w2mynv6VoHxVgNenzRINSaP+yABwyQrOzvNx2t/xHFh5MfH4F4Bh7RD+308ck
 fTuVOMPqq6mHxXUnOADwsYJ0ZIQfgLaBhs3daNmzI4xdLknQDzIfKrCGNhejUzL/W5ni
 DpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710852676; x=1711457476;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ee8to+l0RqVF6uBDTyoio40vVyqZSIm6JrEx7OyFtrw=;
 b=gYUnXJ4FCm++TG6Sroz4x4n5vwu0OmPYzbXMIAk/mS93wcChBKCSG31xZoboZVFy0G
 b8rCu7ke2aXfTyhPE2LNwiG0JKypGhGAWBytcD9R8RnVy58pMD5yHKwMvJweV5ratXOA
 +KrUdLZr6yZpMOIvsChU02LFfM4xbt+MuDiUGADqs07qo6inVBH+1GZ2XtrEDgcB2jlW
 apisi2NlLmQmMx3S1QWQtFQGNFVQBVc2AP5ztxEOFFP2dj+MGKmOd4WJ/fN64M0wb67y
 CwNTBGswJZXWrFuQzY7hjjCBda2FrmqnU5rzA67l2oQRBjW9fQg0qdipNHSDWOJmtJ6N
 SAPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsOYV/4UP6pvlX5ogQqMBSDUfeIYN3Jbu/HfajMr8y5fjzNkNWznLsl/2MmsWbVu4vl34Sn02vjzUgN9WK+37+Qskh7YA=
X-Gm-Message-State: AOJu0Yw+Byb4pOi5gF12KfYuU1s0ssXqvF1+my+SyX91zpUJLYtQUPLs
 DRsqR0uprRcvephjfJqH6Mw74i1GAm/F+iRnTbc3YBVWNS7pfgMvCJRB9JYjax8=
X-Google-Smtp-Source: AGHT+IHtOejukVwmwXZ+53uhhr/v25jHKLsKqgk5HfBezb1ZGWQSx0TYPceok+3xP6efiIgBVDIn9Q==
X-Received: by 2002:a05:6000:2c7:b0:33d:9c3d:f930 with SMTP id
 o7-20020a05600002c700b0033d9c3df930mr2424023wry.66.1710852675948; 
 Tue, 19 Mar 2024 05:51:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 az23-20020adfe197000000b0033e9d9f891csm5587518wrb.58.2024.03.19.05.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 05:51:15 -0700 (PDT)
Message-ID: <c3455d9f-dbf4-43dd-a693-30ffb65a646a@linaro.org>
Date: Tue, 19 Mar 2024 13:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vl: convert qemu_machine_creation_done() to Error **
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240318215641.978308-1-pbonzini@redhat.com>
 <20240318215641.978308-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240318215641.978308-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 18/3/24 22:56, Paolo Bonzini wrote:
> Allow using Error ** to pass an error string up to qmp_x_exit_preconfig()
> and possibly main().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   system/vl.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


