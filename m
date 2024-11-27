Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA0D6ACF2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGKUv-0007Bg-4l; Wed, 27 Nov 2024 11:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1tGKUs-0007Ar-6L; Wed, 27 Nov 2024 11:02:34 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1tGKUq-0002JM-DK; Wed, 27 Nov 2024 11:02:33 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 655DF11401BA;
 Wed, 27 Nov 2024 11:02:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 11:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1732723348; x=1732809748; bh=CknvWwVjT+
 X5gJYTh5dtJ1U1Ec2ju+keNL4bCyKJC/k=; b=CycNQdgETYc1c16cw3vltOzyy8
 gYUGW3vTE2uhIgijew1fzsnEVxsJ61o/WntBUNpfXbKA4wsvF6ymXJR4rs0viHWE
 bqQfcz7YG8AE5gMl7el/QePnR4H1RlC01iVkpu1leYZpWxAhHg3SmtQR1lb6UDKw
 qFrXgxyc+05VDDITK22sSv/oOYiDw8oBtTTKmrE9IulZPvdinkiCfT9yNmD+E720
 6wSnOgNSk1CcG6ZQxKGwbGlI02ff2JnXV4jS1SlO47MbBKMkvcovgapfwgjHMkeM
 oahwFkxK7pKwlkdA9au2eTS2BQvXSpmGC2OJQxm3xIoOFHd0vyzxhnvdqwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1732723348; x=1732809748; bh=CknvWwVjT+X5gJYTh5dtJ1U1Ec2ju+keNL4
 bCyKJC/k=; b=xCUPEYSXoxLb06gSYxqFTY41TXtSUyTTVu/Eq5evINciRXO1cDl
 LVRPFqBhg+JJLH4rYscSRCdtBOKFz4WrdwEBouKsGQLKGLx+q7WAczT4qwyRh3vB
 8UTzqQNpwt1ifo2vo55c4fJRlCttDvjrB618KZ7F5WXiu8Aatq3qfbBrhRPVCojE
 8YJKEj4Z152E1TVmKmDcP5gtdbKXpumQ5pH8zpVWNKCz4lSn0zTkukWfuNJ2qVRR
 75Fe6QKZvsRFoYhnSaKhvmO4FTpMILvhMPm1C/822Gk56fZBvyrfEgN7+JW2PDzb
 VKxkLRtySqY7N/2Xgv7NHqgBfVKGtmeOh0g==
X-ME-Sender: <xms:k0JHZxNo3jxH4tJwVoNj3_3G87TgUsXFMlCLyepOsA7xm5vkLrH98A>
 <xme:k0JHZz9-rW_Jidg-7ceEi2C8RcN-CcIVyxNyUh2OWfAvjXfoITrSCLOGhnZbkrmxQ
 gYl60bUOpZjmeNXH5U>
X-ME-Received: <xmr:k0JHZwSzv2esZf_5GFw-mgLXURJp9K5a3mv9MnjMZJWxDFRgI2pFG3nPDeA2QlBn0f3BAGY0ajaly-Sd7uiWmYtFtll0wZv79A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdejlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpegtkfffgggfuffvvehfhfgjsegrtderredtvdejnecu
 hfhrohhmpeflvghsphgvrhcuhggvnhguvghlucffvghvrghnthhivghruceofhhoshhsse
 guvghfmhgrtghrohdrihhtqeenucggtffrrghtthgvrhhnpeehteelledttdffiedvteff
 hedvvdeiffettdefhfevjedtjeegvdeftdevvdeutdenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfohhsshesuggvfhhmrggtrhhordhithdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehksghushgthheskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 khdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhsth
 grsghlvgesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:k0JHZ9s8CCxTW7Iv4spgmA7owY_Ym7XEWBLF-tAj3nEHV57tPDe1FA>
 <xmx:k0JHZ5dvVmYAj32CWgShda-GDo_Iv-ztqs0gDHHa4u4qzA0bUwkMJw>
 <xmx:k0JHZ53JKY2svPdMGELY0pac8CyzYCXI_p7WZNNnyOt1_BAHjsAnLg>
 <xmx:k0JHZ193RxtfQb_8eJqA9tDsR19_vD9pwb_-mKMTAX6R2b8LB-PebQ>
 <xmx:lEJHZxT4USXBLNz86fRjLPtrZfx_uD28BZAo_71Q44RHPOWicVMKLyT9>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 11:02:26 -0500 (EST)
Content-Type: multipart/alternative;
 boundary="------------dh3jEClS3dz0t2oBHaHgScgJ"
Message-ID: <12b098be-6849-4379-a920-a92a60b8d37a@defmacro.it>
Date: Wed, 27 Nov 2024 17:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 0/4] fixes for hw/nvme
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
References: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
Content-Language: en-US
From: Jesper Wendel Devantier <foss@defmacro.it>
In-Reply-To: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
Received-SPF: pass client-ip=202.12.124.148; envelope-from=foss@defmacro.it;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------dh3jEClS3dz0t2oBHaHgScgJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 11:14, Klaus Jensen wrote:
> A set of misc fixes related to SR-IOV compliance and MSI-X.
>
> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
> ---
> Klaus Jensen (4):
>        hw/nvme: fix msix_uninit with exclusive bar
>        hw/nvme: fix use/unuse of msix vectors
>        hw/nvme: SR-IOV VFs must hardwire pci interrupt pin register to zero
>        hw/nvme: take a reference on the subsystem on vf realization
>
>   hw/nvme/ctrl.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> ---
> base-commit: abb1565d3d863cf210f18f70c4a42b0f39b8ccdb
> change-id: 20241111-nvme-fixes-1038fe44e48a
>
> Best regards,

|Seems good.
|

|Reviewed-by: ||Jesper Wendel Devantier <foss@defmacro.it>|

--------------dh3jEClS3dz0t2oBHaHgScgJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 11/18/24 11:14, Klaus Jensen wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com">
      <pre class="moz-quote-pre" wrap="">A set of misc fixes related to SR-IOV compliance and MSI-X.

Signed-off-by: Klaus Jensen <a class="moz-txt-link-rfc2396E" href="mailto:k.jensen@samsung.com">&lt;k.jensen@samsung.com&gt;</a>
---
Klaus Jensen (4):
      hw/nvme: fix msix_uninit with exclusive bar
      hw/nvme: fix use/unuse of msix vectors
      hw/nvme: SR-IOV VFs must hardwire pci interrupt pin register to zero
      hw/nvme: take a reference on the subsystem on vf realization

 hw/nvme/ctrl.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)
---
base-commit: abb1565d3d863cf210f18f70c4a42b0f39b8ccdb
change-id: 20241111-nvme-fixes-1038fe44e48a

Best regards,
</pre>
    </blockquote>
    <p><code>Seems good.<br>
      </code></p>
    <p><code>Reviewed-by: </code><code>Jesper Wendel Devantier <a
          class="moz-txt-link-rfc2396E" href="mailto:foss@defmacro.it"
          rel="noopener noreferrer" target="_blank">&lt;foss@defmacro.it&gt;</a></code></p>
  </body>
</html>

--------------dh3jEClS3dz0t2oBHaHgScgJ--

