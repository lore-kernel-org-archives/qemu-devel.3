Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8577DCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzvG-00051c-L9; Thu, 21 May 2026 05:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wPzvF-00051K-F0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:42:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wPzvC-0008Jt-4e
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:42:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso45971835e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779356548; x=1779961348; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EvbcgxZMEngpix8PPNffa9OACapw9cCTxSSTQ7Xgr3o=;
 b=VY6yDNr6VTOXMGz4eT3tfZRS10W0XO7/ax+qEk7pYJxUIyhIhSDfoGQqvdvoDnTdxT
 8TBZ50exbhrc/PS4jUNdk4VEe1Itxe3HjixIcgMyP9RDvjI2R9SwuN5WbRZc3Urjy5vd
 c/UBFoWopmXtxIvwBasoH5eVwfScYZIDKZuMjBk0YalNRXWn6C0G81WOWJrx7jndqxST
 UJc4KgCPSkvyI8hnRndJsSwXh983MkmS963cW0Leqy2LTx90kIJ35Bmgdw68QunC06Se
 wTC6QNRys39ptuG+pmrRN7zkfFP5sT5U/0ff0jaNC7Pj3q+4c++Oy8DOh5Q3YOsV7cVZ
 /tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779356548; x=1779961348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvbcgxZMEngpix8PPNffa9OACapw9cCTxSSTQ7Xgr3o=;
 b=n5P0Oz3hubH+CJ7oojxbiuX6zUyorw3DQAUCb0CjCgN3Bvtfe6hxBd2sIuX0zgRLhk
 liJU5RJNzpX8XKBY8C35+ISffP0BwoJ6ggxsZtUgHu0bFlYdTnrzGUMaGFQOODz+9F3h
 oyX1/y7SVGRoC5hZo/+VeopjrAKNlOslvQzt49P+f5Bh9z5vG+RIEhuDMk4DzKhQiSAV
 ASO2FFgJh/BGXV0rbF5zSXhvhjWL6qIMTSw/wIeaO03Id083KZXL7ckB3pEZlYb2nWk9
 L2JEXOEep1D8EmheLbH1kdXlNtHlIUNyp7uNYSyXyMsu2GVdbuBBzdgSF5Y7uE3zhM4s
 wrJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9V5u3pfn6jAmSNJcVrF/++uUllkEcckulkWJ60aKKLl1Gs2lAzdYuKdLatxEDqQa+U/EqPzsv2+t6+@nongnu.org
X-Gm-Message-State: AOJu0YzHUxSBjCLvwziiAi3z5L2VMadCKXdNiPxUDbH2nxTlro/k+gZ4
 vQnjLtKYkbPkdCYzy6SyCAKIvFGNM8sTHhh9Z4FdwXT4SrGh1V+fSJkAjr5oX184
X-Gm-Gg: Acq92OH2W8QSlWw5FnrSkYfbue9KfYnlUdEz5ROfGcdFMPZayZOMsQzgZnCd0qphkY/
 BQwS9Aigr3vBOPQtfmeappXoi/ZWDinuDcP8r7XyXdSTaQaWLTBRCCgZtZ2dcKY1ou5lo43Jy9Q
 jk30968JRkChx8YalwrUxVNlxkIFkg2XK7gd+Myrl+X138VL72isLzWUQYMyS89PwKknVo2pRvX
 ciYCcY7zFJYQzSsdBXWt7gxSpGYkYA0MN7AXbTSak2ukGZVN2oWp6UUDk9voWpEXwIN8NlqO/94
 zJue6ElyZbLAiBoMc2ECUQyyQSkLImGWjsMN3/ZuZ67lTBI2aPya34j/sof23Ec+ecDJKmCYx8q
 mOosOXrVHROFDsNGmWsNYYBV3QP213qZJ4c4kMhvyonzBghb5dhWiA1BEu+Wm7cWswvVYcaR+9j
 q5eVOZKer7/PtB+PfqYmn8aLZKx5UvL8OYkD17k1WVgV3hPArHNL77Ub8f7NNvTEtdbFkFZAf+T
 5+uxVQ+sc1K
