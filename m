Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85ABCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dR1-000454-Li; Tue, 30 Sep 2025 12:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dQv-00041n-Q4
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3dQn-0003bx-JR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759250533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQvvzZcrK7x1/bvzLAfEFoPCxuRxRRB8JKkw1C2f0Mo=;
 b=BoD4ktlq7M2LqxGMpalTE4v7JfV0IsgnXXM2KvkQelfBoz5XkPBNZHSDsDTVoB0yMKE7YG
 RfWj1VkRdoPYHdxY3ZK26kEU9Jj0xaTUfKhAxRYa/UrFlsxapCEShGVdMI059SR9kFfhwM
 YiPunY4YKNylhQFK33mzB/HR7I0OzGo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-8VmOZK2zMWOWAg5Ji412kA-1; Tue, 30 Sep 2025 12:42:11 -0400
X-MC-Unique: 8VmOZK2zMWOWAg5Ji412kA-1
X-Mimecast-MFC-AGG-ID: 8VmOZK2zMWOWAg5Ji412kA_1759250530
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-857003e911fso1382168585a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759250530; x=1759855330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQvvzZcrK7x1/bvzLAfEFoPCxuRxRRB8JKkw1C2f0Mo=;
 b=hd4DxK+rFxlCujiV+0bKT6475bp/2Qfb/MNNBLp/ovarc5qIxl5tCx5VGau/VRts01
 XuTGToOroxB3oKoU4bh9sPFW4TB1Opv/oJ9Flx9zukrKZABQkbsxSXPGa2wDkyrZPC1/
 cFQLK0I6uYeTvSTcBEz8yNuVH0jq3wufqgORvzXyBCk79vm7veL8+pXsSs7B3tZzbw3d
 rD5H/Hp1rsG4P7XsQEDwQ86LYOLyI6bMHFTzBFv7xF2l7yCNEp0SJi7suGmx8vDRic1/
 qY1whm1RzWhEs7SEfXugCmqdkSSIFa90q+siZ/mx9vlLlHPl7qWUr1Ju7TEMLi4OHi7v
 hBCA==
X-Gm-Message-State: AOJu0YzFQQsWlu2TvklGz6TTeRpAYTqXtMYBBXGAlSoskX9Z6PMPuRjW
 gnWaePM81BLEYTaFB8JLTxnh5G+zdJRoh97ldHPomENszt04TMHj/vWnAuaWEDCrg+mHC41ii/Q
 jArjBSY2Kax+GqTwvw5XR4alODYwBTcNvKeUumDivUKUALYb00OWXvBt8
X-Gm-Gg: ASbGncuVICuz93A4l11D4DLHTgz5CDI7lW8Jo7tUQmSlep/pK3qYiWMwdPFqDQdCPpC
 SWHQPdaXi61MBJJMMqSfSVBiW+GwHSme9FZllKWKgcHOT5qSRXnE4xjxiWNkSskxoElC1vXuFVL
 2aq4ggAh5b4t2SBWI+0GhnsxmCuZXnlHMNF2nZgZWkok+5aW8Ya9GH+hITFdE8KMl00kSJ2Ms0l
 QTUH/7313f0CHznkxhb/3MtaiYE7QYSgQqB6SoFaihpkafv2pEeakcJw6ec2MbXHGr2KWSbxmMM
 XvHexxax9Lh30InEyU/HqdFc9ePYk1z74eX1iw==
X-Received: by 2002:a05:620a:28cd:b0:84a:af34:5b7f with SMTP id
 af79cd13be357-87377aeb0e5mr71265685a.75.1759250530289; 
 Tue, 30 Sep 2025 09:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnPr9rg4kNAEsW6cUS8dv1WJngqa0IoyP+M6kRjhubUtMDJr3mZ73yrphHgkyMs+zTl/PZ9A==
X-Received: by 2002:a05:620a:28cd:b0:84a:af34:5b7f with SMTP id
 af79cd13be357-87377aeb0e5mr71260985a.75.1759250529822; 
 Tue, 30 Sep 2025 09:42:09 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c29ae247fsm1053496285a.30.2025.09.30.09.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:42:08 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:42:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 0/8] Live update: cpr-exec
Message-ID: <aNwIXx_gqvvL1Ouj@x1.local>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 11:28:58AM -0400, Steven Sistare wrote:
> Just a reminder, these patches still need review from Peter and/or Fabiano:
> 
>   Patch 5/8: migration: cpr-exec save and load
>   Patch 6/8: migration: cpr-exec mode

I read them and left some comments where I have.  For patch 5 please
remember to include the header that Cedric pointed out, because it does
break the builds.

Other than that the series looks OK.  I suggest when you repost, have the
testcases be together.  I saw Fabiano queued most of the test patches, but
it shouldn't be an issue no matter which lands first.

Thanks,

-- 
Peter Xu


