Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B1C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1Ar-0001Gw-GC; Fri, 16 Aug 2024 13:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf1Ap-000167-Rt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:55:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf1An-00056Q-Oi
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:55:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so1670774b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723830936; x=1724435736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WEoEClJCWjSoHlO/IWlAnDaNlAe95rm1D4So+ODZ0uk=;
 b=GxxJc7jgaA/iy1vWFfKv/uIUuRjJ+bjJ2Gu6jPRYoJSoEM5J22JU2Lx565P09PllHw
 epI7vF2FdjnegrHhGFeiAFAbfu49+mz6mWaAozWjJ76J8WiWNhDlxaHucSYI18OVW2uX
 hwsGT8B52mYtDaCQCNa2HprZhp5Dhn0VNrYjcUYvq5vdhT1sevVP3OnxFjAfVTjKg20M
 q9Vht0WQnkaL9EmGQps9R5aPhu7DL071cQDuJ57N4HlzJpYf//nEXlaH1lBDoktq5fNz
 duNpvVZslkBt2/2FiLKckhPFVQw7ErMKvZnRhJdTXZ/hsXV69PKc+eBq1zBLCFQHdyZq
 FqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723830936; x=1724435736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEoEClJCWjSoHlO/IWlAnDaNlAe95rm1D4So+ODZ0uk=;
 b=IIT673i+xGipwBHWKmsGwJxBU6xM5MzSyrzXv2HWlyYGIPSnWSe76jUyQeoA5LwDFT
 IEpS/3wz0nquhWR2yEWVGksMI3ESn4fUOBuRA8YkfoqziTiFiH9aBbvtuaLPJnut4IZ1
 QJj6iSKCLRmaRQWMCiGStiHZstbqKslK9AlkJLV+LWA8oXxIBaP5TqjjxTRnmnXbqSBQ
 GPH9JJPw7BCvxXdf6uY7OfGyPAW3hOYvipcyoNF06WPlIbWZXCrFApS/8mfcObZLaWxu
 gT2dDzh1A3zVlrcQjB31AGQmywcymNCFdZROTvAb9PkA3teZWlm50cFmrsFJMPBvDC0W
 HPhw==
X-Gm-Message-State: AOJu0YwhNRgcfgXIU2jEMvx9BnB+UCIVE3c6eUJglMxl0Mb84NNqeqGD
 fjNut+DGrtEhwDvzZiy6+4XeUGaaZQhsaP5B1MwgG8X4DKgBxjvb/q3xRbNM03o=
X-Google-Smtp-Source: AGHT+IFOLdEszxSC8+3SkeB6DXjmNsuyIqVS0HIMHv5OlFQGsdmfYbrW2tQqve20fsKhJNg+1SvQvw==
X-Received: by 2002:a05:6a20:d493:b0:1c4:81ab:1f5e with SMTP id
 adf61e73a8af0-1c90503036amr4562718637.38.1723830936042; 
 Fri, 16 Aug 2024 10:55:36 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add68a3sm2883507b3a.7.2024.08.16.10.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 10:55:35 -0700 (PDT)
Message-ID: <55eaeca5-dc4d-4b7a-986a-d49403460dda@linaro.org>
Date: Fri, 16 Aug 2024 10:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/5] target/s390x: fix build warning (gcc-12
 -fsanitize=thread)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240816072218.27125-1-thuth@redhat.com>
 <20240816072218.27125-2-thuth@redhat.com>
 <ddad1d38-2f4d-41b8-a7b5-69bec00ebe02@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ddad1d38-2f4d-41b8-a7b5-69bec00ebe02@linaro.org>
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

