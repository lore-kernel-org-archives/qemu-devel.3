Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1805C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMgC-0002WR-8B; Thu, 20 Jun 2024 14:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMg6-0002Vz-14
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:38:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMg3-0004LK-9V
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:38:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-705bf368037so1112920b3a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718908709; x=1719513509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EuG1WU31MNgaEf8xhe6HVCvciGrvE95KENN7fkoaxXI=;
 b=aKrwKx8NU8SdCUrauGGb8kX7YpmPhvKoFn8Z9YvXpD/nQa6t9B62/VE/E9Ya6wJi0A
 tHh+2TZH0JN9fm0lNrHyrmgdTUJE4j6lpxLciNLBjbdtZBCiXdmhkIMWNMAjKOOnNchm
 ySO3CCEzjGU9qCHaL05km/3tfEWbvcZ/e5tCqfC/rtmeP0TCmi8kyPxp+Lm9bohl/XCA
 VmM3ieCA0ERXFw7Y/+0SR/Rn8clhz8MxCsAr4mCBCkSd6oiXWdgvgLrFetgD1+VRUy7x
 OHu7smvcNqgqE/zq6pB8NAPhZUsDD/i4QOxsGvYxAoYFwdH5wQePb8PeqCElDAwinAbE
 c+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908709; x=1719513509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EuG1WU31MNgaEf8xhe6HVCvciGrvE95KENN7fkoaxXI=;
 b=gR2lTKv4meB4tSNHfMrSDPP5JRlFLkTCAl4pdeP0dLH2MHkYRoAlSlsOvYhHMmJLX3
 8MRPPID/+Qi9EQYSM6T2cLyyEsf+Kaogut/oFM7zInLJxzTWKJpO6nzdg9ez5ewkOrk0
 A0Phrk9cB8a37FMfF/PpNVSv/nDLNedKfQIfV47FzuNVZsEszDo6p9T7W4yBxxqzbsNy
 fp2WDStRyVVImysUuNR/Gi4JFpMqKx94yWPJLcJeFlzyEjPzDQuEjAGO12WhwBrA9OU1
 oErV1o8s+ryO8IaXsqUcsumQjxy8RsRdq1v0nurtz850YtpLW6LNptKcsYwpkvhRMjpQ
 lBFw==
X-Gm-Message-State: AOJu0YyO2r/v7tKHjltw0WtdOTb7Hek2KyAiqBJGSflogMR6eiu8VIEh
 vZtjkKkym82ox5Mi4IdfE5MZ5iok94kq9P1h9MQy4LKb8FWy4y4+lMsnaiA1zoE=
X-Google-Smtp-Source: AGHT+IHY/Zsd87xB2Kr3uAhsYuL6FbtYzc3T7FWz6EWWQmBAeOg5IOXm5jaOQ7Mm4x7QkAL78mySag==
X-Received: by 2002:a62:5e45:0:b0:705:fe85:3672 with SMTP id
 d2e1a72fcca58-70629cce6c0mr6333177b3a.27.1718908708670; 
 Thu, 20 Jun 2024 11:38:28 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc91f6a4sm13120902b3a.13.2024.06.20.11.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:38:28 -0700 (PDT)
Message-ID: <e2ff8e08-4903-4259-b858-447e2001134a@linaro.org>
Date: Thu, 20 Jun 2024 11:38:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins/execlog.c: correct dump of registers values
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, alex.bennee@linaro.org,
 erdnaxe@crans.org, ma.mandourr@gmail.com
Cc: qemu-devel@nongnu.org
References: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

T24gNi8yMC8yNCAwMTozOCwgRnLDqWTDqXJpYyBQw6l0cm90IHdyb3RlOg0KPiBSZWdpc3Rl
ciB2YWx1ZXMgYXJlIGR1bXBlZCBhcyAnc3onIGNodW5rcyBvZiB0d28gbmliYmxlcyBpbiB0
aGUgZXhlY2xvZw0KPiBwbHVnaW4sIHN6IHdhcyAxIHRvbyBiaWcuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBGcsOpZMOpcmljIFDDqXRyb3QgPGZyZWRlcmljLnBldHJvdEB1bml2LWdyZW5v
YmxlLWFscGVzLmZyPg0KPiAtLS0NCj4gICBjb250cmliL3BsdWdpbnMvZXhlY2xvZy5jIHwg
MiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMgYi9jb250
cmliL3BsdWdpbnMvZXhlY2xvZy5jDQo+IGluZGV4IDM3MWRiOTdlYjEuLjFjMTYwMWNjMGIg
MTAwNjQ0DQo+IC0tLSBhL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4gKysrIGIvY29u
dHJpYi9wbHVnaW5zL2V4ZWNsb2cuYw0KPiBAQCAtMTAxLDcgKzEwMSw3IEBAIHN0YXRpYyB2
b2lkIGluc25fY2hlY2tfcmVncyhDUFUgKmNwdSkNCj4gICAgICAgICAgICAgICBHQnl0ZUFy
cmF5ICp0ZW1wID0gcmVnLT5sYXN0Ow0KPiAgICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZF9wcmludGYoY3B1LT5sYXN0X2V4ZWMsICIsICVzIC0+IDB4IiwgcmVnLT5uYW1lKTsNCj4g
ICAgICAgICAgICAgICAvKiBUT0RPOiBoYW5kbGUgQkUgcHJvcGVybHkgKi8NCj4gLSAgICAg
ICAgICAgIGZvciAoaW50IGkgPSBzejsgaSA+PSAwOyBpLS0pIHsNCj4gKyAgICAgICAgICAg
IGZvciAoaW50IGkgPSBzeiAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ICAgICAgICAgICAgICAg
ICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYoY3B1LT5sYXN0X2V4ZWMsICIlMDJ4IiwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWctPm5ldy0+ZGF0
YVtpXSk7DQo+ICAgICAgICAgICAgICAgfQ0KDQpHb29kIGNhdGNoLCB0aGFua3MhDQpSZXZp
ZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0KDQpQaWVycmljaw0K

