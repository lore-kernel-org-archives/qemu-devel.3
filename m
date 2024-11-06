Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E78D29FB1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aes-0000nE-1u; Wed, 06 Nov 2024 02:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1t8Y9Q-0007Zj-HV; Wed, 06 Nov 2024 00:00:18 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1t8Y9N-00027b-4S; Wed, 06 Nov 2024 00:00:16 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A926825400EE;
 Wed,  6 Nov 2024 00:00:10 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
 by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 00:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730869210;
 x=1730955610; bh=BHfOnqcqoXy7rsqCUxwdB7yylXgSLGh4bZMHyx+iXvE=; b=
 bh1rKjdnq8oePnDl5Ec7tXR4EhakNxUpaIYDf3Ni7i22jrlx8IHh/O+JtREm1t+X
 qTJJNGr5dmc8tcarGtiFikvkuA1pbBqnVWaKOkhykXxW43Uj1Pp29905lyzp0mhB
 4N3hoeJNoJZ4jg21yGHxsOspSB2AggEcHNW2oC2w2Nxt5YHLY0AFAo0nB08CYFjR
 X7OJ0H9a789w5EhSqTIpX3+W+UnTES9g10hPUtf0f67UWWni8OXu/k63rilNAjrD
 U11GoVCEiAYzYs3K3ILafufnbIQXoUmCcuBfSJv8VPOh6DPjvmO2sanQPpq34bg8
 pq/4B0d2a7RiSLaao/wfaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730869210; x=
 1730955610; bh=BHfOnqcqoXy7rsqCUxwdB7yylXgSLGh4bZMHyx+iXvE=; b=V
 jXPDfnHqXJquxQg/UaIGWkW5glycmRTg8q/Qr0ZsvRa43YM7uOBG1I4OkpacCTY4
 f2GTKY//4H5LwgH0OAZDIF1UI64eVgyYWjwMREiDIeV0Tf3/XwWwOWNHxVg6hEbS
 ZowQUkHjjCYibMYMPzO5kbFUYA56k9W76LSJVCgo+26pakplstXygI7LnzRtnaeo
 j0fprsvPeh01LqDr9GUMhOa+58gx7oU7NzUduUJY/sRWcLPVHALBxMtStxiXBr5K
 zOejQLLLqqxAGDJli726psm14Ynbk5Cj907HyFYsbDWUPZAjVchU8flSzdtYNplV
 wgrra9ysG6cHdi6DiZVsQ==
X-ME-Sender: <xms:2fcqZ9DWU0BkFwVRbweZ2rLRXSO_Kz7_2g7bN3_ap0Uc19QIV988EQ>
 <xme:2fcqZ7hyZ2btTEoFqCTDn77xVyufxfmaTthX_MRmAaDYYOw4H3z0XfAqorT2trdG7
 -3PSKFu6Gm9EQi97Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdejkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
 ucfhrhhomhepfdetlhgvgigvhicumfgrrhgurghshhgvvhhskhhihidfuceorghikhesoh
 iilhgrsghsrdhruheqnecuggftrfgrthhtvghrnhepuefgueehieefvdejueetveffhfev
 tdfgkedttdeifefhieegjedtfffgudektdehnecuffhomhgrihhnpehgihhtlhgrsgdrtg
 homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
 ihhksehoiihlrggsshdrrhhupdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
 tghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:2fcqZ4mAHdRaViFPzlWq6ajXdksAHbRvwldw2dsYhSDsLEjtLkuTRg>
 <xmx:2fcqZ3w8OmMCEJVVg1LtswrtYdppmqOIDb_z66Zl2KJE0h7lTVynSA>
 <xmx:2fcqZyTtthiGD4dQ2L5I3AvikqKbwk9waOZZ8jZc-C5YSFvnreFIhA>
 <xmx:2fcqZ6bsBzUhZN-r814a8m6GVtJdl828QYdFj-CI9jZJht8Q4dxSTQ>
 <xmx:2vcqZxGQpP4iXX4e-yRegM8piodepjqLthBJGIAcpfoAnqiofvAT4rc->
Feedback-ID: i6e394913:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BB5C31F00072; Wed,  6 Nov 2024 00:00:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 06 Nov 2024 15:59:48 +1100
From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Thomas Huth" <thuth@redhat.com>
Message-Id: <a68316c9-475a-4549-a56e-930b94cde052@app.fastmail.com>
In-Reply-To: <20241106045720.599720-1-aik@ozlabs.ru>
References: <20241106045720.599720-1-aik@ozlabs.ru>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=aik@ozlabs.ru;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Nov 2024 02:40:50 -0500
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

Of course, I meant Nick :-) Sorry for the noise.

On Wed, 6 Nov 2024, at 15:57, Alexey Kardashevskiy wrote:
> The following changes since commit bd4be4d9bd20a252e677239a18b6409ecee98f56:
> 
>   MAINTAINERS: Remove myself as reviewer (2024-11-04 10:09:36 +1000)
> 
> are available in the Git repository at:
> 
>   git@github.com:aik/qemu.git tags/qemu-slof-20241106
> 
> for you to fetch changes up to 3866b650d567f79e78d6bd35cb9b7143258da052:
> 
>   pseries: Update SLOF firmware image (2024-11-06 15:40:53 +1100)
> 
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
> 
> pc-bios/README   |   4 ++--
> pc-bios/slof.bin | Bin 995000 -> 996184 bytes
> roms/SLOF        |   2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> *** Note: this is not for master, this is for pseries
> 
> This adds TPM pass through API.
> Also, moves SLOF from github to gitlab: the idea is to make SLOF
> a proper QEMU subproject but I am not quite sure what this means.
> 
> Do I push changes to https://gitlab.com/qemu-project/SLOF.git [1] ?
> Or I push to https://gitlab.com/slof/slof [2] and someone then
> configures that sync script to pull [2] and push to [1]?
> Or something else entirely? Thanks,
> 
> 

