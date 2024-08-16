Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1781C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf19s-0007WW-GZ; Fri, 16 Aug 2024 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf19p-0007Uv-CV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:54:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf19n-0004rs-H8
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:54:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so1855246b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723830873; x=1724435673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vKkLRfLwd+3pXpbvNbngAZ+9T9Lz9kOCjy+cNgYYdAY=;
 b=BeSm+WLHSXQynzPTDS+/TWDOWpaAUJYY58kccIy+F8NTBiwoVH/Kd3xfWUBedEULwa
 sdK7WteGFBg8dLs/C0Mk3DxR/v9K+Fi9YGaIVMweUJLv420F++kAZDbcjn8jwi9GUxPn
 hVWD6VyXliBUDSVVsGM6r3ESw9JHnEcjRipY1w3hxTqz9V1qYOB5hJQLtt2rAkLxNoM3
 deQmqN/EmOqW7mgmaX4atTWR5J3Fopb6KBaol8RS7Br/HIVZB5Gr0VU1BVHMF6HW1Yse
 kUY9olSRF8SlGhmcAjgo9ZWwfiuEUxIVoNdp19pBIPLnQQOY5YewnxvWkgzT7hcbOzMF
 ZjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723830873; x=1724435673;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vKkLRfLwd+3pXpbvNbngAZ+9T9Lz9kOCjy+cNgYYdAY=;
 b=MXnxG9lnfALV+0J6982hbuYFN4ZutdGkkeLqHKf/PVEh07smPdohsoBsHueGs0aK0R
 rDf2geqlWCjHH3a47vp0u2GgExHQ4Zlni96iXQeNzuYhRSeHlfcqxZ5mdovI2b5eZNih
 SWKC6LkJ0f2JH5S6dgWxVuNZ+CkICquvdAADsMv5rgYtjt4aHzcV1G/GBbyqitWV3AQg
 RvTw0l7K4Llf8tkFymAlXblw//qxmsdkc6vhPh2GB77DZnnB5kWNKY6qDlw8mSo2N4ZE
 g9pmvpEGEYDxJaFPP9UMdrtpIUmKYMLNPqyT2Kl7jJq5U9AMjdVcYA/KaXK8J8zILExC
 XFMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEeEE9Qw5dM5sSyUzwiPuKzYRnD62C+pNIrRP2mfg2n60LBQRZnn8gb+xJhBgwrKHNomNDomwBBQ2IdE0ggOLS5HpOT10=
X-Gm-Message-State: AOJu0YwX+4MZfl3EwfyaBpOM1KS6xkLD5+UU/DJb8nKSN1CsbQeGom6o
 2ddp7fFT3Y5boqPOxz/fo+j+8tXUNLhSyVM48K/+xOA020qoUfDpBTNBmOCWPm0=
X-Google-Smtp-Source: AGHT+IEbfHawBN3cm/BrNhs25Miea0myhD7+YcS/i6OLgODWH/6jqWoXdfVk4cc6MbIKi0KX9CZc1Q==
X-Received: by 2002:a05:6a00:915f:b0:70d:2693:d208 with SMTP id
 d2e1a72fcca58-713c4e857c5mr4269815b3a.15.1723830873559; 
 Fri, 16 Aug 2024 10:54:33 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aefa113sm2965498b3a.99.2024.08.16.10.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 10:54:32 -0700 (PDT)
Message-ID: <dbce200b-a6ac-46ed-aec3-4a87f1434797@linaro.org>
Date: Fri, 16 Aug 2024 10:54:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-3-pierrick.bouvier@linaro.org>
 <54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

