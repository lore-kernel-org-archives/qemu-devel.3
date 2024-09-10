Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9F2EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so25M-000868-45; Tue, 10 Sep 2024 10:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so25K-0007kK-1W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:43:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so25I-0002XL-1X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:43:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d704704aso800289b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979390; x=1726584190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jyO6ZEBsvHTirm3n5JF1PC/HjUbNXf8pwzGy7+XrHR4=;
 b=LM+Htb73zen9hNN02c9wa0Fv/2uN9BGvNNkXhkL+7NS3jFZ9JzJqqWL2PBFtbfSup+
 pjkhl2AL+sYVA4KK++RzwZo9oNKHltO4KmP1LCqlRQrE/dvcGEC/EL1ZNEe8ZCYppQjq
 MsMymoEWuCHsOuOVh1NFdIzn7K/WwP+SbYQeIN/6w5wLdSKcipUCrC+EFRry2YmIOhJu
 vsZ0DdKdcecuEj+f+NIM8/gX+g/b6Q8QCvh0gZS9Cijv1+tNMBkX0+c2h0sEstbezwQ4
 FA+69xS2HliKweADDMRoXqi1gi4dWNIS7U5dLT15t1xq0b7ZYSD/FpgFIEeqZrgGsH8+
 ZGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979390; x=1726584190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jyO6ZEBsvHTirm3n5JF1PC/HjUbNXf8pwzGy7+XrHR4=;
 b=D/mFG4MqLbeVIy740x2pA5oVWkPek8DYGMQecUrB/mJL0gSGdKneaza0N1VnT28Grf
 xETSxiq4p8ExAVwsV1qtxPAJL5nHb4+oSRrACXRv1bER8LSJuMGbHqNxl738Tced9PXX
 dgGdW/p758hD/2oLnLQZuAmFQJ75cHPcdahHzG2RWvUuPGbnKCuYnLsViMBV/94d9Mv/
 2wAo84qs6P2N95HEcplswqPJIrKd9enGMAFgxuCZzEtHBKw002ogqmIy40V8c2IwlGyF
 x2pxTbzEhGM5/fDnaWCJSi4cqA1a+rJcJHoNTg2onMyHlgPamWSP+HjKMzlm2J/Vhwl3
 QyIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcW0A8hVyVKuXpi30lo55Pnm6WFDMTs39H+1Gr31829djxUZNEsZ0A1SzJwrACkx7ytFQa0QgsEeO@nongnu.org
X-Gm-Message-State: AOJu0Yzopu3c5UWx0BNZGr8HcqJStQ+LX9212zW7+xOrss7i8cJIyAM/
 pBqEzS1RoMBC/+d1QyyrJvG7CALJHC4qrsQETDSDHnlum82xzorFbgiK13T3Iuc=
X-Google-Smtp-Source: AGHT+IGMjU0fA05WEKFgQRHJPXzIMha2aabJrITNU/7AOQE76iOWk3Pf/eqzZTMgXnfQ4rcJRtz2QA==
X-Received: by 2002:a05:6a00:22d2:b0:714:28c7:2455 with SMTP id
 d2e1a72fcca58-718e33539abmr17294824b3a.6.1725979389825; 
 Tue, 10 Sep 2024 07:43:09 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe28cbsm1450341b3a.73.2024.09.10.07.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:43:09 -0700 (PDT)
Message-ID: <9c4aa57b-73c2-4ecb-961e-0d61031f5690@linaro.org>
Date: Tue, 10 Sep 2024 07:43:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/26] scripts/ci: update the gitlab-runner playbook
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
 <20240910140733.4007719-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgdXBzdHJlYW0g
