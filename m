Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA96CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqe1D-0005SZ-Hg; Tue, 17 Sep 2024 15:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqe1A-0005Rz-2e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:37:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqe16-0007pB-DO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:37:43 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X7X5L2k4Gz1HJk4;
 Wed, 18 Sep 2024 03:33:42 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
 by mail.maildlp.com (Postfix) with ESMTPS id 80DEF1A0188;
 Wed, 18 Sep 2024 03:37:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Sep 2024 03:37:23 +0800
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 17 Sep 2024 21:37:21 +0200
To: John Groves <John@groves.net>
CC: David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>,
 linux-cxl <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, virtualization
 <virtualization@lists.linux.dev>, Oscar Salvador <osalvador@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>, John Groves
 <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>, Navneet Singh
 <navneet.singh@intel.com>, =?Windows-1252?Q?=93Michael_S=2E_Tsirkin=94?=
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: RE: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Thread-Topic: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Thread-Index: AQHa7y9P2/tUGCry0kSwX0eUzKEWI7Ity18AgADyeACALdXRDA==
Date: Tue, 17 Sep 2024 19:37:21 +0000
Message-ID: A4E80580-437F-46D8-A58B-D2F3851D67BD
References: <20240815172223.00001ca7@Huawei.com>
 <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>,
 <20240819164024.00005a0a@Huawei.com>
In-Reply-To: <20240819164024.00005a0a@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: multipart/alternative;
 boundary="_000_A4E80580437F46D8A58BD2F3851D67BD_"
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=jonathan.cameron@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 INVALID_MSGID=0.568, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_A4E80580437F46D8A58BD2F3851D67BD_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Plan is currently to meet at lpc registration desk 2pm tomorrow Wednesday a=
nd we will find a room.

J


________________________________

Jonathan Cameron
Mobile: +44-7870588074
Mail: jonathan.cameron@huawei.com

From:Jonathan Cameron <Jonathan.Cameron@Huawei.com<mailto:Jonathan.Cameron@=
Huawei.com>>
To:John Groves <John@groves.net<mailto:John@groves.net>>
Cc:David Hildenbrand <david@redhat.com<mailto:david@redhat.com>>;linux-mm <=
linux-mm@kvack.org<mailto:linux-mm@kvack.org>>;linux-cxl <linux-cxl@vger.ke=
rnel.org<mailto:linux-cxl@vger.kernel.org>>;Davidlohr Bueso <dave@stgolabs.=
net<mailto:dave@stgolabs.net>>;Ira Weiny <ira.weiny@intel.com<mailto:ira.we=
iny@intel.com>>;virtualization <virtualization@lists.linux.dev<mailto:virtu=
alization@lists.linux.dev>>;Oscar Salvador <osalvador@suse.de<mailto:osalva=
dor@suse.de>>;qemu-devel <qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.or=
g>>;Dave Jiang <dave.jiang@intel.com<mailto:dave.jiang@intel.com>>;Dan Will=
iams <dan.j.williams@intel.com<mailto:dan.j.williams@intel.com>>;Linuxarm <=
linuxarm@huawei.com<mailto:linuxarm@huawei.com>>;Wangkefeng (OS Kernel Lab)=
 <wangkefeng.wang@huawei.com<mailto:wangkefeng.wang@huawei.com>>;John Grove=
s <jgroves@micron.com<mailto:jgroves@micron.com>>;Fan Ni <fan.ni@samsung.co=
m<mailto:fan.ni@samsung.com>>;Navneet Singh <navneet.singh@intel.com<mailto=
:navneet.singh@intel.com>>;=93Michael S. Tsirkin=94 <mst@redhat.com<mailto:=
mst@redhat.com>>;Igor Mammedov <imammedo@redhat.com<mailto:imammedo@redhat.=
com>>;Philippe Mathieu-Daud=E9 <philmd@linaro.org<mailto:philmd@linaro.org>=
>
Date:2024-08-19 17:41:01
Subject:Re: [RFC] Virtualizing tagged disaggregated memory capacity (app sp=
ecific, multi host shared)

