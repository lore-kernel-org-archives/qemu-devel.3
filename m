Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B3C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZn-0002aZ-Kh; Fri, 04 Apr 2025 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZE-0002Km-Bh
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZA-0005mR-9k
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:54 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227a8cdd241so27506925ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786649; x=1744391449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVXoB/Ll224NDDcRV6AvE1MBua5aq1tYEvM+NVFY8IY=;
 b=cM+q5uzWiIes6mp0wCjKLZSthdFZx+EVWDv31iP/pfvm9Idr26Yjcpwj6Qa8dt1BPa
 Qc3dFHQNjVafOQlV9br0AsXqowVDAu+8DeOpG2iz3ql4DShpSavY5vWECnEK9AcGEA35
 fV2//h6bplxD1B50O53AeJCgTrcJEx9OdAbaNtd0Ke1SvCkIuQ/STpkHIqHYhGbAYyOs
 y/8Wcq/j5SRnzTYrzY3v+ydSytsn5T7mKw9gEE3nz187Nl/kg/BLRtR7gMZNaI/sFSnO
 sGt9WijWZZqNvetyJFwKM+hBzfQXbWzx4rSX27oYLdT8QIEAecCgs2a/FjrfyU/BvpSx
 2ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786649; x=1744391449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVXoB/Ll224NDDcRV6AvE1MBua5aq1tYEvM+NVFY8IY=;
 b=XP5wJVe2jeQYhBhF1CjWgkdfPc6Xm+Y1SQYXzRpzO3VgnPc7BTwVDjlX9fWlfmdpUX
 dmseO/3jGFN6TpiCvbJco6IQ4NRTuQ4B5qoNRVzp/hJQaKsdUhKs4aPKivzV54VGRbed
 4yX+Yhw3kx/57BJrjesLpVklQ6d16ei8eMChKUN4nl1vwxSlOiVNmzNj1oP8RRmQ51Qj
 85tLEht1QtRWCAHWFKxzxu0XomG9XzRSdDljT+jTB1QVdF0pHNQpE5eETRcg9X32d3CM
 UlOaHRUipLbNi9X3wjD4NMevhmPUxLwoqiHGITl2O89bfyUXZlz4BENrND03ahqOpKzN
 kmGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUusa+U4QqjoqOklodhqmKKIwwjFWFtxhLPg9zTZhRKLvjyDUUO1T+9VyibLi3U8flPSn3nHOmpw5BS@nongnu.org
X-Gm-Message-State: AOJu0Yy36KUbjrqn96NoGOV3N5wstrrum68AfFyPxsk/x6b1d/YJHLpn
 sesKTtZKQbb+Th/rpTPB1j0oC5Kx9+hlBWjCm3ICsfwjdmLAEkJanVPAYqqN6Us=
X-Gm-Gg: ASbGncsvlSSS76TBqScrnYxxn49QNSTG5q/OHw10IkLqhYPNMTZu5y6a4lDDzcX1yel
 TDzUyQIzQXwhNqfVHtbTjCPFsijKJLE0PrIA++tqQY1sIh2IDJCYBt8j3VPkuhCrrCKopDxiquN
 gl/lH2qU9uNZYJwjM2DH/D0tBPWOj96qCBQ+ICUfiIUVOj4LZ4LiVOFMzGx27F/YXP5ZM8hj6Jw
 2fmE/OgJBWkKdwRMuQoyuR2AHDtxERDLxBnYhwWCeTNrmrW0yO0mwZc8TGJd9P99ELUEyidvz/e
 UDzLxFlDcZhtv8sW00pERMMM9cSIEE/HS8OYQOhK+Klugn3jC4Sf8rFYf1HPQs4NC/TF
X-Google-Smtp-Source: AGHT+IHG8Y6kWiCxleiNKWkfCx6o1me9jR1L4Y0IyjIyMot9uEEvxHylqCQca9pRKM4krDhiwouRIQ==
X-Received: by 2002:a17:903:41c1:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-22a95511a5cmr3974975ad.14.1743786649661; 
 Fri, 04 Apr 2025 10:10:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:49 -0700 (PDT)
Message-ID: <85685271-bfb2-4bee-827a-a2693feaae35@linaro.org>
Date: Fri, 4 Apr 2025 09:48:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 07/19] target/hppa: Replace TARGET_LONG_BITS
 -> target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICB0YXJnZXQvaHBwYS9tZW1faGVscGVyLmMgfCAzICsrLQ0KPiAgIHRh
