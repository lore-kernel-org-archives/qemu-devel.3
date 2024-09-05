Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C2CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smA5V-00051W-75; Thu, 05 Sep 2024 06:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1smA5S-00050P-M7; Thu, 05 Sep 2024 06:51:39 -0400
Received: from fhigh6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1smA5P-0004MO-Tb; Thu, 05 Sep 2024 06:51:38 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7B0F41140264;
 Thu,  5 Sep 2024 06:51:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1725533492; x=
 1725619892; bh=uWKtHDer+es6lWlPEMo6JoZv96ivRF1hBZProol2ork=; b=t
 TDam6Jkvp0uEK55Ss2AV41nmVC3Ak7KrG5ykS6h98vOrAyrLkl6fL3ntw68SOikJ
 OGUj1HgrAVfT6HK1hc/uk9U2B8v0FIMO7zXF8MixRh8oMZd5Tc9X5658r8c700nd
 o2GQyFkiM0TvS1pzsgSwe+IpB7jiWENJydZfxIBP4fXLkN7/g3EItcbquLJFwv7M
 AeNQIHG7hLMGcVmhLO1M6D7HEdYLSgWfbX7SqgUTVW6ElnzPMat2G6yiaoQi8KHh
 EGJ3HIRlvid4yXxO6g9x3A60XfAJY7Xln2ibHwh/pyJLhJeaOVJB3kmc78Xw0ETj
 A4SYq/0Sdq31tiZJoc/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1725533492; x=1725619892; bh=uWKtHDer+es6lWlPEMo6JoZv96iv
 RF1hBZProol2ork=; b=m4dRRC7M9CDYMRRhXYoMRKrFdi3EyuvkFUbIURO62R3A
 WN5c9BHdOrhJBJ8fzct/tJrQ0EMpZr99t3hC5y7mbCFsa66cvaZml+QhD7HCJBUZ
 61iatk6vt3im6r9nW3WYvUtekFC5gNbtfhWeFgGaP3qz3NGLUirveQREPtgmoNlz
 wEkMULxWKaPP5UsYkxPlCRz7BOSrJu3+gqaAUFkYldD6zQl7knYlMrDyK61AZPTN
 rT8WLfxq9O3IiN83Q2EGEWQunRasRSUPJOJIiZpLaHo2+PEIFovJHwnmFsMbNDjh
 8+ioQ1weZbN39iDkdkfGfUoBDHQtcI44ghg0LYvmLw==
X-ME-Sender: <xms:M43ZZnlBFD-7Q0fqBBZnAVxA4NitomxlmwPRnpOtsPtz0PT2KVNJmA>
 <xme:M43ZZq2y9J8hp8iNcZ-KSnhlII18f8x4fx-EWHLyzBfV-ctP8J3ubrL8Qvcf-v4JR
 xzAwbfFvC-6SQDEqlI>
X-ME-Received: <xmr:M43ZZtrZk6gXsRgl2W-9fBLfco1LSW8foq1Lex6yGY58KqmbRYzw0XKbtnD7_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepveejtdejteevfefhffehiedvffdvudelvdeigfek
 feevledtieetffehgeeggfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgthhgrnhhgqhhird
 duvdefsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotghk
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnh
 hurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohephhhrvghithiisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgvfhgrnhhhrg
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhr
 tghpthhtoheprhhonhhnihgvshgrhhhlsggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpth
 htohepphgsohhniihinhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:M43ZZvkJicIk1Lm2NWCqKdJkLzoIc_-ivgskfY0v67M8iL1Mznl25w>
 <xmx:M43ZZl25Hk82lX0f0O08iQsbbm8S7aHTSE_xkLQhRCGDgZjMh4_jmw>
 <xmx:M43ZZusWQVPf8D2iPxbsYCkHb1GWLGWhbD8wk7mGNZ_qG8UF_aH8sw>
 <xmx:M43ZZpV1j0r0K69Y70wQkOEqNdAbOXNZch8pcE62rjCpv34hcBfj6Q>
 <xmx:NI3ZZmFRw3XtNVYvkkx-S5Fo2wFNN_Asn8qSN7o_KnS07pKB2w9hXkKr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:51:30 -0400 (EDT)
Date: Thu, 5 Sep 2024 12:51:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v10 09/10] hw/nvme: add reservation protocal command
Message-ID: <ZtmNMeCwomjvXY0i@AALNPWKJENSEN.aal.scsc.local>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
 <20240829084214.50548-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829084214.50548-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.157; envelope-from=its@irrelevant.dk;
 helo=fhigh6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Aug 29 16:42, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
> 
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
> 
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 330 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 +++++
>  3 files changed, 371 insertions(+)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad212de723..1f8a5659c9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1747,6 +1755,13 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_READ:
>          status = NVME_UNRECOVERED_READ;
>          break;
> +    case NVME_CMD_RESV_REPORT:
> +        if (ret == -ENOTSUP) {
> +            status = NVME_INVALID_OPCODE;
> +        } else {
> +            status = NVME_UNRECOVERED_READ;
> +        }
> +        break;
>      case NVME_CMD_FLUSH:
>      case NVME_CMD_WRITE:
>      case NVME_CMD_WRITE_ZEROES:
> @@ -1754,6 +1769,15 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
>      case NVME_CMD_COPY:
>          status = NVME_WRITE_FAULT;
>          break;
> +    case NVME_CMD_RESV_REGISTER:
> +    case NVME_CMD_RESV_ACQUIRE:
> +    case NVME_CMD_RESV_RELEASE:
> +        if (ret == -ENOTSUP) {
> +            status = NVME_INVALID_OPCODE;
> +        } else {
> +            status = NVME_WRITE_FAULT;
> +        }
> +        break;
>      default:
>          status = NVME_INTERNAL_DEV_ERROR;
>          break;

This wasn't exactly what I had in mind ;) See below.

> @@ -2692,6 +2716,304 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
>      return NVME_NO_COMPLETE;
>  }
>  
> +typedef struct NvmeKeyInfo {
> +    uint64_t cr_key;
> +    uint64_t nr_key;
> +} NvmeKeyInfo;
> +
> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns = req->ns;
> +    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
> +    bool ignore_key = cdw10 >> 3 & 0x1;
> +    uint8_t action = cdw10 & 0x7;
> +    uint8_t ptpl = cdw10 >> 30 & 0x3;
> +    bool aptpl;
> +

Here, check ns->id_ns.rescap for reservations support and return
NVME_INVALID_OPCODE. There is no need to call the block layer otherwise.

Same for the below commands.

