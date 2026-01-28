Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF52D35677
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 05:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkyQk-0001qz-Tg; Wed, 28 Jan 2026 00:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkyQd-0001ip-GM
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:49:23 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkyQb-0001uL-5G
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:49:23 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-82318b640beso2748770b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769579359; x=1770184159; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GIegsY9WB3wZJxqAXkbIfbfD+pYgPpNR8Y7msKf6HxU=;
 b=h8MuHN4GA3d4EmS+z7mElLUv8axrZ/evMs5j3eJlqm4TaerML8F/Dga6JJm3E/yEyp
 +A5Z5x3Z5n+34U1L3WME+76ARdylAzbwYkIqaVrlhkVuu/FHTP0OQrXoynCp5PcSsT/k
 RNp/oDIqtkSsi+m0zf+1UtpUqK1UKNTcIg4LDXeS7971iuZHe2GcXGHcoCDiik1RuW81
 RLr5ID6OdQ8TskXgTSrlOleb/7l0JK50HPTt83DZLRgeUl2F6X6IO4nT9vrojbjRHdhm
 aaOJv6PbhR0s3nIYgDmLXXJuhVp8TDJzFm0nobxhWyY0X3YlJuxsNsU8dDoKUkfSLGge
 OVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769579359; x=1770184159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIegsY9WB3wZJxqAXkbIfbfD+pYgPpNR8Y7msKf6HxU=;
 b=srUa0RZF/SNCKYKInpzERTiufrTrDJJoHxYSZxe+cLFmRvkWlkJZ6Jw9Cn/HIozKVN
 UTjThZ921fuXkxYQJ2Bie1dP15I0jUDl6DFgzEC+NIKE9gMBGYaN8qFmKYEwS3DWD/TB
 EEeEzwHnc0ZZuFbAdPOgKZNHBctww9M7MwQs4/ieDzrHK7zzS7Y56eDl9Dj8HNWo8Eqs
 VN5tdIEZvBnjKnPcccWv+FYf5OiQx9EkzFTbdpqylG26IU6yCw041vqiQO2zvmJk4U/f
 0sPIstHkLplXWHxRDZnVVJRnwvRDY6F76/CKx+WjqfzxeMcIUD2AXUBg8T9E46yEEa0O
 cdTQ==
X-Gm-Message-State: AOJu0YwsX1RAKEHKPrYXvzsq0eHvVareRF6YyisNpyKnO0IJ7N/BD4od
 xbLKw5RK8IImK1DaSep1cD3EEgfZYTN/JeQsIx/F8IAtV6LjtjiuSgKdJeRz7mFuMaY=
X-Gm-Gg: AZuq6aJpFiXGUCEZqQCIGyKf3DztBr+W0ckK0K7cgGNLWCLZgRsusGU7L/3whlwwL4q
 3z0GvwZqtSultaozk7v9VAE0v980oOrnycOwlYt/9ttWE+uPZ69YBCkEcUAa3ugwelonGuZXdsE
 9+QQEJcsv+/5lFjMdEhxgGhpAGV3JIE9b7RyyRQWDzomtJHkLEPbxUWtjoPa/lAS4CVwL0vrsNr
 ms9g+aRSNy1MMiCbFAzRrp/77kZcFoFOKaQZqHfT/cBJUwuxusVmYUHwPOvCNTQKquZN13GnVL7
 d4qUb3XKkldr3L8ktYGjBrGF9pMJsfVfXDvsEEmtKa1xO1pH//m/ZYIrOXF7l4CwK6hhndln+CD
 gJhiFP+qTgaZzdiLO0r0P+SFexXVCK/ohxCkKylVPKZnGRw5wpQJbwoITWXqUKc0OjoM2d61SV6
 vEbLYi8StF+QN8UdsQK1pU99KeCxIfzRfsX5W0SBJhXcCNKzvAurzGGBaRFw==
X-Received: by 2002:a05:6a21:6813:b0:38e:9ebe:525e with SMTP id
 adf61e73a8af0-38ec6410421mr3917620637.52.1769579358717; 
 Tue, 27 Jan 2026 21:49:18 -0800 (PST)
Received: from sifive.com ([136.226.240.196]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c64276efbb7sm1046117a12.2.2026.01.27.21.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 21:49:18 -0800 (PST)
Date: Wed, 28 Jan 2026 13:49:13 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 02/17] fpu/softfloat: Refactor IEEE format NaN
 classification to share code
Message-ID: <aXmisH-enHafT9Xz@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
 <20260127063723.442734-3-max.chou@sifive.com>
 <7cc87797-4cfb-4195-9a9d-21ddd355aa54@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cc87797-4cfb-4195-9a9d-21ddd355aa54@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-01-28 12:34, Richard Henderson wrote:
> 
> I think the "internal" functions should already assume any_nan.
> 
> Otherwise you're double-testing it in the quiet_nan tests.
> 
> Perhaps the intent would be clearer by naming them <type>_nan_is_snan.
> 
> Perhaps clearer to merge the expressions:
> 
>     return float16_is_any_nan(a) && !float16_nan_is_snan(a)
> and
>     return float16_is_any_nan(a) && float16_nan_is_snan(a)
> 
> for the is_quiet_nan and is_signaling_nan functions respectively?
> 
> 
> r~

Hi Richard,

I agree with your suggestions and I will update v3 for this part.

Thanks,
rnax

