Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2E606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3dkMG1t;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Hqpxc1bk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWd2Q-0007vd-P2; Thu, 26 Nov 2026 12:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWd2O-0007vP-Nz
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 12:13:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWd2M-0005x5-IK
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 12:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795713212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
 b=P3dkMG1tJ52GaZ9RdXvIbyzVRDnVNo87GXzBvTMMnv1VYPZDRYytYEtlphqOqSxSvQwy8Q
 XHR3A0iSsewoePMCKip07VNzuDedTwgeMsB48h6gi5z3q5prwh/C8n03uGXP64hvKZWVnq
 YNDJdfAMAFXQpnq4sb2uO37CxfkOp1c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-htzx3nCFMgigHCWbSgzVWw-1; Thu, 26 Nov 2026 17:13:30 +0000
X-MC-Unique: htzx3nCFMgigHCWbSgzVWw-1
X-Mimecast-MFC-AGG-ID: htzx3nCFMgigHCWbSgzVWw_1795713209
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4bba5f21b85so12526975e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795713209; x=1796318009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
 b=Hqpxc1bkaLZA5Bp2g4lzHghyK6hOkISLNYHeqMi4oLVZ7CU7n46i6s6YXNQ9wj5UiI
 yxfPSHbVPbfnOoJIdtUQopkJaFkr+kKN3yzIdX6dLVSL7OXwlyQsYcO+qRi552XCPXdN
 zMjfe9nsZDFDFyv2Ew0XKgNQ72UbNNY1sbzyVWMKRtmoS1FO679Kev7+P4FS4xRHWa8N
 Wi3W0vsas1WK+fHMl4lda0c1P6IUd85bVARdGXYG4+st4VPQgSqpkYkr68wwUf67SH4W
 NaifRJ6AYWCPpDnu2F9UCPdhedXPtY633naziRkwPGZ62sWpRe6sGFzifdplTsz4+07x
 C56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795713209; x=1796318009;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mb8Bhbqxu6oM0N1y8b2BBJmbdRvDKKI8uFyOuRtNW2w=;
 b=pmhVzzcDwaAW3m+hHS4xwN/Ob/GwCutp/OABHI4nNFmH8JYzUEBl4Uj1ckc527Cq/9
 1kHV98ZkbfVO5mGxz+JP0yKu7WPRClUlzlahRoPhzr0M9iYcWPQ6kQeU26hb6XybbupT
 WIdT/Pf3mrJXG5WyAkvQT8E2zcWKr0sABhrStFO7A6HEKxansMq9+45ISmQgbeAsaANO
 MPEn88v6eCD1iSB/WusWNu+Lv8qfXpc03qHI4+OuVh0E7FoMcrc2Re6KaLWrDTtTTKMu
 UrQAS0nMT9wJuySkux333SfOkBIVxHlJ612MXSzqLmzNL7mSVss6Gy1LDwrxjoKw9uoS
 ml/w==
X-Forwarded-Encrypted: i=1;
 AL+hErEKN2bXaAe7FBXQaNvYDzj7F1/VisplsA6LWXWsO6BdneDxfSXjwXjwovvRgdYPy5cfeyX+rlYmm34c@nongnu.org
X-Gm-Message-State: APuU4Z9hdJjVn+zotUxWRhGAH0vkBLTEMRajKS4bLVCNelzvAD093Uz3
 YZd1CUL4y5X1GPYXEtcg/GHIdTaB2EKJohh8JcdOx+PBcVl0rvCH06FneySBslWS0z8wH9tV0Ws
 GjTnXCFJmtH/2XhAXk88m5WU4Di4Oaa+2lBgmBwzNfux+2fx1hHTvecnk
X-Gm-Gg: AZFdTZfMQZMrYMsw25XAQnbKOT0LJ82AKmvMr78rWLt+jD5FWzCz2T+N09zR3m5gSOI
 ndgZgLFaLSRYp53bwDhXhfVjJbcqhXLIX/2zNkPV//JKVNW51pOm+mtao/XR0u1qrH+FSyyfX9g
 YHKrT6eiUxr2KPVKxbPyhZZ6byRWqlvY0lhWY18ZaGX2o+GK8sA2g/QiXZ/MXrYaNftt9lWiPpq
 wmef5YovxfTKroq6mtg8wPduf4AJXQSRANf1DDE/a7Q7Cb0aswMWNlvnZo7Z+YRd7aAzAPbChWo
 /mGlmP158VTtgA1zVjq6be8LB2ZAblQ6uArx9FKOzfgPbbQkweMp87p5LF0e2vHIa6V5Gi22OEo
 JaKNpWl1md3rbNEZ55whOxwM/wYFhkLrbPPkIA7yE3++evbX+10+RAnXBpjzUjwdAYnfmUiKxnF
 MttA4CQf9uZUKBs2Fb
X-Received: by 2002:a05:600c:80c1:b0:4a2:10d:5e0d with SMTP id
 5b1f17b1804b1-4bb8615a739mr336371055e9.14.1795713209205; 
 Thu, 26 Nov 2026 09:13:29 -0800 (PST)
X-Received: by 2002:a05:600c:80c1:b0:4a2:10d:5e0d with SMTP id
 5b1f17b1804b1-4bb8615a739mr336370715e9.14.1795713208866; 
 Thu, 26 Nov 2026 09:13:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm38213038f8f.23.2026.11.26.09.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 09:13:28 -0800 (PST)
Message-ID: <fa7522a1-1d0e-4bdf-aad9-767c08878cd1@redhat.com>
Date: Thu, 26 Nov 2026 18:13:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Khushit Shah <khushit.shah@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Eric Auger
 <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
 <20261126062002.136401-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261126062002.136401-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Haseeb, Khushit,

On 11/26/26 7:20 AM, Haseeb Ashraf wrote:
> Hi Khushit,
>=20
> On 26/11/26 11:38, Khushit Shah wrote:
>=20
>> There are many such fields like PAuth (APA, GPA, =E2=80=A6) and SVE. T=
hey are
>> not part of the SYSREG_ framework as there already exists boolean
>> properties for them.
>> (Another way to do this is having -cpu =E2=80=A6,vhe=3Don/off property=
)
>=20
> The v1 series was closer to what you are suggesting: it added a
> standalone `vhe=3Don/off` property and used it to select the
> requested KVM vCPU initialization mode.
>=20
> Could you please also review the v1 implementation?
>=20
> https://lore.kernel.org/qemu-devel/20261121095636.289814-1-haseebashraf=
091@gmail.com/

It is a valid point to question the addition of new vcpu properties (espe=
cially low level ones like this one) while we plan to introduce those SYS=
REG low level properties. For composite properties which stand at higher =
level (tweaking several knobs at KVM VCPU init or IDREG field level) it s=
till makes sense though.

Until now we have proposed for the host vcpu to expose SYSREG props only =
for KVM writable ID reg fields. On the other hand, named vcpu models requ=
ire to have ALL ID reg fields exposed. If we were to extend this infra to=
 other archs or TCG, we may also need to expose ALL fields and just have =
different implementation for setters/getters depending on the writability=
 mode (REG WRITE or VCPU init or anything else).=20

Thanks

Eric>=20
> I changed direction for v2 following Marc's feedback against adding a
> separate property.
>=20
> Thanks,
> Haseeb


