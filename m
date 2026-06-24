Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44ABCDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMPz-0006mJ-ME; Wed, 24 Jun 2026 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHxC-0005tY-3y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:23:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHx1-00067G-Bp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:23:21 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260624072303epoutp0418b0b3625faa9775591c478484b3a0ea~783opto_H0395203952epoutp04J
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260624072303epoutp0418b0b3625faa9775591c478484b3a0ea~783opto_H0395203952epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782285783;
 bh=flLJaw24vmZ5PebTC58E7dtIGLM3IzPX1gG/gt3MsWs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qmuTmiKsI/7UqkYmMIIRHeXZHhD7s5OglItSd/TpiqRps4Fs5ZQ7ZDVwIJ1Gu9d9u
 nRU2HgPQgDrAuIeHFaQDdViiboWt2g3H5MzSd39g66n1DP5hGGRrYJfE07CEVgAT1G
 3cJsfzw4sSRzKMWMxVVqCuCm6He/2KNumU885N2A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260624072303epcas5p4986c5350b4fc8c415b99dea6d3edeaad~783oPoHT80772007720epcas5p4u;
 Wed, 24 Jun 2026 07:23:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4glYLb0fVNz6B9m7; Wed, 24 Jun
 2026 07:23:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500~78w7XEGjh3274332743epcas5p2b;
 Wed, 24 Jun 2026 07:15:22 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260624071519epsmtip15f129b67667b670f0ad884ee1fbec427~78w4wroEL1366013660epsmtip1K;
 Wed, 24 Jun 2026 07:15:19 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:34:27 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder registers
Message-ID: <81412691.21782285783075.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-1-junjie.cao@intel.com>
X-CMS-MailID: 20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-6-shrihari.s@samsung.com>
 <20260617154521.520191-1-junjie.cao@intel.com>
 <CGME20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=shrihari.s@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 08:09:17 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:33 +0530, Shrihari E S wrote:
>> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>> -                     UIO_DECODER_COUNT, 0);
>> +                     UIO_DECODER_COUNT,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
>> +                     decoder_count : 0);
>
>CXL2_UPSTREAM_PORT is an enum constant with a non-zero value, so
>"|| CXL2_UPSTREAM_PORT" is always true and the type check collapses
>to just "uio" -- every type that reaches hdm_init_common() with
>uio=true gets the UIO bit set.  Presumably the intent was:
>
>    (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT) && uio
>
>I haven't proposed which types should be in that set -- patch 7 sets
>crp->uio_capable on the cxl-rp, so a root port may well be intended
>here too.  Either way the current expression isn't gating on type.
>The same applies to the UIO_DECODER_COUNT line just below.
>
>Many thanks,
>Junjie

Hi Junjie,

   Thanks for pointing out. Will rectify it in the next version of the patch.

Thanks,

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_--


