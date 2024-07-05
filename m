Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A847CC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWVm-0006aM-Ks; Thu, 04 Jul 2024 20:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPWVi-0006Zx-Oo; Thu, 04 Jul 2024 20:09:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPWVg-0003Eu-Pr; Thu, 04 Jul 2024 20:09:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70af8128081so815509b3a.1; 
 Thu, 04 Jul 2024 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720138146; x=1720742946; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8c4Rfno6JWt6kSJcMhwkFgcGjBQpKGVlBEZqrrKONs=;
 b=Iak4M55KE+SWPC4XCLIWEOIa3kM0QILATGlZb6d5bnlRLKFe2R5a5dj78eGS46h8JD
 ZPS/jnT8TqGkzEf/9SLh0jloSpNsIfP7BkdlHmq+fjHYPQ/xkmLlOfLP6TqdNPbatoVn
 Yf6UjW2oMPTxmPe57s0XfsJZX59kGohEluDhbsqcwDp1Ivbf3soPIRT01yxpuz0jiAmO
 5W4V577v3jkELW/P3ijCWqgd5aRYxVI24GghYs2X0w+ojeGdRiAk1w9zrqUGirkZ37nk
 8+XDaODNtx3LRU3ckc8kxEifwZ75lHr07enBn/QqYZ7tXB5nVe43nYke9tDrTK7gBQ7q
 6nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720138146; x=1720742946;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J8c4Rfno6JWt6kSJcMhwkFgcGjBQpKGVlBEZqrrKONs=;
 b=X2yKEpsGA6WTlQlbXmWOx7H7xToSwPtjog6fT6srf0I37MuQh+1KFL2B6aflcN4SDE
 n8XapKxdT1R5EaP1qIhS4QK1oD2ZEhPCdgiesUmylQRBWRtFS7Cjr/mmNqiFGhQxVDUR
 u+6vYoPjWG/OPCtjKG6JKnYE0iF+OCAFIZEdI6Nd4mEstNj6SPxEGy4qmxSahWnIvPO4
 vO+ScV7iQLTxzJLykFZwXpJ2kJneKwxJ+m8Kxz5qYoOObDhy1TQzki7+31qkRAC6aM8P
 4iYCd3mjUxrpP+bO5SHJB21dIwy/RZ3ecH+NbgEv2y4XFcIdzQkzCqdVHTBntujMKJAY
 o3dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURw5ORNzrG/C95jo50yiY30ObQ//6q3Co5L2gnLmjZjloOhimk/2YqKLksmgHWojbfbDDwu33OeDtrMFqO7wgteS4/D/QMyGBNWXi/+WJ2MHy4ih7Pgp6QZHQ=
X-Gm-Message-State: AOJu0YxAivIqcCaZKOjpchvw7KmhWrL6zHJYKaP8o0zJgBaT3sp6H7F0
 WSVxrB9iVmIsfbE1WL1Brf9C7XGWo9K+MKKxva9wizc0WFBJqtCu
X-Google-Smtp-Source: AGHT+IHmub6qh/qK2FE/TERFl+CK3kqBg5jQIkEn7YvlldKohJYfsG/VkLkzoBcHa8B0xXHQMXZrjw==
X-Received: by 2002:a05:6a20:da84:b0:1be:d74c:dd5a with SMTP id
 adf61e73a8af0-1c0cc74bdaamr2805646637.23.1720138145705; 
 Thu, 04 Jul 2024 17:09:05 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d9685sm128330415ad.111.2024.07.04.17.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 17:09:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 10:08:49 +1000
Message-Id: <D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com>
Subject: Re: [PATCH RFC V3 13/29] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "Jonathan Cameron"
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, "zhukeqian" <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "Linuxarm"
 <linuxarm@huawei.com>
X-Mailer: aerc 0.17.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-14-salil.mehta@huawei.com>
 <D2GEV8KD5L3F.FRD8UH16X3GU@gmail.com>
 <fd0478a51e4e445da33dadafc00b33f6@huawei.com>
In-Reply-To: <fd0478a51e4e445da33dadafc00b33f6@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

On Thu Jul 4, 2024 at 9:23 PM AEST, Salil Mehta wrote:
> HI Nick,
>
> Thanks for taking time to review. Please find my replies inline.
>
> >  From: Nicholas Piggin <npiggin@gmail.com>
> >  Sent: Thursday, July 4, 2024 3:49 AM
> >  To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
> >  qemu-arm@nongnu.org; mst@redhat.com
> > =20
> >  On Fri Jun 14, 2024 at 9:36 AM AEST, Salil Mehta wrote:
> >  > ARM arch does not allow CPUs presence to be changed [1] after kernel
> >  has booted.
> >  > Hence, firmware/ACPI/Qemu must ensure persistent view of the vCPUs  =
to
> >  > the Guest kernel even when they are not present in the QoM i.e. are
> >  > unplugged or are yet-to-be-plugged
> > =20
> >  Do you need arch-independent state for this? If ARM always requires it
> >  then can it be implemented between arm and acpi interface?
>
>
> Yes, we do need as we cannot say if the same constraint applies to other
> architectures as well. Above stated constraint affects how the architectu=
re
> common ACPI CPU code is initialized.

Right, but could it be done with an ACPI property that the arch can
change, or an argument from arch code to an ACPI init routine? Or
even a machine property that ACPI could query.

> >  If not, then perhaps could it be done in the patch that introduces all=
 the
> >  other state?
> > =20
> >  > References:
> >  > [1] Check comment 5 in the bugzilla entry
> >  >    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481#c5
> > =20
> >  If I understand correctly (and I don't know ACPI, so it's likely I don=
't), that is
> >  and update to ACPI spec to say some bit in ACPI table must remain set
> >  regardless of CPU hotplug state.
>
>
> ARM does not claims anything related to CPU hotplug right now. It simply
> does not exists. The ACPI update is simply reinforcing the existing fact =
that
> _STA.Present bit in the ACPI spec cannot be changed after system has boot=
ed.=20
>
> This is  because for ARM arch there are many other initializations which =
depend
> upon the exact availability of CPU count during boot and they do not expe=
ct
> that to change after boot. For example, there are so many per-CPU feature=
s
> and the GIC CPU interface etc. which all expect this to be fixed at boot =
time.
> This is immutable requirement from ARM.
>
>
> > =20
> >  Reference links are good, I think it would be nice to add a small summ=
ary in
> >  the changelog too.
>
> sure. I will do.

Thanks. Something like what you wrote above would work.

Thanks,
Nick

