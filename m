Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228DE7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 08:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSu4o-0004xz-QV; Wed, 01 Jan 2025 03:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1tSu4o-0004xp-59
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:27:38 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1tSu4m-0008Rv-OU
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:27:37 -0500
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso388218039f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735720052; x=1736324852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JofWtTiVqY3SaUL2gFQrvmITFhENuwDZsUsjHp+yfH4=;
 b=deBNYn9pbbOdsYLkXlI3KL0rxDJWMbY/2s4O078mZUOYlsNk8H9ceW3IqcS3y/j3b1
 SpFSv3GNiFylmoqiqPsyA7Ha1cBjLro2w3/8THfFgpsl0Mc5lHMhAoFRW5J348xD54Bn
 WoXH2E9T6oBuuof7BygiYexhThM+cn4rygthdi94A3x9CMkRAyTPu1l5gL2Db9VPrfoQ
 UR7x75nfgwHa/+P3ND2Podk3w46AUcWJu/vazyRErcnqSfEEQ5k2aGZo3gAOlDgirFcX
 J9GruCHuffezED8kBqBw8+Ad48GfmMf0QYQGfX4O0urMf5sddZxg5mMcns5/qYZlxcYZ
 leQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735720052; x=1736324852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JofWtTiVqY3SaUL2gFQrvmITFhENuwDZsUsjHp+yfH4=;
 b=RH3y5CQq/FWcSc+g3LlwqPmRJUfwbDoSkH8HpP8HzCYhBsXlA4bWmUBTQnfjN2MzkI
 AeSmYPY4gETDz/7K2ghnXD91Y5xvZYqVBBSLoOYqjR7LjsDAX+ounA2dnNxAd/0hFJsK
 O8dOaiTuLaHU5+JhG564m29NUkXDTJLRjKA51HHT17xvl+AGeAC708r2mVZfzEF0iSzW
 Byks575h1dEY+xkXtL7zXbmSUVgi0iMHP363OTGjKt/zE0nq4eFoK00ONj57Yi/k3xj3
 EIIClJbWb8m5hx41BSkLqipQmhV1YCeBo2Rfx0YnSdWd1VHkfFpf0y+NlHeNlVGHdGIa
 2HVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbWVjg0s6UogNbCsk2HYqhKe3gdxR1z4aJzaPewNW1TohlaSpWaasdEpt8OLzsl2YeTWU6cRrbCYL/@nongnu.org
X-Gm-Message-State: AOJu0YyEGT81nm/BdEVg0EpMIa4wvn6ppwIpvTglyQTNxPqpqFWt3Emu
 Gzu1zhPM6MVruK8234RXYbAvUFcRaXaqn+4+/E7XOJygJLjrlTTiV6EMOg144rZpHF2DKCtFkDf
 UumR8VZdL4ghITjsIeMHxMkwdYlWmMp0gSQLcYQ==
X-Gm-Gg: ASbGncvaaeHEdKmU7DQPT7DINS/wttjsq1AwFGkP5THRO/DacE5LF4qmfeuDRSmsYNX
 gtOhVQFFIcnU2HSU0alc6dgxGe1+7Umf4RBGGCA==
X-Google-Smtp-Source: AGHT+IEX8NBHkp1Ul4rcpdZlX4/ewP9EamOj1IM9v/ngOVlq5bwo6hd3hQXpRPba3BdklP091TvKRGZzYmIeCjrApeY=
X-Received: by 2002:a5e:cb42:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-84988735634mr3440203839f.5.1735720052208; Wed, 01 Jan 2025
 00:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20250101081555.1050736-1-anisinha@redhat.com>
In-Reply-To: <20250101081555.1050736-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Wed, 1 Jan 2025 09:27:21 +0100
Message-ID: <CAPMQPEL=sEp-e9NR2FKU6DnnfYdYHY2Z-ymDRtyGgwj2i5Ge7g@mail.gmail.com>
Subject: Re: [PATCH] qtest/fw-cfg: remove compiled out code
To: Ani Sinha <anisinha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-io1-xd29.google.com
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

On Wed, 1 Jan 2025 at 09:16, Ani Sinha <anisinha@redhat.com> wrote:
>
> Remove code that is already compiled out. This prevents confusion.
>
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/fw_cfg-test.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

