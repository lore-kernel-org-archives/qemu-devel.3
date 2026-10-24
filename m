Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15838606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tIHuhFYR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVP5-0003qW-V5; Sat, 24 Oct 2026 02:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKVP2-0003lq-9R
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:38:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKVP0-0006NO-LA
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:38:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso920140f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792823929; x=1793428729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tzwfCITsu2Smsw/ib3keCgTPFWgsI4+f9+SUjGo4ofg=;
 b=tIHuhFYRRMTcBbkdgYwFsIgRzUT2su0tZtr9DtwO+K4PvSk1QS/lrWQiE6UX5PYPpT
 whoqLJlxvCkPouounrlFfB+8RWf19MI7GVUDDoWg/VSHXr6nv6Bfq0Kt0U+ffAmejgSr
 eLuKGImfcrTraK8RD1Z2FBX+XjiJpXrTg6lFaoLY/93faQXxpc2To7IpxhNin32rjDKg
 S8SF8rKj3cPgSCfEEYS6544ok8S+R4z8usmgCFYL96rTfkEk7+iWuObRdLezdn7c3IzT
 +WhSDFBc7lvIlHAAtBvZgxbgchuR6uxiE3NcbB+QVw317Cfq8UxyTZ/kb9kIvfNM8xLm
 qSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823929; x=1793428729;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tzwfCITsu2Smsw/ib3keCgTPFWgsI4+f9+SUjGo4ofg=;
 b=AoialajBoFDVDYOPFVZcZBLnVx4izgWcGueDI6fLuuqgOHx9HBGoDBu+8i/UhAWePx
 7OUOMkriEmg5JoiGA4sRj2xGSs8rRaU84K3ZN4hn1zurSupsPShBMyYOfff6qHT2Eh20
 cDmzUn4iQyxIVY7uDsz4WZMDvW/AWj0NMYGJSUS84gJw6TWH2yHsaJwB2sg4SWip0j7D
 PpT8gvoKGt7v9XiPdwfrt5kNci/o/Hs66w1TwHO5Z3mQarH/hvPKh0yCgR3+l3nhB3P2
 q0t0wJs5i1N353lJGk4PXl0mx1NxdFgBHTvLyfPtUHKJnkJqgbc7qkcqRXgK+nHXHwfJ
 iVDg==
X-Gm-Message-State: AFq9FYI/lq029ZdkgLGsJRLximR8NEkjet3zfrNtic7eB//oKOFUsVzi
 yqdcCrXJ+FS3CXik3GvNisTlNW+iSu4abjDLz8THmobEBPk3hETFJwYR6EH1vRAykRpxfN/dW25
 rMJh5fzI=
X-Gm-Gg: AYBFou0CnH1ytq8nNL/BgQpBoFiXpIyyXnIkGNw4MKBBV2K4vqB7WuF71Bj8/ExiS7Q
 ieP4zJSq+26P2Mmts7Pozd8e7wCFEiRi5y/guxZlGX6Mt0lfbdjpYF2L2pmTd+Qfd5dL+gf5j8g
 2lZD6+d5an4futWsZMiYwBByVWTAoztrUoCl3hhD/oWrYbNIFNmkMLg7IWsDrTphHD7SCZbB2wx
 fzaR4aRda6vTIZDJU4haYGeL+bemHVxrm2Nu91k49NwJy7ER7i3XjaiPjbNT4vjjzp2K8DOtL1+
 LVs07o3Ey+KTEFOETm3hMFg+ZuT+aELard+eukq0BV06sjypF5a1lcK+dJsoGckWEWA+5TGYJpZ
 8hlb69EU4kSIC5LgN9nePu59hQbsv+vGc1IWUHdyraep1cvnk17JDIgEsXvqmRyHUIpTeFo2TXG
 +7R1PZ5klWk32DCZW9dOoZO1bjIDO+wL3IQaFMhlOfoAwpOBxw2NXEXxNIxTIwtpLqliL754cj4
 n0hUJXvzkj1PIsyo4Aj6nbCAgKuJYcEZNiLKZ7wZks9Jxwd2R12zqRUmYa6MfKYnKcnI8dbhzaI
 cxXOLEgizbL6mA==
X-Received: by 2002:adf:f712:0:b0:48e:791:1cb with SMTP id
 ffacd0b85a97d-48e3eb93468mr1154397f8f.35.1792823928556; 
 Fri, 23 Oct 2026 23:38:48 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm2371590f8f.33.2026.10.23.23.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 23:38:48 -0700 (PDT)
Message-ID: <adf8fe0e-8eaa-4a5b-90b7-93e9e92c21d5@linaro.org>
Date: Sat, 24 Oct 2026 08:38:46 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] pull-loongarch-20261023 queue
To: qemu-devel@nongnu.org
References: <20261023014931.4055823-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023014931.4055823-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 03:49, Bibo Mao wrote:
> The following changes since commit ed698be7700160c74d24ef7830adccd2a28d840a:
> 
>    Merge tag 'firmware-20261021-pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2026-10-22 08:20:10 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20261023
> 
> for you to fetch changes up to b8cb88aaa32d8e1ff55c5bc347bae7da09f2e63f:
> 
>    target/loongarch: Select sys state by VM level (2026-10-23 09:28:51 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20261023 queue

Applied, thanks.

r~

