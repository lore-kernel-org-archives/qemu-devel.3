Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789BEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlax-0003gT-ER; Tue, 14 Jan 2025 13:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlaT-0003Kf-B2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:25 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlaR-0004Sa-Hl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:24 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21631789fcdso551295ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736879062; x=1737483862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLgjmXcbBcdeSJUEOrS+k2KYsEXYGeTmRAEqoq6eElQ=;
 b=iDIYyzUCK5z61tarDL3JnITlyXxZ75Te4cNCt2cjqtmYl1yEzF2eLk7HkDBc4fzuAK
 soDfutsXA5F+GprbVSSjxxYDkFIWOMEHveIY1/Qy5CdcRGPYFjbY5ZgqP8sHmpLuc67H
 jUtCN5kZ8U42TH2Q2tGJ7mCJRvWluTY89NDUp8VPGsxwJ5kAnJCGiSkDJwqdrmQRfbD/
 k20EdzW6gV1R2A9bMaBUOsRlAroO8StcU2V7LKe8IzT/3zBjYKf6JLoL/hqH2kgp7mtg
 aT8SlcdmgCLYHwt2ySkcZlF5VT/qQx+BDO8cLcou72XQL/wMnRYaoJ6hjO0ax409eznZ
 X/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736879062; x=1737483862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dLgjmXcbBcdeSJUEOrS+k2KYsEXYGeTmRAEqoq6eElQ=;
 b=tRoWBJoqCtBiY8b54eQZ4wKcoXBrddYtVaCnhyJIwVhXDj2iwT+zqcmVNwaV8AMQM2
 xz1FgWHPwiRRGaiBpVRmSRHzkTUi43bmzbZXjdoS0IFt7wTlOJeZpEf3sWbOf2ezELcy
 w7Ppgk5ujcDfQ4BY67cza29RwR4eBczGyW1bf3LVGA7ngOFryD6N9RRtw1tq3tm5kw9K
 IDatV90y1r80cNRV5kTjG79I0+HLgAhIcYCKo3bXSZL8MCI7LIt74NRpsIh0c+Czd6T9
 dKeCDwkNnP4k9Vtx6l6fp5gUgX/9MTiNKWfiYdeq4rbQOdL5Vxh8/0ih2OduNFffUZwB
 ZEPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUze4E9X5YDVWMyF4SliQtpjWunjseHpWS//pbpW0b0QqSXPFQTvrw3Tv79WpgFuh230YwOFiWcgXgb@nongnu.org
X-Gm-Message-State: AOJu0YxA1UKDZg588wJtSFk0zKtqhhQrKMhzOYwIuqdPX6V/B5GLpgJP
 VM7veVVyRCFM/4EqLBqryFvqTDSrzQIONNOBCv/f88jw6E/wPqt9VL+wIpafq2o=
X-Gm-Gg: ASbGncumA/Cuddc8UOGfDwrM0zie83v4XA6PElzL97ripZflw5AONRrZZp4OAgNfpZw
 x4o+vNJlaJSd53eEJGyMloVCc0DnGFV6944PsqmdDG0mlz3iCrsK958iAdNwH/M7HATKDjcaco6
 /NKb3L4zLMS4KWWF+KAQYrozGKb6WmvVdTsIaWjoAJeGkGbXDK3UFK0p1kWVofOKfKx0rlrOHIe
 AkjLLSxPJI4D65w7cP2HY0WOp2ZgwQuUVzmVK3fESa0otyGTF+AowpxeizZeOoF7pSQfQ==
X-Google-Smtp-Source: AGHT+IHTVN9x+3kzmxhjPI/ouCL3Z3Dg4qr98kj+QHm30wG/Mb2xZjdCx72krjgR+7ltIpLx6SHZHw==
X-Received: by 2002:a05:6a20:6a05:b0:1e1:eaff:2c23 with SMTP id
 adf61e73a8af0-1e89c9f27a7mr33700220637.12.1736879062080; 
 Tue, 14 Jan 2025 10:24:22 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a3196da0bf3sm8701392a12.42.2025.01.14.10.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 10:24:21 -0800 (PST)
Message-ID: <57dcec24-0367-412b-8675-84671957743b@linaro.org>
Date: Tue, 14 Jan 2025 10:24:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/37] docs/sphinx: include kernel-doc script as a
 dependency
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-32-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114113821.768750-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMS8xNC8yNSAwMzozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXaGVuIHdlIHVwZGF0
ZSB0aGUgc2NyaXB0IHdlIHNob3VsZCByZWJ1aWxkIHRoZSBkb2NzLiBPdGhlcndpc2UNCj4g
YnJlYWtpbmcgY2hhbmdlcyBtYWRlIHRvIHRoZSBrZG9jIHNjcmlwdCBkb24ndCBiZWNvbWUg
YXBwYXJlbnQgdW50aWwNCj4gbGF0ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJl
bm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGRvY3Mvc3BoaW54
L2RlcGZpbGUucHkgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL3NwaGlueC9kZXBmaWxlLnB5IGIvZG9jcy9z
cGhpbngvZGVwZmlsZS5weQ0KPiBpbmRleCBlNzRiZTZhZjk4Li5kM2M3NzRkMjhiIDEwMDY0
NA0KPiAtLS0gYS9kb2NzL3NwaGlueC9kZXBmaWxlLnB5DQo+ICsrKyBiL2RvY3Mvc3BoaW54
L2RlcGZpbGUucHkNCj4gQEAgLTMxLDYgKzMxLDkgQEAgZGVmIGdldF9pbmZpbGVzKGVudik6
DQo+ICAgICAgICAgICBmb3IgcGF0aCBpbiBQYXRoKHN0YXRpY19wYXRoKS5yZ2xvYignKicp
Og0KPiAgICAgICAgICAgICAgIHlpZWxkIHN0cihwYXRoKQ0KPiAgIA0KPiArICAgICMgYWxz
byBpbmNsdWRlIGtkb2Mgc2NyaXB0DQo+ICsgICAgeWllbGQgc3RyKGVudi5jb25maWcua2Vy
bmVsZG9jX2JpblsxXSkNCj4gKw0KPiAgIA0KPiAgIGRlZiB3cml0ZV9kZXBmaWxlKGFwcCwg
ZXhjZXB0aW9uKToNCj4gICAgICAgaWYgZXhjZXB0aW9uOg0KDQpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

