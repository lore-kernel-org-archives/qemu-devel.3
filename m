Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19795C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1r7i-0003nO-9E; Tue, 30 Apr 2024 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s1r7W-0003iS-Ff
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:18:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s1r7S-0003pJ-Rs
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:18:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso47983465ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714497497; x=1715102297; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nsNRjkgE5rTSwuDeHh29cZYgJuZ5Zz1LUGVq6rxOApI=;
 b=gvegTJN7u8vs42EScINMTr9auyVIFatTku+hPt7rE/3j7jsArbOP0gFbkNW6N6CQhW
 SQsxv4dV7GMYFNyqxir82F00cFKgNU2XWnUt04gQglcJTSCQk0hfT/3niJzcV3eMwXbU
 RuCm6H6knE0iLJaWwB1B9684fCwKln7QiwPAYw0RPNtdgUldoz3p9+P97sG8fBHzwk1p
 Q5SeYGJF/yRnHbgU1bQ4MmJzM3ZhMGar7+Em2k5n+mk0la/Tj94LFx95sWeuqOZFEt5/
 PNyA4jOK/hEHH9fAlPG5twUFnhm3nMSKP+VzXHSvUBOf0xgNwF+RglQDOJZ+YQBBM9VW
 STww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714497497; x=1715102297;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nsNRjkgE5rTSwuDeHh29cZYgJuZ5Zz1LUGVq6rxOApI=;
 b=hhuARYEhl19844SA6p42lSdVtC74C+uUpo6e7c4Mp3skLwnz2Jx8LmYLxdUUvngSsn
 o2xjdAG/9LZefxOJnajklx5fo+V2+xM/cnhZKUzQyCE+JyiHGZn7/s7RSetK1zrw7MDl
 hyITmJZfvQ0ruPm4Sbx6Krv32vvCnwI/nxtvHj98BZWJO4Dyp5OZ69yE2trPvhIaLBJl
 ItcGYyQ5GVxCrdrftCGqqoJFEqqSWchzjpS9N+6NkwS8Iw1GHeyxiipzYeXshf2cRNE3
 juLn4Ldkj0++ZWOpO2NozWhx6FGDhVJUtJ5Msau23eJM3VN9trZpoGzdUE9Fkohb30e5
 1w/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe8mZkVDnrjb/PYuAv0C/xu23PWx0kdcIGm5rXJiNqcFAmMAmm8H4rNfGguYqkUnNQnKX/zjsDcexMypsYqke1y2aC1eY=
X-Gm-Message-State: AOJu0YzXbFmTu8K7wBNDQbV+2Awu7Ck/PY15VxAFcAeSK/wtIfW9sNYO
 VcOoW6mljosdB1WdWlW78mTjJfKqYg2kOHopxWmF/zxrY9m39Spc
X-Google-Smtp-Source: AGHT+IHcotiS/suo6YXQ3Itp9q4KCo12aaLYOWIEjR4S59qRVCUxWYnvobbnDmqcZ5jw7TGXiIY61A==
X-Received: by 2002:a17:902:7292:b0:1e8:c962:4f6e with SMTP id
 d18-20020a170902729200b001e8c9624f6emr32518pll.20.1714497496693; 
 Tue, 30 Apr 2024 10:18:16 -0700 (PDT)
Received: from debian ([2601:641:300:14de:44d7:a685:6990:1604])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a170902e84a00b001e5a5ea5287sm22617943plg.208.2024.04.30.10.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 10:18:16 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 30 Apr 2024 10:17:52 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZjEnwPeoivsW8y5Z@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6fkob0t.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x629.google.com
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

