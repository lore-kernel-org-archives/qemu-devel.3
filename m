Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4330CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYQC-0001wL-1z; Fri, 07 Mar 2025 09:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqYQ8-0001tY-5V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:11:24 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqYQ6-0006uJ-3V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:11:23 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so1246640f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741356680; x=1741961480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJAAX7vKXgJQE8XqN0qNtPWcrBi2YgAiRTW2vWZKD6U=;
 b=FeQukThQX42dhBMcYE6e5NzOL26KnAOeilvCDzgB9WPSyd9GbGIxVNJTNTZu7aSLvr
 h1Dgxqoaf8m1QD/yOoGIUqnYkCwyd1lkbDqrZcVUwOjEdYlrAg1apwUbGWpnZG9BlgqR
 UQ6grOk8BjxzGPfvVXWC/XXMZW809LUMcYKMpu6dq0nXeYczNHSf1069yXNeTk9+j7qb
 VcTTD1y23tEuhL4pw8PfwMHqfivX19D8iRseyGqHj+zFfTIQySq3FRNix33L5hGH1eLz
 tLTKhOCxnHOTbDMwNFDOGuQsUmCi9qNNcTSutWDoWMJD9B5ANDxlvP+wwVRMC55f6/9+
 LaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741356680; x=1741961480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJAAX7vKXgJQE8XqN0qNtPWcrBi2YgAiRTW2vWZKD6U=;
 b=E7a3xMcuw7GfRlaRAsF9t5AVT0moU3/liPy0kQikIjTcE4FZ9GBx4eL98BDQQmIiuW
 9SqYjtSVymrDHspz60MPGX7bzOMR/DToxpx+jR5xyLaE4BGPsjxilfJuHASmh9KQd700
 rMyvkff+2F1/iz/SG7XeRH0tYSggy+Zk7dQESHih7qrBHiM9dfp5pvjC1eTDna80N1K9
 DjBxlXHSpDO6TNaGL8rLeiEWFTMILZCjsw0pbN6bd9mJN5IWPfhZpuxh+N1G3CgPpKrR
 JqWWs9+9quMHk16+mrXl29zbEKHns9CVGzdaPQxh/8/1SaZE9Ycq3RSANbIpPuPrEBDG
 GPPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuR5/1j1Vm/WZyZqIby+IMID31EmH7Rwe/mgPmv/iNWLIqgL+t7mUUMMiIH5XawLAq7g3UyW0Wyz/I@nongnu.org
X-Gm-Message-State: AOJu0YzRzdf0+fNTmk519IXzt85H8OLc9RlSSKdw2Ec9nB8Dvprd2OIt
 dk+Bw4jsl1KALM98VHo0LqwFoGIJrPzMz0KmIj1ZlB8EIyUOThych3iETsqxHIw=
X-Gm-Gg: ASbGncs5iKOm9lAMp0m3B297ZhuagY0Ab5k5kG6bRJS8+JZEUGf9qoM9qb9zXx1om1S
 57zYVpi+YV+E6jJb6w0gkeftxKjsJP+AHFtdkWHV55cUJ79Wo2pT0onoyi/A1my7WuujiFzrgQq
 2RdxU6y3mtmWHrzhvppbQYlBw2WT0Q7xZYgD9Lam8CSyUgHGMHO9MNlAdarL7n6aRbNVdUVkNXq
 srpeMZt4OVE0lS91uXGBNTL08oxNWzLjQAqI9esG2hHQQb2fdvb4iC3qaFmEsPrKm5DaMSI1M9N
 HlHfBlZRNQ5UOeJ+yXvW02GEcvi45XOZiMEqFlH0ThlIyqCJ+iRNZk/QTs22SXsiu0bCfTcWNSv
 MFO4wGOmb7EQA
X-Google-Smtp-Source: AGHT+IFXasXk7QuPA6Mvw2sSC+rTO5X9MeL9Gh2AJ5RXnIJlAM1Pfb41OlCOhqz8D+cW4Tzmo1HkXA==
X-Received: by 2002:a05:6000:1546:b0:390:f60a:e547 with SMTP id
 ffacd0b85a97d-39132dd8745mr2677922f8f.54.1741356679919; 
 Fri, 07 Mar 2025 06:11:19 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c106a1asm5446252f8f.100.2025.03.07.06.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 06:11:19 -0800 (PST)
Message-ID: <a7769d31-7c0e-4e60-9c67-8ebf4af2fd93@linaro.org>
Date: Fri, 7 Mar 2025 15:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ppc/amigaone: Add #defines for memory map constants
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1740673173.git.balaton@eik.bme.hu>
 <3b8e54ad9220d57e7b0a33f3570e880f26677ce8.1740673173.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3b8e54ad9220d57e7b0a33f3570e880f26677ce8.1740673173.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 27/2/25 17:39, BALATON Zoltan wrote:
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/amigaone.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