X-Received: by 2002:a05:600c:26cb:b0:48f:e6de:1cc6 with SMTP id
 5b1f17b1804b1-490360e1832mr18320785e9.32.1779356547548; 
 Thu, 21 May 2026 02:42:27 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-175958-cust4.vm3.cable.virginm.net.
 [80.193.46.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035adf173sm17183185e9.0.2026.05.21.02.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:42:26 -0700 (PDT)
Date: Thu, 21 May 2026 10:42:23 +0100
From: Joshua Lant <joshualant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 01/10] docs: Add documentation for cxl-vcs-switch
Message-ID: <ag7Tf+5Fn4460FL0@thinkpc>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-2-joshualant@gmail.com>
 <20260519153308.4626e491@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519153308.4626e491@jic23-huawei>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Wed, 29 Apr 2026 14:48:35 +0100
> Joshua Lant <joshualant@gmail.com> wrote:
> 
> > Signed-off-by: Joshua Lant <joshualant@gmail.com>
> Hi Joshua,
> 
> Sorry it's taken me a while to get to this!  I blame to much activity
> on other open source projects! :)

No problem at all! I appreciate you taking time to review this.

> 
> I've mused in the past on how to do the command lines for these.
> So some thoughts are based on that - feel free to argue why we
> the structure you have here works better.
> 
> When I get through the series I may well change my mind on some
> of what follows ;)
> 
> 
> > ---
> >  docs/system/devices/cxl.rst | 90 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 85 insertions(+), 5 deletions(-)
> > 
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index 32b1b5d773..9e8452e576 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -119,11 +119,11 @@ and associated component register access via PCI bars.
> >  CXL Switch
> >  ~~~~~~~~~~
> >  Here we consider a simple CXL switch with only a single
> > -virtual hierarchy. Whilst more complex devices exist, their
> > -visibility to a particular host is generally the same as for
> > -a simple switch design. Hosts often have no awareness
> > -of complex rerouting and device pooling, they simply see
> > -devices being hot added or hot removed.
> > +virtual hierarchy. Whilst more complex devices exist (see VCS
> > +Switching below), their visibility to a particular host is
> > +generally the same as for a simple switch design. Hosts often
> > +have no awareness of complex rerouting and device pooling,
> > +they simply see devices being hot added or hot removed.
> >  
> >  A CXL switch has a similar architecture to those in PCIe,
> >  with a single upstream port, internal PCI bus and multiple
> > @@ -467,6 +467,86 @@ Example configuration:
> >  Guest OS communication with the MCTP CCI can then be established using standard
> >  MCTP configuration tools.
> >  
> > +CXL Multi-VCS Switching
> > +-----------------------
> > +
> > +The cxl-vcs-switch object allows for a Fabric Manager to dynamically reconfigure
> > +the switching within a multi-upstream port CXL/PCIe topology, This moves beyond
> > +the static switching configuration described above. The use of vcs=X on an
> > +endpoint device indicates that it should be hidden from guests at boot. 
> 
> That bit seems rather unintuitive.  EPs shouldn't really be involved in this
> at all. I guess you are using them as a proxy for a physical downstream port?

correct...

> Interesting idea if a bit non intuitive. I wonder if we can put in an explicit
> physical DSP device in. When linked it just proxies the vPPD.
> 
> Maybe we can get away without that but it leaves us with no physical port hotplug
> as we can't connect an empty physical downstream port to a VCS.
> 

The main reason it has been designed this way is becasue I could not see
a way of replacing one DSP (the vPPB seen by the guest) with another DSP
(the actual physical port to which the device would be attached). Doing this
could be done in 1 of 3 ways. Two of which I dont think will work. The
third I have not figured out how to do it yet.

1. Reconnect USP to PPB and endpoint rather than the vPPB on bind.

The connection(s) to the USP needs to remain static since the USP itself is not
hotpluggable. This is a mandate from the PCIe spec regarding slot/device
characteristics, rather than a QEMU implementation detail AFAICT.

