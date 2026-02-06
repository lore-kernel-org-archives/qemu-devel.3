Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F95CEE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPnA-0005PR-Ls; Fri, 06 Feb 2026 12:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voPn8-0005PD-Ja
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:38:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voPn5-000386-T4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770399526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKEcaVCG4FvbMspAZ4rJRk9EPr1f3IFn91TISV0R/eA=;
 b=grhBct5ov5X8xKZzc5SsDERZY3Qrkuc2o2Z2t57SGMD1OilWz3ulZmdbmo4zLvAWuNutMW
 OomYNjKGv6gjuaU6LBHW8pD8oWrlgMjcS31E+A0/kZIHapyj0kaVrreo917yw6SCzPoIOK
 Oe0YsvgK1AqmZO3X0Kk+YR1BN/t03Ik=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-MQdxZvUrNJ-p7djGGYxnVg-1; Fri, 06 Feb 2026 12:38:44 -0500
X-MC-Unique: MQdxZvUrNJ-p7djGGYxnVg-1
X-Mimecast-MFC-AGG-ID: MQdxZvUrNJ-p7djGGYxnVg_1770399524
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6b315185aso421354785a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770399524; x=1771004324; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HKEcaVCG4FvbMspAZ4rJRk9EPr1f3IFn91TISV0R/eA=;
 b=LoV7KBkDas8CLyvkzqutRR7cuEwt329fgD9GBhTKLArp0RK2sA0nxtrmUyNFv4Bn6y
 DiulTxlHBIlMRkYXYtZUOaUNXy68CuOlRhbL01x9CK/z47v+q4Nyv/1SoRtxbea6ZjyD
 c2iFgeunhz3t2stXRX6xXCRJCoPZypuXAs/IHT8VRS1etGN9/RsKhthBe3NieAWRplI6
 mV5xXcBXFDTHbIHMm+BLIwhg7IOqnTwtdimr2/zB+3h+zFfblOsEOP4Lp3yphP948FRF
 M16ZQITgYGtcJOwHhZpL0F57IRR7I+mpp8Ay/HPukgCjImie6m4DN5Z7x+YQ+2/NsWYf
 q0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399524; x=1771004324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKEcaVCG4FvbMspAZ4rJRk9EPr1f3IFn91TISV0R/eA=;
 b=btM+rZGLQ286kyIeiBBSVhNMtMdOFtZ7r/Y7oXjjtqGMX0dbTC4gV26aTHQraOnaTe
 nT46ULapicw8rjPHxYKJAZ1i/v8yeQWGr/wTg3v+p+sVrH1M+b2YkZant3mEVYh8v6M3
 nesHMZIDaaemE1kCjemQlS7rmPiHX5d7D5FxEK4b8UNjKEX3j3QqhKLJW9WV2uXEWB+2
 8H9v90jqoiQ3HHwOmr53BxbJi3bnT0YGSLjAHEfR4sw1DmEA/WRh2cKNFsb+/J/Z+Szy
 TRoyWubhqNvaNEGQPylK2doMKmHoMwWhogYqV33XYOMu/Zkon2BPIlkzanhPDNOm51D5
 0vjQ==
X-Gm-Message-State: AOJu0YzIe56wpoIBdCL6VQheUwUs4CfPkE8eNzoG+SsoGzqcjk+G7anH
 zgStJN2S9FxJMlKN9GS1tkirPmM5hJYLmXVkO8B3xV3TZU2Rfj9WTioQLFUialBn2Kn525RFr3G
 STBU8qbCon6/+4Umy/ZYxdzS6BlA2J2J2inw8FqjlV7lCZafABWuf0UT7
X-Gm-Gg: AZuq6aJ7i69ySeFlCnx8gvs3T7DFoVJFKSSIWp0dkGzxrR/KGOJfRGFIpHWWWNqx/zo
 KyEmcqCa7dTD3tR5opk2VSnaGWqvZerYmJ35g8MtSi43L42+1HMcnKCA3+P7898YS1xJQMegi+u
 OVwB2eVsrSvRMOoC52sX60gHn+yALcQPRCOpzSnBKOkijjaV/0xmfIXqx5oIPbTmwjZyk60U5xn
 oe7EeiMD5fAF8bD3pBBiYL17GnG43Mom6E7J0uBqSdhBzPTJbtHfq87DSF5tfcNxNx3NtNsGM1m
 rS59n9R3+EgYmd0vxq4yfcOZK6c8MROXuk14EZ/ipvqpJDZ0cWMBs0wVmG6Adtb4F2dntR+m7pP
 qPP4=
