Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7DED1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 02:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQcDG-0000xi-9f; Tue, 02 Dec 2025 21:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcDC-0000uj-9w
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:03:22 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcDA-0000of-P1
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:03:22 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so6704247b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 18:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764727398; x=1765332198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bwsM5R3TWNXmJsJc2mFjfT0ps+EZB6g2R8TcQODwFM=;
 b=STaYiYrjFvv2e32kpQ92gTELCP6BudUJxtR+S4lK2yoZPL84XuxhcBuMttAYNufymt
 BzJgp9k1uqmh7GiHkWGF550DZEI9MV7TguHPBoUnFjhYpAj5FaxnreDmxVZNQZ6hSDXE
 0GDHC8T4mWRqGPaXMX8YbWXrKvTxLqeTNJS76or5ehBRndf/ee2fJuCOfr5p8sXYUzsq
 C65+fEaE/BQMgaoi3Kt3MOscoT2i3rIcyvpcdDPubYBmmAi5on0VXKPX5JoSEKh9GPBY
 LNAR/xBNbMCMH9p4OQUdFmzeHsbIuUc7eCI2aBeDsgqMsh7QD+cinUtAEOVzhppxbCkt
 X/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764727398; x=1765332198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bwsM5R3TWNXmJsJc2mFjfT0ps+EZB6g2R8TcQODwFM=;
 b=k1xHsZT9CedP6NCIVNo0/cezsAOFZO82gSIY4BOeNJa/gW3uPbL3GaHdO6TMVWby0A
 bHAu2HAB3jGRSrh7Ses4l92NwctKN5T0XGCF9zsN/+OPdWUkaVceK30y+5AiZ5JOC0OQ
 bLcThde3q+kvzTcHD08iCpUd6peYbn0IaEgfHz/06UmAERr6zdc2d/pYFoq5Fdw2QxLd
 6zUNfBMpCVMcehQob3VY3ArmCyU+Tz0jQrJh9AkionTO//EA9Kj1SNKyh4DViBJZF6JB
 hVeganNa3pYWgTs+edv2+suKwHGU/zdU2TZTT0Q36mbuTfF5NFXwfAjTlAf0zia7pKbn
 A46Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ldwVU0blv0yurfZEiTMuPITB4+BCGL816DI6e313Env8GYCC72AMRzo6stOqQgSO9Tg5alEptqHr@nongnu.org
X-Gm-Message-State: AOJu0Yz8vTvUdZF78sZoCo2EDjW7GecoRyw93/t1cyEIiZKcp8pQdcPz
 GfhMCAscWB+6JFYm1CTDvZJzedJRQdJ/tGjBDsMeFFheap4viDa+aiDRQJCMNbjA1xc=
X-Gm-Gg: ASbGnctdP43tbuHKXj/NOL9XN+YO5LQiBVUCkBIke0iQJaWfmsXb0rxoN3POb3Ohmws
 1HdhhqzxxSqKDsID8la/1w6Z79/WsemJXDijIRpL3CYYHOQDjDikVLf8OE3WWtHdWaGpCJFzVv3
 MBdaSz7pxcN+Zy/BgB4n7NvEwqOvY/JX822bLqUgwg0mmJIs6/gcfcySNz3AyfUFksrureHTxCa
 SvmJjBRCF2oMQBquAspZcs09geuSEKT+luKfwoEsXGwbBqgZ7rf2ZVBQ40G96wfMcJQf/96yXm0
 6mPUEAe/aK8coIllW7qToPpF4xQcr3VvHk06nDxEG4Gk2N6bGLEi4DQrT9DIAXFrVosgq+LehHk
 1B8AWNdoqnUK0l95v+gERunYVGWXeAt+grAhEp63rVHC0azy8r05RZc9bqBxPBZMzalCH/2Gfju
 JXauT8ehZ1BA/VIHjyBBIn0+I=
X-Google-Smtp-Source: AGHT+IG0CjJFT8lNfysCxg0sv1wWtp2skMXVXBqMAZtvFhncej2A8PT0h3SAwv0ee3jiyEDT6Tv78w==
X-Received: by 2002:a05:6a20:9146:b0:35d:d477:a7fa with SMTP id
 adf61e73a8af0-363f5d43a56mr1184250637.23.1764727398410; 
 Tue, 02 Dec 2025 18:03:18 -0800 (PST)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-be4fc5a0957sm16692202a12.16.2025.12.02.18.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 18:03:17 -0800 (PST)
Message-ID: <3c483d29-9909-471c-9fe3-f551c7d1c0f8@linaro.org>
Date: Tue, 2 Dec 2025 18:03:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1764716538.git.asb@igalia.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cover.1764716538.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/2/25 3:05 PM, Alex Bradbury wrote:
> This is a resend of my previous patchset which unfortunately seems not to have
> been applied (see
> <https://lore.kernel.org/qemu-devel/cover.1753857212.git.asb@igalia.com/).
> I've rebased on current HEAD, checked it works as expected, and added
> Reviewed-by tags to the patches, which all received review.
>

Sorry about this, this unfortunately happens with email based development.

@alex.bennee, is that still on time to merge this for next rc?
The changes are trivial, and located in this plugin file only.

Regards,
Pierrick

