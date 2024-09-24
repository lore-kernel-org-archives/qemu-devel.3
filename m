Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFB5CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 05:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssyZu-0003Ht-RG; Tue, 24 Sep 2024 01:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssyZt-0003HK-Bx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:59:13 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssyZr-0003M6-Nx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 01:59:13 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ADF89114022F;
 Tue, 24 Sep 2024 01:59:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Tue, 24 Sep 2024 01:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727157550; x=
 1727243950; bh=Ec2oowZ6rd9S8fFAe2a4ygdDPBkyHaKdasP7RFTO2Z8=; b=e
 JpsOjzuC31mc/wyjdEw9Eoj41o/E0ZIgwRegb7y/TRhDeUuAWupBVSA9LZBnoZp5
 k0DVlXES5/j1TIIi13NuUbY9SWW4Vj9yhffpFlrFJKDFaCF59/ZE7wCNPxEIJ58F
 YxzXlw6inrzekrFRnM65efMoW8bRSVX/Y9TxcrphvlqMlP8XkeFpp+EjxDSYzAVJ
 ak60wsaR06PO+bZYFFxPpDR9hBjAVOLsuRGPuHS/TEKH6x/4OF/TWpBbWdZPNjwg
 wFww+lgDsHzTQgKX71mXf4Bygj4fpjgzM6Ut/SUHs/MY6bmO2MTyYoeoS0uZR6xZ
 Noj38T+FMV5SyN8u6yu2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727157550; x=1727243950; bh=Ec2oowZ6rd9S8fFAe2a4ygdDPBky
 HaKdasP7RFTO2Z8=; b=FMKiTZuVQS+qpTbcB0l3wk+MvJs/7fxSZix/ChcDWSv7
 K01PJFPZkIhD3AiUcYnKiFr7jXSdS9yGcjA0p0ZSKrpmMhkXsnYUDjuTqw3BN0S0
 eslTjUJHRMAYyjcwqP6VyKuvh4AhilGNC7Mt/2qxF7xfKjDESWCtuLjjXEPfKpr9
 QtP0gda9I/O/sV8GpYkBhGgbg1d9QvrbUyqSwzsorLx3kQXk2F8wHKXxDk32SZOX
 oRKwPoxqsht8eI/GuJjwoq8S2cQGr7jXggxk8Z4urCvUKUaHvYh3OUwUbA4X6OX/
 mhETU8Q+4o3wem4U8ZhK1b9nbYBS5BAlfKsErMRoDw==
X-ME-Sender: <xms:LlXyZuy6SqRgS9Q4GTXD3VTqXq6VqGPTlfSwmKtFwFB-luzUSCdUtg>
 <xme:LlXyZqS6R1nW6Frk5useG8MfD_s8SRUJU_v0fhbWzbSsyaEC0W8bQjMEpQbDD2EVr
 956c_0N9AMYByvETjQ>
X-ME-Received: <xmr:LlXyZgUoyrOMX-QnlcEUV8qh7JyU4oNFnkMT0YBzwmrDzRDZ4VEzqK7oF0S16g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
 fukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcu
 oehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeevjedtje
 etveefhfffheeivdffvdduledviefgkeefveeltdeiteffheeggefgudenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvg
 hvrghnthdrughkpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprh
 gtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehi
 thhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:LlXyZkj0hqzYBGzuV2H8nTVRV0ivHKGXn3i-AkHERsWP9dAFjLf0_g>
 <xmx:LlXyZgB3kpPPa8M_VjZHLwGkL2sp9tiuVsSeduuCyv0S4XgFvDCokw>
 <xmx:LlXyZlJHLaHNiCF7OaZbbO33FqFSUWRli3uIcAexCv1XA6nwEtHYQw>
 <xmx:LlXyZnCbkJxrQq3qLdhtN4MtB8ByY2w_qSdmKiUFEMLYOSlBUU1euA>
 <xmx:LlXyZi2zzCqok9JqhzNYGOHEJdluEMmfI6fZ5lrgVOMAmd882G4m5fuk>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:59:09 -0400 (EDT)
Date: Tue, 24 Sep 2024 07:59:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: i/o cmd set independent namespace data structure
Message-ID: <ZvJVLF9ZBCLFAlTW@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240920055116epcas5p248fe98a4d8d9de8eddfaa4cfe85b4424@epcas5p2.samsung.com>
 <20240920002116.3494712-1-arun.kka@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920002116.3494712-1-arun.kka@samsung.com>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
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

On Sep 20 05:51, Arun Kumar wrote:
> add support for i/o command set independent namespace data
> structure(cns=8h and cns=1fh)
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Arun Kumar <arun.kka@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 37 +++++++++++++++++++++++++++++++++++++
>  hw/nvme/trace-events |  1 +
>  include/block/nvme.h | 17 +++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..73af48591d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -5498,6 +5498,39 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
>      return nvme_c2h(n, (uint8_t *)&list, sizeof(list), req);
>  }
>  
> +static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, NvmeRequest *req, bool alloc)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    NvmeIdNsIndependent id;
> +
> +    trace_pci_nvme_identify_ns_ind(nsid);
> +
> +    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns = nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        if (alloc) {
> +            ns = nvme_subsys_ns(n->subsys, nsid);
> +            if (!ns) {
> +                return nvme_rpt_empty_id_struct(n, req);
> +            }
> +        } else {
> +            return nvme_rpt_empty_id_struct(n, req);
> +        }
> +    }
> +
> +    id = (NvmeIdNsIndependent) {
> +        .nmic = ns->params.shared ? NVME_NMIC_NS_SHARED : 0x0,
> +        .nstat = 0x1,

Since the NSTAT and NMIC fields recently got some acronyms for the bits,
something like

  enum NvmeIdNsInd {
      NVME_ID_NS_IND_NMIC_SHRNS = 0x1,
      NVME_ID_NS_IND_NSTAT_NRDY = 0x1,
  };

would be nice to add to include/block/nvme.h and use here.

