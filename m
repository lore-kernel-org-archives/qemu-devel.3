Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F89CC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XIg-00042j-Ny; Thu, 03 Apr 2025 23:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1u0XIe-00042S-AW; Thu, 03 Apr 2025 23:00:56 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1u0XIc-0007uL-2S; Thu, 03 Apr 2025 23:00:56 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id A36781380313;
 Thu,  3 Apr 2025 23:00:48 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
 by phl-compute-10.internal (MEProxy); Thu, 03 Apr 2025 23:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1743735648;
 x=1743822048; bh=gZcrbTD0T3tHxBcdnUQFYI78WED0Sfi5eHy1PIJaBAs=; b=
 XMNyo73SG0V6wYmFtFNQLYDQaNNmQNmhr/YTiE6xUDMawrIM1wmOuf3alrTItfUo
 uWD0l1LvcpVx5NVqeQaz+d8Wv3waRUBPicWNI/fE897O4w3BH1M4RdnmymWJXNTc
 x4RZNy4cN6zh0gwYztaU1NiIilgpBTeSluegWi0WsXloEFPruOh5ziVaoTR5DkiF
 2+FDEWvl/zYuA9szNXgFrqzXOF9O+/+ra/dSauQSwYZ03z1Z7b4gUnOrCbDAAY2q
 ZxvWmtGuRKiVyh+Nz/D8NeXBZC8SHLYRyG8xyPJmAKfdlKapmvDKX9mLXq4ckdID
 A1/c+N8DWWRzdxw4lb6/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743735648; x=
 1743822048; bh=gZcrbTD0T3tHxBcdnUQFYI78WED0Sfi5eHy1PIJaBAs=; b=X
 o7yFRG06hDRpS1sYoRtvXZIszRNk2CKaoOsW57hKd4dv6sUxgMYi1Q67vpQXa7AQ
 oKaH3gI0RAQuNOOHczaF3Qn2uO9/gr06XHbelDYbTKbZq/VTRprtqMO1gDY23Z0k
 GpZmWoLTp5oJHScggCSk7sy/PrU1ij8m0XNdBjgQWmFkKrgEV3s1v/PmrF1HwPqr
 5yQ02XVh1bYY77/sG3kx05D1aL5AKDMG+IkyaJlp9cuTtVUIW36SUAW7nIQu/Noa
 xyR2wIn8ttEgAEFuX/VVX9W6EeDYl+puizLhybWdYYpS5D8gwvzjxdPbY4RfDARq
 wS/vrt/1S7nVBpvuzokSg==
X-ME-Sender: <xms:XkvvZ4m_XWjokrNxCp3Mcn7DeHsNUFZcjqjmTon5Hvt5XFbJXYVTWw>
 <xme:XkvvZ32_QVI82qjjasEuSpHH_uhppD2OFDg6cP_T0YXtLoM9oqkD70dQ9-I8U5kdc
 Chot0D1V7RUdvNESvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtfedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
 tddtnecuhfhrohhmpedftehlvgigvgihucfmrghruggrshhhvghvshhkihihfdcuoegrih
 hksehoiihlrggsshdrrhhuqeenucggtffrrghtthgvrhhnpeefvdeikeegkeeiieevleeh
 feejgfetveetvddvhfeuleeuhfduieelieelieehieenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrihhksehoiihlrggsshdrrhhupdhnsggp
 rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtoh
 hnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegurghnihgvlhhhsgegudefsehgmhgr
 ihhlrdgtohhmpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtph
 htthhopehhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepqhgv
 mhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqphhptg
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:X0vvZ2oupfyXuNPmLY7cDV9pg71IBN2oe8L80ZtwywEC_gxLJWoBRA>
 <xmx:X0vvZ0lro_SuFDLvesM-lnR5DvLaJh8difffsBihQPgsmFly7D6PlA>
 <xmx:X0vvZ20IiG3bcPXi8KKlduHXnqdMl2sngWSb1rNP5IL32faR80ShAg>
 <xmx:X0vvZ7sg4KUCE0DLi09IFeK2tJq65ovPjwn2wLBI2DSAAvNOA3mrmg>
 <xmx:YEvvZyg3HGL0Xlr5_2kqwS7bk39Zgg9f08wyFVLyYOKCGAL-YazRKVf->
