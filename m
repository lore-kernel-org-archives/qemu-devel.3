Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC5C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuIY-0006Lp-RM; Fri, 02 Aug 2024 11:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZuIW-0006Kr-LG
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZuIU-000739-Kx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722612863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZalIaqymM70QEtv4tggc2L+MA+uHrbuEftgWsmKn7i8=;
 b=fh0fW7hANmea3CFxrISSyNJ0eRXpK2yhOL5rqMZ+ZDSNT47w8mzmTdVL0hm3tCxPlWfnn7
 G1ibwwBoqi37UsAnLvdDjzufveHprp7JzAqvK6H3/ctZhe7B8vLxLFSVOHfWFjkyma7gjv
 Nn/icpJ/6o1BnRRbh3QLjJ+pvLNtLGc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-zGieRlUMO_Kz-XsKNMupAg-1; Fri, 02 Aug 2024 11:34:22 -0400
X-MC-Unique: zGieRlUMO_Kz-XsKNMupAg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5d0fecd1981so2091094eaf.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722612861; x=1723217661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZalIaqymM70QEtv4tggc2L+MA+uHrbuEftgWsmKn7i8=;
 b=fZiHu3OYqxkl7Q8DBk/Zr48Wz/DzdGOzJNdI2PY+q0ATcefw2kU81Cwq7R2rt+D8BE
 qDj0IyrYxBX0ZsjqPtF//bJE9PGsRHSk/kA0DX9v7IxZ+m0yHT7buWPiD14zi7zsjAsX
 gr+4uE9EjtzEzLbEIU7NWoVvkGG0+RkUvnXhRUto4+EKPPvR6O1k5ovli1xcs8Zsu+4E
 o+KLRQNxxLFG7HRRk49UqZYZWkYiW0pxmEB07UYUNugWyeL0m9a6dDPn/0VNks/ijCH2
 s93KZFxokRlS3/TWNHwRKJPES5LzHYx9VqoXBzEztxkZ+voFCsh6kw+eiJVGjImsjJ1c
 UhLA==
X-Gm-Message-State: AOJu0YzliPMeAEBtflNzf9ha88vXeXtNsdWV/asa1z2Kqb0Tud2urqtL
 OxsU+hBzcErJKVISQG0Sfw7bXv1sj0y5fhJuUfTTgm3BaCdaHAIjAo3Awl0MJmKu9WwT1yRTprM
 mpZLzUUOfHJpPjkh4sjB4psj4TP70+hIvhLLdLjxUlv+XmB4cVSb4
X-Received: by 2002:a05:6870:8555:b0:254:a7df:721b with SMTP id
 586e51a60fabf-26891e9706amr2476833fac.5.1722612861427; 
 Fri, 02 Aug 2024 08:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFpEsiaeUTITiiyQpX0rrnl8MzQfdszhoJUjeBG6CU/UY1mZEv8pGq8JUbnr2xq9/2T9xRQw==
X-Received: by 2002:a05:6870:8555:b0:254:a7df:721b with SMTP id
 586e51a60fabf-26891e9706amr2476820fac.5.1722612861016; 
 Fri, 02 Aug 2024 08:34:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a34f6f2ce7sm93493385a.52.2024.08.02.08.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 08:34:20 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:34:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-9.2] tests/qtest/migration: Remove
 vmstate-static-checker test
Message-ID: <Zqz8ejp7BLSQx8rQ@x1n>
References: <20240802145301.29629-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802145301.29629-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 02, 2024 at 11:53:01AM -0300, Fabiano Rosas wrote:
> I fumbled one of my last pull requests when fixing in-tree an issue
> with commit 87d67fadb9 ("monitor: Stop removing non-duplicated
> fds"). Basically mixed-up my `git add -p` and `git checkout -p` and
> committed a piece of test infra that has not been reviewed yet.
> 
> This has not caused any bad symptoms because the test is not enabled
> by default anywhere: make check doesn't use two qemu binaries and the
> CI doesn't have PYTHON set for the compat tests. Besides, the test
> works fine anyway, it would not break anything.
> 
> Remove this because it was never intended to be merged.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


