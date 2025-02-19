Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3987C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 11:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkiDU-0005xL-E0; Wed, 19 Feb 2025 06:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkiDT-0005xB-2k
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:26:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkiDQ-0000qz-0E
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:26:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so45304815e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739964366; x=1740569166; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iApStDCJvUfCeXee8yeyXgBT4rT/rvhjLJdgWWFCNRM=;
 b=g7ZPcz7edvL0UTyWQ91gMVW2fWRDrkThWhlG2o/fd/Rw3sTHHDxrU7fLy8GzM8IAVE
 Sc5GkExuV0bkpKcfrOT2NxGYxZwlEjAXDE0Eo9deFNCjC+aBjUkUeuQrmziXO2rvSLPr
 eF2CNK1D1UgiVpJrg6OO4JenwibobkJIwaTIDzh50kKUrVrE/m/XzSpUKkWgWVZGN8NX
 oHKI1kUnknkzFDwVmJA6qFokB7EZ+0DdxHm2OxoFG4DMCRbHbp3B0bXaYX/3T3zyGWep
 WBmYIk+1A7I0D/IAkZc/ioO8iGTxeXb+6m6Lis/BobGeCUIvAsrWB0hU/OR1C8BZDuoU
 r1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739964366; x=1740569166;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iApStDCJvUfCeXee8yeyXgBT4rT/rvhjLJdgWWFCNRM=;
 b=kfvcxcllgg4nFcHliuv/fnn4vtloCVBF6F1ZX3uivJ3GGg+6fc3pj8i6QP9n2M8LUK
 Y1rDWPj583z2plQhbyviI7txeOYTv0ACOpMO9H5Uw5lpyC1KksEzhtT0UrmYsKX4uAW4
 8U5F5HcScxWoXqHSSyRv49YnG8ZLA3jRQFHF1Ndb5R6vAb0eLW0LCA6p9Kux2sTCHUHW
 eIEPB9CbpQPznDAVNzw0MXRtOxhR6X7oHCqyyF2ApsyS7+4iouv3YBEYGXvaY6zKTjqu
 OpfMd6ansLGAzmHmGnJ5zCEhVBw7J7CCxdk7U9m2RokcHszv9hzXsAD+3VMJM5ojs/lv
 4zwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+wckAL93+DwYrMdiFdh0kAWE30NczQ8eDw3/x0EPe/f/w1elywso+YGdmadkPLVCH4+PQlboV0Hgd@nongnu.org
X-Gm-Message-State: AOJu0Yz9sQRQ3StRzMKqXuWdNxR/PjbktUx5CKIAxSml7rMWOcLz1fq8
 ZD0zmse5JaUASFeJghZSj5tTWcwRoGOXrtr4/0DjzAf4bnS1kHxZ
X-Gm-Gg: ASbGncvG9GgDVpAAvXIEECtQI4KQaFbUCf5Xdma/xyThtu3UU+JbH6KmioQw6vXm7ba
 HXQcIoMUwhfvQh91x9syeos5kqVS4LvOCoiqyEs6L8zP68Oe3mjds4Klzqr82mk3xDOy1zAB5iC
 xeaYtF7uU2VNIn/4ouS4OrlTEFjv2IOoWkyBzy0Z9Mc5ptUnfyGYyok6leLt+4dM13QSIGsEEX+
 TMw5nuEkdX4em/0mudv4a/rSgU33Ej+a5TvmjeiPgFDC5uOirFJSiJ/yLBkOF1teirrhMINgWWq
 a/0baIqdiXOntqY/xBzEXXPAtnKhm04FNS9z6Pl4A2mzcm6XmHm/h7fgGGjmC+tXo5aMREPl
X-Google-Smtp-Source: AGHT+IEIDVxGLXVm3UmjmbM8mUbnyzLAfNCR28Hflo5cJ5BeFFsWEiBDrkN+xT4GAJfkjmR43EDCmQ==
X-Received: by 2002:a05:6000:1786:b0:38f:4b2c:2464 with SMTP id
 ffacd0b85a97d-38f4b2c2755mr8437478f8f.55.1739964366054; 
 Wed, 19 Feb 2025 03:26:06 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1?
 ([2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b434fsm17836924f8f.16.2025.02.19.03.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 03:26:05 -0800 (PST)
Message-ID: <71f051114ab5db2a94506b4d8768ebfa79033590.camel@gmail.com>
Subject: Re: [PATCH v7 19/52] i386/tdx: Track mem_ptr for each firmware
 entry of TDVF
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
Date: Wed, 19 Feb 2025 12:26:04 +0100
In-Reply-To: <20250124132048.3229049-20-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-20-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-wm1-x336.google.com
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

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA4OjIwIC0wNTAwLCBYaWFveWFvIExpIHdyb3RlOgo+ICtz
dGF0aWMgdm9pZCB0ZHhfZmluYWxpemVfdm0oTm90aWZpZXIgKm5vdGlmaWVyLCB2b2lkICp1bnVz
ZWQpCj4gK3sKPiArwqDCoMKgIFRkeEZpcm13YXJlICp0ZHZmID0gJnRkeF9ndWVzdC0+dGR2ZjsK
PiArwqDCoMKgIFRkeEZpcm13YXJlRW50cnkgKmVudHJ5Owo+ICsKPiArwqDCoMKgIGZvcl9lYWNo
X3RkeF9md19lbnRyeSh0ZHZmLCBlbnRyeSkgewo+ICvCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGVu
dHJ5LT50eXBlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgVERWRl9TRUNUSU9OX1RZUEVfQkZW
Ogo+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIFREVkZfU0VDVElPTl9UWVBFX0NGVjoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+bWVtX3B0ciA9IHRkdmYtPm1lbV9wdHIgKyBlbnRyeS0+
ZGF0YV9vZmZzZXQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKg
wqDCoMKgIGNhc2UgVERWRl9TRUNUSU9OX1RZUEVfVERfSE9COgo+ICvCoMKgwqDCoMKgwqDCoCBj
YXNlIFREVkZfU0VDVElPTl9UWVBFX1RFTVBfTUVNOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVudHJ5LT5tZW1fcHRyID0gcWVtdV9yYW1fbW1hcCgtMSwgZW50cnktPnNpemUsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpLCAwLCAw
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKClNob3VsZCBjaGVjayBmb3IgTUFQ
X0ZBSUxFRCByZXR1cm4gdmFsdWUuCgo+ICvCoMKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgiVW5zdXBwb3J0ZWQgVERWRiBzZWN0aW9u
ICVkIiwgZW50cnktCj4gPnR5cGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoMSk7
CgpTZWN0aW9uIGVudHJ5IHR5cGVzIGhhdmUgYWxyZWFkeSBiZWVuIGNoZWNrZWQgYWdhaW5zdCB2
YWxpZCB0eXBlcyBpbgp0ZHZmX3BhcnNlX2FuZF9jaGVja19zZWN0aW9uX2VudHJ5KCksIG5vIG5l
ZWQgdG8gY2hlY2sgdGhlbSBhZ2FpbiBoZXJlLgo=


