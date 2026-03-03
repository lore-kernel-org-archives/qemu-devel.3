Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF8EB3650
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFNR-0003TW-HE; Mon, 02 Mar 2026 21:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFNM-0003So-24
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:20:44 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFNK-0007p3-GK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:20:43 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B304114001F8;
 Mon,  2 Mar 2026 21:20:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 21:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1772504441; x=1772590841; bh=g8wAwSCubEFFgWCrIIeXQ5Gm2oGb4EHL
 63vl8YhGIk8=; b=SU6OW2duLp2HNAw7iBOUcMln/fnr+jHe4TP1OvSfxUcIgewT
 4Fj1XlQHbrQY/zdtPZtYViVqzEZZrUjukxr8izfJ2/VZ8J8j+Lm5qFTS8kw5c0F8
 lMggTtpf2fdmAgY+D6ASt2KXpTZ3E730I8C608xeaefQDzsCPJKOmzNoancefA6G
 2h3Aj8eNe6syN8Fi8jC0q9ZmPwpVZDAS0oQS1dRP3IhmswA1xcQlXL6GPzZG2SoQ
 R5+qtZxmfjuX2RRVze1snEu1RfIZ+zytzl+mQNwdFcB/NBG2MObMMZTi1RXsPsOl
 m6osb+RVFvR55gZmVouQnvaCMbFLnb8x8HCGkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772504441; x=
 1772590841; bh=g8wAwSCubEFFgWCrIIeXQ5Gm2oGb4EHL63vl8YhGIk8=; b=u
 TUMMcnK++6n5rdjiWRWaCz/rKMnXUitMz8fjFLoKZtfIsotwfsWZWv0GwRbg5U8A
 OCHa3zWmOt0CAzrd/F/qMURvtKXXOwbnRIcMit/SVjakJ6JXDL4xTXHEbQjUfDCk
 4nAqc7UCYuHwf/TVM6mgalRGnxDQOh85VCjMrm+Sq6djXJqhgA1rEno4z5yTV4gB
 Q8tYbMiSBpAWebb9zaH/hnQtajlwTI+V2cfPheGYLBgy7aPWMMYooidTJ7tI8wH3
 MtONYF0hOcvdIUuhebjJZZMHNjM2Y1wrnYbKYKNc5JGCK3obgV1WhVxU7Fy/Q81I
 mZKx2l8l3IlrhqdneCuPA==
X-ME-Sender: <xms:eUWmaQAG8qNsjIyNSrK7CYFp7sJwhMorZdUwU-mEfUVZx2ltVuodPQ>
 <xme:eUWmaZZ0neL5GFZIJZ6BDHZORTEGyt2UJiL1o0JWL6xGD44bX-XuqPg3bQoVmqudx
 BBHJStnoxY0mHUgrqClnI6J_NLAM1gnQsxcVHnJ1uSCNVAjWx3VfSo>
X-ME-Received: <xmr:eUWmab76IyU938O4VyDJemlXpuoMu1DUQ3QAiGKGZndd47rHSpwKfUnO8SPP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelfeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhr
 vggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsg
 hmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:eUWmaSahYZSjuQjojXo6Fvh2_U_EMkWoqn8-c4xWcqBSZHzJVCTJbA>
 <xmx:eUWmaSh-d5w5DBnY4ufkqtNKAOUqf3tiktB2W0AV37iAV1YcSCxgJA>
 <xmx:eUWmab8AFfu5gm0JD0LTD1kyX8dvkSLKYmfkBxwJAyDwCvCWf6CF-g>
 <xmx:eUWmaVoz6m6rmxQZiTMor7wAF-9IpP8nIfSamQqyH32Ssc6NsFH5RQ>
 <xmx:eUWmaU0ruBFr0_Np9TyWizWvGR9WuVtk8MBIR1ZZQWPghHdoRSd9vNax>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:20:40 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 35ceee6d;
 Tue, 3 Mar 2026 02:20:39 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 21:20:39 -0500
Message-Id: <DGSSDUHO9BGF.88ZFRUYS9ZVP@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v10 17/17] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260302180447.1078098-1-chad@jablonski.xyz>
 <20260302180447.1078098-18-chad@jablonski.xyz>
 <681a858e-1e35-aa8c-ecf9-b791438aaac5@eik.bme.hu>
In-Reply-To: <681a858e-1e35-aa8c-ecf9-b791438aaac5@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>> +    /* Copy and then modify blit ctx for use in a chunked blit */
>> +    chunk =3D ctx;
>> +    chunk.src_bits =3D pix_buf;
>> +    chunk.src.y =3D 0;
>> +    chunk.src_stride =3D ATI_HOST_DATA_ACC_BITS * bypp;
>> +
>> +    /* Blit one scanline chunk at a time */
>> +    row =3D s->host_data.row;
>> +    col =3D s->host_data.col;
>> +    idx =3D 0;
>> +    DPRINTF("blt %dpx @ row: %d, col: %d\n", pix_count, row, col);
>> +    while (idx < pix_count && row < ctx.dst.height) {
>> +        unsigned pix_in_scanline =3D MIN(pix_count - idx,
>> +                                       ctx.dst.width - col);
>> +        chunk.src.x =3D idx;
>> +        /* Build a rect for this scanline chunk */
>> +        chunk.dst.x =3D ctx.dst.x + col;
>> +        chunk.dst.y =3D ctx.dst.y + row;
>> +        chunk.dst.width =3D pix_in_scanline;
>> +        chunk.dst.height =3D 1;
>> +        DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
>> +                pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
>> +        if (ati_2d_do_blt(&chunk, s->use_pixman)) {
>> +            ati_set_dirty(&s->vga, &chunk);
>> +        }
>> +        idx +=3D pix_in_scanline;
>> +        col +=3D pix_in_scanline;
>> +        if (col >=3D ctx.dst.width) {
>> +            col =3D 0;
>> +            row +=3D 1;
>> +        }
>> +    }
>
> This looks a bit complex. I wonder if this would be simpler as two=20
> nested loops over rows and then cols but I can live with this for now too=
.
>

I gave nested loops a shot on this but my attempt didn't turn out any simpl=
er,
sadly. I think it may not fit well here in that we don't necessarily get fu=
ll
rows and so we always have to be tracking the number of pixels written so t=
hat
we can end early when we run out of data. So the inner column loop ends up
having to do all of this bookeeping anyway.

