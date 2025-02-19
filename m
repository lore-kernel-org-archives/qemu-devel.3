Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA71EC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkh6d-0004yV-AB; Wed, 19 Feb 2025 05:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkh6b-0004yJ-Pd
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:15:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkh6a-0007RU-0I
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:15:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f504f087eso1594821f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739960098; x=1740564898; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pBdezJomEBdTTOtXU+AfpHqre+lwyUBQ4DYIvVkVfSA=;
 b=VDmd4A2CMxGbHcyV/2IYEZelmOU11fvJBGS1EadhJU25Q29JiqDGR5VJ9rmGSWLU/K
 aBZlFeuzvA2XtPkRIUH+mthJxaNxax5EGKQUr7RSLdTmYEas33BNPishubqEUKkvKnGf
 dzKcZsKTCsXZzhghJjHPbdLZpNXsp434hHsmQ38TXRCzoG07ME+zfhzRa//3R9p86bPS
 oky4y3IZ871WnTT3PVF/SBJCgAGVXuZbolrJxtgvc7AdAhno+Bs4sVp0ywr71qds/vV3
 h7w84k9lavZp0wZoJQHd8MVPqq5+KzCWOp8Sw58DhjpNWwbjkJv90UvXcecdAivDDtQw
 YAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739960098; x=1740564898;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pBdezJomEBdTTOtXU+AfpHqre+lwyUBQ4DYIvVkVfSA=;
 b=h3p8hPXi64OGnaZrgc9+4yfVOR5ImevV+E4rfwmw5X8V+NYxbhMc1H1588eyVvqOhl
 awwwkgtB6fCltrruhY8sEtmGz8nzHh8KTkMscQt/VzeU3gpcYFU+YwlcrsG4PsCPKC0E
 uDLq3JUeIFBgbqIBJU8oYyqHeolhe9Ye8yjcxmkRCe9MQjxhUCPE8EuWopf43nvp7I3d
 3xS05oneFTxHg+Nvjl9bpso/Yz3ezzMfzVhW2DKpS+L5T5bn//ELNRnnHFTKAcNtZ5t3
 cf+PocCZin2jfSTD7FqT0dNw+A8JfdszEvEXT5cx1SWr3cZXd541u4idODWgwha5kt10
 SQmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/DJhG5sULM/dK/qJ6UoCh8QgWoqTgNMcePmz6pZayULzGpS582NqX/+OTbu9W8nUjGnf07M2o01H@nongnu.org
X-Gm-Message-State: AOJu0Yz5qsOtZDn9IyXSvLkAYSzEtmB3aUmAcQd6QE36//KQ/NGJ8cfR
 +Zf7k/Y+Lne7OBUsF+gEXMNW5dQYYb3Z2qWjy1Tzv0UaZ3t1TFmR
X-Gm-Gg: ASbGncuuuJk0VZb0yg5EcmKj+KVfO1t6RbKYNpzByNAJsIIbheJ5PGylRqUvY69i+rL
 B0GQqvlWMHEEB32tyx3bRaDplstoTDw50uPOQuHut9Ghy/Vaez56eFxJ/9N5SdF5eSoTzWIQfZ1
 jwsvj+XhSbAN1sovEKUYnYji138t6DRG8xJgJTU4cnt+ecsaxeVs1wWKhF2hCvXHbf4W1qfySrn
 3BPaODjE2J2DDQHDpYZzRh25ujUHi7jTldcXhIcdc1QbslJRy7r8IVqKNlKFgW6MoQvyanwhCQp
 AcKOB8G++UUCgx93MVL8RDTj6TokhRTL72IyUc4XJlxcEw+F2sEC0fTAA0i6EN1sOnQ6GF2C
