Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B863CEFCE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAQf-0005wH-El; Tue, 06 Jan 2026 12:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1vdAQZ-0005fr-2U; Tue, 06 Jan 2026 12:01:04 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1vdAQW-0005J2-Ho; Tue, 06 Jan 2026 12:01:02 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D06BC7A0157;
 Tue,  6 Jan 2026 12:00:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 12:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1767718854;
 x=1767805254; bh=TzP6zgB/UK1wRtZVoQoKcLloN0E9lGwY2Qs9lCyTvuQ=; b=
 asqlr7PH/Muy94Zc9EpMo1sxxOuuNhzMHUaTJZRlxWQcUSduAOO1G9dSZc5G2pzm
 w49gk2wCwLEW0Q2495isZYXXTUhflBvgnXYmX388ckSlm5b6rhB2/1yW6oIkKg71
 HxhDRSnFMJkjdUihBfT4Z9PPwfEMukH5ncevoGbam0+rVwIb59fh9ggYkhzdBq4V
 bXhus4sZmYMwNAVdWYu99wNHUvCJB+T4LEsn2vPww3YivNq9WLonKX3n6K/jqN4O
 Mf7VWpGdls+oTmNmgjZ/kM3fBPYo9jooVY64F2F0hh1qNJwL7b3bc6VG/xEkq8Jx
 uVjalKqLpJJDL9QGbod8wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767718854; x=
 1767805254; bh=TzP6zgB/UK1wRtZVoQoKcLloN0E9lGwY2Qs9lCyTvuQ=; b=f
 2YoXgovME5zyVhRiX9jEZzv21SMG1XUEsn0eFkcuI++fWOLBVmnBj7pKcfmxpywp
 +Fw4iYcIR8CskX0XGvcN/Rb90Df6LoPxJd+9/shNCbH1NdKBEhj5qOAH24C3r0pY
 Nxc5XoAmkLDLJ3ArWZVARYaiIjVYhp+eFUYPF4qDqtEm0OMz7AqCUrYqnATdKf/W
 ZyGiopK345c07veWRuP98NGHE+hnD/ssfp1Wi+vzUMxr2kBa4JhJNLHMhDhLMs6K
 j3JT+ECcbnlAd7XNHaya8r+gzIFp8L8Kz8jhpctlL5E6Y72e69Q2UyCRln/pEhOm
 n3VHLR3kpDZrsopzuWKSw==
X-ME-Sender: <xms:xT9dae8Oxhfvd6OzL8VD9zcoR_hmbpCqVEMpyq_vLBBZABnMdEiPNQ>
 <xme:xT9daZbuuDnV2VCzw0t0J0LqYa94cM1U584k-mEoKSZZH8EdUe5CcXYaSHXBUHS_7
 -XrpPTT3PSj1MGxAKv17LtPlG4gIrz7PTSMRu5T5EGPb-Bhv4iX>
X-ME-Received: <xmr:xT9daaoMIM0D9GUqBKjnF9DTVAGsok3O7RZk8qD0rjww_pD1_rvcnKKqZ1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtjeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfgggtgfesthhqredttddtjeenucfhrhhomheptehlvgigucgh
 ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
 htvghrnhepgfffvdefjeejueevfeetudfhgeetfeeuheetfeekjedvuddvueehffdtgeej
 keetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduledpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepvghrihgtrdgruhhgvghrsehrvgguhhgrthdrtghomh
 dprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghp
 thhtohephihirdhlrdhlihhusehinhhtvghlrdgtohhmpdhrtghpthhtohepqhgvmhhuqd
 grrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrh
 hordhorhhgpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
 nhhitgholhhinhgtsehnvhhiughirgdrtghomhdprhgtphhtthhopeguughuthhilhgvse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:xT9daRa85tfiZcXtv4ynW898CxudSOGG81Kq6l1QIcs4xdYCFylCVA>
 <xmx:xT9dad74IP0OdJAEfXRDIX2jKaa8GZwZAr94lMFBDyeTUNEc7ly3Ow>
 <xmx:xT9dacQBZLkrF6Q5UJ76cyndxYwJrdomA8F6e1VOSNotzGAPZTSODg>
 <xmx:xT9daduXkf1L2wv6HttBqU5n3aOch__zJvZqizcAzVJnidEr7-7LGA>
 <xmx:xj9daW6MA-8_4qR6AoaKCnyIl4KXw8SGeAY9YB-Ks17b5pPUNymDVgOB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 12:00:52 -0500 (EST)
Date: Tue, 6 Jan 2026 10:00:51 -0700
From: Alex Williamson <alex@shazbot.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Message-ID: <20260106100051.313ccbab.alex@shazbot.org>
In-Reply-To: <15ace9b4-ead5-4153-be5c-7a0323498cb3@redhat.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
 <7dc608a7-b36b-4250-befd-d26115b54e26@redhat.com>
 <483fa0e2-aeb5-43b7-a136-692bbd24d0ba@intel.com>
 <CH3PR12MB75489918DACE8B009A8F4F32AB86A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <4a1e1e8a-8480-4294-a176-b5e630b7d0c7@redhat.com>
 <CH3PR12MB75483839B76AB0C78803687FAB87A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <15ace9b4-ead5-4153-be5c-7a0323498cb3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.156; envelope-from=alex@shazbot.org;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 6 Jan 2026 14:22:57 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> On 1/6/26 12:38 PM, Shameer Kolothum wrote:
