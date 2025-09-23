Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE86CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 15:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14rQ-0004TT-43; Tue, 23 Sep 2025 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1v14rN-0004Su-Vz; Tue, 23 Sep 2025 11:23:18 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1v14rL-0002DN-8z; Tue, 23 Sep 2025 11:23:17 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 76C5D7A007A;
 Tue, 23 Sep 2025 11:23:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 11:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758640989;
 x=1758727389; bh=xL8LNShCtxryXQtiUDOoxgzYHqtBVr2QeDvaNqUzP98=; b=
 VJfgQFBRsBbeiGc6EKwSGiIDQXlFhqbY9qCs4zlvAoD9AdupHtsT8qDwzf/wAegS
 pXALSY/LpYwpLUA4o+cymWygjPGV329hP9voj6dGMPDSsq9MjAuAnQ/wLvUReEjS
 vKx0tzHLiwxl9sQLvxMxNIlfxBKLrq8yRwHPcGCa3eCT1NalT9bp+cWZDwAs3tkK
 DU8hs7aIj+BCP0OmFxL1+azLGb2mr3X+PxH+x2mbZS6ddlst7xdsrc6z4zWe855F
 NBfQwy3hltgLxYiJV9MSq7JirQWpo8i0c0nN7I/VL9dMxqZJHNHUwEGXZVgdBPok
 QGqX+JrkfCDSzs4KU2lRqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758640989; x=
 1758727389; bh=xL8LNShCtxryXQtiUDOoxgzYHqtBVr2QeDvaNqUzP98=; b=l
 DM5v0IcYi8st9QPSEOuxkyyZ2KjXd5BqJOh8y+8wjh4f1mYrlhLPmAChHfoAMs33
 AL4Io8NmyMAi6igCsjirewi5H4HJ3+MCVfywAdimGm2aNFA8jkqjrDQ9yNeHyL4/
 9y23wRqASWrmaFDLJJwlpTaNA5u+q7xx5oWerwRLtOygCR/yTn6DuQnfqPet+6pz
 EeKLoEeiAudFKGGR4ws4LP3sC2iX5c9zyqPr/4Vo6nfTevG5FGXHgwikZ0Xpct6T
 dxcANdv9n/S1Txz5LgFuz30u4l9A1+R8WJvb4+RSS75GazEbLAs14UQD5g+ygxd+
 Oik4n60gOACajGZQIn6zw==
X-ME-Sender: <xms:XLvSaC3p0xL-Kk2_Ptk0_yQPb1sSWdXoMxtxbfUcAPU1DN3kBDEERg>
 <xme:XLvSaOAPMWdlpVCJjXpWozfPwfNeZ5Ms0aWxvg1VEgpL-3M29bnO6iIyyyQ-7eZHE
 0siMc1bBssoBQYQMhzx0aIUptOUlRSqbLiXTI6vKoWfGEkxi8cJQw>
X-ME-Received: <xmr:XLvSaGdK4Dz7FGEbJHrZ_FIsSDGXrJB-N4JTYn9Dpk0D9bEp3uBOttl5XoK9x4XeegvrzlVxvq-ou6yKyHX3L7uJhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflvghsphgv
 rhcuffgvvhgrnhhtihgvrhdfuceofhhoshhsseguvghfmhgrtghrohdrihhtqeenucggtf
 frrghtthgvrhhnpedtveekffevgfekuedthfetlefhhefhueegfffgtdfhleefuedufffg
 leelueduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehfohhsshesuggvfhhmrggtrhhordhithdpnhgspghrtghpthhtohepiedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmhhsohhnsehorhgrtghlvg
 drtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhr
 tghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhsse
 hirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdoqh
 gvmhhuqdguvghvvghlpegrrhgthhhivhgvrhdrkhgvrhhnvghlrdhorhhgsehnohhnghhn
 uhdrohhrgh
X-ME-Proxy: <xmx:XLvSaD55vU4z69cCLgzqcKPc-nV8pMFzpKTHPqZqQmeETnd1qXENAA>
 <xmx:XLvSaBWuhZMK5ip8A6pusKt73_a2p86JHxw8_HUPl7NMNUhxJbwkiQ>
 <xmx:XLvSaK5sm3_3xhVEsnoQcxQBPKbapQ9psR_Labo2eBOPhOwQTMwOwg>
 <xmx:XLvSaEppr3NBe86c9HOpUt58eDsgsnkAAMn57fVdYs_uHXmqmzXn4g>
 <xmx:XbvSaDULD-qkZ4PrtcKTAL5aM9B_1ELiL43Qx3279EDC_MAP2hHDv5Pk>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 11:23:07 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 17:23:04 +0200
Message-Id: <DD0A7772884E.HOY3HVDIV4FB@defmacro.it>
Cc: <kbusch@kernel.org>, <its@irrelevant.dk>, <qemu-block@nongnu.org>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH 0/2] Add support for NVMe Namespace and Boundary Atomic
 Parameters
From: "Jesper Devantier" <foss@defmacro.it>
To: "Alan Adamson" <alan.adamson@oracle.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.20.1
References: <20250602230458.1073148-1-alan.adamson@oracle.com>
In-Reply-To: <20250602230458.1073148-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=foss@defmacro.it;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue Jun 3, 2025 at 1:04 AM CEST, Alan Adamson wrote:
> This patch set is a follow on to commit ebd1568fc732 ("hw/nvme: add atomi=
c
> write support").  These patches introduces two updates to the NVMe subsys=
tem in QEMU,
> both aimed at enhancing atomic write support for namespaces.
>
> hw/nvme: enable ns atomic writes
> --------------------------------
> This patch introduces support for namespace-specific atomic write paramet=
ers: NAWUN
> and NAWUPF, as defined by the NVMe specification. The atomic parameters a=
re
> utilized to guarantee that writes conforming to these boundaries will be =
atomic,
> improving data integrity for namespaces that require atomic operations.
>
> The patch introduces new NVMe QEMU parameters:
> 	atomic.nawun (default: 0)
> 	atomic.nawupf (default: 0)
> 	atomic.nsfeat (default: off)
>
> The addition of atomic.nsfeat sets the Namespace Supported Atomic Boundar=
y &
> Power (NSABP) bit in the Identify Namespace Data Structure, enabling name=
space-specific
> atomic write features. The patch also ensures that atomic write behavior =
adheres to the
> NACWU and NAWUPF parameters.
>
> hw/nvme: add atomic boundary support
> ------------------------------------
> The second patch expands on the atomic write capabilities by adding suppo=
rt for atomic
> boundary parameters: NABO, NABSN, and NABSPF. These parameters define the=
 atomic
> boundary size for writes and ensure that any writes crossing these bounda=
ries are
> treated atomically, based on the AWUN and AWUPF values.
>
> The following parameters are added:
> 	atomic.nabo (default: 0)
> 	atomic.nabsn (default: 0)
> 	atomic.nabspf (default: 0)
>
> If the atomic boundary is crossed, the writes are guaranteed to be atomic=
 only if their
> size does not exceed the values defined by AWUN and AWUPF. This ensures t=
hat larger
> writes crossing atomic boundaries are not subject to partial updates, the=
reby improving
> the robustness of atomic operations across boundaries.
>
> See the NVMe Specification for more information.
>
> Alan Adamson (2):
>   hw/nvme: enable ns atomic writes
>   hw/nvme: add atomic boundary support
>
>  hw/nvme/ctrl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h | 14 ++++++++++
>  3 files changed, 164 insertions(+)

Follows the spec far as I can see.
Read the code, seems good

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>

