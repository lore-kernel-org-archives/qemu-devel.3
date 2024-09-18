Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C916CCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtpH-0008PO-21; Wed, 18 Sep 2024 08:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sqtpE-0008Op-Su
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:30:29 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sqtpA-0008Vq-LU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:30:28 -0400
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, "Zuo,Boqun" <zuoboqun@baidu.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "alxndr@bu.edu" <alxndr@bu.edu>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Topic: [PATCH v3 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Index: AQHbCcaAp+oaXwlAHke9fuf1dG6Z0g==
Date: Wed, 18 Sep 2024 12:30:10 +0000
Message-ID: <780a8840510448bb96c3e5db946a75ad@baidu.com>
References: <20240903120304.97833-1-gaoshiyuan@baidu.com>,
 <b7f9dad2-29d9-42e6-97b0-32be6c077391@redhat.com>
In-Reply-To: <b7f9dad2-29d9-42e6-97b0-32be6c077391@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.87.136]
Content-Type: multipart/alternative;
 boundary="_000_780a8840510448bb96c3e5db946a75adbaiducom_"
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.51
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_780a8840510448bb96c3e5db946a75adbaiducom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > Now virtio_address_space_lookup only lookup common/isr/device/notify
> > MR and exclude their subregions.
> >
> > When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
> > host-notifier subregions and we need use host-notifier MR to
> > notify the hardware accelerator directly instead of eventfd notify.
> >
> > Further more, maybe common/isr/device MR also has subregions in
> > the future, so need memory_region_find for each MR incluing
> > their subregions.
> >
> > Add lookup subregion of VirtIOPCIRegion MR instead of only lookup conta=
iner MR.
> >
> > Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to mo=
dern_bar")
> >
> > Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> > Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> > ---
> >   hw/virtio/virtio-pci.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > ---
> > v2 -> v3:
> > * modify commit message
> > * remove unused variable and move mrs to the inner block
> > * replace error_report with assert
> >
> > v1 -> v2:
> > * modify commit message
> > * replace direct iteration over subregions with memory_region_find.
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 524b63e5c7..4d832fe845 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -615,8 +615,12 @@ static MemoryRegion *virtio_address_space_lookup(V=
irtIOPCIProxy *proxy,
> >           reg =3D &proxy->regs[i];
> >           if (*off >=3D reg->offset &&
> >               *off + len <=3D reg->offset + reg->size) {
> > -            *off -=3D reg->offset;
> > -            return &reg->mr;
> > +            MemoryRegionSection mrs =3D memory_region_find(&reg->mr,
> > +                                        *off - reg->offset, len);
> > +            assert(mrs.mr);
>
> We are able to trigger that assert:
>
> https://gitlab.com/qemu-project/qemu/-/issues/2576
>
> Can you take a look and send a fix?
>
> --
> Cheers,
>
> David / dhildenb
>

Sorry for this, Peter and David's Command line can reproduce in my environm=
ent.

But this patch works fine in my testing environment, it can start VM(both q=
35 and i440fx) success and
I will compare the differences in command line parameters with Peter's.

As for qtest, When I use this command line(Change the machine from q35 to i=
440fx), it looks ok

    cat << EOF | ./qemu-system-x86_64 -display none -machine accel=3Dqtest,=
 -m \
    512M -machine pc -nodefaults -device virtio-balloon -qtest stdio
    outl 0xcf8 0x80000890
    outl 0xcfc 0x2
    outl 0xcf8 0x80000891
    inl 0xcfc
    EOF

So I think there might exists other bug, and this patch just happens to tri=
gger them.
I will find it as soon as possible.


--_000_780a8840510448bb96c3e5db946a75adbaiducom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, Helvetica, EmojiFont, &qu=
ot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &qu=
ot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"=
ltr">
<p></p>
<div>&gt; &gt; Now virtio_address_space_lookup only lookup common/isr/devic=
e/notify</div>
<div>&gt; &gt; MR and exclude their subregions.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify =
MR has</div>
<div>&gt; &gt; host-notifier subregions and we need use host-notifier MR to=
</div>
<div>&gt; &gt; notify the hardware accelerator directly instead of eventfd =
notify.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Further more, maybe common/isr/device MR also has subregions=
 in</div>
<div>&gt; &gt; the future, so need memory_region_find for each MR incluing<=
/div>
<div>&gt; &gt; their subregions.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Add lookup subregion of VirtIOPCIRegion MR instead of only l=
ookup container MR.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Fixes: a93c8d8 (&quot;virtio-pci: Replace modern_as with dir=
ect access to modern_bar&quot;)</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Co-developed-by: Zuo Boqun &lt;zuoboqun@baidu.com&gt;</div>
<div>&gt; &gt; Signed-off-by: Gao Shiyuan &lt;gaoshiyuan@baidu.com&gt;</div=
>
<div>&gt; &gt; Signed-off-by: Zuo Boqun &lt;zuoboqun@baidu.com&gt;</div>
<div>&gt; &gt; ---</div>
<div>&gt; &gt;&nbsp; &nbsp;hw/virtio/virtio-pci.c | 8 &#43;&#43;&#43;&#43;&=
#43;&#43;--</div>
<div>&gt; &gt;&nbsp; &nbsp;1 file changed, 6 insertions(&#43;), 2 deletions=
(-)</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; ---</div>
<div>&gt; &gt; v2 -&gt; v3:</div>
<div>&gt; &gt; * modify commit message</div>
<div>&gt; &gt; * remove unused variable and move mrs to the inner block</di=
v>
<div>&gt; &gt; * replace error_report with assert</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; v1 -&gt; v2:</div>
<div>&gt; &gt; * modify commit message</div>
<div>&gt; &gt; * replace direct iteration over subregions with memory_regio=
n_find.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c=
</div>
<div>&gt; &gt; index 524b63e5c7..4d832fe845 100644</div>
<div>&gt; &gt; --- a/hw/virtio/virtio-pci.c</div>
<div>&gt; &gt; &#43;&#43;&#43; b/hw/virtio/virtio-pci.c</div>
<div>&gt; &gt; @@ -615,8 &#43;615,12 @@ static MemoryRegion *virtio_address=
_space_lookup(VirtIOPCIProxy *proxy,</div>
<div>&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &amp;proxy-&=
gt;regs[i];</div>
<div>&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (*off &gt;=3D reg=
-&gt;offset &amp;&amp;</div>
<div>&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*off &=
#43; len &lt;=3D reg-&gt;offset &#43; reg-&gt;size) {</div>
<div>&gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *off -=3D reg-&gt=
;offset;</div>
<div>&gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return &amp;reg-&=
gt;mr;</div>
<div>&gt; &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; MemoryRegionS=
ection mrs =3D memory_region_find(&amp;reg-&gt;mr,</div>
<div>&gt; &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; *off - reg-&gt;offset, len);</div>
<div>&gt; &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; assert(mrs.mr=
);</div>
<div>&gt;</div>
<div>&gt; We are able to trigger that assert:</div>
<div>&gt;</div>
<div>&gt; https://gitlab.com/qemu-project/qemu/-/issues/2576</div>
<div>&gt;</div>
<div>&gt; Can you take a look and send a fix?</div>
<div>&gt;</div>
<div>&gt; --</div>
<div>&gt; Cheers,</div>
<div>&gt;</div>
<div>&gt; David / dhildenb</div>
<div>&gt;</div>
<div><br>
</div>
<div>Sorry for this, Peter and David's Command line can reproduce in my env=
ironment.</div>
<div><br>
</div>
<div>But this patch works fine in my testing environment, it can start VM(b=
oth q35 and i440fx) success and</div>
<div>I will compare the differences in command line parameters with Peter's=
.</div>
<div><br>
</div>
<div>As for qtest, When I use this command line(Change the machine from q35=
 to i440fx), it looks ok</div>
<div><br>
</div>
<div>&nbsp; &nbsp; cat &lt;&lt; EOF | ./qemu-system-x86_64 -display none -m=
achine accel=3Dqtest, -m \</div>
<div>&nbsp; &nbsp; 512M -machine pc -nodefaults -device virtio-balloon -qte=
st stdio</div>
<div>&nbsp; &nbsp; outl 0xcf8 0x80000890</div>
<div>&nbsp; &nbsp; outl 0xcfc 0x2</div>
<div>&nbsp; &nbsp; outl 0xcf8 0x80000891</div>
<div>&nbsp; &nbsp; inl 0xcfc</div>
<div>&nbsp; &nbsp; EOF</div>
<div><br>
</div>
<div>So I think there might exists other bug, and this patch just happens t=
o trigger them.</div>
<div>I will find it as soon as possible.</div>
<br>
<p></p>
<div style=3D"color: rgb(0, 0, 0);"></div>
</div>
</body>
</html>

--_000_780a8840510448bb96c3e5db946a75adbaiducom_--

