Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC4CFA465
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hl7-0003L5-26; Wed, 23 Oct 2024 16:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3hl5-0003K5-Ux
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:15:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3hl4-0006N4-38
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:15:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso149620b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729714502; x=1730319302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ej05N5mayzncWU1FzQqx3UhQ3ibWGyoYkK0x8xCYTBU=;
 b=wKh/Xr2N2CZr1q0ocLsIn5uwiUsS2nyHCx1XbrZiJOlqnHPkVYVBtbEAxr7rXjJu0L
 PPHuTYz4HZSw6an9SKfGspoD9kvNHYvcEOoSwhC4SbE3Ba31dAH1tCxqE4Ke5mwMQ+/f
 /Lvm1GV3DyDIkRUvz02Bsd+sw0P1K+s9C2N/Hi9Fb4LyD4v/6Wv58e4uuOxilzELGAuH
 0wvPwninggbYEkQ+pwFRLYHlf2tDcc76RQeyDhZcIUhAVRcVrh5l/KMhfezNT/ss+lAJ
 FAj5izdjN8QLCO0KF/pFIxB9yM5+zv/ffp7s5Cv0Ih7FTPbwiO59UOdDbNjjaqh42tDk
 qTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729714502; x=1730319302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ej05N5mayzncWU1FzQqx3UhQ3ibWGyoYkK0x8xCYTBU=;
 b=XkZhusEBzV66Cv7gEh5qzkig8xMBIwGn7pD5BUt+IK970xkoQMZ1PGqPo4lV27+g1o
 sEUyf+hA/L8qe3VdcKq37MtLfghhnHSNSBox3HjwCMF95vRoJCN9UXTN9DLxwtBNsajo
 GqSEO+ExZKPARAeZrH6bOUAB/Njj+IJt51q0ynuR8M/2Wxa4+eyC6ycfavfqWzXx0Fei
 CqWSYgvmd72OV/MH2MPp4x1v69guxUbxW6Mvo1Gzlhu6TFkzS+Nzus48VYJEbKWixmSw
 T3vLTw7H9/DqPAxn3EdQe0eS9hvDnGGB3ml/AAM9qmeBMnXV3ssWB6nycd7/Q/1422Jf
 kuuA==
X-Gm-Message-State: AOJu0YxH0BO3FAPXzHpaKJMkhWWiUErzgAulmcASOLP7RRrY+y3q80gL
 imvZ9rUvFCFD/P6at2VHEtPLxG/ay2bOU3Fqq98mPZRnzKcc7vSVFeknwVNVPlk=
X-Google-Smtp-Source: AGHT+IFFdqhwzd1FgJ4xRrGg2oNlGn++0Cz8OR8KWuZc9NTgAm+fwTi1E6PhbHfSy86rOxku0GC2pg==
X-Received: by 2002:a05:6a21:3a94:b0:1d9:6c9c:75ea with SMTP id
 adf61e73a8af0-1d978aeac14mr4548525637.5.1729714502430; 
 Wed, 23 Oct 2024 13:15:02 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13128c2sm6767913b3a.33.2024.10.23.13.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 13:15:01 -0700 (PDT)
Message-ID: <0ec19690-760a-4726-baa9-6073c193dc3c@linaro.org>
Date: Wed, 23 Oct 2024 13:15:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-win32: fix format-truncation warning
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241023183009.1041419-1-pierrick.bouvier@linaro.org>
 <875xpilhu6.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <875xpilhu6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