aW5zdGFsbCBpbnN0cnVjdGlvbnM6DQo+IA0KPiAgICBodHRwczovL2RvY3MuZ2l0bGFiLmNv
bS9ydW5uZXIvaW5zdGFsbC9saW51eC1yZXBvc2l0b3J5Lmh0bWwNCj4gDQo+IE5vdyByZWZl
ciB0byByZXBvc2l0b3JpZXMgYW5kIGEgc2V0dXAgc2NyaXB0LiBNb2Rlcm5pc2UgdGhlIHBs
YXlib29rDQo+IHRvIHVzZSB0aGUgcHJlZmVycmVkIGRlbGl2ZXJ5IG1ldGhvZC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4N
Cj4gLS0tDQo+ICAgc2NyaXB0cy9jaS9zZXR1cC9naXRsYWItcnVubmVyLnltbCB8IDM5ICsr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Njcmlw
dHMvY2kvc2V0dXAvZ2l0bGFiLXJ1bm5lci55bWwgYi9zY3JpcHRzL2NpL3NldHVwL2dpdGxh
Yi1ydW5uZXIueW1sDQo+IGluZGV4IDdiZGFmYWI1MTEuLjU3ZTdmYWViZjEgMTAwNjQ0DQo+
IC0tLSBhL3NjcmlwdHMvY2kvc2V0dXAvZ2l0bGFiLXJ1bm5lci55bWwNCj4gKysrIGIvc2Ny
aXB0cy9jaS9zZXR1cC9naXRsYWItcnVubmVyLnltbA0KPiBAQCAtNDksMzAgKzQ5LDUxIEBA
DQo+ICAgICAgIC0gZGVidWc6DQo+ICAgICAgICAgICBtc2c6IGdpdGxhYi1ydW5uZXIgYXJj
aCBpcyB7eyBnaXRsYWJfcnVubmVyX2FyY2ggfX0NCj4gICANCj4gLSAgICAtIG5hbWU6IERv
d25sb2FkIHRoZSBtYXRjaGluZyBnaXRsYWItcnVubmVyIChERUIpDQo+ICsgICAgIyBEZWJp
YW4vVWJ1bnR1IHNldHVwDQo+ICsgICAgLSBuYW1lOiBHZXQgZ2l0bGFiLXJ1bm5lciByZXBv
IHNldHVwIHNjcmlwdCAoREVCKQ0KPiAgICAgICAgIGdldF91cmw6DQo+ICAgICAgICAgICBk
ZXN0OiAiL3Jvb3QvIg0KPiAtICAgICAgICB1cmw6ICJodHRwczovL2dpdGxhYi1ydW5uZXIt
ZG93bmxvYWRzLnMzLmFtYXpvbmF3cy5jb20vbGF0ZXN0L2RlYi9naXRsYWItcnVubmVyX3t7
IGdpdGxhYl9ydW5uZXJfYXJjaCB9fS5kZWIiDQo+ICsgICAgICAgIHVybDogImh0dHBzOi8v
cGFja2FnZXMuZ2l0bGFiLmNvbS9pbnN0YWxsL3JlcG9zaXRvcmllcy9ydW5uZXIvZ2l0bGFi
LXJ1bm5lci9zY3JpcHQuZGViLnNoIg0KPiArICAgICAgICBtb2RlOiAwNzU1DQo+ICAgICAg
ICAgd2hlbjoNCj4gICAgICAgICAgIC0gYW5zaWJsZV9mYWN0c1snZGlzdHJpYnV0aW9uJ10g
PT0gJ1VidW50dScNCj4gICANCj4gLSAgICAtIG5hbWU6IERvd25sb2FkIHRoZSBtYXRjaGlu
ZyBnaXRsYWItcnVubmVyIChSUE0pDQo+ICsgICAgLSBuYW1lOiBSdW4gZ2l0bGFiLXJ1bm5l
ciByZXBvIHNldHVwIHNjcmlwdCAoREVCKQ0KPiArICAgICAgc2hlbGw6ICIvcm9vdC9zY3Jp
cHQuZGViLnNoIg0KPiArICAgICAgd2hlbjoNCj4gKyAgICAgICAgLSBhbnNpYmxlX2ZhY3Rz
WydkaXN0cmlidXRpb24nXSA9PSAnVWJ1bnR1Jw0KPiArDQo+ICsgICAgLSBuYW1lOiBJbnN0
YWxsIGdpdGxhYi1ydW5uZXIgKERFQikNCj4gKyAgICAgIGFuc2libGUuYnVpbHRpbi5hcHQ6
DQo+ICsgICAgICAgICAgbmFtZTogZ2l0bGFiLXJ1bm5lcg0KPiArICAgICAgICAgIHVwZGF0
ZV9jYWNoZTogeWVzDQo+ICsgICAgICAgICAgc3RhdGU6IHByZXNlbnQNCj4gKyAgICAgIHdo
ZW46DQo+ICsgICAgICAgIC0gYW5zaWJsZV9mYWN0c1snZGlzdHJpYnV0aW9uJ10gPT0gJ1Vi
dW50dScNCj4gKw0KPiArICAgICMgUlBNIHNldHVwDQo+ICsgICAgLSBuYW1lOiBHZXQgZ2l0
bGFiLXJ1bm5lciByZXBvIHNldHVwIHNjcmlwdCAoUlBNKQ0KPiAgICAgICAgIGdldF91cmw6
DQo+ICAgICAgICAgICBkZXN0OiAiL3Jvb3QvIg0KPiAtICAgICAgICB1cmw6ICJodHRwczov
L2dpdGxhYi1ydW5uZXItZG93bmxvYWRzLnMzLmFtYXpvbmF3cy5jb20vbGF0ZXN0L3JwbS9n
aXRsYWItcnVubmVyX3t7IGdpdGxhYl9ydW5uZXJfYXJjaCB9fS5ycG0iDQo+ICsgICAgICAg
IHVybDogImh0dHBzOi8vcGFja2FnZXMuZ2l0bGFiLmNvbS9pbnN0YWxsL3JlcG9zaXRvcmll
cy9ydW5uZXIvZ2l0bGFiLXJ1bm5lci9zY3JpcHQucnBtLnNoIg0KPiArICAgICAgICBtb2Rl
OiAwNzU1DQo+ICAgICAgICAgd2hlbjoNCj4gICAgICAgICAgIC0gYW5zaWJsZV9mYWN0c1sn
ZGlzdHJpYnV0aW9uJ10gPT0gJ0NlbnRPUycNCj4gICANCj4gLSAgICAtIG5hbWU6IEluc3Rh
bGwgZ2l0bGFiLXJ1bm5lciB2aWEgcGFja2FnZSBtYW5hZ2VyIChERUIpDQo+IC0gICAgICBh
cHQ6IGRlYj0iL3Jvb3QvZ2l0bGFiLXJ1bm5lcl97eyBnaXRsYWJfcnVubmVyX2FyY2ggfX0u
ZGViIg0KPiArICAgIC0gbmFtZTogUnVuIGdpdGxhYi1ydW5uZXIgcmVwbyBzZXR1cCBzY3Jp
cHQgKFJQTSkNCj4gKyAgICAgIHNoZWxsOiAiL3Jvb3Qvc2NyaXB0LnJwbS5zaCINCj4gICAg
ICAgICB3aGVuOg0KPiAtICAgICAgICAtIGFuc2libGVfZmFjdHNbJ2Rpc3RyaWJ1dGlvbidd
ID09ICdVYnVudHUnDQo+ICsgICAgICAgIC0gYW5zaWJsZV9mYWN0c1snZGlzdHJpYnV0aW9u
J10gPT0gJ0NlbnRPUycNCj4gICANCj4gLSAgICAtIG5hbWU6IEluc3RhbGwgZ2l0bGFiLXJ1
bm5lciB2aWEgcGFja2FnZSBtYW5hZ2VyIChSUE0pDQo+IC0gICAgICB5dW06IG5hbWU9Ii9y
b290L2dpdGxhYi1ydW5uZXJfe3sgZ2l0bGFiX3J1bm5lcl9hcmNoIH19LnJwbSINCj4gKyAg
ICAtIG5hbWU6IEluc3RhbGwgZ2l0bGFiLXJ1bm5lciAoUlBNKQ0KPiArICAgICAgeXVtOg0K
PiArICAgICAgICBuYW1lOiBnaXRsYWItcnVubmVyDQo+ICsgICAgICAgIHVwZGF0ZV9jYWNo
ZTogeWVzDQo+ICsgICAgICAgIHN0YXRlOiBwcmVzZW50DQo+ICAgICAgICAgd2hlbjoNCj4g
ICAgICAgICAgIC0gYW5zaWJsZV9mYWN0c1snZGlzdHJpYnV0aW9uJ10gPT0gJ0NlbnRPUycN
Cj4gICANCj4gKyAgICAjIFJlZ2lzdGVyIFJ1bm5lcnMNCj4gICAgICAgLSBuYW1lOiBSZWdp
c3RlciB0aGUgZ2l0bGFiLXJ1bm5lcg0KPiAgICAgICAgIGNvbW1hbmQ6ICIvdXNyL2Jpbi9n
aXRsYWItcnVubmVyIHJlZ2lzdGVyIC0tbm9uLWludGVyYWN0aXZlIC0tdXJsIHt7IGdpdGxh
Yl9ydW5uZXJfc2VydmVyX3VybCB9fSAtLXJlZ2lzdHJhdGlvbi10b2tlbiB7eyBnaXRsYWJf
cnVubmVyX3JlZ2lzdHJhdGlvbl90b2tlbiB9fSAtLWV4ZWN1dG9yIHNoZWxsIC0tdGFnLWxp
c3Qge3sgYW5zaWJsZV9mYWN0c1tcImFyY2hpdGVjdHVyZVwiXSB9fSx7eyBhbnNpYmxlX2Zh
Y3RzW1wiZGlzdHJpYnV0aW9uXCJdfGxvd2VyIH19X3t7IGFuc2libGVfZmFjdHNbXCJkaXN0
cmlidXRpb25fdmVyc2lvblwiXSB9fSAtLWRlc2NyaXB0aW9uICd7eyBhbnNpYmxlX2ZhY3Rz
W1wiZGlzdHJpYnV0aW9uXCJdIH19IHt7IGFuc2libGVfZmFjdHNbXCJkaXN0cmlidXRpb25f
dmVyc2lvblwiXSB9fSB7eyBhbnNpYmxlX2ZhY3RzW1wiYXJjaGl0ZWN0dXJlXCJdIH19ICh7
eyBhbnNpYmxlX2ZhY3RzW1wib3NfZmFtaWx5XCJdIH19KSciDQo+ICAgDQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=