On Sun, 18 Aug 2024 21:12:34 -0500
John Groves <John@groves.net> wrote:

> On 24/08/15 05:22PM, Jonathan Cameron wrote:
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > If we think application specific memory (including inter-host shared me=
mory) is
> > a thing, it will also be a thing people want to use with virtual machin=
es,
> > potentially nested. So how do we present it at the Host to VM boundary?
> >
> > This RFC is perhaps premature given we haven't yet merged upstream supp=
ort for
> > the bare metal case. However I'd like to get the discussion going given=
 we've
> > touched briefly on this in a number of CXL sync calls and it is clear n=
o one is
>
> Excellent write-up, thanks Jonathan.
>
> Hannes' idea of an in-person discussion at LPC is a great idea - count me=
 in.

Had a feeling you might say that ;)

>
> As the proprietor of famfs [1] I have many thoughts.
>
> First, I like the concept of application-specific memory (ASM), but I won=
der
> if there might be a better term for it. ASM suggests that there is one
> application, but I'd suggest that a more concise statement of the concept
> is that the Linux kernel never accesses or mutates the memory - even thou=
gh
> multiple apps might share it (e.g. via famfs). It's a subtle point, but
> an important one for RAS etc. ASM might better be called non-kernel-manag=
ed
> memory - though that name does not have as good a ring to it. Will mull t=
his
> over further...

Naming is always the hard bit :)  I agree that one doesn't work for
shared capacity. You can tell I didn't start there :)

>
> Now a few level-setting comments on CXL and Dynamic Capacity Devices (DCD=
s),
> some of which will be obvious to many of you:
>
> * A DCD is just a memory device with an allocator and host-level
>   access-control built in.
> * Usable memory from a DCD is not available until the fabric manger (like=
ly
>   on behalf of an orchestrator) performs an Initiate Dynamic Capacity Add
>   command to the DCD.
> * A DCD allocation has a tag (uuid) which is the invariant way of identif=
ying
>   the memory from that allocation.
> * The tag becomes known to the host from the DCD extents provided via
>   a CXL event following succesful allocation.
> * The memory associated with a tagged allocation will surface as a dax de=
vice
>   on each host that has access to it. But of course dax device naming &
>   numbering won't be consistent across separate hosts - so we need to use
>   the uuid's to find specific memory.
>
> A few less foundational observations:
>
> * It does not make sense to "online" shared or sharable memory as system-=
ram,
>   because system-ram gets zeroed, which blows up use cases for sharable m=
emory.
>   So the default for sharable memory must be devdax mode.
(CXL specific diversion)

Absolutely agree this this. There is a 'corner' that irritates me in the sp=
ec though
which is that there is no distinction between shareable and shared capacity=
.
If we are in a constrained setup with limited HPA or DPA space, we may not =
want
to have separate DCD regions for these.  Thus it is plausible that an orche=
strator
might tell a memory appliance to present memory for general use and yet it
surfaces as shareable.  So there may need to be an opt in path at least for
going ahead and using this memory as normal RAM.

> * Tags are mandatory for sharable allocations, and allowed but optional f=
or
>   non-sharable allocations. The implication is that non-sharable allocati=
ons
>   may get onlined automatically as system-ram, so we don't need a namespa=
ce
>   for those. (I argued for mandatory tags on all allocations - hey you do=
n't
>   have to use them - but encountered objections and dropped it.)
> * CXL access control only goes to host root ports; CXL has no concept of
>   giving access to a VM. So some component on a host (perhaps logically
>   an orchestrator component) needs to plumb memory to VMs as appropriate.

Yes.  It's some mashup of an orchestrator and VMM / libvirt, local library
of your choice. We can just group into into the ill defined concept of
a distributed orchestrator.

