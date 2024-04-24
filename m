Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31327C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg8t-0004fq-0R; Wed, 24 Apr 2024 13:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzg8r-0004ZL-8Q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:10:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rzg8p-0005lQ-0f
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:10:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so338655ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713978640; x=1714583440; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BgjSmDm9nEqvaBmKU8KVrKDMCb4dJzu5b3vNyI4pLQ8=;
 b=kq/YpFHo+VXfFgwmUqBNR5d5NqO4i/NJb/dLrpXd+0vr9+/xizABs6OEuH70L64La4
 6MncigIJNXzNxF6QL5EafoC5eUdjeVa6pE/a2EiMeS+cQEAFcKxAfACaOZoQWWyicuwS
 6SAch/2/Uvx0r0mcQjwklLeoGLkT6OyJ+E5HtISvMrGShTvxcvABEh2OJhLwdvlXYWx/
 63Pud67Fvy/FkZrReBHEkvVgVrGKLv2WxNQevTkygGUxUBX0kMF2rIsYMh5mns2TstO0
 6Y27TFTumMZhoFXQAziya7ggadEvbSP8K2NelA5MYI67kToKwNVZfjheIhGsTWsxR+HT
 DJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978640; x=1714583440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgjSmDm9nEqvaBmKU8KVrKDMCb4dJzu5b3vNyI4pLQ8=;
 b=C79f/3xq7dE6f6mejgD/W6IPB6Q4kkRd13e8RNhP0AZ564QdnW7FzCLstfNy0zb2Js
 0qDVryOYjfqAWNWsWHUpE8u4jkoMaML1K36QKu2thinFTKNf+H2Oyyp5fCwuMBDewXru
 iZ/Z6ug7rbXjRSKZ68x1ou/OBajQfBU+W4aBepj8ThEaSKUKotMF+lJiiJv9SBBwqT71
 ZDdX2X0wONde66VF++BhM87giLS7KPFjcM3Y1yUDEqvwFVONPn3fcuNEu1VHEYmzQeeG
 iFsRtVwuLTnC1z/RaWkBdO+4S5IBrkwdH091JgWu5cr9/qFIaJZtvmgsvJZ2ZTsYbWVH
 +yVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9deILuRllNRA8pQD/PodBMI8DDJZwxa/IMbXeA8nO0CmD/q1hWkuWTZYuQCn6tyCUsqV4taWCMEQwhwlTl+jBqgMiQdk=
X-Gm-Message-State: AOJu0Yzj3TUQKShOKIhhEOlp7za/7D5eRzg0ojcuwsjQeBiF8SZTCL9X
 28AMPbOPiT35gjW/TrFPj0KQ3Kfg+VdLlW4JKlW/1/mZjyP5HRqE
X-Google-Smtp-Source: AGHT+IFrb1yUe3eATE8i9Ne+A2xiCXoLKalUBVD/ETaTOSSQr0L7gGa/lf2DfSTtL/TjWXr0quHdhg==
X-Received: by 2002:a17:902:e5d2:b0:1e6:40f1:9357 with SMTP id
 u18-20020a170902e5d200b001e640f19357mr3836801plf.8.1713978640164; 
 Wed, 24 Apr 2024 10:10:40 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
 by smtp.gmail.com with ESMTPSA id
 im15-20020a170902bb0f00b001e3e081d07esm12409930plb.179.2024.04.24.10.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:10:39 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:10:08 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zik88BUMsMEFb0Nr@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5livrdr.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x633.google.com
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
> 

Hi Markus,
Thanks for reviewing the patchset. This is v5 and we have sent out v7
recently, there are a lot of changes from v5 to v7.

FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Fan

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
> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> What is a CXL DCD?  Is it a device?
> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> > +# @region-id: id of the region where the extent to add
> 
> What's a region, and how do they get their IDs?
> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.0
> 
> 9.1
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
> 
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> Is "and can be re-added" relevant here?
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 

