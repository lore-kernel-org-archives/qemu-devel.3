Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C021EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 23:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Z4P-0006YS-WF; Tue, 21 May 2024 19:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s9Z4N-0006Xv-Ua
 for qemu-devel@nongnu.org; Tue, 21 May 2024 19:38:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s9Z4L-0001ah-OP
 for qemu-devel@nongnu.org; Tue, 21 May 2024 19:38:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso1393095a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716334736; x=1716939536; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfCnJtdyD/uzrKZ8o/xY+WhPnZ4AgcXIZ/ZIkO8OCP0=;
 b=GRl3xXPObxuo76BZsr74iDcmiyi0FbE2W12/ChKeKw+WBPO7i8+zzQJiPFdVhWUa08
 lTRKnlE4fDaMiBxUYv0zJ0FooMk59Psfpua7PHvQmipqgkP+GltIq/jNccC3ZTbCf6fb
 0hyJS64nLRMQ23mcku67J8KB7aGSx9vD+tuyppY5kwX7GrV0PhvxEZqhrCG8q/O93Dpr
 Ekvjusyk8m5z4v5A0mSLfZ+f9GfpgXMI/mGZfT68js0a9T3Ghwb5UI4sb1kC7fNoc7y4
 uCWbLXxhmUJZuwqvedzKFKQxMWQrvI182vDf2g0Z6FzSXNEFpNG3OTE/g0CrPtYMFWZv
 8p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716334736; x=1716939536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfCnJtdyD/uzrKZ8o/xY+WhPnZ4AgcXIZ/ZIkO8OCP0=;
 b=G99QvQ4S3r15lMtk3QH30aiI5701JkPmAPi7dio12HMegtWidtWekUpydpOJ6umcX1
 hFc1e+4C3+oHKE372Ca7dnwa4uyFrBFAVoj9RHDz3z5gti8CMP0BbkcQ8V9vTc9DLWQS
 8XqUAhzLCNr197Aep/0Gp4PINGuHcK+TG11fbEg9uv8apoB5gnrNmXHa9H0WAp47kTXp
 DRyABbb2Jg2gR40gnZx588nirzoJ+FZF16Ody+Z3J56e/i8ErzZVoJHZr+NE37AIfuYS
 vbLcWbSepmzYLthVjotRRPbhK453kUHJEbAjitIt+TJx+ykdzdA9XJMjSp8wECZTe4q8
 Jj4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+gpfk5yndinIa0v1HX1Tocm00GESpMNQ/4EExqVlfMauc1Bi6zVLLiTtnLcyvINGOgLU5/ulV3PT7JF9TpeXanCMpQwU=
X-Gm-Message-State: AOJu0YwyYjPjvXIg3kWOfA6k1Tzy9Codqa1qz4IjixLSkf7R8E7Nkt3j
 jbeTKX0R1jqeAwa5+np7KfJUpA0saPdstiUROdaLUiPNr9cP+mKj
X-Google-Smtp-Source: AGHT+IHI8ENoGEW9i2PKsQzv7nwT9Wh0XjRg/c0q3ldfcn7oTJRiDXl4QIwkMhGdGFu3XXTUcaWZBg==
X-Received: by 2002:a05:6a21:3386:b0:1a9:8b4a:b84 with SMTP id
 adf61e73a8af0-1b1f884508fmr544182637.18.1716334735986; 
 Tue, 21 May 2024 16:38:55 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:3a56:ff85:21cf:d468])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c2563c0sm226881995ad.287.2024.05.21.16.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 16:38:55 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 21 May 2024 16:38:53 -0700
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
Message-ID: <Zk0wjWL2cbwdF69r@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjLCS8yJC-OvPsUS@debian>
 <20240520175012.000045fe@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520175012.000045fe@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x532.google.com
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

Hi Jonathan,
FYI.
I just sent out the updated QAPI patch with selection policy defined as
enum and removal policy split out in this thread,
https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#m9838d6afda49fb26eb90526eae5550256f5d0f56

Planning to send out v8 on Thursday.

Fan

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
> 
> > +#
> > +# @region: The dynamic capacity region where the extents will be
> > +#     released.
> 
> This has a better definition in the add dynamic capacity entry above.
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