>
> So tags are a namespace to find specific memory "allocations" (which in t=
he
> CXL consortium, we usually refer to as "tagged capacity").
>
> In an orchestrated environment, the orchestrator would allocate resources
> (including tagged memory capacity), make that capacity visible on the rig=
ht
> host(s), and then provide the tag when starting the app if needed.
>
> if (e.g.) the memory cotains a famfs file system, famfs needs the uuid of=
 the
> root memory allocation to find the right memory device. Once mounted, it'=
s a
> file sytem so apps can be directed to the mount path. Apps that consume t=
he
> dax devices directly also need the uuid because /dev/dax0.0 is not invari=
ant
> across a cluster...
>
> I have been assuming that when the CXL stack discovers a new DCD allocati=
on,
> it will configure the devdax device and provide some way to find it by ta=
g.
> /sys/cxl/<tag>/dev or whatever. That works as far as it goes, but I'm com=
ing
> around to thinking that the uuid-to-dax map should not be overtly CXL-spe=
cific.

Agreed. Whether that's a nice kernel side thing, or a utility pulling data
from various kernel subsystem interfaces doesn't really matter. I'd prefer
the kernel presents this but maybe that won't work for some reason.

>
> General thoughts regarding VMs and qemu
>
> Physical connections to CXL memory are handled by physical servers. I don=
't
> think there is a scenario in which a VM should interact directly with the
> pcie function(s) of CXL devices. They will be configured as dax devices
> (findable by their tags!) by the host OS, and should be provided to VMs
> (when appropriate) as DAX devices. And software in a VM needs to be able =
to
> find the right DAX device the same way it would running on bare metal - b=
y
> the tag.

Limiting to typical type 3 memory pool devices. Agreed. The other CXL devic=
e
types are a can or worms for another day.

>
> Qemu can already get memory from files (-object memory-backend-file,...),=
 and
> I believe this works whether it's an actual file or a devdax device. So f=
ar,
> so good.
>
> Qemu can back a virtual pmem device by one of these, but currently (AFAIK=
)
> not a virtual devdax device. I think virtual devdax is needed as a first-=
class
> abstraction. If we can add the tag as a property of the memory-backend-fi=
le,
> we're almost there - we just need away to lookup a daxdev by tag.

I'm not sure that is simple. We'd need to define a new interface capable of=
:
1) Hotplug - potentially of many separate regions (think nested VMs).
   That more or less rules out using separate devices on a discoverable hot=
pluggable
   bus. We'd run out of bus numbers too quickly if putting them on PCI.
   ACPI style hotplug is worse because we have to provision slots at the ou=
tset.
2) Runtime provision of metadata - performance data very least (bandwidth /
   latency etc). In theory could wire up ACPI _HMA but no one has ever both=
ered.
3) Probably do want async error signaling.  We 'could' do that with
   FW first error injection - I'm not sure it's a good idea but it's defini=
tely
   an option.

A locked down CXL device is a bit more than that, but not very much more.
It's easy to fake registers for things that are always in one state so
that the software stack is happy.

virtio-mem has some of the parts and could perhaps be augmented
to support this use case with the advantage of no implicit tie to CXL.


>
> Summary thoughts:
>
> * A mechanism for resolving tags to "tagged capacity" devdax devices is
>   essential (and I don't think there are specific proposals about this
>   mechanism so far).

Agreed.

> * Said mechanism should not be explicitly CXL-specific.

Somewhat agreed, but I don't want to invent a new spec just to avoid explic=
it
ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpo=
se
memory for example to a VM. It will trivially work if that is what a user
wants to do and also illustrates that this stuff doesn't necessarily just
apply to capacity on a memory pool - it might just be 'weird' memory on the=
 host.

> * Finding a tagged capacity devdax device in a VM should work the same as=
 it
>   does running on bare metal.

Absolutely - that's a requirement.

> * The file-backed (and devdax-backed) devdax abstraction is needed in qem=
u.

Maybe. I'm not convinced the abstraction is needed at that particular level=
.

> * Beyond that, I'm not yet sure what the lookup mechanism should be. Extr=
a
>   points for being easy to implement in both physical and virtual systems=
.

