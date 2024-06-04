Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA3C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 17:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEXwg-0000t7-IG; Tue, 04 Jun 2024 13:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEXwe-0000se-Uf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:27:36 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEXwd-00081s-Ab
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:27:36 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f8e7b50e18so783129a34.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717522053; x=1718126853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6JtwiViQNmdN7X4VqKqIy1upj9gc6dT/XmCwmVOqjRM=;
 b=o3/X1FSmKhBzRUSIYQfG2kTPjoVJGpAwdQtdiIT3ZlmDky0+v+8Chq/XvyDLMtyyL4
 s6lei7JVjq4yCB3tbDhJa4SXQI/pjfnBzvRI2QOG+OnWQF8yT48Begxb00QoVd9v+w4w
 2E7k09anaZpYgNQM7GhMVUkL2c7806c/lrH14QG3mjf5ZUJBDf13Wnn6DXHP7vrN73+j
 nVapRjCnlwaRo3Bg0VS7C+iLkmYzy6RThN5dIZwoO5kFMSUF7uiVHwM/J+syiu4Qv7v4
 7VGQ0qdsMjWIXqKorzsfv0lk/ogjMK3Ub/edwO0PGDhhvfTdUSHdby1ow6eyJWk0jMNw
 5jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717522053; x=1718126853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JtwiViQNmdN7X4VqKqIy1upj9gc6dT/XmCwmVOqjRM=;
 b=t3cOo+15ol8+QGmDoA5u/x30aAcSgSdcBNtcZMAK2aRb3YjQW8Yo4plu4+Xa61ci/u
 K3Y5OJyA0zGYbtnmMhCKDE8sYmB8mtk1t44mdq/7dVTc8jJewUYiYPjOtywm9iVw5QVg
 dEjxaQHmmaCPtIrWxwf4kdvBpaadRZU04KM6u9tUh5QpBdVZ/OfU6esDK4l8WPc1BAD2
 iDzx6+Szz8YdKpUAMoh5PvBSApeRIhd9rynkuQ97fbLvglTvGhvpnVULrW/rVtBValiF
 42hi+oNijFQazaNgu55RtJtVl1/FJiTlOfybuTtnL+ffjaYG7I2IRcYVS7a0Ig61Cj38
 uBQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMz7A/w0z4TaFhPmrGl29PJzuN527FnnzmasCMra51AjSLSaQj5VOGyJeUpu/8vgXi/FG1KZ1ZGEmyR4Ec3aGZWYy31iU=
X-Gm-Message-State: AOJu0Yw9y4X5kZJGvBdQhtSb1WWYVeWodhkxsfCtAEf9CmCIPuMTZUf/
 nxN6cp6gPiCpdZVgnWZJ7hh057+H/agaLWQcOjxvHPcO+38z5CwbD1UfTp5Jvbk=
X-Google-Smtp-Source: AGHT+IGgeGmUTeI97lO8DutLxI+BFcRBw1EGcorew1KNq32x+FRK79wsSSvZydrn5dAtFjzdV3czLg==
X-Received: by 2002:a05:6870:b521:b0:24c:a780:ffd with SMTP id
 586e51a60fabf-25121dbeb87mr229280fac.16.1717522053134; 
 Tue, 04 Jun 2024 10:27:33 -0700 (PDT)
Received: from ?IPV6:2607:fb90:4563:8160:fb06:600d:add4:fe30?
 ([2607:fb90:4563:8160:fb06:600d:add4:fe30])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f939831307sm451548a34.27.2024.06.04.10.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 10:27:32 -0700 (PDT)
Message-ID: <6522b027-42ba-4a1d-a240-fdb15a5ddc87@linaro.org>
Date: Tue, 4 Jun 2024 12:27:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/2] NBD patches for 2024-05-30
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20240603142240.22679-4-eblake@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240603142240.22679-4-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/3/24 09:21, Eric Blake wrote:
> The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:
> 
>    Merge tag 'pull-request-2024-05-29' ofhttps://gitlab.com/thuth/qemu  into staging (2024-05-29 08:38:20 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git  tags/pull-nbd-2024-05-30-v2
> 
> for you to fetch changes up to a73c99378022ebb785481e84cfe1e81097546268:
> 
>    iotests: test NBD+TLS+iothread (2024-06-03 09:17:11 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2024-05-30
> 
> - Fix AioContext assertion with NBD+TLS

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


