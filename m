Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A59BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLfv-00066N-8g; Wed, 13 Mar 2024 06:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLfs-000663-Dg
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:17:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLfn-00082C-E1
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:17:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso3307934f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710325041; x=1710929841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sf5pPpx4mg4DIArQSPbFlqG8wcjX4u0F8trQ6ogi+q8=;
 b=pT410r9tTGKU/56bwxlx1W5dCW+LosKQfhmAjwXG94iv+FDDAa0xUWDe6dd9c1WGcY
 BpC9R5R+97BfgRrYgpKbZ1WrPiu3aaAVpfJdU9wt7N4HULklmf7eWB3XmUCeKaojh9N0
 ABuB6laft6Yb6zRI5Waj1RsXXYQZ25uF+WbV3csTyCNQQUYgTmDNa3/8UaCutAlaDghR
 KIIMx7LzGNhLNrEDv4WsirHbUR/VXujQ5W3w8ImGfJKbh50aA0NfbOcMCUZ2Lbo/98PX
 CvoPYD2ai2+zqsKY5QXnchPUecl/ln7nLDpZepnHJgv4lup7XPySvfiomSGmT1Ndub6h
 aouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325041; x=1710929841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sf5pPpx4mg4DIArQSPbFlqG8wcjX4u0F8trQ6ogi+q8=;
 b=agDcJbe3lSbZQkGut12ACCKxU/ZeJXoO7GS+RAk7HNiAybYLkQtler5BFe5mgIytpC
 8iPkT69ePx9y1gprMuljeIOxS1/6DNQcJxVYscD1iSzSqkM3UVrfUdmkI+DGxUsBl4yo
 nFfogNtQmmepneUVSJTb4BlMAQXpE267OhmGVjh4ZNtbh9DIZOFjM85l/QPrmskl2u3Y
 9kgsp6fGKcTUT+in51cjFLtQf/V3mopAN5MbTfQaWOSQGbAdXLqVOnBWRZejkeDwAdU2
 XueKd2nE2OSWXtwZ/D9ab5Unza6eVNtkvhPzgqylQgLwAA/T7xtZwczVFzqRamaz7f/h
 1ZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUluYmP8hKGlWqvrvCx4J1u4KP+lUXVe9GuUHJpjLiZbj/gQWcMWaGaVrXhfB2o28kafl8W52rHoIQmLDw1IiSfjRUlXNw=
X-Gm-Message-State: AOJu0YyNWBNqwhIKrnnxKcHM2gPKe6bQZUZ073mg5Y3vcaQJdVGAZdFU
 o1SYaGG7N+HbWukvjvYWJm8aKWRyLydh+nvHXh8ysb/VEYFW1VarA/pZ8qpBxMI=
X-Google-Smtp-Source: AGHT+IH9adU6UEbzVdfOgBgSId2womWDmklB6lzdMfl3hFjGBuhmuezIb1H6r458HIaDBIwp/m1rHw==
X-Received: by 2002:a05:6000:ec3:b0:33d:3ff4:60b8 with SMTP id
 ea3-20020a0560000ec300b0033d3ff460b8mr1340538wrb.18.1710325041572; 
 Wed, 13 Mar 2024 03:17:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 cm22-20020a5d5f56000000b0033e99b7cfa8sm6658816wrb.13.2024.03.13.03.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:17:21 -0700 (PDT)
Message-ID: <3f0d7531-6b53-4c4a-b605-cf3b62ec7244@linaro.org>
Date: Wed, 13 Mar 2024 11:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] qapi/parser: fix typo - self.returns.info =>
 self.errors.info
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
 <20240313044127.49089-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313044127.49089-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/3/24 05:41, John Snow wrote:
> Small copy-pasto. The correct info field to use in this conditional
> block is self.errors.info.
> 
> Fixes: 3a025d3d1ffa

Reported-by: Markus Armbruster <armbru@redhat.com>

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/parser.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


