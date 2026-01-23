Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D758D6CFD1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGVr-0000PA-Qm; Fri, 23 Jan 2026 07:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vjGVn-0000Ni-JY
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:43:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vjGVj-0002s1-LX
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:43:39 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260123123401epoutp041d40ae2194ee5484a5bb4e5bd76b7f9c~NXDvtaxP72002120021epoutp04s
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 12:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260123123401epoutp041d40ae2194ee5484a5bb4e5bd76b7f9c~NXDvtaxP72002120021epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1769171641;
 bh=NV/c+++0Y5HoTXbtx6ZE/X3FoyhoT4mrud5skyghaTU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Oa1dHAFn7woe3trnZjr9jPOMnDsxHZmXpwl4fkQPJWMgCS+h1T0mkmmx2GEyrTTkc
 3Q92p7Bcx496SRrboVA3VmHhcjuHi6iKQFYf/+iqDrowiF6Q0n3PqMWn+Bx5/60KC4
 3ATtDWGofNoGhUivTjsk6WXMPqfKtRdc2Waiuxn4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260123123400epcas5p23eb831bb5e0e940d25e09526038c4681~NXDvdxioz2482124821epcas5p2D;
 Fri, 23 Jan 2026 12:34:00 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dyHRW62jLz6B9m5; Fri, 23 Jan
 2026 12:33:59 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260123123359epcas5p157278863fa71ee0fa261a925eac274eb~NXDt2XHBM2972229722epcas5p1n;
 Fri, 23 Jan 2026 12:33:59 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260123123357epsmtip1c8b4fdb3ae4bb58917c395a2442ca0a5~NXDsxgCDE2183521835epsmtip1i;
 Fri, 23 Jan 2026 12:33:57 +0000 (GMT)
Date: Fri, 23 Jan 2026 18:01:11 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 vishwa.mg@samsung.com, y.kaushal@samsung.com, ashish.anand202@gmail.com
Subject: Re: target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <z346m63rsuvrwlpa4nnujnlap7y3t3e2pmgpezeglaalf27spb@4pevbudmsxst>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-DBkPbb_47vqeOhtPrdHq5dOkbtBmQgVRj8aBP1kyhQ@mail.gmail.com>
X-CMS-MailID: 20260123123359epcas5p157278863fa71ee0fa261a925eac274eb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11ef4e_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f
References: <CGME20260121132716epcas5p1cab4021fbcd469b95d13ef4b4adc757f@epcas5p1.samsung.com>
 <20260121132421.2220928-1-ashish.a6@samsung.com>
 <CAFEAcA_-DBkPbb_47vqeOhtPrdHq5dOkbtBmQgVRj8aBP1kyhQ@mail.gmail.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ashish.a6@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11ef4e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>
>You already have the VecInfo pointer at all the callsites,
>so I think it would be better to pass it to this function
>rather than recalculating it from the irq number etc.
>
>I agree with Alex about using a bool for the event_register
>struct field.
>
>Otherwise I think this looks good!
>
>thanks
>-- PMM
>

Hi Peter,

Thanks for the review and feedback!

Quick clarification on the nvic_update_pending_state() refactoring:

I've changed the signature from -
     nvic_update_pending_state(s, irq, secure, value)
to -
     nvic_update_pending_state(s, vec, irq, scr_bank, value)

This removes the internal vec/scr_bank calculation.  
Callsites now calculate both vec (already present) and scr_bank before the call.
Example(at callsite) -

     if (banked && secure) {
         vec = &s->sec_vectors[irq];
         scr_bank = M_REG_S;
     } else {
         vec = &s->vectors[irq];
         scr_bank = M_REG_NS;
     }
     
     nvic_update_pending_state(s, vec, irq, scr_bank, 1);

In some places like nvic_writel() case 0xd24, where we're in a known 
attrs.secure context with specific exceptions, I hardcode the scr_bank 
value (M_REG_S or M_REG_NS) directly.

Is this the approach you had in mind?

Thanks,
Ashish


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11ef4e_
Content-Type: text/plain; charset="utf-8"


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11ef4e_--

