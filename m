Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1151C27C52
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 00:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFN8C-0004tk-8B; Thu, 06 Jun 2024 20:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFN8B-0004tU-2v
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:06:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFN89-0004NE-C9
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:06:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f61f775738so13981525ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717718811; x=1718323611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+YFULanMr7Tt9tzFcud5DCd60OHhq/1RFVT64kRORc=;
 b=TXsbayNHScfDZ2R11rpgdmyMRKPmyVm5hW3onofj6BfFWJZIYjBu98NyMKlhgPyqFi
 LUcUa0BaJEKzj84p1w6M3P8d8LQ+Q+3GCTTf948ZTmGOKNJKYgkXnTPd05ZishsgYP8K
 WV/JaAkDnx3jPseist/I4EOBC5r+NpHuEhXpnN+Yml3rHknJRIfwEPPDO7FtrXm1BIUC
 1z//P/BCwRsrwBhkDwQiuAPhBT3mxxSPmdmapzF7/3j7zhIkzrCT76tHbtL5PBVXcEOD
 dy+mrqoHVg6ufB5M/DafGA3RbNr7eFTbRYWcISHs+xdP8SQDcQP4UwyMTcuwKqJ1s7ld
 oyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717718811; x=1718323611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+YFULanMr7Tt9tzFcud5DCd60OHhq/1RFVT64kRORc=;
 b=EnG6vgnvsjGGA4Sd3rsS9TbTt4gL3gcKr6YrKJDP39H1U7wOiRb4LbXWvXWDPtwOXZ
 cCUguHK0lxl/MArQNdmX7CDAK94MUnXQVSTq/GfjUyVn7Nfz4fmnoA+Zp1AGvKyqwlPS
 k9iT98CJw/W5iBzwFFFByUCHXoeA0WLA9ad4T7f9ebG9P6SEpAfwHstZIbugyFxXcLje
 IhskTFdk55FDJ6FIAMHN1l838SFw6T8d4e+rl5rBjgSo/GH7oZFCXFlg6oXGQQt9E17V
 l4nqVwNxykScyDhfVOwf7N8vZdT8P5FPtK6iOoLdVDR1TNz6UCNYI8S/Wi6KyuXV2bsn
 L1RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyCYpeea3ZI1iqbZpPZItQlndeg41Wr8HUu0hKltwumx1KvcpIYxqclkUE4RWXJYerVYAYvRzbw6NB7JOzSuKxO4uK8R8=
X-Gm-Message-State: AOJu0YxrDT+QCw4m4FhlcKrRs0vbN+yrMNLBnagVRqo3dYeCgPl3CQlV
 1yHbw9MMxK1A/09qHEFHrxB9dpW6aemeXfjbZEUYYUYCEKnDdqUBXq5R81buaFqM2j83XdcqLNp
 z
X-Google-Smtp-Source: AGHT+IFrphXyfsTcZPQEDXbi2eJbWpS2VGFjxxIFldg9HXvDdUe8mCE8ly3rBCUUp7G3lR4E/AGeYg==
X-Received: by 2002:a17:902:e742:b0:1f6:5e40:6e30 with SMTP id
 d9443c01a7336-1f6d03cc26cmr12922705ad.60.1717718811107; 
 Thu, 06 Jun 2024 17:06:51 -0700 (PDT)
Received: from [192.168.101.177] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd81bbc1sm21514315ad.302.2024.06.06.17.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 17:06:50 -0700 (PDT)
Message-ID: <7c34cb9d-cb2c-4279-a027-c03a224ac551@linaro.org>
Date: Thu, 6 Jun 2024 17:06:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240606040155.2607422-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606040155.2607422-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/5/24 21:01, Song Gao wrote:
> The following changes since commit db2feb2df8d19592c9859efb3f682404e0052957:
> 
>    Merge tag 'pull-misc-20240605' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-06-05 14:17:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240606
> 
> for you to fetch changes up to 78f932ea1f7b3b9b0ac628dc2a91281318fe51fa:
> 
>    target/loongarch: fix a wrong print in cpu dump (2024-06-06 11:58:06 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240606

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


