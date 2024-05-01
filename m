Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BBEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 22:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2IZL-00065t-BM; Wed, 01 May 2024 18:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s2IZJ-00065L-IG
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:36:53 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s2IZH-0002ek-GH
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:36:53 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-61e01d5ea74so9474787b3.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714603010; x=1715207810; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nBvaKgJBJ+oK+nIKOiEo7E3/IY84/nH8+IpysiosK4I=;
 b=I3O9fIalGelhwXzYB9bSw/8i9wMtbBEAurpcp4mFK5UDqBczWnO/xfl9g2qMDoPmD1
 BJLi6K63ajDKYOuTUxf81DIBGJxRJFPmMkN05MA5xBaH+8Q2oKP/pOUFYdG6SCVCUsIV
 kWKvsmGfgp6d2Gz/zbDl2xBSKJWPqkbXzEYhYMb+kDO7UMeiNA8DRyQylAxd3Z8W4c/Q
 fPRNMLd5o1/KLO9t6Wi5CC7nMnAYNCXDLPqY0jdMuqyGb/S1wYjWQqOIqeEcp1+s+mso
 SKxB//KlZxtTnQMoXcSwQhnbYwSiwdt/M1LOWZtbmFZkLZxZ6NQ0qbnsjIGCQ7269lfx
 Ed2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714603010; x=1715207810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBvaKgJBJ+oK+nIKOiEo7E3/IY84/nH8+IpysiosK4I=;
 b=TX+aewQS7qIU27Gs9l67NZ/jyTXRJHti2kwvp2tHnzaDcBOpL+2NatRgQVG+CndwXj
 9jnv6BuCp/DpcNezT84S9ZmfK/Qs/EzDEfAkKV2hhEOBGGahj0fHtlygSNhewTCF/lM8
 g3NJ0ynMyZuRXA6jy6ZSns0U3egDbgavNpCqv+dmsp4a7mLKI7fB8ZejRp1euSqlDeTk
 vJFU36eju+zOL8P2+btsD/x8yJTISd27M2OdnBOb7YQLH2bzQfJGFKzjCtAMXQHc4JVI
 iR+pFR9chz6WZXX+6tnGvC5cCn7VlunXw81eJAPwUN1kX29JtKcfN97DfI4AUYClXWpG
 YR+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQRNoEvQklZDFiPQ8HZzqISyfTyJcp4zpZt1FDtjoPctWKSKsUHV1wu+9yOIDr6L01QBX+/3dYMnWnn40ZSb6+SzgSp6w=
X-Gm-Message-State: AOJu0YxhnbXI/rYiC0onUHfR3TcCKASE9yaCqTgVy6zyHoyITnO9/ufY
 kTx+rfzyPIHx2Ck2Vb2c4j7YTXdXpK/unbBBNCnWGPutLvsMiUIQ
X-Google-Smtp-Source: AGHT+IHBUM5spfwVDo/cU7Zy2S0wkyo1Id8JIRs2xQX//Hy3JhSVOYTnZDkoDeqM7FVMTHG1B7Dkpw==
X-Received: by 2002:a05:690c:4b90:b0:617:fbaa:1d91 with SMTP id
 iq16-20020a05690c4b9000b00617fbaa1d91mr4347127ywb.11.1714603010166; 
 Wed, 01 May 2024 15:36:50 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 z30-20020a81ac5e000000b0061df7da7c00sm715943ywj.65.2024.05.01.15.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 15:36:49 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 1 May 2024 15:36:47 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>, mst@redhat.com
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZjLD_wSqrj_z6mM7@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjEnwPeoivsW8y5Z@debian>
 <20240501155812.00002ec3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501155812.00002ec3@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1130.google.com
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

Hi Markus, Michael and Jonathan,

FYI. I have updated this patch based on the feedbacks so far, and posted here:
https://lore.kernel.org/linux-cxl/20240418232902.583744-1-fan.ni@samsung.com/T/#ma25b6657597d39df23341dc43c22a8c49818e5f9

Comments are welcomed and appreciated.

Fan