On Mon, Apr 29, 2024 at 09:58:42AM +0200, Markus Armbruster wrote:
> fan <nifan.cxl@gmail.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:12:50AM +0200, Markus Armbruster wrote:
> >> nifan.cxl@gmail.com writes:
> 
> [...]
> 
> >> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> >> > index 4281726dec..2dcf03d973 100644
> >> > --- a/qapi/cxl.json
> >> > +++ b/qapi/cxl.json
> >> > @@ -361,3 +361,72 @@
> >> >  ##
> >> >  {'command': 'cxl-inject-correctable-error',
> >> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> >> > +
> >> > +##
> >> > +# @CXLDCExtentRecord:
> >> 
> >> Such traffic jams of capital letters are hard to read.  What about
> >> CxlDynamicCapacityExtent?
> >> 
> >> > +#
> >> > +# Record of a single extent to add/release
> >> 
> >> Suggest "A dynamic capacity extent."
> >> 
> >> > +#
> >> > +# @offset: offset to the start of the region where the extent to be operated
> >> 
> >> Blank line here, please.
> >> 
> >> 
> >> 
> >> > +# @len: length of the extent
> >> > +#
> >> > +# Since: 9.1
> >> > +##
> >> > +{ 'struct': 'CXLDCExtentRecord',
> >> > +  'data': {
> >> > +      'offset':'uint64',
> >> > +      'len': 'uint64'
> >> > +  }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-add-dynamic-capacity:
> >> > +#
> >> > +# Command to start add dynamic capacity extents flow. The device will
> >> > +# have to acknowledged the acceptance of the extents before they are usable.
> >> 
> >> This text needs work.  More on that at the end of my review.
> >
> > Yes. I will work on it for the next version once all the feedbacks
> > are collected and comments are resolved.
> >
> > See below.
> >
> >> 
> >> docs/devel/qapi-code-gen.rst:
> >> 
> >>     For legibility, wrap text paragraphs so every line is at most 70
> >>     characters long.
> >> 
> >>     Separate sentences with two spaces.
> >> 
> >> More elsewhere.
> >> 
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path
> >> 
> >> I'd prefer @qom-path, unless you can make a consistency argument for
> >> @path.
> >> 
> >> Sure the QOM path needs to be canonical?
> >> 
> >> If not, what about "path to the CXL dynamic capacity device in the QOM
> >> tree".  Intentionally close to existing descriptions of @qom-path
> >> elsewhere.
> >
> > From the same file, I saw "path" was used for other commands, like
> > "cxl-inject-memory-module-event", so I followed it.
> > DCD is nothing different from "type 3 device" expect it can dynamically
> > change capacity. 
> > Renaming it to "qom-path" is no problem for me, just want to make sure it
> > will not break the naming consistency.
> 
> Both @path and @qom-path are used (sadly).  @path is used for all kinds
> of paths, whereas @qom-path is only used for QOM paths.  That's why I
> prefer it.
> 
> However, you're making a compelling local consistency argument: cxl.json
> uses only @path.  Sticking to that makes sense.
> 
> >> > +# @hid: host id
> >> 
> >> @host-id, unless "HID" is established terminology in CXL DCD land.
> >
> > host-id works.
> >> 
> >> What is a host ID?
> >
> > It is an id identifying the host to which the capacity is being added.
> 
> How are these IDs assigned?

All the arguments passed to the command here are defined in CXL spec. I
will add reference to the spec.

Based on the spec, for LD-FAM (Fabric attached memory represented as
logical device), host id is the LD-ID of the host interface to which
the capacity is being added. LD-ID is a unique number (16-bit) assigned
to a host interface.

> 
> >> > +# @selection-policy: policy to use for selecting extents for adding capacity
> >> 
> >> Where are selection policies defined?
> >
> > It is defined in CXL specification: Specifies the policy to use for selecting
> > which extents comprise the added capacity
> 
> Include a reference to the spec here?
Wil do.
> 
> >> > +# @region-id: id of the region where the extent to add
> >> 
> >> Is "region ID" the established terminology in CXL DCD land?  Or is
> >> "region number" also used?  I'm asking because "ID" in this QEMU device
> >> context suggests a connection to a qdev ID.
> >> 
> >> If region number is fine, I'd rename to just @region, and rephrase the
> >> description to avoid "ID".  Perhaps "number of the region the extent is
> >> to be added to".  Not entirely happy with the phrasing, doesn't exactly
> >> roll off the tongue, but "where the extent to add" sounds worse to my
> >> ears.  Mind, I'm not a native speaker.
> >
> > Yes. region number is fine. Will rename it as "region"
> >
> >> 
> >> > +# @tag: Context field
> >> 
> >> What is this about?
> >
> > Based on the specification, it is "Context field utilized by implementations
> > that make use of the Dynamic Capacity feature.". Basically, it is a
> > string (label) attached to an dynamic capacity extent so we can achieve
> > specific purpose, like identifying or grouping extents.
> 
> Include a reference to the spec here?
Will do.
> 
> >> > +# @extents: Extents to add
> >> 
> >> Blank lines between argument descriptions, please.
> >> 
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-add-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'selection-policy': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-release-dynamic-capacity:
> >> > +#
> >> > +# Command to start release dynamic capacity extents flow. The host will
> >> > +# need to respond to indicate that it has released the capacity before it
> >> > +# is made unavailable for read and write and can be re-added.
> >> 
> >> This text needs work.  More on that at the end of my review.
> >
> > Will do.
> >
> >> 
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path
> >> 
> >> My comment on cxl-add-dynamic-capacity applies.
> >> 
> >> > +# @hid: host id
> >> 
> >> Likewise.
> >> 
> >> > +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, bit[5] for
> >> > +#     sanitize on release, bit[7:6] reserved
> >> 
> >> Where are these flags defined?
> >
> > Defined in the CXL specification, it defines the release behaviour.
> 
> Include a reference to the spec here?
Will do.
> 
> Is the numeric encoding of flags appropriate?
> 
> In general, we prefer symbolic encodings.  Numeric encodings can make
> sense when
> 
> • the encoding is stable, and
> 
> • QEMU doesn't need to decode it, only pass it on to something else, and
> 
> • both the QMP client and the "something else" prefer a numeric
>   encoding.
The encoding is from the specification, and we do not invent anything
here. It is stable and all the updates to the spec need to be backward
compatible.
> 
> >> > +# @region-id: id of the region where the extent to release
> >> 
> >> My comment on cxl-add-dynamic-capacity applies.
> >> 
> >> > +# @tag: Context field
> >> 
> >> Likewise.
> >> 
> >> > +# @extents: Extents to release
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-release-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'flags': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +}
> >> 
> >> During review of v5, you wrote:
> >> 
> >>     For add command, the host will send a mailbox command to response to
> >>     the add request to the device to indicate whether it accepts the add
> >>     capacity offer or not.
> >>     
> >>     For release command, the host send a mailbox command (not always a
> >>     response since the host can proactively release capacity if it does
> >>     not need it any more) to device to ask device release the capacity.
> >> 
> >> Can you briefly sketch the protocol?  Peers and messages involved.
> >> Possibly as a state diagram.
> >
> > Need to think about it. If we can polish the text nicely, maybe the
> > sketch is not needed. My concern is that the sketch may
> > introduce unwanted complexity as we expose too much details. The two
> > commands provide ways to add/release dynamic capacity to/from a host,
> > that is all. All the other information, like what the host will do, or
> > how the device will react, are consequence of the command, not sure
> > whether we want to include here.
> 
> The protocol sketch is for me, not necessarily the doc comment.  I'd
> like to understand at high level how this stuff works, because only then
> can I meaningfully review the docs.

--------------------------------
For add command, saying a user sends a request to FM to ask to add
extent A of the device (managed by FM) to host 0.
The function cxl-add-dynamic-capacity simulates what FM needs to do.
1. Verify extent A is valid (behaviour defined by the spec), return
error if not; otherwise,
2. Add a record to the device's event log (indicating the intent to
add extent A to host 0), update device internal extent tracking status,
signal an interrupt to host 0;
(The above step 1 & 2 are performed in the QMP interface, following
operations are QMP irrelevant, only host and device involved.)
3. Once the interrupt is received, host 0 fetch the event record from
the device's event log through some mailbox command (out of scope
of this patch series).
4. Host 0 decides whether it accepts extent A or not. Whether accept or
reject, host needs to send a response (add-response mailbox command) to
the device so the device can update its internal extent tracking
status accordingly.
The device return a value to the host showing whether the response is
successful or failed.
5. Based on the mailbox command return value, the host process
accordingly.
6. The host sends a mailbox command to the device to clear the event
record in the device's event log. 

