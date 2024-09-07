Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CABCE7B04
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 01:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smkd7-0006CC-1D; Fri, 06 Sep 2024 21:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1smkam-0005Ow-Jx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 21:50:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1smkaH-0004Si-R5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 21:50:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso1136719b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725673785; x=1726278585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U5aD6fmWQmIyy90Qib8S21Mealy/Cen9vHpo/8MXhOM=;
 b=SIfiFa2mBnKjMg2qU+HPEAo0u+ijFGSPEa4aliD2rlY1OejylqsgS0aJiDPS7mixcg
 3LLv1E4p6D9BB4ZmI00wEtfjGfQEpZbJJAFlJ8oWqBJ3/vz6MJ1tnwDCLS3Mvzie2o0o
 3tV1JUrzyzOFXyhhg3QyvsyJZ969F1qUzZGoR7gUHaCJ6JtAMhk1eRSwuEEiRjv2QNEY
 UjQMZ19nG2Oxdn4pvEHte8uSl2lqis+9eavFJEbaicvLsLD9xl/ef1FvWHWvZIvnW3iC
 Chlrgx7w3iGg/vREC1hVuPde2whWcObfoM9ghka4Zi94P1Y+umtAbrkhWxZ9BM8yMzln
 JnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725673785; x=1726278585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U5aD6fmWQmIyy90Qib8S21Mealy/Cen9vHpo/8MXhOM=;
 b=l0uy10ON8FZLjAQzNiW83+84KrTPiapRz1hdOckgoA2PDRZC8NL/+n2iM1wC2uZSpG
 zLJ9oDxFh/Ap0btqWvjlOuCTBTMin218Ern2sNt36rM05Wn/FvhsSMG4lFyzjbMF+3ZD
 A1C7zr8N2IsQL+W2lNcotOddchjnzsxLEgs0OuAkXQP+8KrXq4EVPrytUd686Cj18M9T
 7SCHr3Drf5BSes247pNQwId9sxw9ezI9QVk43yfKPX2raKLq4XM7eIPedR9ey/PeYTCG
 SXwOHu3EMo2/qVZJ2mIf2u/k8LkftKyYWeIkGSTNCgdrGzp38+zAU/23uEcOQAnyMQXC
 Mzsg==
X-Gm-Message-State: AOJu0Yy31ZBC5e0+IntzN7vRnVEC60bhQCxOAPW76Lf6vptWSGpn+XV4
 z500RRZBsk+YUa9VziVHq+tC3NJU6WsWgneP/IA6OUX0E9rOi78pvN51h99R+Kk=
X-Google-Smtp-Source: AGHT+IGnvG1ZxgtYOqrPT5Mep7YkW6vgp77NXT8XOTX/TOdH13NTf0B3YMU2hTVi5bwo/4LjiimzyA==
X-Received: by 2002:a05:6a00:2d90:b0:717:8ece:2f8b with SMTP id
 d2e1a72fcca58-718e3fe6a8bmr1608538b3a.17.1725673784794; 
 Fri, 06 Sep 2024 18:49:44 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d825ab12b8sm92629a12.83.2024.09.06.18.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 18:49:44 -0700 (PDT)
Message-ID: <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org>
Date: Fri, 6 Sep 2024 18:49:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <8734met9c8.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8734met9c8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gOS81LzI0IDA4OjIxLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IFRoaXMg
c2VyaWVzIGFsbG93cyBwbHVnaW5zIHRvIGtub3cgd2hpY2ggdmFsdWUgaXMgcmVhZC93cml0
dGVuIGR1cmluZyBhIG1lbW9yeQ0KPj4gYWNjZXNzLg0KPj4NCj4+IEZvciBldmVyeSBtZW1v
cnkgYWNjZXNzLCB3ZSBrbm93IGNvcHkgdGhpcyB2YWx1ZSBiZWZvcmUgY2FsbGluZyBtZW0g
Y2FsbGJhY2tzLA0KPj4gYW5kIHRob3NlIGNhbiBxdWVyeSBpdCB1c2luZyBuZXcgQVBJIGZ1
bmN0aW9uOg0KPj4gLSBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlDQo+IA0KPiBRdWV1ZWQg
dG8gcGF0Y2hlcyAxLTUgdG8gcGx1Z2lucy9uZXh0LCB0aGFua3MuDQo+IA0KPiBZb3UgY2Fu
IHNlbmQgdGhlIHJlLXNwdW4gdmVyc2lvbiBvZiA2IG9uY2UgdGhlIHJldmlldyBjb21tZW50
cyBoYXZlIGJlZW4NCj4gZG9uZS4NCj4gDQoNClRoYW5rcyBBbGV4LA0KDQpyaWdodCBub3cs
IG15IHRyeSB0byBtYWtlIGNoZWNrLXRjZyBhcmUgYmxvY2tlZCB3aXRoIHRoZSBjcm9zcyAN
CmNvbnRhaW5lcnMgd2hvIGRvbid0IGNvbXBpbGUsIHNvIEknbGwgd2FpdCBmb3IgdGhpcyB0
byBiZSByZXNvbHZlZC4NCkkgc3RpbGwgd29uZGVyIGlmIGhhdmluZyBhIHNpbXBsZSBhYXJj
aDY0L3g2NCB0ZXN0IGlzIG5vdCBlbm91Z2gsIGFuZCANCmNvdmVyaW5nIDk5LjklIG9mIHRo
ZSBidWcgd2UgY291bGQgaW50cm9kdWNlIGluIHRoZSBmdXR1cmUgb24gdGhpcy4NCg==

