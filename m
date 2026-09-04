Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094D7C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bzb-0005Q7-7K; Fri, 04 Sep 2026 18:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzS-0005O4-MR; Fri, 04 Sep 2026 18:02:31 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2byv-0005WD-3k; Fri, 04 Sep 2026 18:02:30 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 40D4B140013C;
 Fri,  4 Sep 2026 17:58:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 17:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559099; x=1788645499; bh=sYofxPuQAf
 //7sGsgUf//gkDL0teBIdTMDEaM7XQ1Ro=; b=FjHOMRAFeHEPu1GfNPv684h+x6
 7+AvQAX/Kae9HoLRLZ5tpwfSDtwzCY/clUGbecbhNr0O1943yaoIXU0I8lTN09sM
 bfIKD/DyJa9s8mYS1pgHm8/CPL+houyTVbPmaNrHJMde8KJusHXxYL+UqIDHXICP
 P7g98FoMVvRnp8Fip0OC/CvCsCDUjbDNXIHgoUaFoOmElvn4SSA0R5kjkcxQLmCY
 oIuI7XPKfXM+SLahsZsw4REwP8RJZbFLhwU1Eau2lE/ZPpWF8Hlb2h43e1GTx368
 r97HUd01KxAF5JriaQhHdIX7t54AMqOohJACOZjp4b1cjcohy/EoKz32RH2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559099; x=1788645499; bh=sYofxPuQAf//7sGsgUf//gkDL0teBIdTMDE
 aM7XQ1Ro=; b=XRvWxXj5/6GiL9Tdfff+oJ7E9y1cZjmuy9kEwbmhF8ZUiauOyaW
 V/mGJ/wB8EeFeWsZBqfwnqham1RopFtzGcQcaMjPOqRxp5XkcO6a8P5NEh4vS+Ja
 0uGsHx8hxlbXuCdwnlbolNpQay8YDo/oZNzrDXtvwKcavAi91IKs+tJklUYk8sKO
 UI9MhbOaqxSNWTaun2sM54O4ybV4BPaCW0VNn43fS2DmF6+MWf608m3RD9/32RE5
 6AiQNhbD4fuAdn7vU69PhNyMlvnkRfdXhCnerHq7KxKLOfO9OiLBMBuqRyTQRNFF
 V5yVnt2JyM5b9OYSu5leT0OyIeN1pjlp1kA==
X-ME-Sender: <xms:-j6balsB25dhIF00lnNmcvU5YKc1P18FA6q9SsUW7b0aRegDm93soQ>
 <xme:-j6bakfNXW7zIUHXOKzYY6YdJNq5TdmWFlKZi6eb2Be3GoyFUZLJCjax0ehSszyQ-
 zmbZ3HkH2QbGo4-IvAa7Ohqom9nS4cWXNcxCRqLqt2lRgcNeOy8z0lE>
X-ME-Received: <xmr:-j6bajmakqfo-Pxi3Lbz4-CvWB2DGP9dXfhAUtIf474--HKrQKo7BDlni0mTtKaIXniQd9msG8EGPrmN3clE>
X-ME-Proxy-Cause: dmFkZTGtFOdQhu4w6sHnx9l0gSCIxeApuVk4ZawM3bZbG0YI4GXB5DhL3eHdoQvyNopPpw
 4bDW9BR0emjtnFA74g9jp7Z1v3uGju2Q1/nFucuc9Jp0xHfU1Il9tkXNkcYhAeE7M3SdcX
 iiZIEkYT49GO09IFXcbRng/jGmw6u0Bw3e5Zyz7DBxnXPkKWeZnP+Gn957AMCd7qmXcHAk
 d01Nevoqs7Oh1l/AeCdPgpnYIb2peGyojNIbijpFNovEe8ikYGLqw22YS06KpSM/jJaPBA
 zu9gQk4YupnVBkkmSY85+mjTTwdmPsjD/WX63xa7nA/vBK/peJ22o6I8Xf81nO597jHUIW
 3eEG/E2UGmNuu7AfsZ12jzPYuJ0iuZPQdmCqpu53P0jar5KcdFRSWS/5Wj4QwDk8b07z+V
 MnzeSppKizN4w4sdOu1/msfqZ/v8cWm6saz3aIzaCyQM8FR5KGcIogRvKqcQ/P3UPwkicl
 dZBrr7BsjyzyTkARP+JB14wo5aKxJFqBamLZ+4jV6SAb+Z2jCQmfzshMnc/HEuqzsBrj+R
 2Ds/Bg6ynxzgavd9CcII1dpukRrh6qud1IRqJm7oC5VzBgHyj+p4/TcWFa8lSWq43jw5ZW
 cGdet7o03Bg0j8KmmHRdi9wsL8tdmZ+deEm1AcCcwsJyIiwXq9Kox33mcqmQ
X-ME-Proxy: <xmx:-j6bavDw-GyjR3MIUmVEwOwXk_36c_4XBUI3Qs2QxEKWeJMVPZxAPQ>
 <xmx:-j6balP4MNXqpr8X5ImU9fTKylQjjZRDaQMB8kPV4XdbIqUqUFpEyA>
 <xmx:-j6bamPT8A2jObza_MdvxLLW-wzL9dWwK8HASpgHs0464X1gi84-gA>
 <xmx:-j6batk2B_7EX_rR1eR4F_In_UMdN_eEH6wJbWk8b83vlOF5VRH3bA>
 <xmx:-z6basSEifGeFwZtWWiOJlqiOYfCf9-lZHdxjvh5HmaJwx7Lgoy0E6kz>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:58:17 -0400 (EDT)
Date: Fri, 4 Sep 2026 23:58:16 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 4/7] dma-helpers: chunk dma_blk_cb at IOV_MAX
Message-ID: <20260904235802.4-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-4-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-4-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=103.168.172.158; envelope-from=foss@defmacro.it;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026-08-19T17:24:06+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
> must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
> rejects the call.
>
> Break the accumulation loop when niov reaches IOV_MAX. The existing
> re-entry path resumes mapping and submits a follow-up chunk under
> the same AIOCB, so callers no longer carry that constraint.
>
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  system/dma-helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index d4fd33a3d4c..613fa548669 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -175,6 +175,9 @@ static void dma_blk_cb(void *opaque, int ret)
>              dbs->sg_cur_byte = 0;
>              ++dbs->sg_cur_index;
>          }
> +        if (dbs->iov.niov >= IOV_MAX) {
> +            break;
> +        }
>      }
>  
>      if (dbs->iov.size == 0) {
>
> -- 
> 2.55.0
>
>
>

Acked-by: Jesper Wendel Devantier <foss@defmacro.it>