X-Received: by 2002:a05:620a:1982:b0:8c7:16fb:ed45 with SMTP id
 af79cd13be357-8caef7e16e5mr469457885a.27.1770399524139; 
 Fri, 06 Feb 2026 09:38:44 -0800 (PST)
X-Received: by 2002:a05:620a:1982:b0:8c7:16fb:ed45 with SMTP id
 af79cd13be357-8caef7e16e5mr469454485a.27.1770399523708; 
 Fri, 06 Feb 2026 09:38:43 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cafa4b49casm197168085a.49.2026.02.06.09.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 09:38:43 -0800 (PST)
Date: Fri, 6 Feb 2026 12:38:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 4/9] qapi: Implement qapi_dealloc_present_visitor
Message-ID: <aYYnItBr-FOhgRNq@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-5-farosas@suse.de>
 <aYUPZ6ZnWCgxvLxh@x1.local> <87fr7eqd2u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr7eqd2u.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 06, 2026 at 09:19:21AM -0300, Fabiano Rosas wrote:
> >> +static void qapi_dealloc_push(Visitor *v, QObject *obj, void *qapi)
> >> +{
> >> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> >> +    QStackEntry *se = g_new0(QStackEntry, 1);
> >> +
> >> +    assert(obj);
> >> +    se->obj = obj;
> >> +    se->qapi = qapi;
> >> +
> >> +    if (qobject_type(obj) == QTYPE_QLIST) {
> >> +        se->entry = qlist_first(qobject_to(QList, obj));
> >
> > I still don't yet understand why do we care about lists here.
> >
> > I'm trying to guess, what this code wanted to do: we pushed the 1st entry
> > of the list into the stack, trying to make it as a reference for all the
> > items later within the list.
> >
> > But IIUC we can still define the conditiona-dealloc visitor to be even
> > simpler, right?  Say, if the ref qobject has the qlist object, then free
> > the whole list?
> >
> 
> I need to look at this closely, but I think we need to hold the list ref
> so we can walk each of the objects inside of it and free them, then free
> the empty list. When you "free the whole list" that would mean
> qapi_free_<something>, which we can't do here, being already inside
> visitor code; and free(list) doesn't free it's children, of course.

True.

> 
> > IMHO there're three things we need to manage on conditional deallocations:
> > (1) struct, (2) list, (3) alternatives.  All the rest seem to be scalars.
> >
> > So I wonder if we could define this visitor, so that it treats both (2) and
> > (3) the same way (to always dealloc as long as present).
> >
> > That sounds at least making more sense when I picture that in migration
> > parameters: if we have a list in the parameters (e.g. cpr-exec-command), as
> > long as the list is present in the ref, we should free the whole thing
> > completely on the other one being visited.
> >
> 
> Yes, that makes sense. I'm not expecting individual list items to be
> ever updated separately. However, as I said above, I'm not sure whether
> we can free the whole list without some sort of a walk of its
> members. I'll check and get back to you.

My QAPI kongfu is very limited.. but my current understanding is the
visitor framework will make sure everything will be visited properly within
the list, and after each visit to the list entry, it'll finally free the
list structure (in case of dealloc visitor) via qapi_dealloc_next_list().
I believe that's also what the new dealloc_present visitor should rely on.

So my understanding is maybe we don't need to hold any reference to the
list being walked.  However maybe we want to remember we're walking this
list, then no matter how deep we walk into this list, we should stop
checking / referencing the ref object but just always free everything (aka,
fallback to the basic dealloc operations).

When thinking about that, I found maybe it's not that list is special; it's
when the "top level" is special.

Consider if we have a migration parameter that is a nested struct:

  - struct1
    - struct2
      - int
    - struct3
      - boolean

Then if currently we have this value for this parameter:

  - struct1
    - struct2
      - int=1
    - struct3
      - string="foobar"

When we take an update from the user on this specific parameter, and if the
user's input is:

  - struct1
    - struct2
      - int=2
    (omit struct3)

With your current patch, you'll leave struct3 and the sub-field string
untouched.  However, IIUC the current semantics (of migrate_set_parameters,
at least) should be that we use the new data to fully replace the old
struct1 tree, making sure struct3 alone with the string to be unset?

So I wonder if we should just remember the top of the stack (which must be
a qdict), then free anything below that whenever the top element is present
in the ref.

-- 
Peter Xu


