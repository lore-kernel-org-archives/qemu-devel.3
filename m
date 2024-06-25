Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B55C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6p2-0005D1-J1; Tue, 25 Jun 2024 10:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM6p0-0005Ce-BD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:06:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM6oy-00022X-Mr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:06:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9d9b57b90so37378995ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719324415; x=1719929215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ciGB53KUieuWK8O7mqsJYtUePrIv1XfATtmdc7iE/s=;
 b=dC8SY2Kc670qLbo20Imt/m6qzGYdbUD0DlPdkGGHvGT6ys/GDZ7JJbds+QjleYhavE
 Xr/NTY/ZgF5M7DSayxKSpMH0JC9AagK1dJIoAfr1ttL1MyZzljrYTrOFOTNDtodjRuxh
 dKGc1FS6dxPvZk6fH2jGXZAvldaEvR42Bm+zGBjUcsXJAz+FatXzPuz9wABjWp3RMrOU
 X74jJzO9r0WMESW32mO/L9gFsIQ244Ig/qZszWkOWVumt4gbFAPi7sNplO4etrgxniwN
 4PHESwQkrv0cVmBdDh28hVh7ywWX2WKLORVuCHb7xm2qopEiyXaKLaSKyynMfJ4cDSEP
 r8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324415; x=1719929215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ciGB53KUieuWK8O7mqsJYtUePrIv1XfATtmdc7iE/s=;
 b=Cmb1wy/L7BJt7yY09vjMYuttpeUsbsamsy3WWFMlbq0d9onW5NpBG+LFvWV4qlpYv4
 i5098DqZNcoIwXNQhAJvFz6WFdwpnpnId2gh06qnxK6BbGi6T2YwwFAK+mBGqz285A0u
 zi/KT86DZwqu0KQL40u+MZQ9OSBbovXgbNs7G2ULgrkb4nh+mwxtZXPINJd69R+dVQ+Q
 geZch4H3HH3WhTl7T2OML/0Zax5Y9Ir5cdBchjcGdVFBTgjLfpvkmnnl8+oWBGjrlrwg
 I2A/JSvmshV0mE/D5fAu2rchXU85Ux1zHjW90QX1MrJa2ozvNp5r/ai0zilpfXvhsldE
 gq6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/xN6j3WT8F2jaQyCMyk0OcgpX44l9t6pbANangX378jSeoyMBzcoKv05KY0K+OqdGeTHDdIx42KsU6/aC2r2kX1/UzA=
X-Gm-Message-State: AOJu0YxxaSiCPAc1Z/sYYIwAtHYY678nMC/lTz3Yf4AbJRAIsrozPA2f
 ru7v0k6jwGrKskkW18GqizNBwBJ7YhNjRBUSLHhS9pJEno9fHC5Li0hdmWgqcFg=
X-Google-Smtp-Source: AGHT+IFcr8nzc5nSRSzOwrvJCZc2QMp90M4Dlz/XVWwsZF02oQsZPiwti/N7WsAAFy8B7PRhQ28vrQ==
X-Received: by 2002:a17:903:41cd:b0:1f8:55dd:3c44 with SMTP id
 d9443c01a7336-1fa23f235b4mr96652265ad.61.1719324414718; 
 Tue, 25 Jun 2024 07:06:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc9efesm80970175ad.309.2024.06.25.07.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 07:06:54 -0700 (PDT)
Message-ID: <d63f54ab-d5b3-4c45-a648-a50a5bb79805@linaro.org>
Date: Tue, 25 Jun 2024 07:06:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help improve 32-bit testing
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
 <d59f9541-eb4e-4a0a-b2c2-54d7eecbff95@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d59f9541-eb4e-4a0a-b2c2-54d7eecbff95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/25/24 00:11, Thomas Huth wrote:
> On 25/06/2024 01.33, Richard Henderson wrote:
>> Hiya,
>>
>> I've just discovered a 32-bit build issue that is probably 3 weeks old.
>>
>> While we still support 32-bit builds at all, I would request that we improve our 
>> cross-i686 testing.  For instance: we have cross-i686-user and cross-i686-tci.  There is 
>> some system build testing in the tci job, but (rightfully) not everything.
> 
> System emulation on 32-bit x86 hosts is marked as deprecated since QEMU 8.0 ... maybe we 
> could finally remove it instead?

I'm ok with that too.  I just don't want the current situation to stand.


r~