For physical systems we aren't going to get agreement :(  For the systems
I have visibility of there will be some diversity in hardware, but the
presentation to userspace and up consistency should be doable.

Jonathan

>
> Thanks for teeing this up!
> John
>
>
> [1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
>



--_000_A4E80580437F46D8A58BD2F3851D67BD_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<style type=3D"text/css">
<!--
*
	{}
body
	{font-family:Calibri}
-->
</style>
<div>
<div>
<div id=3D"x_focus">
<div><br>
Plan is currently to meet at lpc registration desk 2pm tomorrow Wednesday a=
nd we will find a room.&nbsp;</div>
<div><br>
</div>
<div>J</div>
<div><br>
</div>
<div><br>
</div>
</div>
</div>
<div></div>
<div id=3D"x_signature">
<hr style=3D"border-top:dotted 1px">
<br>
Jonathan Cameron<br>
Mobile: &#43;44-7870588074<br>
Mail: jonathan.cameron@huawei.com<br>
<br>
</div>
<div name=3D"x_AnyOffice-Background-Image" style=3D"border-top:1px solid #B=
5C4DF; padding:8px">
<div style=3D"word-break:break-all"><b>From:</b>Jonathan Cameron &lt;<a hre=
f=3D"mailto:Jonathan.Cameron@Huawei.com">Jonathan.Cameron@Huawei.com</a>&gt=
;</div>
<div style=3D"word-break:break-all"><b>To:</b>John Groves &lt;<a href=3D"ma=
ilto:John@groves.net">John@groves.net</a>&gt;</div>
<div style=3D"word-break:break-all"><b>Cc:</b>David Hildenbrand &lt;<a href=
=3D"mailto:david@redhat.com">david@redhat.com</a>&gt;;linux-mm &lt;<a href=
=3D"mailto:linux-mm@kvack.org">linux-mm@kvack.org</a>&gt;;linux-cxl &lt;<a =
href=3D"mailto:linux-cxl@vger.kernel.org">linux-cxl@vger.kernel.org</a>&gt;=
;Davidlohr
 Bueso &lt;<a href=3D"mailto:dave@stgolabs.net">dave@stgolabs.net</a>&gt;;I=
ra Weiny &lt;<a href=3D"mailto:ira.weiny@intel.com">ira.weiny@intel.com</a>=
&gt;;virtualization &lt;<a href=3D"mailto:virtualization@lists.linux.dev">v=
irtualization@lists.linux.dev</a>&gt;;Oscar Salvador &lt;<a href=3D"mailto:=
osalvador@suse.de">osalvador@suse.de</a>&gt;;qemu-devel
 &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;=
;Dave Jiang &lt;<a href=3D"mailto:dave.jiang@intel.com">dave.jiang@intel.co=
m</a>&gt;;Dan Williams &lt;<a href=3D"mailto:dan.j.williams@intel.com">dan.=
j.williams@intel.com</a>&gt;;Linuxarm &lt;<a href=3D"mailto:linuxarm@huawei=
.com">linuxarm@huawei.com</a>&gt;;Wangkefeng
 (OS Kernel Lab) &lt;<a href=3D"mailto:wangkefeng.wang@huawei.com">wangkefe=
ng.wang@huawei.com</a>&gt;;John Groves &lt;<a href=3D"mailto:jgroves@micron=
.com">jgroves@micron.com</a>&gt;;Fan Ni &lt;<a href=3D"mailto:fan.ni@samsun=
g.com">fan.ni@samsung.com</a>&gt;;Navneet Singh &lt;<a href=3D"mailto:navne=
et.singh@intel.com">navneet.singh@intel.com</a>&gt;;=93Michael
 S. Tsirkin=94 &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
;Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.c=
om</a>&gt;;Philippe Mathieu-Daud=E9 &lt;<a href=3D"mailto:philmd@linaro.org=
">philmd@linaro.org</a>&gt;</div>
<div style=3D"word-break:break-all"><b>Date:</b>2024-08-19 17:41:01</div>
<div style=3D"word-break:break-all"><b>Subject:</b>Re: [RFC] Virtualizing t=
agged disaggregated memory capacity (app specific, multi host shared)</div>
<div><br>
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Sun, 18 Aug 2024 21:12:34 -0500<br>
John Groves &lt;John@groves.net&gt; wrote:<br>
<br>
&gt; On 24/08/15 05:22PM, Jonathan Cameron wrote:<br>
&gt; &gt; Introduction<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; <br>
&gt; &gt; If we think application specific memory (including inter-host sha=
red memory) is<br>
&gt; &gt; a thing, it will also be a thing people want to use with virtual =
machines,<br>
&gt; &gt; potentially nested. So how do we present it at the Host to VM bou=
ndary?<br>
&gt; &gt; <br>
&gt; &gt; This RFC is perhaps premature given we haven't yet merged upstrea=
m support for<br>
&gt; &gt; the bare metal case. However I'd like to get the discussion going=
 given we've<br>
&gt; &gt; touched briefly on this in a number of CXL sync calls and it is c=
lear no one is&nbsp;
<br>
&gt; <br>
&gt; Excellent write-up, thanks Jonathan.<br>
&gt; <br>
&gt; Hannes' idea of an in-person discussion at LPC is a great idea - count=
 me in.<br>
<br>
Had a feeling you might say that ;)<br>
<br>
&gt; <br>
&gt; As the proprietor of famfs [1] I have many thoughts.<br>
&gt; <br>
&gt; First, I like the concept of application-specific memory (ASM), but I =
wonder<br>
&gt; if there might be a better term for it. ASM suggests that there is one=
<br>
&gt; application, but I'd suggest that a more concise statement of the conc=
ept<br>
&gt; is that the Linux kernel never accesses or mutates the memory - even t=
hough<br>
&gt; multiple apps might share it (e.g. via famfs). It's a subtle point, bu=
t<br>
&gt; an important one for RAS etc. ASM might better be called non-kernel-ma=
naged<br>
&gt; memory - though that name does not have as good a ring to it. Will mul=
l this<br>
&gt; over further...<br>
<br>
Naming is always the hard bit :)&nbsp; I agree that one doesn't work for<br=
>
shared capacity. You can tell I didn't start there :)<br>
<br>
&gt; <br>
&gt; Now a few level-setting comments on CXL and Dynamic Capacity Devices (=
DCDs),<br>
&gt; some of which will be obvious to many of you:<br>
&gt; <br>
&gt; * A DCD is just a memory device with an allocator and host-level<br>
&gt;&nbsp;&nbsp; access-control built in.<br>
&gt; * Usable memory from a DCD is not available until the fabric manger (l=
ikely<br>
&gt;&nbsp;&nbsp; on behalf of an orchestrator) performs an Initiate Dynamic=
 Capacity Add<br>