---------------------------------
For release command, saying a user sends a request to FM to ask host 0
to release extent A and return it back to the device (managed by FM).

The function cxl-release-dynamic-capacity simulates what FM needs to do.
1. Verify extent A is valid (defined by the spec), return error if not;
otherwise,
2. Add a record to the event log (indicating the intent to
release extent A from host 0), signal an interrupt to host 0;
(The above step 1 & 2 are performed in the QMP interface, following
operations are QMP irrelevant, only host and device involved.
3. Once the interrupt is received, host 0 fetch the event record from
the device's event log through some mailbox command (out of scope
of this patch series).
4. Host 0 decides whether it can release extent A or not. Whether can or
cannot release, host needs to send a release (mailbox command) to the device
so the device can update its internal extent tracking status accordingly.
The device returns a value to host 0 showing whether the release is
successful or failed.
5. Based on the returned value, the host process accordingly.
6. The host sends mailbox command to clear the event record in the
device's event log. 

For release command, it is more complicated. Based on the release flag
passed to FM, FM can behaviour differently. For example, if the
forced-removal flag is set, FM can directly get the extent back from a
host for other uses without waiting for the host to send command to the
device. For the above step 2, their may be not event record to the event
log (no supported in this patch series yet).

Also, for the release interface here, it simulates FM initializes the
release request.
There is another case where the host can proactively release extents it
do not need any more back to device. However, this case is out of the
scope of this release interface.

Hope the above text helps a little for the context here.
Let me know if further clarification is needed.

Thanks,
Fan



> 
> > @Jonathan, Any thoughts on this?
> 
> Thanks!
> 