2.
The connection between DSP (PPB) and endpoint is severed on bind, and
then the endpoint is then attached to the vPPB.

This will mean in QEMU that the device has to go through the teardown process
and reenumeration, so will potentially lose device state information. The
alternative being (i'd imagine) a messy piece of code to rewrite the exit
functions depending what is happening (real exit or "rewiring")...

3.
Create some sort of new device which looks like a DSP but actually is
more of a shim of some sort and is able to connect pre-realized devices to
pre-existing DSPs (the vPPBs) but somehow trigger a hotplug event in the guest
as if it was only just being realized.

> > Each
> > +upstream port with vcs=X set will conceptually become an upstream PPB. Any
> > +downstream port that is connected to an upstream port with vcs=X set will
> > +automatically become a vPPB for that VCS. The overall cxl-virtual-switch has a
> Neat not to have to set it for the DSPs, but I think we will need them to
> grow new functionality so maybe a different device type is good.
> 
> > +single CCI mailbox used for config/status of all ports within the switch.
> 
> Need to support both MCTP and switch-cci but that should be fine.
> 
> > +Setting local-fm=true indicates that this QEMU instance has the CCI mailbox
> > +attached. Setting it false will create listeners for commands from a remote
> > +QEMU process (yet to be implemented).
> 
> Nice but make that the default for now (And drop the parameter).
> Absence of a connected CCI might be sufficient though that's a bit ugly
> to check.
> 
> > +
> > +An example of how the topology is described on the CLI is shown below:
> > +
> > +  -object cxl-vcs-switch,id=vcs0,usp-ppbs=2,dsp-ppbs=4,local-fm=true \
> Interesting.  I'd kind of like it to be a device, but it has no presence
> on any bus in of itself (arguably it is on a whole load of them). So maybe not.
> 

I mentioned this briefly in the cover letter (sorry if unclear). I would
have liked it to be a device as well, but I couldn't figure out how
to do this given the way QEMU associates the buses and
devices to one another in the QOM tree. You can't not give it a bus
option, becasue it will then choose a single default bus to associate
with. Im unsure about adding multiple bus association. Doing this will require
deeper changes to the qdev/qbus which might be messy or unpalatable to upstream
folk. I made my changes to qbus as minimal as possible.

> > +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
> 
> Small side note - avoid the passthrough trick. It means a bunch of code
> paths aren't exercised and has hidden various OS bugs.
> 
> > +  -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
> > +  -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> > +  -device cxl-rp,port=0,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
> > +  -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,vcs=vcs0,usppb=0 \
> > +  -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,multifunction=on,vcs=vcs0,usppb=1 \
> 
> How can we have two upstream ports in a single vcs?  To me those are separate VCSs
> where a VCS is normally a tree topology below a given USP.
> 
> I think we have a terminology problem.  If I read this right you are using VCS
> to mean the whole physical switch?  Been a little while but I don't think
> that corresponds at all to it's meaning in the CXL Spec. Your VCS0/1 below
> are right.
> 

Yeah I was struggling with the naming somewhat trying not to conflate a "VCS
capable switch" with the VCS within the switch itself. Seems I didn't do a
great job. Just to be clear 1 VCS = 1 USP. The whole switch is the collection
of all the VCS's. The id's here of the CLI devices is misleading I see
that.

> 
> 
> > +  -device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=vcs0 \
> > +  -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=vcs0 \
> > +  -device cxl-downstream,port=0,bus=us0,id=dsp0,slot=3 \
> > +  -device cxl-downstream,port=1,bus=us0,id=dsp1,slot=4 \
> > +  -device cxl-downstream,port=0,bus=us1,id=dsp2,slot=7 \
> > +  -device cxl-downstream,port=1,bus=us1,id=dsp3,slot=8 \
> Ok. So these only know they are virtual because they are connected to a virtual USP.
> Might be enough - or we might want to make that more explicit via
> a new device type.
> 
> > +  -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,vcs=vcs0,dsppb=0 \
> > +  -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,vcs=vcs0,dsppb=1 \
> > +  -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,vcs=vcs0,dsppb=2 \
> > +  -device cxl-type3,persistent-memdev=cxl-mem4,id=cxl-ep4,lsa=cxl-lsa4,sn=102,vcs=vcs0,dsppb=3 \
> This I mention above. I 'think' you are using the dsppb to instantiate something that is pretending
> to be a the physical DSP.
> I haven't yet read thee series, but gut feeling is that will make the querying of link
> properties etc rather different from the normal case.
> 
> > +  -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G
> > +
> > +Example topology involving VCS switching::
> > +
> > +               +--------------------+  +--------------------+
> > +               |   Host Bridge 0    |  |   Host Bridge 1    |
> > +               +----------+---------+  +----------+---------+
> > +    +-------+             |                       |
> > +    | MCTP  |             |                       |
> > +    | USB/  |  +----------+---------+  +----------+---------+
> > +    | I2C   |  |    Root Port 0     |  |    Root Port 1     |
> > +    +-----+-+  +----------+---------+  +----------+---------+
> > +          |               |                       |
> > +          |               |                       |
> > +   +------|---------------+-----------------------+-----------------------+
> > +   |    +-+--------+      |  cxl-vcs-switch (vcs0)|                       |
> > +   | +--| CCI MBOX |---*  |                       |                       |
> > +   | |  +----------+      |                       |                       |
> > +   | |  +-----------------+--------+      +-------+------------------+    |
> > +   | +--+                 |   VCS0 |  *---+       |             VCS1 |    |
> > +   |    | +---------------+------+ |      | +-----+----------------+ |    |
> > +   |    | |                      | |      | |                      | |    |
> > +   |    | |        USP 0         | |      | |        USP 1         | |    |
> > +   |    | |                      | |      | |                      | |    |
> > +   |    | +----+------------+----+ |      | +----+------------+----+ |    |
> > +   |    |      |            |      |      |      |            |      |    |
> > +   |    | +----+----+  +----+----+ |      | +----+----+  +----+----+ |    |
> > +   |    | |  DSP 0  |  |  DSP 1  | |      | |  DSP 2  |  |  DSP 3  | |    |
> > +   |    | |(vPPB 0) |  |(vPPB 1) | |      | |(vPPB 0) |  |(vPPB 1) | |    |
> > +   |    | |         |  |         | |      | |         |  |         | |    |
> > +   |    | +---------+  +---------+ |      | +---------+  +----+----+ |    |
> > +   |    +--------------------------+      +-------------------+------+    |
> > +   |                                                          |           |
> > +   |           +----------------------------------------------+           |
> > +   |           |                                                          |
> > +   |           |            -                    -            -           |
> > +   +-----------|------------|--------------------|------------|-----------+
> > +               |            |                    |            |
> > +          +---------+  +---------+          +---------+  +---------+
> > +          |CXL/PCIe |  |CXL/PCIe |          |CXL/PCIe |  |CXL/PCIe |
> > +          |  EP 0   |  |  EP 1   |          |  EP 2   |  |  EP 3   |
> > +          | (PPB0)  |  | (PPB1)  |          | (PPB2)  |  | (PPB3)  |
> > +          +---------+  +---------+          +---------+  +---------+
> > +                 PPB0 Bound to VCS1, vPPB1. Others unbound...
> > +
> Good to have the diagram as makes it easier to discuss.  
> 
> What you have here is a bit of a hack because only some entities created
> exist in the command line - the others are spun up implicitly.  I suspect
> we really want to make them explicit.  The one thing I never looked into in
> the following is how hard it would be to poke a vDSP in front of a physical
> DSP and basically proxy stuff through or not.  Some stuff will be programmed
> at boot (windows etc for hotplug later) but other stuff will fire in the hotplug
> flow on an attach of a physical port. Will need some care and stitching up
> memory regions across the boundary.
> 

I think that this is really the crux of the issue with this series, and
all relates to the first question I posed in the cover letter and some of the
other comments you make on other patches, and with my comments below.

The way these patches work currently make the software side of the
hotplug on binding trivial, but they disallow FM comms to the device when it is
not bound. If we solve this and have realized devices dangling off the
DSPs, then it makes the hotplug to the guest more complex.

The issue is that the hotplug events and the realize/exit functions seem so
tied up with one another. I'm unsure at the moment how to decouple them cleanly
in the VCS case.

> The command line I'd be looking at for this as a target (feel free to shoot
> at it) would be something like (I went with one PXB - but need to test both options). 
> Note some of this is probably garbage as I haven't checked parameters are right.
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 \
>  -device cxl-rp,bus,cxl.0,id=root_port1...
>  -device cxl-rp,bus,cxl.0,id=root_port2..
>  -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,virtual=on \
>  -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,virtual=on \
> 
> #note I extended current target to a list
>  -device cxl-virtual-downstream,vport=0,bus=us0,id=vppb0 \
>  -device cxl-virtual-downstream,vport=1,bus=us0,id=vppb0 \
>  -device cxl-virtual-downstream,vport=2,bus=us0,id=vppb0 \
>  -device cxl-virtual-downstream,vport=0,bus=us1,id=vppb0 \
>  -device cxl-virtual-downstream,vport=1,bus=us1,id=vppb0 \
>  -device cxl-virtual-downstream,vport=2,bus=us1,id=vppb0 \
> # Note more virtual ports than physical - likely common situation.
>  -object cxl-switch,usps.0=usp0,usps.1=usp1,id=vsw0 \
> #list of usps so we can navigate downwards from this.
>  -device cxl-switch-mailbox-cci,id=swcci0,bus=root_por1,multifunction=on,target=vsw0\
> # Maybe hang the unconnected physical dsps on a bus created by the cxl-switch?

