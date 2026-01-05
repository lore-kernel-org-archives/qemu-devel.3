Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B14CD0405
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrhd-0007R9-O5; Mon, 05 Jan 2026 16:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrhZ-0007Pb-AJ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrhX-00038D-TJ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767646879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvdRB5KNAJbel5/7jkKX7os5uQnAshEnuSoDzHJaFX8=;
 b=SB7G9vGGevI/+kioL4wtp153v5YtiJa/eAFYJjxw1JJ0rVS4cBPeOTnfh6e98F192lmP42
 5E6U1uJdF48f4iDDTbxZXSbF47K5GpUjvojKjy1n1FyqhC7SOKwvT1dFku0RSu5i1Y4HQz
 vljuYuUoe+erfpHJIjYEm8r+gGsChSg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-x7e9puTBMSG1_d188xzGAA-1; Mon, 05 Jan 2026 16:01:16 -0500
X-MC-Unique: x7e9puTBMSG1_d188xzGAA-1
X-Mimecast-MFC-AGG-ID: x7e9puTBMSG1_d188xzGAA_1767646876
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a344b86f7so10410586d6.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767646876; x=1768251676; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wvdRB5KNAJbel5/7jkKX7os5uQnAshEnuSoDzHJaFX8=;
 b=QMOAWZYjG41xUuni6d3xINy/6pb7eatqx3B3/JgR9XsgDIs69qY5ugctQWd4jkTBkS
 W5fiM6CcXxGtCN/uVvoAR7WOWPXamTPru6P96Cu3dyuHo1FJl0mvOpqnbfUInH5qC7i+
 CiCufUiMR3d3KqyJS+vo16qevCj7ZAF6xknmkNlQvF5mMH2vxrT1F+oIRBgQQnQMo6Ch
 KsCYL23XVde0UNiLHnBaOS6JSQ2G/ft8msuy2KHXAwYmWKhpuMX/2/5Z2AOybaCXH+6g
 oe03CcyZn01c0/y+66hTEkvrA9s4hS3cExkaugYAdtYK597yYUNY2As8vGyyPDwQzaZP
 qFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767646876; x=1768251676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvdRB5KNAJbel5/7jkKX7os5uQnAshEnuSoDzHJaFX8=;
 b=WYomPUlHRz44MMOyDtHJ/3tZsQlhVt+nFgo3wrj7/oEISOGIb/Z+v+OLBoDpInqbc/
 lDylpV/2gAgn22fncY0ofxe0nQ066es5RCw1koqNtbGdsWA/snl5g5zkSCCkdBy4I1Uu
 aY1jVWRNHhSlNmxLEqgXByxP/l8lLDa1XN2r8t3tobVfOWgwQ/Md1wPsMvE/8+qlMlud
 9sYn9uGLEp6BovXuLcZlC2dg0I+Lg25KZI+8s8OjiBjL9OREeBSS9NcnF8sZAabwnWpv
 0uEQsVZyBhs3J0BvQGGw29Xo++y0ZVDeUcnVdGajHlfXH70RFxWfZ7nUmIH08QuabXFD
 scgA==
X-Gm-Message-State: AOJu0Yz7zQeUlHFNG5cXgMVJnW/Fh7lD07llA3YzwTF4fEhJs4Ja8cKQ
 fHoW+8au9NWTnnVF819m3sWFIRa3uIUDJgtkylAkUmqGWLPnKqX2GqdVWyDvt1BZDdBi6jqQISL
 ZMkO4r/h9jQJ+3vYMyIaycMcM9QEKNJ+Blsz8FkaooavIUSCAYCMUwAm1IBhX6YI3
X-Gm-Gg: AY/fxX5o8wGrKovsspmKfB3Gmzm7hIhqs6bJOXh9Xmpj4EYN8/SGcsghf1Wz7OAoLeR
 VytfUEUipYdYJKCR2SOksKu0euXL1cevy/62HNZvT5eJviNurZIluyqTKlF4OoMiB6MAOCdEzo1
 +63XoZIR7juRtlxDlfbvPBoZKhUrqpFX939pAdr4AQaFay9LEpaSuapXSyaNvaTuuzSI8G6DGwu
 TPTjacxV6MgbbIMF5KKj96JIAYBMCi9Bptcgl7GGjrHfew/Sb7pOqNStKrzknDca3biFn8FHwkH
 lUGSYlyWJQmtx5LebqtylKvb+qGleEPAdBPVDsa1SRS2fT2axkhvF1L95SPZo01D42kjo/il6EM
 noHk=
X-Received: by 2002:a05:6214:48c:b0:882:4c83:af43 with SMTP id
 6a1803df08f44-89075ee423amr14279446d6.42.1767646875610; 
 Mon, 05 Jan 2026 13:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdSvuxYrTtplITao+e1noyloIjqbwkMitBg+7zbK+hn1rXd7fGT8d8Tpz2tWfkt2QYGqxWEQ==
X-Received: by 2002:a05:6214:48c:b0:882:4c83:af43 with SMTP id
 6a1803df08f44-89075ee423amr14278586d6.42.1767646874949; 
 Mon, 05 Jan 2026 13:01:14 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772340b9sm1178846d6.26.2026.01.05.13.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:01:14 -0800 (PST)
Date: Mon, 5 Jan 2026 16:01:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 21/25] migration: Move URI parsing to channel.c
Message-ID: <aVwmmfbJQuF7jS4u@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-22-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-22-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Jan 05, 2026 at 04:06:38PM -0300, Fabiano Rosas wrote:
> The migrate_uri_parse function is responsible for converting the URI
> string into a MigrationChannel for consumption by the rest of the
> code. Move it to channel.c and add a wrapper that calls both URI and
> channels parsing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


