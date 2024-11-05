Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63CDD1CA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ARy-0001yr-O1; Mon, 04 Nov 2024 22:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8ARx-0001yd-60
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:41:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8ARv-0000xU-GB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:41:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c805a0753so46177615ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730778106; x=1731382906; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G29ji3B3dcfxxHIOyZgoKioTbNqXy2uHPZonI74Y7Bo=;
 b=IJNPR8/+qKpROp+veOyY8gKeuSUgmsE8J5mouRtASFlyF7GfKSXu2uKY3D68A9WzF2
 a9Rl0nUuEbS2GO2emKPltjFM0SLMyggHXLgn1KgfQtmenTbB2pxdQb/qVKxna/E0j0sP
 iaGd76SZY+CULad2AuDX4+kJIo/RJUKArh+KbnhNjNul5fFsL/JUCR3UPurtvZbltzhQ
 Y0JxcOgr/tc+bLiX/q4dzpC9k/f6lahHaUKKYTX45wZGMDqK0+Cer3/tDzEKM22WnzFb
 HdVJ41/hwhJHIB/U0aWCPD8QRWBuBZPWqS/7adHp2MBpZejQJR72FjPqzcZGvwoKFbro
 ZFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730778106; x=1731382906;
 h=content-transfer-encoding:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G29ji3B3dcfxxHIOyZgoKioTbNqXy2uHPZonI74Y7Bo=;
 b=l65JmpfU9Js1CqAIzlbpeh0nZp3NwkVQikA/R6MflZpibSjd3ZRbeGU5J81IY9TJMJ
 XpNlO7LrT8FA6Or5aEMFIRPpWRPQ0XOd5+Y/ZVuca/ruNWIOlhIMR+VBsklVa/fZWP9O
 eTY/WL3JOXz+mRQ2K3pixCPSJCMAvIfTidq+a+LG9mLjSpKMdH9Ecd0niBMn0p4UZTE7
 ZvsR9z6tBL78swcQLAQ59VSg7a8k39F3EY/kG+WFxM+SqlOuQruDTPQ/CSayrdicINh/
 KoXfiArjNraKcRO71g2aA8/2rdTv/WqWE1KJvMjh1MNLxuZBB8Om5J5pVKx+2+NkEyGx
 bZjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCuj7BKYEN6rhogAEWXs9wbHaOTs0uP02I20OlCAoJjstPx+00FEMvGuVWv7wR2S1TdntNaZ35SlQ6@nongnu.org
X-Gm-Message-State: AOJu0YzaDCaSYYmnt2rgoPmwvsf1PR7eK80H8qis66ZE6DF14dDNCByr
 Uqw/1K7YlXYCIEUjEg5cJcUuFE/0mPHcyYppZnl8ZV2BRSCZsp6kfBtrBTV2aDA=
X-Google-Smtp-Source: AGHT+IEl2kcFbWsgM8BlMlnTd3+Ke8jfOTpfU0OSAWU4q3BWUSmMclGuTsLYzLq7Rrc+acPiFhbunw==
X-Received: by 2002:a17:902:f60a:b0:20c:dbff:b9d8 with SMTP id
 d9443c01a7336-210c6c3f27emr435490475ad.37.1730778105741; 
 Mon, 04 Nov 2024 19:41:45 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057d43fasm69150305ad.265.2024.11.04.19.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 19:41:45 -0800 (PST)
Message-ID: <b8806360-a2b6-4608-83a3-db67e264c733@linaro.org>
Date: Mon, 4 Nov 2024 19:41:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: test regression - qemu:block-slow+slow / io-raw-055
To: peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

SGksDQoNCnRoaXMgdGVzdCB3YXMgcmVjZW50bHkgYnJva2VuIGJ5IDM0YTg4OSAobWlncmF0
aW9uOiBEcm9wIA0KbWlncmF0aW9uX2lzX2lkbGUoKSkuDQoNClJlcHJvZHVjZSB3aXRoOg0K
bWVzb24gdGVzdCAtQyBidWlsZCAtdCAxIC0tc2V0dXAgc2xvdyAgLS1udW0tcHJvY2Vzc2Vz
IDEgDQotLXByaW50LWVycm9ybG9ncyBpby1yYXctMDU1IC0tdmVyYm9zZQ0KDQoxLzEgcWVt
dTpibG9jay1zbG93K3Nsb3cgLyBpby1yYXctMDU1ICAgICAgICBSVU5OSU5HDQogPj4+IEFT
QU5fT1BUSU9OUz1oYWx0X29uX2Vycm9yPTE6YWJvcnRfb25fZXJyb3I9MTpwcmludF9zdW1t
YXJ5PTEgDQpVQlNBTl9PUFRJT05TPWhhbHRfb25fZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0x
OnByaW50X3N1bW1hcnk9MTpwcmludF9zdGFja3RyYWNlPTEgDQpNQUxMT0NfUEVSVFVSQl89
MjkgTUVTT05fVEVTVF9JVEVSQVRJT049MSANClBZVEhPTj0vaG9tZS91c2VyLy53b3JrL3Fl
bXUvYnVpbGQvcHl2ZW52L2Jpbi9weXRob24zIEdfVEVTVF9TTE9XPTEgDQpTUEVFRD1zbG93
IA0KTVNBTl9PUFRJT05TPWhhbHRfb25fZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0xOnByaW50
X3N1bW1hcnk9MTpwcmludF9zdGFja3RyYWNlPTEgDQovaG9tZS91c2VyLy53b3JrL3FlbXUv
YnVpbGQvcHl2ZW52L2Jpbi9weXRob24zIA0KL2hvbWUvdXNlci8ud29yay9xZW11L2J1aWxk
Ly4uL3Rlc3RzL3FlbXUtaW90ZXN0cy9jaGVjayAtdGFwIC1yYXcgMDU1IA0KLS1zb3VyY2Ut
ZGlyIC9ob21lL3VzZXIvLndvcmsvcWVtdS90ZXN0cy9xZW11LWlvdGVzdHMgLS1idWlsZC1k
aXIgDQovaG9tZS91c2VyLy53b3JrL3FlbXUvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzDQri
lrYgMS8xIHJhdyAwNTUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZBSUwNCjEv
MSBxZW11OmJsb2NrLXNsb3crc2xvdyAvIGlvLXJhdy0wNTUgICAgICAgIEVSUk9SICAgICAg
ICAgICAxMS4wNnMgDQpleGl0IHN0YXR1cyAxDQrigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJUgDQrinIAgDQrigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJUNCnN0ZGVycjoNCi0tLSAvaG9tZS91c2VyLy53b3JrL3FlbXUvdGVzdHMvcWVt
dS1pb3Rlc3RzLzA1NS5vdXQNCisrKyAvaG9tZS91c2VyLy53b3JrL3FlbXUvYnVpbGQvc2Ny
YXRjaC9yYXctZmlsZS0wNTUvMDU1Lm91dC5iYWQNCkBAIC0xLDUgKzEsMjE1IEBADQotLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KKy4uLi4uLkVSUk9SOnFl
bXUucW1wLnFtcF9jbGllbnQucWVtdS0xODU2Mzg4OkZhaWxlZCB0byByZWNlaXZlIA0KR3Jl
ZXRpbmc6IEVPRkVycm9yDQorRVJST1I6cWVtdS5xbXAucW1wX2NsaWVudC5xZW11LTE4NTYz
ODg6RmFpbGVkIHRvIGVzdGFibGlzaCBzZXNzaW9uOiANCkVPRkVycm9yDQoNCi0tLQ0KDQpS
ZWdhcmRzLA0KUGllcnJpY2sNCg==