X-Google-Smtp-Source: AGHT+IGVpmUfFf4EKFxE5EQ7BRJspLuZlpuC9K+zDXtaBJ110L1kEgPSGteUe0uewA53XqGlKtU4FQ==
X-Received: by 2002:a05:6000:1a86:b0:38f:2211:e628 with SMTP id
 ffacd0b85a97d-38f5878d730mr2603011f8f.20.1739960097984; 
 Wed, 19 Feb 2025 02:14:57 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1?
 ([2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b412esm17125485f8f.1.2025.02.19.02.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 02:14:57 -0800 (PST)
Message-ID: <6571727841685f4276aa7c814776ff1fdd162a0a.camel@gmail.com>
Subject: Re: [PATCH v7 08/52] i386/tdx: Initialize TDX before creating TD vcpus
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Date: Wed, 19 Feb 2025 11:14:56 +0100
In-Reply-To: <20250124132048.3229049-9-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-9-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA4OjIwIC0wNTAwLCBYaWFveWFvIExpIHdyb3RlOgo+IGRp
ZmYgLS1naXQgYS9hY2NlbC9rdm0va3ZtLWFsbC5jIGIvYWNjZWwva3ZtL2t2bS1hbGwuYwo+IGlu
ZGV4IDQ1ODY3ZGJlMDgzOS4uZTM1YTlmYmQ2ODdlIDEwMDY0NAo+IC0tLSBhL2FjY2VsL2t2bS9r
dm0tYWxsLmMKPiArKysgYi9hY2NlbC9rdm0va3ZtLWFsbC5jCj4gQEAgLTU0MCw4ICs1NDAsMTUg
QEAgaW50IGt2bV9pbml0X3ZjcHUoQ1BVU3RhdGUgKmNwdSwgRXJyb3IgKiplcnJwKQo+IMKgCj4g
wqDCoMKgwqAgdHJhY2Vfa3ZtX2luaXRfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hfdmNw
dV9pZChjcHUpKTsKPiDCoAo+ICvCoMKgwqAgLyoKPiArwqDCoMKgwqAgKiB0ZHhfcHJlX2NyZWF0
ZV92Y3B1KCkgbWF5IGNhbGwgY3B1X3g4Nl9jcHVpZCgpLiBJdCBpbiB0dXJuCj4gbWF5IGNhbGwK
PiArwqDCoMKgwqAgKiBrdm1fdm1faW9jdGwoKS4gU2V0IGNwdS0+a3ZtX3N0YXRlIGluIGFkdmFu
Y2UgdG8gYXZvaWQgTlVMTAo+IHBvaW50ZXIKPiArwqDCoMKgwqAgKiBkZXJlZmVyZW5jZS4KPiAr
wqDCoMKgwqAgKi8KPiArwqDCoMKgIGNwdS0+a3ZtX3N0YXRlID0gczsKClRoaXMgYXNzaWdubWVu
dCBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIGt2bV9jcmVhdGVfdmNwdSgpLCBhcyBub3cgaXQncwpy
ZWR1bmRhbnQgdGhlcmUuCgo+IMKgwqDCoMKgIHJldCA9IGt2bV9hcmNoX3ByZV9jcmVhdGVfdmNw
dShjcHUsIGVycnApOwo+IMKgwqDCoMKgIGlmIChyZXQgPCAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
IGNwdS0+a3ZtX3N0YXRlID0gTlVMTDsKCk5vIG5lZWQgdG8gcmVzZXQgY3B1LT5rdm1fc3RhdGUg
dG8gTlVMTCwgdGhlcmUgYWxyZWFkeSBhcmUgb3RoZXIgZXJyb3IKY29uZGl0aW9ucyB1bmRlciB3
aGljaCBjcHUtPmt2bV9zdGF0ZSByZW1haW5zIGluaXRpYWxpemVkLgoKPiDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gZXJyOwo+IMKgwqDCoMKgIH0KPiDCoAo+IEBAIC01NTAsNiArNTU3LDcgQEAgaW50
IGt2bV9pbml0X3ZjcHUoQ1BVU3RhdGUgKmNwdSwgRXJyb3IgKiplcnJwKQo+IMKgwqDCoMKgwqDC
oMKgwqAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJrdm1faW5pdF92Y3B1OiBrdm1fY3JlYXRl
X3ZjcHUgZmFpbGVkCj4gKCVsdSkiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGt2bV9hcmNoX3ZjcHVfaWQoY3B1KSk7Cj4gK8KgwqDCoMKgwqDC
oMKgIGNwdS0+a3ZtX3N0YXRlID0gTlVMTDsKClNhbWUgaGVyZS4K


