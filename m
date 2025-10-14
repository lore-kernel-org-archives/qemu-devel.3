Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A8FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fPb-0003FN-Do; Tue, 14 Oct 2025 09:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1v8fPZ-0003Ed-3L
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:49:57 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1v8fPT-00033L-82
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:49:56 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3AF83140006E;
 Tue, 14 Oct 2025 09:49:45 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-11.internal (MEProxy); Tue, 14 Oct 2025 09:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1760449785;
 x=1760536185; bh=gKruouVL71WELV2XAL7wI0J7Ry6uxeoI3KxYOZT7Z7s=; b=
 qvMzUEiVe72s5a/jrWmnZAZGlW9O+eqMf6gSivMCBqfdRq1l2Y0HfrKkZNCbRzqp
 xgfvBknluAJBxtugUwekou6PHrrGVxDQ+FYBCOHnyRBgpyeEjqr7KKW5tsURLSqc
 Hs5ty6HGYJpUNu1nBzyOXXmxMO+Fx3N0EMjQtMMR08GmzLiPELRU8b9Z1LNclecQ
 AWPspi8vDlX63sWhIyB7pkJ/BLucmNY8x8UQMmKV4Bwn5f86llKoCvw+OGMbwQ5U
 KPRCq7/snTFczA01+fErsMJrhs0C7CCOvkRjlwDV4feZtcZduIp7I0AP0sbrYlXU
 OqQanA2+jWR97N0F02m2lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760449785; x=
 1760536185; bh=gKruouVL71WELV2XAL7wI0J7Ry6uxeoI3KxYOZT7Z7s=; b=k
 XtP1WZMdmgFS1MxsV2obJGnMEaLZpND8bTI+VaoarW1+hRqmL6tLexZ8FfkwxxHZ
 lroFsHRxVahJVfiNHblQGU2wUrBQRXo/f1Sk5MAjf2nScxiij1gGBEEZDlukN/dy
 2GmIy+EU08zB84LYnnwX/KuLs1ahsOFNRHeBo9+2Bs+ITpbvagsj99WYRcbwcZer
 TTRwAWN+XZYsRyiZEU4Y/TaTdoRLDLSgq04j265Q+SNISRyBWnOCF0/sZBvswyAy
 MXTQ/ZMX6edQaQGeOgfpMqAfJ44DueYqKZKSeGH1OcJj0A0Lm5h6Gt0Ny8detxxL
 505zTUoGOqE1rJjXXcgRQ==
X-ME-Sender: <xms:-FTuaJC0b7oGNXLeWjJD76Zloyy1tKZvE4Vt7akZkO8J-3QCCR0j7w>
 <xme:-FTuaCUVGO6wTHBrATLwMHXvwFGwr96dPAVZ5NlPKaEMSq6cHhRxinB2tC7QsIs7u
 OXKiSLhUT8BO6tDQTR2WGhd_Ss0xAqV0VU3YNDlza0TaQCRU4O3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtieelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlvgig
 ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
 frrghtthgvrhhnpeeugfdtfeehieehtefhgefghfetudeihfffhfeileejieejgeeiffel
 veejieeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdroh
 hrghdprhgtphhtthhopehjohhhnhdrlhgvvhhonhesnhhuthgrnhhigidrtghomhdprhgt
 phhtthhopegvlhgvnhgrrdhufhhimhhtshgvvhgrsehorhgrtghlvgdrtghomhdprhgtph
 htthhopehjrghgrdhrrghmrghnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjohhh
 nhdrghdrjhhohhhnshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlvgigrd
 ifihhllhhirghmshhonhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghlghesrhgv
 ughhrghtrdgtohhm
X-ME-Proxy: <xmx:-FTuaBloqBXe1C1s7MUHr1T2Hnvzr4NjdnRQi9osFvf_SM5RoR-Vjw>
 <xmx:-FTuaPHMFCo9v2PQim77bwCDnSL9NSOd7DVP6sI1o-1dbK5tIlSb6g>
 <xmx:-FTuaJ6ka3LuS-VlVMGRXnxqSuLmEWl5Afm0wLKj095vzILIWD09Fw>
 <xmx:-FTuaHl5EsK3KCzXhMSZ5UJvwVx2quHKZlwZ8H_j_7XG8XxwZs8phw>
 <xmx:-VTuaPKbMGPGbbbE7CYqpKEo5oyLurWO2q28p1BI9wB5d-VB7mUQdNZX>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9843015C0053; Tue, 14 Oct 2025 09:49:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ALmdNnJvd437
