Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DAEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMLV-0002Gg-C8; Wed, 14 Aug 2024 18:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMLT-0002B2-U3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:19:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMLS-0003x5-Ey
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:19:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc47abc040so3236415ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723673993; x=1724278793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=igvCa6KFBkfZv//Q37tD5DjsRMiXWlZ0E24G4o0hob8=;
 b=hKAa2a5e52gdg1C+dUTDYf59zkSnvr/y0KNzosQrkMcKGeZj2sYwCUAudkQPTjuBMq
 D4SthvwaU+42L5PHMhFCicWPyebAkV+xQscg8iaTNc7dFpRi255WvxX7rN8VpWXBF7ct
 QqsHa07xbfcWvKpkd9++qpxkHF0aWoTLEd8Y185jDs8Pw9fLBtW9Syluyva7YJGcigM2
 KJD0tp/5lqccIGOEPX+EHiDUBQgHAPf36MHp8cs4Pt0mW4yFvcatxpIvcR9A8CRLw4hk
 DKVz2EYXvT4TwDtkKHN8+CPCAhLgzDwiaPz3v0QbWoEPR44OrckRwjUy0YY/v45+WUCK
 AC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723673993; x=1724278793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=igvCa6KFBkfZv//Q37tD5DjsRMiXWlZ0E24G4o0hob8=;
 b=fjFSmQLX9XAz74uz25Foi8WoNqQ74r9wP+pmXNjLEi7evUz+m6xVEarkiaKM5JpGKs
 TqUxFj3VVlhA82eeJMBnVjSNznMZLXKYE3kGGhcKhd+fJVylRivIK8KwG5QOM5NvrMfr
 Rc9iQnAxeTq5RAeNJ5HIX0IFX5juN/emJEsLDq2/q0Zy1i+wH3g2CSIKcS6Uqi8aGxuQ
 ccGEPmT75dbE1P2g+3hvvziMcP56DdVjXP1qGqOKsFKvN4PcD2so7iagzm4XO/PQ08SQ
 AOROP2iWkNVkdsdwkaigIe3b4w7TuCaVmMZs1TE/zJwfp655kajNFClNRMiXCZ9lLpmi
 Kq6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ySG7dIeQN5E6Axwhyu0C9JlJGTmnyAxWuJjvUOYbjOGoV5cCVL46RIWgUsGzaSVqaeKhd/fGdyv7+sVE6ml482sP+YA=
X-Gm-Message-State: AOJu0YwsPRbNQgLinGfsRg7/KLfqeFkiwXNMRYPbyVI1v5sIZL3UwIeY
 bFyAOA5uwGp+oeTjMOvIEy9BGfNPud+B/sWncc6xFqZLKyiPWunYfudGBgMBb/XaKvtwzPSXtR+
 6hp4=
X-Google-Smtp-Source: AGHT+IGqXXWf/9feypDHzrcnWoEJGZoF4zXT5eb0ynOcMrv9chQ5pBQuG1rRgexBJxtSojsqFI9GOw==
X-Received: by 2002:a17:902:e74d:b0:1fd:63d7:5d21 with SMTP id
 d9443c01a7336-201d6520966mr45461525ad.47.1723673992531; 
 Wed, 14 Aug 2024 15:19:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03203efsm1149405ad.118.2024.08.14.15.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:19:52 -0700 (PDT)
Message-ID: <271d3df3-1e95-4995-bc55-e95fe219c071@linaro.org>
Date: Thu, 15 Aug 2024 08:19:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1? 4/4] linux-user/mips: Select Loongson CPU for
 Loongson binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier
 <laurent@vivier.eu>, YunQiang Su <syq@debian.org>
References: <20240814133928.6746-1-philmd@linaro.org>
 <20240814133928.6746-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814133928.6746-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/14/24 23:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/mips64/target_elf.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And yes, this might as well go in with the others for 9.1.


r~