T24gOC8xNi8yNCAwMzo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE1LzgvMjQgMDA6NDEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBGb3VuZCBvbiBk
ZWJpYW4gc3RhYmxlLg0KPj4NCj4+IC4uL3RhcmdldC9pMzg2L2t2bS9rdm0uYzogSW4gZnVu
Y3Rpb24g4oCYa3ZtX2hhbmRsZV9yZG1zcuKAmToNCj4+IC4uL3RhcmdldC9pMzg2L2t2bS9r
dm0uYzo1MzQ1OjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9mIG5vbi12b2lkIGZ1
bmN0aW9uIFstV2Vycm9yPXJldHVybi10eXBlXQ0KPj4gICAgNTM0NSB8IH0NCj4+ICAgICAg
ICAgfCBeDQo+PiAuLi90YXJnZXQvaTM4Ni9rdm0va3ZtLmM6IEluIGZ1bmN0aW9uIOKAmGt2
bV9oYW5kbGVfd3Jtc3LigJk6DQo+PiAuLi90YXJnZXQvaTM4Ni9rdm0va3ZtLmM6NTM2NDox
OiBlcnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdl
cnJvcj1yZXR1cm4tdHlwZV0NCj4+ICAgIDUzNjQgfCB9DQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4g
LS0tDQo+PiAgICB0YXJnZXQvaTM4Ni9rdm0va3ZtLmMgfCA0ICsrLS0NCj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBSZXZp
ZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0K
PiANCj4gQnV0IHdoYXQgYWJvdXQgdGhlIG90aGVyIGNhc2VzPw0KPiANCj4gJCBnaXQgZ3Jl
cCAnYXNzZXJ0KGZhbHNlKScNCj4gYmxvY2svcWNvdzIuYzo1MzAyOiAgICAgICAgYXNzZXJ0
KGZhbHNlKTsNCj4gaHcvaHlwZXJ2L2h5cGVydl90ZXN0ZGV2LmM6OTE6ICAgIGFzc2VydChm
YWxzZSk7DQo+IGh3L2h5cGVydi9oeXBlcnZfdGVzdGRldi5jOjE5MDogICAgYXNzZXJ0KGZh
bHNlKTsNCj4gaHcvaHlwZXJ2L2h5cGVydl90ZXN0ZGV2LmM6MjQwOiAgICBhc3NlcnQoZmFs
c2UpOw0KPiBody9oeXBlcnYvdm1idXMuYzoxODc3OiAgICBhc3NlcnQoZmFsc2UpOw0KPiBo
dy9oeXBlcnYvdm1idXMuYzoxODkyOiAgICBhc3NlcnQoZmFsc2UpOw0KPiBody9oeXBlcnYv
dm1idXMuYzoxOTM0OiAgICBhc3NlcnQoZmFsc2UpOw0KPiBody9oeXBlcnYvdm1idXMuYzox
OTQ5OiAgICBhc3NlcnQoZmFsc2UpOw0KPiBody9oeXBlcnYvdm1idXMuYzoxOTk5OiAgICBh
c3NlcnQoZmFsc2UpOw0KPiBody9oeXBlcnYvdm1idXMuYzoyMDIzOiAgICBhc3NlcnQoZmFs
c2UpOw0KPiBody9uZXQvZTEwMDBlX2NvcmUuYzo1NjQ6ICAgICAgICBhc3NlcnQoZmFsc2Up
Ow0KPiBody9uZXQvaWdiX2NvcmUuYzo0MDA6ICAgICAgICBhc3NlcnQoZmFsc2UpOw0KPiBo
dy9uZXQvbmV0X3J4X3BrdC5jOjM3ODogICAgICAgIGFzc2VydChmYWxzZSk7DQo+IGh3L252
bWUvY3RybC5jOjE4MTk6ICAgICAgICBhc3NlcnQoZmFsc2UpOw0KPiBody9udm1lL2N0cmwu
YzoxODczOiAgICAgICAgYXNzZXJ0KGZhbHNlKTsNCj4gaHcvbnZtZS9jdHJsLmM6NDY1Nzog
ICAgICAgIGFzc2VydChmYWxzZSk7DQo+IGh3L252bWUvY3RybC5jOjcyMDg6ICAgICAgICBh
c3NlcnQoZmFsc2UpOw0KPiBody9wY2kvcGNpLXN0dWIuYzo0OTogICAgZ19hc3NlcnQoZmFs
c2UpOw0KPiBody9wY2kvcGNpLXN0dWIuYzo1NTogICAgZ19hc3NlcnQoZmFsc2UpOw0KPiBo
dy9wcGMvc3BhcHJfZXZlbnRzLmM6NjQ4OiAgICAgICAgZ19hc3NlcnQoZmFsc2UpOw0KPiBp
bmNsdWRlL2h3L3MzOTB4L2NwdS10b3BvbG9neS5oOjYwOiAgICBhc3NlcnQoZmFsc2UpOw0K
PiBpbmNsdWRlL3FlbXUvb3NkZXAuaDoyNDA6ICogYXNzZXJ0KGZhbHNlKSBhcyB1bnVzZWQu
ICBXZSByZWx5IG9uIHRoaXMNCj4gd2l0aGluIHRoZSBjb2RlIGJhc2UgdG8gZGVsZXRlDQo+
IG1pZ3JhdGlvbi9kaXJ0eXJhdGUuYzoyMzE6ICAgICAgICBhc3NlcnQoZmFsc2UpOyAvKiB1
bnJlYWNoYWJsZSAqLw0KPiB0YXJnZXQvaTM4Ni9rdm0va3ZtLmM6NTc3MzogICAgYXNzZXJ0
KGZhbHNlKTsNCj4gdGFyZ2V0L2kzODYva3ZtL2t2bS5jOjU3OTI6ICAgIGFzc2VydChmYWxz
ZSk7DQo+IA0KDQpUaGV5IGRvbid0IHNlZW0gdG8gYmUgYSBwcm9ibGVtLCBidXQgSSdsbCBk
byBhIHNlcmllcyB0byBjbGVhbiB0aGlzIA0KY29tcGxldGVseSBmcm9tIHRoZSBjb2RlIGJh
c2UsIHNvIGFzc2VydChmYWxzZSkgaXMgZXJhZGljYXRlZC4NCg==