&gt;&nbsp;&nbsp; command to the DCD.<br>
&gt; * A DCD allocation has a tag (uuid) which is the invariant way of iden=
tifying<br>
&gt;&nbsp;&nbsp; the memory from that allocation.<br>
&gt; * The tag becomes known to the host from the DCD extents provided via<=
br>
&gt;&nbsp;&nbsp; a CXL event following succesful allocation.<br>
&gt; * The memory associated with a tagged allocation will surface as a dax=
 device<br>
&gt;&nbsp;&nbsp; on each host that has access to it. But of course dax devi=
ce naming &amp;<br>
&gt;&nbsp;&nbsp; numbering won't be consistent across separate hosts - so w=
e need to use<br>
&gt;&nbsp;&nbsp; the uuid's to find specific memory.<br>
&gt; <br>
&gt; A few less foundational observations:<br>
&gt; <br>
&gt; * It does not make sense to &quot;online&quot; shared or sharable memo=
ry as system-ram,<br>
&gt;&nbsp;&nbsp; because system-ram gets zeroed, which blows up use cases f=
or sharable memory.<br>
&gt;&nbsp;&nbsp; So the default for sharable memory must be devdax mode.<br=
>
(CXL specific diversion)<br>
<br>
Absolutely agree this this. There is a 'corner' that irritates me in the sp=
ec though<br>
which is that there is no distinction between shareable and shared capacity=
.<br>
If we are in a constrained setup with limited HPA or DPA space, we may not =
want<br>
to have separate DCD regions for these.&nbsp; Thus it is plausible that an =
orchestrator<br>
might tell a memory appliance to present memory for general use and yet it<=
br>
surfaces as shareable.&nbsp; So there may need to be an opt in path at leas=
t for<br>
going ahead and using this memory as normal RAM.<br>
<br>
&gt; * Tags are mandatory for sharable allocations, and allowed but optiona=
l for<br>
&gt;&nbsp;&nbsp; non-sharable allocations. The implication is that non-shar=
able allocations<br>
&gt;&nbsp;&nbsp; may get onlined automatically as system-ram, so we don't n=
eed a namespace<br>
&gt;&nbsp;&nbsp; for those. (I argued for mandatory tags on all allocations=
 - hey you don't<br>
&gt;&nbsp;&nbsp; have to use them - but encountered objections and dropped =
it.)<br>
&gt; * CXL access control only goes to host root ports; CXL has no concept =
of<br>
&gt;&nbsp;&nbsp; giving access to a VM. So some component on a host (perhap=
s logically<br>
&gt;&nbsp;&nbsp; an orchestrator component) needs to plumb memory to VMs as=
 appropriate.<br>