Feedback-ID: i6e394913:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E3A571F00073; Thu,  3 Apr 2025 23:00:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tc8f811213d1a6613
Date: Fri, 04 Apr 2025 14:00:26 +1100
From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Nicholas Piggin" <npiggin@gmail.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Message-Id: <d8d883c3-afcd-44bd-aa71-6ca23d1dd9c3@app.fastmail.com>
In-Reply-To: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
References: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
Subject: Re: [PATCH v2] ppc/vof: Make nextprop behave more like Open Firmware
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=aik@ozlabs.ru;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



On Tue, 1 Apr 2025, at 01:26, BALATON Zoltan wrote:
> The FDT does not normally store name properties but reconstructs it
> from path but each node in Open Firmware should at least have this
> property. This is correctly handled in getprop but nextprop should
> also return it even if not present as a property. This patch fixes
> that and also skips phandle which does not appear in Open Firmware
> and only added for internal use by VOF.
> 
> Explicit name properties are still allowed because they are needed
> e.g. on the root node that guests expect to have specific names as
> seen on real machines instead of being empty so sometimes the node
> name may need to be overriden.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> I've tested this with pegasos2 but don't know how to test spapr.
> v2:
> Fixed a typo in commit message
> Simplified loop to get next property name
> 
> hw/ppc/vof.c | 51 ++++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 09cb77de93..790d67c096 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -353,34 +353,51 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
> {
>      int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
>      char prev[OF_PROPNAME_LEN_MAX + 1];
> -    const char *tmp;
> +    const char *tmp = NULL;
> +    bool match = false;
>  
>      if (readstr(prevaddr, prev, sizeof(prev))) {
>          return PROM_ERROR;
>      }
> -
> -    fdt_for_each_property_offset(offset, fdt, nodeoff) {
> -        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> -            return 0;
> +    /*
> +     * "name" may or may not be present in fdt but we should still return it.

yeah we should, at least, to match "getprop". I also wonder if VOF does not add "name", then what would do so, do we really expect to see such properties anywhere? Because if not, then we do not need to skip it as we won't find it.

> +     * Do that first and then skip it if seen later. Also skip phandle which is

(a nit) appears to me that if handling of a missing "name" was done after the last property, the patch would look simpler, but not sure and do not insist.

> +     * an internal value we added in vof_build_dt but should not appear here.

I would not hide anything though, unless it breaks something. Thanks,

> +     */
> +    if (prev[0] == '\0') {
> +        tmp = "name";
> +    } else {
> +        if (strcmp(prev, "name") == 0) {
> +            prev[0] = '\0';
>          }
> -        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
> -            if (prev[0] != '\0') {
> -                offset = fdt_next_property_offset(fdt, offset);
> -                if (offset < 0) {
> -                    return 0;
> -                }
> -            }
> +        fdt_for_each_property_offset(offset, fdt, nodeoff) {
>              if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
>                  return 0;
>              }
> -
> -            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> -                return PROM_ERROR;
> +            if (strcmp(tmp, "name") == 0 || strcmp(tmp, "phandle") == 0) {
> +                continue;
> +            }
> +            if (match) {
> +                break;
>              }
> -            return 1;
> +            if (strcmp(prev, tmp) == 0) {
> +                match = true;
> +                continue;
> +            }
> +            if (prev[0] == '\0') {
> +                break;
> +            }
> +        }
> +        if (offset < 0) {
> +            return 0;
>          }
>      }
> -
> +    if (tmp) {
> +        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> +            return PROM_ERROR;
> +        }
> +        return 1;
> +    }
>      return 0;
> }
>  
> -- 
> 2.41.3
> 
> 

