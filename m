Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886CD6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3yR-0002UG-8a; Thu, 21 Nov 2024 04:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tE3yP-0002QP-0y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:59:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tE3yN-0005jD-CM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:59:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38231f84dccso460729f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732183177; x=1732787977; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BbEfDWhKyYd9zSBb/mGkC0SqEbMMrXlD49MbRQL/sy8=;
 b=F5SLj24L0xOy435DsP/7Z+uS/gIQ5i9l/Iz6YhvaoiTPy0URfuJSQPhxUqtUIT16vr
 zS8wwJHU0UWpZFnvQDwm8tgHcpUch/jL1fvQawjcxV5HdswrTNZP4LoEmRKAO0KRxHfF
 gul2huIlg+uBkU460ReVE7mCCqlmksgOYFrTgxVOUcdKlvmDxzUrllxkhIrvxdkxDkUh
 Ck7PoPz+/SX5vLIZjorr0GO34Qd7KyVIFkgrqyUKWgdX37c7nLbDGrY9z3cPDGyRTzXT
 MBcNzKR7fZ8BNB/B9VzxSXV0X9Wx3JJUOU4HA72J2V67arPY78ZrZzpMWReGmbeypo2l
 DOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732183177; x=1732787977;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BbEfDWhKyYd9zSBb/mGkC0SqEbMMrXlD49MbRQL/sy8=;
 b=WHvoi+UiskBwkeDPaZwtAYYck+6eN+3eEJESWIp5Ur23Ybax46UA4SdPrlxHpJO80K
 FmnHm1YqZMRk7TSMPvpF2ZH453S1453TBy7mC78P/8LSRFFKNgoSI7WdvNLZewjAtJXb
 4pnN9bAVADhwulh1QNB2a+TZaSh/JpP5OurfKOAQtQeq5zvIwr+ZXKlrP54ArnvDahts
 yH1fArA2NSxKCfWsMcfis4z+GdLbh7/tH0AEPuY0gik/T56tcLNjRCdfozgcJaPxt9xH
 xbjJiRsS9gzpNqw1zohOdWDtEc4YEZaoC04mjEZPbzFBzLvjLyuhgWf2RkIhHb4hS8Ml
 3+lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoosf1NmdqcGnZBQ2U6eUP8/QpjvOwNwGmTd8HDCzVT+/XIpmxWiPmt8Qg7sKPu6bEZm9MRh4or9/D@nongnu.org
X-Gm-Message-State: AOJu0YwBt1u2i4TuQkSsg70sVSQZNdU0pPook6XB1FCOlgwkgFlevjZC
 KzJnN5dVygBxFkaPwfxjUKo37/SVsG7Tbi3jQRI6TDfp1g0WaIOzfCKzD47GltY=
X-Gm-Gg: ASbGnctWy2MZbDHkmFNIu6RjtOTnQB1I8E4on/erKgUYdLqdvUbg+ezEDzBf+9rhAJU
 mGumZ2JWAD9bWsU/rAzKaKHea1dgJNTJq53zGbkJP/gBUugqdq2W7VbMoLWX5ZThZpzCTD6OV7F
 XKRkByvU+FHA5Jch6l8+KN5s84Ba+A/a5OhJzmjxBYV8TwR8uhz3KlQAOuROjIBCRYJUR13Hnyc
 96Z6qhZgfmP7boEIOHF0q5non/Dh4HCbwDLJDUbnEeIWJdT
X-Google-Smtp-Source: AGHT+IHuAdyU2gUTB8AFmmGYwmuOyPU7AACal18ZnzSD1VriJhBVVgm2ZUCjTE3R1OltPQ/PrtIiyg==
X-Received: by 2002:a05:6000:1448:b0:382:4d54:2cd9 with SMTP id
 ffacd0b85a97d-38254ae84ccmr4648432f8f.20.1732183177248; 
 Thu, 21 Nov 2024 01:59:37 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382549052b5sm4458010f8f.13.2024.11.21.01.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 01:59:36 -0800 (PST)
Date: Thu, 21 Nov 2024 10:00:00 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: New "rme-guest" QEMU object addition
Message-ID: <20241121100000.GA2024976@myrica>
References: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Itaru,

On Thu, Nov 21, 2024 at 02:34:24PM +0900, Itaru Kitayama wrote:
> Hi Jean, Mathieu,
> 
> I’ve been using you guys’ ccs/v3 QEMU for some time to bring up an Realm instance without a major issue, and as a one who is making changes libvirt to support CCA, I wonder if you could merge the v3 local changes under qap dir first so I can query the feature from libvirt?

I'm not very familiar with libvirt, which changes are needed for query,
this one:
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/250732e03bf0bd2e2a9058358707baf51d0193cb#68c067b8d3c460fb3331256759e405f48df64c73
?

The problem for upstreaming QEMU VMM patches is that the whole series
depends on the updated KVM API, so until that gets merged in Linux I can't
get the QEMU patches merged
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/bb044aeb5bf888f193b1def0a4d03de2ff8389ac
https://lore.kernel.org/linux-arm-kernel/20241004152804.72508-1-steven.price@arm.com/
And without the KVM API we can't allow users to create a rme-guest object,
since it wouldn't be functional.

Thanks,
Jean

