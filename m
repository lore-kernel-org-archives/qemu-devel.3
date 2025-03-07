Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8903EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdDa-0003Yb-Sf; Fri, 07 Mar 2025 14:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdAd-0006Dt-4h
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:43 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdAb-0001OW-6V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:42 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22401f4d35aso43384215ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374938; x=1741979738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QqCDeIdxVx+sY8BGYg8mEWyfybpFwVxZ0VNk7LmcKUo=;
 b=QTXqJ810WuvAIEH+HG5JLY7reCk+Kb69gwuuvbET9bLAdVZa3qW2BT7vfnXcnWF03X
 RJ2vSZVvGHhiNGSKNQYoYEkYQ5Y/998UQMYzmcT0SPfLFBuwF6aFeykoVE/lHz0zL7Oi
 bpXcjJ+FTWqVgd9RWcRQayTltw95pOr6rGl4ixVMuMsF3ybavysAiFQ0xLbRAJDbwKrF
 GYLyURQz9r9HATC/FuYn6pfhfkAqCtt7FJqzFC9fo48gaYU4KnL4S+8ADDmkeoEmSqQk
 spBqcziAqxYOuYuwOxGRcsUSp7nEup6zSSx23QRb5nwPpybaVOlNQ7phlQSBJheEhyJ1
 jIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374938; x=1741979738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QqCDeIdxVx+sY8BGYg8mEWyfybpFwVxZ0VNk7LmcKUo=;
 b=BA/XCJAy1Y3uNhxJ5/A6mKyu9ZIHLrtNyL4wyXYQhhJEkHrd7y8Oeb01+4k+lpx/1m
 W0Mj0Upijzgi4r/JXd+VcA1MzvcSKTKIoVhfiyQGOSqO/GeSDGDceblhLZFzqiSAa3uc
 4C0YFcQ5X+R8pc/LudATCFIX44/+7t7FHYdDtvPAlFfP2MeKDkL2JkjfCatftPXk7hR6
 8OkkLjVLyTh4oIUpjn8eO95gI3JsLGES8ZE4mvRok0nuKjxDk81FsCjFXVFMEIHDbaKZ
 meMS61/6e3B4fLo5k8mi02aUKDWPUrCfidmaHLameqsFAsIwI3/bwFkq4FSYFvfhX2HN
 3Naw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRlE+BQQI9zbrezzbnP1irGmbEsReoyoEz5alDhE4RzYQj4JTRQQSmrbfkTHVf2NtVYlDkw545lZLd@nongnu.org
X-Gm-Message-State: AOJu0YxMMafpgmpxVbsIaiRohkymTcgEx90Y74nhf9P8XbKxdO+27xAy
 L++Y44ZBvxOeEaGo71P8KlpdPkTxQE1cvJUpW/GVOwmR9woomOdhaYNCXRYl/uc=
X-Gm-Gg: ASbGncva5JhDxIPvegHx0AgEgcSPs/1nI+O53khzsSQTN4LoSJsZxIS01Ehudn9njly
 Ute28LcD5RSUP8Ks494tlE7w4TjozjfL27iEF1orGnwNc5N28xvleqgQLwv54sms7fo6Wbju2mq
 MykLv51+ccTJyJWwGffh9POdkx15yViFKrohWrv5JriL22Dg89gr4zMhEPLA7LSkc5ZIZG0pNrj
 IzfdMmrd3XvcGkfOI+uwVG39XJaWDvFV43i3VyvQVZmN2JyimfOC6gNPu+gH4uXwfYHHtmL+mqn
 UZgNQ2lQnJF8vRuwxaxrVaHCstjxS2qRBoeI6fwimkijkeDgCmt3fyvW9w==