> > Hi Eric,
> > =20
> >> -----Original Message-----
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Sent: 06 January 2026 10:55
> >> To: Shameer Kolothum <skolothumtho@nvidia.com>; Yi Liu
> >> <yi.l.liu@intel.com>; qemu-arm@nongnu.org; qemu-devel@nongnu.org
> >> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
> >> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> >> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> >> smostafa@google.com; wangzhou1@hisilicon.com;
> >> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> >> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> >> <kjaju@nvidia.com>; alex@shazbot.org
> >> Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> Hi Shameer, =20
> > [...]
> > =20
> >>>>> Besides the fact the offset is arbitrarily chosen so that this is t=
he
> >>>>> last cap of the vconfig space, the code looks good to me.
> >>>>> So
> >>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>>>>
> >>>>> Just wondering whether we couldn't add some generic pcie code that
> >>>>> parses the extended cap linked list to check the offset range is not
> >>>>> used by another cap before allowing the insertion at a given offset?
> >>>>> This wouldn't prevent a subsequent addition from failing but at lea=
st we
> >>>>> would know if there is some collision.this could be added later on =
though.
> >>>>> =20
> >>>> You're absolutely right. My approach of using the last 8 bytes was a
> >>>> shortcut to avoid implementing proper capability parsing logic
> >>>> (importing pci_regs.h and maintaining a cap_id-to-cap_size mapping
> >>>> table), and it simplified PASID capability detection by only examini=
ng
> >>>> the last 8bytes by a simple dump :(. However, this approach is not
> >>>> good as we cannot guarantee that the last 8bytes are unused by any
> >>>> device.
> >>>>
> >>>> Let's just implement the logic to walk the linked list of ext_caps to
> >>>> find an appropriate offset for our use case. =20
> >>> I had a go at this. Based on my understanding, even if we walk the PC=
Ie
> >>> extended capability linked list, we still can't easily determine the =
size
> >>> occupied by the last capability as the extended capability header doe=
s not
> >>> encode a length, it only provides the "next" pointer, and for the las=
t entry
> >>> next =3D=3D 0. =20
> >> If my understanding is correct when walking the linked list, you can
> >> enumerate the start index and the PCIe extended Capability variable si=
ze
> >> which is made of fix header size + register block variable size which
> >> depends on the capability ID). After that we shall be able to allocate=
 a
> >> slot within holes or at least check that adding the new prop at the end
> >> of the 4kB is safe, no?. What do I miss? =20
> > I think the main issue is that we can't know whether the apparent "hole=
s"
> > between extended capabilities are actually free. Depending on the vendor
> > implementation, those regions may be reserved or used for vendor specif=
ic
> > purposes, and I am not sure(please correct me) PCIe spec guarantee that
> > such gaps are available for reuse. Hence thought of relying on the =E2=
=80=9Cnext=E2=80=9D
> > pointer as a safe bet.
> >
> > Even if we look at the last CAP ID and derive a size based on the
> > spec defined register layout, we still can;t know whether there is
> > any additional vendor specific data beyond that "size". It is still
> > a best guess and I don't think we gain much in adding this additional
> > check. =20
>=20
> Ah OK I see what you mean (you may have discussed that earlier in other
> threads sorry). So you may have vendor specific private data in the
> holes. In that case I guess we cannot do much :-/

Also, we can only know the size of capabilities that are currently
defined, we don't do a great job of keeping up with the latest ECNs.

Unless we have device specific knowledge, the best we can do is hope
that a gap between capabilities is unused.  It might be a helpful
indicator to verify the config space we intend to overlap is zero,
though we can get false positives with such a method if we overlap a
capability that kernel vfio-pci has disconnected from the capability
chain an marked read-only.

> >
> > Perhaps, I think we could inform the user that we are placing
> > teh PASID at the last offset and the onus is on user to make sure
> > it is safe to do so.  =20
> or another solution is to let the user opt-in for this hasardous
> placement using an explicit x- prefixed option? Dunno

Yeah, this is probably one of those cases where we expect we don't have
a foolproof solution and we should allow an override.  I think we're
defining the initial 'auto' algorithm that a -x-vpasid_cap_offset=3D
might use by default.  It should also take a numerical value as an
override though.  We'll need a table so that when we find a device that
requires a different value, that becomes the auto value for that
device.

Also consider how adding subsequent purely virtual capability would
work.  We don't want to have each capability defining a new algorithm
and default offset.  To that extent, we might be better served with a
command line override that specifies available ranges of config space
rather than an offset for a specific vcap.  I think our discussions
related to a kernel interface were headed more in this direction.
Thanks,

Alex