On Wed, May 01, 2024 at 03:58:12PM +0100, Jonathan Cameron wrote:
> 
> 
> 
> > > >> > +# @hid: host id  
> > > >> 
> > > >> @host-id, unless "HID" is established terminology in CXL DCD land.  
> > > >
> > > > host-id works.  
> > > >> 
> > > >> What is a host ID?  
> > > >
> > > > It is an id identifying the host to which the capacity is being added.  
> > > 
> > > How are these IDs assigned?  
> > 
> > All the arguments passed to the command here are defined in CXL spec. I
> > will add reference to the spec.
> > 
> > Based on the spec, for LD-FAM (Fabric attached memory represented as
> > logical device), host id is the LD-ID of the host interface to which
> > the capacity is being added. LD-ID is a unique number (16-bit) assigned
> > to a host interface.
> 
> Key here is the host doesn't know it.  This ID exists purely for rooting
> to the appropriate host interface either via choosing a port on a
> multihead Single Logical Device (SLD) (so today it's always 0 as we only
> have one head) or if we ever implement a switch capable of handling MLDs
> then the switch will handle routing of host PCIe accesses so it lands
> on the interface defined by this ID (and the event turns up in that event log.
> 
>             Host A         Host B - could in theory be a RP on host A ;)
>               |              |  Doesn't exist (yet, but there are partial.
>              _|______________|_ patches for this on list.
>             | LD 0         LD 1|
>             |                  |
>             |   Multi Head     |
>             |   Single Logical |
>             |  Device (MH-SLD) |
>             |__________________|
> Host view similar to the switch case, but just two direct
> connected devices.
> 
> Or Switch and MLD case - we aren't emulating this yet at all
> 
>      Wiring / real topology                 Host View 
>          
>       Host A     Host B              Host A       Host B
>         |          |                   |            |
>      ___|__________|___               _|_          _|_
>     |   \  SWITCH /    |             |SW0|        | | |
>     |    \       /     |             | | |        | | |
>     |    LD0   LD1     |             | | |        | | |
>     |      \   /       |             | | |        | | |
>     |        |         |             | | |        | | |
>     |________|_________|             |_|_|        |_|_|
>              |                         |            |
>       Traffic tagged with LD           |            |
>              |                         |            |
>      ________|________________     ____|___     ____|___
>     | Multilogical Device MLD |   |        |   |        |
>     |        |                |   | Simple |   | Another|
>     |       / \               |   | CXL    |   | CXL    |
>     |      /   \              |   | Memory |   | Memory |
>     |    Interfaces           |   | Device |   | Device |
>     |   LD0     LD1           |   |        |   |        |
>     |_________________________|   |________|   |________|
> 
> Note the hosts just see separate devices and switches with the fun exception that the
> memory may actually be available to both at the same time.
> 
> Control plane for the switches and MLD see what is actually going on.
> 
> At this stage upshot is we could just default this to zero and add an optional
> parameter to set it later.
> 
> 
> 
> ...
> 
> > > >> > +# @extents: Extents to release
> > > >> > +#
> > > >> > +# Since : 9.1
> > > >> > +##
> > > >> > +{ 'command': 'cxl-release-dynamic-capacity',
> > > >> > +  'data': { 'path': 'str',
> > > >> > +            'hid': 'uint16',
> > > >> > +            'flags': 'uint8',
> > > >> > +            'region-id': 'uint8',
> > > >> > +            'tag': 'str',
> > > >> > +            'extents': [ 'CXLDCExtentRecord' ]
> > > >> > +           }
> > > >> > +}  
> > > >> 
> > > >> During review of v5, you wrote:
> > > >> 
> > > >>     For add command, the host will send a mailbox command to response to
> > > >>     the add request to the device to indicate whether it accepts the add
> > > >>     capacity offer or not.
> > > >>     
> > > >>     For release command, the host send a mailbox command (not always a
> > > >>     response since the host can proactively release capacity if it does
> > > >>     not need it any more) to device to ask device release the capacity.
> > > >> 
> > > >> Can you briefly sketch the protocol?  Peers and messages involved.
> > > >> Possibly as a state diagram.  
> > > >
> > > > Need to think about it. If we can polish the text nicely, maybe the
> > > > sketch is not needed. My concern is that the sketch may
> > > > introduce unwanted complexity as we expose too much details. The two
> > > > commands provide ways to add/release dynamic capacity to/from a host,
> > > > that is all. All the other information, like what the host will do, or
> > > > how the device will react, are consequence of the command, not sure
> > > > whether we want to include here.  
> > > 
> > > The protocol sketch is for me, not necessarily the doc comment.  I'd
> > > like to understand at high level how this stuff works, because only then
> > > can I meaningfully review the docs.  
> > 
> > --------------------------------
> > For add command, saying a user sends a request to FM to ask to add
> > extent A of the device (managed by FM) to host 0.
> > The function cxl-add-dynamic-capacity simulates what FM needs to do.
> 
> This gets a little fiddly as an explanation.  I'd argue this is more or
> less at the level of the FM to device command flow so it's the device
> verifying etc. (you could explain this interface as talking to an FM
> that is talking to the device, but that just feels complicated to me).
> 
> > 1. Verify extent A is valid (behaviour defined by the spec), return
> > error if not; otherwise,
> > 2. Add a record to the device's event log (indicating the intent to
> > add extent A to host 0), update device internal extent tracking status,
> > signal an interrupt to host 0;
> > (The above step 1 & 2 are performed in the QMP interface, following
> > operations are QMP irrelevant, only host and device involved.)
> 
> In this patch.
> 
> > 3. Once the interrupt is received, host 0 fetch the event record from
> > the device's event log through some mailbox command (out of scope
> > of this patch series).
> 
> It's in patch 8.
> 
> > 4. Host 0 decides whether it accepts extent A or not. Whether accept or
> > reject, host needs to send a response (add-response mailbox command) to
> > the device so the device can update its internal extent tracking
> > status accordingly.
> > The device return a value to the host showing whether the response is
> > successful or failed.
> 
> (assuming the host isn't buggy this always succeeds)
> 
> > 5. Based on the mailbox command return value, the host process
> > accordingly.
> 
> Memory now useable by host if it accepted it successfully.
> 
> > 6. The host sends a mailbox command to the device to clear the event
> > record in the device's event log. 
> > 
> > ---------------------------------
> > For release command, saying a user sends a request to FM to ask host 0
> > to release extent A and return it back to the device (managed by FM).
> > 
> > The function cxl-release-dynamic-capacity simulates what FM needs to do.
> > 1. Verify extent A is valid (defined by the spec), return error if not;
> > otherwise,
> > 2. Add a record to the event log (indicating the intent to
> > release extent A from host 0), signal an interrupt to host 0;
> > (The above step 1 & 2 are performed in the QMP interface, following
> > operations are QMP irrelevant, only host and device involved.
> > 3. Once the interrupt is received, host 0 fetch the event record from
> > the device's event log through some mailbox command (out of scope
> > of this patch series).
> > 4. Host 0 decides whether it can release extent A or not. Whether can or
> > cannot release, host needs to send a release (mailbox command) to the device
> > so the device can update its internal extent tracking status accordingly.
> > The device returns a value to host 0 showing whether the release is
> > successful or failed.
> > 5. Based on the returned value, the host process accordingly.
> > 6. The host sends mailbox command to clear the event record in the
> > device's event log. 
> > 
> > For release command, it is more complicated. Based on the release flag
> > passed to FM, FM can behaviour differently. For example, if the
> > forced-removal flag is set, FM can directly get the extent back from a
> > host for other uses without waiting for the host to send command to the
> > device. For the above step 2, their may be not event record to the event
> > log (no supported in this patch series yet).
> I thought we weren't doing force remove yet?  So for that we could
> set default value as normal release until we add that support perhaps.
> 
> > 
> > Also, for the release interface here, it simulates FM initializes the
> > release request.
> > There is another case where the host can proactively release extents it
> > do not need any more back to device. However, this case is out of the
> > scope of this release interface.
> > 
> > Hope the above text helps a little for the context here.
> > Let me know if further clarification is needed.
> 
> Only thing I'd add is that for now (because we don't need it for testing
> the kernel flows) is that this does not provide any way for external
> agents (e.g. our 'fabric manager' to find out what the state is - i.e.
> if the extents have been accepted by the host etc). That stuff is all
> defined by the spec, but not yet in the QMP interface.  At somepoint
> we may want to add that as a state query type interface.
> 
> Jonathan
> 
> p.s. Our emails raced yesterday, so great you put together this explanation
> of the flows before I got to it :)
> 
> > 
> > Thanks,
> > Fan
> > 
> > 
> > 
> > >   
> > > > @Jonathan, Any thoughts on this?  
> > > 
> > > Thanks!
> > >   
> 