T24gMTAvMjMvMjQgMTI6NTAsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gU2lt
cGx5IGluY3JlYXNlIGRlc3RpbmF0aW9uIGJ1ZmZlciBzaXplIHNvIHRydW5jYXRpb24gY2Fu
J3QgaGFwcGVuLg0KPj4NCj4+ICJjYyIgIi1tNjQiICItSWxpYmNvbW1vbi5hLnAiICItSXN1
YnByb2plY3RzL2R0Yy9saWJmZHQiDQo+PiAiLUkuLi9zdWJwcm9qZWN0cy9kdGMvbGliZmR0
Ig0KPj4gIi1JRDovYS9fdGVtcC9tc3lzNjQvbWluZ3c2NC9pbmNsdWRlL3BpeG1hbi0xIg0K
Pj4gIi1JRDovYS9fdGVtcC9tc3lzNjQvbWluZ3c2NC9pbmNsdWRlL2dsaWItMi4wIg0KPj4g
Ii1JRDovYS9fdGVtcC9tc3lzNjQvbWluZ3c2NC9saWIvZ2xpYi0yLjAvaW5jbHVkZSINCj4+
ICItSUQ6L2EvX3RlbXAvbXN5czY0L21pbmd3NjQvaW5jbHVkZS9uY3Vyc2VzdyINCj4+ICIt
ZmRpYWdub3N0aWNzLWNvbG9yPWF1dG8iICItV2FsbCIgIi1XaW52YWxpZC1wY2giICItV2Vy
cm9yIg0KPj4gIi1zdGQ9Z251MTEiICItTzIiICItZyIgIi1mc3RhY2stcHJvdGVjdG9yLXN0
cm9uZyIgIi1XZW1wdHktYm9keSINCj4+ICItV2VuZGlmLWxhYmVscyIgIi1XZXhwYW5zaW9u
LXRvLWRlZmluZWQiICItV2Zvcm1hdC1zZWN1cml0eSINCj4+ICItV2Zvcm1hdC15MmsiICIt
V2lnbm9yZWQtcXVhbGlmaWVycyIgIi1XaW1wbGljaXQtZmFsbHRocm91Z2g9MiINCj4+ICIt
V2luaXQtc2VsZiIgIi1XbWlzc2luZy1mb3JtYXQtYXR0cmlidXRlIiAiLVdtaXNzaW5nLXBy
b3RvdHlwZXMiDQo+PiAiLVduZXN0ZWQtZXh0ZXJucyIgIi1Xb2xkLXN0eWxlLWRlY2xhcmF0
aW9uIiAiLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiINCj4+ICItV3JlZHVuZGFudC1kZWNscyIg
Ii1Xc2hhZG93PWxvY2FsIiAiLVdzdHJpY3QtcHJvdG90eXBlcyINCj4+ICItV3R5cGUtbGlt
aXRzIiAiLVd1bmRlZiIgIi1XdmxhIiAiLVd3cml0ZS1zdHJpbmdzIg0KPj4gIi1Xbm8tbWlz
c2luZy1pbmNsdWRlLWRpcnMiICItV25vLXBzYWJpIiAiLVduby1zaGlmdC1uZWdhdGl2ZS12
YWx1ZSINCj4+ICItaXF1b3RlIiAiLiIgIi1pcXVvdGUiICJEOi9hL3FlbXUvcWVtdSIgIi1p
cXVvdGUiDQo+PiAiRDovYS9xZW11L3FlbXUvaW5jbHVkZSIgIi1pcXVvdGUiDQo+PiAiRDov
YS9xZW11L3FlbXUvaG9zdC9pbmNsdWRlL3g4Nl82NCIgIi1pcXVvdGUiDQo+PiAiRDovYS9x
ZW11L3FlbXUvaG9zdC9pbmNsdWRlL2dlbmVyaWMiICItaXENCj4+IC4uL25ldC90YXAtd2lu
MzIuYzogSW4gZnVuY3Rpb24gJ3RhcF93aW4zMl9vcGVuJzoNCj4+IC4uL25ldC90YXAtd2lu
MzIuYzozNDM6MTk6IGVycm9yOiAnJXMnIGRpcmVjdGl2ZSBvdXRwdXQgbWF5IGJlIHRydW5j
YXRlZCB3cml0aW5nIHVwIHRvIDI1NSBieXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNpemUgMTc2
IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCj4+ICAgIDM0MyB8ICAgICAgICAgICAg
ICAiJXNcXCVzXFxDb25uZWN0aW9uIiwNCj4+ICAgICAgICB8ICAgICAgICAgICAgICAgICAg
IF5+DQo+PiAgICAzNDQgfCAgICAgICAgICAgICAgTkVUV09SS19DT05ORUNUSU9OU19LRVks
IGVudW1fbmFtZSk7DQo+PiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5+fn5+fn5+fg0KPj4gSW4gZnVuY3Rpb24gJ2dldF9kZXZpY2VfZ3VpZCcs
DQo+PiAgICAgIGlubGluZWQgZnJvbSAndGFwX3dpbjMyX29wZW4nIGF0IC4uL25ldC90YXAt
d2luMzIuYzo2MTY6MTA6DQo+PiAuLi9uZXQvdGFwLXdpbjMyLmM6MzQxOjk6IG5vdGU6ICdz
bnByaW50Zicgb3V0cHV0IGJldHdlZW4gOTIgYW5kIDM0Nw0KPj4gYnl0ZXMgaW50byBhIGRl
c3RpbmF0aW9uIG9mIHNpemUgMjU2DQo+IA0KPiBJcyB0aGUgY29tcGlsZXIgbWluL21heCBt
YXhpbmcgd2hhdCBVQ1MtMTYgb3IgVVRGLTggbWlnaHQgcGFjayBpbnRvIHRoYXQgc3RyaW5n
Pw0KPj4NCg0KWWVzLCBlbnVtX25hbWUgKHVzZWQgdG8gY29tcG9zZSBmaW5hbCBzdHJpbmcp
IGlzIGFscmVhZHkgc2l6ZWQgMjU2LCBzbyANCnJlc3VsdCAqbWF5KiBiZSBiaWdnZXIuIEkn
bSBub3Qgc3VyZSBpdCB3b3VsZCBoYXBwZW4gaW4gdGhlIHJlYWwgd29ybGQgDQp0aG91Z2gu
DQoNClRoZSByZXN1bHQgc3RyaW5ncyBhcmUgdXNlZCB0byBhY2Nlc3MgcmVnaXN0cnkga2V5
cywgd2hpY2ggaGF2ZSBhIG1heCANCnNpemUgb2YgMjU1LiBBbmQgZGV2aWNlX3BhdGggaXMg
dXNlZCB0byBvcGVuIGEgZmlsZSwgd2hpY2ggaXMgbGltaXRlZCBpbiANCnNpemUgdG9vLg0K
aHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3Mvd2luMzIvc3lzaW5m
by9yZWdpc3RyeS1lbGVtZW50LXNpemUtbGltaXRzDQoNCj4+IFNpZ25lZC1vZmYtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0K
Pj4gICBuZXQvdGFwLXdpbjMyLmMgfCA2ICsrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9u
ZXQvdGFwLXdpbjMyLmMgYi9uZXQvdGFwLXdpbjMyLmMNCj4+IGluZGV4IDdlZGJkNzE2MzM3
Li40YTQ2MjVhZjJiMiAxMDA2NDQNCj4+IC0tLSBhL25ldC90YXAtd2luMzIuYw0KPj4gKysr
IGIvbmV0L3RhcC13aW4zMi5jDQo+PiBAQCAtMjE0LDcgKzIxNCw3IEBAIHN0YXRpYyBpbnQg
aXNfdGFwX3dpbjMyX2Rldihjb25zdCBjaGFyICpndWlkKQ0KPj4gICANCj4+ICAgICAgIGZv
ciAoOzspIHsNCj4+ICAgICAgICAgICBjaGFyIGVudW1fbmFtZVsyNTZdOw0KPj4gLSAgICAg
ICAgY2hhciB1bml0X3N0cmluZ1syNTZdOw0KPj4gKyAgICAgICAgY2hhciB1bml0X3N0cmlu
Z1s1MTJdOw0KPiANCj4gSWYgdGhpcyBpc24ndCBwZXJmIHNlbnNpdGl2ZSBjb2RlIGxldHMg
anVzdCBnZXQgcmlkIG9mIHRoaXMgc3RhY2sNCj4gYWxsb2NhdGlvbiBhbmQgYmUgZG9uZSB3
aXRoIHNvbWUgYXV0b2ZyZWUnZCBnX3N0cmR1cF9wcmludGZzPw0KPiANCg0KWWVzLCB3aWxs
IGRvIHRoYXQuDQpBbGwgdGhpcyBpcyB1c2VkIG9ubHkgd2hlbiBvcGVuaW5nIHRoZSBkZXZp
Y2UsIHNvIGl0J3Mgbm90IG9uIGFueSBob3QgcGF0aC4NCg0KVGhhbmtzLA0KUGllcnJpY2sN
Cg==