<br>
Yes.&nbsp; It's some mashup of an orchestrator and VMM / libvirt, local lib=
rary<br>
of your choice. We can just group into into the ill defined concept of<br>
a distributed orchestrator.<br>
<br>
&gt; <br>
&gt; So tags are a namespace to find specific memory &quot;allocations&quot=
; (which in the<br>
&gt; CXL consortium, we usually refer to as &quot;tagged capacity&quot;).<b=
r>
&gt; <br>
&gt; In an orchestrated environment, the orchestrator would allocate resour=
ces<br>
&gt; (including tagged memory capacity), make that capacity visible on the =
right<br>
&gt; host(s), and then provide the tag when starting the app if needed.<br>
&gt; <br>
&gt; if (e.g.) the memory cotains a famfs file system, famfs needs the uuid=
 of the<br>
&gt; root memory allocation to find the right memory device. Once mounted, =
it's a<br>
&gt; file sytem so apps can be directed to the mount path. Apps that consum=
e the<br>
&gt; dax devices directly also need the uuid because /dev/dax0.0 is not inv=
ariant<br>
&gt; across a cluster...<br>
&gt; <br>
&gt; I have been assuming that when the CXL stack discovers a new DCD alloc=
ation,<br>
&gt; it will configure the devdax device and provide some way to find it by=
 tag.<br>
&gt; /sys/cxl/&lt;tag&gt;/dev or whatever. That works as far as it goes, bu=
t I'm coming<br>
&gt; around to thinking that the uuid-to-dax map should not be overtly CXL-=
specific.<br>
<br>
Agreed. Whether that's a nice kernel side thing, or a utility pulling data<=
br>
from various kernel subsystem interfaces doesn't really matter. I'd prefer<=
br>
the kernel presents this but maybe that won't work for some reason.<br>
<br>
&gt; <br>
&gt; General thoughts regarding VMs and qemu<br>
&gt; <br>
&gt; Physical connections to CXL memory are handled by physical servers. I =
don't<br>
&gt; think there is a scenario in which a VM should interact directly with =
the<br>
&gt; pcie function(s) of CXL devices. They will be configured as dax device=
s<br>
&gt; (findable by their tags!) by the host OS, and should be provided to VM=
s<br>
&gt; (when appropriate) as DAX devices. And software in a VM needs to be ab=
le to<br>
&gt; find the right DAX device the same way it would running on bare metal =
- by<br>
&gt; the tag.<br>
<br>
Limiting to typical type 3 memory pool devices. Agreed. The other CXL devic=
e<br>
types are a can or worms for another day.<br>
<br>
&gt; <br>
&gt; Qemu can already get memory from files (-object memory-backend-file,..=
.), and<br>
&gt; I believe this works whether it's an actual file or a devdax device. S=
o far,<br>
&gt; so good.<br>
&gt; <br>
&gt; Qemu can back a virtual pmem device by one of these, but currently (AF=
AIK)<br>
&gt; not a virtual devdax device. I think virtual devdax is needed as a fir=
st-class<br>
&gt; abstraction. If we can add the tag as a property of the memory-backend=
-file,<br>
&gt; we're almost there - we just need away to lookup a daxdev by tag.<br>
<br>
I'm not sure that is simple. We'd need to define a new interface capable of=
:<br>
1) Hotplug - potentially of many separate regions (think nested VMs).<br>
&nbsp;&nbsp; That more or less rules out using separate devices on a discov=
erable hotpluggable<br>
&nbsp;&nbsp; bus. We'd run out of bus numbers too quickly if putting them o=
n PCI.<br>
&nbsp;&nbsp; ACPI style hotplug is worse because we have to provision slots=
 at the outset.<br>
