Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F25606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CNZVSw6i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOsA-0006Uw-Fr; Tue, 17 Nov 2026 14:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOs6-0006Uk-T3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:29:39 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOs4-0006aM-AP
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:29:38 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3b08a162d4bso37085a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943775; x=1795548575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aXL9sWRQ8kfXyO2d/TF3lXjagH54hb7wa4eF943Gw80=;
 b=CNZVSw6i61OFjn3e3f9E2pMnvGb9wyZbTyrgCijD/4MPhoKPXDBWqkWLkq8dGGQXlk
 myMSrWH3BXv1s01tmPZFUI+NiD0OKiNXe67/B1Xcft6m82ZeENLEvFeyz9PvIBTLfpkf
 HuPSiaTPUXn+3MbEXmcKy0touhreya561r2UoDlcpoeUPDbrGtPPo9Oa2DbKB+af++Xo
 JtaDazPazZJyzj5aoRcTlkcsXeJzf74bp1d1SsW+eCz9jX+p1lQFQSwPGZJlswL+KzmM
 YB4lWyUpII+8f9BYC3GgzMAhqoKgzgAewrPjnRsyzTeLcVQiwHJC28j/7jKhtzXG9T6i
 /8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943775; x=1795548575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aXL9sWRQ8kfXyO2d/TF3lXjagH54hb7wa4eF943Gw80=;
 b=HW81ns1N5+0z8p6A0uYaz4m/Vf1crof+FxWHVebIRPNMCf+oCbqBRry2/IuVU1RQJM
 fG8EuCmHWec7hJ98PAv3x7wwyOQFFEunA4YZXqIUtRYUTKg+EoBdFs4ekJhQuZHxTV+u
 GYg71adbRobxS67l940HhHXs+Maz/krbLW2aSNJF7Dvt7Rihr/8db034aDROj4bqpli3
 OewRQCvAQanJY1wBRSaZEV7nStRteBxssit41oHMtH7QxHmEYOXoNed5762qGwhX4AJl
 SEyuWuz4ecKN08ezUfKjJUqdt3v3az4z9qBLlbGfgr4oaexgFqdFQrQDQLtoQm7j32F3
 b3Sg==
X-Forwarded-Encrypted: i=1;
 AL+hErE6dlFhIduAuFRvKizrTypsypFtmyHLcdbA/jkZX683kWO9nwO07M/dha98RNq86W3k/Wh0K/9oyOP8@nongnu.org
X-Gm-Message-State: APuU4Z/LX8DezFB34OhlDVWJFfbhph0ie9fllZ7W/dtTNtQLc6amLxbG
 VWFn1HigG+fA5fMXNinEdckm1kAyr8Jhr23bO5a0x/m/sYSvQLHc8ovhH63K5ckYWQI=
X-Gm-Gg: AZFdTZdIdVUslyzA4WMVt6a9SDQcpOWS+7yC9dsGu0AnQ3YYa8q9NXyX8dI1mxXQb+Y
 LGlAHJPmLQykiE9BCh/b2VAqah/0Y0q3ipm6p/TNpImemyn7J5hHbcZHFO5Gf0v6kl5QvLvGqID
 H1nFThZyn4ylYfMtkD3D7cjuEBpAOLlmJ4uW1sAME7RdGbrjVUe0ZtGlvvOkMNIfw9KA354k1h1
 c2954wf+DF40B1780UVQKlhWWSvwXJyFR3YgfPEgA3eYGkdbStTxT25oYhLe6E/DasAi8h7e3P/
 W9PV3X/D1R6r7wSexqntgY3reHNHnL+j5wOgpemfdmassyXYU7XytBQXmeDueBcu1azNNpDH1h1
 szrcM+bg48L2JU4+nTcBZNNH6mmA+tHnrRy9NZewsL72ORvXn9SU8fOpKooPGLoAlD0g/1t5vQW
 cVk5NEzKFCV2re41xAlrNwxfybiaPRj/ylj/4EFspbVTP/bN2qyLXk4j2DhFrs8DRbQBucwETHM
 /+ScWQBo8hOkISd3Lolc/9X6h9TKEmfLjZF51RFGbRsDYX+ERfI7pe6/mvg5+NGGg67u5DGfCgw
 29xI8u1EzWUpuY1uaKJdduq1ddBBc2vVg4nD2T/DR3QLK7TpvcGfMWnci69JEVi7I3jYWnaFu2y
 kI6sCtI9Z73NYirR7
X-Received: by 2002:a17:90b:4d84:b0:3ab:1481:69e5 with SMTP id
 98e67ed59e1d1-3b3d074d047mr420034a91.11.1794943774690; 
 Tue, 17 Nov 2026 11:29:34 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac255634sm5243655a91.5.2026.11.17.11.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:29:34 -0800 (PST)
Message-ID: <bbab87ef-4183-4a9b-9f00-b88a447db65a@linaro.org>
Date: Tue, 17 Nov 2026 11:29:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] target/mips: Do not sign-extend partial LWR results
 on Octeon
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-19-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-19-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The MIPS64 Release 6.05 manual (LWR description) says that when bit
> 31 is not loaded, bits 63..32 of the destination are implementation
> dependent: either unchanged or a copy of bit 31. Both behaviours are
> architecturally allowed.
> 
> Octeon III CN71XX hardware leaves bits 63..32 unchanged unless the
> whole word is loaded (vAddr[1:0] = 3 for big-endian, 0 for
> little-endian). QEMU always sign-extended the merged low word.
> 
> Seen replaying a risu trace recorded on a Cavium Octeon III CN71XX:
> "lwr s7,26334(a2)" left r23 = 0004114d368db793 on the hardware where
> QEMU had 00000000368db793.
> 
> Only change the behaviour for Octeon CPUs (INSN_OCTEON); all other
> CPUs keep sign-extending the result. LWL always loads bit 31 and is
> unchanged.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

Horrid, but,
Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

