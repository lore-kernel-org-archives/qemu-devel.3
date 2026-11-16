Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EF606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qs+WuZSx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1tb-0005SC-Fw; Mon, 16 Nov 2026 13:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT1ta-0005OJ-46
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:57:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT1tX-0006Lh-5g
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:57:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1842864f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794855453; x=1795460253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RIC6/AdPDOweSTfySBAr8bYI/5fnqpqzSYxDbZyga2Y=;
 b=qs+WuZSxAMf0tMrjoRUrewh0DBhkMTKMnOOiKmoK7Iz6bI/p2kWPsi6UtMzVITYhnL
 TdFbR4UXk8KLV5Lr/kkDrX5/CLqgKUwzY0V3UjgatPxfQelCfqPS/Mcu0At8wE6c03DR
 AL3hRkzMLY2yQV0UcvljFzwQFafaY3qyth3dF9bpqABGsXK9FWzKtWkvEZpiIp4IzG7X
 NXwNATf8mcUsbCjVspEVZ2zcw5F3j3riAGvDsCuSjDVd3KJrzLmP+E+5pSQHQuMHpx3N
 Xx+GY2WrRjMWIi7N6JKJrE+RAUBKttncHRsOawtSeorYORYeFmNnk6MaCcaEYraoGK3H
 XBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855453; x=1795460253;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RIC6/AdPDOweSTfySBAr8bYI/5fnqpqzSYxDbZyga2Y=;
 b=1b1ql/e6uGc/MB+bTPRd2Khq+e6OimNS63i8VMEgo45PZOwUycaipgPDlTNCY1TDkT
 wqeO9hkWDkx9L/wdokoEgpjCzQiJO5OyX8iondhh4h2BIwcSPUtCEn6++2drkn+xYm9B
 iSY6nF6BO/w9RwgYj2UJyV5aOPcId/BcAaf3Rimlfm6xQhatWhWO80vpVX95VoG3tUL3
 siXQ4fzYlyX/x+HvL7TwSZwMYgKp5WVrm3nj1O7cDvbzE5j50AvryfYxc7Z2f2GT9Aos
 zupLu4ri1OYyKPb8Z/tajqH/DpUNVnVWOtud++n2/xAWJ+xpPI4T+dRkG1oQ1p71Q9DF
 /XHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGhOvyv0OpeXoJs9HgnKIv18U8D0stuwsWgu/nkgQAXBWDw7vhXZBgKfrVHDCIE/i7N4HTT0wkLFvWy@nongnu.org
X-Gm-Message-State: APuU4Z+IWavRWkOJHOccceUkekOKVdaBtNxzmhPFfkyhJ6Ds5v66f3l9
 lAXxQLsPcqRXH3ccKwKFI5nW+OpknKEYUEhypklOC6aPaPtVZPBTlObW3RSLSxjdl33WnEYpn7N
 ZaJQBKgw=
X-Gm-Gg: AZFdTZd1XtoClbCpEeo/y8MUGJMrJLQKycmUa11TD1EgzwSHBMAb0M5u4mGEaIBcQpK
 ALjO+ilxLW0mxb4E0OKBP6sIY469pGbtYtZCxmm4WFizS3xw9spXvJHxELcq1HDFWMrFmJv+BQz
 zYCAW0dvp8fSEdvxOy60vtPLNcMT2YLRi0u4HzZWOqA+XggfAZwOqKIWWT0d1xjCf3DNv467wW4
 hQ7YYFi6VRCJBYjmZ6ju2RViBcQsfDkx7bnwxetOfbBv03z4+O2rJTPeO8ABDc+p3WyWvJ+uMEj
 75vbolq6gMsSYrzApa0etesOhsgOYz3Ph/CuzkzcDrLswArDKWVfGmZEqRYQhRqadoTM9DeQh5C
 dSJjXU9qMbI4yOKcBWlhs5OfQwsBseP/4ORntBMTsFTNcuMRztTJsUhq0Ah9UX3f8SAEk8Dezdp
 sopFVrDbTKYCCyyyKxvgfVhAERPNJOh+G1iPCP27oNZdRrC+o6xeVfSh8JET8F5A855r0Z9Uipn
 0jfzCkN/Dn+ArvheclETeQL74D3FZnNVP1Ar23aIpxIdpix2pLmP56qbzIX3m1apk/CqSeu20aV
 vtAHAdh44yYKyPSLdKXRSRsEzZJ/
X-Received: by 2002:a05:6000:4024:b0:490:d197:bde8 with SMTP id
 ffacd0b85a97d-49c6b972aedmr28472431f8f.0.1794855453450; 
 Mon, 16 Nov 2026 10:57:33 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c18b9sm19789038f8f.20.2026.11.16.10.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:57:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EB6F5F8FE;
 Mon, 16 Nov 2026 18:57:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,  qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org,
 Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v2 28/28] hw/usb: mark UHCI, OCHI & ECHI USB hosts as
 secure
In-Reply-To: <1711cf10-2719-4d6a-93f2-b7a3a7554ecb@redhat.com> (Thomas Huth's
 message of "Fri, 6 Nov 2026 13:28:18 +0100")
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-29-berrange@redhat.com>
 <1711cf10-2719-4d6a-93f2-b7a3a7554ecb@redhat.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Mon, 16 Nov 2026 18:57:31 +0000
Message-ID: <87zev8ioys.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thomas Huth <thuth@redhat.com> writes:

> On 29/10/2026 14.12, Daniel P. Berrang=C3=A9 wrote:
>> Modern virtualized guests are expected to be deployed with the
>> XHCI controller which supports all of USB 1, 2 and 3. The UHCI
>> OCHI and ECHI hosts, however, have all been widely used in
>> virtualization scenarios historically, especially on x86. Indeed
>> the -usb flag will enable UCHI by default.
>> So while these are undesirable hosts in general, this marks them
>> as secure for virtualization use cases.
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>   hw/usb/hcd-ehci-pci.c    | 1 +
>>   hw/usb/hcd-ehci-sysbus.c | 7 +++++++
>>   hw/usb/hcd-ohci-pci.c    | 1 +
>>   hw/usb/hcd-ohci-sysbus.c | 1 +
>>   hw/usb/hcd-uhci.c        | 1 +
>>   5 files changed, 11 insertions(+)
> I'd also rather drop this patch until we've got a proper USB
> maintainer again. Otherwise we promise that these devices are secure,
> but nobody really takes care of security related issues in the end.
> (It's already exhausting enough to get XHCI into a proper shape again)
>

+1 - it's not like users can't use USB but the warning from failing with
secure will at least make them go in with eyes open/look for
alternatives.

>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