2) Runtime provision of metadata - performance data very least (bandwidth /=
<br>
&nbsp;&nbsp; latency etc). In theory could wire up ACPI _HMA but no one has=
 ever bothered.<br>
3) Probably do want async error signaling.&nbsp; We 'could' do that with<br=
>
&nbsp;&nbsp; FW first error injection - I'm not sure it's a good idea but i=
t's definitely<br>
&nbsp;&nbsp; an option.<br>
<br>
A locked down CXL device is a bit more than that, but not very much more.<b=
r>
It's easy to fake registers for things that are always in one state so<br>
that the software stack is happy.<br>
<br>
virtio-mem has some of the parts and could perhaps be augmented<br>
to support this use case with the advantage of no implicit tie to CXL.<br>
<br>
<br>
&gt; <br>
&gt; Summary thoughts:<br>
&gt; <br>
&gt; * A mechanism for resolving tags to &quot;tagged capacity&quot; devdax=
 devices is<br>
&gt;&nbsp;&nbsp; essential (and I don't think there are specific proposals =
about this<br>
&gt;&nbsp;&nbsp; mechanism so far).<br>
<br>
Agreed.<br>
<br>
&gt; * Said mechanism should not be explicitly CXL-specific.<br>
<br>
Somewhat agreed, but I don't want to invent a new spec just to avoid explic=
it<br>
ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpo=
se<br>
memory for example to a VM. It will trivially work if that is what a user<b=
r>
wants to do and also illustrates that this stuff doesn't necessarily just<b=
r>
apply to capacity on a memory pool - it might just be 'weird' memory on the=
 host.<br>
<br>
&gt; * Finding a tagged capacity devdax device in a VM should work the same=
 as it<br>
&gt;&nbsp;&nbsp; does running on bare metal.<br>
<br>
Absolutely - that's a requirement.<br>
<br>
&gt; * The file-backed (and devdax-backed) devdax abstraction is needed in =
qemu.<br>
<br>
Maybe. I'm not convinced the abstraction is needed at that particular level=
.<br>
<br>
&gt; * Beyond that, I'm not yet sure what the lookup mechanism should be. E=
xtra<br>
&gt;&nbsp;&nbsp; points for being easy to implement in both physical and vi=
rtual systems.<br>
<br>
For physical systems we aren't going to get agreement :(&nbsp; For the syst=
ems<br>
I have visibility of there will be some diversity in hardware, but the<br>
presentation to userspace and up consistency should be doable.<br>
<br>
Jonathan<br>
<br>
&gt; <br>
&gt; Thanks for teeing this up!<br>
&gt; John<br>
&gt; <br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/cxl-micron-reskit/famfs/blob/master/=
README.md">
https://github.com/cxl-micron-reskit/famfs/blob/master/README.md</a><br>
&gt; <br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_A4E80580437F46D8A58BD2F3851D67BD_--

