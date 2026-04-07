Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91708FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUJ-0005zy-6I; Tue, 07 Apr 2026 14:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABSY-0002o3-II
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wA8PW-0005Xl-Es
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775575933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7VRl3S2rNTZXwX28LihXaYXdGqCNej5/6BBqjKxC5A=;
 b=Ua25cuvnVv/P+R2pG292ULOz9P/kCLCnn2X6P/J1LINh/xgKbovsjIE7J7Pj3WPz7alJ3J
 HBJciZtJEiqHoX4zvllv5F0K3dx0lcvdl7Hot64PvzL7OyIPi6+p6qGtARh2KvX4FQizqU
 ZEKcwFiYbIlBb03zvRhgAZPDrQ8dzu0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-se-QI7wUNbCGEDwHBZhvuA-1; Tue, 07 Apr 2026 11:32:12 -0400
X-MC-Unique: se-QI7wUNbCGEDwHBZhvuA-1
X-Mimecast-MFC-AGG-ID: se-QI7wUNbCGEDwHBZhvuA_1775575931
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d890580e1so50878141cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775575931; x=1776180731; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t7VRl3S2rNTZXwX28LihXaYXdGqCNej5/6BBqjKxC5A=;
 b=NoOsdfxreUZHzCXNxSJ5j/btNXiaekOY/aCn3dIOp7sUU1PTLrikICnADa4xiKB18x
 mxrajHordCsVLcS1im8mAnl6+Tz9ZsEZnyTg+gCEKcxhm4z57eKbVju0VrLjmm7QNdST
 4VTXqcie4Rq0dwz9LNhyb5GKRRuJ7ml2JCzDe8Jd7iWuqao/VCMFEpLXki++rnPDczLW
 +CWX8lDzMEHUz7yLWua3r+zeQ7yQpdXdaSIjRMYi3Gr5QC+lo/yc+jgpfBDliA0zR+31
 t5XiMNRMHF65WHMOZWUjXqIC0vYaZ+jmR9vSUTgCFjewvWWx6NoX5WaLTZcRfxei66gY
 nnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575931; x=1776180731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7VRl3S2rNTZXwX28LihXaYXdGqCNej5/6BBqjKxC5A=;
 b=YrlYQwU8XYNIfCW2y6GVzcZLXNEvKuIseeaPJYseo2Qrb4j/xfnTP2kaLV1dkbxH0P
 q8DhSciMhZUMSxT0ov1lhNlfVbZ1/xi9zvQWHqEUcwqq/kpoZIyDhnq20GknvkX2zW/X
 ENI42Hx5SyjKjy9lOG6qkiHAyF87IkvmZK0qv8r8db8DbRBdvXmmiY+GNxRNOmjWxe8f
 nZRD53VTWkyUtdBmLBO0QnuMEd7Zp2+zQ1eVYxMPPTYqnUyTboJD05eNPvZ3AFfPuylH
 orbHZA6Jsqo6NCBKcZCCpO69+v7DfpI3HdlZvh9kDysbfKMsA0SCTgZxzQ7k/n9SqvAN
 zdkw==
X-Gm-Message-State: AOJu0YweBgDKDwvxc/bw0bjEv6V5SWhLNUTWoP4vKmbw8pyyYOC/cVBL
 yX55OL+xfQq35pmajjpjPQW6QlWrrlo26/bxZM23EPz3k7a69X2J9z50LF1YbOGpTe3C4lcvcsu
 2AuyoinaXzHIo0pFsRtxJgPZwIe47iCEPUVx0brS2MN9ILCvuchRCFzf6
X-Gm-Gg: AeBDieuEpjdfTge7siGFJ6NMtEyKNHpGx0GjjDZ4dl8tDFuq7o4po0qXw0OE1inAROl
 1DkXRVh5ufA2sR93PWtrHrxaarZlscC21d3pHjH86T3nWi1FIcKjr2WA0FWmCU42vH31sep3k9c
 3cnBOdt6jGFRjuVcZSB5YfWByog2AjnkSFADDQB/UWqNeIVswUp3R1qsHVkiJyq6lOE9oky3igG
 Z2IrRDiy1AKG++IdGpKg3UicuGvZ3dXWQ+Vwt8ZJUtfNxFdR+v1uubn9ja4t8hgAkmJIJQUa2Bg
 JSnhb2xxob+3G3P0C6rJ36w+EkVNHpx0u+hirTStRWCJCR9FkDJ970Dvaltljk8LR47XKas/bHA
 PPL4D+24GIzwuCrqIVYfZ6AEflq6Xz3gc+1+kWrIDt/DLq00=
X-Received: by 2002:a05:622a:2518:b0:50d:7f60:6231 with SMTP id
 d75a77b69052e-50d7f606e8dmr192880211cf.21.1775575931375; 
 Tue, 07 Apr 2026 08:32:11 -0700 (PDT)
X-Received: by 2002:a05:622a:2518:b0:50d:7f60:6231 with SMTP id
 d75a77b69052e-50d7f606e8dmr192879521cf.21.1775575930724; 
 Tue, 07 Apr 2026 08:32:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b73ea66sm168573831cf.14.2026.04.07.08.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:32:10 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:32:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <adUjefnry9gBCfUg@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <acavsDOsAz0hmfvi@fedora> <ac6IRfYH7UCluuIt@x1.local>
 <adUfNiig4RptM2sS@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adUfNiig4RptM2sS@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 07, 2026 at 05:19:01PM +0200, Juraj Marcin wrote:
> I think, moving the fastpath boolean out and passing it as a separate
> parameter would help greatly with the input/output separation. Then, if
> some modules even validate the condition in the comment, there's no
> harm, it'll just get overwritten afterward with the correct value.

Sure, I'll use it.

-- 
Peter Xu