X-Google-Smtp-Source: AGHT+IGnzx+k5zUhuX3NZ/2GZWiR3bSe6+YntnIe5LSV9c49LIusJsWpQguDAWG9zDWnLdX6/aAelQ==
X-Received: by 2002:a05:6a21:3990:b0:1f5:52fe:dcf8 with SMTP id
 adf61e73a8af0-1f552fee0acmr2561235637.26.1741374938061; 
 Fri, 07 Mar 2025 11:15:38 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af40411619dsm1571828a12.14.2025.03.07.11.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:15:37 -0800 (PST)
Message-ID: <0075174b-a5ee-4516-b9d8-c81e57d862ec@linaro.org>
Date: Fri, 7 Mar 2025 11:15:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hw/vfio: Compile more objects once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVGhl
c2UgZmlsZXMgZGVwZW5kIG9uIHRoZSBWRklPIHN5bWJvbCBpbiB0aGVpciBLY29uZmlnDQo+
IGRlZmluaXRpb24uIFRoZXkgZG9uJ3QgcmVseSBvbiB0YXJnZXQgc3BlY2lmaWMgZGVmaW5p
dGlvbnMsDQo+IG1vdmUgdGhlbSB0byBzeXN0ZW1fc3NbXSB0byBidWlsZCB0aGVtIG9uY2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L3ZmaW8vbWVzb24uYnVpbGQgfCA2ICsrKy0t
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9tZXNvbi5idWlsZCBiL2h3L3ZmaW8vbWVz
b24uYnVpbGQNCj4gaW5kZXggOGUzNzZjZmNiZjguLjI5NzJjNmZmOGRlIDEwMDY0NA0KPiAt
LS0gYS9ody92ZmlvL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L3ZmaW8vbWVzb24uYnVpbGQN
Cj4gQEAgLTE0LDEzICsxNCwxMyBAQCB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9f
UENJJywgaWZfdHJ1ZTogZmlsZXMoDQo+ICAgKSkNCj4gICB2ZmlvX3NzLmFkZCh3aGVuOiAn
Q09ORklHX1ZGSU9fQ0NXJywgaWZfdHJ1ZTogZmlsZXMoJ2Njdy5jJykpDQo+ICAgdmZpb19z
cy5hZGQod2hlbjogJ0NPTkZJR19WRklPX1BMQVRGT1JNJywgaWZfdHJ1ZTogZmlsZXMoJ3Bs
YXRmb3JtLmMnKSkNCj4gLXZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19YR01BQycs
IGlmX3RydWU6IGZpbGVzKCdjYWx4ZWRhLXhnbWFjLmMnKSkNCj4gLXZmaW9fc3MuYWRkKHdo
ZW46ICdDT05GSUdfVkZJT19BTURfWEdCRScsIGlmX3RydWU6IGZpbGVzKCdhbWQteGdiZS5j
JykpDQo+ICAgdmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX0FQJywgaWZfdHJ1ZTog
ZmlsZXMoJ2FwLmMnKSkNCj4gLXZmaW9fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19JR0Qn
LCBpZl90cnVlOiBmaWxlcygnaWdkLmMnKSkNCj4gICANCj4gICBzcGVjaWZpY19zcy5hZGRf
YWxsKHdoZW46ICdDT05GSUdfVkZJTycsIGlmX3RydWU6IHZmaW9fc3MpDQo+ICAgDQo+ICtz
eXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19YR01BQycsIGlmX3RydWU6IGZpbGVz
KCdjYWx4ZWRhLXhnbWFjLmMnKSkNCj4gK3N5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19W
RklPX0FNRF9YR0JFJywgaWZfdHJ1ZTogZmlsZXMoJ2FtZC14Z2JlLmMnKSkNCj4gK3N5c3Rl
bV9zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX0lHRCcsIGlmX3RydWU6IGZpbGVzKCdpZ2Qu
YycpKQ0KPiAgIHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPJywgaWZfdHJ1ZTog
ZmlsZXMoDQo+ICAgICAnaGVscGVycy5jJywNCj4gICAgICdjb250YWluZXItYmFzZS5jJywN
Cg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCg0K

