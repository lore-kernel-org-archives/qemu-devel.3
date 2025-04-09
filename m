Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905CCC369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 12:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2U6F-0004Zh-DN; Wed, 09 Apr 2025 08:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2U61-0004Ve-7b
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 07:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1u2U5x-0004xX-Ia
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 07:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744199990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGYeIdON7sDA69uYb6aWZChE2KaJ8xLMx1K6I241Q/E=;
 b=hZX4IG+prYQPQpxWM62qOZBkDAo9d22fq5RWCgwVN5HWSOxA2tkmmeaN3SkCO0OfGQjF7P
 gjQJ/OU7apxhWbVS4sj54toPrZEzt7Y4haKEvVStR6s4pNVpVuUVRNfjBfzmfVhQbaRlVM
 UTlNxoKfXlYMPlKQKCgKcw3nmujLDlw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-qF2TikwXOeC6DFJq6av1dw-1; Wed, 09 Apr 2025 07:59:47 -0400
X-MC-Unique: qF2TikwXOeC6DFJq6av1dw-1
X-Mimecast-MFC-AGG-ID: qF2TikwXOeC6DFJq6av1dw_1744199986
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-306e5d9c9a6so309198a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 04:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744199986; x=1744804786;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGYeIdON7sDA69uYb6aWZChE2KaJ8xLMx1K6I241Q/E=;
 b=dg1QraRHYDnmdka2OKL5+9cPYvPO0h68nhJ9aXQQvgoUva5zGXMa/Howwa20xqGSKB
 JR4YhrtRTWlhdQE9q1nnrPn02YBu1FHRrVfWAFWlqH+X0TjO3OBH9QlY7SGzzPa2O2Ct
 SlPO0is7W8BnweJxOPbjr1GYYJ5cfsr4nR27QEheyGkXOyiDHHBo4BF/9P9Xlk3jEIr8
 4i0BHHiCmAMDhQC10yZ3Uzgcdu6J7efSViFqtDQgUJ+3AyNgcrLXkGs+nyO+Nl1D/vat
 iCZONMN/xJcfkEO0lkN3kmPH6QK5MaVqoTl9ASMrkCcdFwHYCl5WiukkCWwC60pd85pN
 ZpxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvZvzMX/ebCPsKIGm/zQe7ScTSeXuA5g4LUjR8My4wBIvCWTNspTp6qR1TzvZbcF2VvdQvyrzZ9/X@nongnu.org
X-Gm-Message-State: AOJu0YwDRnnT4kiGgKWcEFlmfxqBCkn43rHJTAAn2lsWYUwGFVBXjjT9
 mbUFpM1V8B+5RLb5iKoH0+R9VZDSwody8aWc2urolFhQPiZJy0PaenNkfMsv9GIqowIC0+UPtxn
 v+jXzGPyoKtUsv8DDHqnirkjKyOhI2LoGSaxQpgWyIgvYamqBSGgT
X-Gm-Gg: ASbGncuCpN85sAFgV1xfgbmGz/Ak2WIlu2pmMvAneTC6iwCeEyd2s19LL9Bp/jAWLFI
 pA1NRfo9BG9Un/A3jLeaXhqr80MHlznvn6oXxkwEa4Wlk14B8GNsFzccn5pCRGcW5bNTp3NjVwa
 geKSgcjIPJsNja5K9HRc4VR6rkZBQX/nbJ8OQqJZJjp7qOyxtyjkZYNHSUXOOv9ycgqQ11SjKZy
 zreC2qspEsPgBXzGaRar9S2Gh3Qpmb1hMuu0wEwklBEAi5sj1R0jZ79imEyIZqazDw48P/j4tqk
 Ziqa6EEcKa39GX/2ntNClkBX/CNP
X-Received: by 2002:a17:90b:5344:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-306dbc3ba42mr3666433a91.29.1744199986378; 
 Wed, 09 Apr 2025 04:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pAQggumJtLLh7kjfEdPtZ8EDPuN9vfLvgpJPqP02shc0zPjL/2U3OHdnLDzNiYoKP/OCjA==
X-Received: by 2002:a17:90b:5344:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-306dbc3ba42mr3666396a91.29.1744199985948; 
 Wed, 09 Apr 2025 04:59:45 -0700 (PDT)
Received: from smtpclient.apple ([115.96.197.203])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df0907f3sm1344063a91.28.2025.04.09.04.59.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Apr 2025 04:59:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
Date: Wed, 9 Apr 2025 17:29:28 +0530
Cc: Gerd Hoffman <kraxel@redhat.com>, Alexander Graf <graf@amazon.com>,
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20EDEA71-FFB4-485A-A4F1-74E1EC82D5A0@redhat.com>
References: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
 <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
 <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



> On Apr 9, 2025, at 03:12, Dionna Amalie Glaze <dionnaglaze@google.com> =
wrote:
>=20
> On Tue, Apr 8, 2025 at 1:33=E2=80=AFAM Gerd Hoffman =
<kraxel@redhat.com> wrote:
>>=20
>>  Hi,
>>=20
>>>> Well.  If you want put the db into the igvm and the igvm into the =
uki
>>>> you've got a chicken-and-egg problem.  Moving the firmware from the =
main
>>>> UKI to UKI add-on would solve that.
>>>=20
>>> Why is embedding a public key that will sign the IGVM in the IGVM a
>>> chicken-and-egg problem? It's only that if db were a list of
>>> acceptable measurements, which it isn't.
>>> I'm not sure why relying on secure boot makes any sense for
>>> confidential computing. I still think that tearing down the VM =
context
>>> and rebuilding it is more secure, given
>>> the need for an honest launch measurement/MRTD.
>>=20
>> Current idea is to allow passing EFI signature databases for db/dbx =
to
>> the firmware getting loaded.  The signature databases must be part of
>> the launch measurement.  Not clear yet how exactly to handle that, =
one
>> idea is to add a special page type to the igvm spec, so a igvm parser
>> can easily find and update db/dbx.
>>=20
>> So, the VM context will be rebuild, the igvm (including db/dbx) will =
be
>> measured, the firmware can verify the payload using db/dbx and =
standard
>> secure boot hash/signature.
>>=20
>> This allows to use both signing (pass CA certificate in db) and =
hashing
>> (pass authenticode hash(es) in db) for payload verification.
>>=20
>> The chicken-and-egg problem arises if you go for hashing and want =
embed
>> the igvm file in the UKI.
>=20
> I don't really see how signing the IGVM file for secure boot helps =
anything.
> The VM context will be reconstructed by the hypervisor, and anything
> checked or stored before loading
> the new firmware is suspect.
> SEV-SNP has IDBLOCK_AUTH to have the SNP firmware check a signature,
> but TDX has nothing of the sort.
> Your initial measurement is checked by nothing trusted.

By "initial measurement" you mean before the VM context is =
reconstructed, that is in the first stage boot correct?

>=20
> Do you need the UEFI_APPLICATION that uses the vmfwupdate interface to
> be signed for secure boot? Seems unnecessary.
>=20
>>=20
>>> Revocation is just not a real thing that works. Short-lived policy =
is.
>>> Policy services can be updated more simply than the UEFI variables =
of
>>> every node in the fleet.
>>=20
>> In the model outlined above you'll go ship db/dbx in the igvm, so the
>> launch measurement will tell you what is allowed and what is not.  =
Which
>> in turn can be used in attestation server policies.
>>=20
>> take care,
>>  Gerd
>>=20
>=20
> --
> -Dionna Glaze, PhD, CISSP, CCSP (she/her)



