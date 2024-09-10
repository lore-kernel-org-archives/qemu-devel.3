Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5CCEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so24n-0004ZA-1Y; Tue, 10 Sep 2024 10:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so24l-0004SR-BF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:42:39 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so24h-0002Vl-6z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:42:38 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-277efdcfa63so3208824fac.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979353; x=1726584153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wWRtKX4Fc0XZZzY4iDmqemDW+Sl8iS5dOb2n/7LmYl4=;
 b=IYkQLk28CMS++PZbXhbhesrDGymboMJrS5KgOmnTFL8kzvt8SnIJ/ysjrslq3P5608
 dGmCuTCRzxZt6M1+pTp/e+cTSdxLJ4VD3SQMe1MUKOSJNbRThEIWNlET4cjHaPqjtrrV
 sqOCB6VQaeHSQ6R1xhc2ORnVy1b6LEHadm12hpZyD2k2pSVxQV532khg+ydXgvRsktiy
 PWGKr+Y+RVvNyhTno/fErc0DIgZwCVUmjRdW+4dTLK9t2zTfuVekoWNGZ6hrY47Dl6nn
 7fJs+BIZQppF353EBfo200pBGdVCVNlVRQBxs8JWnmbDLmaZ80JgeTBH8oSAOHyrm+ge
 ocbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979353; x=1726584153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wWRtKX4Fc0XZZzY4iDmqemDW+Sl8iS5dOb2n/7LmYl4=;
 b=oAXmu8l3k9xbPoUxuA317SSEPr27PR7DRAN6YHinHqUBZKNITy12HOyVSW/os27ulI
 1ANR3qCnQU5ve6LALGxaVymad8Ztzaa0KXkZB35n21stKyZA74jd+gwllsk+8+TLWfef
 4PLk/eZQOaYr/6OhgMmYXwK9I1RT5ee8HuskpUkmZu2Y+Nd6OnaEyQTlfwzhwwO4doHy
 Mjyl3QMD/3wN6lLRT4q4rPhy2ZYEptBIFwbg8IM27IhiwdAh+8jf4I9uNg8CR/OD6rGt
 8T3bNoFY17JSK8+uPMuXMlGg0uA5dXJZakjp7DKdioJ4wgmKJdUVIUHLj/9T+1LqyZo5
 f9Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHE57Xz5g91DOQd6As4aW03fx7mquGU1nyrEVho9c8L2ZCuQc2+L6ymvKAZE2MtwhN2QAOp6N+wQfA@nongnu.org
X-Gm-Message-State: AOJu0YzfITXQSdxE9CmQ6fSflSPTaX1mwG5Ygd57CfUU1nbDn+JMJsyh
 ZK+iMv+vGahF/SXMPPo52M/oizUwVXcZA6gznewJG8zUqL0RERaa20Wn0wlR7wI=
X-Google-Smtp-Source: AGHT+IFgTFdjpuoaiHApP15tub66oG6PB2tqjYWZWOukXIgPdDeqbAzUOEO9JnKqI4DvWblh11Vb6g==
X-Received: by 2002:a05:6870:e414:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-27b82b69ab8mr16155913fac.0.1725979353435; 
 Tue, 10 Sep 2024 07:42:33 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d823736318sm4821228a12.12.2024.09.10.07.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:42:32 -0700 (PDT)
Message-ID: <a4908f0b-1c59-447e-b63f-03fd8265607f@linaro.org>
Date: Tue, 10 Sep 2024 07:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] docs/devel: fix duplicate line
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
 <20240910140733.4007719-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x2c.google.com
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBJIGd1ZXNzIHRoZSBz
YW1lIGNoYW5nZSBjYW1lIGluIHZpYSB0d28gcGF0Y2ggc2VyaWVzLiBSZW1vdmUgdGhlDQo+
IHJlcGV0aXRpb24uDQo+IA0KPiBGaXhlczogMmE4NTFmY2E5ZiAoZG9jcy9kZXZlbDogcmVt
aW5kIGRldmVsb3BlcnMgdG8gcnVuIENJIGNvbnRhaW5lciBwaXBlbGluZSB3aGVuIHVwZGF0
aW5nIGltYWdlcykNCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBkb2NzL2RldmVsL3Rlc3RpbmcvbWFpbi5yc3Qg
fCA2IC0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RvY3MvZGV2ZWwvdGVzdGluZy9tYWluLnJzdCBiL2RvY3MvZGV2ZWwv
dGVzdGluZy9tYWluLnJzdA0KPiBpbmRleCBlOTkyMWE0YjEwLi4wOTcyNWU4ZWE5IDEwMDY0
NA0KPiAtLS0gYS9kb2NzL2RldmVsL3Rlc3RpbmcvbWFpbi5yc3QNCj4gKysrIGIvZG9jcy9k
ZXZlbC90ZXN0aW5nL21haW4ucnN0DQo+IEBAIC01MDAsMTIgKzUwMCw2IEBAIGZpcnN0IHRv
IGNvbnRyaWJ1dGUgdGhlIG1hcHBpbmcgdG8gdGhlIGBgbGlidmlydC1jaWBgIHByb2plY3Q6
DQo+ICAgICAgYENJIDxodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9j
aS5odG1sPmBfXyBkb2N1bWVudGF0aW9uDQo+ICAgICAgcGFnZSBvbiBob3cgdG8gdHJpZ2dl
ciBnaXRsYWIgQ0kgcGlwZWxpbmVzIG9uIHlvdXIgY2hhbmdlLg0KPiAgIA0KPiAtICogUGxl
YXNlIGFsc28gdHJpZ2dlciBnaXRsYWIgY29udGFpbmVyIGdlbmVyYXRpb24gcGlwZWxpbmVz
IG9uIHlvdXIgY2hhbmdlDQo+IC0gICBmb3IgYXMgbWFueSBPUyBkaXN0cm9zIGFzIHByYWN0
aWNhbCB0byBtYWtlIHN1cmUgdGhhdCB0aGVyZSBhcmUgbm8NCj4gLSAgIG9idmlvdXMgYnJl
YWthZ2VzIHdoZW4gYWRkaW5nIHRoZSBuZXcgcHJlLXJlcXVpc2l0ZS4gUGxlYXNlIHNlZQ0K
PiAtICAgYENJIDxodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9jaS5o
dG1sPmBfXyBkb2N1bWVudGF0aW9uDQo+IC0gICBwYWdlIG9uIGhvdyB0byB0cmlnZ2VyIGdp
dGxhYiBDSSBwaXBlbGluZXMgb24geW91ciBjaGFuZ2UuDQo+IC0NCj4gICBGb3IgZW50ZXJw
cmlzZSBkaXN0cm9zIHRoYXQgZGVmYXVsdCB0byBvbGQsIGVuZC1vZi1saWZlIHZlcnNpb25z
IG9mIHRoZQ0KPiAgIFB5dGhvbiBydW50aW1lLCBRRU1VIHVzZXMgYSBzZXBhcmF0ZSBzZXQg
b2YgbWFwcGluZ3MgdGhhdCB3b3JrIHdpdGggbW9yZQ0KPiAgIHJlY2VudCB2ZXJzaW9ucy4g
IFRoZXNlIGNhbiBiZSBmb3VuZCBpbiBgYHRlc3RzL2xjaXRvb2wvbWFwcGluZ3MueW1sYGAu
DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxp
bmFyby5vcmc+DQo=