cmdldC9ocHBhL3RyYW5zbGF0ZS5jICB8IDMgKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hwcGEvbWVtX2hlbHBlci5jIGIvdGFyZ2V0L2hwcGEvbWVtX2hlbHBlci5jDQo+IGlu
ZGV4IDU1NGQ3YmY0ZDE0Li4wM2NkMTAzZjI4NCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hw
cGEvbWVtX2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9ocHBhL21lbV9oZWxwZXIuYw0KPiBA
QCAtMTksNiArMTksNyBAQA0KPiAgIA0KPiAgICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
ICAgI2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5m
by5oIg0KPiAgICNpbmNsdWRlICJjcHUuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFs
bC5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdXRsYi5oIg0KPiBAQCAtMTAxLDcgKzEwMiw3
IEBAIHN0YXRpYyB2b2lkIGhwcGFfZmx1c2hfdGxiX2VudChDUFVIUFBBU3RhdGUgKmVudiwg
SFBQQVRMQkVudHJ5ICplbnQsDQo+ICAgDQo+ICAgICAgIHRsYl9mbHVzaF9yYW5nZV9ieV9t
bXVpZHgoY3MsIGVudC0+aXRyZWUuc3RhcnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZW50LT5pdHJlZS5sYXN0IC0gZW50LT5pdHJlZS5zdGFydCArIDEsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIUFBBX01NVV9GTFVTSF9NQVNLLCBUQVJH
RVRfTE9OR19CSVRTKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhQUEFf
TU1VX0ZMVVNIX01BU0ssIHRhcmdldF9sb25nX2JpdHMoKSk7DQo+ICAgDQo+ICAgICAgIC8q
IE5ldmVyIGNsZWFyIEJUTEJzLCB1bmxlc3MgZm9yY2VkIHRvIGRvIHNvLiAqLw0KPiAgICAg
ICBpc19idGxiID0gZW50IDwgJmVudi0+dGxiW0hQUEFfQlRMQl9FTlRSSUVTKGVudildOw0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hwcGEvdHJhbnNsYXRlLmMgYi90YXJnZXQvaHBwYS90
cmFuc2xhdGUuYw0KPiBpbmRleCAxNGYzODMzMzIyMi4uODFmNTM1NTg5Y2YgMTAwNjQ0DQo+
IC0tLSBhL3RhcmdldC9ocHBhL3RyYW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9ocHBhL3Ry
YW5zbGF0ZS5jDQo+IEBAIC0xOCw2ICsxOCw3IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2lu
Y2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLmgi
DQo+ICAgI2luY2x1ZGUgImNwdS5oIg0KPiAgICNpbmNsdWRlICJxZW11L2hvc3QtdXRpbHMu
aCINCj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiBAQCAtMzczMSw3ICszNzMy
LDcgQEAgc3RhdGljIGJvb2wgdHJhbnNfc2hycF9pbW0oRGlzYXNDb250ZXh0ICpjdHgsIGFy
Z19zaHJwX2ltbSAqYSkNCj4gICAgICAgdDIgPSBsb2FkX2dwcihjdHgsIGEtPnIyKTsNCj4g
ICAgICAgaWYgKGEtPnIxID09IDApIHsNCj4gICAgICAgICAgIHRjZ19nZW5fZXh0cmFjdF9p
NjQoZGVzdCwgdDIsIHNhLCB3aWR0aCAtIHNhKTsNCj4gLSAgICB9IGVsc2UgaWYgKHdpZHRo
ID09IFRBUkdFVF9MT05HX0JJVFMpIHsNCj4gKyAgICB9IGVsc2UgaWYgKHdpZHRoID09IHRh
cmdldF9sb25nX2JpdHMoKSkgew0KPiAgICAgICAgICAgdGNnX2dlbl9leHRyYWN0Ml9pNjQo
ZGVzdCwgdDIsIGNwdV9nclthLT5yMV0sIHNhKTsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAg
ICAgICAgIGFzc2VydCghYS0+ZCk7DQoNClRoZSB0ZW1wdGF0aW9uIGlzIGdvb2QsIGJ1dCBw
bGVhc2UgZG8gbm90IHRvdWNoIGFueSB0YXJnZXQgY29kZSBhdCB0aGlzIA0KcG9pbnQuIFdl
IHdhbnQgdG8gZm9jdXMgb24gZGVmaW5pbmcgdGhlIEFQSSBmaXJzdCwgYW5kIHdlIGNhbiBw
ZXJmb3JtIA0KY29kZWJhc2UgY2hhbmdlcyBhcyBhIHNlY29uZCBzdGVwLCB3aXRob3V0IGxl
dHRpbmcgYW55IG9jY3VycmVuY2VzIG9mIA0KdGhlIG9sZCBtYWNyb3MvZnVuY3Rpb25zLCBp
bnN0ZWFkIG9mIGp1c3QgYWRkaW5nICJhbm90aGVyIHdheSB0byBkbyBpdCIuDQo=