T24gOC8xNi8yNCAwMDo0NSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE2LzgvMjQgMDk6MjIsIFRob21hcyBIdXRoIHdyb3RlOg0KPj4gRnJvbTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4NCj4+IEZvdW5kIG9u
IGRlYmlhbiBzdGFibGUuDQo+Pg0KPj4gLi4vdGFyZ2V0L3MzOTB4L3RjZy90cmFuc2xhdGUu
YzogSW4gZnVuY3Rpb24g4oCYZ2V0X21lbV9pbmRleOKAmToNCj4+IC4uL3RhcmdldC9zMzkw
eC90Y2cvdHJhbnNsYXRlLmM6Mzk4OjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9m
IG5vbi12b2lkIGZ1bmN0aW9uIFstV2Vycm9yPXJldHVybi10eXBlXQ0KPj4gICAgIDM5OCB8
IH0NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQo+PiBBY2tlZC1ieTogSWx5YSBMZW9zaGtldmljaCA8aWlp
QGxpbnV4LmlibS5jb20+DQo+PiBNZXNzYWdlLUlEOiA8MjAyNDA4MTQyMjQxMzIuODk3MDk4
LTQtcGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogVGhv
bWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgIHRhcmdldC9zMzkw
eC90Y2cvdHJhbnNsYXRlLmMgfCAxIC0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9zMzkweC90Y2cvdHJhbnNsYXRl
LmMgYi90YXJnZXQvczM5MHgvdGNnL3RyYW5zbGF0ZS5jDQo+PiBpbmRleCBjODFlMDM1ZGVh
Li5iY2ZmZjQwYjI1IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3MzOTB4L3RjZy90cmFuc2xh
dGUuYw0KPj4gKysrIGIvdGFyZ2V0L3MzOTB4L3RjZy90cmFuc2xhdGUuYw0KPj4gQEAgLTM5
Miw3ICszOTIsNiBAQCBzdGF0aWMgaW50IGdldF9tZW1faW5kZXgoRGlzYXNDb250ZXh0ICpz
KQ0KPj4gICAgICAgICAgICByZXR1cm4gTU1VX0hPTUVfSURYOw0KPj4gICAgICAgIGRlZmF1
bHQ6DQo+PiAgICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+PiAtICAgICAg
ICBicmVhazsNCj4gDQo+IFdoeSBhcmVuJ3QgdGhlIG90aGVyIGNhc2VzIHByb2JsZW1hdGlj
Pw0KPiANCj4gJCBnaXQgZ3JlcCAtQTEgZ19hc3NlcnRfbm90X3JlYWNoZWQgfCBmZ3JlcCAt
QjEgYnJlYWsNCj4gYWNjZWwvdGNnL3BsdWdpbi1nZW4uYzoyNTM6ICAgICAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOw0KPiBhY2NlbC90Y2cvcGx1Z2luLWdlbi5jLTI1NC0gICAgICAg
IGJyZWFrOw0KPiAtLQ0KPiBibG9jay9zc2guYzo0NzY6ICAgICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOw0KPiBibG9jay9zc2guYy00NzctICAgICAgICBicmVhazsNCj4gLS0NCj4g
ZnB1L3NvZnRmbG9hdC1wYXJ0cy5jLmluYzoxMzc1OiAgICAgICAgICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7DQo+IGZwdS9zb2Z0ZmxvYXQtcGFydHMuYy5pbmMtMTM3Ni0gICAgICAg
ICAgICBicmVhazsNCj4gLS0NCj4gZnB1L3NvZnRmbG9hdC1wYXJ0cy5jLmluYzoxMzg4OiAg
ICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+IGZwdS9zb2Z0ZmxvYXQtcGFy
dHMuYy5pbmMtMTM4OS0gICAgICAgICAgICBicmVhazsNCj4gLS0NCj4gaHcvZ3Bpby9ucmY1
MV9ncGlvLmM6NDI6ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiBody9ncGlv
L25yZjUxX2dwaW8uYy00My0gICAgICAgIGJyZWFrOw0KPiAtLQ0KPiBody9taXNjL2lteDZf
Y2NtLmM6MzAzOiAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gaHcvbWlzYy9p
bXg2X2NjbS5jLTMwNC0gICAgICAgIGJyZWFrOw0KPiAtLQ0KPiBody9taXNjL21hY192aWEu
Yzo0OTc6ICAgICAgICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+IGh3L21p
c2MvbWFjX3ZpYS5jLTQ5OC0gICAgICAgICAgICAgICAgYnJlYWs7DQo+IC0tDQo+IGh3L21p
c2MvbWFjX3ZpYS5jOjU1ODogICAgICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0K
PiBody9taXNjL21hY192aWEuYy01NTktICAgICAgICAgICAgYnJlYWs7DQo+IC0tDQo+IGh3
L3BjaS1ob3N0L2d0NjQxMjAuYzo2OTE6ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
Ow0KPiBody9wY2ktaG9zdC9ndDY0MTIwLmMtNjkyLSAgICAgICAgYnJlYWs7DQo+IC0tDQo+
IGh3L3BjaS1ob3N0L2d0NjQxMjAuYzo5MzU6ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpOw0KPiBody9wY2ktaG9zdC9ndDY0MTIwLmMtOTM2LSAgICAgICAgYnJlYWs7DQo+IC0t
DQo+IGh3L3Njc2kvdmlydGlvLXNjc2kuYzozNTk6ICAgICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOw0KPiBody9zY3NpL3ZpcnRpby1zY3NpLmMtMzYwLSAgICAgICAgYnJlYWs7DQo+
IC0tDQo+IGh3L3RwbS90cG1fc3BhcHIuYzoyMDg6ICAgICAgICAgICAgICAgIGdfYXNzZXJ0
X25vdF9yZWFjaGVkKCk7DQo+IGh3L3RwbS90cG1fc3BhcHIuYy0yMDktICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAtLQ0KPiB0YXJnZXQvYXJtL2h5cF9nZGJzdHViLmM6MTYwOiAgICAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gdGFyZ2V0L2FybS9oeXBfZ2Ric3R1Yi5j
LTE2MS0gICAgICAgIGJyZWFrOw0KPiAtLQ0KPiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc19ydnYuYy5pbmM6MzE3NDogICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+
IHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYy0zMTc1LSAgICAgICAg
YnJlYWs7DQo+IC0tDQo+IHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmlu
YzozMjU5OiAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gdGFyZ2V0L3Jpc2N2
L2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jLTMyNjAtICAgICAgICBicmVhazsNCj4gLS0N
Cj4gdGFyZ2V0L3Jpc2N2L21vbml0b3IuYzoxODY6ICAgICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOw0KPiB0YXJnZXQvcmlzY3YvbW9uaXRvci5jLTE4Ny0gICAgICAgIGJyZWFrOw0K
PiAtLQ0KPiB0YXJnZXQvczM5MHgvdGNnL3RyYW5zbGF0ZS5jOjM5NDogICAgICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7DQo+IHRhcmdldC9zMzkweC90Y2cvdHJhbnNsYXRlLmMtMzk1
LSAgICAgICAgYnJlYWs7DQo+IC0tDQo+IHRjZy9sb29uZ2FyY2g2NC90Y2ctdGFyZ2V0LmMu
aW5jOjY1MjogICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+IHRjZy9sb29uZ2Fy
Y2g2NC90Y2ctdGFyZ2V0LmMuaW5jLTY1My0gICAgICAgIGJyZWFrOw0KPiAtLQ0KPiB0ZXN0
cy9xdGVzdC9taWdyYXRpb24taGVscGVycy5jOjc4OiAgICAgICAgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKTsNCj4gdGVzdHMvcXRlc3QvbWlncmF0aW9uLWhlbHBlcnMuYy03OS0gICAgICAg
IGJyZWFrOw0KPiAtLQ0KPiB1aS9xZW11LXBpeG1hbi5jOjUxOiAgICAgICAgZ19hc3NlcnRf
bm90X3JlYWNoZWQoKTsNCj4gdWkvcWVtdS1waXhtYW4uYy01Mi0gICAgICAgIGJyZWFrOw0K
PiANCg0KSSdsbCB0YWtlIGEgbG9vayBhdCBjb25zdHJ1Y3Rpb25zIHdoZXJlIGNvZGUgaXMg
cHJlc2VudCBhZnRlciANCmdfYXNzZXJ0X25vdF9yZWFjaGVkKCkgYW5kIG1ha2UgYSBzZXJp
ZXMgb3V0IG9mIGl0IHRvIGNsZWFuIHRoaXMuDQo=

