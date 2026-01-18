Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C18C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhcgQ-0001x8-6i; Sun, 18 Jan 2026 18:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcg0-0001k0-FR
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:59:24 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhcfy-0007yH-Qd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:59:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so3415680b3a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768780761; x=1769385561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkAqCMVhY9TRsgw5YaU8aple0OPWF5aKRLJ2eLUM5n0=;
 b=YJGR91I9O2+ZjPyk4t50LbtiiVAUnMz9UyHHk6sPPAGsQcrQ4kjUvZoSzR+96Hqs0M
 Dutk3vTNzGJOW3zG4JL5ladUqUP2WL3032rjBgtOdLbyxkCssqL4Y4Vyl02NjLy6M0XL
 p15h5cmy5SH5s2CNvdcYuya3oDyUeHQ18gxqxtfcSVDYpJW/9IayOdiufUEmYKpA1kjk
 wKJc+S0dtBuKG71Q4Rf45hJp5Jijg9ptqAqhE1gF7HEYffTny0ewOnonqdNfpmkRwjIp
 XJI/lsL0zkfLFhZPhRf24LITnNSaIRqM61hasMew05kqaBhw0NdQAtZqYV4xlT8CKnTU
 OeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768780761; x=1769385561;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkAqCMVhY9TRsgw5YaU8aple0OPWF5aKRLJ2eLUM5n0=;
 b=mNLv9gPw/ZH3PZdTUdsUuNJwsw2CT7yac/Ol3S/427EcPEQfmjYlRqG/DOaYG8M8hc
 eaUpwqKSFERxisdkZu0I/+djh6ERlohoH8cf7QjKg58NRJ33uXbWD+ug0x0+s5ikS4B9
 hdD2FEDuOsg1TwpHyJGatTIPKDd9atQuvY6fxHlFg6IcnJmu5UtzcnkkmxhQPWAxbRHT
 Y3bPcP9kBLRFTaC1NykV0BLDSs+z1EutJm4ZhyTaYmwzk9Cmrttz13FCaoCu6riyJNEU
 9FwBOWc+H3ZLoxygWCQ8a1H7oSKYmLA4H2XR6vB/rQeA8aXD9gsDdYFo1Ekrl1SyD93E
 UXZg==
X-Gm-Message-State: AOJu0Yyq7fbC7k9J6WL/eRxWaUFlL7V/3OP3tsq5oNb46mthykioeRCo
 /iEQNT/ffcSDPwWyhfzkPNVK8NrxEQrGcOp3Pjm2CWlV3074yhTpcz6eZ/paYSZ2HZRQnT2nFYN
 7rcMdykZNQA==
X-Gm-Gg: AY/fxX5SApDimKGy6j81yzofyWYKmR52eUpsPP90ed6bY64diM82eDtY3Il+TE4zB9Y
 sECv1H08w2yIgIjChxyANAOlugEiQ9fG+mNAGighv3GZKAZjier/Ayxd/5+kw0+nWAz9WJNOQCr
 NW3+H5UbcEutZWWX4sJvblxoo+p5YFovO93EK0ACdn0M91u7Fan9XQwzdxE6EBXkeCsXnpMuGBg
 spMk67likUIfHIfpQNdq4v+Atz+lXysl7C/dTibU38PLxdc7VOVgiPR6rt8c7I7nZsUhvsim1VY
 vuClqEqHUHqYSen+crnZqbil8UfyIbCboHXy7FVUsL1F1Pi/JW7ubnSm+dA4ArCji9ew4YVYJCe
 Ldu+n6URz8UI63GkYnvF5r+1WIokSEvNuY6RDxtHOsTqiJSuFWwXxiCvASeVdZ46Mjj/NkaQt88
 qamuEuZojS8oGMvExWMBbH6OufaGr7Sg==
X-Received: by 2002:a05:6a00:94c1:b0:81f:5037:a316 with SMTP id
 d2e1a72fcca58-81fa032b50dmr8559211b3a.63.1768780761072; 
 Sun, 18 Jan 2026 15:59:21 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10efc6bsm6958073b3a.29.2026.01.18.15.59.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 15:59:20 -0800 (PST)
Message-ID: <cd4d1520-0c04-44c4-bb8b-7ac9add725ec@linaro.org>
Date: Mon, 19 Jan 2026 10:59:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/54] Remove 32-bit host support
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260118220414.8177-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/19/26 09:03, Richard Henderson wrote:
> The following changes since commit 42a5675aa9dd718f395ca3279098051dfdbbc6e1:
> 
>    Merge tag 'accel-20260116' ofhttps://github.com/philmd/qemu into staging (2026-01-16 22:26:36 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260119
> 
> for you to fetch changes up to 239b9d0488b270f5781fd7cd7139262c165d0351:
> 
>    include/qemu/atomic: Drop aligned_{u}int64_t (2026-01-17 10:46:51 +1100)
> 
> ----------------------------------------------------------------
> Remove support for 32-bit hosts.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

