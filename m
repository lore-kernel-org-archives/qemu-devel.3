Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2F6CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 05:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssyTD-0007BW-12; Tue, 24 Sep 2024 01:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssyTB-0007B2-QR
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:52:17 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssyT9-0002mH-LT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:52:17 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D18AC13802C5;
 Tue, 24 Sep 2024 01:52:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 24 Sep 2024 01:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727157133; x=
 1727243533; bh=eI9ro2mKoJNPQv96D4OI51cnTwOq2/8QSKG/Co3T0z4=; b=L
 JUct/CjeW/u/gRQ7PLkFN4A9rtJ1yxWGMfMyBF8QkqesF6Qz7ojNwbM3xtue1pSV
 nt9C9Aj5htKmwtOTZPli0t3e46GciR/aYtP9gSBUDVAQh1Yb/eUcOK9zle+cF0i6
 CqfTEq4hff8pAVyDLCWEXys4IY2zSuaYW+LoMA8Us6lbh4GFflm747RuZMjqaIkh
 9Bk0/gU2fNI0OJqGnEkOx4vcChbAyc1lZJ/YQXL8IhTnaxx6dmBUgdwM9GXU+evs
 y+/Z5WvzVQhacyy0aw5oSNTbievsAzQoiBNsG6WEsRc7mIIe0w21QDHAF62XFto6
 2OsB0SpplxOAXAjCXtIfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727157133; x=1727243533; bh=eI9ro2mKoJNPQv96D4OI51cnTwOq
 2/8QSKG/Co3T0z4=; b=IXtvNp1Oz/IQePttriUEVjxJB4D/P3bQXDMaq9RzzzkZ
 7dFY6FHmxr13r3sFWxhrzJ0wxvzCyQ6QhOKbVJ2gV5kzvJucfWYUZzzlz+ZOcZM9
 pd3/dNZemncOd7hLrJK+Z0KQXZFiFXLCK2vEszs/o33P2pEj0K86ZvXMTEhb4Z4D
 m3KL+NWbgnlrzqbgjD6JhHRo3HmBYCM+qFZZDfj89m6KL5b49uirZ91SaqjwwpgM
 g+WNcbCzE56bvKYTXgNa3nMo2WGTyYX0p8H7FL9WWCMnOaxyR4LWWs2JItCllhim
 QEPGgyoCci0RXv44FxZ7xbg0IRSu6/B4QWERLAKPAA==
X-ME-Sender: <xms:jFPyZsPpU60bd94Ocb286xi3pgbajJuDOKEqTcp8HmQOsd9SMgM1xg>
 <xme:jFPyZi_WeRJhVWSq9qNXaJ3QY6HTnM2sRgSrEWwWv0Fp9b83yZb07QJkVWgkuCu0U
 v2iS-9agKbLl-ZfKb8>
X-ME-Received: <xmr:jFPyZjTEAoGKQLEksyTboOGk6zlSnEsJeGxhwOcQja2qHMsmXzRR-YOHQEaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepveejtdejteevfefhffehiedvffdvudelvdeigfek
 feevledtieetffehgeeggfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgihuhhshhdrmhehheessh
 grmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
 hopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehithhssehirhhrvghl
 vghvrghnthdrughk
X-ME-Proxy: <xmx:jFPyZkuuR6dpMxUvq1SAhM7o0g11Y48j7yBbwoAKQDOlX8uPhsFjCA>
 <xmx:jFPyZkdchJOLEPrUs1vXevSg6HnSYMR-nbTktnso2tuXHfLEQhjzhQ>
 <xmx:jFPyZo2wnd5R6Kl5FwpXAD_DVX5FRocHhjAjZyg07cXGgRnWOUX-vA>
 <xmx:jFPyZo9rXPA8zJYoRix9W3ByNirCNSk4p8Zo3D1yr75E0rYpZW8_UA>
 <xmx:jVPyZpG9VMQkFLIdW2ZsXr2RGzNUZFLOGR_bJtM6WwafsoIjrUGcXWKV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:52:12 -0400 (EDT)
Date: Tue, 24 Sep 2024 07:52:10 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ayush Mishra <ayush.m55@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: Adding support for NPDAL and NPDGL
Message-ID: <ZvJTioFwLD0jf1lT@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240923115650epcas5p4750a5c44184b2439d7dc012e950db99e@epcas5p4.samsung.com>
 <20240923062651.3511358-1-ayush.m55@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923062651.3511358-1-ayush.m55@samsung.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
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

On Sep 23 11:56, Ayush Mishra wrote:
> Adding support for new 32 bit NPDGL and NPDAL fields to address the
> needs of larger granularities.
> 
> Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
> ---
>  hw/nvme/ns.c         | 5 ++++-
>  include/block/nvme.h | 7 ++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..8b2ea37a1b 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -30,6 +30,7 @@
>  void nvme_ns_init_format(NvmeNamespace *ns)
>  {
>      NvmeIdNs *id_ns = &ns->id_ns;
> +    NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
>      BlockDriverInfo bdi;
>      int npdg, ret;
>      int64_t nlbas;
> @@ -55,6 +56,8 @@ void nvme_ns_init_format(NvmeNamespace *ns)
>      }
>  
>      id_ns->npda = id_ns->npdg = npdg - 1;
> +    id_ns_nvm->npdal = npdg;
> +    id_ns_nvm->npdgl = npdg;
>  }
>  
>  static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
> @@ -72,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      ns->id_ns.dlfeat = 0x1;
>  
>      /* support DULBE and I/O optimization fields */
> -    id_ns->nsfeat |= (0x4 | 0x10);
> +    id_ns->nsfeat |= (0x4 | 0x30);

This is a good opportunity to add some defines in include/block/nvme.h
for these spec values.

>  
>      if (ns->params.shared) {
>          id_ns->nmic |= NVME_NMIC_NS_SHARED;
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 5298bc4a28..fdf3d999c0 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1413,7 +1413,12 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
>      uint8_t     pic;
>      uint8_t     rsvd9[3];
>      uint32_t    elbaf[NVME_MAX_NLBAF];
> -    uint8_t     rsvd268[3828];
> +    uint32_t    npdgl;
> +    uint32_t    nprg;
> +    uint32_t    npra;
> +    uint32_t    nors;
> +    uint32_t    npdal;
> +    uint8_t     rsvd288[3808];
>  } NvmeIdNsNvm;
>  
>  typedef struct QEMU_PACKED NvmeIdNsDescr {
> -- 
> 2.43.0
> 
> 

