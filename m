Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EAEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgb1-0001Tw-FO; Wed, 24 Apr 2024 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzgap-0001QD-Go
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:39:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzgal-0003xI-J2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:39:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so159012b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713980373; x=1714585173; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cR2up4bi4Kb1J42a3eTuZ1XQ06fTcq0vPdkBZmwmbEI=;
 b=OC58RwS44Wm+4Wj09YSgtQ+byGStNZZg4KyvddShBLtKGWPpuF+HJYlmc7V96ghYF+
 ErbGBpaGCBSYhUbEifWFsqPzNBMIEXIZhQ4Bq59HNaw02bKNAXcih1+EBjTfL9+H1Atu
 WRuEZhWlEeyLZheYz4Ws1Ab34+ZVUhrPa0unMOGqnDW0KhXW8/qP1HYuuXPtuwcYxZg7
 vjE3sD7u7MwFQNAN7nXinAowBGnT7HLHjx95Dvu3iO/0qWLKKfMto0ELJTAjFa6uwzkz
 GvwwbnjQy9hVqYnV62ER9YRi0YveVbFvxvN8K9nF9jAsDoBDdX8YNGYHCiruRwvhDQDA
 MZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980373; x=1714585173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR2up4bi4Kb1J42a3eTuZ1XQ06fTcq0vPdkBZmwmbEI=;
 b=KC7OUrdIweV8T4O8U67mDe6Q8G8hEPvKg//NOq/9GV6QqW0LlcU2S+EfudzH8vI/ym
 37comP+UlGYVAoMNwofKGzRI+2gxPKFEgqD6JuIQU4AfQBNyVBw8tCyf9AV8Y+a/jGtH
 j7npQca9eJPpYXXgwsqEaObabDF+c8gBKHOLo5urSJM353XnP8tD/4MGsML+BrlyOAkh
 6EnUeUCD0gEQnFlBKvYYAzSv1oSo7Orf1ZK/JAW7eauThi2TwXqmQ+vKbVx1IwW3VbwL
 Qm08/Pec/9QhLeeZttfL8x94lo22/fOhltxaZOEL8tNZk1j9BYtc2eUczA26VFUqQ7YF
 VN+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuhCa9ZSQyhprXVivFgSeIfpWo3xzqyGa8QsLITZaJv/+BkZtg3z3oUhplcMEH+uZNQCufbP//bJHqTKbftfIRK0KG7xg=
X-Gm-Message-State: AOJu0YyVPBrZLVySgI5PZ9fTQ2cA7Rhqaka9JFV5t2WGjw3OVzQ/39hr
 VKimhzLAcReqGUbraEqAbDR44Yy/4BGzdLfQ0iukpRShC+z4OOgb
X-Google-Smtp-Source: AGHT+IHVNqcDsAXO2OPNUFuHejmO1SIZtipjUnEFl/Wm+N4DVytplmJd1ZsDajfzBYu+2RjMDAXnDQ==
X-Received: by 2002:a05:6a00:893:b0:6ed:caf6:6e54 with SMTP id
 q19-20020a056a00089300b006edcaf66e54mr3820780pfj.28.1713980373348; 
 Wed, 24 Apr 2024 10:39:33 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa78516000000b006f03a06314esm11721432pfn.195.2024.04.24.10.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:39:33 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:39:27 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZilDz3X5hmda5oNr@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5livrdr.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
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

On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
> nifan.cxl@gmail.com writes:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Since fabric manager emulation is not supported yet, the change implements
> > the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Will fabric manager emulation obsolete these commands?

If in the future, fabric manager emulation supports commands for dynamic capacity
extent add/release, it is possible we do not need the commands.
But it seems not to happen soon, we need the qmp commands for the
end-to-end test with kernel DCD support.

> 
> > Note: we skips any FM issued extent release request if the exact extent
> > does not exist in the extent list of the device. We will loose the
> > restriction later once we have partial release support in the kernel.
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
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > 2. Release dynamic capacity extents:
> >
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) look like below:
> >
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..2645004666 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -19,13 +19,16 @@
> >  #
> >  # @fatal: Fatal Event Log
> >  #
> > +# @dyncap: Dynamic Capacity Event Log
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'enum': 'CxlEventLog',
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> 
> We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.

FYI. This has been removed to avoid the potential side effect in the
latest post.
v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

> 
> >   }
> >  
> >  ##
> > @@ -361,3 +364,59 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDCExtentRecord:
> 
> Such traffic jams of capital letters are hard to read.
> 
> What does DC mean?
Dynamic capacity
> 
> > +#
> > +# Record of a single extent to add/release
> > +#
> > +# @offset: offset to the start of the region where the extent to be operated
> 
> Blank line here, please
> 
> > +# @len: length of the extent
> > +#
> > +# Since: 9.0
> > +##
> > +{ 'struct': 'CXLDCExtentRecord',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to start add dynamic capacity extents flow. The device will
> 
> I think we're missing an article here.  Is it "a flow" or "the flow"?
> 
> > +# have to acknowledged the acceptance of the extents before they are usable.
> 
> to acknowledge

It should be "to be acknowledged". 

> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.

Thanks. Will fix.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> What is a CXL DCD?  Is it a device?
Dynamic capacity device.
Yes. It is cxl memory device that can change capacity dynamically.

> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> > +# @region-id: id of the region where the extent to add
> 
> What's a region, and how do they get their IDs?

Each DCD device can support up to 8 regions (0-7).  

> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.0
> 
> 9.1

Already fixed in the latest post.

> 
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to start release dynamic capacity extents flow. The host will
> 
> Article again.
> 
> The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.

For add command, the host will send a mailbox command to response to the add
request to the device to indicate whether it accepts the add capacity offer
or not.

For release command, the host send a mailbox command (not always a response
since the host can proactively release capacity if it does not need it
any more) to device to ask device release the capacity.

But yes, the text needs to be polished.

> 
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> Is "and can be re-added" relevant here?

Not really. Will fix.

> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1

Already fixed in the latest post.

Thanks again for the review. Will take care of the comments in the next
version.

Fan
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 