I had tried writing it like this originally. The issue comes from the
fact that having a "bus" implies something has been added to the QOM Tree, which
forces an association to the guest. When actually we need this whole bus
to be invisible to the guest (but visible to an FM) on boot.

I'm sure this can be solved, but I can't see a way of doing it wihtout
more invasive changes to the qbus/qdev code (patch 2), and conceptually
to how the QOMTree represents the whole machine in general. I'm not sure yet
if this could open up a can of worms with other stuff going on deeper in the
guts of QEMU...

Ultimately this is at the boundary of my knowledge of QEMU internals
currently, but I think something like this might be necessary to
solve the issues regarding FM communication with the
unbound devices etc. I would really appreciate input about this
specific issue.

>  -device cxl-downstream,port=0,bus=vsw0,id=dsp0,slot=3 \
>  -device cxl-downstream,port=1,bus=vsw0,id=dsp1,slot=4 \
>  -device cxl-downstream,port=2,bus=vsw0,id=dsp2,slot=7 \
>  -device cxl-downstream,port=3,bus=vsw0,id=dsp3,slot=8 \
> #ideally a device but need to think where to hang it.
>  -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,bus=dsp0 \
>  -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,bus=dsp1 \
>  -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,bus=dsp2 \
> #note not all DSPs have anything on them.
> 
> Few reasons for this structure.
> 1) The unconnected physical port - we want to make sure physical hotplug works both
>    when not associated with a VCS and when it is.
> 2) We need to be able to talk to EPs via FM interfaces when they aren't connected
>    Given we have to make that look like PCI, let's make it PCI.  I'm not sure how
>    much hackery that will take as we'll need to do some level of enumeration from
>    the the switch controller.  Only need that once we want to do more than check
>    training etc though - so maybe job for another day.  In theory we can do everything
>    with devices in that state (be it slowly) so would need all the addresses programmed
>    etc. Not as general as current discussions on enumerating full PCI bus in QEMU as
>    all direct connect.

What discussions are you refering to?

> 
> Anyhow it's fiddly with this scheme but I think a little more general
> than your current one and closer representation of the hardware which will
> matter as we add all the introspection stuff etc in the FMAPI.
> 

I agree fully. It would be much better if I could get this general
solution. I just need to figure out how to do it...

Cheers,

Josh

