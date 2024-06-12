Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1AFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQL7-0008SR-8Y; Wed, 12 Jun 2024 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQL5-0008Rx-M8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:56:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQL4-0000Bk-85
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:56:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-705c1220a52so533132b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718207801; x=1718812601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C/xS715ze4u55i++yoL/8pno/bPeipAfJy0uowYBN4g=;
 b=xFPdJ0KpyHDCwn7N7OSHcjZ+R7dHfE6zyEOndPv23rxTxLfZ3P0ntPNIloYhPCx95f
 xm6zi52K5FcJyogdJXantML/QRnvHOK77XVCgXkrhOuDr8507VPgR2188UjKUrVbHSJ5
 HR+ByMKcU5P8NBWYcn3qBBb22Mou9rnJb+KE3dhLN5xcsjxHSDXBXBvq+3iJrrKUG+Lr
 6gidGaNj8IFO5AyZqERQhfQB+EzY04BTEvBbjF8j43nybGSrGxsxwSE3n71NugEYPHVx
 v/w4/vPdpVwReI8eVzExO+ZDwdH+7E2fiVw/nkmZrwy/gpU36mOPC3hlO/zckF/I/mQ0
 rmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718207801; x=1718812601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/xS715ze4u55i++yoL/8pno/bPeipAfJy0uowYBN4g=;
 b=LTlATs+eYhn3ta3YYciQGq5QkQ5mGHl0PnGmh3pbsgjqDlWsYzYJFoowHVFnxfX8N7
 4G3Y649rbc5DnIAjJF91GhheoYYYr7O1LVpELg1Ha8KzE0trwKI2gtNoK2SelKl5hqFO
 2/PTzUUWGvInpP0k0941UG1krPauhhnkNqdCr7ZQoE5/v9RUuCTAai3s1sfcSebpQ+0T
 p1h3JdV9o915N0PQUokR9514UoaBXHefUykOHDP8lJyo3waBXnpuWK+/sKBhcmkcu6mc
 KAH4qVjaCfmfrUKDK38sODhdpuOXF+aW9WyVpvRsrBaiOmoXbwEEavEHyw9dEflGBicT
 JLZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX+hdtHxEzDxoVDyxGlhd5xtj1+Ruu25j7mzlqP53/MDgSWBZBcBLzlS/A/0/Mp/QoZSa2irDAn+ofMdfUO6oqmng8iig=
X-Gm-Message-State: AOJu0YyqMwKrnnJ8PJsJTOn7XdMzQc7HKe7gEuE9p/SyB8Y5S4tBdibA
 PnvOd1oMjE2EGPAx8L1vM55lvnL6+grxX4oMY6QzrNDxzoveQHH4mNeZbLbjxRWlkpuL/wU2jS/
 p
X-Google-Smtp-Source: AGHT+IGMBCXE2LyecX+AfooXBwHBA7tsWopJGphYysIOn+9ELPlwsGk4Fvby1MO0dabHXRAuwqYMCQ==
X-Received: by 2002:a05:6a20:9183:b0:1b8:a0b3:c9d5 with SMTP id
 adf61e73a8af0-1b8a9c6891bmr2836434637.41.1718207800904; 
 Wed, 12 Jun 2024 08:56:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704140681e5sm9072922b3a.125.2024.06.12.08.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 08:56:40 -0700 (PDT)
Message-ID: <8da3efe5-27cc-4017-a6de-b78e1ad48317@linaro.org>
Date: Wed, 12 Jun 2024 08:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] include/exec: add missing include guard comment
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240612153508.1532940-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

T24gNi8xMi8yNCAwODozNSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGlu
Y2x1ZGUvZXhlYy9nZGJzdHViLmggfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL2dkYnN0dWIuaCBiL2luY2x1ZGUvZXhlYy9nZGJzdHViLmgNCj4gaW5kZXggZWIxNGI5
MTEzOS4uMDA4YTkyMTk4YSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL2dkYnN0dWIu
aA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvZ2Ric3R1Yi5oDQo+IEBAIC0xNDQsNCArMTQ0LDQg
QEAgdm9pZCBnZGJfc2V0X3N0b3BfY3B1KENQVVN0YXRlICpjcHUpOw0KPiAgIC8qIGluIGdk
YnN0dWIteG1sLmMsIGdlbmVyYXRlZCBieSBzY3JpcHRzL2ZlYXR1cmVfdG9fYy5weSAqLw0K
PiAgIGV4dGVybiBjb25zdCBHREJGZWF0dXJlIGdkYl9zdGF0aWNfZmVhdHVyZXNbXTsNCj4g
ICANCj4gLSNlbmRpZg0KPiArI2VuZGlmIC8qIEdEQlNUVUJfSCAqLw0KDQpSZXZpZXdlZC1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