Date: Tue, 14 Oct 2025 07:49:24 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "John Levon" <john.levon@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Alex Williamson" <alex.williamson@redhat.com>,
 "John Johnson" <john.g.johnson@oracle.com>,
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>,
 "Jagannathan Raman" <jag.raman@oracle.com>
Message-Id: <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
In-Reply-To: <aO5RAIX6WI0MerI-@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com> <aO5RAIX6WI0MerI-@lent>
Subject: Re: [PULL 25/28] vfio: add region info cache
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@shazbot.org;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 14, 2025, at 7:32 AM, John Levon wrote:
> On Tue, Oct 14, 2025 at 03:16:46PM +0200, C=C3=A9dric Le Goater wrote:
>
>> > +    /* check cache */
>>=20
>> It would be good to add an assert to check the index value. More impo=
rtant
>> we need to fix an ugly "index out-of-bounds" bug that can occur when =
booting
>> a VM with a vGPU :
>>=20
>>   -device vfio-pci-nohotplug,host=3D0000:27:00.4,display=3Don,ramfb=3D=
true ...
>>=20
>> The interesting part is :
>>=20
>>   Thread 1 (Thread 0x7ffff6891ec0 (LWP 11372) "qemu-kvm"):
>>   #0  0x000055555581b83d in vfio_region_setup (obj=3D0x5555588c0b70, =
vbasedev=3D0x5555588c1630, region=3D0x555558a9c040, index=3D9, name=3D0x=
555555de94ba <str.68.llvm> "display") at ../hw/vfio/region.c:199
>>   #1  0x00005555558208a4 in vfio_display_region_update (opaque=3D<opt=
imized out>) at ../hw/vfio/display.c:449
>>   #2  0x00005555556bdd6c in graphic_hw_update (con=3D0x555558acf830) =
at ../ui/console.c:143
>>   #3  vnc_refresh (dcl=3D0x7fffec048050) at ../ui/vnc.c:3262
>>   #4  0x00005555556a15cb in dpy_refresh (s=3D0x555558acf980) at ../ui=
/console.c:880
>>   #5  gui_update (opaque=3D0x555558acf980) at ../ui/console.c:90
>>   (gdb) p vbasedev->num_regions
>>   $9 =3D 9
>>=20
>> Index 9 is beyond the maximum valid index of the reginfo array :/
>>=20
>> We didn't take into account the ioctl VFIO_DEVICE_QUERY_GFX_PLANE
>> which can return region index 9 which is beyond the maximum valid
>> index of the reginfo array :/
>
> My apologies - we hit the exact same issue internally, but with a much=
 older
> codebase, so I did not realise this could be an upstream problem as we=
ll!
>
> We put this down to a bug in the nvidia driver - surely it shouldn't be
> reporting fewer regions than are actually in use. So we applied what w=
e thought
> to be a gross hack of boundary checking, and not using the region cach=
e in case
> it's beyond num_regions.
>
> To put it another way, the header file says:
>
>    217         __u32   num_regions;    /* Max region index + 1 */
>
> If it's not actually the max region index + 1, what are the expected s=
emantics
> of this field, or of region indices more generally? We could not find =
any clear
> documentation on the topic other than this comment.

'9' only defines the end of the fixed, pre-defined region indexes for vf=
io-pci, ie. VFIO_PCI_NUM_REGIONS.  Beyond that, we support device specif=
ic regions.  The GFX region is one such device specific region.

We enumerate these regions based on vfio_device_info.num_regions and use=
 the capabilities feature of the vfio_region_info to introspect the regi=
on type provided.

There is no fixed limit to the number of regions a device may expose, no=
r is vfio_device_info.num_regions necessarily a static value.  We're cur=
rently discussing a uAPI for generating special mappings to a region tha=
t could dynamically increase the reported regions.  Thanks,

Alex

