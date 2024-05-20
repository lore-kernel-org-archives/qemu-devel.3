Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61FC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s97Ew-000838-Te; Mon, 20 May 2024 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s97Eu-00082m-Rt
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:56:00 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s97Es-00056z-W3
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:56:00 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-de604ca3cfcso2494036276.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716227757; x=1716832557; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BtjAIyJLEqd+Ar6/hpaY1HvZ1kKP7FiX4lHjiKrcUkM=;
 b=NcOUjFq90EDqS+TOZ2+b/xBtsDVO1pBfpem/ALy4qYnNwQuxtiDwkuLpy8dYQGSdzn
 Z9xKv2b3IsEM8pJycpoOqKK/PV99UWkneJsxOLYPyPENwqCJmN6E69fzHmrVJwPrFVt/
 pbTGjGbvppxxw0vqakMtpUwWRfaeQ/IOp2Zvvvv7bFnDckyFlLIq4j2dBBvSmbP2xqH4
 K4qjBB2FOSt+yk+gnWUO4g5INByGhwCSkNkOt86g8ws/mqJ+I1z9z7h2BXMfE4le6YXE
 8lmWALgYu4ORdefzsaccCHTFnCLqtCaaJFQua0RtdU0TCXSAUGPS3zA6tUw99Zf+ZDQY
 rsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716227757; x=1716832557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtjAIyJLEqd+Ar6/hpaY1HvZ1kKP7FiX4lHjiKrcUkM=;
 b=PXgbjeRWjkBWKATg8YSwQP5eL9Xnaoo7AxIZjlOdTFOt+LEmhB6E013HQOd4NnWIw6
 Ecwc4hTr2SMbfObCkqhytKbssDs6jFfxlMdTrMfYfcoSUeOBJXNwdYhMCTefuz790djA
 NeU47ntFpIHjUVPybJEEppwHXO/Q/Kkgs7MdOmFsZV7o3J36pvO6wKQ1d7E8j8xOJphr
 nA8ro1/Ah5R2SkK6frnjUqRr03D4XjWrdBTNashntpg+U2AQ4V/8xvnZlO2GSLyV89b5
 wnOo7XMR8QsVeZ2qZUyHwLJdvS/7mzjGa2PV50htF0KlYqVDWM8YFl4ksy3ovzPub5F8
 L4rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU11PQRinIuq05tgQpCTAWMS35Gdpq+m+7tDLKEbickj2K0ZFzPkF5mpKY4HEttiXp8htVecaAXKELlK/NRwsy2EXZnd5o=
X-Gm-Message-State: AOJu0YwBb/BTp3WQ+6sG1IjudlkdRUBLIcHZTfnr4R0/+4TRoX3Sjkoq
 kujZEoa9QK+rE80tE/hThHI8z/rxXazzz1LqVjFFkFT6qS3Imq+q
X-Google-Smtp-Source: AGHT+IEYrKDe5exF08nsZpdAWuKzkvTmM4QcyPcyPsDamE95yqUGPNA5y6MRzoSCzaUkwj/egK3DRw==
X-Received: by 2002:a5b:d4b:0:b0:df4:4345:260b with SMTP id
 3f1490d57ef6-df4434527d3mr14529116276.36.1716227757112; 
 Mon, 20 May 2024 10:55:57 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-dee6073d62esm4377992276.1.2024.05.20.10.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 10:55:56 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 20 May 2024 10:55:41 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZkuOnZCxyo896ocv@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjLCS8yJC-OvPsUS@debian>
 <20240520175012.000045fe@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520175012.000045fe@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb32.google.com
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

On Mon, May 20, 2024 at 05:50:12PM +0100, Jonathan Cameron wrote:
> On Wed, 1 May 2024 15:29:31 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > From 873f59ec06c38645768ada452d9b18920a34723e Mon Sep 17 00:00:00 2001
> > From: Fan Ni <fan.ni@samsung.com>
> > Date: Tue, 20 Feb 2024 09:48:31 -0800
> > Subject: [PATCH] hw/cxl/events: Add qmp interfaces to add/release dynamic
> >  capacity extents
> > Status: RO
> > Content-Length: 25172
> > Lines: 731
> > 
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > add/release dynamic capacity extents requests.
> > 
> > With the change, we allow to release an extent only when its DPA range
> > is contained by a single accepted extent in the device. That is to say,
> > extent superset release is not supported yet.
> > 
> > 1. Add dynamic capacity extents:
> > 
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "selection-policy": 2,
> >       "region": 0,
> >       "tag": "",
> >       "extents": [
> >       {
> >           "offset": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > 2. Release dynamic capacity extents:
> > 
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) looks like below:
> > 
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "flags": 1,
> >       "region": 0,
> >       "tag": "",
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan,
> 
> A few trivial questions inline.  I don't feel particularly strongly
> about breaking up the flags fields, but I'd like to understand your
> reasoning for keeping them as single fields?
> 
> Is it mainly to keep aligned with the specification or something else?
> 
> Thanks,
> 
> Jonathan
> 
> 
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 4281726dec..27cf39f448 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -361,3 +361,93 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDynamicCapacityExtent:
> > +#
> > +# A single dynamic capacity extent
> > +#
> > +# @offset: The offset (in bytes) to the start of the region
> > +#     where the extent belongs to
> > +#
> > +# @len: The length of the extent in bytes
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'CXLDynamicCapacityExtent',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to initiate to add dynamic capacity extents to a host.  It
> > +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-70.
> > +#
> > +# @selection-policy: The "Selection Policy" bits as defined in
> > +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> > +#     selecting which extents comprise the added capacity.
> 
> Hmm. This one is defined as a selection of nameable choices.  Perhaps
> worth an enum?  If we did do that, we'd also need to break the flags
> on in the release flags below.

Initially, I defined a enum for selection policy. But for users who are
not familiar with CXL spec, I think the enum definition is not very clear to
to them without reading the spec, so I removed it. Also, there are some
reserved bits there, let it as uint8 may help keep the interface unchanged
if some of the bits are used in the future?

> 
> 
> > +#
> > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > +#     Table 7-70.  The dynamic capacity region where the capacity
> > +#     is being added.  Valid range is from 0-7.
> > +#
> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
> > +#
> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > +#     Table 7-70.
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'selection-policy': 'uint8',
> > +            'region': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to initiate to release dynamic capacity extents from a
> > +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# @flags: The "Flags" field as defined in cxl spec r3.1 Table 7-71,
> > +#     with bit[3:0] for removal policy, bit[4] for forced removal,
> > +#     bit[5] for sanitize on release, bit[7:6] reserved.
> 
> This can be nicely broken up into removal policy enum plus two flags.
> It might be worth doing so to give a nicer interface?

So if we choose to do it this way, maybe we use enum for the above add
command also?

> 
> > +#
> > +# @region: The dynamic capacity region where the extents will be
> > +#     released.
> 
> This has a better definition in the add dynamic capacity entry above.

Yeah, will fix. 

Fan
> 
> > +#
> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> > +#
> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'flags': 'uint8',
> > +            'region': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> 

