Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED0DC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uVC-0008Bt-Ab; Wed, 22 May 2024 18:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uV0-0008Ao-9D
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:31:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uUw-0005ac-A4
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:31:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f4dcc3eeb3so1451446b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716417102; x=1717021902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pVY2vkTW2T8JT02nqLWPdhiqo2HS5RWtXHIhakyE1H8=;
 b=fHAI6lRu1pxLCoBLLPE273L/neLl8tEj0HpDnfeBe3zF9yfV/qs1J8XJ0ve+EDKL2T
 xpvzucs0dYLncZHFeqbCAdN+4hEz3Cwv48DltNVHwYjeII00o1z84+NZcrgk3k3yJiEO
 n3aBOLpQkBL0Z375M0ks0hqP6mAmHrWHwFVI30YNb6cb0fFxKXeCJAv/M+JXivtYqHbb
 nYRYpRFutBdvRkNniAsjY5LXEZQvpNxa6JJ6di6juhgaa4f96umbCxsDLFnxr73gOnsg
 k4CtLjoVPVvk+O6RTsdk7rbd9lPLrzazUOvXmrBMqJwvQKC6SfvqYomMm86lQfHfKosN
 LdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716417102; x=1717021902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVY2vkTW2T8JT02nqLWPdhiqo2HS5RWtXHIhakyE1H8=;
 b=qucIADkXdbINNiWsMlu9epLbzrlcO1KkC23iAm2B1M+OKc2UFnpsR4FSws9Q12sYQI
 Ca+14m7zeRkW1Hym5+zP6DcQ5MaDzK5jpnUOJH81wbzn1j8noxfuiI5gs+FHNoIoJWll
 MoWi2z5UFU5jmZ5/bYOScLzKW15nEKsjdVZo+rdd09SZSBbxPk8/MkWDAYF1Mhe/MMF2
 J9LREvFR6G+Byk31Mz99XMiwEdDh5K1+Bb+tUAY5/ly1dAfTdQnDNCbJT6FOWSosqbIH
 tK01w1p4VZOlLR88SP3HBNca0gGsZiCjo275/pw4D/QsDL43Dr5jA1bA/uikhCvoeTPv
 k5NQ==
X-Gm-Message-State: AOJu0YzLHtFIx6+ObWZiyfLkbOS44ztMUDahgB6zrMfjCemOdbw5MPwB
 wEf3WrL4wZ7ljhZHQMa/vv6G1YyHzWX76+5XL6HwGmBaTKPr5PI3YATF8lGQEhKTM9HovvMTs31
 y
X-Google-Smtp-Source: AGHT+IHqb0fInknD+eoAtqA3/lJylK37ZH7QVFusugJltGmOOs4X6V4e8fP6GsgKfWrbgHyQnZEYAA==
X-Received: by 2002:a05:6a20:9188:b0:1af:8fa8:3126 with SMTP id
 adf61e73a8af0-1b1f881fc93mr4204883637.6.1716417102180; 
 Wed, 22 May 2024 15:31:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a632725sm20019095a12.12.2024.05.22.15.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 15:31:41 -0700 (PDT)
Message-ID: <fb886e9c-0d8f-4771-858a-070b27a443bc@linaro.org>
Date: Wed, 22 May 2024 15:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] vfio queue
To: qemu-devel@nongnu.org
References: <20240522095442.195243-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/22/24 02:53, Cédric Le Goater wrote:
> The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:
> 
>    Merge tag 'pull-maintainer-may24-160524-2' ofhttps://gitlab.com/stsquad/qemu  into staging (2024-05-16 10:02:56 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20240522
> 
> for you to fetch changes up to b4e1670c494165d4186930d56f692857f4fec89b:
> 
>    vfio/igd: Use g_autofree in vfio_probe_igd_bar4_quirk() (2024-05-22 10:04:22 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Improvement of error reporting during migration
> * Removed Vendor Specific Capability check on newer machine
> * Addition of a VFIO migration QAPI event
> * Changed prototype of routines using an error parameter to return bool
> * Several cleanups regarding autofree variables

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


